$fn=100;

/* Camera */
cam_dia = 10.5;


/* LED PCB */
ledpcb_tol=2;
ledpcbw = 26;
ledpcbh = 71.88-ledpcb_tol;
ledpcb_thickness = 3.47;
ledpcb_header_pos = 25;
ledpcb_header_w = 9;
holedia = (cam_dia + 8);

/* SMD LED */
led_tol=1;
ledh = 2.76-1.59+led_tol;
ledw = 4+led_tol;
ledd = 1.6+led_tol;

/* Thorough Hole LED */
ledpin_tol=1;
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
    holealld=ledh+ledpinh_hold+4;
    holderheight=10;
    difference()
    {
      union()
      {
        cubee(ledw+5,ledd+1,holderheight);
        cubee(ledpcbw-1,ledd+4,2);
      }
        // SMD
      translate([0,0,holderheight-holealld])
        cubee(ledw+2,ledh,holealld+0.1);
      translate([0,0,holderheight-holealld])
        cubee(1,100,holealld+0.1);
      
      // Through Hole
      translate([0,0,holderheight-ledpinh_hold+0.1])
        rotate([rotated,0,0])
        cylinder(r=ledpindia/2, h=ledpinh_hold+5);
      translate([ledpinpitch/2,0,0])
        cube([ledpinwiredia,ledpinwiredia,10], center=true);
      translate([-ledpinpitch/2,0,0])
        cube([ledpinwiredia,ledpinwiredia,10], center=true);
      
      // Underwire
      cube([1.5,ledpcbh+100,2], center=true);
      cube([ledpcbw*2/3,2,2], center=true);
      translate([ledpcbw*1/3,0,0])
        cube([ledpinwiredia,ledpinwiredia,10], center=true);
      translate([-ledpcbw*1/3,0,0])
        cube([ledpinwiredia,ledpinwiredia,10], center=true);
      translate([ledpcbw*1/3,0,0])
        cube([2,ledpcbh+100,2], center=true);
      translate([-ledpcbw*1/3,0,0])
        cube([2,ledpcbh+100,2], center=true);
    }

    if(0)
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
    
    cube([2,ledpcbh+100,2], center=true);
    translate([ledpcbw/3,0,0])
    cube([2,ledpcbh+100,2], center=true);
    translate([-ledpcbw/3,0,0])
    cube([2,ledpcbh+100,2], center=true);

    translate([0,0,3])
        cubee(ledpcbw-2,ledpcbh,100);
}

