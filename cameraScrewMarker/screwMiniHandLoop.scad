use <lib/ISOThread.scad>
// Hand Twistable Loop

// Typical camera mounts are 3/4 inch or 1/4 inch
screwDia=6.35-0.25; // 6.35mm == 1/4 inch
screwLen=6;
screwWasherThickness=2;
screwWasherDiameter=screwDia+4;

flagLabel=10;
flagHead=3.5;
flagWidth=30;

loopCutHeight=2.5;
loopCutWidth=loopCutHeight*2;

layerHeight=0.3;

rotate([-90,0,0])
intersection()
{
    screwFlatCut=screwDia/2;
    union()
    {
         // Screw
        union()
        {
            translate([0,0,screwWasherThickness])
            {
                thread_out(screwDia,screwLen+0.5);
                thread_out_centre(screwDia+0.2,screwLen+0.5);
            }
            cylinder(d=screwWasherDiameter, h=screwWasherThickness);
            translate([0,0,screwWasherThickness+1/2])
                %cube([10,10,1], center=true);
        }
        difference()
        {
            // Head
            hull()
            {
                cube([flagWidth,screwFlatCut,0.1], center=true);
                translate([0,0,-(flagLabel+2)])
                    cube([flagWidth,screwFlatCut,0.1], center=true);
                translate([0,0,-(flagLabel+2)-flagHead])
                    cube([flagWidth,1,0.1], center=true);
            }
            // Loop
            translate([0,0,-(flagLabel+2)-flagHead+loopCutHeight/2+1])
                cube([loopCutWidth,screwFlatCut+1,loopCutHeight], center=true);
            // Paper Slot
            paperWindowW=flagWidth-6;
            paperThickness=0.8;
            translate([0,-1,-(flagLabel+2)/2])
                cube([paperWindowW,screwFlatCut,flagLabel-1], center=true);
            translate([0,0,-(flagLabel+2)/2])
                hull()
                {
                    cube([flagWidth-6,screwFlatCut-2,flagLabel-1], center=true);
                    translate([0,paperThickness/2,0])
                        cube([flagWidth-2,0.5,flagLabel+0.5], center=true);
                }
            // Paper Insert Slit
            translate([flagWidth/2-2.5,screwFlatCut/2,-(flagLabel-2)/2-2])
                cube([2,screwFlatCut/2+0.1,(flagLabel+0.5)], center=true);
            translate([-flagWidth/2+2.5,screwFlatCut/2,-(flagLabel-2)/2-2])
                cube([2,screwFlatCut/2+0.1,(flagLabel+0.5)], center=true);
            // Simulated paper model
            if(0)
            translate([0,screwFlatCut/2-1.5,-(flagLabel-2)/2-2])
                %cube([flagWidth-2, 0.1, flagLabel-0.1], center=true);
        }

        // Brim for more reliable printing if needed
        if (0)
        hull()
        {
            translate([0,screwFlatCut/2,screwLen+screwWasherThickness])
                cube([screwDia-2,layerHeight*2+0.1,0.01], center=true);
            translate([0,screwFlatCut/2,screwLen+10])
                cube([screwDia*2,layerHeight*2+0.1,0.01], center=true);
        }
        if (0)
        hull()
        {
            translate([0,screwFlatCut/2,0])
                cube([1,layerHeight*2+0.1,0.01], center=true);
            translate([0,screwFlatCut/2,-10])
                cube([3,layerHeight*2+0.1,0.01], center=true);
        }
    }

    // Cut for ease of printing
    cube([screwDia*2+flagWidth, screwFlatCut, screwLen*3+10+(flagLabel+2)+flagHead], center=true);
}