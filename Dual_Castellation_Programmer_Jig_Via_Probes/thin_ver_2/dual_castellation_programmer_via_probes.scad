$fn=20;
/*
  Dual Castellation Programmer Jig Via Probes
  Author: Brian Khuu 2019
  
  Allows for quick connects without soldering to castellation based PCBs. This is useful for testing or quick programming.
  
  C10-34-10
  
*/

base_thickness = 1; // Base thickness
bh = 2; // Top thickness
st = 2; // side thickness
mt = 2; // middle thickness

/* probe pin spec */
ppext = 3; // Probe extention length
ppbody = 13; // Body of the probe
ppdia = 1; // probe pin diameter

ppdiatol = 0.5; // tolerance for fitting
ppinset = 1;

ppdiaoutset = ppext-ppinset; // How far to space out to allow for side fits

echo(ppdiaoutset);

/* Castellated Module Pin Spacing and count */
ppc = 18; // pin pair count
pps = 2.54; // spacing between each pair of probes
fps = 3; //first probe spacing from bottom of module

/* Castellated Module */
modtol = 0.4; // module dimentions tolerance
modx = 49.4; // module x length
mody = 27.5; // module y length
modcutx = 48.3; // module y length cutout area
modcuty = 18.9; // module y length cutout area

mod_side_clearance = 2.5; // Too large and you can't slide the pcb into the jig if there is parts on the bottom. Too small and you don't have support.
mod_pcb_thickness = 0.8; //0.8
mod_bottom_depth = 4;
modh = mod_pcb_thickness + mod_bottom_depth+1.5; // Module depth required

/* Clip */
clip_tab = 5; // Clip tab to more easily open the clip

/* pcb */
pcb_h = 2; // pcb thickness

/* calc */
boxx = fps + ppc * pps + pps-0.5;
boxy = st*2 + mody + (ppbody + ppdiaoutset)*2;
boxh = bh+modh+base_thickness;

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

module half_dual_castellation_probe_programmer()
{
  /* Module Visualisation */
  %translate([0, 0, base_thickness+mod_bottom_depth+ppdiatol/2])color("green",0.25) cube([modx+pps,(mody)/2, mod_pcb_thickness]);

  /* Clip Body */
  difference() {
    
    /* Bulk */
    cube([boxx,boxy/2,boxh]);

    /* Probe Access Cutout */
    translate([-1, 5, base_thickness+mod_bottom_depth+ppdia/2]) 
      union()
      {
        translate([0,(mody+modtol)/2+1,0])
          cube([modx+pps+1,ppbody*1/3, 10]);
      }
      
    translate([-1, 0, 0]) 
      union()
      {     
        translate([0, (mody+modtol)/2+0.5, base_thickness+mod_bottom_depth+ppdia+1]) 
          cube([modx+pps+1,6, mod_bottom_depth]);   
      }

    /* Module Cutout */
    translate([-1, 0, 0]) 
      union()
      {     
        translate([0, 0,base_thickness]) 
          cube([modx+pps+1,(mody-mod_side_clearance)/2, mod_bottom_depth]);   
        translate([0, 0, base_thickness+mod_bottom_depth]) 
          cube([modx+pps+1,(mody)/2+ppdiaoutset, 10]);
      }
      
    /* Probe */
    for ( xi = [0 : 1 : ppc-1] )
    {
      translate([fps+pps*xi, 0, base_thickness+mod_bottom_depth+ppdiatol/2])
      union()
      {
        translate([0, (mody)/2+ppdiaoutset, mod_pcb_thickness/2])
          rotate([90,0,0])
          probe_pin_req();
        
        //if(0)
        translate([0, (mody)/2+ppdiaoutset, mod_pcb_thickness/2])
          rotate([180,0,0])
            translate([0, ((mody)/2+ppdiaoutset)/2, 0])
              cube([ppdia,((mody)/2+ppdiaoutset),ppdia+1], center=true);
      }
    }
    
    /* Wire Guide (To solder onto the probe) */
    for ( xii = [0 : 1 : ppc-1] )
    {
      translate([fps+pps*xii, boxy/2+1, base_thickness+mod_bottom_depth+ppdia+1.5])
        rotate([93,0,0])
          cylinder(r=(1.6)/2, h=10);
    }
  }
}


module dual_castellation_probe_programmer()
{
  union()
  {
    mirror([0,0,0]) half_dual_castellation_probe_programmer();
    mirror([0,1,0]) half_dual_castellation_probe_programmer();
  }
}

dual_castellation_probe_programmer();