// Preprinted Label Holder or First Aid Bandaid Holder
// By Brian Khuu 2022-04-22


print_nozzle_dia = 0.6;
print_layer_width = 0.2;

// slot
// Default values based on https://www.mbe.com.au/what-is-the-standard-business-card-size-in-australia/
slot_width = 95; // 90mm but some in real life are more like 91mm (Plus 0.5 tol )
slot_height = 32; // 55mm (add 0.5mm tol)
slot_thickness = 5; // 0.25mm for thin paper cards. 0.8mm for thick plastic cards. We need to add extra thickness to account for layer droop

// Holder
wall_spacing = print_nozzle_dia+0.4;
wall_card_grip = 20;
wall_x_count = 2;
wall_y_count = 6;

// Calc
wall_base = print_layer_width*3+0.1;
wall_top = print_layer_width*4+0.1;
wall_width = wall_base + slot_thickness + wall_top;
slot_bulk_width = slot_width+wall_spacing+wall_card_grip;
slot_bulk_height = slot_height+wall_spacing*2;

module cardholder()
{
    // Label Title Sticker
    if (0)
    translate([wall_spacing,-30/2,wall_width+0.1])
        %cube([90, 30, 0.1]);    
        
    // Label In Holder
    if (0)
    translate([wall_spacing+wall_card_grip,-30/2,wall_width/2])
        rotate([0,-2,0])
        %cube([90, 30, 0.1]);

    difference()
    {
        translate([0,-slot_bulk_height/2,0])
            cube([slot_bulk_width, slot_bulk_height, wall_width]);

        // Slope
        translate([wall_card_grip+wall_spacing,0,wall_base])
            rotate([90,0,0])
                translate([0,0,-(slot_bulk_height-wall_spacing*2)/2])
                    linear_extrude(height=slot_bulk_height-wall_spacing*2)
                        polygon(points=[[0,0],
                            [0,slot_thickness],
                            [slot_width-wall_card_grip,slot_thickness],
                            [slot_width-wall_card_grip,slot_thickness+wall_top+0.1],
                            [slot_width-wall_card_grip,slot_thickness+wall_top+0.1],
                            [slot_width,slot_thickness+wall_top],
                            [slot_width-wall_card_grip,0]
                            ]);

        // Slope
        if (0)
        translate([wall_card_grip+wall_spacing,0,wall_base])
            rotate([90,0,0])
                translate([0,0,-(slot_bulk_height-wall_spacing*2)/4])
                    linear_extrude(height=(slot_bulk_height-wall_spacing*2)/2)
                        polygon(points=[[0,0],
                            [0,slot_thickness],
                            [slot_width-wall_card_grip,slot_thickness],
                            [slot_width-wall_card_grip,slot_thickness+wall_top+0.1],
                            [slot_width-wall_card_grip,slot_thickness+wall_top+0.1],
                            [slot_width,slot_thickness+wall_top],
                            [slot_width-wall_card_grip/3,0]
                            ]);

        // Label Positioner
        translate([wall_spacing,-(slot_bulk_height-wall_spacing*2-1)/2,wall_width-print_layer_width])
            cube([slot_width, slot_bulk_height-wall_spacing*2-1, print_layer_width*1+0.1]);    
    }
}

if (wall_x_count == 1 && wall_y_count == 1)
{
    cardholder();
}
else
{
    translate([-((slot_bulk_width)*wall_x_count)/2,-((slot_bulk_height)*wall_y_count)/2,0])
    {
        for (x = [0: 1 : wall_x_count-1])
            for (y = [0 : 1 : wall_y_count-1])
                translate([x*(slot_bulk_width) + (slot_bulk_width)/2, y*(slot_bulk_height)+(slot_bulk_height)/2, 0])
                        cardholder();
    }
}

