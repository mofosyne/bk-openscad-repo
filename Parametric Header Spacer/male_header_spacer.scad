$fn = 100;

/* Spacer Settings */
x_count = 20;
y_count = 2;
spacer_height = 2.5;
tolerance = 0.5;

/* Currently Assuming Imperial Header Size */
header_width = 0.65;
header_length = 6;
header_spacing = 2.54;

module header_spacer(x_count, y_count, spacer_height, header_width, header_length, header_spacing, tolerance)
{
    module female_header_req(hw, hl, sh, tol)
    {
        union()
        {
            #translate([-(hw+tol)/2,-(hw+tol)/2,-1])
                cube([hw+tol,hw+tol,sh+2]);
            
            /* Male Header Visualisation */
            %union()
            {
                translate([-(hw)/2,-(hw)/2,-3-2.5]) color("grey")
                    cube([hw,hw,hl+3+2.5]);
                translate([0,0,-(header_spacing)/2])
                    cube([header_spacing,header_spacing,(2.5)],  center=true);
            }
        }
    }
    
    difference()
    {
        /* Spacer */
        translate([header_spacing/2, header_spacing/2, 0]) 
            cube([header_spacing*x_count,header_spacing*y_count,spacer_height]);
        
        /* Cutout */
        for ( xi = [1 : 1 : x_count] )
        for ( yi = [1 : 1 : y_count] )
        translate([header_spacing*xi, header_spacing*yi, 0]) 
        female_header_req(header_width, header_length, spacer_height, tolerance);

    }
}

header_spacer(x_count, y_count, spacer_height, header_width, header_length, header_spacing, tolerance);

