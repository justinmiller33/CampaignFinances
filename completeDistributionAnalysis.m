%completeDistributionAnalysis
%Sourced from distributionAnalysis but for all representatives for comp.

%load('senators.mat');
%load('donations.mat');
%load('demographics.mat');

%List of Reps
reps = ["Feeney, Paul"];
%Parallel list of distNums
distNums = [32];

%Parallel list of towns completely covered
townsC = cell(length(reps),1);
townsC{1} = ["Mansfield","Norton","Seekonk","Rehoboth","Foxborough","Medfield","Sharon","Foxboro"];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];
townsC{1} = [];

%Parallel list of towns partially covered
townsP = cell(length(reps),1);
townsP{1} = ["Attleboro","Walpole","East Walpole"];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];
townsP{1} = [];

%Cell structure with amounts per rep per district status(in,out,unknown)
data = cell(length(reps),3);


for rep = 1:length(reps)
    amount = [];
    inDistrict = [];
    donorIndices = [];

    %Finding index for chosen rep
    index = find(senators.Senator == reps(rep));
    distNum = senators(index,:).DistNum;
    count = 1;

    for i = 1:height(donations)

        row = string(donations(i,:).Recipient);

        if row ~= reps(rep)
            count = count+1;
            continue
        end

        amount = [amount,donations(i,:).Amount];

        city = lower(string(donations(i,:).City));
        
        if donations(i,:).VarName24 == distNums[rep]
            inDistrict = [inDistrict,1];
        elseif find(city == townsC(rep))
            inDistrict = [inDistrict,1]
        elseif find(city == townsP(rep))
            inDistrict = [inDistrict,NaN]
        elseif ismissing(donations(i,:).City)
            inDistrict = [inDistrict,NaN];
        else 
            inDistrict = [inDistrict,0];
        end   

        donorIndices = [donorIndices, count];
        count = count+1;
    end
    %% 

    unknown = find(ismissing(inDistrict)==1);
    ukAmount = amount(unknown)
    
    inDistrictAmount = amount.*inDistrict;
    outDistrictAmount = amount - inDistrictAmount;

    inDistrictAmount = rmmissing(nonzeros(inDistrictAmount));
    outDistrictAmount = rmmissing(nonzeros(outDistrictAmount));
    
    data{rep,1} = inDistrictAmount;
    data{rep,2} = outDistrictAmount;
    data{rep,3} = ukAmount;
    
    %% 

    %Accumulation function visualization
    inDistrictAmount = sort(inDistrictAmount);
    sxIn = [0];
    for i = 2:length(inDistrictAmount)+1
        sxIn = [sxIn,sxIn(i-1)+inDistrictAmount(i-1)];
    end

    outDistrictAmount = sort(outDistrictAmount);
    sxOut = [0];
    for i = 2:length(outDistrictAmount)+1
        sxOut = [sxOut,sxOut(i-1)+outDistrictAmount(i-1)];
    end

    sxUk = [0];
    for i = 2:length(unknown)+1
        sxUk = [sxUk,sxUk(i-1)+ amount(unknown(i-1))];
    end
    %% 
    %For helping with plots
    adjOutDistrictAmount = [zeros(length(inDistrictAmount),1);outDistrictAmount];
    figure()
    area(adjOutDistrictAmount)
    hold on
    area(inDistrictAmount)
    area(sort(amount(unknown)))
    title(reps(rep))
    hold off

    figure()
    plot(sxOut,'LineWidth',5)
    hold on
    plot(sxIn,'LineWidth',5)
    plot(sxUk, 'LineWidth',5)
    title(reps(rep))
    hold off

end