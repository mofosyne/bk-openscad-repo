$fn=30;

/*
  Wanhao Duplicator i3 or Cocoon Create Plus Tool Holder (OpenSCAD) Rev3
  Author: Brian Khuu (2020)
  
  This revision adds 4 slots for 4 full sized sdcards.
  Rev 2 tried microsd but found its not easy to maintain size
*/

// Hole
xhole=5;
zhole=10;
metal_thickness=2;

// Tool Holder
metal_stick_dia=1.5;
hook_length=35;
hook_dia=6;
hole_tol=1;
hex_dias=[metal_stick_dia,1.6,2.2,2.5,3,4];

xtweezer=5;
ytweezer=12;

// Caddy
xcaddy=xtweezer+7;
ycaddy=50;

// Secondary Caddy
xScaddy=50;

function sumv(v, maxi, i=0) = (maxi > i) ? v[i] + sumv(v, maxi, i+1) : 0;

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

module handlesSide(ypos)
{
    translate([0,0,hook_dia/2])
    union()
    {
        translate([0,ypos,0])
            rotate([0,90,0])
                cylinder(r=hook_dia/2,h=hook_length);
        hull()
        {
            translate([hook_length,ypos,0])
                sphere(r=hook_dia/2);
            translate([hook_length+5,ypos,3])
                sphere(r=hook_dia/4);
        }
    }
}


difference()
{
    union()
    {
        // Hole Slot
        translate([0,ycaddy*1/4,0])
            cube([xhole,ycaddy*3/4,zhole]);
        translate([0,ycaddy/4,zhole/2])
            rotate([0,90,0])
                cylinder(r=zhole/2,h=xhole);
        translate([0,ycaddy,zhole/2])
            rotate([0,90,0])
                cylinder(r=zhole/2,h=(xhole+metal_thickness+xcaddy));

        // Holder bump
        translate([zhole/2-1/4,ycaddy/2+1,0])
                cylinder(r=1/2,h=zhole);
        
        /* Main Caddy */
        // Caddy
        translate([xhole+metal_thickness,0,0])
            cube([xcaddy,ycaddy,zhole]);
        translate([xhole+metal_thickness,0,zhole/2])
            rotate([0,90,0])
                cylinder(r=zhole/2,h=xcaddy);

        // Handle
        handles(0);
        handles(ycaddy/2);
        handles(ycaddy);
        
        /* Secondary Caddy */
        translate([metal_thickness+xcaddy,0,0])
        {
            // Caddy
            translate([-xScaddy,ycaddy,zhole/2])
                rotate([0,90,0])
                    cylinder(r=zhole/2,h=(xScaddy));
                    
            // Handle
            translate([(metal_thickness),ycaddy,0])
                rotate([0,0,90])
                {
                    handlesSide(0);
                    handlesSide(xScaddy/2);
                    handlesSide(xScaddy);
                }
                
            translate([-xScaddy,ycaddy,zhole/2])
                sphere(r=zhole/2);
        }
    }

    // Tweezer
    translate([xhole+metal_thickness+xcaddy-xtweezer-1.5,ycaddy-ytweezer-zhole/4,-0.1])
        cube([xtweezer,ytweezer,zhole+0.2]);



    // Hex
    for(yi=[0:1:len(hex_dias)-1])
    {
        translate([xhole+metal_thickness+xcaddy-4,sumv(hex_dias,yi)+4*yi,-1])
            cylinder(r=hex_dias[yi]/2+hole_tol/2,h=100);
    }
  
    /* SD Card Holder */
    //sdcardT=1.4 + 0.4; // Actual Mini SD Thickness: 1.4mm
    //sdcardW=11 + 1.5; // Actual Mini SD Width: 11mm
    //sdcardL=15; // Actual Mini SD Width: 11mm
    sdcardT=2.08 + 0.2; // Actual Mini SD Thickness: 2.08mm
    sdcardW=24.13 + 0.4; // Actual Mini SD Width: 24.13mm
    sdcardL=15; // Actual Mini SD Width: 32mm  
    
    translate([0,-0.5,0])
    {        
        translate([xhole+metal_thickness+1.5,zhole/4-4,zhole-sdcardL/2])
            cube([sdcardT,sdcardW,sdcardL]);
        translate([xhole+metal_thickness+1.5,zhole/4+sdcardW-2.5,zhole-sdcardL/2])
            cube([sdcardT,sdcardW,sdcardL]);   
    }
   
    translate([xcaddy+metal_thickness*2-1,ycaddy,0])
    {
        rotate([0,0,90])
        {
            translate([0,zhole/4-4,zhole-sdcardL/2])
                cube([sdcardT,sdcardW,sdcardL]);
            translate([0,zhole/4+sdcardW-2,zhole-sdcardL/2])
                cube([sdcardT,sdcardW,sdcardL]);   
            
        }
    }
}