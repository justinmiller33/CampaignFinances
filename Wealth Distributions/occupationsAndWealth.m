%Looking at occupations
%58.27 percent of donorData list occupations too
%% Gathering Occupation Groupings

load("feeneyWithHomes.mat")

donorData = FeeneyWithHomes;

jobs = [];
for i=1:height(donorData)
    jobs = [jobs;donorData(i,:).Occupation];
end

usJobs = jobs;
lengthListed = length(donorData.Amount(usJobs~="" & donorData.RecordTypeDescription == "Individual"));

empty = ismissing(jobs);

jobs(empty) = [];

jobs = strip(string(jobs));

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
    jobIndex = find(contains(lower(string(usJobs)),wordsByFrequency(i)) & donorData.RecordTypeDescription=="Individual");
    jobMean = mean(donorData.Amount(jobIndex));
    jobStd = std(donorData.Amount(jobIndex));
    
    means(i) = jobMean;
    stds(i) = jobStd;
end
sums = rankOfOccurrences.*means;
totalProportion = sums/sum(donorData.Amount);
impactRatio = totalProportion./wordProportion;

data = [data, table(means,stds,sums,totalProportion)];

%% Grouping for those with at least [threshold] values (arbitrary)
threshold = 5

commonIndices = find(data.rankOfOccurrences>=threshold);

[meanDonorData, meanInd] = sort(data.means(commonIndices),'Descend');

orderedJobs = data.wordsByFrequency(commonIndices);
orderedJobs = orderedJobs(meanInd);

%plot range grouped for means
bar(meanDonorData);
%xticklabels(orderedJobs(end-10:end));

%% For Feeney,only. Matching with home estimates
allMeans = [];

for j=1:length(find(data.rankOfOccurrences>threshold))
    
targetJob = data(j,:).wordsByFrequency;
homeMeans = [];
for i=1:height(FeeneyWithHomes)
    if contains(lower(string(FeeneyWithHomes(i,:).Occupation)),targetJob)
        if FeeneyWithHomes(i,:).zestimate ~= 0 & FeeneyWithHomes(i,:).RecordTypeDescription == "Individual"
            homeMeans = [homeMeans, FeeneyWithHomes(i,:).zestimate];
        end
    end
end
allMeans = [allMeans; mean(homeMeans)];
end
%% 

[sortedMeans, homeSortIdx] = sort(allMeans,'descend');
jobsByHomePrice = data(1:j,:).wordsByFrequency(homeSortIdx);

homeTables = table(sortedMeans,jobsByHomePrice);
bar(sortedMeans)
hold on
xticklabels(jobsByHomePrice)

