%Looking at occupations
%58.27 percent of donorData list occupations too
%% Gathering Occupation Groupings

load("feeneyWithHomes.mat")

donorData = donations;

jobs = [];
for i=1:height(donorData)
    jobs = [jobs;donorData(i,:).Occupation];
end

usJobs = jobs;
lengthListed = length(donorData.Amount(usJobs~="" & donorData.RecordTypeDescription == "Individual"));

empty = ismissing(jobs) | jobs == "";

jobs(empty) = [];

jobs = strip(string(jobs));

keywords = lower(jobs);
[words,~,idx] = unique(keywords);
numOccurrences = histcounts(idx,numel(words));

[rankOfOccurrences,rankIndex] = sort(numOccurrences,'descend');
rankOfOccurrences = transpose(rankOfOccurrences);
wordsByFrequency = words(rankIndex);
wordProportion = rankOfOccurrences/lengthListed;
%% 

data = cell(length(wordsByFrequency),4);
for i = 1:length(wordsByFrequency)
    data{i,1} = wordsByFrequency(i);
    data{i,2} = rankOfOccurrences(i);
    data{i,3} = wordProportion(i);
end

%% Looking at Wealth Distributions

for i=1:length(wordsByFrequency)
    jobIndex = find(contains(lower(string(usJobs)),wordsByFrequency(i)) & donorData.RecordTypeDescription=="Individual");
    data{i,4} = donorData.Amount(jobIndex);
end
%% 

plot(sort(data{1,4}),'r*')
hold on
plot(sort(data{2,4}),'b*')
plot(sort(data{3,4}),'g*')
plot(sort(data{4,4}),'p*')
