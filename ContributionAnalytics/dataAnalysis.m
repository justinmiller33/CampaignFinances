 %Analyzing Continuous Contribution Data

%  load('data3.mat')
%  sums = [];
%  cp = 50;
%  
%  
%  for i=1:length(reps)
%      
%  [overallData] = overallComp(i,data,reps);
%  overallData = overallData(1:(min(find(overallData>=1000))));
%  
%  sums = [sums,sum(overallData(find(overallData<=cp)))/sum(overallData)]; 
%  
%  
%  end
%  
%  mdl = fitlm(demographics.DistrictMedianHouseholdIncome,sums)
%  
  plot(demographics.DistrictMedianHouseholdIncome,sums,'r*')
 %In out Comparisons 
 grassrootsA = [];
 grassrootsB = [];
 
 %Critical point for grassroots support
 cp = 51;
 
 for i = 1:length(reps)
 [inProp, outProp] = aComp(i,data,reps);
 grassrootsA = [grassrootsA,inProp(cp)];
 grassrootsB = [grassrootsB,outProp(cp)];
 
 end
 %finding p-values for various cps
 mdl = fitlm(demographics.DistrictMedianHouseholdIncome,grassrootsA);
 mdl.Coefficients.pValue(2)
 
 plot(demographics.DistrictMedianHouseholdIncome,grassrootsA,'r*')
figure()
 plot(demographics.DistrictMedianHouseholdIncome,grassrootsB,'blue*')
%Plotting
 
% plt(20,data,reps)
% plt(21,data,reps)
% plt(22,data,reps)
% plt(23,data,reps)
 %% Amount Comparisons for IN/OUT of Districts
 
 function [overallData] = overallComp(rep,data,reps)
    
    overallData = [data{rep,1};data{rep,2};transpose(data{rep,3})]
    overallData = sort(overallData)
 
 end
 %Percent of in dist & out dist donations made up by values less than i
 %Metric to help measure grassroots support
 
 function [inProp,outProp] = aComp(rep,data,reps)
 
 data{rep,1} = sort(data{rep,1});
 data{rep,2} = sort(data{rep,2});
 
 inProp = zeros(1,floor(max(max(data{rep,1}),max(data{rep,2}))));
 outProp = zeros(1,floor(max(max(data{rep,1}),max(data{rep,2}))));
 
 for i = 1:length(inProp)
    
     inProp(i) = sum(data{rep,1}(find(data{rep,1}<i)))/(sum(data{rep,1}));
     outProp(i) = sum(data{rep,2}(find(data{rep,2}<i)))/(sum(data{rep,2}));
     
    
 end
 
 
 
 
 
 
 
 end
 
 















%% VISUALIZATION SECTION... Standard and Accumulations

function [] = plt(rep,data,reps)
figure()
data{rep,1} = sort(data{rep,1});
plot(data{rep,1},'red*')
hold on

data{rep,2} = sort(data{rep,2});
plot(data{rep,2},'blue*')

data{rep,3} = sort(data{rep,3});
plot(data{rep,3},'yellow*')

title(reps(rep))
legend("In District", "Out of District", "Unknown District")
hold off

figure()
plot(cumsum(data{rep,1}),"LineWidth",3)
hold on

plot(cumsum(data{rep,2}),"LineWidth",3)
plot(cumsum(data{rep,3}),"LineWidth",3)

title(reps(rep))
legend("In District","Out of District","Unknown District")
hold off
end


