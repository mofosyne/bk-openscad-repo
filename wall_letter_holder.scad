

letter_width = 220;
letter_height = 110;
letter_thickness = 5;

// Letter Model
for (i=[0:1:5])
    translate([0,-i*(letter_height*2/3),0])
        rotate([10,0,0])
            translate([0,letter_height/2,letter_thickness/2])
                %cube([letter_width, letter_height, letter_thickness], center=true);



// Letter Model
for (i=[0:1:5])
    translate([0,-i*(letter_height*2/3),0])
        difference()
        {
            hull()
            {
                rotate([10,0,0])
                    translate([0,(letter_height*1/3)/2,letter_thickness/2])
                        cube([letter_width, (letter_height*1/3), letter_thickness], center=true);
            }
            rotate([10,0,0])
                translate([0,letter_height/2,letter_thickness/2])
                    cube([letter_width, letter_height, letter_thickness], center=true);
        }