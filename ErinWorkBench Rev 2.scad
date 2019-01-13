//Draw Allted's Simple CNC Table based on input dimensions using openscad
//Translated into openscad on 4/4/2016  by: David Bunch
//
//The default dimensions are what I am using for a table, 48"Long x 36"Wide x 30"High
//This is drawn in Inches, set ScaleFactor variable to 25.4 to draw in millimeters
//Rev2 - revised for Quantity of Top Ledge Lengths if only 1 middle stiffener used
//Rev3 - Legs, Top Ledges & Shelf Ledges can be different Widths & thickness now
//       I made this change because I want to use 2x3's for the Shelf ledges
//Rev4 - Display Shelf Usable Heights with a visual cube for each shelf
//CUSTOMIZER VARIABLES
//If you want your MPCNC corners to be right at corners of table,
//Set Len & Wid the same as your CNC_LEN & CNC_Wid
WorkBenchLength = 5*12;                   //Length of Table
WorkBenchDepth = 24;                      //Width of Table
BoardWidth = 3.5;          //Width Legs (I am using 2x4)
BoardThickness = 1.5;   



RailLength = WorkBenchLength;
BeamLength = WorkBenchDepth-(2*BoardThickness);
NumberOfTopSupportBeams = 1; //Number of Beams for support


Caster_Height = 4;           //how tall are your casters
Total_Height = 36;           //Total height of the table (Including casters)
Ht = Total_Height - Caster_Height;                    //Height of Table at top of Ledges


module Draw2by4(boardLength)
{
    cube([boardLength,BoardThickness,BoardWidth]);
}

module DrawBeams(numBeams)
{
    color("green")
    {   
        totalBeams = 2 + numBeams;  //Account for "end" beams along with addition beams in between(numBeans)

        echo(str("** Total Beams: " , totalBeams));
        echo(str("** Rail Length: ", RailLength));
        echo(str("** Beam Step: ", RailLength / (totalBeams - 1)));

        for(currentPosition = [BoardThickness: (RailLength - BoardThickness) / (totalBeams - 1) :RailLength + BoardThickness])
            {
                echo(str("** Current Beam Position: " , currentPosition));
                
                translate([currentPosition,BoardThickness,0])
                    rotate([0,0,90])
                        Draw2by4(BeamLength);
            }
    }
}

module DrawTop()
{
    Draw2by4(WorkBenchLength);
    translate([0,BeamLength+BoardThickness,0])
    Draw2by4(WorkBenchLength);
    
    DrawBeams(NumberOfTopSupportBeams);

}

DrawTop();