/**********************************************************\
*                                                          *
*  IDC-Socket Adaptor for Female Headers                   *
*  by Mose                                                 *
*  http://www.thingiverse.com/mose                         *
*  build after datasheets for                              *
*   - MPE-Garry 094 series female header                   *
*   - Amtek Technology IDC1 series IDC socket              *
*                                                          *
\**********************************************************/
/*
    Remixed By Brian Khuu to take into account 
*/
$fn=20;

// Accounting for FDM printer inaccuracy
nozzledia = 0.5;

// pin count; change to match your header
PINS   = 10;
HEIGHT = 14;

// IDC Specs
idc_depth=6.5;

module cube_rounded(size, radius=0)
{ // Round corners for Openscad - By WilliamAAdams Jun 15, 2011 (But adjusted to always fit within the xyz size)
    x = size[0];
    y = size[1];
    z = size[2];
    if (radius > 0)
    {
        linear_extrude(height=z)
        hull()
        { // place 4 circles in the corners, with the given radius
            translate([(-x/2)+(radius), (-y/2)+(radius), 0])
                circle(r=radius);
            translate([(x/2)-(radius), (-y/2)+(radius), 0])
                circle(r=radius);
            translate([(-x/2)+(radius), (y/2)-(radius), 0])
                circle(r=radius);
            translate([(x/2)-(radius), (y/2)-(radius), 0])
                circle(r=radius);
        }
    }
    else
    {
        translate([0,0,z/2])
            cube([x,y,z], center=true);
    }
}

// don't change below
PW = (PINS/2-1)*2.54;

difference(){
	union(){
        difference()
        { // Side Locks
            cube_rounded([7.3+PW, 6, HEIGHT],radius=1);
            translate([0,0,-1])
              cube_rounded([3.35+PW, 7, HEIGHT+2], radius=0);
        }
        
        // Tab
	    translate([0,1.5,0])
	        cube_rounded([3.5, 6.5, HEIGHT],radius=1);

        // Bottom Base
        cube_rounded([7.3+PW, 5.5+2*nozzledia, HEIGHT-idc_depth],radius=1);
	}

    // Hole
    translate([0,0,-1])
        cube_rounded([3.35+PW, 5.5, HEIGHT+2], radius=0);

    // Side Tab
    hull()
    {
        translate([0,0,HEIGHT-idc_depth/2])
            cube_rounded([7.3+PW-1.5, 6-1.5, HEIGHT+2],radius=0.5);
        translate([0,0,HEIGHT-idc_depth])
            cube_rounded([3.35+PW, 6-1.5, 1], radius=0);
    }
    // Tab
    translate([0,1.5,-1])
        cube_rounded([3.5-1.5, 6.5-1.5, HEIGHT+2],radius=0.5);
}

echo((6-5.5));