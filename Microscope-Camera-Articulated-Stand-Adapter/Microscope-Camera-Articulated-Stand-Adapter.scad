//    Brian Khuu (March 2020)
//    Microscope Camera articulation clamp adaptor


$fn=100;

//printer_err = 2 + 0.5; //// My printer currently has xy error of 2mm for "holedia=35" (height is ok) on 2020 March 18th 

printer_err = 0.5; // But your's might have better tolerance? Try playing around.

outerdia = 50 + printer_err;

lipdia = 38   + printer_err;
lipheight = 2;

holedia = 35  + printer_err;
height = 10;

screwdia = 2.1; //1.9mm + tol // This printed alright so far for my printer

// bolt spec
arm_dia=5+0.6;
arm_offset=4;

translate([0,0,height/2])
difference()
{
    union()
    {
        // Mount Point
        hull()
        {
            #translate([outerdia/2+20+(height/2+arm_offset),0,-height/2]) rotate([90,0,0]) 
                cylinder(r=0.01, h=8, center=true);
            translate([outerdia/2+20,0,arm_offset]) rotate([90,0,0]) 
                cylinder(r=height/2+arm_offset, h=8, center=true);
            translate([outerdia/2+5,0,0]) rotate([90,0,0]) 
                cylinder(r=height/2, h=8, center=true);
        }
        // Bulk
        hull()
        {
            translate([outerdia/2+5,0,0]) rotate([90,0,0]) 
                cylinder(r=height/2, h=7, center=true);
            cylinder(r=outerdia/2,    h=height, center=true);
        }
        // Lip
        hull()
        {
            cylinder(r=lipdia/2,    h=height/2+lipheight);
            cylinder(r=outerdia/2,    h=height/2);
        }
    }

    // screws
    translate([0,0, 0])
        union()
        {
            #rotate([0, -90, 0]) translate([0, 0, (holedia)/2])
                cylinder(r=screwdia/2, h=holedia, center=true);
            #rotate([0, -90, 120]) translate([0, 0, (holedia)/2])
                cylinder(r=screwdia/2, h=holedia, center=true);
            #rotate([0, -90, -120]) translate([0, 0, (holedia)/2])
                cylinder(r=screwdia/2, h=holedia, center=true);
        }

    // Bolt
    translate([outerdia/2+20,0,arm_offset])
        rotate([90,0,0])
        cylinder(r=arm_dia/2, h=100, center=true);
    
    // Main hole
    cylinder(r=(holedia)/2, h=height+10, center=true);
    
    // Lense Lip
    translate([0,0,height/2])
        cylinder(r=(lipdia)/2, h=lipheight+1, center=false);
}

