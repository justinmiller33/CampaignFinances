%Analysis of Wealth Distributions in the Feeney District
%Loading data subsetted for Paul Feeney
load("FeeneyWithHomes.mat")

%Getting individual's indices and data
notIndividuals = [];

%Checking to find non-individual donations
for i=1:height(FeeneyWithHomes)
    if FeeneyWithHomes.RecordTypeDescription(i) ~= "Individual"
    notIndividuals = [notIndividuals, i];
    end
end

%Removing non-individual donations from dataset
inData = FeeneyWithHomes;
inData(notIndividuals,:) = [];

%Excluding null values from home estimates
inDataNZ = [];
indexDataNZ = [];
for i = 1:height(inData)
    if inData.zestimate(i) ~= 0 
        indexDataNZ = [indexDataNZ,i];
        inDataNZ = [inDataNZ; inData(i,:)];
    end
end

%Fitting linear Model (Optional)
%mdl = fitlm(inDataNZ.zestimate,inData.Amount(indexDataNZ))
%plot(inDataNZ.zestimate,inData.Amount(indexDataNZ),'r*')

%Seperating data to in district and out of district arrays
inInDataNZ =[];
outInDataNZ =[];
for i=1:height(inDataNZ)
    %Remember 32 is feeney's district
    if inDataNZ.VarName27(i) == 32
        inInDataNZ = [inInDataNZ; inDataNZ(i,:)];
    elseif inDataNZ.VarName27(i) < 40
        outInDataNZ  = [outInDataNZ; inDataNZ(i,:)];
    end
end
        
%Modeling and plotting home price vs. donation amount
%For both in and out of district
mdl = fitlm(inInDataNZ.zestimate,inInDataNZ.Amount)
plot(inInDataNZ.zestimate,inInDataNZ.Amount,'r*')
figure()
mdl = fitlm(outInDataNZ.zestimate,outInDataNZ.Amount)
plot(outInDataNZ.zestimate,outInDataNZ.Amount,'r*')


%Finding percentage of campaign funds contributed by top 50% 433833
%NOTE: Critical point of 670000 gives a perfect 1:1 ratio
%Feeney district median home price ~ 470000

CP = 470000;

%Vectors of home price indices above and below CP
aboveIndices = find(inDataNZ.zestimate>CP);
belowIndices = find(inDataNZ.zestimate<CP);

%Amounts donated from those
aboveAmounts = inDataNZ.Amount(aboveIndices);
belowAmounts = inDataNZ.Amount(belowIndices);

%Ratio of cumulative donations from above CP to below CP
ratio = sum(aboveAmounts)/sum(belowAmounts);

