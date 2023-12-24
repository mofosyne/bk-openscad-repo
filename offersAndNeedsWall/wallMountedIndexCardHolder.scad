// Wall Mounted Multi Card Holder Extention
// By Brian Khuu 2022-04-22
// Dev Note: Originally for businesscard, but modified for OffersAndNeeds 3D printed wall
$fn = 40;

print_layer_height = 0.2; //< This is the value you used when printing the main holder. This will indicate the amount of gap needed for the mounting slot

// Index Card
// 76 x 127mm (More like 126mm width when measured)
businesscard_width = 127.5; // 127mm (Plus 0.5 tol)
businesscard_height = 76.5; // 76mm (add 0.5mm tol)
businesscard_thickness = 1.5; // 0.25mm for thin paper cards. 0.8mm for thick plastic cards. We need to add extra thickness to account for layer droop

// Holder
wall_spacing = 2;
wall_card_grip = 20;

// Calc
wall_base = print_layer_height*3+0.1;
wall_top = print_layer_height*3+0.1;
wall_height = wall_base + businesscard_thickness + wall_top*2;

// Main Holder
holder_thickness = 1.0;
holder_slot_depth = businesscard_thickness*11; // 10 business cards (1 businesscard tolerance)
holder_slot_shift = 10;

// Pen Holder
penHolder_thickness = 1;
penHolder_pendia = 13;

module penholder() {
    intersection()
    {

        penHolder_outerdia = penHolder_pendia+penHolder_thickness*2+2;
        penHolder_outerGripDia = penHolder_pendia;
        penHolder_innerdia = penHolder_pendia+1;
        difference()
        {
            hull()
            {
                translate([0,holder_slot_depth+holder_thickness*2+holder_slot_shift,penHolder_outerdia/2])
                    rotate([0,90,0])
                        cylinder(d=penHolder_outerdia, h=(businesscard_width+holder_thickness*2), center=true);
                translate([0,holder_slot_depth+holder_thickness*2+holder_slot_shift+penHolder_outerdia/2,penHolder_outerdia/2])
                    rotate([0,90,0])
                        cylinder(d=penHolder_outerdia, h=(businesscard_width+holder_thickness*2), center=true);
            }
            hull()
            {
                translate([0,holder_slot_depth+holder_thickness*2+holder_slot_shift+penHolder_innerdia/2+penHolder_thickness-2,penHolder_innerdia/2+penHolder_thickness])
                    rotate([0,90,0])
                        cylinder(d=penHolder_innerdia, h=businesscard_width, center=true);
                translate([0,holder_slot_depth+holder_thickness*2+holder_slot_shift+penHolder_innerdia/2+penHolder_thickness,penHolder_innerdia/2+penHolder_thickness])
                    rotate([0,90,0])
                        cylinder(d=penHolder_innerdia, h=businesscard_width, center=true);
            }
            hull()
            {
                translate([0,holder_slot_depth+holder_thickness*2+holder_slot_shift+penHolder_innerdia/2+penHolder_thickness-3,penHolder_innerdia/2+penHolder_thickness])
                    rotate([0,90,0])
                        cylinder(d=penHolder_outerGripDia, h=businesscard_width+holder_thickness*2+0.1, center=true);
                translate([0,holder_slot_depth+holder_thickness*2+holder_slot_shift+penHolder_innerdia/2+penHolder_thickness,penHolder_innerdia/2+penHolder_thickness])
                    rotate([0,90,0])
                        cylinder(d=penHolder_outerGripDia, h=businesscard_width+holder_thickness*2+0.1, center=true);
            }
        }
        translate([0,holder_slot_depth+holder_thickness*2+holder_slot_shift+penHolder_thickness,penHolder_outerdia/4])
        cube([businesscard_width+holder_thickness*2,penHolder_outerdia*2,penHolder_outerdia/2],center=true);
    }

}

rotate([0,90,0])
difference()
{
    // Bulk
    union()
    {
        hull()
        {
            translate([-(businesscard_width+holder_thickness*2)/2, 0, businesscard_height-holder_thickness])
                cube([(businesscard_width+holder_thickness*2), holder_slot_depth+holder_thickness*2, 1]);
            translate([-(businesscard_width+holder_thickness*2)/2, 0, 0])
                cube([(businesscard_width+holder_thickness*2), holder_slot_depth+holder_thickness*2+holder_slot_shift, 1]);
                
            
        }
        // Pen Cut
        penholder();
        translate([0, -3, penHolder_pendia + penHolder_pendia/2])
            penholder();
        
    }

    // Card
    hull()
    {
        translate([-(businesscard_width)/2, holder_thickness, holder_thickness+businesscard_height])
            cube([(businesscard_width), holder_slot_depth, 1]);
        translate([-(businesscard_width)/2, holder_thickness+holder_slot_shift, holder_thickness])
            cube([(businesscard_width), holder_slot_depth, 1]);
    }
    
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