use <lib/ISOThreadCust.scad>

waxStamp_screw_shaft = 12;
waxStampHolderLength = 60;
waxStamp_metric_screw_dia = 8;
waxStamp_metric_shaft_length = 6.5;

module wax_stamp_screw(
                screwDia = 8,
                shaftLength = 6.5)
{
    thread_out(screwDia,shaftLength);
    thread_out_centre(screwDia,shaftLength);
}

module wax_stamp_handle(
                screwShaft = 12,
                holderLength = 60,
                screwDia = 8,
                shaftLength = 6.5)
{
    flatPrintRadius = (screwDia/2) - (5*(cos(30)*get_coarse_pitch(screwDia))/8);
    intersection()
    {
        rotate([0,90,0])
        union()
        {
            translate([0,0,holderLength-1])
                wax_stamp_screw(screwDia, shaftLength+1);
            thread_out_centre(screwDia,holderLength);
            cylinder(d=screwShaft, holderLength-2);
        }        
        translate([(holderLength+shaftLength)/2,0,0])
            cube([(holderLength+shaftLength), screwShaft, flatPrintRadius*2], center=true);
    }
}

wax_stamp_handle(
        waxStamp_screw_shaft,
        waxStampHolderLength,
        waxStamp_metric_screw_dia,
        waxStamp_metric_shaft_length
    );