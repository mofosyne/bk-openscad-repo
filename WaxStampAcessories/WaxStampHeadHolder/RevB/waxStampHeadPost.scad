use <lib/ISOThreadCust.scad>

$fn = 40;

// For the stamp holder
waxStamp_screw_shaft = 12;
waxStampHolderLength = 60;
waxStamp_metric_screw_dia = 8;
waxStamp_metric_shaft_length = 6.5;

// For stamp head
wax_stamp_head_diameter = 40;
wax_stamp_head_spacing  = 2;

// Number of heads
x_holder_count = 4;
y_holder_count = 4;

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
            cylinder(d1=waxStamp_metric_screw_dia*1.5+1, d2=waxStamp_metric_screw_dia+1,waxStamp_metric_shaft_length/3);
	    	translate([0,0,-0.1]) cylinder(r = waxStamp_metric_screw_dia/2, h =waxStamp_metric_shaft_length/2 + 0.2);
        }
        thread_in(waxStamp_metric_screw_dia,waxStamp_metric_shaft_length/2);
    }
}

module wax_stamp_grub()
{
    translate([0,0,waxStamp_metric_shaft_length/2])
        difference()
        {
            intersection()
            {
                translate([0,0,-waxStamp_metric_shaft_length/2])
                    union()
                    {
                        thread_out(waxStamp_metric_screw_dia,waxStamp_metric_shaft_length);
                        thread_out_centre(waxStamp_metric_screw_dia+0.5,waxStamp_metric_shaft_length);
                    }
                cube([waxStamp_metric_screw_dia, waxStamp_metric_screw_dia*0.8, waxStamp_metric_shaft_length], center=true);
            }
            // Screw Slot
            cutoutWidth = 1;
            cutoutLength = waxStamp_metric_shaft_length;
            translate([0,0,waxStamp_metric_shaft_length/2])
                cube([cutoutWidth,waxStamp_metric_screw_dia, cutoutLength], center=true);
            // Phillips head support (But opted not to use this, as it may reduce strength of this grub)
            if (0)
            hull()
            {
                translate([0,0,waxStamp_metric_shaft_length/2])
                    cube([waxStamp_metric_screw_dia/2, cutoutWidth, 0.01], center=true);
                translate([0,0,waxStamp_metric_shaft_length/3])
                    cube([waxStamp_metric_screw_dia/4, 0.01, 0.01], center=true);
            }
        }
}

rotate([90,0,0])
{
    wax_stamp_grub();
    %wax_stamp_screw(waxStamp_metric_screw_dia, waxStamp_metric_shaft_length);
}



