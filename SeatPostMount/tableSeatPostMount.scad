// Table/Seat Post Mount
// By Brian Khuu (May 2023)
// Design Context: Wanted to mount a small flat wood top to a collapsible table post
//                 Note that the table post has cross braces so this design is mostly there to keep 
//                 the post aligned to the centre of the table.
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
base_thickness = 3;

// Post Diamater
post_slot_dia=17;

// Distance between edge of one post to the other edge of the post
post_slot_to_post_slot_from_edge_to_edge = 200;

// Post slot height
post_slot_height = 20;

// Post slot wall thickness (Top)
post_slot_wall_top_thickness = 2;

// Distance between centerpoint of each post
post_slot_to_post_slot = post_slot_to_post_slot_from_edge_to_edge - post_slot_dia;

// Post slot wall thickness (Bottom)
post_slot_wall_base_thickness = post_slot_to_post_slot/2;

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
        }
        
        union()
        {
            // Base
            translate([0,0,base_thickness/2])
                cube([post_slot_to_post_slot+post_slot_wall_base_diameter,post_slot_to_post_slot+post_slot_wall_base_diameter, base_thickness], center=true);
            
            // Slot
            for (i=[0:1:3])
                rotate([0,0,90*i])
                    translate([post_slot_to_post_slot/2, post_slot_to_post_slot/2,1])
                        difference()
                        {
                            cylinder(d1=post_slot_wall_base_diameter, d2=post_slot_wall_top_diameter, h=post_slot_height);
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

