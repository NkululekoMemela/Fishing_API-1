%% Author: Nkululeko Memela, MSc.                          Date:22/02/2021              vwxTripDragFreezercatch.csv Creation

function ConsolidatedTable = DragFreezercatchDDL(NewDDL_Data) 

    NewDDL_Data.index = (1:height(NewDDL_Data)).';                                          %Creating a drag index
    DragIndex = NewDDL_Data(:,width(NewDDL_Data));
    DragIndex = table2array(DragIndex);
    DragIndex = array2table(string(DragIndex));                                             %Converting it from a double to a string
    NewDDL_Data = [DragIndex NewDDL_Data];
    NewDDL_Data(:,width(NewDDL_Data)) = [];
    NewDDL_Data.Properties.VariableNames(1) = {'sysSetID'};                                 %Renaming the drag index

    j = NewDDL_Data(1:end,33:33);                                                           %This simply counts the total rows in the sheet
    Output=[];                                                                              %This creates the container of the list of all corrected drags in the end
    for X = 1:numel(j)                                                                      %This is the range I'm looping over
        i = NewDDL_Data(X,34:end-1);                                                        %These are the species that will be transposed
        Drag = NewDDL_Data(X,1:end);                                                        %This is drag 1 as a Table
        Drags=[];                                                                           %This a container for itarating the same drag
        for jj = 1:numel(i)
            Drags=[Drags;Drag];                                                             %This is the iteration logic that appends a drag record below itself unaltered
        end
        DragMtrx = table2array(Drag);
        DragMtrx;
        n=34;                                                                               %This is the location of the first species record in the original table (to be precise, "at the origional matrix actally")
        lst=[];                                                                             %This is a container for the individual species "number of bins".
        for val = 1:numel(i)                                                                %This the range of itaration for the number of species
            Catch=DragMtrx(1,n);                                                            %This is the iteration logic that appends the individual species "number of bins"
            n=n+1;
            lst=[lst;Catch];                                                                %This appends on the next line the new record. 
        end
        clear n;                                                                            %It is important to clear n so that it doesnt' grow beyond scope
        Product=["H_GLocal" "H_GExport " "CapeHaddieFillet" "HighSeasFillet" "ByCatch"];    %This is the list of species names.
        Conversionfactors=["1.46" "1.46" "1.52" "1.52" "1"];                                %This is the list of conversion factors.
        C_Factor = Conversionfactors';                                                      %Transpose of species conversion factos.

        Grades=["Small" "Large" "Large" "Small" "Ungraded"];                                %This is the list of grades.
        Grade = Grades';
        GC = array2table(Grade);
        Cf = array2table(C_Factor);
        T = array2table(Product');                                                          %This converts an array matrix to a table.
        Tt = array2table(lst);                                                              %This does the same and the reason for these conversions is to perform the combine tables operation. All variables must be tables
        CombinedTables = [T GC Tt Cf Drags];                                                %This concartinates the species names, total number of bins and the original table.
        Output=[Output;CombinedTables];                                                     %This appends each of the above complete operations per drag up antil the drags are all computed.
        clear lst;
        clear Drags;
    end
    Output.Properties.VariableNames([1 2 3 4]) = {'Product' 'Grade'...
            'NumberOfBins' 'Conversionfactor'};                                             %This renames column names 1,2,3 and 4.
    Output;
    Output(:,38:end)=[];                                                                    %Delete all the number of bins that you were doing this entire work to rearrange and transpose virtically.
    ShiftOne = movevars(Output,'Product','Before','MoonPhase');                             %Rearranges the species colums to the location before moonphase
    ShiftTwo = movevars(ShiftOne,'NumberOfBins','Before','MoonPhase');                      %Rearranges the above output to before the moonphase
    ShiftThree = movevars(ShiftTwo,'MoonPhase','Before','Product');                         %Rearranges the above to before the moonphase
    ShiftFour = movevars(ShiftThree,'Grade','Before','NumberOfBins');                       %Rearranges the grade to before the Number of Bins
    TheOutput = movevars(ShiftFour,'Conversionfactor','Before','Product');                  %Rearranges the grade to before the Number of Bins
    head(TheOutput,35);
    TheOutput(:,37);                                                                         %This is the Number of bins, it should actually be called weight.

    %% H&G Weight
    ff=TheOutput{:,:};                                                                      %Convert table to a string
    ff= str2double(ff);                                                                     %Convert the string to a double. By the way "a double is a maxtrix".
    HGWeight_kg = ff(:,37);                                                                 %Multiply number of bins with bin size
    Tot_HG_Tbl = array2table(HGWeight_kg);                                                  %Convert back to table format

    %% Duration and CPUE
    TheOutputArryStartDrag = table2array(TheOutput(:,3));                                   %Convert date in Output table to array
    dateeString = char(TheOutputArryStartDrag);                                             %Convert The above to a charecter
    formatOut = 'dd-mmm-yyyy HH:MM';                                                        %Specify a date format for the output.
    StartDrag=datestr(datenum(dateeString,'dd mmmm yyyy HH:MM',1900),formatOut);            %Define Start Drag converting it from the 'dd mmmm yyyy HH:MM' format to the format specified above.

    TheOutputArryEndDrag=table2array(TheOutput(:,4));
    dateeString = char(TheOutputArryEndDrag);
    formatOut = 'dd-mmm-yyyy HH:MM';
    EndDrag=datestr(datenum(dateeString,'dd mmmm yyyy HH:MM',1900),formatOut);              %Same steps as above

    Duration = datetime(EndDrag) - datetime(StartDrag);                                     %Take the time difference between drag start and DragEnd to find Duration.
    DurationThreshold = {'07:26:00'};                                                       %The threshold is the maximum acceptable drag time length. 
    formatOut = 'HH:MM:SS';                                                                 %Specify a date format for the output.
    Threshold =datestr(datenum(DurationThreshold,'HH:MM:SS',1900),formatOut);               %The threshold in date string format.

    Outliers = find(Duration >= DurationThreshold);                                         %find function returns the index location where Duration is bigger or equal to the threshold.
    Duration(Outliers) = NaN;                                                               %Converts the outliers in the duration to NaN.
    Duration = hours(Duration);                                                             %Convert duration to hours
    CPUE_tph = (HGWeight_kg/1000)./Duration;                                                %Calculate the CPUE in Ton/hr

    CPUE = (HGWeight_kg)./Duration;                                                         %Calculate the CPUE in Ton/hr

    CPUE = array2table(CPUE); 
    CPUE_tph = array2table(CPUE_tph);                                                       %Convert CPUE array into a table
    HGWeight_kg = array2table(HGWeight_kg);                                                 %Convert HGweight into table
    SetDuration_hours = array2table(Duration);                                              %Convert Duration into table from array

    FullTable = [TheOutput SetDuration_hours HGWeight_kg CPUE CPUE_tph];                    %Concartinate the above three tables with "TheOutput" table created much earlier.
    head(FullTable,50);

    %% Handling Geographical coordinates :LAT & LON correction.
    %Longitudes
    S_Lon = char(table2array(FullTable(:,5)));                                              %Convert Start-Longitude column in table to array and then to a charecter
    for XX = 1:length(S_Lon)                                                                %Loop over the start Longitude length
        Lons = strcat(S_Lon(1:XX,2:3),'.',S_Lon(1:XX,4:5),S_Lon(1:XX,7:end));               %Breakdown the string and specify the location on the "." in the GPS position. The GPS was in the form 3305.3655. Convert it to 33.053655
    end
    SLon = string(Lons);                                                                    %Convert start Longitude from charecter to string
    SetStartLongitude = str2double(SLon);                                                   %Convert start Longitude from string to a double
    StartLon = array2table(SetStartLongitude);                                              %Convert start Longitude from a double array to a table
    clear Lons;

    E_Lon = char(table2array(FullTable(:,7)));                                              %Repeat the above steps
    for XX = 1:length(E_Lon)     
        Lons = strcat(E_Lon(1:XX,2:3),'.',E_Lon(1:XX,4:5),E_Lon(1:XX,7:end));
    end
    ELon = string(Lons);
    SetEndLongitude = str2double(ELon);
    EndLon = array2table(SetEndLongitude);

    %Latitudes
    S_Lat = char(table2array(FullTable(:,6)));                                              %Repeat the above steps for Latitudes now
    for XX = 1:length(S_Lat)    
        Lats = strcat('-',S_Lat(1:XX,1:2),'.',S_Lat(1:XX,3:4),S_Lat(1:XX,6:end));
    end
    SLat =string(Lats);
    SetStartLatitude = str2double(SLat);
    StartLat = array2table(SetStartLatitude);
    clear Lats; 

    E_Lat = char(table2array(FullTable(:,8)));                                              %Repeat the above steps
    for XX = 1:length(E_Lat)    
        Lats = strcat('-',E_Lat(1:XX,1:2),'.',E_Lat(1:XX,3:4),E_Lat(1:XX,6:end));
    end
    ELat = string(Lats);                                                                    %Try 'char(SetEndLatitude)' incase you wanna remove double qotes
    SetEndLatitude = str2double(ELat);
    EndLat = array2table(SetEndLatitude);

    FullTable = [StartLon,EndLon,StartLat,EndLat,FullTable];
    FullTable(:,9:12)=[]; 
    head(FullTable,5);

    %% Creating Fishing ground categories. 
    FishingGrounds = string(zeros(size(FullTable(:,1))));
    for i = 1:height(FullTable(:,1))
        if SetStartLongitude(i) >=14 & SetStartLongitude(i) <19 & SetStartLatitude(i) >=-32 & SetStartLatitude(i) <-30
            FishingGrounds(i) = "N. Coast";
        elseif SetStartLongitude(i) >=16 & SetStartLongitude(i) <19 & SetStartLatitude(i) >=-34 & SetStartLatitude(i) <-32
            FishingGrounds(i) = "W. Coast";
        elseif SetStartLongitude(i) >=16.5 & SetStartLongitude(i) <20 & SetStartLatitude(i) >=-37 & SetStartLatitude(i) <-34
            FishingGrounds(i) = "C. Town";
        elseif SetStartLongitude(i) >=20 & SetStartLongitude(i) <24 & SetStartLatitude(i) >=-37 & SetStartLatitude(i) <-34
            FishingGrounds(i) = "Agulhas";
        elseif SetStartLongitude(i) >=24 & SetStartLongitude(i) <27 & SetStartLatitude(i) >=-36 & SetStartLatitude(i) <-34
            FishingGrounds(i) = "E. Coast";
        else
            FishingGrounds(i) = "Undefined";   
        end
    end
    FishingGrounds = array2table(FishingGrounds);

    %% Creating Fishing ground categories based on Fishing Grid-blocks.
    Gridblock = char(table2array(FullTable(:,13-4)));                                              %Repeat the above steps
    Gridblock = string(Gridblock);
    Gridblock = str2double(Gridblock);
    FishingGrounds = string(zeros(size(FullTable(:,13))));
    for i = 1:height(FullTable(:,1))
        if Gridblock(i) >=308 & Gridblock(i) <406
            FishingGrounds(i) = "N. Coast";        
        elseif Gridblock(i) >=407 & Gridblock(i) <455
            FishingGrounds(i) = "W. Coast";        
        elseif Gridblock(i) >=456 & Gridblock(i) <511
            FishingGrounds(i) = "C. Town";        
        elseif Gridblock(i) >=535 & Gridblock(i) <546 || Gridblock(i) >=550 & Gridblock(i) <561
            FishingGrounds(i) = "Agulhas";
        elseif Gridblock(i) >=565 & Gridblock(i) <576 || Gridblock(i) >=580 & Gridblock(i) <591
            FishingGrounds(i) = "Agulhas";
        elseif Gridblock(i) >=595 & Gridblock(i) <603 || Gridblock(i) >=604 & Gridblock(i) <612
            FishingGrounds(i) = "Agulhas";
        elseif Gridblock(i) >=613 & Gridblock(i) <621 
            FishingGrounds(i) = "Agulhas";        
        elseif Gridblock(i) >=518 & Gridblock(i) <520 || Gridblock(i) >=532 & Gridblock(i) <534
            FishingGrounds(i) = "E. Coast";
        elseif Gridblock(i) >=547 & Gridblock(i) <549 || Gridblock(i) >=562 & Gridblock(i) <564
            FishingGrounds(i) = "E. Coast";
        elseif Gridblock(i) >=577 & Gridblock(i) <579 || Gridblock(i) >=592 & Gridblock(i) <594
            FishingGrounds(i) = "E. Coast";
        elseif Gridblock(i) >=622
            FishingGrounds(i) = "E. Coast";        
        else
            FishingGrounds(i) = "Undefined";   
        end
    end
    FishingGrounds = array2table(FishingGrounds);

    %% Fishing depth categories.
    Depth = table2array(FullTable(:,18-4));
    Depth = string(Depth);
    Depth = str2double(Depth);
    FishingDepth = string(zeros(size(FullTable(:,1))));
    for i = 1:height(FullTable(:,1))
        if Depth(i) >=110 & Depth(i) <300 
            FishingDepth(i) = "[100-300]";
        elseif Depth(i) >=300 & Depth(i) <400
            FishingDepth(i) = "[300-399]";
        elseif Depth(i) >=400 & Depth(i) <500
            FishingDepth(i) = "[400-499]";
        elseif Depth(i) >=500 & Depth(i) <600
            FishingDepth(i) = "[500-599]";
        elseif Depth(i) >=600 & Depth(i) <800
            FishingDepth(i) = "[600-699]";
        else
            FishingDepth(i) = "Undefined";   
        end
    end
    FishingDepth = array2table(FishingDepth);

    %% Bottom Temperature categories.
    BTemp = table2array(FullTable(:,17-4));
    BTemp = string(BTemp);
    BTemp = str2double(BTemp);
    FishingBTemp = string(zeros(size(FullTable(:,1))));
    for i = 1:height(FullTable(:,1))
        if BTemp(i) >=1 & BTemp(i) <4 
            FishingBTemp(i) = "Below 4";
        elseif BTemp(i) >=4 & BTemp(i) <5
            FishingBTemp(i) = "[4-5]";
        elseif BTemp(i) >=5 & BTemp(i) <6
            FishingBTemp(i) = "[5-6]";
        elseif BTemp(i) >=6 & BTemp(i) <7
            FishingBTemp(i) = "[6-7]";
        elseif BTemp(i) >=7 & BTemp(i) <8
            FishingBTemp(i) = "[7-8]";
        elseif BTemp(i) >=8 & BTemp(i) <9
            FishingBTemp(i) = "[8-9]";
        elseif BTemp(i) >=9 
            FishingBTemp(i) = "Above 9";
        else
            FishingBTemp(i) = "Undefined";   
        end
    end
    FishingBTemp = array2table(FishingBTemp);

    %% Sea Surface Temperature categories.
    SST = table2array(FullTable(:,20-4));
    SST = string(SST);
    SST = str2double(SST);
    FishingSST = string(zeros(size(FullTable(:,1))));
    for i = 1:height(FullTable(:,1))
        if SST(i) >=9 & SST(i) <14 
            FishingSST(i) = "Below 14";
        elseif SST(i) >=14 & SST(i) <15
            FishingSST(i) = "[14-15]";
        elseif SST(i) >=15 & SST(i) <16
            FishingSST(i) = "[15-16]";
        elseif SST(i) >=16 & SST(i) <17
            FishingSST(i) = "[16-17]";
        elseif SST(i) >=17 & SST(i) <18
            FishingSST(i) = "[17-18]";
        elseif SST(i) >=18 & SST(i) <19
            FishingSST(i) = "[18-19]";
        elseif SST(i) >=19 & SST(i) <20
            FishingSST(i) = "[19-20]";
        elseif SST(i) >=20 & SST(i) <21
            FishingSST(i) = "[20-21]";
        elseif SST(i) >=21
            FishingSST(i) = "Above 21";
        else
            FishingSST(i) = "Undefined";   
        end
    end
    FishingSST = array2table(FishingSST);

    %% Cloud Cover correction.
    C_Cover = table2array(FullTable(:,32-4));
    C_Cover = string(C_Cover);
    C_Cover = str2double(C_Cover);
    CloudCover = string(zeros(size(FullTable(:,1))));
    for i = 1:height(FullTable(:,1))
        if C_Cover(i) == 0
            CloudCover(i) = "[0/8]";
        elseif C_Cover(i) == 1
            CloudCover(i) = "[1/8]";
        elseif C_Cover(i) == 2
            CloudCover(i) = "[2/8]";
        elseif C_Cover(i) == 3
            CloudCover(i) = "[3/8]";
        elseif C_Cover(i) == 4
            CloudCover(i) = "[4/8]";
        elseif C_Cover(i) == 5
            CloudCover(i) = "[5/8]";
        elseif C_Cover(i) == 6
            CloudCover(i) = "[6/8]";
        elseif C_Cover(i) == 7
            CloudCover(i) = "[7/8]";
        elseif C_Cover(i) == 8
            CloudCover(i) = "[8/8]";
        else
            CloudCover(i) = "Undefined";   
        end
    end
    FullTable(:,32-4) = [];                                                                     %Delete origional Cloud cover to make space for the new one. 
    CloudCover = array2table(CloudCover);

    %% Bringing together all the tables.
    FullTable = [CloudCover FishingSST FishingBTemp FishingGrounds FishingDepth FullTable];     %Concartinating all the tables together
    head(FullTable,2);

    %% Creating Unique IDs 
    FullTable.index = (1:height(FullTable)).';                                                  %Creating the index colum
    FullTable = movevars(FullTable,'index','Before','CloudCover'); 
    FullTable.Properties.VariableNames(1) = {'sysFreezercatchID'};                              %This renames column name 1.
    FullTable = movevars(FullTable,'sysSetID','Before','CloudCover');
    head(FullTable,1);

    %% Rename all other variables 
    FullTable.Properties.VariableNames([26 43 19 39 13 14 7 5 4 6]) = {'SetEstimatedBagVolume_tons' 'SetDuration_hours'...
                                                                        'SurfaceTemperature_degC' 'GreenweightConversionFactor'...
                                                                        'SetStartDateTime' 'SetEndDateTime' 'SeaBottomDepth_m'...
                                                                        'BottomTemperatureRegion' 'SSTRegion' 'GridRegion'};
    FullTable.Properties.VariableNames([16 17 15]) = {'SetStartYear' 'SetStartMonth' 'SetStartGridBlock'};
    FullTable.Properties.VariableNames(35) = {'Visibility_m'};
    FullTable.Properties.VariableNames(30) = {'SetActivity'};                              %This renames column name 29.
    FullTable.Properties.VariableNames(21) = {'AirPressure_mbar'};                         %This renames column name 20.
    FullTable.Properties.VariableNames(23) = {'SurfaceCurrentDirection_deg'};              %This renames column name 22.
    FullTable.Properties.VariableNames(24) = {'SurfaceCurrentSpeed_knots'};                %This renames column name 23.
    FullTable.Properties.VariableNames(25) = {'WindDirection_deg'};                        %This renames column name 24.
    FullTable.Properties.VariableNames(28) = {'SetStartDirection'};                        %This renames column name 27.
    FullTable.Properties.VariableNames(31) = {'GreenWeight_kg'};                           %This renames column name 30.
    FullTable.Properties.VariableNames(19) = {'BottomTemperature_degC'};                   %This renames column name 18.
    FullTable.Properties.VariableNames(22) = {'SurfaceTemperature_degC'};                  %This renames column name 21.
    FullTable.Properties.VariableNames(29) = {'SetEndGridBlock'};                          %This renames column name 28.
    head(FullTable,1);

    %% Bringing together FullTable with Unused variables to make a perfect match with vwxTripSetWetcatch.
    sysTripID                       = repmat("",1,height(FullTable)).';
    SailingLatitude                 = repmat("",1,height(FullTable)).';
    SailingLongitude                = repmat("",1,height(FullTable)).';
    SailingPort                     = repmat("",1,height(FullTable)).';
    DockingLatitude                 = repmat("",1,height(FullTable)).';
    DockingLongitude                = repmat("",1,height(FullTable)).';
    DockingPort                     = repmat("",1,height(FullTable)).';
    VesselType                      = repmat("Freezer",1,height(FullTable)).';
    VesselName                      = repmat("",1,height(FullTable)).';
    FuelAtStartDGO_Litres           = repmat("",1,height(FullTable)).';
    FuelAtStartIFO_Litres           = repmat("",1,height(FullTable)).';
    FuelAtEndDGO_Litres             = repmat("",1,height(FullTable)).';
    FuelAtEndIFO_Litres             = repmat("",1,height(FullTable)).';
    GearCode                        = repmat("",1,height(FullTable)).';
    CodendMeshSize_mm               = repmat("",1,height(FullTable)).';
    SetTargetSpecies                = repmat("",1,height(FullTable)).';
    WindForceBeaufortScale          = repmat("",1,height(FullTable)).';
    CloudType                       = repmat("",1,height(FullTable)).';
    Species                         = repmat("",1,height(FullTable)).';
    Weight_kg                       = repmat("",1,height(FullTable)).';
    HGConversionFactor              = repmat("",1,height(FullTable)).';
    OriginalTime                    = repmat("",1,height(FullTable)).';
    SailingDateTime                 = repmat("",1,height(FullTable)).';
    DockingDateTime                 = repmat("",1,height(FullTable)).';

    OutSideVarTable = table(sysTripID,SailingLatitude,SailingLongitude,SailingPort,DockingLatitude,DockingLongitude,...
        DockingPort,VesselType,FuelAtStartDGO_Litres,FuelAtStartIFO_Litres,FuelAtEndDGO_Litres,...
        FuelAtEndIFO_Litres,GearCode,CodendMeshSize_mm,SetTargetSpecies,WindForceBeaufortScale,CloudType,Species,...
        Weight_kg,HGConversionFactor,OriginalTime,SailingDateTime,DockingDateTime);
    ConsolidatedTable = [OutSideVarTable FullTable];                                        %Concartinating all the tables together
    head(ConsolidatedTable,2);

    %% Remove Parametres that are not in vwxTripDaySetFreezercatch.
    ConsolidatedTable(:,end-28) = [];                                                       %Remove Day
    ConsolidatedTable(:,end-19) = [];                                                       %Remove PackingContainer
    ConsolidatedTable(:,end-14) = [];                                                       %Remove CalculatedHgweight
    ConsolidatedTable(:,end-4)  = [];                                                       %Remove NumberOfBins
    head(ConsolidatedTable(:,end-28),2);                                                     %Checking The above

    %% Rearrange the order of variables to make a perfect match with vwxTripSetWetcatch.
    ConsolidatedTable = movevars(ConsolidatedTable,'VesselName','After','VesselType');
    ConsolidatedTable = movevars(ConsolidatedTable,'SkipperName','After','VesselName');
    ConsolidatedTable = movevars(ConsolidatedTable,'FuelAtStartDGO_Litres','After','SkipperName');
    ConsolidatedTable = movevars(ConsolidatedTable,'FuelAtStartIFO_Litres','After','FuelAtStartDGO_Litres');
    ConsolidatedTable = movevars(ConsolidatedTable,'FuelAtEndDGO_Litres','After','FuelAtStartIFO_Litres');
    ConsolidatedTable = movevars(ConsolidatedTable,'FuelAtEndIFO_Litres','After','FuelAtEndDGO_Litres');
    ConsolidatedTable = movevars(ConsolidatedTable,'sysSetID','After','FuelAtEndIFO_Litres');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartMonth','After','sysSetID');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartYear','After','SetStartMonth');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetActivity','After','SetStartYear');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartDirection','After','SetActivity');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartGridBlock','After','SetStartDirection');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartLatitude','After','SetStartGridBlock');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartLongitude','After','SetStartLatitude');
    ConsolidatedTable = movevars(ConsolidatedTable,'GridRegion','After','SetStartLongitude');
    ConsolidatedTable = movevars(ConsolidatedTable,'GearCode','After','GridRegion');
    ConsolidatedTable = movevars(ConsolidatedTable,'CodendMeshSize_mm','After','GearCode');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetTargetSpecies','After','CodendMeshSize_mm');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetEstimatedBagVolume_tons','After','SetTargetSpecies');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetDuration_hours','After','SetEstimatedBagVolume_tons');
    ConsolidatedTable = movevars(ConsolidatedTable,'WindForceBeaufortScale','After','SetDuration_hours');
    ConsolidatedTable = movevars(ConsolidatedTable,'CloudType','After','WindForceBeaufortScale');
    ConsolidatedTable = movevars(ConsolidatedTable,'CloudCover','After','CloudType');
    ConsolidatedTable = movevars(ConsolidatedTable,'WaterColour','After','CloudCover');
    ConsolidatedTable = movevars(ConsolidatedTable,'AirPressure_mbar','After','WaterColour');
    ConsolidatedTable = movevars(ConsolidatedTable,'Visibility_m','After','AirPressure_mbar');
    ConsolidatedTable = movevars(ConsolidatedTable,'MoonPhase','After','Visibility_m');
    ConsolidatedTable = movevars(ConsolidatedTable,'SeaBottomDepth','After','MoonPhase');
    ConsolidatedTable = movevars(ConsolidatedTable,'SurfaceTemperature_degC','After','SeaBottomDepth');
    ConsolidatedTable = movevars(ConsolidatedTable,'SSTRegion','After','SurfaceTemperature_degC');
    ConsolidatedTable = movevars(ConsolidatedTable,'BottomTemperature_degC','After','SSTRegion');
    ConsolidatedTable = movevars(ConsolidatedTable,'BottomTemperatureRegion','After','BottomTemperature_degC');
    ConsolidatedTable = movevars(ConsolidatedTable,'SeaBottomDepth_m','After','BottomTemperatureRegion');
    ConsolidatedTable = movevars(ConsolidatedTable,'WindDirection_deg','After','SeaBottomDepth_m');
    ConsolidatedTable = movevars(ConsolidatedTable,'SurfaceCurrentDirection_deg','After','WindDirection_deg');
    ConsolidatedTable = movevars(ConsolidatedTable,'SurfaceCurrentSpeed_knots','After','SurfaceCurrentDirection_deg');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetEndLatitude','After','SurfaceCurrentSpeed_knots');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetEndLongitude','After','SetEndLatitude');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetEndGridBlock','After','SetEndLongitude');
    ConsolidatedTable = movevars(ConsolidatedTable,'sysFreezercatchID','After','SetEndGridBlock');
    ConsolidatedTable = movevars(ConsolidatedTable,'Species','After','sysFreezercatchID');
    ConsolidatedTable = movevars(ConsolidatedTable,'Product','After','Species');
    ConsolidatedTable = movevars(ConsolidatedTable,'Grade','After','Product');
    ConsolidatedTable = movevars(ConsolidatedTable,'Weight_kg','After','Grade');
    ConsolidatedTable = movevars(ConsolidatedTable,'HGConversionFactor','After','Weight_kg');
    ConsolidatedTable = movevars(ConsolidatedTable,'HGWeight_kg','After','HGConversionFactor');
    ConsolidatedTable = movevars(ConsolidatedTable,'GreenweightConversionFactor','After','HGWeight_kg');
    ConsolidatedTable = movevars(ConsolidatedTable,'GreenWeight_kg','After','GreenweightConversionFactor');
    ConsolidatedTable = movevars(ConsolidatedTable,'CPUE','After','GreenWeight_kg');
    ConsolidatedTable = movevars(ConsolidatedTable,'OriginalTime','After','CPUE');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartDateTime','After','OriginalTime');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetEndDateTime','After','SetStartDateTime');
    ConsolidatedTable = movevars(ConsolidatedTable,'SailingDateTime','After','SetEndDateTime');
    ConsolidatedTable = movevars(ConsolidatedTable,'DockingDateTime','After','SailingDateTime');
    ConsolidatedTable(:,end-2) = [];                                                         %Remove DragIDs

    %% Further Rearrange the order of variables to make a perfect match with vwxTripDaySetFreezercatch.
    ConsolidatedTable = movevars(ConsolidatedTable,'SeaBottomDepth_m','Before','SurfaceTemperature_degC');
    ConsolidatedTable = movevars(ConsolidatedTable,'Visibility_m','Before','WaterColour');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetDuration_hours','After','DockingDateTime');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartDirection','Before','GearCode');
    ConsolidatedTable = movevars(ConsolidatedTable,'GridRegion','Before','SetActivity');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartGridBlock','Before','SetStartDirection');
    ConsolidatedTable = movevars(ConsolidatedTable,'SetActivity','Before','SetStartGridBlock');
    ConsolidatedTable = movevars(ConsolidatedTable,'GridRegion','After','SetStartLongitude');
    ConsolidatedTable = movevars(ConsolidatedTable,'Visibility_m','After','SurfaceCurrentSpeed_knots');
    ConsolidatedTable = movevars(ConsolidatedTable,'WaterColour','After','Visibility_m');
    ConsolidatedTable = movevars(ConsolidatedTable,'AirPressure_mbar','After','WaterColour');
    ConsolidatedTable = movevars(ConsolidatedTable,'CalculatedWeight','After','GreenWeight_kg');
    ConsolidatedTable = movevars(ConsolidatedTable,'CPUE_tph','After','CPUE');
    ConsolidatedTable = movevars(ConsolidatedTable,'OriginalTime','After','SetDuration_hours');
    ConsolidatedTable(:,end) = [];                                              %Remove Origional time empty column

    %% Count The number of drags
    ConsolidatedTable_DragCount = table2array(ConsolidatedTable);
    formatOut2 = 'dd/mm/yyyy';
    Time = datestr(datenum(ConsolidatedTable_DragCount(1:end,60),'dd mmmm yyyy HH:MM',1900),formatOut);
    Date = datestr(datenum(ConsolidatedTable_DragCount(1:end,60),'dd mmmm yyyy HH:MM',1900),formatOut2);
    Date = datetime(Date);
    Time = timeofday(datetime(Time));
    D = datenum(Date).';
    T = datenum(Time).';

      i=find(diff(D));                 %This finds the last index where the date is the same before turning different, i.e. 1 2 2 2 3 (i=1,4)
      n=[i numel(D)]-[0 i];            %This finds the number of elements inside two consequtive indices. i.e. The number of observed drags in a day.           
      ii=[0,i]+1;                               %This finds the first index of the after the change in indices. i.e. The first drag observation in a new day
      ij=(n+ii)-1;                              %This is identical to i except that it takes the final element which i doesn't, i.e. 1 2 2 2 3 (i=1,4,3)
      clear n

      n=1;
      lst={};  
      for val = ii
         SelectTime=unique(T(val:ij(n)));
         e=find(diff(SelectTime));              %This finds the last index where the date is the same before turning different, i.e. 1 2 2 2 3 (i=1,4)
         f=[e numel(SelectTime)]-[0 e];         %This finds the number of elements inside two consequtive indices. This will always be 1 since nothing happens between drags
         gg=[0,e]+1    ;                        %This finds the first index after the change in indices. 
         gh=num2str(gg);
         n=n+1;
         lst=[lst,gg];
      end

      dragy=cat(2,lst{:});  
      ss=find(diff(T));
      nn=[ss numel(T)]-[0 ss]  ;
    % Sums
      result = cell2mat(arrayfun(@(w,q)repmat(w,1,q),dragy,nn,'UniformOutput',false));
      DaySetCount = result.';
      DaySetCount = array2table(DaySetCount);
      DayDate = array2table(string(datestr(Date,formatOut2)));  
      sysDayID = D.';  
      sysDayID = array2table(sysDayID);

    ConsolidatedTable = [ConsolidatedTable DaySetCount DayDate sysDayID];                               %Concartinating all the tables together
    ConsolidatedTable.Properties.VariableNames(65) = {'DayDate'};                                       %This renames column name 28.
    ConsolidatedTable.Properties.VariableNames(56) = {'GreenWeight_ton'};                               %This renames column name 28.
    ConsolidatedTable = movevars(ConsolidatedTable,'DaySetCount','Before','sysSetID');                  %Move these variables to their right places.
    ConsolidatedTable = movevars(ConsolidatedTable,'sysDayID','After','FuelAtEndIFO_Litres');
    ConsolidatedTable = movevars(ConsolidatedTable,'DayDate','After','sysDayID');

    %% Month Correction
    ConsolidatedTable(:,19) = [];
    SetStartMonth = month(Date);
    SetStartMonth = array2table(SetStartMonth);
    ConsolidatedTable = [ConsolidatedTable SetStartMonth];                               %Concartinating all the tables
    ConsolidatedTable = movevars(ConsolidatedTable,'SetStartMonth','After','sysSetID');
    ConsolidatedTable = movevars(ConsolidatedTable,'Species','After','Product');
    head(ConsolidatedTable);

    %% ProductID correction.
    SpeciesNames = table2array(ConsolidatedTable(:,end-15));
    SpeciesNames = string(SpeciesNames);
    ProductID = string(zeros(size(SpeciesNames)));
    for i = 1:height(ConsolidatedTable(:,end-9))
        if SpeciesNames(i) == "H_GLocal"
            ProductID(i) = 1;
        elseif SpeciesNames(i) == "H_GExport "
            ProductID(i) = 2;
        elseif SpeciesNames(i) == "CapeHaddieFillet"
            ProductID(i) = 3;
        elseif SpeciesNames(i) == "HighSeasFillet"
            ProductID(i) = 4;
        else
            ProductID(i) = 5;   
        end
    end
    ProductID = array2table(ProductID);
    size(ProductID);

    %% Using the product ID above to Count The number of drags
    SpeciesObs = str2double((table2array(ProductID)));                                     % SpeciesIDs SpeciesObserved
    DayID = datestr(datenum(ConsolidatedTable_DragCount(1:end,60),'dd mmmm yyyy HH:MM',1900),formatOut2);
    DayID = datenum(datetime(DayID));
    UniqueProd = unique(SpeciesObs);
    TransposeT=DayID.';

      i=find(diff(TransposeT));                                                         %Total number of per drag unique species records
      n=[i numel(TransposeT)]-[0 i];                                                    %Total number of fishing days
      ii=[0,i]+1;                                                                       %Unique fishing days start index
      ij=(n+ii)-1;                                                                      %Unique fishing days end index

    kk=ii;
    s=1; 
    lst=[];
    for val=ii                                                                          %loop over day product entries (1    21    36    56    66    86   111   131   146   166   186   206   221   226   236   246   261   271)
        lstDrags=[];
        for DayVal=kk(s):ij(s)                                                          %loop over same products per drag (1     6    11    16)
            VarUsed=table2array(ConsolidatedTable(:,17)).'; 
            SameProd=VarUsed(1,(DayVal));                                               %This is the iteration logic that appends the individual species "number of bins"
            lstDrags=[lstDrags;SameProd];%This is the different line from the loop above
        end
        MaxElem = max(lstDrags);   
        lst=[lst;repelem(MaxElem,MaxElem*numel(UniqueProd)).'];                         %appending the list
        s=s+1;
    end
    size(lst);
    DaySetCount = lst;

    %% HGWeight_kg ReComputation
    HGWeight_kg = table2array(ConsolidatedTable(:,end-10));
    HGWeight_kg = HGWeight_kg./DaySetCount;                                                 %The division by DaySetCount is done because we want a toonage by drag.
    size(HGWeight_kg);
    Tot_HG_Tbl = array2table(HGWeight_kg);                                                  %Convert back to table format

    %% CPUE ReComputation
    CPUE_tph = (HGWeight_kg/1000)./Duration;                                                %Calculate the CPUE in Ton/hr
    CPUE = (HGWeight_kg)./Duration;                                                         %Calculate the CPUE in Ton/hr
    CPUE = array2table(CPUE); 
    CPUE_tph = array2table(CPUE_tph);

    %% Clean up to produce a correct table structure
    ConsolidatedTable(:,end-10) = [];
    ConsolidatedTable(:,end-6) = [];
    ConsolidatedTable(:,end-5) = [];
    ConsolidatedTable = [ConsolidatedTable Tot_HG_Tbl CPUE CPUE_tph];
    ConsolidatedTable = movevars(ConsolidatedTable,'HGWeight_kg','After','HGConversionFactor');
    ConsolidatedTable = movevars(ConsolidatedTable,'CPUE','After','GreenWeight_ton');
    ConsolidatedTable = movevars(ConsolidatedTable,'CPUE_tph','After','CPUE');
    head(ConsolidatedTable,3);

    %% Species correction.
    C_Species = table2array(ConsolidatedTable(:,end-15));
    C_Species = string(C_Species);
    Specie = string(zeros(size(ConsolidatedTable(:,1))));
    for i = 1:height(ConsolidatedTable(:,1))
        if C_Species(i) == "H_GLocal"
            Specie(i) = "Hake";
        elseif C_Species(i) == "H_GExport "
            Specie(i) = "Hake";
        elseif C_Species(i) == "CapeHaddieFillet"
            Specie(i) = "Hake";
        elseif C_Species(i) == "HighSeasFillet"
            Specie(i) = "Hake";
        else
            Specie(i) = "ByCatch";   
        end
    end
    Species = Specie;
    ConsolidatedTable(:,end-14) = [];                                                           %Delete origional Cloud cover to make space for the new one. 
    Species = array2table(Species);
    ConsolidatedTable =[ConsolidatedTable Species];
    ConsolidatedTable = movevars(ConsolidatedTable,'Species','After','Product');
    head(ConsolidatedTable,2);
end
