$fn=20;
/*
    Stacked Pogo Pin Serial Adaptor (Customisable)
    Author: Brian Khuu 2021

    This is similar to https://hackaday.com/2017/08/04/pogo-pin-serial-adapter-thing/
    But is fully 3D printed without need for PCB.
    
    This was created to help with programming a board that has
    dual stacked programming pins. Which you might find in JTAG boards.

    I used P75-E2 probes for this

    ```
    Specification:
    Model: P75-E2
    Full Stroke: 2.50mm
    Current: 3A
    Resistance: 50mΩ
    Spring Pressure: 100g
    Color: Gold+Silver
    Needle Diameter: approx. 1.3mm
    Shank Diameter: approx. 0.74mm
    Needle Length: approx. 16.5mm
    Needle Sheath Diameter: 1.32mm
    Drill Size: approx. 1.4mm
    Minimum Test Distance: approx. 1.91mm
    ```
    
    I tested this print using a 0.8mm nozzle on 2021-10-20
*/

// Designed For Printer Nozzle
printer_nozzle=0.4;

// Base Thickness
base_thickness = 0.1;

/* probe pin spec */
ppext = 2.5; // Probe extention length
ppbody = 16.5-ppext; // Body of the probe
ppdia = 1.3; // probe pin diameter

ppdiatol = 0.2; // tolerance for fitting
ppinset = 2.5;

ppdiaoutset = ppext-ppinset; // How far to space out to allow for side fits
echo(ppdiaoutset);

/* Castellated Module Pin Spacing and count */

// Pin Count
ppc = 7;

// Pin Spacing
pps = 2; // Most typically 2.54mm but this one is smaller at 2mm

// PCB Thickness
pcb_thickness = 1.1; // 1mm Open Log Clone

// PCB Probe Offset
pcb_probe_offset = 1.3;

/* Clip */
clip_tab = 5; // Clip tab to more easily open the clip

/* pcb */
pcb_h = 2; // pcb thickness

/* calc */
boxx = ppc * pps + ppdia;
boxy = ppbody + ppdiaoutset+2;
boxh = pps*2+pcb_probe_offset+ppdiatol+1;

module probe_pin_req(angleOffset=0)
{
  inset=0;
  
  translate([0,0,ppext])
  rotate([angleOffset,0,0])
  translate([0,0,-ppbody-ppext])
  union()
  {
    translate([0,0,0])
      cylinder(r1=(ppdia)/2,r2=(ppdia+ppdiatol)/2, h=3);
    translate([0,0,1])
      cylinder(r=(ppdia+ppdiatol)/2, h=ppbody+ppext+1);
    %color("gold") cylinder(r=ppdia/2, h=ppbody);
    %color("silver") translate([0,0,ppbody])
      cylinder(r1=ppdia/2, r2=0, h=ppext);
  }
}

module openlog_clone_programmer_jig()
{
    /* Bulk */
    rotate([0,90,0])
    difference()
    {
        angleOffsetDeg=2;
        union()
        {
            backHeadExtra = 2;
            
            // 3D Print Folding cover Shield 
            // Dev Note: Also doubles as oooze shield
            coverThickness=1;
            translate([boxx/2, coverThickness-coverThickness/2, 0])
                cube([boxx,coverThickness,boxh+boxy*2], center=true);
            
            // Probe Head
            hull()
            {
                translate([boxx/2, 0, 0])
                    cube([boxx,0.01,boxh], center=true);
                translate([boxx/2, boxy, 0])
                    cube([boxx,0.01,boxh+backHeadExtra], center=true);
            }            
            
            // Probe Spine
            hull()
            {
                translate([boxx/2, boxy, 0])
                    cube([boxx,0.01,boxh+backHeadExtra], center=true);
                translate([boxx/2, boxy+5, 0])
                    cube([boxx,0.01,2], center=true);
            }
            hull()
            {
                translate([boxx/2, boxy+5, 0])
                    cube([boxx,0.01,2], center=true);
                translate([boxx/2, boxy+50, 0])
                    cube([boxx,0.01,0.8], center=true);
            }
        }
        
        /* Probe */
        for ( xi = [0 : 1 : ppc-1] )
        {
          translate([ppdia/2+pps/2+pps*xi, 0, 0])
          union()
          {
            translate([0, ppdiaoutset, +pps/2])
              rotate([90,0,0])
                probe_pin_req(angleOffsetDeg);
            translate([0, ppdiaoutset, -pps/2])
              rotate([90,0,0])
                probe_pin_req(-angleOffsetDeg);
          }
        }
                
        // Soldering Access
        headGap = 2;
        backGap = 3.5;
        hull()
        {
            translate([boxx/2, ppbody-backGap, ppdia*2])
                rotate([0,90,0])
                    cylinder(r=ppdia, h=boxx+1, center=true);
            translate([boxx/2, ppdia+headGap, ppdia*2])
                rotate([0,90,0])
                    cylinder(r=ppdia, h=boxx+1, center=true);
            translate([boxx/2, ppbody-ppdia*3, 100])
                rotate([0,90,0])
                    cylinder(r=ppdia, h=boxx+1, center=true);
            translate([boxx/2, ppdia+4, 100])
                rotate([0,90,0])
                    cylinder(r=ppdia, h=boxx+1, center=true);
        }
        hull()
        {
            translate([boxx/2, ppbody-backGap, -(ppdia*2)])
                rotate([0,90,0])
                    cylinder(r=ppdia, h=boxx+1, center=true);
            translate([boxx/2, ppdia+headGap, -(ppdia*2)])
                rotate([0,90,0])
                    cylinder(r=ppdia, h=boxx+1, center=true);
            translate([boxx/2, ppbody-headGap, -100])
                rotate([0,90,0])
                    cylinder(r=ppdia, h=boxx+1, center=true);
            translate([boxx/2, ppdia+4, -100])
                rotate([0,90,0])
                    cylinder(r=ppdia, h=boxx+1, center=true);
        }
        // Soldering Access Wire Guide
        wireCutOffset = 0.5;
        for ( xi = [0 : 1 : ppc-1] )
        {
          translate([0, headGap+boxy+1, 0])
          translate([ppdia/2+pps/2+pps*xi, 0, 0])
          union()
          {
            translate([0,-boxy,+wireCutOffset])
            rotate([angleOffsetDeg,0,0])
            translate([0,boxy,0])
            hull()
            {
                translate([0, 0, +boxh/2])
                    rotate([90,0,0])
                        cylinder(r=(ppdia+ppdiatol)/2, h=boxy);
                translate([0, 0, +100])
                    rotate([90,0,0])
                        cylinder(r=(ppdia+ppdiatol)/2, h=boxy);
            }
            translate([0,-boxy,-wireCutOffset])
            rotate([-angleOffsetDeg,0,0])
            translate([0,boxy,0])       
            hull()
            {
                translate([0, 0, -boxh/2])
                    rotate([90,0,0])
                        cylinder(r=(ppdia+ppdiatol)/2, h=boxy);
                translate([0, 0, -100])
                    rotate([90,0,0])
                        cylinder(r=(ppdia+ppdiatol)/2, h=boxy);
            }
          }
        }
        
        /* Probe Head Widening */
        // Dev Note: Had issue where excess plastic on one hole prevented fitting. So this is added for tolerance
        probeWiding=0.5; ///< How much extra tolerance do you need?
        for ( xi = [0 : 1 : ppc-1] )
        {
          translate([ppdia/2+pps/2+pps*xi, 0, 0])
          union()
          {
            hull()
            {
                translate([0, headGap/2, pps/2])
                    rotate([90,0,0])
                        cylinder(r=(ppdia+ppdiatol)/2, h=1, center=true);
                translate([0, headGap/2, pps/2+probeWiding])
                    rotate([90,0,0])
                        cylinder(r=(ppdia+ppdiatol)/2, h=headGap+3, center=true);
            }
            hull()
            {
                translate([0, headGap/2, -pps/2])
                    rotate([90,0,0])
                        cylinder(r=(ppdia+ppdiatol)/2, h=1, center=true);
                translate([0, headGap/2, -(pps/2+probeWiding)])
                    rotate([90,0,0])
                        cylinder(r=(ppdia+ppdiatol)/2, h=headGap+3, center=true);
            }
          }
        }
    }
}

openlog_clone_programmer_jig();