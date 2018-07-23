radius = 16;
sides = 5;
thickness = 1.5;
bodyHeight = 25;
bodyTwist = 60;
bodyFlare = 1.8;
baseHeight=1;
rimHeight=1;

////////////////////////////////////////////////////
// Renders

//base
linear_extrude( height=baseHeight ){
    polyShape( solid = "yes");

}

//body
translate([0,0,baseHeight])
linear_extrude (height=bodyHeight, twist=bodyTwist, 
                scale = bodyFlare, slices=2*bodyHeight){
    
    polyShape( solid = "no");
}

//rim
translate([0,0,bodyHeight+baseHeight])
rotate(-bodyTwist)
scale(bodyFlare)
linear_extrude ( height=rimHeight)
    polyShape( solid = "no");



////////////////////////////////////////////////////
// Modules
module polyShape(solid){
    difference(){
        // start with outside shape
        offset( r=5, $fn=48)
            circle (r=radius, $fn=sides );
        
        
        // take away inside shape
        if (solid=="no"){
            offset( r=5 - thickness, $fn=48)
                circle (r=radius, $fn=sides );
        }
        

    }
}


