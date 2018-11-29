$fn = 50;

/* Ceiling Loop Mount */

/* [Enable/Disable Loops] */
loop_pos = "c"; // [c:center,l:left,r:right, a:all, s:side only]

/* [Mounting Strip Base]  */
/* Command Strip dimentions is typically 50mmx15mm */
sx = 50 ; // length of mounting strip base
sy = 15 ; // widith of mounting strip base
sh = 2  ; // height of mounting strip base

/* [Loop Sizing] */
lt = 2; // loop thickness
lh = 5; // loop holesize

/* Hook function and module */
function loop_width(thickness, holesize) = holesize+thickness*2;
module hook(x, z, thickness, holesize)
{
    /* Hook centre */
    translate([x, 0  , z])
    difference()
    {
        outerdia = (holesize+thickness*2);
        rotate([-90,0,0])
            cylinder(r=outerdia/2, h=sy);
        #translate([0, -1  , 0])
            rotate([-90,,0])
            cylinder(r=holesize/2, h=sy+1);
        #translate([-outerdia/2  , -1/2  , -outerdia/2])
            cube([outerdia,sy+1,outerdia/2]);
    }
}

union() {
    translate([0  , 0  , 0])
        cube([sx,sy,sh]);
    
    if ((loop_pos == "a")||(loop_pos == "c"))
        hook(sx/2, sh, lt, lh);
    if ((loop_pos == "a")||(loop_pos == "s")||(loop_pos == "l"))
        hook(loop_width(lt, lh)/2, sh, lt, lh);
    if ((loop_pos == "a")||(loop_pos == "s")||(loop_pos == "r") )
        hook(sx-loop_width(lt, lh)/2, sh, lt, lh);
} 