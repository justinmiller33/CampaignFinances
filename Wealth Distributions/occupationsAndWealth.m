%Looking at occupations
%58.27 percent of donations list occupations too
%% Gathering Occupation Groupings

load("feeneyWithHomes.mat")

jobs = [];
for i=1:height(donations)
    jobs = [jobs;donations(i,:).Occupation];
end

usJobs = jobs;
lengthListed = length(donations.Amount(usJobs~="" & donations.RecordTypeDescription == "Individual"));

empty = (jobs =="");
jobs(empty) = [];

jobs = strip(jobs);

keywords = [];
for i = 1:length(jobs)
   keywords = [keywords;split(jobs(i))];
end

keywords = lower(keywords);
[words,~,idx] = unique(keywords);
numOccurrences = histcounts(idx,numel(words));

[rankOfOccurrences,rankIndex] = sort(numOccurrences,'descend');
rankOfOccurrences = transpose(rankOfOccurrences);
wordsByFrequency = words(rankIndex);
wordProportion = rankOfOccurrences/lengthListed;

data = table(wordsByFrequency,rankOfOccurrences,wordProportion);

%% Looking at Wealth Distributions

means = zeros(height(data),1);
stds = zeros(height(data),1);
for i=1:height(data)
    jobIndex = find(contains(lower(usJobs),wordsByFrequency(i)) & donations.RecordTypeDescription=="Individual");
    jobMean = mean(donations.Amount(jobIndex));
    jobStd = std(donations.Amount(jobIndex));
    
    means(i) = jobMean;
    stds(i) = jobStd;
end
sums = rankOfOccurrences.*means;
totalProportion = sums/sum(donations.Amount);
impactRatio = totalProportion./wordProportion;

data = [data, table(means,stds,sums,totalProportion)];

%% Grouping for those with at least 20 values (arbitrary)

commonIndices = find(data.rankOfOccurrences>=20);

[meanDonations, meanInd] = sort(data.means(commonIndices),'Descend');

orderedJobs = data.wordsByFrequency(commonIndices);
orderedJobs = orderedJobs(meanInd);

%plot range grouped for means
bar(meanDonations);
%xticklabels(orderedJobs(end-10:end));
