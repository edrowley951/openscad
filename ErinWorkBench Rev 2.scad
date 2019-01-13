
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
RailLength = WorkBenchLength - (2*BoardThickness);
BeamLength = WorkBenchDepth-(2*BoardThickness);
NumberOfTableTopSupportBeams = 1; //Number of Beams for support
LegHeight = WorkBenchHeight - CasterHeight - TableTopThickness;





module Draw2by4(boardLength)
{
    cube([boardLength,BoardThickness,BoardWidth]);
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

module DrawShelf(height)
{
    translate([0,0,height])
    Draw2by4(RailLength);
    translate([0,BeamLength+BoardThickness,height])
    Draw2by4(RailLength);
    DrawBeams(NumberOfTableTopSupportBeams, height);
}


module DrawWorkBench()
{
    translate([BoardThickness,BoardThickness,0]) // Make Room for Legs
    {
        Debug("Leg Height", LegHeight);
        //Drop Top
        Debug("*******TOP*******", "Begin");
        DrawShelf(LegHeight-BoardWidth);  //Place Top at top of Leg
        Debug("*******TOP*******", "End");

        Debug("*******Bottom Shelf*******", "Begin");
        DrawShelf(CasterHeight);
        Debug("*******Bottom Shelf*******", "End");
    }
}

module Debug(caption, message)
{
    echo(str("",caption,": " , message));
}

DrawWorkBench();