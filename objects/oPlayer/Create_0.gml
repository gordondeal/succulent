hsp = 0;
vsp = 0;
grv = 0.35;
walksp = 4;
jumpsp = 9;

inTheAir = false;
instance_create_depth(x,y, -1, oLevelManager);

global.hp = 2;
global.lastRoom = noone;

hpPrev = global.hp;
