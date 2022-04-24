// Wall Mounted Multi Card Holder Extention
// By Brian Khuu 2022-04-22
// RevA : This slots into the single card holder to allow for holding on to multiple cards in case you want to store a few extra cards not on show

print_layer_height = 0.2; //< This is the value you used when printing the main holder. This will indicate the amount of gap needed for the mounting slot

// Businesscard
// Default values based on https://www.mbe.com.au/what-is-the-standard-business-card-size-in-australia/
businesscard_width = 93; // 90mm but some in real life are more like 91mm (Plus 0.5 tol )
businesscard_height = 56; // 55mm (add 0.5mm tol)
businesscard_thickness = 1.5; // 0.25mm for thin paper cards. 0.8mm for thick plastic cards. We need to add extra thickness to account for layer droop

// Holder
wall_spacing = 2;
wall_card_grip = 20;

// Calc
wall_base = print_layer_height*3+0.1;
wall_top = print_layer_height*3+0.1;
wall_height = wall_base + businesscard_thickness + wall_top*2;



// Fake Businesscard To Grip Single Card Slot
wall_mount_card_thickness = 1.0;
wall_mount_card_width = 90.0;
wall_mount_spacing = print_layer_height*3 + 1.0;
translate([-wall_mount_card_width/2, -wall_mount_card_thickness-wall_mount_spacing, 0])
    cube([wall_mount_card_width, wall_mount_card_thickness, businesscard_height/2]);
translate([-(businesscard_width-wall_card_grip*2-1.0)/2, -wall_mount_spacing, 0])
    cube([(businesscard_width-wall_card_grip*2-1.0), wall_mount_spacing, businesscard_height/2]); 


// Main Holder
holder_thickness = 1.0;
holder_slot_depth = businesscard_thickness*11; // 10 business cards (1 businesscard tolderance)
difference()
{
    // Bulk
    translate([-(businesscard_width+holder_thickness*2)/2, 0, 0])
        cube([(businesscard_width+holder_thickness*2), holder_slot_depth+holder_thickness*2, businesscard_height-holder_thickness]);

    // Card
    translate([-(businesscard_width)/2, holder_thickness, holder_thickness])
        cube([(businesscard_width), holder_slot_depth, businesscard_height]);
    
    // Slot Cut
    hull()
    {
        translate([0, (holder_slot_depth+holder_thickness*3)/2, businesscard_height/2])
            rotate([-45/2,0,0])
            cube([(businesscard_width*2), holder_slot_depth*2, 1], center=true);
        translate([0, (holder_slot_depth+holder_thickness*3)/2, businesscard_height])
            rotate([0,0,0])
            cube([(businesscard_width*2), holder_slot_depth*2, 1], center=true);
    }
    
    
}