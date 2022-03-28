1. Report Table Real Status Expression = 
VAR _Boundry = 0.05
    
VAR CurrentItem = SELECTEDVALUE('ReportingTable (2)'[Index])
RETURN
SWITCH(TRUE(),
//Fishing Vessels
//Bounty

    CurrentItem = 2,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. Monthly HGWeight]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 + _Boundry)), 1,
            [1. Monthly HGWeight]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. Monthly HGWeight]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty")))),
        _Status
    ),
    
    CurrentItem = 3,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. S-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 + _Boundry)), 1,
            [1. S-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. S-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty")))),
        _Status
    ),

    CurrentItem = 4,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. M-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 + _Boundry)), 1,
            [1. M-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. M-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty")))),
        _Status
    ),

    CurrentItem = 5,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. L-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 + _Boundry)), 1,
            [1. L-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. L-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty")))),
        _Status
    ),
    
    CurrentItem = 6,    
    VAR _Status =
    SWITCH(
        TRUE,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))>(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 + _Boundry)), 1,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))<(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK(CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty")))),
        _Status
    ),
    
    CurrentItem = 7,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. ByCatch-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 + _Boundry)), 1,
            [1. ByCatch-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. ByCatch-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Bounty")))),
        _Status
    ),

//Krotoa
    CurrentItem = 11,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. Monthly HGWeight]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 + _Boundry)), 1,
            [1. Monthly HGWeight]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. Monthly HGWeight]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa")))),
        _Status
    ),
    
    CurrentItem = 12,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. S-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 + _Boundry)), 1,
            [1. S-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. S-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa")))),
        _Status
    ),

    CurrentItem = 13,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. M-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 + _Boundry)), 1,
            [1. M-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. M-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa")))),
        _Status
    ),

    CurrentItem = 14,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. L-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 + _Boundry)), 1,
            [1. L-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. L-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa")))),
        _Status
    ),
    
    CurrentItem = 15,    
    VAR _Status =
    SWITCH(
        TRUE,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))>(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 + _Boundry)), 1,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))<(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK(CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa")))),
        _Status
    ),
    
    CurrentItem = 16,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. ByCatch-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 + _Boundry)), 1,
            [1. ByCatch-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. ByCatch-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Vessel_LookUp,Vessel_LookUp[Vessel]="Krotoa")))),
        _Status
    ),

//Fishing Grounds
//N. Coast

    CurrentItem = 21,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. Monthly HGWeight]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 + _Boundry)), 1,
            [1. Monthly HGWeight]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. Monthly HGWeight]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast")))),
        _Status
    ),
    
    CurrentItem = 22,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. S-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 + _Boundry)), 1,
            [1. S-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. S-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast")))),
        _Status
    ),

    CurrentItem = 23,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. M-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 + _Boundry)), 1,
            [1. M-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. M-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast")))),
        _Status
    ),

    CurrentItem = 24,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. L-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 + _Boundry)), 1,
            [1. L-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. L-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast")))),
        _Status
    ),
    
    CurrentItem = 25,    
    VAR _Status =
    SWITCH(
        TRUE,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))>(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 + _Boundry)), 1,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))<(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK(CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast")))),
        _Status
    ),
    
    CurrentItem = 26,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. ByCatch-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 + _Boundry)), 1,
            [1. ByCatch-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. ByCatch-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="N. Coast")))),
        _Status
    ),

//W. Coast
    CurrentItem = 29,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. Monthly HGWeight]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 + _Boundry)), 1,
            [1. Monthly HGWeight]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. Monthly HGWeight]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast")))),
        _Status
    ),
    
    CurrentItem = 30,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. S-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 + _Boundry)), 1,
            [1. S-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. S-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast")))),
        _Status
    ),

    CurrentItem = 31,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. M-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 + _Boundry)), 1,
            [1. M-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. M-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast")))),
        _Status
    ),

    CurrentItem = 32,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. L-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 + _Boundry)), 1,
            [1. L-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. L-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast")))),
        _Status
    ),
    
    CurrentItem = 33,    
    VAR _Status =
    SWITCH(
        TRUE,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))>(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 + _Boundry)), 1,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))<(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK(CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast")))),
        _Status
    ),
    
    CurrentItem = 34,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. ByCatch-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 + _Boundry)), 1,
            [1. ByCatch-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. ByCatch-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="W. Coast")))),
        _Status
    ),

//C. Town
    CurrentItem = 37,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. Monthly HGWeight]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 + _Boundry)), 1,
            [1. Monthly HGWeight]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. Monthly HGWeight]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town")))),
        _Status
    ),
    
    CurrentItem = 38,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. S-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 + _Boundry)), 1,
            [1. S-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. S-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town")))),
        _Status
    ),

    CurrentItem = 39,    
    VAR _Status =
    SWITCH(
        TRUE,
            [1. M-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 + _Boundry)), 1,
            [1. M-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. M-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town")))),
        _Status
    ),

    CurrentItem = 40,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. L-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 + _Boundry)), 1,
            [1. L-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. L-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town")))),
        _Status
    ),
    
    CurrentItem = 41,    
    VAR _Status =
    SWITCH(
        TRUE,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))>(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 + _Boundry)), 1,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))<(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK(CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"),FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town")))),
        _Status
    ),
    
    CurrentItem = 42,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. ByCatch-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 + _Boundry)), 1,
            [1. ByCatch-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. ByCatch-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(FishingRegion_LookUp,FishingRegion_LookUp[Grid Region]="C. Town")))),
        _Status
    ),
    
    
//Overall Summary
    CurrentItem = 45,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. Monthly HGWeight]>([6.1 Forecast value]*(1 + _Boundry)), 1,
            [1. Monthly HGWeight]<([6.1 Forecast value]*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. Monthly HGWeight]))
        && NOT(ISBLANK([6.1 Forecast value])),
        _Status
    ),
    CurrentItem = 46,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. S-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Grade_LookUp,Grade_LookUp[Grade] = "Small"))*(1 + _Boundry)), 1,
            [1. S-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Grade_LookUp,Grade_LookUp[Grade] = "Small"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. S-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Grade_LookUp,Grade_LookUp[Grade] = "Small")))),
        _Status
    ),
    CurrentItem = 47,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. M-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Grade_LookUp,Grade_LookUp[Grade] = "Medium"))*(1 + _Boundry)), 1,
            [1. M-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Grade_LookUp,Grade_LookUp[Grade] = "Medium"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. M-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Grade_LookUp,Grade_LookUp[Grade] = "Medium")))),
        _Status
    ),
    CurrentItem = 48,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. L-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(Grade_LookUp,Grade_LookUp[Grade] = "Large"))*(1 + _Boundry)), 1,
            [1. L-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(Grade_LookUp,Grade_LookUp[Grade] = "Large"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. L-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(Grade_LookUp,Grade_LookUp[Grade] = "Large")))),
        _Status
    ),
    CurrentItem = 49,
    VAR _Status =
    SWITCH(
        TRUE,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))>(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))*(1 + _Boundry)), 1,
            CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))<(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK(CALCULATE([1. Monthly HGWeight],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))))
        && NOT(ISBLANK((CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species]="Hake"))))),
        _Status
    ),
    CurrentItem = 50,
    VAR _Status =
    SWITCH(
        TRUE,
            [1. ByCatch-Wet-Fish Vessel]>(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species] <> "Hake"))*(1 + _Boundry)), 1,
            [1. ByCatch-Wet-Fish Vessel]<(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species] <> "Hake"))*(1 - _Boundry)), -1,
            0
            )
    RETURN
    IF(
        NOT(ISBLANK([1. ByCatch-Wet-Fish Vessel]))
        && NOT(ISBLANK(CALCULATE([6.1 Forecast value],FILTER(SpeciesWetFish_LookUp,SpeciesWetFish_LookUp[Species] <> "Hake")))),
        _Status
    )
) 