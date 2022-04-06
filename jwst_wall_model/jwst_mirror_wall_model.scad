// James Webb Space Telescope Mirrors Wall Model 
// By Brian Khuu 2022
//
// This is a model of the james webb space telescope mirror suing Acrylic Hex Mirrors
//
// Required Material:
//     - 18x Acrylic Geometric Hexagon Mirror Stickers (Mine was 23mm each side)
//     - 18x Adhesive Circles (Mine was a 1mm thick foam, 15mm in diameter)
//     - 2x Wall adhesive strips to attach this model to a wall

/*******************************************************************************
    User Customiseable Settings
*******************************************************************************/
$fn=40;

/* [Mirror] */
mirror_subtrate_thickness = 0.7; // Mirror Substrate Thickness
mirror_side_length = 23; // Mirror Side Length
mirror_base_side = mirror_side_length * 0.5; // Mirror Base Side

/* [Adhesive Circle] */
adhesive_circle_thickness = 1; // Adhesive Circle Thickness
adhesive_circle_diameter  = 15; // Adhesive Circular Diameter

/* [Base Thickness] */
base_thickness = 0.5; // Base Thickness

/* [Printer Spec] */
nozzle = 0.4; // Nozzle Size
extra_tol = 0.01; // Margins For Correct Number of Lines


/*******************************************************************************
    Model
*******************************************************************************/
print_tolerance = nozzle + extra_tol;
hex_mirror_dia = mirror_side_length / sin(30); // This is the wide diameter of the hex mirror
hex_mirror_mini_dia = mirror_side_length / tan(30); // This is the narrow diameter of the hex mirror

// JWST Wall Mirror Model
union()
{
    // Receiver Horn
    honeycomb(hex_mirror_dia - print_tolerance, base_thickness + adhesive_circle_thickness + mirror_subtrate_thickness);
    cylinder(d = hex_mirror_mini_dia - print_tolerance, h = base_thickness + adhesive_circle_thickness + mirror_subtrate_thickness + 3);
    hull()
    {
        hornDia = ((hex_mirror_mini_dia - print_tolerance)*cos(45));
        translate([0, (hornDia * 1/4)/2,, base_thickness + adhesive_circle_thickness + mirror_subtrate_thickness])
            cube([hornDia, hornDia*3/4, 0.1], center=true);
        translate([0, (hornDia * 1/4)/2,, base_thickness + adhesive_circle_thickness + mirror_subtrate_thickness + 30])
            cube([hornDia*0.6, hornDia*3/4 * 0.8, 0.1], center=true);
    }

    // Mirrors
    difference()
    {
        translate([0, 0, 0])
            jwst_bulk(hex_mirror_dia, base_thickness + adhesive_circle_thickness + mirror_subtrate_thickness, extraoffset = mirror_base_side);

        translate([0, 0, base_thickness + adhesive_circle_thickness])
            jwst_bulk(hex_mirror_dia, mirror_subtrate_thickness + 1, extraoffset = 0.1 + print_tolerance);

        translate([0, 0, base_thickness])
            jwst_adhesive_circle_bulk(hex_mirror_dia, adhesive_circle_diameter, adhesive_circle_thickness + 1, extraoffset = print_tolerance);
    }
}

// Test Mirror Fit
if (1)
%translate([0, 0, base_thickness + adhesive_circle_thickness])
    color("silver")
        jwst_bulk(hex_mirror_dia, mirror_subtrate_thickness, 0, noMiddle=true);


/*******************************************************************************
    Modules
*******************************************************************************/
module jwst_bulk(hex_mirror_dia, thickness, extraoffset=0, noMiddle=false)
{
    pitch_X = hex_mirror_dia * cos(30);
    pitch_Y = (hex_mirror_dia / 2) * (1 + sin(30));
    for ( X = [-2 : 2] )
    {
        for ( Y = [-2 : 2] )
        {
            if (0
                || (Y == -2 && X == -2)
                || (Y ==  2 && X ==  2)
                || (X == -2 && Y ==  2)
                || (Y == -2 && X ==  2))
            {
                // Corner
            }
            else if (noMiddle && (Y == 0 && X == 0))
            {
                // Center
            }
            else if(Y % 2 == 0)
            {
                translate([X * pitch_X, Y * pitch_Y, 0])
                    honeycomb(hex_mirror_dia + extraoffset, thickness);
            }
            else if (X != 2)
            {
                translate([(X + 0.5) * pitch_X, Y * pitch_Y, 0])
                    honeycomb(hex_mirror_dia + extraoffset, thickness);
            }
        }
    }
}

module honeycomb(diameter, thickness)
{
    nSides = 6;
    rotate([0,0,30])
        cylinder(d=diameter, h=thickness, $fn=nSides);
};


////////////////////////////////////////////////////////////////////////////////

module jwst_adhesive_circle_bulk(hex_mirror_dia, adhesive_circle_diameter, thickness, extraoffset=0)
{
    pitch_X = hex_mirror_dia * cos(30);
    pitch_Y = (hex_mirror_dia / 2) * (1 + sin(30));
    for( X = [-2 : 2] )
    {
        for( Y = [-2 : 2] )
        {
            if (0
                || (Y == -2 && X == -2)
                || (Y ==  2 && X ==  2)
                || (X == -2 && Y ==  2)
                || (Y == -2 && X ==  2))
            {
                // Corner
            }
            else if (Y == 0 && X == 0)
            {
                // Center
            }
            else if(Y % 2 == 0)
            {
                translate([X * pitch_X, Y * pitch_Y, 0])
                    cylinder(d=adhesive_circle_diameter + extraoffset, h=thickness);
            }
            else if (X != 2)
            {
                translate([(X + 0.5) * pitch_X, Y * pitch_Y, 0])
                    cylinder(d=adhesive_circle_diameter + extraoffset, h=thickness);
            }
        }
    }
}

