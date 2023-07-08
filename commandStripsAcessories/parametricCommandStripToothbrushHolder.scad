// Command Strip Parametric Broom Handle Clip
// Brian Khuu 2023 June

$fn = 40;

/* [Handle Spec] */
handle_diameter = 6; // Toothbrush handle measured 6mm so add a bit of tolerance
handle_offset = 5;
handle_tol = 0.5; // Toothbrush handle measured 6mm so add a bit of tolerance

/* [Mount Base Spec] */
mount_base_thickness = 1;
mount_tab_length = 20;
mount_tab_thickness = 0.6;
mount_base_length = 30;
mount_base_height = 15;

/* [Mount Curve Spec] */
curve_thickness = 1.5;
curve_height = mount_base_height;

module hookCrossSection()
{
    square(size = [curve_thickness, curve_height], center = true);
}

module hookHalfCurve(hook_diameter, flange_radius)
{
    majorcurve_radius = hook_diameter/2;
    majorcurve_angle = 90+30;
    flange_radius = hook_diameter/2+3;
    flange_angle = 80;
    
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


module hookToothbrush()
{
    hook_diameter = handle_diameter + handle_tol;
    flange_radius = hook_diameter/2+3;
    union()
    {
        translate([-handle_offset,0,0])
            union()
            {
                hookHalfCurve(hook_diameter, flange_radius);
                mirror([0,1,0])
                    hookHalfCurve(hook_diameter, flange_radius);
            }
        translate([-handle_offset/2,0,0])
            cube([handle_offset,curve_thickness,curve_height], center=true);
        if (1)
        {
            stablizer_h = 5;
            difference()
            {
                translate([-handle_offset-(hook_diameter)/2,0,mount_base_height/2])
                    cylinder(d=hook_diameter+curve_thickness*2, h=stablizer_h);
                translate([-handle_offset-(hook_diameter)/2,0,mount_base_height/2-0.5])
                    cylinder(d=hook_diameter, h=stablizer_h+1);
                hull()
                {
                    translate([-handle_offset-(hook_diameter)/2-curve_thickness,0,mount_base_height/2+stablizer_h/2+stablizer_h])
                        cube([hook_diameter+curve_thickness*2,hook_diameter+curve_thickness*2,stablizer_h], center=true);
                    translate([-handle_offset-hook_diameter-curve_thickness,0,mount_base_height/2+stablizer_h/2-0.1])
                        cube([hook_diameter+curve_thickness*2,hook_diameter+curve_thickness*2,stablizer_h], center=true);
                }
            }
        }
    }
    translate([-handle_offset-handle_diameter/2,0,0])
        %cylinder(d=handle_diameter, h=mount_base_height+10, center=true);
}

union()
{
    hookToothbrush();
    rotate([0,0,-90])
        cube([mount_base_length, mount_base_thickness, curve_height], center=true);
    translate([-(mount_base_thickness-mount_tab_thickness)/2,mount_base_length/2+mount_tab_length/2,0])
        rotate([0,0,-90])
            cube([mount_tab_length, mount_tab_thickness, curve_height], center=true);
    translate([-(mount_base_thickness-mount_tab_thickness)/2,-(mount_base_length/2+mount_tab_length/2),0])
        rotate([0,0,-90])
            cube([mount_tab_length, mount_tab_thickness, curve_height], center=true);
}
