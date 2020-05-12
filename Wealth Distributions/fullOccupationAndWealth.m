%Looking at occupations
%58.27 percent of donorData list occupations too
%% Gathering Occupation Groupings

load("feeneyWithHomes.mat")
load("donations.mat")

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
    data{i,4} = donorData(jobIndex,:);
end

%% Percent demographic donations testing for each job
job = "homemaker"

pWhite = white(data,job)
pMale = male(data,job)
pDem = dem(data,job)
pInDistrict = inD(data,job)

%% Finding inDistricts for all jobs in table format
idp = [];
pw = [];
pm = [];
pd = [];
dof = [];
job = [];
for i=1:100
    job = [job; data{i,1}];
    idp = [idp; inD(data,data{i,1})];
    pw = [pw; white(data,data{i,1})];
    pm = [pm; male(data,data{i,1})];
    pd = [pd; dem(data,data{i,1})];
    dof = [dof; height(data{i,4})];
end

jobIdp = table(job, idp, pw, pm, pd, dof);

function [pInDistrict] = inD(data,job)
    for i=1:length(data)
        if data{i,1} == job
            index = i;
        end
    end
    subData = data{index,4};
    pInDistrict = nanmean(subData.inDistrict);
end

function [pDem] = dem(data,job)
    for i=1:length(data)
        if data{i,1} == job
            index = i;
        end
    end
    subData = data{index,4};
    pDem = length(find(subData.Party == "Democrat"))/height(subData);
end

function [pMale] = male(data,job)
    for i=1:length(data)
        if data{i,1} == job
            index = i;
        end
    end
    subData = data{index,4};
    pMale = length(find(subData.Sex=="Male"))/height(subData);
end

function [pWhite] = white(data,job)
    for i=1:length(data)
        if data{i,1} == job
            index = i;
        end
    end
    subData = data{index,4};
    pWhite = length(find(subData.Race=="White"))/height(subData);
end

