%Analyzing Continuous Contribution Data

%load('data.mat')

%% Amount Comparisons for IN/OUT of Districts

%Proportion of donations that are larger than this for inside and out

[inProp, outProp] = aComp(20,data,reps);

function [inProp,outProp] = aComp(rep,data,reps)

data{rep,1} = sort(data{rep,1});
data{rep,2} = sort(data{rep,2});

inProp = zeros(1,max(max(data{rep,1}),max(data{rep,2})));
outProp = zeros(1,max(max(data{rep,1}),max(data{rep,2})));

for i = 1:length(inProp)
   
    inProp(i) = sum(data{rep,1}(find(data{rep,1}<i)))/(sum(data{rep,1}) + sum(data{rep,2}));
    outProp(i) = sum(data{rep,2}(find(data{rep,2}<i)))/(sum(data{rep,1}) + sum(data{rep,2}));
    
end







end

















%% VISUALIZATION SECTION... Standard and Accumulations


%plt(20,data,reps)
%plt(21,data,reps)

function [] = plt(rep,data,reps)
figure()
data{rep,1} = sort(data{rep,1});
plot(data{rep,1},"LineWidth",3)
hold on

data{rep,2} = sort(data{rep,2});
plot(data{rep,2},"LineWidth",3)

data{rep,3} = sort(data{rep,3});
plot(data{rep,3},"LineWidth",3)

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


