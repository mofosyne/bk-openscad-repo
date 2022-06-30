


input_scaledownFactor = 1; ///< 1:100 --> 1m : 1m
//input_scaledownFactor = 100; ///< 1:100 --> 1m : 1cm
//input_scaledownFactor = 50; ///< 1:50 --> 1m : 2cm
//input_scaledownFactor = 25; ///< 1:25 --> 1m : 4cm

output_scaledownFactor = 1; ///< 1:100 --> 1m : 1m
//output_scaledownFactor = 100; ///< 1:100 --> 1m : 1cm
//output_scaledownFactor = 50; ///< 1:50 --> 1m : 2cm
//output_scaledownFactor = 25; ///< 1:25 --> 1m : 4cm

scaling=input_scaledownFactor/output_scaledownFactor;

realHeight = 0.6;
scaledHeight = realHeight/output_scaledownFactor;


intersection()
{
    //rotate([90,0,90])
    linear_extrude(height = scaledHeight, center = true)
        scale([scaling,scaling,1])
        //translate([1000/2,0,100])
        import("directionArrow.svg"); 
}