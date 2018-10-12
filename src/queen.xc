/*
 * queen.xc
 *
 *  Created on: 9 Oct 2018
 *      Author: zack
 */

#include <stdio.h>

void ant (const unsigned char world[3][4], int antId, int startX, int startY, chanend c) {
    int posX = startX;
    int posY = startY;
    int food = 0;
    int allowedToHarvest = 0;
    while(1){
        int fertility = world[posY][posX];
        c <: fertility;
        c :> allowedToHarvest;
        if (allowedToHarvest){
            food += fertility;
        } else {
            for(int i=0; i<2; i++){
                if (world[(posY+1)%3][posX] > world[posY][(posX+1)%4]) {
                    posY = (posY+1)%3;

                } else {
                    posX = (posX+1)%4;
                }
            };
        }
        printf("Ant # = %i, Current food = %i\n", antId, food);
    }
}

int queen (const unsigned char world[3][4], chanend c1, chanend c2){
    int harvest = 0;
    int fertility1 = 0;
    int fertility2 = 0;
    while(1){
        printf("Total harvest = %i\n", harvest);
        c1 :> fertility1;
        c2 :> fertility2;
        if (fertility1 >= fertility2) {
            printf("1 > 2\n");
            c1 <: 1;
            c2 <: 0;
            harvest += fertility1;
        } else {
            printf("1 < 2\n");
            c2 <: 1;
            c1 <: 0;
            harvest += fertility2;
        }
    }

    return harvest;
}

int main(void){
    const unsigned char world[3][4] = {
            {10, 0 , 1, 7},
            {2, 10, 0, 3},
            {6, 8, 7, 6},
    };
    chan c1, c2;
    par {
        ant(world, 0, 0, 1, c1);
        ant(world, 1, 1, 0, c2);
        queen(world, c1, c2);

    };
    return 0;
}
