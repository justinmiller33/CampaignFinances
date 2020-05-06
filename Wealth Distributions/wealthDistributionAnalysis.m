%Analysis of Wealth Distributions in the Feeney District

load("FeeneyWithHomes1.mat")

%Getting individual's indices and data
notIndividuals = [];

for i=1:height(FeeneyWithHomes1)
    if FeeneyWithHomes1.RecordTypeDescription(i) ~= "Individual"
    notIndividuals = [notIndividuals, i];
    end
end

inData = FeeneyWithHomes1;
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
        
mdl = fitlm(inInDataNZ.zestimate,inInDataNZ.Amount,'RobustOpts','on')
plot(inInDataNZ.zestimate,inInDataNZ.Amount,'r*')
figure()
mdl = fitlm(outInDataNZ.zestimate,outInDataNZ.Amount,'RobustOpts','on')
plot(outInDataNZ.zestimate,outInDataNZ.Amount,'r*')