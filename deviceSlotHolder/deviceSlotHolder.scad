// Device Charging Fin Holder (e.g. Smartphones and Battery Packs)
// Brian Khuu 2023
// Intended for adding fins to IKEA Skadis parametric pegboard tray so you can place smartphones and other devices vertically
//      e.g. https://www.printables.com/model/47813-ikea-skadis-parametric-pegboard-tray
$fn=50;

// Length of Fins
length=170;
// Smallest Spacing
spacingBiggest=25;
spacingSmallest=15; // Can't figure out how to do cumulative summation...
// Number Of Slots
slotcount=6;

/* [Print Spec] */
wallTopThickness=0.8;
wallBottomThickness=2;
wallHeight=60;
baseThickness=0.5;

/* [Styling] */
// Slot Top Rounding
finSlotRounding=20;
// Slot Bottom Rounding
finBottomRounding=30;

/* [Calcuation] */
// Slot Shrinkage
slotshrink = length/(slotcount+4);

rotate([0,0,90*3])
{
    // Fins
    for (i=[0:1:slotcount])
    {
        translate([0,i*spacingBiggest,0])
        hull()
        {
            translate([(length-i*slotshrink)/2,0,0]) cube([(length-i*slotshrink),wallBottomThickness,0.01], center=true);
            translate([finSlotRounding/2,0,wallHeight-finSlotRounding/2]) rotate([90,0,0]) cylinder(d=finSlotRounding, h=wallTopThickness, center=true);
        }
    }

    // Curved Base
    union()
    {
        difference()
        {
            cube([finBottomRounding/2,spacingBiggest*slotcount,finBottomRounding/2]);
                translate([finBottomRounding/2+wallTopThickness,0,finBottomRounding/2+baseThickness]) 
                    rotate([90,0,180]) cylinder(d=finBottomRounding, h=spacingBiggest*slotcount);
        }
        if (0)
        cube([wallTopThickness,spacingBiggest*slotcount,wallHeight-finSlotRounding/2]);
    }

    // Base
    hull()
    {
        for(i = [0:1:slotcount])
        {
            translate([0,i*spacingBiggest,baseThickness/2])
                    translate([(length-i*slotshrink)/2,0,0]) cube([(length-i*slotshrink),wallBottomThickness,baseThickness], center=true);
        }
    }
}