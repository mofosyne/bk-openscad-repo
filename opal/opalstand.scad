$fn = 40;

module oval_stand(oval_w, oval_l, oval_base_depth, inaccuracy)
{
  // calc
  oval_w_ina = oval_w + inaccuracy;
  oval_l_ina = oval_l + inaccuracy;

  base_w_ina = oval_w*2;
  base_l_ina = oval_l*2;
  height = oval_w_ina*0.8;
  
  module ovalshape(w,l,h)
  {
    linear_extrude(h)
      resize(newsize=[w,l,1]) 
        circle(r=1);
  }
  
  difference()
  {
    hull()
    {
      ovalshape(base_w_ina*2, base_l_ina*2, 0.1);
      
      translate([0,0,height])
        rotate([10,0,0])
          ovalshape(oval_w_ina, oval_l_ina, 1);
    }
    
    #translate([0,0,height])
      rotate([10,0,0])
        ovalshape(oval_w_ina, oval_l_ina, oval_base_depth);
  }
}


oval_stand(2,5,1,1);