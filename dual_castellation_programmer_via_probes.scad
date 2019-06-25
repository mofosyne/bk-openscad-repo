$fn=20;

/* Debug Clip Req */

bh = 2; // base thickness
st = 1.5; // side thickness
mt = 2; // middle thickness

/* probe pin spec */
ppext = 3; // Probe extention length
ppbody = 13; // Body of the probe
ppdia = 1; // probe pin diameter

ppdiatol = 0.8; // tolerance for fitting

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

mod_top_depth = 0; // Also means how much of the top to show
mod_pcb_thickness = 1;
mod_bottom_depth = 4;
modh = mod_top_depth + mod_pcb_thickness + mod_bottom_depth; // Module depth required

/* Clip */
clip_tab = 5; // Clip tab to more easily open the clip

/* pcb */
pcb_h = 2; // pcb thickness

/* calc */
boxx = fps + ppc * pps + pps-0.5;
boxy = st*2 + ppdia*2 + mody + (ppbody + ppext + 10) + modtol;
boxh = bh+mod_top_depth + mod_pcb_thickness + mod_bottom_depth+0.5;

ppexth = ppext/2;

module probe_pin_req()
{
  inset=ppext/2;
  translate([0,0,-ppbody-inset])
  union()
  {
    #cylinder(r=(ppdia+ppdiatol)/2, h=ppbody+inset);
    %color("gold") cylinder(r=ppdia/2, h=ppbody);
    %color("silver") translate([0,0,ppbody])
      cylinder(r=ppdia/2, r2=0, h=ppext);
  }
}

module half_dual_castellation_probe_programmer()
{
  pit_orgin = bh+modh+mt;
  pit_depth = boxh -bh - modh -mt;
  insert_pcb_offset = ppext*2/3;
  leglength = modcutx - 1;
  joint_spacing = 0.5;
  
  module clip_spring()
  {
      cube([6,cap_leg_t, 1 + pit_depth+insert_pcb_offset+pcb_h+5]);
      translate([0, 1.5 ,0])
      rotate([0,90,0])
        linear_extrude(height = 6)
          polygon([[0,0],[-2,-0.5],[-2,-1.5],[0, -2] ]);
  }
  
  union()
  {    

    /* Clip Body */
    difference() {
      union()
      {
        cube([boxx,boxy/2,boxh]);
      }

      /* Probe Access Cutout */
      translate([-1, 0, 0]) 
        union()
        {
          top_depth = bh + mod_pcb_thickness + mod_top_depth;
          translate([0,(ppbody/2)/2+(mody+modtol)/2,0])
          cube([modx+pps+1,ppbody/2, bh]);
        }

      /* Module Cutout */
      translate([-1, 0, 0]) 
        union()
        {
          top_depth = bh + (ppdia+ppdiatol)/2;
          cube([modx+pps+1,(mody)/2, top_depth]);
          translate([0, 0, top_depth]) 
          cube([modx+pps+1,(mody-ppdia*4)/2, mod_bottom_depth]);
        }

      /* Probe */
      for ( xi = [0 : 1 : ppc-1] )
      {
        translate([fps+pps*xi, 0, bh])
        union()
        {
          translate([0, (mody)/2, 0])
            rotate([90,0,0])
            probe_pin_req();
        }
      }
      
      /* Extra Probes On Top (I needed this for a specific board) */
      translate([fps+pps*ppc+pps/4, 0, bh])
      union()
      {
        for ( yi = [1 : 1 : 4] )
        {
          translate([0, (pps/4)+(pps*yi), 0])
            rotate([0,-90,0])
            probe_pin_req();
        }
      }
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

rotate([0,180,0])
dual_castellation_probe_programmer();