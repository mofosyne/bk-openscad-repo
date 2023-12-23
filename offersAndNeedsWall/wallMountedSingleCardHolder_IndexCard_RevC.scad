// Wall Mounted Single Card Holder
// By Brian Khuu 2022-04-22
// RevC : This revision is an optimiation for ease of pickup as well as being able to view cards behind a glass

print_layer_height = 0.2;

// Index Card
// 76 x 127mm (More like 126mm width when measured)
businesscard_width = 127.5; // 127mm (Plus 0.5 tol)
businesscard_height = 76.5; // 76mm (add 0.5mm tol)
businesscard_thickness = 2.5; // 0.25mm for thin paper cards. 0.8mm for thick plastic cards. We need to add extra thickness to account for layer droop

// Holder
wall_spacing = 2;
wall_card_grip = 16;
wall_x_count = 1; //2
wall_y_count = 2; //3

// Calc
wall_base = print_layer_height*3+0.1;
wall_top = print_layer_height*3+0.1;
wall_height = wall_base + businesscard_thickness + wall_top*2;

module cardSlopeOutline()
{
    hull()
    {
        slope_width = (businesscard_width-wall_card_grip)/2;
        translate([0,businesscard_height/2+1, wall_base])
        cube([slope_width, 0.01, 0.01], center = true);
        translate([0,businesscard_height/4,businesscard_thickness + wall_top*2])
        cube([slope_width, 0.01, 0.01], center = true);
    }
}

module cardWindowOutline()
{
    hull()
    {
        translate([0,businesscard_height/2,businesscard_thickness + wall_top*2])
        cube([businesscard_width, 0.01, 0.01], center = true);
        translate([0,0,0])
        cube([businesscard_width, 0.01, 0.01], center = true);
    }
    hull()
    {
        translate([0,0,businesscard_thickness + wall_top*2])
        cube([businesscard_width, 0.01, 0.01], center = true);
        translate([0,-businesscard_height/2,0])
        cube([businesscard_width-wall_card_grip, 0.01, 0.01], center = true);
    }
}

module cardholder(reducePlastic=false)
{
    if (0)
    translate([0,0,wall_base+businesscard_thickness])
        rotate([2,0,0])
        %cube([85, 54, 0.1], center = true);

    difference()
    {
        translate([0,0,wall_height/2])
            cube([businesscard_width+wall_spacing, businesscard_height+wall_spacing, wall_height], center = true);

        // Card Slide
        translate([0,0,wall_base])
        translate([0,0,businesscard_thickness/2])
        {
            // Upper
            hull()
            {
                translate([0,businesscard_height/2,businesscard_thickness + wall_top*2])
                cube([businesscard_width, 0.01, businesscard_thickness], center = true);

                translate([0,0,0])
                cube([businesscard_width, 0.01, businesscard_thickness], center = true);
            }
            // Lower
            hull()
            {
                translate([0,-businesscard_height/2,0])
                cube([businesscard_width, 0.01, businesscard_thickness], center = true);
                cube([businesscard_width, 0.01, businesscard_thickness], center = true);
            }
        }

        // Grip
        translate([0,0,wall_height/2+wall_base])
            hull()
            {
                translate([0,0,0])
                cube([businesscard_width-wall_card_grip, 0.01, wall_height], center = true);

                translate([0,-businesscard_height,0])
                cube([businesscard_width-wall_card_grip, 0.01, wall_height], center = true);
            }


        // Card Window
        translate([0,0,wall_base+businesscard_thickness/2])
        {
            hull()
            {
                // Card Window Base
                cardWindowOutline();
                // Card Window Top
                translate([0,0,businesscard_thickness + wall_top * 2])
                    cardWindowOutline();
            }
        }

        // Card Slope
        translate([0,0,0])
        {
            hull()
            {
                // Card Window Base
                cardSlopeOutline();
                // Card Window Top
                translate([0,0,businesscard_thickness + wall_top * 2])
                    cardSlopeOutline();
            }
        }

        // Reduce Plastic
        if (reducePlastic)
        translate([0,0,wall_base+businesscard_thickness/2+0.5])
        {
            cube([businesscard_width-wall_card_grip,businesscard_height*0.8, wall_height+1], center=true);
        }
    }
}

if (wall_x_count == 1 && wall_y_count == 1)
{
    cardholder(true);
}
else
{
    translate([-((businesscard_width+wall_spacing)*wall_x_count)/2,-((businesscard_height+wall_spacing)*wall_y_count)/2,0])
    {
        for (x = [0: 1 : wall_x_count-1])
            for (y = [0 : 1 : wall_y_count-1])
                translate([x*(businesscard_width+wall_spacing) + (businesscard_width+wall_spacing)/2, y*(businesscard_height+wall_spacing)+(businesscard_height+wall_spacing)/2, 0])
                        cardholder(true);
    }
}





