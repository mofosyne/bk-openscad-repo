/*
    BLTouch Z Height Calibration Gauge V1
    Author: Brian Khuu (2021)
    
    This allows you to consistently calibrate the z-height settings via the bltouch system.

    Each step 0.2mm and 0.4mm is relative to the BTouch region
    
    Usage:
    1. During Z-heigh calibration get the probe to touch the BLTouch region.
    2. When the nozzle adjust stage comes up, measure against the corresponding
    layer squish height you are aiming for.
*/

letter_h = 1;
letter_s = 10;

gaugeW = 50;
gaugeL_perSwatch = 40;
gaugeBaseH = 1;

module swatch(lengthOffset, layerHOffset, swatchL, layerH, nameStr) 
{
    module letter(l) 
    {
      linear_extrude(height = letter_h) 
        text(l, size = letter_s, font = "Liberation Sans", halign = "center", valign = "center", $fn = 16);
    }
    
    translate([gaugeW/2, lengthOffset + letter_s, layerHOffset+layerH]) color("grey") letter(nameStr);
    translate([0, lengthOffset, 0]) 
        cube([gaugeW, swatchL, layerHOffset+layerH]);
}

// Base
swatch(2 * gaugeL_perSwatch, 0, gaugeL_perSwatch, gaugeBaseH, "BTouch");
swatch(1 * gaugeL_perSwatch, gaugeBaseH, gaugeL_perSwatch, 0.2, "0.2mm");
swatch(0 * gaugeL_perSwatch, gaugeBaseH + 0.2, gaugeL_perSwatch, 0.4, "0.4mm");
