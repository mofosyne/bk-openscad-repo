/* Glow Ring Flat */

// Diameter Of Object To Wrap
inner = 30;

// thickness
thickness = 1;
height = 4;

// Cutout Size
cutout = 1;

// Flex Cuts
flexcut = 5;

/* Calc */
outer = inner+10;

difference()
{
  hull()
  {
    /* Main Disc */
    cylinder(r=outer/2, h=thickness);

    /* Side Lip */
    cylinder(r=(inner+2)/2, h=height);
  }
  
  /* Main Disc */
    #translate([0  , 0  , -thickness/2])cylinder(r=inner/2, h=(height+1));
    #translate([0  , -cutout/2  , -thickness/2])cube([inner/2+10, cutout, (height+1)]);

  /* Side Lip */
    rotate(0)
    #translate([-inner/2 -thickness -4 , -flexcut/2, thickness])cube([inner+thickness+10, flexcut, height+1]);

    rotate(90)
    #translate([-inner/2 -thickness -4 , -flexcut/2, thickness])cube([inner+thickness+10, flexcut, height+1]);
  
    rotate(45)
    #translate([-inner/2 -thickness -4 , -flexcut/2, thickness])cube([inner+thickness+10, flexcut, height+1]);


    rotate(90+45)
    #translate([-inner/2 -thickness -4 , -flexcut/2, thickness])cube([inner+thickness+10, flexcut, height+1]);
  
}

