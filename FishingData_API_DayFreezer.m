%% Author: Nkululeko Memela, MSc.                          Date:22/02/2021              vwxTripDragFreezercatch.csv Creation

function PerDayTable = DayFreezercatchDDL(ConsolidatedTable) 

    ConsolidatedTable = movevars(ConsolidatedTable,'sysFreezercatchID','Before','sysTripID');
    ConsolidatedTable = movevars(ConsolidatedTable,'Species','After','DaySetCount');
    ConsolidatedTable = movevars(ConsolidatedTable,'Product','After','Species');
    ConsolidatedTable = movevars(ConsolidatedTable,'Grade','After','Product');
    ConsolidatedTable = movevars(ConsolidatedTable,'Weight_kg','After','Grade');
    ConsolidatedTable = movevars(ConsolidatedTable,'HGConversionFactor','After','Weight_kg');
    ConsolidatedTable = movevars(ConsolidatedTable,'HGWeight_kg','After','HGConversionFactor');
    ConsolidatedTable = movevars(ConsolidatedTable,'GreenweightConversionFactor','After','HGWeight_kg');
    ConsolidatedTable = movevars(ConsolidatedTable,'GreenWeight_kg','After','GreenweightConversionFactor');
    ConsolidatedTable = movevars(ConsolidatedTable,'GreenWeight_ton','After','GreenWeight_kg');
    ConsolidatedTable = movevars(ConsolidatedTable,'SailingDateTime','After','GreenWeight_ton');
    ConsolidatedTable = movevars(ConsolidatedTable,'DockingDateTime','After','SailingDateTime');
    ConsolidatedTable(:,30:end) = [];

    %% ProductID correction.
    SpeciesNames = table2array(ConsolidatedTable(:,end-9));
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

    %% Combine tables like you always wated to do.
    SpeciesCatch = table2array(ConsolidatedTable(:,end-5));                                     % HGWeight_kg
    SpeciesObs = str2double((table2array(ProductID)));                                     % SpeciesIDs SpeciesObserved
    DayID = table2array(ConsolidatedTable(:,end-13));

    TransposeT=DayID.';
    TransposeSC=SpeciesCatch.';

    i=find(diff(TransposeT));                                                 %Total number of per drag unique species records
    n=[i numel(TransposeT)]-[0 i];                                            %Total number of fishing days
    ii=[0,i]+1;                                                               %Unique fishing days start index
    ij=(n+ii)-1;                                                              %Unique fishing days end index

    %% Handling column 24
    UniqueProd = unique(SpeciesObs);
      kk=ii;
      s=1; 
      lst=[];
      for val=ii                                                                % loop over day product entries (1    21    36    56    66    86   111   131   146   166   186   206   221   226   236   246   261   271)
          lstDrags=[];
        for r=1:numel(UniqueProd)                                               %loop over number of products (1     2     3     4     5)
          lst2=[];
           for DayVal=kk(s):numel(UniqueProd):ij(s)                             %loop over same products per drag (1     6    11    16)
               SameProd=TransposeSC(1,(DayVal+r-1));                            %This is the iteration logic that appends the individual species "number of bins"
               lst2(end+1)=SameProd;                                            %appending the list
           end
           lstDrags=[lstDrags;nanmean(lst2)];                                   %This is the different line from the next loop
        end
          s=s+1;
          lst=[lst;lstDrags];                                                   %appending the list
      end
      ProductCatch=lst;
      PerDayProd = array2table(ProductCatch); 

    %% For calculating the number of drags in a day (column 18)
    kk=ii;
    s=1; 
    lst=[];
    for val=ii                                                                  %loop over day product entries (1    21    36    56    66    86   111   131   146   166   186   206   221   226   236   246   261   271)
        lstDrags=[];
        for r=1:numel(UniqueProd)                                               %loop over number of products (1     2     3     4     5)
            lst2=[];
            for DayVal=kk(s):numel(UniqueProd):ij(s)                            %loop over same products per drag (1     6    11    16)
                VarUsed=table2array(ConsolidatedTable(:,18)).'; 
                SameProd=VarUsed(1,(DayVal+r-1));                               %This is the iteration logic that appends the individual species "number of bins"
                lst2=[lst2;SameProd];
            end
            lstDrags=[lstDrags;numel(lst2)];%This is the different line from the loop above          
        end
        s=s+1;
        lst=[lst;lstDrags];                                                     %appending the list
    end
    DaySetCount = lst;
    DaySetCount = array2table(DaySetCount);

    %% Handling (all other columns). The reason why all these could all be done together on a larger loop is because they all have the same dimentions (1:90)
    WholeSheet = [];
    for WS = [2:17,19:23,25,27:29]                                                                  %Number of columns
        VarUsed=table2array(ConsolidatedTable(:,WS)).';  
        kk=ii;
        s=1; 
        lst=[];
        for val=ii                                                                  %loop over day product entries (1    21    36    56    66    86   111   131   146   166   186   206   221   226   236   246   261   271)
            lstDrags=[];
            for r=1:numel(UniqueProd)                                               %loop over number of products (1     2     3     4     5)
                lst2=[];
                for DayVal=kk(s):numel(UniqueProd):ij(s)                            %loop over same products per drag (1     6    11    16)
                    SameProd=VarUsed(1,(DayVal+r-1));                               %This is the iteration logic that appends the individual species "number of bins"
                    lst2=[lst2;SameProd];
                end
                lstDrags=[lstDrags;unique(lst2)];%This line is the different above loops         
            end
            s=s+1;
            lst=[lst;lstDrags];                                                     %appending the list
        end
        WholeSheet=[WholeSheet,lst];
    end
    DimSheet=size(WholeSheet(:,2));                                                 %Dimentions of the variable 2
    WholeSheet = array2table(WholeSheet);

    %% Column 1 rebuild
    sysFreezercatchID = 1:DimSheet(1);                                              %Creating a drag index
    sysFreezercatchID = sysFreezercatchID.';
    sysFreezercatchID  = array2table(sysFreezercatchID);

    %% For calculating the number of drags in a day (column 26)
    kk=ii;
    s=1; 
    lst=[];
    for val=ii                                                                  %loop over day product entries (1    21    36    56    66    86   111   131   146   166   186   206   221   226   236   246   261   271)
        lstDrags=[];
        for r=1:numel(UniqueProd)                                               %loop over number of products (1     2     3     4     5)
            lst2=[];
            for DayVal=kk(s):numel(UniqueProd):ij(s)                            %loop over same products per drag (1     6    11    16)
                VarUsed=table2array(ConsolidatedTable(:,26)).'; 
                SameProd=VarUsed(1,(DayVal+r-1));                               %This is the iteration logic that appends the individual species "number of bins"
                lst2=[lst2;SameProd];
            end
            lstDrags=[lstDrags;numel(lst2)];            
        end
        s=s+1;
        lst=[lst;lstDrags];                                                     %appending the list
    end
    GreenWeight_kg = lst;
    GreenWeight_kg = array2table(GreenWeight_kg);

    %% All day catches brought together                                                                           ;
    PerDayTable = [sysFreezercatchID DaySetCount WholeSheet PerDayProd GreenWeight_kg];
    PerDayTable = movevars(PerDayTable,'ProductCatch','Before','WholeSheet22');
    PerDayTable = movevars(PerDayTable,'DaySetCount','After','WholeSheet16');
    PerDayTable = movevars(PerDayTable,'GreenWeight_kg','Before','WholeSheet23');
    PerDayTable.Properties.VariableNames([1:29]) = {'sysFreezercatchID'	'sysTripID'...
        'SailingLatitude'	'SailingLongitude'	'SailingPort'...
        'DockingLatitude'	'DockingLongitude'	'DockingPort'	'VesselType'	'VesselName'...
        'SkipperName'	'FuelAtStartDGO_Litres'	'FuelAtStartIFO_Litres'	'FuelAtEndDGO_Litres'...
        'FuelAtEndIFO_Litres'	'sysDayID'	'DayDate'	'DaySetCount'	'Species'	'Product'...
        'Grade'	'Weight_kg'	'HGConversionFactor'	'HGWeight_kg'	'GreenweightConversionFactor'...
        'GreenWeight_kg'	'GreenWeight_ton'	'SailingDateTime'	'DockingDateTime'};
end