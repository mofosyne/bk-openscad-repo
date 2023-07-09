// Command Strip Parametric Broom Handle Clip
// Brian Khuu 2023 June

$fn = 40;

/* [Holder Spec] */
handle_count = 3;
handle_spacing = 40;

/* [Handle Spec] */
handle_diameter = 6; // Toothbrush handle measured 6mm so add a bit of tolerance
handle_offset = 5;
handle_tol = 0.5; // Toothbrush handle measured 6mm so add a bit of tolerance

/* [Mount Base Spec] */
mount_base_thickness = 1.5;
mount_base_length = 130; // Command strips lengths: 30mm, 60mm
mount_base_height = 15;

/* [Mount Tab Spec] */
mount_tab_enable = false;
mount_tab_length = 20;
mount_tab_thickness = 0.6;

/* [Mount Curve Spec] */
curve_thickness = 1.5;
curve_height = mount_base_height;

/* [Mount Screw Spec] */
screw_enable = true;
screw_hole_size = 2;
screw_hole_tol = 0.1;

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
        // Hook
        translate([-handle_offset,0,0])
            union()
            {
                hookHalfCurve(hook_diameter, flange_radius);
                mirror([0,1,0])
                    hookHalfCurve(hook_diameter, flange_radius);
            }
        // Spacer
        translate([-handle_offset/2,0,0])
            cube([handle_offset,curve_thickness,curve_height], center=true);
       // Toothbrush stablizer
        difference()
        {
            stablizer_h = 5;
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
    // Sanity check that the handle fits
    if (0)
    translate([-handle_offset-handle_diameter/2,0,0])
        %cylinder(d=handle_diameter, h=mount_base_height+10, center=true);
}

union()
{
    translate([0,-((handle_count-1)*handle_spacing)/2,0])    
        for (i = [0 : 1 : handle_count-1])
        {
            translate([0,i*handle_spacing,0])
                hookToothbrush();
        }
    difference()
    {
        rotate([0,0,-90])
            cube([mount_base_length, mount_base_thickness, curve_height], center=true);

        #translate([0,-((handle_count-1)*handle_spacing)/2,0])    
            for (i = [0 : 1 : handle_count-1])
            {
                translate([0,i*handle_spacing+handle_spacing/2,0])
                    rotate([0,90,0])
                        cylinder(r=screw_hole_size/2+screw_hole_tol, h=mount_base_thickness+0.2, center=true);
                translate([0,i*handle_spacing-handle_spacing/2,0])
                    rotate([0,90,0])
                        cylinder(r=screw_hole_size/2+screw_hole_tol, h=mount_base_thickness+0.2, center=true);
            }
        
    }
    if (mount_tab_enable)
    {
        translate([-(mount_base_thickness-mount_tab_thickness)/2,mount_base_length/2+mount_tab_length/2,0])
            rotate([0,0,-90])
                cube([mount_tab_length, mount_tab_thickness, curve_height], center=true);
        translate([-(mount_base_thickness-mount_tab_thickness)/2,-(mount_base_length/2+mount_tab_length/2),0])
            rotate([0,0,-90])
                cube([mount_tab_length, mount_tab_thickness, curve_height], center=true);
    }
}
