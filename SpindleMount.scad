$fn = 150;

fudge = 0.01;


//CompleteBracketRotoZIP();

CompleteBracketDWP611();


// Section for Exporting Each Part

// DWP611 Mounting Brackets
//difference () {
// RotoZipHolderBracket(RotoZipDia=69.00,BlockoutFront=true,BlockoutBack=false,RearMountOffset=70);
//    translate([0,50,68.01])
//    rotate([0,180,0])
//    M5ScrewHole(25,Nut=false,ScrewDia=5);

//    translate([0,50,-.01])
//  rotate([0,0,0])
//    M5ScrewHole(25,Nut=false,ScrewDia=5);
//  }

//RotoZipHolderBracket(RotoZipDia=69.00,BlockoutFront=false,BlockoutBack=true,RearMountOffset=70);

//CenterBracket(RearMountOffset=70);

// =====================
module CenterBracket(RearMountOffset=70) {
// =====================

  difference () {
    union() {
      translate([0,0,0])
        RearSupport(RearMountOffset);
    }

    translate([0,50,68.01])
    rotate([0,180,0])
    M5ScrewHole(25,Nut=false,ScrewDia=5);

    translate([0,50,-.01])
    rotate([0,0,0])
    M5ScrewHole(25,Nut=false,ScrewDia=5);
  }

}

// ===============================================
module CompleteBracketDWP611() {
// ===============================================

  difference () {
    union() {
      translate([0,0,50])
        RotoZipHolderBracket(RotoZipDia=69.00,BlockoutFront=false,BlockoutBack=false,RearMountOffset=70);

      translate([0,0,0])
        RotoZipHolderBracket(RotoZipDia=69.00,BlockoutFront=false,BlockoutBack=false,RearMountOffset=70);

      translate([0,0,0])
        RearSupport(RearMountOffset=70);
    }

    translate([0,50,68.01])
    rotate([0,180,0])
    M5ScrewHole(25,Nut=false,ScrewDia=5);

    translate([0,50,-.01])
    rotate([0,0,0])
    M5ScrewHole(25,Nut=false,ScrewDia=5);
  }

}

// ===============================================
module CompleteBracketRotoZIP() {
// ===============================================

  difference () {
    union() {
      translate([0,0,50])
        RotoZipHolderBracket(RotoZipDia=69.80,BlockoutFront=false,BlockoutBack=false);

      translate([0,0,0])
        RotoZipHolderBracket(RotoZipDia=67.40,BlockoutFront=false,BlockoutBack=false);

      translate([0,0,0])
        RearSupport();
    }

    translate([0,50,68.01])
    rotate([0,180,0])
    M5ScrewHole(25,Nut=false,ScrewDia=5);

    translate([0,50,-.01])
    rotate([0,0,0])
    M5ScrewHole(25,Nut=false,ScrewDia=5);
  }

}

// ===============================================
module RearSupport (RearMountOffset=60) {
// ===============================================

  SupportWidth     = 35;
  SupportHeight    = 50-(2*(18/2));
  SupportThickness = RearMountOffset - 35;


     difference() {
       translate([-SupportWidth/2,RearMountOffset-SupportThickness,18])
        cube([SupportWidth,SupportThickness,SupportHeight]);

       // Center Screw Access Holes
       translate([20/2,4,18+(SupportHeight/2)])
       rotate([-90,0,0])
       cylinder(r=12/2,h=RearMountOffset);

       translate([-20/2,4,18+(SupportHeight/2)])
       rotate([-90,0,0])
       cylinder(r=12/2,h=RearMountOffset);

     }
}


// ================================================================================
module RotoZipHolderBracket(RotoZipDia=70,BlockoutFront=false,BlockoutBack=false,RearMountOffset=60.00) {
// ================================================================================

   BracketThickness  = 18;
   BracketOutsideDia = 95;
   //RotoZipDia  = 70;

   ScrewFlangeWidth  = 130;
   ScrewFlangeDepth  = 25;
   ScrewFlangeGap    = 5;

   FlangeScrewLength = 20;
   FlangeScrewXOffset = ((ScrewFlangeWidth/2)-(BracketOutsideDia/2))/2 + (BracketOutsideDia/2) ;
   FlangeScrewYOffset = -((FlangeScrewLength+5)/2);
   FlangeScrewZOffset = BracketThickness/2;


   RearMountWidth    = 88;
   RearMountHeight   = RearMountOffset - 15;
   //RearMountOffset   = 60.00;

   RearMountHoleSpacing = 20;
   RearMountScrewLength = 25; // Acutal Length of the screw used DONT CHANGE THIS

   RearMountScrewXOffset = RearMountHoleSpacing/2;
   RearMountScrewYOffset = RearMountOffset-23;
   RearMountScrewZOffset = BracketThickness/2;

   difference() {

    union() {

      //Main Ring Holder
      cylinder(r=BracketOutsideDia/2,h=BracketThickness,$fn=300);

      // Screw Flange
      translate([-ScrewFlangeWidth/2,-ScrewFlangeDepth/2,0])
      cube([ScrewFlangeWidth,ScrewFlangeDepth,BracketThickness]);
      
      // Rear Mount
      translate([-RearMountWidth/2,RearMountOffset,BracketThickness])
        rotate([90,90,0])
        cube([BracketThickness,RearMountWidth,RearMountHeight]);
   }
    
    // Inside Hole for RotoZip
    translate([0,0,-(fudge*2)])
    cylinder(r=RotoZipDia/2,h=BracketThickness+(4*fudge),$fn=300);

    // Cut between two Halfs
    translate([-(ScrewFlangeWidth/2)-(fudge),-ScrewFlangeGap/2,-fudge])
    cube([ScrewFlangeWidth+(2*fudge),ScrewFlangeGap,BracketThickness+(2*fudge)]);
    
    // Outer Right Hand Scew Hole
    translate([FlangeScrewXOffset,FlangeScrewYOffset,FlangeScrewZOffset])
    rotate([-90,0,0])
      M5ScrewHole(FlangeScrewLength,Nut=true);

    // Outer Left Hand Scew Hole
    translate([-FlangeScrewXOffset,FlangeScrewYOffset,FlangeScrewZOffset])
    rotate([-90,0,0])
      M5ScrewHole(FlangeScrewLength,Nut=true);

    // Bracket Hole Right
    translate([RearMountScrewXOffset,RearMountScrewYOffset,RearMountScrewZOffset])
    rotate([-90,0,0])
      #M5ScrewHole(RearMountScrewLength,Nut=true,ExtendHead=20);

    // Bracket Hole Left
    translate([-RearMountScrewXOffset,RearMountScrewYOffset,RearMountScrewZOffset])
    rotate([-90,0,0])
     #M5ScrewHole(RearMountScrewLength,Nut=true,ExtendHead=20);

   if (BlockoutFront != false) {
     translate([-75,-50,-fudge])
     cube([150,50,30]);
   }

   if (BlockoutBack != false) {
     translate([-75,00,-fudge])
     cube([150,80,30]);
   }

   }

}


// ===============================================
module M5Screw(ScrewLength=10,Nut=false) {
// ===============================================

  // Current Inventory of Metric Lengths
  // M5 X 10
  // M5 X 15
  // M5 X 20
  // M5 X 25
  // M5 X 30

  HeadDia       = 8.30;
  HeadHeight    = 5.00;
  HeadHexDia    = 5.00;
  HeadHexDepth  = 3.54;
  ScrewDia      = 5.00;

  NutHeight     = 2.64;
  NutDia        = 9.00;
 
  difference() {
   union() {
     // Head
     cylinder(r=HeadDia/2,h=HeadHeight);

     // Screw
     cylinder(r=ScrewDia/2,h=ScrewLength+HeadHeight);

     if (Nut != false) {
       translate([0,0,(ScrewLength+HeadHeight)-NutHeight-1])
       cylinder(r=NutDia/2,h=NutHeight,$fn=6);
     }
   }
   //translate([0,0,-fudge])
   //cylinder(r=HeadHexDia/2,h=HeadHexDepth,$fn=6);
  }
}

// ===============================================
module M5ScrewHole(ScrewLength=10,Nut=false,ExtendHead=0,ScrewDia=5.80) {
// ===============================================

  // Current Inventory of Metric Lengths
  // M5 X 10
  // M5 X 15
  // M5 X 20
  // M5 X 25
  // M5 X 30

  HeadDia       = 9.20;
  HeadHeight    = 5.30;
  HeadHexDia    = 5.00;
  HeadHexDepth  = 3.54;

  NutHeight     = 3.50;
  NutDia        = 9.50;
 
  difference() {
   union() {
     // Head
     translate([0,0,-.2-ExtendHead])
     cylinder(r=HeadDia/2,h=HeadHeight+.2+ExtendHead);

     // Screw
     cylinder(r=ScrewDia/2,h=ScrewLength+HeadHeight);

     if (Nut != false) {
       translate([0,0,(ScrewLength+HeadHeight)-NutHeight-1+.2])
       cylinder(r=NutDia/2,h=NutHeight+1+.2,$fn=6);
     }
   }
   //translate([0,0,-fudge])
   //cylinder(r=HeadHexDia/2,h=HeadHexDepth,$fn=6);
  }
}

