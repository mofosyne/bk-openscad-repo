// Cardboard Box Stacker (Remixed in OpenSCAD for printability) 
// Original Design By UnleashSpirit and Wolfcraft In https://www.thingiverse.com/thing:3331874
// Redesign By Brian Khuu 2024 for easier printability and parametric capability

$fn=50;

stacker_thickness = 1;
stacker_flange = 15;
stacker_height = 50;

pole_dia = 5;

rotate([90,0,0])
intersection()
{
    union()
    {
        rotate([0,0,45])
        {
            translate([stacker_flange/2, stacker_thickness/2-1/2, 0])
                cube([stacker_thickness, stacker_flange+1, stacker_height], center=true);
            translate([stacker_thickness/2-1/2, stacker_flange/2, 0])
                cube([stacker_flange+1, stacker_thickness, stacker_height], center=true);
        }

        hull()
        rotate([0,0,45])
        {
            translate([stacker_flange/2, stacker_thickness/2-1/2, 0])
                cube([stacker_thickness, stacker_flange+1, 1], center=true);
            translate([stacker_thickness/2-1/2, stacker_flange/2, 0])
                cube([stacker_flange+1, stacker_thickness, 1], center=true);
        }

        translate([0,2,0])
        {
            cylinder(d=pole_dia, h=stacker_height/2-pole_dia);
            translate([0,0,stacker_height/2-pole_dia])
                cylinder(d1=pole_dia,d2=0, h=pole_dia);
        }
    }
    
   translate([0,stacker_flange/2,0])
    cube([stacker_flange*2,stacker_flange,stacker_height], center=true);
}