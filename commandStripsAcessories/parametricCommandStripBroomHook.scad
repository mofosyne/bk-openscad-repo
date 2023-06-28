// Command Strip Parametric Broom Handle Clip
// Brian Khuu 2023 June

$fn = 40;

curve_thickness = 2.5;
curve_height = 15;
majorcurve_radius = 30/2;
majorcurve_angle = 90+30;
minicurve_radius = majorcurve_radius/2;
minicurve_angle = 80;

module hookCrossSection()
{
    minkowski()
    {
        square(size = [curve_thickness, curve_height], center = true);
        circle(r=0.5);
    }
}

module hookHalfCurve()
{
    translate([-majorcurve_radius,0,0])
    union()
    {
        // Major Curve
        rotate_extrude(angle = majorcurve_angle) 
            translate([majorcurve_radius+curve_thickness/2, 0, 0])
                hookCrossSection();
        // Mini Curve
        rotate([0,0,-180+majorcurve_angle])
        translate([-majorcurve_radius-minicurve_radius-curve_thickness/2,0,0])
        rotate_extrude(angle = -minicurve_angle) 
            translate([minicurve_radius, 0, 0])        
                hookCrossSection();
        // Mini Curve
        rotate([0,0,-180+majorcurve_angle])
        translate([-majorcurve_radius-minicurve_radius-curve_thickness/2,0,0])
            rotate([0,0,-minicurve_angle])
                translate([minicurve_radius, 0, 0])
                    rotate([90,0,0])
                        linear_extrude(height=1, scale=0.5)
                            hookCrossSection();
    }
}

union()
{
    hookHalfCurve();
    mirror([0,1,0])
        hookHalfCurve();
    
    minkowski()
    {
        translate([curve_thickness/2,0,0])
            rotate([0,0,-90])
                cube([30, curve_thickness, curve_height], center=true);
        sphere(r=0.5);
    }
}
