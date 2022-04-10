// Wall Mounted Single Card Holder
// By Brian Khuu 2022-04-10

print_layer_height = 0.2;

// Businesscard
// Default values based on https://www.mbe.com.au/what-is-the-standard-business-card-size-in-australia/
businesscard_width = 91.5; // 90mm but some in real life are more like 91mm (Plus 0.5 tol)
businesscard_height = 55.5; // 55mm (add 0.5mm tol)
businesscard_thickness = 0.9; // 0.25mm for thin paper cards. 0.8mm for thick plastic cards

// Holder
wall_spacing = 1;
wall_card_grip = 10;

// Calc
wall_base = print_layer_height+0.1;
wall_top = print_layer_height*2+0.1;
wall_height = wall_base + businesscard_thickness + wall_top*2;


if (0)
translate([0,0,2])
    %cube([businesscard_width, businesscard_height, 1], center = true);



module cardholder(reducePlastic=false)
{
    difference()
    {
        translate([0,0,wall_height/2])
            cube([businesscard_width+wall_spacing, businesscard_height+wall_spacing, wall_height], center = true);

        // Reduce Plastic and print time
        if (reducePlastic)
        {
            translate([0,0,wall_height/2])
                cube([businesscard_width*0.8, businesscard_height*0.8, wall_height*3], center = true);
        }
        
        // Card Slide
        translate([0,0,wall_base])
        translate([0,0,businesscard_thickness/2])
        {
            hull()
            {
                translate([0,businesscard_height/2,businesscard_thickness + wall_top*2])
                cube([businesscard_width, 0.01, businesscard_thickness], center = true);
                
                translate([0,0,0])
                cube([businesscard_width, 0.01, businesscard_thickness], center = true);
            }
            hull()
            {
                translate([0,-businesscard_height/2,0])
                cube([businesscard_width, 0.01, businesscard_thickness], center = true);
                
                cube([businesscard_width, 0.01, businesscard_thickness], center = true);
            }
        }
        
        // Card Window
        translate([0,0,wall_base])
        translate([0,0,businesscard_thickness/2])
        {
            hull()
            {
                translate([0,0,0])
                union()
                {
                    translate([0,businesscard_height/2,businesscard_thickness + wall_top*2])
                    cube([businesscard_width, 0.01, businesscard_thickness], center = true);
                    translate([0,-businesscard_height/2,0])
                    cube([businesscard_width-wall_card_grip, 0.01, businesscard_thickness], center = true);
                }
                translate([0,0,businesscard_thickness + wall_top*2])
                union()
                {
                    translate([0,businesscard_height/2,businesscard_thickness + wall_top*2])
                    cube([businesscard_width, 0.01, businesscard_thickness], center = true);
                    translate([0,-businesscard_height/2,0])
                    cube([businesscard_width-wall_card_grip, 0.01, businesscard_thickness], center = true);
                }
            }
        }
    }
}

for (x = [1: 1 : 2])
    for (y = [1 : 1 : 3])
       translate([x*(businesscard_width+wall_spacing), y*(businesscard_height+wall_spacing), 0])
            cardholder();

    
    
    