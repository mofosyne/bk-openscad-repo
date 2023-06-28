// Command Strip Parametric Broom Handle Clip
// Brian Khuu 2023 June

$fn = 40;

/* [Handle Spec] */
handle_diameter = 25;
handle_offset = 10;

/* [Mount Screw Spec] */
handle_screw_enable = true;
handle_screw_hole = 3; // M3 thread = 3mm
handle_screw_head = 5.6; // M3 head = 5.6mm
screw_head_tol = 0.5;

/* [Mount Base Spec] */
mount_base_thickness = 1;
mount_base_length = 30;
mount_base_height = 15;

/* [Mount Curve Spec] */
curve_thickness = 2.1;
curve_height = mount_base_height;

/* [Calc] */
majorcurve_radius = handle_diameter/2;
majorcurve_angle = 90+30;
minicurve_radius = majorcurve_radius/2;
minicurve_angle = 80;
smoothing = 0.5;

module hookCrossSection()
{
    minkowski()
    {
        square(size = [curve_thickness-smoothing*2, curve_height-smoothing*2], center = true);
        circle(r=smoothing);
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
            // Mini Curve Cap
            rotate([0,0,-180+majorcurve_angle])
            translate([-majorcurve_radius-minicurve_radius-curve_thickness/2,0,0])
                rotate([0,0,-minicurve_angle])
                    translate([minicurve_radius, 0, 0])
                        rotate([90,0,0])
                            linear_extrude(height=1, scale=0.5)
                                hookCrossSection();
        }  
}

difference()
{
    // Hook
    difference()
    {
        union()
        {
            translate([-handle_offset,0,0])
            {
                hookHalfCurve();
                mirror([0,1,0])
                    hookHalfCurve();
            }
            minkowski()
            {
                translate([-handle_offset/2+smoothing,0,0])
                    cube([handle_offset-smoothing*2,curve_thickness-smoothing*2,curve_height-smoothing*2], center=true);
                sphere(r=smoothing);
            }
            minkowski()
            {
                rotate([0,0,-90])
                    cube([mount_base_length-smoothing*2, mount_base_thickness, curve_height-smoothing*2], center=true);
                sphere(r=smoothing);
            }
            if (handle_screw_enable)
            {
                translate([-(0.1+smoothing*2)/2-(handle_offset-smoothing*2)/2,0,0])
                    rotate([0,90,0])
                        cylinder(r=(handle_screw_head+curve_thickness)/2+screw_head_tol, h=handle_offset-smoothing*2, center=true);
            }            
        }
        if (handle_screw_enable)
        {
            translate([-(0.1+smoothing*2)/2-(handle_offset+smoothing*2)/2+0.001,0,0])
                rotate([0,90,0])
                    cylinder(r=(handle_screw_head)/2+screw_head_tol, h=handle_offset+smoothing*2, center=true);
            rotate([0,90,0])
                cylinder(r=handle_screw_hole/2, h=smoothing*2+mount_base_thickness, center=true);
        }
    }
}
