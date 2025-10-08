// Screw Back Plane
// Brian Khuu 2025
// This allows for creating custom screw backplane that you often find in junction boxes etc...
// Found out that these junction boxes typically have screw size of M2 and screw pitch of 5mm
// At least based on https://www.aliexpress.com/item/1005009909495336.html

// Width
width=30;

// Length
length=30;

// Pitch
pitch=5;

// Screw Size
screwSize=2;

// Thickness
thickness=3;

module screwBackPlaneHoles(width, length, thickness=3, pitch=5, screwSize=2)
{
    xCount = floor(width/pitch)-1;
    yCount = floor(length/pitch)-1;
    xCalcWidth = xCount  * pitch + pitch/2;
    yCalcWidth = yCount * pitch + pitch/2;
    translate([-xCalcWidth/2,-yCalcWidth/2,0])
    translate([screwSize/2,screwSize/2,0])
    {
        for (xoffset = [0:1:xCount])
        for (yoffset = [0:1:yCount])
            translate([xoffset*5,yoffset*5,0])
                render()
                {
                    translate([0,0,thickness+0.5]) 
                        cube([screwSize+1,screwSize+1,1], center = true);
                    hull()
                    {
                        translate([0,0,thickness]) 
                            cube([screwSize+1,screwSize+1,0.01], center = true);
                        translate([0,0,0]) 
                            cube([screwSize,screwSize,0.01], center = true);
                    }
                    translate([0,0,-0.5]) 
                        cube([screwSize,screwSize,1], center = true);
                }
    } 
}

module screwBackPlane(width=67, length=117, pitch=5, screwSize=2, thickness=3)
{
    difference()
    {
        translate([0,0,thickness/2]) 
            cube([width, length, thickness], center=true);
        screwBackPlaneHoles(width=width, length=length, thickness=thickness, pitch=pitch, screwSize=screwSize);
    }
}

screwBackPlane(width=width, length=length, pitch=pitch, screwSize=screwSize, thickness=thickness);