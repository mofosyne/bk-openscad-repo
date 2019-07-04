$fn=20;
/*
  Edge Header Programmer Jig Via Probes (e.g. OpenLog Clone)
  Author: Brian Khuu 2019
  
  This is originally designed for connecting to OpenLog Clones
  
  I used P100-E2 probes for this
*/

// Designed For Printer Nozzle
printer_nozzle=0.4;

// Base Thickness
base_thickness = 1;

/* probe pin spec */
ppext = 8; // Probe extention length
ppbody = 25; // Body of the probe
ppdia = 1.5; // probe pin diameter

ppdiatol = 0.6; // tolerance for fitting
ppinset = 2;

ppdiaoutset = ppext-ppinset; // How far to space out to allow for side fits
echo(ppdiaoutset);

/* Castellated Module Pin Spacing and count */

// Pin Count
ppc = 6;

// Pin Spacing
pps = 2.54;

// PCB Thickness
pcb_thickness = 1; // 1mm Open Log Clone

// PCB Probe Offset
pcb_probe_offset = 1.3;

/* Clip */
clip_tab = 5; // Clip tab to more easily open the clip

/* pcb */
pcb_h = 2; // pcb thickness

/* calc */
boxx = ppc * pps;
boxy = 2 + ppbody + ppdiaoutset;
boxh = base_thickness+pcb_probe_offset+ppdiatol+5;

module probe_pin_req()
{
  inset=0;
  translate([0,0,-ppbody])
  union()
  {
    translate([0,0,0])
    cylinder(r1=(ppdia)/2,r2=(ppdia+ppdiatol)/2, h=3);
    translate([0,0,1])
      cylinder(r=(ppdia+ppdiatol)/2, h=ppbody);
    %color("gold") cylinder(r=ppdia/2, h=ppbody);
    %color("silver") translate([0,0,ppbody])
      cylinder(r=ppdia/2, r2=0, h=ppext);
  }
}

module openlog_clone_programmer_jig_clip()
{
  grip_thickness=printer_nozzle*3+0.1;
  grip_height=6;
  difference() 
  {
    translate([-(grip_thickness*2+2)/2,-1,0])
      cube([boxx+2+(grip_thickness*2),boxy/3+3,grip_height]);
    translate([-1,-2,-1])
      cube([boxx+2,boxy/3+2,grip_height+2]);
  }
  translate([-(grip_thickness*2+2)/2,-0.5,0])
    hull()
    {
      cube([4,0.1,grip_height]);
      translate([0,-8,0])
        cube([0.1,0.1,grip_height]);
    }
  translate([(grip_thickness*2+2)/2+boxx,-0.5,0])
    hull()
    {
      translate([-4,0,0])
        cube([4,0.1,grip_height]);
      translate([-0.1,-8,0])
        cube([0.1,0.1,grip_height]);
    }
}

module openlog_clone_programmer_jig()
{
  difference()
  {  
    /* Bulk */
    union()
    {
      difference()
      {
        cube([boxx,boxy,boxh]);
        translate([-5, 0, base_thickness+pcb_probe_offset+ppdia*1.5]) 
          cube([ppc * pps+10,ppbody, 5]);      
      }
      translate([-(ppdia)/2, ppdiaoutset+7+ppbody/2, 0]) 
        cube([boxx+(ppdia),boxy-(ppdiaoutset+7+ppbody/2), boxh]);
      openlog_clone_programmer_jig_clip();
    }

    /* Probe Access Cutout */
    translate([-5, ppdiaoutset+7, base_thickness+ppdia/2]) 
      cube([ppc * pps+10,ppbody/2, 10]);
      
    /* Module Cutout */
    translate([0, -0.001, 0]) 
      union()
      {     
        translate([0, 0,base_thickness]) 
          cube([boxx,pcb_thickness, boxh]);   
        translate([0, 0, base_thickness+ppdia/2]) 
          cube([boxx,ppdiaoutset, boxh]);
      }
      
    /* Probe */
    for ( xi = [0 : 1 : ppc-1] )
    {
      translate([pps/2+pps*xi, 0, base_thickness])
      union()
      {
        translate([0, ppdiaoutset, pcb_probe_offset+ppdiatol])
          rotate([90,0,0])
          probe_pin_req();
        
        translate([0, ppdiaoutset, pcb_probe_offset+ppdiatol])
          rotate([180,0,0])
            translate([0, (ppdiaoutset)/2, 0])
              cube([ppdia,(ppdiaoutset),ppdia+1], center=true);
      }
    }
    
    /* Wire Guide (To solder onto the probe) */
    #for ( xii = [0 : 1 : ppc-1] )
    {
      translate([pps/2+pps*xii, boxy+1, base_thickness+ppdia+1.5+pcb_probe_offset+ppdiatol])
        rotate([95,0,0])
          cylinder(r=1, h=15);
    }
  }
}

openlog_clone_programmer_jig();