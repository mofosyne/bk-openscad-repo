/* Computer Mirror Mount */
// Brian Khuu 2023

/* [Mounting Strip Base] Command Strip dimentions is typically 50mmx15mm */
// length of mounting strip base
sx = 50 ;
// widith of mounting strip base
sy = 15 ;
// height of mounting strip base
sh = 2  ;

/* [Car Blindspot Mirror]  */
// Width of mirror
mirrorWidth = 65;
// Height of mirror
mirrorHeight = 45;
// Mount Width
mirrorMountWidth = 30 ;

/* [Quality]  */
$fn = 50;

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