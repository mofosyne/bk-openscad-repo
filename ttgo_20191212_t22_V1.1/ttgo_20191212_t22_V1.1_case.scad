// ttgo_20191212_t22_V1.1 case
use <ttgo_t22_V1_1_model.scad> 

smdUseIPEX = false; ///< External IPEX to SMA antenna else onboard antenna

production = true; // Ensure prints in ready orientation

topCaseEnable = false;
bottomCaseEnable = true;

module ttgoV2Bottom()
{
    // http://www.lilygo.cn/claprod_view.aspx?TypeId=62&Id=1281&FId=t28:62:28

    caseThickness = 3;
    caseZipTieExtra = 10;
    
    holeSMA_dia = 7;
    holeSMA_thickness = 1;
    holeSpacing = 5;

    /////////////////////////////////////////////////////////////////////////
    ttgoxExact = 32.89;
    ttgoyExact = 100.13;
    ttgox = ttgoxExact + caseThickness * 2 + caseZipTieExtra;
    ttgoy = ttgoyExact + caseThickness * 2;
    ttgoSMD = 3; ///< SMD Standoff
    ttgoPCB = 2; ///< PCB thickness
    ttgoPCBHoleOff = 2.36;
    ttgoPCBHoleDia = 2;
    rd=2;
    
    // TopStandoff
    //color("grey")
    translate([0,0,ttgoPCB/2])
        hull()
        {
            translate([ttgox/2-rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoSMD,$fn=10);
            translate([-ttgox/2+rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoSMD,$fn=10);
            translate([ttgox/2-rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoSMD,$fn=10);
            translate([-ttgox/2+rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoSMD,$fn=10);
        }
    
    // PCB
    //color("green")  
    hull()
    {
        translate([ttgox/2-rd,ttgoy/2-rd,0])
            cylinder(r=rd,h=ttgoPCB,$fn=10, center=true);
        translate([-ttgox/2+rd,-ttgoy/2+rd,0])
            cylinder(r=rd,h=ttgoPCB,$fn=10, center=true);
        translate([ttgox/2-rd,-ttgoy/2+rd,0])
            cylinder(r=rd,h=ttgoPCB,$fn=10, center=true);
        translate([-ttgox/2+rd,ttgoy/2-rd,0])
            cylinder(r=rd,h=ttgoPCB,$fn=10, center=true);
    }

    // Main Body
    hull()
    {
        translate([0,0,0])
        hull()
        {
            translate([ttgox/2-rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoPCB,$fn=10, center=true);
            translate([-ttgox/2+rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoPCB,$fn=10, center=true);
            translate([ttgox/2-rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoPCB,$fn=10, center=true);
            translate([-ttgox/2+rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoPCB,$fn=10, center=true);
        }
        translate([0,0,-ttgoPCB/2-7-caseThickness])
        hull()
        {
            translate([ttgox/2-rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=0.01,$fn=10, center=true);
            translate([-ttgox/2+rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=0.01,$fn=10, center=true);
            translate([ttgox/2-rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=0.01,$fn=10, center=true);
            translate([-ttgox/2+rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=0.01,$fn=10, center=true);
        }
        translate([0,0,-ttgoPCB/2-20-caseThickness])
        hull()
        {
            ttgox2=16+caseThickness;
            ttgoy2=78+caseThickness;
            translate([ttgox2/2-rd,ttgoy2/2-rd,0])
                cylinder(r=rd,h=0.01,$fn=10, center=true);
            translate([-ttgox2/2+rd,-ttgoy2/2+rd,0])
                cylinder(r=rd,h=0.01,$fn=10, center=true);
            translate([ttgox2/2-rd,-ttgoy2/2+rd,0])
                cylinder(r=rd,h=0.01,$fn=10, center=true);
            translate([-ttgox2/2+rd,ttgoy2/2-rd,0])
                cylinder(r=rd,h=0.01,$fn=10, center=true);
        }
    }
    

    // SMD Hole
    if (smdUseIPEX)
    {
        // IPEX SMA Antenna Hole
        SMAExtra=10;
        SMAMountThickness=1;
        hull()
        {
            translate([0,-(ttgoyExact/2+SMAExtra+SMAMountThickness)/2,+ttgoPCB/2+ttgoSMD])
                cube([(holeSMA_dia+holeSpacing*2+caseThickness*2),(ttgoyExact/2+SMAExtra+SMAMountThickness),0.01], center=true);
            translate([0,-(ttgoyExact/2+SMAExtra+SMAMountThickness)/2,-ttgoPCB/2-(holeSMA_dia+holeSpacing)/2])
                rotate([90,0,0])
                    cylinder(r=(holeSMA_dia/2 + holeSpacing + caseThickness/2), h=(ttgoyExact/2+SMAExtra+SMAMountThickness), $fn=20, center=true);
            translate([0,-(78/2)/2,-ttgoPCB/2-20-caseThickness])
                cube([(holeSMA_dia+holeSpacing*2),(78/2),0.01], center=true);
        }
    }
}

module ttgoV2Top()
{
    // http://www.lilygo.cn/claprod_view.aspx?TypeId=62&Id=1281&FId=t28:62:28

    caseTopThickness = 1;
    caseThickness = 3;
    caseZipTieExtra = 10;
    
    holeSMA_dia = 7;
    holeSMA_thickness = 1;
    holeSpacing = 5;

    /////////////////////////////////////////////////////////////////////////
    ttgoxExact =  32.89;
    ttgoyExact = 100.13;
    ttgox = ttgoxExact + caseThickness * 2 + caseZipTieExtra;
    ttgoy = ttgoyExact + caseThickness * 2;
    ttgoSMD = 3; ///< SMD Standoff
    ttgoPCB = 2; ///< PCB thickness
    ttgoPCBHoleOff = 2.36;
    ttgoPCBHoleDia = 2;
    rd=2;
    
    translate([0,0,ttgoPCB/2+ttgoSMD])
        hull()
        {
            translate([ttgox/2-rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoSMD,$fn=10);
            translate([-ttgox/2+rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoSMD,$fn=10);
            translate([ttgox/2-rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoSMD,$fn=10);
            translate([-ttgox/2+rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoSMD,$fn=10);

            // SMD Hole
            if (smdUseIPEX)
            {
                SMAExtra=10;
                SMAMountThickness=1;
                translate([0,-(ttgoyExact/2+SMAExtra+SMAMountThickness)/2,ttgoSMD/2])
                    cube([(holeSMA_dia+holeSpacing*2+caseThickness*2),(ttgoyExact/2+SMAExtra+SMAMountThickness),ttgoSMD], center=true);
            }
        }
}

module ttgoV2Cut()
{
    // http://www.lilygo.cn/claprod_view.aspx?TypeId=62&Id=1281&FId=t28:62:28
    caseThickness = 3;
    caseZipTieExtra = 10;

    holeSMA_dia = 7;
    holeSMA_thickness = 1;
    holeSpacing = 5;

    ///////////////////
    pcbTolx = 2;
    pcbToly = 3;
    ttgoxExact = 32.89;
    ttgoyExact = 100.13;
    ttgox = ttgoxExact + pcbTolx;
    ttgoy = ttgoyExact + pcbToly;
    ttgoSMD = 3; ///< SMD Standoff
    ttgoPCB = 2; ///< PCB thickness
    ttgoPCBHoleOff = 2.36;
    ttgoPCBHoleDia = 2;
    rd=2;
    //%cube([ttgox,ttgoy,1], center=true);
    
    // OLED Screen
    oledtol=10;
    color("black")
    translate([ttgoxExact/2-6-7.5,ttgoyExact/2-25,ttgoPCB/2+ttgoSMD+1+2])
        union()
        {
            cube([15,25,2+0.01],center=true);
        }
    color("blue")
    translate([0,ttgoyExact/2-25,ttgoPCB/2+ttgoSMD+1])
        union()
        {
            cube([30,30+oledtol,2],center=true);
        }

    // SMD ANTENNA
    if (!smdUseIPEX)
    {
        translate([ttgoxExact/2-7/2,-ttgoyExact/2+40,ttgoPCB/2+10/2])
            union()
            {
                tol = 0.5;
                cube([7,6,10],center=true);
                translate([6/2,0,1])
                    rotate([0,90,0])
                    cylinder(r=6/2, h=6);
                // Cover
                translate([-tol,0,1])
                hull()
                {
                    translate([-3.5,0,0])
                        rotate([0,90,0])
                        cylinder(r=(6+tol)/2, h=16);
                    translate([16/2-3.5,0,-(6+tol)/2-0.5-ttgoPCB])
                        cube([16,(6+tol),0.1],center=true);
                }
            }
        translate([ttgoxExact/2-7/2,-ttgoyExact/2+40,-ttgoPCB/2-4/2])
            cube([7,6,4],center=true);
    }

    // Ports Reference
    if (0)
    %union()
    {
        // USB
        translate([-ttgoxExact/2+6/2-1,2,ttgoPCB/2+3/2])
            cube([6+caseThickness,6,3],center=true);

        // Button
        translate([-ttgoxExact/2+5/2-1,-7,ttgoPCB/2+3/2])
            cube([5,5,3],center=true);
        translate([-ttgoxExact/2+5/2-1,-7-9.5,ttgoPCB/2+3/2])
            cube([5,5,3],center=true);
        translate([-ttgoxExact/2+5/2-1,-7-9.5-9.5,ttgoPCB/2+3/2])
            cube([5,5,3],center=true);     
    }

    // Port Cutout
    hull()
    {
        translate([-ttgoxExact/2+6/2-0.5-caseThickness,-12,ttgoPCB/2+3/2+5/2])
            cube([1,40,3+0.1+5],center=true);
        translate([-ttgoxExact/2+6/2-0.5-caseZipTieExtra-1,-12,ttgoPCB/2+3/2+5/2])
            cube([1,45,10+0.1+5],center=true);
    }

    // SMA Cutout
    if(!smdUseIPEX)
    {
        hull()
        {
            translate([-(-ttgoxExact/2+6/2-0.5-caseThickness),-12,ttgoPCB/2+3/2+5/2])
                cube([1,40,3+0.1+5],center=true);
            translate([-(-ttgoxExact/2+6/2-0.5-caseZipTieExtra-1),-12,ttgoPCB/2+3/2+5/2])
                cube([1,45,10+0.1+5],center=true);
        }
    }

    // TopStandoff
    //color("grey")
    translate([0,0,ttgoPCB/2])
        hull()
        {
            translate([ttgox/2-rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoSMD+0.2,$fn=10);
            translate([-ttgox/2+rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoSMD+0.2,$fn=10);
            translate([ttgox/2-rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoSMD+0.2,$fn=10);
            translate([-ttgox/2+rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoSMD+0.2,$fn=10);
        }
    
    extraCut = 0.1;

    // PCB
    //color("green")
    difference()
    {
        hull()
        {

            translate([ttgox/2-rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoPCB+(extraCut*2),$fn=10, center=true);
            translate([-ttgox/2+rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoPCB+(extraCut*2),$fn=10, center=true);
            translate([ttgox/2-rd,-ttgoy/2+rd,0])
                cylinder(r=rd,h=ttgoPCB+(extraCut*2),$fn=10, center=true);
            translate([-ttgox/2+rd,ttgoy/2-rd,0])
                cylinder(r=rd,h=ttgoPCB+(extraCut*2),$fn=10, center=true);
        }
    }

    // Battery
    difference()
    {
        pcbBatTol=3; ///< Account for battery tolerance
        pcbLedgeX=0; ///5
        union()
        {
            //color("grey")
            hull()
            {
                translate([0,0,-ttgoPCB/2-10/2])
                    cube([23+pcbBatTol,ttgoy-pcbLedgeX,10],    center=true);
                translate([0,0,-ttgoPCB/2-20])
                    cube([16,78,0.01], center=true);
            }
            hull()
            {
                translate([0,0,-ttgoPCB/2-10/2])
                    cube([ttgox,78+pcbBatTol,10],    center=true);
                translate([0,0,-ttgoPCB/2-20])
                    cube([16,78,0.01], center=true);
            }
        }

        // Account For Lanyard Cutout
        translate([0,-(-ttgoy/2-holeSMA_dia+4),-ttgoPCB/2-5/2])
            cube([100,20,100], center=true);
    
        if (!smdUseIPEX)
        {
            translate([0,-ttgoy/2-holeSMA_dia+4,-ttgoPCB/2-5/2])
                cube([100,20,100], center=true);
        }
    }

    // SMD Hole
    if (smdUseIPEX)
    {
        SMAExtra=10;
        translate([0,-ttgoyExact/2-SMAExtra,-ttgoPCB/2-(holeSMA_dia+holeSpacing)/2])
            rotate([90,0,0])
            cylinder(r=holeSMA_dia/2, h=10+SMAExtra, $fn=20, center=true);
        hull()
        {
            translate([0,-(ttgoyExact/2+SMAExtra)/2,+ttgoPCB/2+ttgoSMD+0.01])
                cube([(holeSMA_dia+holeSpacing*2),(ttgoyExact/2+SMAExtra),0.01], center=true);
            translate([0,-(ttgoyExact/2+SMAExtra)/2,-ttgoPCB/2-(holeSMA_dia+holeSpacing)/2])
                rotate([90,0,0])
                cylinder(r=(holeSMA_dia/2 + holeSpacing), h=(ttgoyExact/2+SMAExtra), $fn=20, center=true);
            translate([0,-(78/2)/2,-ttgoPCB/2-20])
                cube([(holeSMA_dia+holeSpacing*2),(78/2),0.01], center=true);
        }
    }

    // ZipTie/M3Screw Slot
    translate([0,ttgoy/2-8,0])
    {
        translate([-ttgox/2-caseZipTieExtra/2+1.5,0,0])
        union()
        {
            cube([2,5.5,100], center=true);
            cylinder(r=3/2-0.05, h=100, center=true, $fn=20);
        }
        translate([-(-ttgox/2-caseZipTieExtra/2+1.5),0,0])
        union()
        {
            cube([2,5.5,100], center=true);
            cylinder(r=3/2-0.05, h=100, center=true, $fn=20);
        }
    }
    translate([0,-ttgoy/2+8,0])
    {
        translate([-ttgox/2-caseZipTieExtra/2+1.5,0,0])
        union()
        {
            cube([2,5.5,100], center=true);
            cylinder(r=3/2-0.05, h=100, center=true, $fn=20);
        }
        translate([-(-ttgox/2-caseZipTieExtra/2+1.5),0,0])
        union()
        {
            cube([2,5.5,100], center=true);
            cylinder(r=3/2-0.05, h=100, center=true, $fn=20);
        }
    }
    
    // Strap Slot
    translate([0,ttgoy/2-26,0])
    {
        // Typical Straps is around 2mm by 25mm
        translate([-ttgox/2-caseZipTieExtra/2+1.5,0,0])
            cube([2.5,24,100], center=true);
        translate([-(-ttgox/2-caseZipTieExtra/2+1.5),0,0])
            cube([2.5,24,100], center=true);
    }
    
    // Strap Slot
    translate([0,ttgoy/2-65,0])
    {
        // Typical Straps is around 2mm by 25mm
        translate([-ttgox/2-caseZipTieExtra/2+1.5,0,0])
            cube([2.5,35,100], center=true);
        translate([-(-ttgox/2-caseZipTieExtra/2+1.5),0,0])
            cube([2.5,35,100], center=true);
    }

    // Lanyard
    translate([0,+ttgoy/2-3,-ttgoPCB/2-4])
        rotate([0,90,0])
            cylinder(r=2,h=100,$fn=40, center=true);

    if (!smdUseIPEX)
    {
        translate([0,-(ttgoy/2-3),-ttgoPCB/2-4])
            rotate([0,90,0])
                cylinder(r=2,h=100,$fn=40, center=true);
    }
}

///////////////////////////////////////////////////////
// Output
if (production)
{
    // Production
    if (topCaseEnable)
    rotate([0,180,0])
    difference()
    {
        ttgoV2Top();
        ttgoV2Cut();
    }

    if (bottomCaseEnable)
    difference()
    {
        ttgoV2Bottom();
        ttgoV2Cut();
    }
}
else
{
    // Dev
    if (topCaseEnable)
    difference()
    {
        ttgoV2Top();
        ttgoV2Cut();
    }

    if (bottomCaseEnable)
    difference()
    {
        ttgoV2Bottom();
        ttgoV2Cut();
    }

    // Model
    //%ttgoV2Model();
    //%ttgoV2Model_PCBOnly();
}