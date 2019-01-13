
WorkBenchLength = 5*12;     //Length of Table
WorkBenchDepth = 24;        //Width of Table
WorkBenchHeight = 36;        //Total Height of WorkBench


//Stock Info
BoardWidth = 3.5;           //Width of Boards (Using 2x4s)
BoardThickness = 1.5;       //Thickness of Boards (Using 2x4s)
TableTopThickness = .75;    //Thickness of TableTop (Using 3/4 inch MDF)
ShelfTopThickness = .5;     //Thickness of ShelfTop (using 1/2 inch MDF)
CasterHeight = 4;          //how tall are your casters


//Calulated Values
RailLength = WorkBenchLength - (2 * BoardThickness);
BeamLength = WorkBenchDepth - (2 * BoardThickness);
NumberOfTableTopSupportBeams = 3;                                   //Number of Beams for support
NumberOfBottomShelfSupportBeams = 2;                                //Number of beams for the bottom shelf
LegHeight = WorkBenchHeight - CasterHeight - TableTopThickness;





module Draw2by4(boardLength)
{
    cube([boardLength,BoardThickness,BoardWidth]);
}

module DrawRails(depth, height)
{
    translate([0,0,height])
    Draw2by4(RailLength);
    translate([0,depth+BoardThickness,height])
    Draw2by4(RailLength);
}


module DrawBeams(numBeams, height)
{
    color("green")
    {
        totalBeams = 2 + numBeams;  //Account for "end" beams along with addition beams in between(numBeans)
        
        Debug("Total Beams", totalBeams);
        Debug("Rail Length", RailLength);
        Debug("Beam Step", RailLength / (totalBeams - 1));

        for(currentPosition = [BoardThickness: (RailLength - BoardThickness) / (totalBeams - 1) :RailLength + BoardThickness])
        {
            Debug("Current Beam Position" , currentPosition);
            
            translate([currentPosition,BoardThickness,height])
                rotate([0,0,90])
                    Draw2by4(BeamLength);
        }
    }
}

module DrawShelf(shelfHeight, numberOfBeams)
{
    DrawRails(BeamLength, shelfHeight);
    DrawBeams(numberOfBeams, shelfHeight);
}


module DrawLegs()
{
    translate([0,0,CasterHeight])
    {
        DrawLegs2();   
    }
}
module DrawLegs2()
{

    color("blue")
    {
        translate([BoardWidth,0,0])
            rotate([0,270,0])
                Draw2by4(LegHeight);
        
        translate([BoardWidth,BeamLength + (BoardThickness*3),0])
            rotate([0,270,0])
                Draw2by4(LegHeight);
    
        translate([RailLength + (BoardThickness * 2),0,0])
            rotate([0,270,0])
                Draw2by4(LegHeight);      
      
        translate([RailLength + (BoardThickness * 2),BeamLength + (BoardThickness * 3),0])
            rotate([0,270,0])
                Draw2by4(LegHeight);        
        
    }
    
    color("orange")
    {
        translate([0,BoardThickness,0])
            rotate([0,270,270])
                Draw2by4(LegHeight);

        translate([BoardThickness,BeamLength + (BoardThickness*3),0])
            rotate([0,270,90])
                Draw2by4(LegHeight);   
    
        translate([RailLength + BoardThickness,BoardThickness,0])
            rotate([0,270,270])
                Draw2by4(LegHeight);
                
        translate([RailLength + (BoardThickness * 2),BeamLength + (BoardThickness * 3),0])
            rotate([0,270,90])
                Draw2by4(LegHeight);    
    }
    
    
}

module DrawWorkBench()
{
    translate([BoardThickness,BoardThickness,CasterHeight]) // Make Room for Legs and Casters
    {
        Debug("Leg Height", LegHeight);
        //Drop Top
        Debug("*******TOP*******", "Begin");
        DrawShelf(LegHeight-BoardWidth, NumberOfTableTopSupportBeams);  //Place Top at top of Leg
        Debug("*******TOP*******", "End");

        Debug("*******Bottom Shelf*******", "Begin");
        DrawShelf(0, NumberOfBottomShelfSupportBeams);
        Debug("*******Bottom Shelf*******", "End");
    }
    DrawLegs();
}

module Debug(caption, message)
{
    echo(str("",caption,": " , message));
}

DrawWorkBench();