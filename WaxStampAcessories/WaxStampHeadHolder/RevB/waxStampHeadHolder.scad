use <lib/ISOThreadCust.scad>

$fn = 40;

// For the stamp holder
waxStamp_screw_shaft = 12;
waxStampHolderLength = 60;
waxStamp_metric_screw_dia = 8;
waxStamp_metric_shaft_length = 6.5;

// For stamp head
wax_stamp_head_diameter = 25; // 25mm, 30mm
wax_stamp_head_spacing  = 5;

// Number of heads
x_holder_count = 3;
y_holder_count = 3;

holder_base_thickness = 1.0;


virtualHeadDia = wax_stamp_head_diameter +  wax_stamp_head_spacing;


module wax_stamp_screw(
                waxStamp_metric_screw_dia = 8,
                waxStamp_metric_shaft_length = 6.5)
{
    union()
    {
        difference()
        {
            cylinder(d1=waxStamp_metric_screw_dia*1.5+1, d2=waxStamp_metric_screw_dia+1,waxStamp_metric_shaft_length/2);
	    	translate([0,0,-0.1]) cylinder(r = waxStamp_metric_screw_dia/2, h =waxStamp_metric_shaft_length/2 + 0.2);
        }
        thread_in(waxStamp_metric_screw_dia,waxStamp_metric_shaft_length/2);
    }
}

module wax_stamp_head_holder(
                waxStamp_screw_shaft = 12,
                waxStampHolderLength = 60)
{
    translate([0,0,0])
        wax_stamp_screw(waxStamp_metric_screw_dia, waxStamp_metric_shaft_length);
    %translate([0,0,10])
        cylinder(d=wax_stamp_head_diameter,h=1);
}

// Holder
for (i = [0:1:x_holder_count-1])
for (j = [0:1:y_holder_count-1])
{
    virtualHeadDia = wax_stamp_head_diameter +  wax_stamp_head_spacing;

    // Stamp Head Holder
    translate([virtualHeadDia/2+virtualHeadDia*i, virtualHeadDia/2+virtualHeadDia*j,holder_base_thickness])
        wax_stamp_head_holder(waxStamp_screw_shaft, waxStampHolderLength);
}

// Base
translate([0,0,0])
    cube([virtualHeadDia*x_holder_count,virtualHeadDia*y_holder_count, holder_base_thickness]);







