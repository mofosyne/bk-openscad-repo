// Wall Mounted Single Card Holder For 13cm square photos for gameboy gallery (Derived from business card wall mount source)
// By Brian Khuu 2022-04-10
// Note: Adjusted to have enough space for command strips (2cmm on each side)

print_layer_height = 0.2;

// Businesscard
// Default values based on https://www.mbe.com.au/what-is-the-standard-business-card-size-in-australia/
businesscard_width = 127; // 127mm plus some tolerance
businesscard_height = 127; // 127mm plus some tolerance
businesscard_thickness = 1.0;

// Holder
wall_spacing = 1;
wall_card_grip = 10;
wall_x_count = 1; //2
wall_y_count = 1; //3

// Calc
wall_base = print_layer_height*3+0.1;
wall_top = print_layer_height*3+0.1;
wall_height = wall_base + businesscard_thickness + wall_top*2;

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
        %cube([130, 130, 0.1], center = true);

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
                translate([0,businesscard_height,0])
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

        // Reduce Plastic
        if (reducePlastic)
        translate([0,0,wall_base+businesscard_thickness/2+0.5])
        {
            //cube([businesscard_width-40,businesscard_height-30, wall_height+1], center=true);
            cube([businesscard_width-40,businesscard_height-40, wall_height+1], center=true);
        }
    }
}

if (wall_x_count == 1 && wall_y_count == 1)
{
    cardholder(false);
}
else
{
    for (x = [1: 1 : wall_x_count])
        for (y = [1 : 1 : wall_y_count])
           translate([x*(businesscard_width+wall_spacing), y*(businesscard_height+wall_spacing), 0])
                cardholder(false);
}