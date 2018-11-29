$fn=20;

/* Debug Clip Req */

bh = 2; // base thickness
st = 4; // side thickness
mt = 2; // middle thickness

/* probe pin spec */
ppext = 3; // Probe extention length
ppbody = 13; // Body of the probe
ppdia = 1; // probe pin diameter

ppdiatol = 0.4; // tolerance for fitting

/* Castellated Module Pin Spacing and count */
ppc = 18; // pin pair count
pps = 2.54; // spacing between each pair of probes
fps = 4; //first probe spacing from bottom of module

/* Castellated Module */
modtol = 1.5; // module dimentions tolerance
modx = 49.4; // module x length
mody = 27.5; // module y length
modcutx = modx; // module y length cutout area
modcuty = 18.83; // module y length cutout area

mod_top_depth = 2; // Also means how much of the top to show
mod_pcb_thickness = 2;
mod_bottom_depth = 4;
modh = mod_top_depth + mod_pcb_thickness + mod_bottom_depth; // Module depth required


/* pcb */
pcb_h = 2; // pcb thickness

/* Cap */
cap_hook_dia = 2;
cap_tol = 1;
cap_leg_t = 1;
standoff = 0;

/* calc */
boxx = fps + ppc * pps;
boxy = st*2 + mody;
boxh = bh+ppbody;

clip_bodyx = boxx;
clip_bodyy = boxy;

ppexth = ppext/2;

module probe_pin_req()
{
  union()
  {
    #cylinder(r=(ppdia+ppdiatol)/2, h=ppbody);
    %color("gold") cylinder(r=ppdia/2, h=ppbody);
    %color("silver") translate([0,0,ppbody])
      cylinder(r=ppdia/2, r2=0, h=ppext);
  }
}


module half_dual_castellation_probe_clip()
{
  pit_orgin = bh+modh+mt;
  pit_depth = boxh -bh - modh -mt;
  insert_pcb_offset = ppext*2/3;
  leglength = boxx - 1;
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
    /* PCB Cutout visualisation */
    translate([0, (modcuty)/2, bh+ppbody+insert_pcb_offset])
    {          
      %color("green", 0.1)cube([modcutx,10,pcb_h]);
    }
    
    /* Clip Leg */
    translate([0, -(standoff/2), pit_orgin])
    {
      /* Indicates the clearance*/
      %translate([0, (modcuty)/2, 0]) cube([leglength,0.1, 10]);
      
      /* Hook */
      translate([0, (modcuty)/2-1, pit_depth+insert_pcb_offset+pcb_h])
        union()
      {
        rotate([0,90,0])
          linear_extrude(height = leglength)
            polygon([[0, 3], [0,2],[-5,0],[-5,1]]);
        translate([0, 0, 2])
          cube([leglength,cap_leg_t, 3]);
      }
      
      /* Spring */
      translate([0, (modcuty)/2-(cap_leg_t), -1])
        union()
        {
          translate([0, 0, 0])
            clip_spring();
          translate([leglength/2-3, 0, 0])
            clip_spring();
          translate([leglength-6, 0, 0])
            clip_spring();
        }


    }

    /* Clip Body */
    difference() {
      union()
      {
        cube([boxx,boxy/2,boxh]);
      }

      /* Clip bend cutout */
      translate([-1, 0, bh+modh+mt]) 
          cube([boxx+2, (mody+modtol-ppdia*4)/2, boxh -bh - modh -mt + 1]);

      /* Module Cutout */
      #translate([-1, 0, 0]) 
        union()
        {
          top_depth = bh + mod_pcb_thickness + mod_top_depth;
          cube([modx+2,(mody+modtol)/2, top_depth]);
          #translate([0, 0, top_depth]) 
          cube([modx+2,(mody+modtol-ppdia*4)/2, mod_bottom_depth]);
        }

      /* Probe */
      for ( xi = [0 : 1 : ppc-1] )
      {
        translate([fps+pps*xi, 0, bh])
        union()
        {
          translate([0, (mody+modtol)/2, 0])
            probe_pin_req();
        }
      }
    }
  }
}

module dual_castellation_probe_clip()
{
  union()
  {
    mirror([0,0,0]) half_dual_castellation_probe_clip();
    mirror([0,1,0]) half_dual_castellation_probe_clip();
  }
}

rotate([0,-90,0])
dual_castellation_probe_clip();