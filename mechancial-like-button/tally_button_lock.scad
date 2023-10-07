$fn=50;
screw_hole=2;
screw_shaft_depth=0.2;
screw_head_dia=4;
screw_head_depth=1;

screw_spacing = 31;
reset_rotor_spacing = 10;
reset_rotor_dia = 14;
reset_rotor_upper_dia = 10;
reset_rotor_height = 10;
reset_rotor_cover_thickness = 1;

difference()
{
    union()
    {
        base_thickness = screw_shaft_depth+screw_head_depth;
        linear_extrude(height = base_thickness)
            hull()
            {
                translate([-screw_spacing/2,0,0])
                    circle(d=screw_head_dia+1);
                translate([screw_spacing/2,0,0])
                    circle(d=screw_head_dia+1);
                translate([0,reset_rotor_spacing,0])
                    circle(d=reset_rotor_dia+reset_rotor_cover_thickness*2);
            }

        translate([0,reset_rotor_spacing,base_thickness])
            cylinder(d1=reset_rotor_dia+reset_rotor_cover_thickness*2, d2=reset_rotor_upper_dia+reset_rotor_cover_thickness*2, h=reset_rotor_height-base_thickness+1);
    }

    translate([0,reset_rotor_spacing,-0.1])
        cylinder(d1=reset_rotor_dia, d2=reset_rotor_upper_dia, h=reset_rotor_height);

    translate([-screw_spacing/2,0,-0.01])
        cylinder(d=screw_hole, h=screw_shaft_depth);
    translate([screw_spacing/2,0,-0.01])
        cylinder(d=screw_hole, h=screw_shaft_depth);
    translate([-screw_spacing/2,0,screw_shaft_depth-0.05])
        cylinder(d1=screw_hole,d2=screw_head_dia, h=screw_head_depth+0.1);
    translate([screw_spacing/2,0,screw_shaft_depth-0.05])
        cylinder(d1=screw_hole,d2=screw_head_dia, h=screw_head_depth+0.1);
}