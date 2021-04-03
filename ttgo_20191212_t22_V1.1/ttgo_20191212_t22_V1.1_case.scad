// ttgo_20191212_t22_V1.1 case
use <ttgo_t22_V1_1_model.scad> 

module ttgoV2Bulk()
{
    // http://www.lilygo.cn/claprod_view.aspx?TypeId=62&Id=1281&FId=t28:62:28

    caseThickness = 3;
    holeSMA_dia = 7;
    holeSpacing = 2;
    /////////////////////////////////////////////////////////////////////////
    ttgox = 32.89 + caseThickness;
    ttgoy = 100.13 + caseThickness;
    ttgoSMD = 4; ///< SMD Standoff
    ttgoPCB = 2; ///< PCB thickness
    ttgoPCBHoleOff = 2.36;
    ttgoPCBHoleDia = 2;
    rd=2;
    
    // TopStandoff
    if (0)
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
        translate([0,0,-ttgoPCB/2-3-(holeSMA_dia+holeSpacing*2)])
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
        translate([0,0,-ttgoPCB/2-7/2])
        hull()
        {
            ttgox2=23+caseThickness;
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
}


module ttgoV2Cut()
{
    // http://www.lilygo.cn/claprod_view.aspx?TypeId=62&Id=1281&FId=t28:62:28

    holeSMA_dia = 7;
    holeSpacing = 2;
    
    ///////////////////
    pcbTol = 1;
    ttgox = 32.89 + pcbTol;
    ttgoy = 100.13 + pcbTol;
    ttgoSMD = 4; ///< SMD Standoff
    ttgoPCB = 2; ///< PCB thickness
    ttgoPCBHoleOff = 2.36;
    ttgoPCBHoleDia = 2;
    rd=2;
    //%cube([ttgox,ttgoy,1], center=true);
    
    // SMD ANTENNA
    translate([ttgox/2-7/2,-ttgoy/2+40,ttgoPCB/2+10/2])
        union()
        {
            cube([7,6,10],center=true);
            
            translate([6/2,0,1])
              rotate([0,90,0])
                cylinder(r=6/2, h=6);
        }
    translate([ttgox/2-7/2,-ttgoy/2+40,-ttgoPCB/2-4/2])
        union()
        {
            cube([7,6,4],center=true);
        }

    // USB
    translate([-ttgox/2+6/2-1,2,ttgoPCB/2+3/2])
            cube([6,6,3],center=true);
        
    // Button
    translate([-ttgox/2+5/2-1,-7,ttgoPCB/2+3/2])
            cube([5,5,3],center=true);
    translate([-ttgox/2+5/2-1,-7-9.5,ttgoPCB/2+3/2])
            cube([5,5,3],center=true);
    translate([-ttgox/2+5/2-1,-7-9.5-9.5,ttgoPCB/2+3/2])
            cube([5,5,3],center=true);
            
    // TopStandoff
    //color("grey")
    translate([0,0,ttgoPCB/2-0.01])
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

        // Holes
        if(0)
        union()
        {
            translate([ttgox/2-ttgoPCBHoleOff,ttgoy/2-ttgoPCBHoleOff,0])
                cylinder(r=ttgoPCBHoleDia/2,h=1+ttgoPCB,$fn=10, center=true);
            translate([-ttgox/2+ttgoPCBHoleOff,-ttgoy/2+ttgoPCBHoleOff,0])
                cylinder(r=ttgoPCBHoleDia/2,h=1+ttgoPCB,$fn=10, center=true);
            translate([ttgox/2-ttgoPCBHoleOff,-ttgoy/2+ttgoPCBHoleOff,0])
                cylinder(r=ttgoPCBHoleDia/2,h=1+ttgoPCB,$fn=10, center=true);
            translate([-ttgox/2+ttgoPCBHoleOff,ttgoy/2-ttgoPCBHoleOff,0])
                cylinder(r=ttgoPCBHoleDia/2,h=1+ttgoPCB,$fn=10, center=true);
        }
    }


    // Battery
    //color("grey")
    pcbBatTol=1; ///< Account for battery tolerance
    hull()
    {
        translate([0,0,-ttgoPCB/2-(holeSMA_dia+holeSpacing*2)/2])
                cube([23+pcbBatTol,ttgoy,(holeSMA_dia+holeSpacing*2)],    center=true);
        translate([0,0,-ttgoPCB/2-20])
                cube([16,78,0.01], center=true);
    }
    hull()
    {
        translate([0,0,-ttgoPCB/2-7/2])
                cube([ttgox,78+pcbBatTol,7],    center=true);
        translate([0,0,-ttgoPCB/2-20])
                cube([16,78,0.01], center=true);
    }

    // SMD Hole
    translate([0,ttgoy/2,-ttgoPCB/2-(holeSMA_dia+holeSpacing)/2])
        rotate([90,0,0])
        cylinder(r=holeSMA_dia/2, h=10, $fn=20, center=true);
}

if (1)
difference()
{
    ttgoV2Bulk();
    ttgoV2Cut();
}

//%ttgoV2Model();
