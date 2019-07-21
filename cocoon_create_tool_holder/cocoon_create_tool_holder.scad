$fn=30;

/*
  Wanhao Duplicator i3 or Cocoon Create Plus Tool Holder (OpenSCAD)
  Author: Brian Khuu (2019)
*/

// Hole
xhole=5;
zhole=10;
metal_thickness=2;

// Tool Holder
hook_length=20;
hook_dia=6;
hole_tol=1;
hex_dias=[1.6,2.2,2.5,3,4];
metal_stick_dia=1.5;

xtweezer=5;
ytweezer=12;

// Caddy
xcaddy=xtweezer+6;
ycaddy=50;


module handles(ypos)
{
    translate([0,0,hook_dia/2])
    union()
    {
        translate([xhole+metal_thickness+xcaddy,ypos,0])
            rotate([0,90,0])
                cylinder(r=hook_dia/2,h=hook_length);
        hull()
        {
            translate([xhole+metal_thickness+xcaddy+hook_length,ypos,0])
                sphere(r=hook_dia/2);
            translate([xhole+metal_thickness+xcaddy+hook_length+5,ypos,3])
                sphere(r=hook_dia/4);
        }
    }
}


module twist_handle(ypos)
{
    twist_dia=9;
    twist_depth=10;
    difference()
    {
        translate([0,0,twist_dia/3])
        union()
        {
            translate([xhole+metal_thickness+xcaddy,ypos,0])
                rotate([0,90,0])
                    cylinder(r=twist_dia/2,h=twist_depth);
            translate([xhole+metal_thickness+xcaddy+twist_depth,ypos,0])
                sphere(r=twist_dia/2+0.2);
        }
        
        translate([0,ypos,0])
            cube([100,twist_dia/3,100],center=true);
        translate([0,0,-100/2])
            cube([100,100,100],center=true);
    }
}

difference()
{
    union()
    {
        // Hole Slot
        translate([0,ycaddy/2,0])
            cube([xhole,ycaddy/2,zhole]);
        translate([0,ycaddy/2,zhole/2])
            rotate([0,90,0])
                cylinder(r=zhole/2,h=xhole);
        translate([0,ycaddy,zhole/2])
            rotate([0,90,0])
                cylinder(r=zhole/2,h=(xhole+metal_thickness+xcaddy));

        // Holder bump
        translate([zhole/2-1/4,ycaddy/2+1,0])
                cylinder(r=1/2,h=zhole);

        // Caddy
        translate([xhole+metal_thickness,0,0])
            cube([xcaddy,ycaddy,zhole]);
        translate([xhole+metal_thickness,0,zhole/2])
            rotate([0,90,0])
                cylinder(r=zhole/2,h=xcaddy);

        // Handle
        handles(0);
        handles(ycaddy);
        
        twist_handle(ycaddy/2);
    }

    // Tweezer
    translate([xhole+metal_thickness+4,ycaddy-ytweezer-zhole/4,-0.1])
        cube([xtweezer,ytweezer,zhole+0.2]);

    // Wire Holder
    translate([xhole+metal_thickness+3,zhole/4,-1])
        cylinder(r=metal_stick_dia/2+hole_tol/2,h=100);

    // Hex
    for(yi=[0:1:len(hex_dias)-1])
    {
        translate([xhole+metal_thickness+4+xtweezer/2,zhole/4+7*yi,-1])
            cylinder(r=hex_dias[yi]/2+hole_tol/2,h=100);
    }
   
}