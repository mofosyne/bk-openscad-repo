$fn=100;
/*

Object Name: Holder For TYPE-C or LIGHTNING and TRRS (e.g. Earphone Wraps) (OpenSCAD)
Author: Brian Khuu 2019

Here is few different sockets using OpenSCAD that you can consider using in your projects if you need to have TYPE-C or LIGHTNING and TRRS. For example you are creating an earphone wrap which requires a mounting point for the earphone audio connector.

*/



/*********************************************
  TYPE-C LIGHTNING TRRS
**********************************************/


module plug_socket(plugdia, pluglength, plugdepth, outerdia, outerheight, sideshift)
{
  translate([0, -sideshift,0])
  difference()
  {
    union()
    {
      difference()
      {
        hull()
        {
          translate([0,(pluglength-plugdia)/2,0])
            cylinder(r = outerdia/2, outerheight);
          translate([0,-(pluglength-plugdia)/2,0])
            cylinder(r = outerdia/2, outerheight);
          
          /* Side Shift */
          translate([0,(pluglength-plugdia)/2 + sideshift,0])
            cylinder(r = outerdia/2, outerheight);
        }
      }
    }
    
    /* Socket Align cut */
    translate([0,0,outerheight])
      hull()
      {
        translate([0,(pluglength-plugdia)/2,0])
          cylinder(r=(outerdia/2), 1);
        translate([0,-(pluglength-plugdia)/2,0])
          cylinder(r=(outerdia/2), 1);
        translate([0,(pluglength-plugdia)/2,-1])
          cylinder(r=(plugdia/2), 1);
        translate([0,-(pluglength-plugdia)/2,-1])
          cylinder(r=(plugdia/2), 1);
      }

    /* Socket Cut */
    translate([0,0,outerheight-plugdepth])
      hull()
      {
        translate([0,(pluglength-plugdia)/2,0])
          cylinder(r=(plugdia/2), plugdepth+1);
        translate([0,-(pluglength-plugdia)/2,0])
          cylinder(r=(plugdia/2), plugdepth+1);
      }
    
    /* top wire wrap cut */
    difference()
    {
      hull()
      {
        translate([0,0,outerheight])
          cube( [outerdia+1, pluglength*2/3, 0.1], center=true);
        translate([0,0,outerheight-plugdepth+1])
          rotate([0,90,0])
            cylinder(r=1, outerdia, center=true);
      }
      
      // Enable to cut only on one side
      if (0)
      rotate([0,0,180])
        translate([(outerheight+4)/2,0,(outerheight+2)/2])
          cube((outerheight+4), center=true); 
    }
  }
}

module typec_socket(outerdia, outerheight, sideshift, tol)
{
  typec_plugdia    = 2.5;
  typec_pluglength = 8.3;
  typec_plugdepth  = 6.5;
  plug_socket(
      typec_plugdia+tol,
      typec_pluglength+0.5+tol,
      typec_plugdepth+tol,
      outerdia, outerheight, sideshift
    );
}

module lightning_socket(outerdia, outerheight, sideshift, tol)
{
  lightning_plugdia    = 1.5;
  lightning_pluglength = 6.7;
  lightning_plugdepth  = 6.7; 
  plug_socket(
      lightning_plugdia+tol,
      lightning_pluglength+0.5+tol,
      lightning_plugdepth+tol,
      outerdia, outerheight, sideshift
    );
}


module trrs_socket(outerdia, outerheight, sideshift, tol)
{
  trrs_plugdia    = 3.5;
  trrs_pluglength = 3.5;
  trrs_plugdepth  = 15;
  plug_socket(
      trrs_plugdia+tol,
      trrs_pluglength+0.5+tol,
      trrs_plugdepth+tol,
      outerdia, outerheight, sideshift
    );
}

/*********************************************
  TYPE-C LIGHTNING (Combined with TRRS)
**********************************************/

module plug_inc_trrs_socket(plugdia, pluglength, plugdepth, outerdia, outerheight, sideshift)
{
  trrs_plugdia    = 3.5-0.01; //Make slightly smaller for snug fit
  trrs_plugdepth  = 15;

  translate([0, -sideshift,0])
  difference()
  {
    union()
    {
      difference()
      {
        hull()
        {
          translate([0,(pluglength-plugdia)/2,0])
            cylinder(r = outerdia/2, outerheight);
          translate([0,-(pluglength-plugdia)/2,0])
            cylinder(r = outerdia/2, outerheight);
          
          /* Side Shift */
          translate([0,(pluglength-plugdia)/2 + sideshift,0])
            cylinder(r = outerdia/2, outerheight);
        }
      }
    }
    
    /* Socket Align cut */
    translate([0,0,outerheight])
      hull()
      {
        translate([0,(pluglength-plugdia)/2,0])
          cylinder(r=(outerdia/2), 1);
        translate([0,-(pluglength-plugdia)/2,0])
          cylinder(r=(outerdia/2), 1);
        translate([0,(pluglength-plugdia)/2,-1])
          cylinder(r=(plugdia/2), 1);
        translate([0,-(pluglength-plugdia)/2,-1])
          cylinder(r=(plugdia/2), 1);
      }

    /* TRRS Cut */
    translate([0,0,outerheight])
    hull()
    {
      translate([0,0,-plugdepth])
      cylinder(r=(trrs_plugdia)*2/3, plugdepth);
      translate([0,0,-plugdepth-1])
      cylinder(r=(trrs_plugdia/2), 1);
    }
    translate([0,0,outerheight-trrs_plugdepth])
      cylinder(r=(trrs_plugdia/2), trrs_plugdepth+1);

    /* Socket Cut */
    translate([0,0,outerheight-plugdepth])
      hull()
      {
        translate([0,(pluglength-plugdia)/2,0])
          cylinder(r=(plugdia/2), plugdepth+1);
        translate([0,-(pluglength-plugdia)/2,0])
          cylinder(r=(plugdia/2), plugdepth+1);
      }
    
    /* top wire wrap cut */
    difference()
    {
      hull()
      {
        translate([0,0,outerheight])
          cube( [outerdia+1, trrs_plugdia*2/3, 0.1], center=true);
        translate([0,0,outerheight-trrs_plugdepth+1])
          rotate([0,90,0])
            cylinder(r=1, outerdia, center=true);
      }
      
      // Enable to cut only on one side
      if (0)
      rotate([0,0,180])
        translate([(outerheight+4)/2,0,(outerheight+2)/2])
          cube((outerheight+4), center=true); 
    }
  }
}



module typec_trrs_socket(outerdia, outerheight, sideshift, tol)
{
  typec_plugdia    = 2.5;
  typec_pluglength = 8.3;
  typec_plugdepth  = 6.5;
  plug_inc_trrs_socket(
      typec_plugdia+tol,
      typec_pluglength+0.5+tol,
      typec_plugdepth+tol,
      outerdia, outerheight, sideshift
    );
}

module lightning_trrs_socket(outerdia, outerheight, sideshift, tol)
{
  lightning_plugdia    = 1.5;
  lightning_pluglength = 6.7;
  lightning_plugdepth  = 6.7;
  plug_inc_trrs_socket(
      lightning_plugdia+tol,
      lightning_pluglength+0.5+tol,
      lightning_plugdepth+tol,
      outerdia, outerheight, sideshift
    );
}


/*********************************************
  EXAMPLES
**********************************************/

translate([0,-20,0])
union()
{
  %translate([10,-5,0])text("Type-C");
  typec_socket(6, 8, 0, 0);
}

translate([0,-40,0])
union()
{
  %translate([10,-5,0])text("Lightning");
  lightning_socket(6, 8, 0, 0);
}

translate([0,0,0])
union()
{
  %translate([10,-5,0])text("TRRS");
  trrs_socket(6, 20, 0, 0);
}

translate([0,+20,0])
union()
{
  %translate([10,-5,0])text("Type-C  (With TRRS)");
  typec_trrs_socket(6, 20, 0, 0);
}

translate([0,+40,0])
union()
{
  %translate([10,-5,0])text("Lightning (With TRRS)");
  lightning_trrs_socket(6, 20, 0, 0);
}

