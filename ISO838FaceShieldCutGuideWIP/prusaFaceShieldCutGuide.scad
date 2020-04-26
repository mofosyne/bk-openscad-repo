$fn = 100;
/*
    Cutting Guide for Prusa Face Shield RC3 (Requires at least 240x240mm build plate)
    Brian Khuu (March 2020) mofosyne@gmail.com
    
    This is a cutting guide based on the laser cut spec diagram for the replaceable face shield sheets:
    https://www.prusaprinters.org/prints/25857-prusa-protective-face-shield-rc3
    
    It consists of a upper drill guide as well as a lower base for cutting the surrounding sheets.
    I have not tested this design as it requires a build plate that is larger than my 200x200mm buildplate. But it may be of use for others.
    
    * faceShieldSheetModel()   : This is the model of the face shield sheet
    * faceShieldDrillGuide()   : This is the drill guide
    * faceShieldCuttingGuide() : This is the cut guide with alignment holes
    
    # Generate Models
    openscad -Dmode=0 -o prusaFaceShieldCutGuide_model.stl prusaFaceShieldCutGuide.scad
    openscad -Dmode=1 -o prusaFaceShieldCutGuide_drillGuide.stl prusaFaceShieldCutGuide.scad
    openscad -Dmode=2 -o prusaFaceShieldCutGuide_cutGuide.stl prusaFaceShieldCutGuide.scad 
    
    # MacOS generate model
    /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -Dmode=0 -o prusaFaceShieldCutGuide_model.stl prusaFaceShieldCutGuide.scad
    /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -Dmode=1 -o prusaFaceShieldCutGuide_drillGuide.stl prusaFaceShieldCutGuide.scad
    /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -Dmode=2 -o prusaFaceShieldCutGuide_cutGuide.stl prusaFaceShieldCutGuide.scad 
    
    
    
*/

mode = -1;

/*******************************
    Prusa Face Shield RC3 Spec
********************************/

xwidth = 240;
ywidth = 240;

// Holes
hole_rad = 5.5/2;
hole_wid = 2;

// Top
top_rad=10;
top_outer_hole_spacing = 60/2+79;
top_inner_hole_spacing = 60/2;
top_hole_offset=10;

// Bottom
bottom_rad=50;
bottom_hole_spacing=90/2;
bottom_hole_offset=6;


/*************************
    Utilities
**************************/

module shield_bulk(h=1)
{
    linear_extrude(height = h, scale = 1)
    hull()
    {
        translate([xwidth/2-top_rad,-top_rad])
            circle(r=top_rad);
        translate([-xwidth/2+top_rad,-top_rad])
            circle(r=top_rad);
        translate([xwidth/2-bottom_rad,-ywidth+bottom_rad])
            circle(r=bottom_rad);
        translate([-xwidth/2+bottom_rad,-ywidth+bottom_rad])
            circle(r=bottom_rad);
    }
}

module shield_holes(h=1, offset=0)
{
    module mount_hole_model(_r,_w)
    {
        hull()
        {
            translate([_w/2,0])
                circle(r=_r);
            translate([-_w/2,0])
                circle(r=_r);
        }
    }
    
    _hole_radius = hole_rad+offset;
    
    linear_extrude(height = h, scale = 1)
    union()
    {
        // Top
        translate([0,-top_hole_offset])
        union()
        {
            translate([top_inner_hole_spacing,0])
                mount_hole_model(_hole_radius, hole_wid);
            translate([-top_inner_hole_spacing,0])
                mount_hole_model(_hole_radius, hole_wid);
            translate([top_outer_hole_spacing,0])
                mount_hole_model(_hole_radius, hole_wid);
            translate([-top_outer_hole_spacing,0])
                mount_hole_model(_hole_radius, hole_wid);
        }
        
        // Top
        translate([0,-ywidth+bottom_hole_offset])
        union()
        {
            translate([0,0])
                mount_hole_model(_hole_radius, hole_wid);
            translate([-bottom_hole_spacing,0])
                mount_hole_model(_hole_radius, hole_wid);
            translate([bottom_hole_spacing,0])
                mount_hole_model(_hole_radius, hole_wid);
        }
    }
}

/********************************
    Prusa Face Shield RC3 Model
********************************/

module faceShieldSheetModel(thickness=0.5)
{
    // Prusa recommends 0.5 mm thick petg sheet 
    difference()
    {
        shield_bulk(thickness);
        translate([0,0,-1])
            shield_holes(thickness+2, 0);
    }
}


/********************************
    Various Cutting Guides
********************************/


module faceShieldCuttingGuide(baseThickness=2, alignmentHeight=20, alignmentHoleOffset=-0.2)
{
    union()
    {
        shield_bulk(baseThickness);
        shield_holes(alignmentHeight, alignmentHoleOffset);
    }
}

module faceShieldDrillGuide(baseThickness=2, alignmentHoleOffset=0.2)
{
    // Prusa recommends 0.5 mm thick petg sheet 
    difference()
    {
        shield_bulk(baseThickness);
        translate([0,0,-1])
            shield_holes(baseThickness+2, alignmentHoleOffset);
    }
}


/********************************
    Various Cutting Guides
********************************/




if (mode == 0) {
     faceShieldCuttingGuide();
} else if (mode == 1) {
     faceShieldDrillGuide();
} else if (mode == 2) {
     faceShieldSheetModel();
} else {
    // Demo
    translate([0,0,0])
        faceShieldCuttingGuide();
    %translate([0,0,100])
        faceShieldSheetModel();
    translate([0,0,200])
        faceShieldDrillGuide();
}
