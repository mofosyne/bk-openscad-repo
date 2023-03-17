$fn = 50;

/* Computer Mirror Mount */

/* [Mounting Strip Base]  */
/* Command Strip dimentions is typically 50mmx15mm */
sx = 50 ; // length of mounting strip base
sy = 15 ; // widith of mounting strip base
sh = 2  ; // height of mounting strip base

/* [Car Blindspot Mirror]  */
mirrorWidth = 65;
mirrorHeight = 45;
mirrorMountWidth = 30 ;

difference()
{
    hull() 
    {
        translate([-sx/2  , 0  , 0])
            cube([sx,sy,sh]);

        translate([0, 0, mirrorHeight/2])
            rotate([-90,0,0])
            cylinder(r=mirrorMountWidth/2, h=3);
    }

    translate([0, -0.5, mirrorHeight/2])
        rotate([-90,0,0])
        cylinder(d1=mirrorMountWidth+4,d2=mirrorMountWidth, h=2);
}

translate([-mirrorWidth/2  , -5  , 0])
    %cube([mirrorWidth,1,mirrorHeight]);


