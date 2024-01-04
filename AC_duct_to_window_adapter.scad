$fn=50;

duct_width = 56;
duct_length = 168;
duct_rim = 5;
duct_rim_thickness = 2.5;
duct_tol = 1.0;

adaptor_base_thickness = 0.5;
adaptor_thickness = 1.0;

// Simpler code with same result
module roundedcube(xx, yy, height, radius, center=false, centerxy=false)
{
    translate([(center||centerxy)?-xx/2:0,(center||centerxy)?-yy/2:0,center?0:height/2])
    hull()
    {
        translate([radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,yy-radius,0])
        cylinder(height,radius,radius,true);

        translate([radius,yy-radius,0])
        cylinder(height,radius,radius,true);
    }
}

if (0)
% roundedcube(duct_length, duct_width, 0.8, 5, center=true);

union()
{
    difference()
    {
        cube([230, 110, 0.5], center = true);
        roundedcube(duct_length-duct_rim/2, duct_width-duct_rim/2, 1, 5, center=true);
    }
    difference()
    {
        hull()
        {
            roundedcube(duct_length+duct_rim+duct_tol+adaptor_thickness*2+5, duct_width+duct_rim+duct_tol+adaptor_thickness+5, 0.1, 5, centerxy=true);
            roundedcube(duct_length+duct_rim+duct_tol+adaptor_thickness*2+1, duct_width+duct_rim+duct_tol+adaptor_thickness+1, duct_rim_thickness+duct_tol+adaptor_thickness, 5, centerxy=true);
        }
        if (1)
        hull()
        {
            roundedcube(duct_length+duct_rim+duct_tol+2, duct_width+duct_rim+duct_tol+2, 0.1, 5, centerxy=true);
            roundedcube(duct_length+duct_rim+duct_tol, duct_width+duct_rim+duct_tol, duct_rim_thickness+duct_tol, 5, centerxy=true);
        }
        roundedcube(duct_length-5, duct_width-5, 10, 5, center=true);
        translate([(duct_length+duct_rim)/2,0,10/2])
            cube([duct_rim*2+10,duct_width+duct_rim+10,10],center=true);
    }
}
