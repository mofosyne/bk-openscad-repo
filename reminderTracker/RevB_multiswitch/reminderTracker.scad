$fn = 20;

layerHeight = 0.30; // Typical for 0.4 to 0.6mm nozzle

NUMBER_OF_SWITCHES = 5; // Number Of Switches
MODE_CONE_SLIDER = false;
MODE_SWITCH_SLIDER = true;


baseThickness = layerHeight*15;
baseWidth = 23;
baseHeight = 20;

sliderRail = 10;
sliderWidthThickness = 1.5;
sliderHeightThickness = 2;

sliderWidth = baseWidth-sliderWidthThickness*2;
sliderHeight = baseHeight-sliderHeightThickness*2;

echo(baseThickness);



MODE_ADD_WINDOW = true;

module sliderBulk(heightTop, heightBottom, width, sliderRailW, sliderRailH=0, offsetX=0, offsetY=0, offsetZ=0, cutMode=false)
{
    difference()
    {
        // Slider Rails
        union()
        {
            hull()
            {
                translate([0, 0, baseThickness+0.01])
                    cube([heightTop-sliderRailW+offsetX, width+offsetY, 0.01], center = true);
                translate([0, 0, layerHeight*10+offsetZ])
                    cube([heightTop-sliderRailW+offsetX+1, width+offsetY, 0.01], center = true);
            }
            hull()
            {
                translate([0, 0, layerHeight*10+offsetZ])
                    cube([heightBottom+offsetX-2, width+offsetY, 0.01], center = true);
                translate([0, 0, -0.01])
                    cube([heightBottom+offsetX, width+offsetY, 0.01], center = true);
            }
        }
        // Slide flange to make it easier to slide over the tab
        if (0) //< Feature disabled for now due to potential tolerance issues. Also not sure if actually needed
        if (cutMode)
        {
            translate([(heightBottom-sliderRailW/2-offsetX)/2 -1/2, 0, 0])
                cylinder(r1=1.0, r2=0, h=sliderRailH);
            translate([-(heightBottom-sliderRailW/2-offsetX)/2 +1/2, 0, 0])
                cylinder(r1=1, r2=0, h=sliderRailH);
        }
        // Slider Bottom Rail
        hull()
        {
            translate([0, 0, sliderRailH+0.02])
                cube([heightBottom-sliderRailW/2-offsetX, width+offsetY+0.01, 0.01], center = true);
            translate([0, 0, -0.02])
                cube([heightBottom-sliderRailW/2-offsetX, width+offsetY+0.01, 0.01], center = true);
        }
    }

    // Slider Handle
    if (MODE_CONE_SLIDER)
    {
        translate([0, 0, baseThickness])
            color("grey")
            cylinder(r1=(heightTop-sliderRailW)/2, r2=(heightTop-sliderRailW)/2+2, h=layerHeight*10+0.01);
    }
    if (MODE_SWITCH_SLIDER)
    {            
        color("grey")
        hull()
        {
            translate([0, 0, baseThickness+0.01])
                cube([(heightTop-sliderRailW), width*0.2, 0.01], center = true);
            translate([0, 0, baseThickness+layerHeight*10+0.01])
                cube([(heightTop-sliderRailW)/2, width*0.05, 0.01], center = true);
        }
    }
}

module switch_model(flipSwitchState=false)
{
    union()
    { // Base
        xTol = 1.5;
        yTol = 1.0;
        windowWidth = sliderWidth/2-1.5;
        windowHeight = sliderHeight-sliderRail/2-xTol-2;
        difference()
        {
            translate([0,0,baseThickness/2])
                cube([baseHeight,baseWidth,baseThickness], center = true);
            sliderBulk(
                heightTop=sliderHeight,
                heightBottom=sliderHeight,
                width=sliderWidth,
                sliderRailW=sliderRail,
                sliderRailH=layerHeight*5,
                offsetX=xTol,
                offsetY=yTol,
                offsetZ=layerHeight*2,
                cutMode=true);
            
            if (MODE_ADD_WINDOW)
            {
                translate([0, -(baseWidth/2-windowWidth/2-sliderWidthThickness-0.5), layerHeight*3])
                    cube([windowHeight, windowWidth, layerHeight*4*2], center = true);
                translate([0, +(baseWidth/2-windowWidth/2-sliderWidthThickness-0.5), layerHeight*3])
                    cube([windowHeight, windowWidth, layerHeight*4*2], center = true);
            }
        }

        // Add Color Windows
        if (MODE_ADD_WINDOW)
        {
            color("green")
                translate([0, -(baseWidth/2-windowWidth/2-sliderWidthThickness-0.5), layerHeight*2/2+layerHeight*2])
                cube([windowHeight, windowWidth, layerHeight*2+0.01], center = true);
            color("red")
                translate([0, +(baseWidth/2-windowWidth/2-sliderWidthThickness-0.5), layerHeight*1])
                cube([windowHeight, windowWidth, layerHeight*2+0.01], center = true);
        }
    }

    union()
    { // Slider
        flangeCompensate = 0.5;
        silderPos = flipSwitchState ? -sliderWidth/4-flangeCompensate/2 : sliderWidth/4+flangeCompensate/2;
        translate([0,silderPos,0])
            sliderBulk(
                heightTop=sliderHeight, 
                heightBottom=sliderHeight, 
                width=sliderWidth/2-1-flangeCompensate,
                sliderRailW=sliderRail,
                sliderRailH=layerHeight*5+layerHeight*1);
    }
}


translate([-((NUMBER_OF_SWITCHES-1)*baseHeight)/2,0,0])
    for(i = [0:1:NUMBER_OF_SWITCHES-1])
        translate([baseHeight*i,0,0])
            switch_model(flipSwitchState=i%2);