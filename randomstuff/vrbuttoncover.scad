/*
    Button cover for a VR headset
*/

$fn=100;

button_dia=9;
button_thickness=1;
button_spacing=(13+9);

button_cover_thickness=1;
button_cover_standoff=1;
button_cover_pen_access=5;

button_hole_enable=false;

module button_model()
{
   translate([button_spacing/2,0,0])
        cylinder(
                r=button_dia/2,
                h=button_thickness
            );
   translate([-button_spacing/2,0,0])
        cylinder(
                r=button_dia/2,
                h=button_thickness
            );
}

module bulk(thickness)
{
    hull()
    {
        translate([button_spacing/2,0,0])
            cylinder(
                    r1=button_dia/2+0.1+thickness,
                    r2=button_dia/2+thickness,
                    h=button_thickness+thickness
                );
        translate([-button_spacing/2,0,0])
            cylinder(
                    r1=button_dia/2+0.1+thickness,
                    r2=button_dia/2+thickness,
                    h=button_thickness+thickness
                );
    }
}

module rounder_bulk_cut(thickness)
{
    intersection()
    {
        union()
        {
            hull()
            {
                translate([button_spacing/2,0,0])
                    sphere( r=button_dia/2+thickness);
                translate([button_spacing/2-2,0,0])
                    sphere( r=button_dia/2+thickness);
            }
            hull()
            {
                translate([-button_spacing/2,0,0])
                    sphere( r=button_dia/2+thickness);
                translate([-button_spacing/2+2,0,0])
                    sphere( r=button_dia/2+thickness);
            }
        }
        translate([0,0,(button_thickness+thickness)/2])
            cube([1000,1000,button_thickness+thickness], center=true);
    }
}

module rounder_bulk(thickness)
{
    intersection()
    {
        hull()
        {
            translate([button_spacing/2,0,0])
                sphere( r=button_dia/2+thickness);
            translate([-button_spacing/2,0,0])
                sphere( r=button_dia/2+thickness);
        }
        translate([0,0,(button_thickness+thickness)/2])
            cube([1000,1000,button_thickness+thickness], center=true);
    }
}

module rounder_bulk_sides(thickness, extended)
{
    intersection()
    {
        hull()
        {
            translate([(button_spacing+extended)/2,0,0])
                sphere( r=button_dia/2 );
            translate([-(button_spacing+extended)/2,0,0])
                sphere( r=button_dia/2 );
        }
        translate([0,0,(thickness)/2])
            cube([1000,1000,thickness], center=true);
    }
}

/* Button Cover Main Design */
%button_model();

difference()
{
    union()
    {
        rounder_bulk(button_cover_standoff+button_cover_thickness);
        rounder_bulk_sides(0.4,20);
    }
    translate([0,0,-0.001])
        rounder_bulk_cut(button_cover_standoff);
    
    if (button_hole_enable)
    {
        translate([button_spacing/2,0,0])
          cylinder(r=button_cover_pen_access/2,h=100);
        translate([-button_spacing/2,0,0])
          cylinder(r=button_cover_pen_access/2,h=100);
    }
    
}