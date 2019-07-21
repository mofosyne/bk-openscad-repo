$fn=40;

// This is for https://www.thingiverse.com/thing:2591811


// length of mounting strip base
sx = 50 ; 

// widith of mounting strip base
sy = 15 ;

module hook(base_length)
{
    tol=0.5;
    screw_dia=2;
    slit_depth=2-tol;
    slit_width=16;
    slight_height=7;
    translate([0,0,slight_height])
    difference()
    {
        union()
        {
            // Base
            translate([0,base_length/2-screw_dia*2,0])
            hull()
            {
                translate([-slit_width/2,0,-slight_height])
                    cube([slit_depth,base_length,1],center=true);
                translate([slit_width/2,0,-slight_height])
                    cube([slit_depth,base_length,1],center=true);
            }
            hull()
            {
                translate([slit_width/2,0,0])
                    rotate([0,90,0])
                        cylinder(r=screw_dia*2,h=slit_depth,center=true);
                translate([slit_width/2,0,-slight_height])
                    cube([slit_depth,screw_dia*4,0.001],center=true);
            }
            hull()
            {
                translate([-slit_width/2,0,0])
                    rotate([0,90,0])
                        cylinder(r=screw_dia*2,h=slit_depth,center=true);
                translate([-slit_width/2,0,-slight_height])
                    cube([slit_depth,screw_dia*4,0.001],center=true);
            }
        }
        // Screw
        #rotate([0,90,0])
            cylinder(r=(screw_dia+tol)/2,h=100,center=true);
    }
}

hook(15);