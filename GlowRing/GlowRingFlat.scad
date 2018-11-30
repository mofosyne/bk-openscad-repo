/* Glow Ring Flat (Brian Khuu 2018) (Use with glow in the dark filament) */

// Diameter Of Object To Wrap
inner = 20;

// thickness
thickness = 1;
height = 30;

// Cutout Size
cutout = 1;

// Flex Cuts
flexcut = 5;

/* Calc */
outer = inner+10;

/* Object */
union()
{
translate([0  , 0  , height-thickness]){
  difference()
  {
    cylinder(r=(inner+2)/2, h=thickness);
    translate([0  , 0  ,-thickness/2])
      cylinder(r=(inner+2)/2 - 1, h=thickness*2);
    translate([0, -flexcut/2, -thickness/2])cube([inner+thickness+10, flexcut, thickness*2]);
  }
}

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
    translate([0  , 0  , -thickness/2])cylinder(r=inner/2, h=(height+1));
    translate([0  , -cutout/2  , -thickness/2])cube([inner/2+10, cutout, (height+1)]);

  /* Side Lip */
    rotate(0)
    translate([-inner/2 -thickness -4 , -flexcut/2, thickness])cube([inner+thickness+10, flexcut, height+1]);

    rotate(90)
    translate([-inner/2 -thickness -4 , -flexcut/2, thickness])cube([inner+thickness+10, flexcut, height+1]);
  
    rotate(45)
    translate([-inner/2 -thickness -4 , -flexcut/2, thickness])cube([inner+thickness+10, flexcut, height+1]);


    rotate(90+45)
    translate([-inner/2 -thickness -4 , -flexcut/2, thickness])cube([inner+thickness+10, flexcut, height+1]);
}
}

/* Cylinder To Wrap Around */
translate([0, 0, -10])
%cylinder(r=inner/2, h=20);

