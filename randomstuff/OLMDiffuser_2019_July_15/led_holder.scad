$fn=100;

/* Camera */
cam_dia = 10.5;


/* LED PCB */
ledpcb_tol=0.5;
ledpcbw = 26.7-ledpcb_tol;
ledpcbh = 71.88-ledpcb_tol;
ledpcb_thickness = 3.47;
ledpcb_header_pos = 25;
ledpcb_header_w = 9;
holedia = (cam_dia + 8);

/* SMD LED */
led_tol=0.5;
ledh = 2.76-1.59+led_tol;
ledw = 4+led_tol;
ledd = 1.6+led_tol;

/* Thorough Hole LED */
ledpin_tol=0.5;
ledpinwiredia=0.5+ledpin_tol;
ledpinpitch=2+ledpin_tol;
ledpinh=8.2+ledpin_tol;
ledpindia=5.6+ledpin_tol;

module cubee(x,y,z)
{
    translate([0,0,z/2])
        cube([x,y,z], center=true);
}
module led_holder(rotated)
{
    ledpinh_hold=1;
    holealld=ledh+ledpinh_hold;
    holderheight=6;
    difference()
    {
      union()
      {
        cubee(ledw+2,ledd+1,holderheight);
        cubee(ledpcbw,ledd+1,1);
      }
        // SMD
      translate([0,0,holderheight-holealld])
        cubee(ledw,ledh,holealld+0.1);
      translate([0,0,holderheight-holealld])
        cubee(100,0.5,holealld+0.1);
      
      // Through Hole
      translate([0,0,holderheight-ledpinh_hold+0.1])
        rotate([rotated,0,0])
        cylinder(r=ledpindia/2, h=ledpinh_hold+5);
      translate([ledpinpitch/2,0,0])
        cylinder(r=ledpinwiredia/2, h=10, center=true);
      translate([-ledpinpitch/2,0,0])
        cylinder(r=ledpinwiredia/2, h=10, center=true);
      
      // Underwire
       cube([1,ledpcbh+100,1], center=true);
       cube([ledpcbw/2,1,1], center=true);
      translate([ledpcbw/4,0,0])
        cylinder(r=ledpinwiredia/2, h=10, center=true);
      translate([-ledpcbw/4,0,0])
        cylinder(r=ledpinwiredia/2, h=10, center=true);

    }

    %translate([0,0,holderheight-ledpinh_hold+0.1])
        rotate([rotated,0,0])
        cylinder(r=ledpindia/2, h=ledpinh_hold,center=true);
}

translate([0,ledpcbh/2-4,0])
    led_holder(10);
translate([0,-ledpcbh/2+4,0])
    rotate([0,0,180])
    led_holder(10);


difference()
{
    union()
    {
        cubee(ledpcbw,ledpcbh,1);
        hull()
        {
            translate([0,0,5])
                cubee(ledpcbw-2,ledpcbh-2,1);
            translate([0,0,3])
                cubee(ledpcbw,ledpcbh-2,1);
            cubee(ledpcbw-2,ledpcbh-2,1);
        }
        cubee(ledpcbw-1,ledpcbh-1,5);
        cubee(ledpcbw-10,ledpcbh+10,0.5);
    }
    cube([ledpcbw-2,ledpcbh-2,100], center=true);
    
    cube([1,ledpcbh+100,2], center=true);
    translate([ledpcbw/3,0,0])
    cube([1,ledpcbh+100,2], center=true);
    translate([-ledpcbw/3,0,0])
    cube([1,ledpcbh+100,2], center=true);

    translate([0,0,3])
        cubee(ledpcbw-2,ledpcbh,100);
}

