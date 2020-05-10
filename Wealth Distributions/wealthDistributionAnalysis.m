%Analysis of Wealth Distributions in the Feeney District

load("FeeneyWithHomes.mat")

%Getting individual's indices and data
notIndividuals = [];

for i=1:height(FeeneyWithHomes)
    if FeeneyWithHomes.RecordTypeDescription(i) ~= "Individual"
    notIndividuals = [notIndividuals, i];
    end
end

inData = FeeneyWithHomes;
inData(notIndividuals,:) = [];

%Excluding Zeros
inDataNZ = [];
indexDataNZ = [];
for i = 1:height(inData)
    if inData.zestimate(i) ~= 0 
        indexDataNZ = [indexDataNZ,i];
        inDataNZ = [inDataNZ; inData(i,:)];
    end
end

%mdl = fitlm(inDataNZ.zestimate,inData.Amount(indexDataNZ))
%plot(inDataNZ.zestimate,inData.Amount(indexDataNZ),'r*')

%In district vs. out of district
inInDataNZ =[];
outInDataNZ =[];
for i=1:height(inDataNZ)
    if inDataNZ.VarName27(i) == 32
        inInDataNZ = [inInDataNZ; inDataNZ(i,:)];
    elseif inDataNZ.VarName27(i) < 40
        outInDataNZ  = [outInDataNZ; inDataNZ(i,:)];
    end
end
        
mdl = fitlm(inInDataNZ.zestimate,inInDataNZ.Amount)
plot(inInDataNZ.zestimate,inInDataNZ.Amount,'r*')
figure()
mdl = fitlm(outInDataNZ.zestimate,outInDataNZ.Amount)
plot(outInDataNZ.zestimate,outInDataNZ.Amount,'r*')


%Finding percentage of campaign funds contributed by top 50% 433833
%CP of 670000 gives a perfect 1:1 ratio
%Feeney district median home price ~ 470000

aboveIndices = find(inDataNZ.zestimate>470000);
belowIndices = find(inDataNZ.zestimate<470000);

aboveAmounts = inDataNZ.Amount(aboveIndices);
belowAmounts = inDataNZ.Amount(belowIndices);

ratio = sum(aboveAmounts)/sum(belowAmounts)

