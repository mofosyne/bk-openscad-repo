use <lib/ISOThreadCust.scad>
use <waxStampHolder.scad>

$fn = 40;

// For the stamp holder
waxStamp_screw_shaft = 12;
waxStampHolderLength = 60;
waxStamp_metric_screw_dia = 8;
waxStamp_metric_shaft_length = 6.5;
waxStamp_holder_tol = 0.5;
waxStamp_holder_clipThickness = 3;
waxStamp_holder_clipLength = 15;

// For stamp head
wax_stamp_head_diameter = 40;
wax_stamp_head_spacing  = 2;

// Number of heads
x_holder_count = 4;
y_holder_count = 4;

holder_base_thickness = 1;


virtualHeadDia = wax_stamp_head_diameter +  wax_stamp_head_spacing;


module wax_stamp_screw(
                waxStamp_metric_screw_dia = 8,
                waxStamp_metric_shaft_length = 6.5)
{
    thread_out(waxStamp_metric_screw_dia,waxStamp_metric_shaft_length);
    thread_out_centre(waxStamp_metric_screw_dia,waxStamp_metric_shaft_length);
}

module wax_stamp_head_holder(
                waxStamp_screw_shaft = 12,
                waxStampHolderLength = 60)
{
    translate([0,0,0])
        wax_stamp_screw();
    %translate([0,0,10])
        cylinder(d=wax_stamp_head_diameter,h=1);
}

module wax_stamp_clip(
                screwShaft = 12,
                holderLength = 60,
                screwDia = 8,
                clipThickness =5)
{
    flatPrintRadius = (screwDia/2) - (5*(cos(30)*get_coarse_pitch(screwDia))/8);
    translate([0,0,flatPrintRadius])
    difference()
    {
        cube([holderLength-0.01, screwShaft+clipThickness, flatPrintRadius*2-0.01], center=true);
        rotate([0,90,0])
        intersection()
        {
            cylinder(d=screwShaft, holderLength, center=true);        
            translate([0,0,0])
                cube([flatPrintRadius*2, screwShaft, holderLength], center=true);
        }
    }
}

// Holder
for (i = [0:1:x_holder_count-1])
for (j = [0:1:y_holder_count-1])
{
    virtualHeadDia = wax_stamp_head_diameter +  wax_stamp_head_spacing;
    
    // Stamp Head Holder
    translate([virtualHeadDia/2+virtualHeadDia*i, virtualHeadDia/2+virtualHeadDia*j,1])
        wax_stamp_head_holder();

    if (0)
    {
        // Handle Clip
        translate([virtualHeadDia/2+virtualHeadDia*i, virtualHeadDia/2+virtualHeadDia*j+(waxStamp_screw_shaft+3),holder_base_thickness])
            wax_stamp_clip(
                    waxStamp_screw_shaft,
                    waxStamp_holder_clipLength,
                    waxStamp_metric_screw_dia + waxStamp_holder_tol,
                    waxStamp_holder_clipThickness);

        // Handle Clip
        translate([virtualHeadDia/2+virtualHeadDia*i, virtualHeadDia/2+virtualHeadDia*j-(waxStamp_screw_shaft+3),holder_base_thickness])
            wax_stamp_clip(
                    waxStamp_screw_shaft,
                    waxStamp_holder_clipLength,
                    waxStamp_metric_screw_dia + waxStamp_holder_tol,
                    waxStamp_holder_clipThickness);
    }
}

// Base
translate([0,0,0])
    cube([virtualHeadDia*x_holder_count,virtualHeadDia*y_holder_count, holder_base_thickness]);







