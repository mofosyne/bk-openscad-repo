// Command Strip Parametric Cup Clip
// Brian Khuu 2023 June

$fn = 40;

/* [Holder Spec] */
handle_count = 1;
handle_spacing = 70;

/* [Handle Spec] */
handle_diameter = 55; // small glass cup = 39, larger glass cup = 59
handle_offset = 0;
handle_tol = 0.5;

/* [Mount Screw Spec] */
screw_enable = true;
screw_hole_size = 2;
screw_hole_tol = 0.1;

/* [Mount Base Spec] */
mount_base_thickness = 2;
mount_base_length = handle_spacing*handle_count+screw_hole_size*2+5; // Command strips lengths: 30mm, 60mm
mount_base_height = 15;

/* [Mount Tab Spec] */
mount_tab_enable = false;
mount_tab_length = 20;
mount_tab_thickness = 0.6;

/* [Mount Curve Spec] */
curve_thickness = 2.5;
curve_height = mount_base_height;


module hookCrossSection()
{
    square(size = [curve_thickness, curve_height], center = true);
}

module hookHalfCurve(majorcurve_radius, flange_radius)
{
    majorcurve_angle = 90+30+10;
    flange_angle = 140;
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


module hookClip()
{
    clip_shift_offset = curve_thickness + handle_offset;
    hook_diameter = handle_diameter + handle_tol;
    majorcurve_radius = hook_diameter/2;
    flange_radius = hook_diameter/6;
    union()
    {
        // Hook
        translate([-clip_shift_offset,0,0])
            union()
            {
                hookHalfCurve(majorcurve_radius, flange_radius);
                mirror([0,1,0])
                    hookHalfCurve(majorcurve_radius, flange_radius);
            }
        // Spacer
        translate([-clip_shift_offset/2,0,0])
            cube([clip_shift_offset,curve_thickness,curve_height], center=true);
    }
    // Sanity check that the handle fits
    if (0)
    translate([-clip_shift_offset-handle_diameter/2,0,0])
        %cylinder(d=handle_diameter, h=mount_base_height+10, center=true);
}

union()
{
    translate([0,-((handle_count-1)*handle_spacing)/2,0])    
        for (i = [0 : 1 : handle_count-1])
        {
            translate([0,i*handle_spacing,0])
                hookClip();
        }
    difference()
    {
        rotate([0,0,-90])
            cube([mount_base_length, mount_base_thickness, curve_height], center=true);

        translate([0,-((handle_count-1)*handle_spacing)/2,0])    
            for (i = [0 : 1 : handle_count-1])
            {
                translate([0,i*handle_spacing+handle_spacing/2,0])
                    rotate([0,90,0])
                        cylinder(r=screw_hole_size/2+screw_hole_tol, h=mount_base_thickness+0.2, center=true);
                translate([0,i*handle_spacing-handle_spacing/2,0])
                    rotate([0,90,0])
                        cylinder(r=screw_hole_size/2+screw_hole_tol, h=mount_base_thickness+0.2, center=true);
            }        translate([0,-((handle_count-1)*handle_spacing)/2,0])    
        %for (i = [0 : 1 : handle_count-1])
            {
                translate([0,i*handle_spacing+handle_spacing/2,0])
                    rotate([0,90,180])
                        cylinder(r=0.1, h=100);
                translate([0,i*handle_spacing-handle_spacing/2,0])
                    rotate([0,90,180])
                        cylinder(r=0.1, h=100);
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
