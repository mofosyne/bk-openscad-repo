// Preprinted Label Holder (Keyring Style)
// By Brian Khuu 2022-06-26

print_nozzle_dia = 0.6;
print_layer_height = 0.2;

// label preview
label_width = 26; // 25mm (add 0.5mm tol side to side)
label_height = 26; // 25mm (add 0.5mm tol side to side)

// slot
// Default values based on https://www.mbe.com.au/what-is-the-standard-business-card-size-in-australia/
slot_width = 31; // 30mm (add 0.5mm tol side to side)
slot_height = 40; // 30mm (add 0.5mm tol side to side)
slot_thickness = 3; // 0.25mm for thin paper cards. 0.8mm for thick plastic cards. We need to add extra thickness to account for layer droop

// Holder
wall_spacing = print_nozzle_dia+0.4;
wall_card_grip = 5;
wall_x_count = 1;
wall_y_count = 1;

// Calc
slot_label_height = print_layer_height*3+0.1;
wall_base = print_layer_height*3+0.1;
wall_top = print_layer_height*6+0.1;
wall_thickness = wall_base + slot_thickness + wall_top + slot_label_height;
slot_bulk_width = slot_width+wall_spacing*2;
slot_bulk_height = slot_height+wall_spacing*2;

// Keyring
keyring_hole_size_thinnest = 2;
keyring_hole_size_widest = 10;
keyring_hole_wall_top = 1.5;
keyring_hole_wall_side = 10;

// box rounding
boxFilletRadidus = 1;

module roundedBox00(length, width, height, filletRad)
{
    // https://www.printables.com/model/50333-rounded-box-module-for-openscad/files
    filletDia=2*filletRad;
    translate([length/2, width/2, height/2])
    minkowski()
    {
        sphere(filletRad, $fn=40);
        cube([length-filletDia, width-filletDia, height-filletDia], center=true);
    }   
}

module cardholder()
{
    difference()
    {
        union()
        {
            if (boxFilletRadidus == 0)
                translate([0,-slot_bulk_height/2,0])
                    cube([slot_bulk_width, slot_bulk_height, wall_thickness]);
            else
                translate([0,-slot_bulk_width/2,0])
                    roundedBox00(slot_bulk_height, slot_bulk_width, wall_thickness, boxFilletRadidus);
            // Keyring Bulk
            hull()
            {
                translate([slot_bulk_height-boxFilletRadidus,0,wall_thickness/2])                
                    cube([0.01, slot_bulk_width-boxFilletRadidus*2, wall_thickness], center=true);
                translate([slot_bulk_height+keyring_hole_size_thinnest+keyring_hole_wall_top,0,(wall_thickness/8)/2])                
                    cube([0.01, (keyring_hole_size_widest)/2, wall_thickness/8], center=true);
            }
        }

        // Slope
        translate([wall_spacing,0,slot_thickness+wall_base+slot_label_height])
            rotate([-90,0,0])
                translate([0,0,-(slot_bulk_width-wall_spacing*2)/2])
                    linear_extrude(height=slot_bulk_width-wall_spacing*2)
                        polygon(points=[[0,0],
                            [0,slot_thickness],
                            [slot_height-wall_card_grip,slot_thickness+slot_label_height],
                            [slot_height-wall_card_grip,slot_thickness+wall_base+slot_label_height+0.1],
                            [slot_height-wall_card_grip,slot_thickness+wall_base+slot_label_height+0.1],
                            [slot_height-0.01,slot_thickness+wall_base+slot_label_height],
                            [slot_height-wall_card_grip,0]
                            ]);

        // Grip 
        hull()
        {
            translate([slot_bulk_height/2, 0, -0.1])
                cylinder(d=slot_bulk_width/3, h=slot_thickness, $fn=40);
            translate([slot_height+wall_spacing-wall_card_grip, 0, (wall_base+1)/2-0.1])
                cube([0.01, slot_bulk_width/3, wall_base+1], center=true);
        }

        // Label Positioner
        translate([slot_bulk_height/2,0,wall_thickness-slot_label_height+(slot_label_height+0.1)/2+0.1])
            cube([label_width, label_height, slot_label_height+0.1], center=true);    
        
        // Keyring Bulk
        hull()
        {
            translate([slot_bulk_height,0,wall_thickness/2-0.1])                
                cube([0.01, keyring_hole_size_widest, wall_thickness], center=true);
            translate([slot_bulk_height+keyring_hole_size_thinnest,0,wall_thickness/2-0.1])                
                cube([0.01, (keyring_hole_size_widest)/2, wall_thickness], center=true);
        }        
    }
}

cardholder();
