use <lib/ISOThread.scad>
// Tiny but hard to twist

// Typical camera mounts are 3/4 inch or 1/4 inch
screwDia=6.35; // 6.35mm == 1/4 inch
screwLen=6;

flagHead=6;

layerHeight=0.3;

rotate([-90,0,0])
intersection()
{
    screwFlatCut=screwDia/2;
    union()
    {
         // Screw
        thread_out(screwDia,screwLen+0.1);
        thread_out_centre(screwDia+0.2,screwLen+0.1);
        difference()
        {
            headWidth=screwDia+2;
            // Head
            hull()
            {
                cube([headWidth,screwFlatCut,0.1], center=true);
                translate([0,0,-flagHead/2])
                    cube([headWidth,screwFlatCut,0.1], center=true);
                translate([0,0,-flagHead])
                    cube([headWidth,1,0.1], center=true);
            }
            translate([0,0,-flagHead/2])
                cube([headWidth-3,screwFlatCut+1,flagHead-3], center=true);
        }

        // Brim for more reliable printing
        if (0)
        hull()
        {
            translate([0,screwFlatCut/2,screwLen])
                cube([1,layerHeight*2+0.1,0.01], center=true);
            translate([0,screwFlatCut/2,screwLen+10])
                cube([3,layerHeight*2+0.1,0.01], center=true);
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
    cube([screwDia*2, screwFlatCut, screwLen*3+10], center=true);
}