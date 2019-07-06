$fn=20;
/*
  Edge Header Programmer Clip Via Probes (e.g. OpenLog Clone)
  Author: Brian Khuu 2019
  
  This is originally designed for connecting to OpenLog Clones
  
  I used P100-E2 probes for this
  
  Note: The purple openlog clone Programmer Port essentally has [GND, RST, SCK, M0, M1, Vin]

*/

/* [Feature Selection] */
PCB_probe_clip_grip_enable = true;
PCB_probe_align_enable = false;

/* [Properties] */
// Designed For Printer Nozzle
printer_nozzle=0.4;

// Base Thickness
base_thickness = 0.2;

/* probe pin spec */
ppext = 8; // Probe extention length
ppbody = 25; // Body of the probe
ppdia = 1.5; // probe pin diameter

ppdiatol = 0.6; // tolerance for fitting
ppinset = 0.5;

ppdiaoutset = ppext-ppinset; // How far to space out to allow for side fits

/* PCB Pin Spacing and count */

// Pin Count
ppc = 6;

// Pin Spacing
pps = 2.54;

// PCB Thickness
pcb_thickness = 1.1; // 1mm Open Log Clone

// PCB Probe Offset (Bottom)
pcb_probe_offset = 1.3;

// PCB Probe Offset (Side)
pcb_probe_side_offset = 0;

/* Clip */
clip_tab = 5; // Clip tab to more easily open the clip

/* pcb */
pcb_h = 2; // pcb thickness

/* calc */
boxx = ppc * pps + ppdia;
boxy = 2 + ppbody + ppdiaoutset;
boxh = base_thickness+pcb_probe_offset+ppdiatol+5;

supported_pcb_size = pcb_probe_side_offset*2+boxx;

module probe_pin_req()
{
  inset=0;
  translate([0,0,-ppbody])
  union()
  {
    translate([0,0,0])
      cylinder(r1=(ppdia)/2,r2=(ppdia+ppdiatol)/2, h=3);
    translate([0,0,1])
      cylinder(r=(ppdia+ppdiatol)/2, h=ppbody+ppext+1);
    %color("gold") cylinder(r=ppdia/2, h=ppbody);
    %color("silver") translate([0,0,ppbody])
      cylinder(r=ppdia/2, r2=0, h=ppext);
  }
}

module openlog_clone_programmer_jig_clip()
{
  grip_gap=6;
  grip_thickness=printer_nozzle*7;
  grip_height=base_thickness+pcb_probe_offset+ppdiatol+ppdia;

  if (PCB_probe_clip_grip_enable)
  {
    translate([-grip_gap-grip_thickness,-1,0])
      cube([grip_thickness,boxy,grip_height]);
    translate([grip_gap+boxx,-0.5,0])
      cube([grip_thickness,boxy,grip_height]);
  }

  difference()
  {
    translate([-grip_gap-grip_thickness,0,0])
      cube([boxx+grip_gap*2+grip_thickness*2,boxy/3,grip_height]);
    translate([-grip_gap,-3,-1])
      cube([boxx+grip_gap*2,boxy/3,grip_height+2]);
  }
  translate([-(grip_thickness*2+grip_gap*2)/2,-0.5,0])
    hull()
    {
      translate([0,0,0])
        cube([(grip_thickness+grip_gap+ppdia-pcb_probe_side_offset),0.1,grip_height]);
      translate([0,-5,0])
        cube([0.1,0.1,grip_height]);
      translate([(grip_thickness+grip_gap+ppdia-pcb_probe_side_offset),-1,0])
        cube([0.1,0.1,grip_height]);
    }
  translate([(grip_thickness*2+grip_gap*2)/2+boxx,-0.5,0])
    hull()
    {
      translate([-(grip_thickness+grip_gap+ppdia-pcb_probe_side_offset),0,0])
        cube([(grip_thickness+grip_gap+ppdia-pcb_probe_side_offset),0.1,grip_height]);
      translate([-0.1,-5,0])
        cube([0.1,0.1,grip_height]);
      translate([-(grip_thickness+grip_gap+ppdia-pcb_probe_side_offset),-1,0])
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
        translate([0,0,-1])
          cube([4,pcb_thickness*2,boxh],center=true);
        translate([boxx,0,-1])
          cube([4,pcb_thickness*2,boxh],center=true);
      }
      translate([-(ppdia)/2, ppdiaoutset+7+ppbody/2, 0]) 
        cube([boxx+(ppdia),boxy-(ppdiaoutset+7+ppbody/2), boxh]);
      openlog_clone_programmer_jig_clip();
    }

    /* Probe Access Cutout */
    translate([-5, ppdiaoutset+7, base_thickness+pcb_probe_offset+ppdia/2]) 
      cube([ppc * pps+10,ppbody/2, boxh]);
      
    /* Module Cutout */
    translate([0, -0.001, 0]) 
      union()
      {
        if(PCB_probe_align_enable)
        {
          translate([0, 0,base_thickness]) 
            cube([boxx,pcb_thickness, boxh]);
        }
        else
        {
          translate([0, 0,-base_thickness/2]) 
            cube([boxx,pcb_thickness, boxh]);
        }
        
        translate([0, 0, base_thickness+ppdia+ppdiatol]) 
          cube([boxx,ppdiaoutset, boxh]);
      }
      
    /* Probe */
    for ( xi = [0 : 1 : ppc-1] )
    {
      translate([ppdia/2+pps/2+pps*xi, 0, base_thickness])
      union()
      {
        translate([0, ppdiaoutset, pcb_probe_offset+ppdiatol])
          rotate([90,0,0])
          probe_pin_req();
        
        translate([0, ppdiaoutset, pcb_probe_offset+ppdiatol])
          rotate([180,0,0])
            translate([0, (ppdiaoutset)/2, 0])
              cube([ppdia+ppdiatol,(ppdiaoutset),ppdia+1], center=true);
      }
    }
    
    /* Wire Guide (To solder onto the probe) */
    for ( xii = [0 : 1 : ppc-1] )
    {
      translate([ppdia/2+pps/2+pps*xii, boxy+1, base_thickness+ppdia+1.5+pcb_probe_offset+ppdiatol])
        rotate([95,0,0])
          cube([2,2.5,20],center=true);
    }
  }
}

openlog_clone_programmer_jig();

/* Visualisation */
%translate([boxx/2,pcb_thickness/2,base_thickness+pcb_probe_offset])
  cube([supported_pcb_size,pcb_thickness,1], center=true);
echo("##Supported PCB Length:",supported_pcb_size);
