/*
  Fridge Leaflet Holder
  By Brian Khuu 2019

  This requires the use of double sided adhesives to attach this leaflet holder to the fridge
*/

// Leaflet Holder Specifictions
holder_wall_thickness=0.8; /* Thickness of walls */
holder_base_thickness=0.8; /* Thickness of base */
holder_hole_size=8; /* Size of the leaflet holder */

// Leaflet Reference Dimentions
leaflet_w=115;//mm (e.g. letter width is around 110mm )
leaflet_l=220;//mm

// Calc
holder_w=leaflet_w+holder_wall_thickness*2;
holder_l=leaflet_l/3;

supported=false;

module leafletholder()
{
  union()
  {
    difference()
    {
      hull()
      {
        cube([holder_w,holder_l,holder_hole_size+holder_base_thickness*2], center=true);
        translate([0,10,holder_hole_size/2+holder_base_thickness/2])
          cube([holder_w,holder_l+10,holder_base_thickness], center=true);
      }
      translate([0,holder_wall_thickness+100/2,0])
        cube([leaflet_w,holder_l+100,holder_hole_size], center=true);
    }
    if(supported)
    {
      translate([0,(holder_l)/2+15,0])
        cube([holder_w,0.5,holder_hole_size+holder_base_thickness*2], center=true);
      translate([0,(holder_l)/2+15,-holder_hole_size/2-holder_base_thickness])
        cube([holder_w,5,0.1], center=true);
    }
  }
}

if(!supported)
{
  rotate([90,0,0]) leafletholder();
}
else
{
  leafletholder();
}