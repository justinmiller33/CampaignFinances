%Looking at occupations
%58.27 percent of donorData list occupations too
%% Gathering Occupation Groupings
%Loading data
load("feeneyWithHomes.mat")

%Option to load subset of donor data (Just Feeney's District)
donorData = FeeneyWithHomes;

%Making string array of everybody's jobs
jobs = [];
for i=1:height(donorData)
    jobs = [jobs;donorData(i,:).Occupation];
end

%Saving copy of unstripped jobs
%Stripping jobs and checking that donations are on behalf of individuals
usJobs = jobs;
lengthListed = length(donorData.Amount(usJobs~="" & donorData.RecordTypeDescription == "Individual"));


%Checking and removing empty jobs
empty = ismissing(jobs) | jobs == "";
jobs(empty) = [];

%Stripping jobs by word
jobs = strip(string(jobs));

%Lowercasing
keywords = lower(jobs);

%Creating histogram setup of words
[words,~,idx] = unique(keywords);
numOccurrences = histcounts(idx,numel(words));

%Sorting and reorganizing into columns
[rankOfOccurrences,rankIndex] = sort(numOccurrences,'descend');
rankOfOccurrences = transpose(rankOfOccurrences);

%Creating frequency hierarchy and finding proportions
wordsByFrequency = words(rankIndex);
wordProportion = rankOfOccurrences/lengthListed;

%Putting amounts into a table
data = table(wordsByFrequency,rankOfOccurrences,wordProportion);

%% Looking at Wealth Distributions
%Calculating mean donations and standard deviations for each job
means = zeros(height(data),1);
stds = zeros(height(data),1);
for i=1:height(data)
    jobIndex = find(contains(lower(string(usJobs)),wordsByFrequency(i)) & donorData.RecordTypeDescription=="Individual");
    jobMean = mean(donorData.Amount(jobIndex));
    jobStd = std(donorData.Amount(jobIndex));
    
    means(i) = jobMean;
    stds(i) = jobStd;
end
%Finding total sum for each job
sums = rankOfOccurrences.*means;
%Finding proportion of total donation contributed by that job title
totalProportion = sums/sum(donorData.Amount);

%Adding these to the master table
data = [data, table(means,stds,sums,totalProportion)];

%% Grouping for those with at least [threshold] values (arbitrary)
%Minimum number of mentions to use as a job category
threshold = 5;

%Find the indices of common jobs in master job table
commonIndices = find(data.rankOfOccurrences>=threshold);

%Out of all common jobs, sort by maximum mean donation
[meanDonorData, meanInd] = sort(data.means(commonIndices),'Descend');

%Reordering the common jobs by mean donations
orderedJobs = data.wordsByFrequency(commonIndices);
orderedJobs = orderedJobs(meanInd);

%plot range grouped for means
bar(meanDonorData);
%xticklabels(orderedJobs(end-10:end));

%% For Feeney,only. Matching with home estimates
%Creating mean array
allMeans = [];
 
%Looping through length of common jobs table
for j=1:length(find(data.rankOfOccurrences>threshold))
    
%Allocating target job for each loop iteration
targetJob = data(j,:).wordsByFrequency;
%Creating array for home prices
homeMeans = [];

%For each donation to feeney
for i=1:height(FeeneyWithHomes)
    %Check to see if job listed is the target job
    if contains(lower(string(FeeneyWithHomes(i,:).Occupation)),targetJob)
        %Check to see that the house price is recorded + individual donor
        if FeeneyWithHomes(i,:).zestimate ~= 0 & FeeneyWithHomes(i,:).RecordTypeDescription == "Individual"
            %Saving home prices for jobs 
            homeMeans = [homeMeans, FeeneyWithHomes(i,:).zestimate];
        end
    end
end
%Saving mean home price for each occupation
allMeans = [allMeans; mean(homeMeans)];
end
%% 
%Sorting mean home prices for each occupation
[sortedMeans, homeSortIdx] = sort(allMeans,'descend');
jobsByHomePrice = data(1:j,:).wordsByFrequency(homeSortIdx);

%Plotting mean home prices for each occupation
homeTables = table(sortedMeans,jobsByHomePrice);
bar(sortedMeans)
hold on
xticklabels(jobsByHomePrice)

