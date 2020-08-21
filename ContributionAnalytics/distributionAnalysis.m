%Histograms
%Loading stuff

%load('senators.mat');
%load('donations.mat');
%load('demographics.mat');

%Chosen Rep and known towns
chosenRep = "Spilka, Karen";

amount = [];
inDistrict = [];
donorIndices = [];

%Finding index for chosen rep
index = find(senators.Senator == chosenRep);
distNum = senators(index,:).DistNum;
count = 1;

for i = 1:height(donations)
    
    rep = string(donations(i,:).Recipient);
        
    if rep ~= chosenRep
        count = count+1;
        continue
    end

    amount = [amount,donations(i,:).Amount];
    
    city = lower(string(donations(i,:).City));
    if donations(i,:).VarName24 == distNum || city == "Ashland" || city == "Framingham" || city == "Holliston" || city == "Hopkinton" || city == "Medway"
        inDistrict = [inDistrict,1];
    elseif city == "Natick" || city == "Franklin" || ismissing(donations(i,:).City)
        inDistrict = [inDistrict,NaN];
    else 
        inDistrict = [inDistrict,0];
    end   
    
    donorIndices = [donorIndices, count];
    count = count+1;
end
%% 

unknown = find(ismissing(inDistrict)==1);

inDistrictAmount = amount.*inDistrict;
outDistrictAmount = amount - inDistrictAmount;

inDistrictAmount = rmmissing(nonzeros(inDistrictAmount));
outDistrictAmount = rmmissing(nonzeros(outDistrictAmount));
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
hold off

figure()
plot(sxOut,'LineWidth',5)
hold on
plot(sxIn,'LineWidth',5)
plot(sxUk, 'LineWidth',5)
hold off