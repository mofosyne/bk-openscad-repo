// Table/Seat Post Mount
// By Brian Khuu (May 2023)
// Design Context: Wanted to mount a small flat wood top to a collapsable table post
//                 Note that the table post has cross braces so this design is mostly there to keep 
//                 the post aligned to the center of the table.
//                 This will be glued to the wood table top and the post would be slotted in.

/*
    |<-- post_slot_to_post_slot -->|
   (X)............................(X)
    :                              :
    :                              :
    :                              :
    :                              :
    :                              :
    :                              :
    :                              :
    :                              :
    :                              :
    :                              :
    :                              :
   (X)............................(X)
*/

// Mount Base Thickness
base_thickness = 2;

// Post Diamater
post_slot_dia=17;

// Distance between edge of one post to the other edge of the post
post_slot_to_post_slot_from_edge_to_edge = 200;

// Post slot height
post_slot_height = 15;

// Post slot wall thickness (Top)
post_slot_wall_top_thickness = 2;

// Distance between centerpoint of each post
post_slot_to_post_slot = post_slot_to_post_slot_from_edge_to_edge - post_slot_dia;

// Post slot wall thickness (Bottom)
post_slot_wall_base_thickness = post_slot_to_post_slot/2;

// Screws
screw_enable = true;
screw_shaft_height = 2;
screw_shaft_dia = 3 + 0.2;
screw_head_height = 2;
screw_head_dia = 4.5 + 0.2;

// Lazy Susan Hole
// Note: Was implemented so that this can fit a IKEA SNUDDA lazy susan which has a fixed base diameter of 18.2cm and 22mm offset from bottom of base to top of rotating table
lazy_susan_enable = true;
lazy_susan_dia = 185; // Measured 18.2cm


module post_to_tabletop_slot(post_slot_dia, post_slot_to_post_slot, base_thickness, post_slot_height, post_slot_wall_top_thickness, post_slot_wall_base_thickness)
{
    post_slot_wall_top_diameter = post_slot_wall_top_thickness*2 + post_slot_dia;
    post_slot_wall_base_diameter = post_slot_wall_base_thickness*2 + post_slot_dia;
    
    intersection()
    {
        // Bulk
        difference()
        {
            hull()
            {
                for (i=[0:1:3])
                    rotate([0,0,90*i])
                        translate([post_slot_to_post_slot/2, post_slot_to_post_slot/2,0])
                            cylinder(d=post_slot_wall_top_diameter, h=base_thickness+post_slot_height);
            }
            hull()
            {
                distXYOffset=(post_slot_wall_top_diameter/2)*cos(45);
                for (i=[0:1:3])
                    rotate([0,0,90*i])
                        translate([post_slot_to_post_slot/2-distXYOffset*2, post_slot_to_post_slot/2-distXYOffset*2,-0.1])
                            cylinder(d=post_slot_wall_top_diameter, h=base_thickness+post_slot_height+1);
            }
            if (screw_enable)
            {
                for (i=[0:1:3])
                rotate([0,0,90*i])
                    translate([post_slot_to_post_slot/2, post_slot_to_post_slot/2,0])
                        union()
                        {
                            translate([0,0,-1])
                                cylinder(d=screw_shaft_dia, h=post_slot_height+0.1, $fn=40);
                            translate([0,0,screw_shaft_height])
                                cylinder(d1=screw_head_dia, d2=screw_head_dia+2, h=screw_head_height+0.1, $fn=40);
                        }
            }
            if (lazy_susan_enable)
            {
                translate([0,0,-0.1])                
                    cylinder(d=lazy_susan_dia, h=base_thickness+post_slot_height, $fn=60);
            }
        }
        
        union()
        {
            // Base
            translate([0,0,base_thickness/2])
                cube([post_slot_to_post_slot+post_slot_wall_base_diameter,post_slot_to_post_slot+post_slot_wall_base_diameter, base_thickness], center=true);
            
            // Slot
            for (i=[0:1:3])
                rotate([0,0,90*i])
                    translate([post_slot_to_post_slot/2, post_slot_to_post_slot/2,])
                        difference()
                        {
                            translate([0,0,base_thickness])
                                cylinder(d1=post_slot_wall_base_diameter, d2=post_slot_wall_top_diameter, h=post_slot_height);
                            translate([0,0,screw_enable ? (screw_shaft_height+screw_head_height) : 1])
                                cylinder(d=post_slot_dia, h=post_slot_height+0.1);
                        }
        }
    }
}

if (1)
{
    // Use
    post_to_tabletop_slot(
        post_slot_dia=post_slot_dia,
        post_slot_to_post_slot=post_slot_to_post_slot,
        base_thickness=base_thickness,
        post_slot_height=post_slot_height,
        post_slot_wall_top_thickness=post_slot_wall_top_thickness, 
        post_slot_wall_base_thickness=post_slot_dia*3);
}
else
{
    // Test
    post_to_tabletop_slot(
        post_slot_dia=post_slot_dia,
        post_slot_to_post_slot=post_slot_to_post_slot,
        base_thickness=0.5,
        post_slot_height=5,
        post_slot_wall_top_thickness=1, 
        post_slot_wall_base_thickness=1);
}

