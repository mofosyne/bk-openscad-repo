// Wall Mounted Single Card Holder
// By Brian Khuu 2022-04-10
// RevB is specifically for Alexar's request for gear style slopes
use <MCAD/involute_gears.scad>
use <MCAD/regular_shapes.scad>

print_layer_height = 0.2;

// Businesscard
// Default values based on https://www.mbe.com.au/what-is-the-standard-business-card-size-in-australia/
businesscard_width = 93; // 90mm but some in real life are more like 91mm (Plus 0.5 tol )
businesscard_height = 56; // 55mm (add 0.5mm tol)
businesscard_thickness = 1.5; // 0.25mm for thin paper cards. 0.8mm for thick plastic cards. We need to add extra thickness to account for layer droop

// Holder
wall_spacing = 2;
wall_card_grip = 20;
wall_x_count = 2; //2
wall_y_count = 3; //3

// Calc
wall_base = print_layer_height*3+0.1;
wall_top = print_layer_height*3+0.1;
wall_height = wall_base + businesscard_thickness + wall_top*2;

module simple_gear (
	number_of_teeth=15,
	circular_pitch=false, diametral_pitch=false,
	pressure_angle=28,
	clearance = 0.2,
	backlash=0,
	twist=0,
	involute_facets=0,
	flat=false)
{
    pi=3.1415926535897932384626433832795;
    
	if (circular_pitch==false && diametral_pitch==false)
		echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;
	echo ("Teeth:", number_of_teeth, " Pitch radius:", pitch_radius);

	// Base Circle
	base_radius = pitch_radius*cos(pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / number_of_teeth - backlash_angle) / 4;


    linear_exturde_flat_option(flat=flat, height=rim_thickness, convexity=10, twist=twist)
    gear_shape (
        number_of_teeth,
        pitch_radius = pitch_radius,
        root_radius = root_radius,
        base_radius = base_radius,
        outer_radius = outer_radius,
        half_thick_angle = half_thick_angle,
        involute_facets=involute_facets);
}

module cardSlopeOutline()
{
    hull()
    {
        translate([0,businesscard_height/2+1, wall_base])
        cube([businesscard_width-wall_card_grip, 0.01, 0.01], center = true);
        translate([0,businesscard_height/4,businesscard_thickness + wall_top*2])
        cube([businesscard_width-wall_card_grip, 0.01, 0.01], center = true);
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
        difference()
        {
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
            translate([0,-225,0])
                simple_gear(number_of_teeth=100, circular_pitch=900, rim_thickness = wall_height);
        }
        
        // Reduce Plastic
        if (reducePlastic)
        translate([0,0,wall_base+businesscard_thickness/2+0.5])
        {
            cube([businesscard_width-wall_card_grip,businesscard_height-10, wall_height+1], center=true);
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





