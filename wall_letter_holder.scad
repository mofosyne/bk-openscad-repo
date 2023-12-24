$fn = 40;




letter_width = 220;
letter_height = 110;
letter_thickness = 5;

letter_slot_count = 2;

/* [Command Strip] */

// Command Strip Width
commandstrip_w = 16; // 16mm width strip, but cut in half

// Command Strip Height (Not including the pull tab)
commandstrip_h = 50;

// Command Strip Thickness
commandstrip_thickness = 1.0;

/* model spec */
spring_curve_thickness = 0.8;

module hookHalfCurve(
    majorcurve_radius = 5, 
    flange_radius = 5,
    majorcurve_angle = 265, 
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

rotate([0,90,0])
{
    // Letter Model
    if (1)
    for (i=[0:1:letter_slot_count-1])
        translate([0,-i*(letter_height*2/3),0])
            rotate([10,0,0])
                translate([0,letter_height/2,letter_thickness/2])
                    %cube([letter_width, letter_height, letter_thickness], center=true);

    // Base
    base_thickness = 0.8;
    //hull()
    {
        for (i=[0:1:letter_slot_count-1])
            translate([0,-i*(letter_height*2/3),0])
                translate([0,letter_height*1/3,0])
                    cube([commandstrip_w, letter_height*2/3, base_thickness], center=true);
    }

    for (i=[0:1:letter_slot_count-1])
        translate([0,-i*(letter_height*2/3),spring_curve_thickness/2])
                rotate([180,90,0])
                    hookHalfCurve(curve_thickness=spring_curve_thickness, curve_height=commandstrip_w);
}