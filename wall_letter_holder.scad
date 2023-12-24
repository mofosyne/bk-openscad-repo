// Wall Letter Holder (OpenSCAD)
// Brian Khuu December 2023
// Description: Wall Letter Organiser using commands strips split in half to stick it to the wall
//              You need two copies to hold each letter stably
//              This was tested under a Prusa MK3S+ with a 0.6mm Nozzle
$fn = 40;

/* [Letter Dimentions] */
letter_width = 220;
letter_height = 110;
letter_thickness = 5;

/* [Letter Holder Spec] */
letter_slot_overlap_percent = 1/2;
letter_slot_count = 3;
base_thickness = 0.8;

/* [Command Strip] */

// Command Strip Width
commandstrip_w = 16/2; // 16mm width strip, but cut in half

// Command Strip Height (Not including the pull tab)
commandstrip_h = 50;

// Command Strip Thickness
commandstrip_thickness = 1.0;

/* [Stacked Printing Mode] */
stack_printing_count = 0;
stack_printing_gap = 0.3;

module hookHalfCurve(
    majorcurve_radius = 5, 
    flange_radius = 5,
    majorcurve_angle = 260, 
    flange_angle = 140,  
    curve_thickness = 1,
    curve_height=10)
{
    module hookCrossSection()
    {
        square(size = [curve_thickness, curve_height], center = true);
    }
    translate([-majorcurve_radius,0,0])
        union()
        {
            // Major Curve
            rotate_extrude(angle = majorcurve_angle) 
                translate([majorcurve_radius+curve_thickness/2, 0, 0])
                    hookCrossSection();
            // Mini Curve
            rotate([0,0,-180+majorcurve_angle])
            translate([-majorcurve_radius-flange_radius-curve_thickness/2,0,0])
            rotate_extrude(angle = -flange_angle) 
                translate([flange_radius, 0, 0])        
                    hookCrossSection();
            // Mini Curve Cap
            rotate([0,0,-180+majorcurve_angle])
            translate([-majorcurve_radius-flange_radius-curve_thickness/2,0,0])
                rotate([0,0,-flange_angle])
                    translate([flange_radius, 0, 0])
                        rotate([90,0,0])
                            linear_extrude(height=1, scale=0.5)
                                hookCrossSection();
        }
}

module letter_holder()
{
    rotate([0,90,0])
    {
        // Letter Model
        if (0)
        for (i=[0:1:letter_slot_count-1])
            translate([0,-i*(letter_height*(1-letter_slot_overlap_percent)),0])
                rotate([10,0,0])
                    translate([0,letter_height/2,letter_thickness/2])
                        %cube([letter_width, letter_height, letter_thickness], center=true);

        // Base
        hull()
        {
            slot_base_length = letter_height*(1-letter_slot_overlap_percent);
            for (i=[0:1:letter_slot_count-1])
                translate([0,slot_base_length/2-i*slot_base_length,0])
                        cube([commandstrip_w, slot_base_length, base_thickness], center=true);
        }

        // Hooks
        spring_curve_thickness = base_thickness;
        for (i=[0:1:letter_slot_count-1])
            translate([0,-i*(letter_height*(1-letter_slot_overlap_percent)),spring_curve_thickness/2])
                    rotate([180,90,0])
                        hookHalfCurve(curve_thickness=spring_curve_thickness, curve_height=commandstrip_w);
    }
}

if (stack_printing_count > 0)
{
    // Multi Item Stacked Printing
    for (i=[0:1:stack_printing_count-1])
        translate([0, 0, i*(commandstrip_w+stack_printing_gap)])
            letter_holder();
}
else
{
    // Single Item 
    // (You will need to print twice so you can stablize the letter on the wall)
    letter_holder();
}
