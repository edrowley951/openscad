$fn = 50;

difference()
{
    minkowski(){
        cube([20,40,20], center = true);
        sphere(1);
    }

//Chop off the top
    translate([0,0,10]) cube([26,46,20], center = true);




//hollow inside

    minkowski(){
        cube([16,36,16], center = true);
        sphere(1);
    }


    translate([0,0,-2]){
        linear_extrude(4){
            minkowski(){

                square([18,38], center = true ); 
                circle(1);
            }
        }
    }
}
