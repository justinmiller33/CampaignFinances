%Looking at occupations
%58.27 percent of donorData list occupations too
%% Gathering Occupation Groupings
%Loading data
load("feeneyWithHomes.mat")
load("donations.mat")

%Option to load targeted subset of donor donations (feeney's district)
donorData = donations;

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

%Stripping jobs down by words
jobs = strip(string(jobs));

%Lowercasing
keywords = lower(jobs);

%Creating histogram setup of words
[words,~,idx] = unique(keywords);
numOccurrences = histcounts(idx,numel(words));

%Sorting and reorganizing into columns
[rankOfOccurrences,rankIndex] = sort(numOccurrences,'descend');
rankOfOccurrences = transpose(rankOfOccurrences);

%Creating frequency hierarchy and calculating proportions
wordsByFrequency = words(rankIndex);
wordProportion = rankOfOccurrences/lengthListed;
%% 

%Putting scalars into cell structure
data = cell(length(wordsByFrequency),4);
for i = 1:length(wordsByFrequency)
    data{i,1} = wordsByFrequency(i);
    data{i,2} = rankOfOccurrences(i);
    data{i,3} = wordProportion(i);
end

%% Looking at Wealth Distributions

%Putting donation amount tables into cell structure
for i=1:length(wordsByFrequency)
    jobIndex = find(contains(lower(string(usJobs)),wordsByFrequency(i)) & donorData.RecordTypeDescription=="Individual");
    data{i,4} = donorData(jobIndex,:);
end

%% Percent demographic donations testing for each job
job = "homemaker"

%Percent of donors who are white, male, democratic, and live in district
pWhite = white(data,job)
pMale = male(data,job)
pDem = dem(data,job)
pInDistrict = inD(data,job)

%% Finding inDistricts for all jobs in table format
%Preallocating
idp = [];
pw = [];
pm = [];
pd = [];
dof = [];
job = [];

%Running donor demographic sweep for top 100 jobs
%Including degrees of freedom
for i=1:100
    job = [job; data{i,1}];
    idp = [idp; inD(data,data{i,1})];
    pw = [pw; white(data,data{i,1})];
    pm = [pm; male(data,data{i,1})];
    pd = [pd; dem(data,data{i,1})];
    dof = [dof; height(data{i,4})];
end

%Saving as a table
jobIdp = table(job, idp, pw, pm, pd, dof);

%In district proportion
function [pInDistrict] = inD(data,job)
    %Finding index of job
    for i=1:length(data)
        if data{i,1} == job
            index = i;
        end
    end
    %Using indices to extract target table
    subData = data{index,4};
    %Finding proportion of in district origin
    pInDistrict = nanmean(subData.inDistrict);
end

%Finding proportion of democrats
function [pDem] = dem(data,job)
    %Finding index of job
    for i=1:length(data)
        if data{i,1} == job
            index = i;
        end
    end
    %Using indices to extract target table
    subData = data{index,4};
    %Extracting proportion of democrat recipients
    pDem = length(find(subData.Party == "Democrat"))/height(subData);
end

%Finding proportion of male recipients
function [pMale] = male(data,job)
    %Finding index of job
    for i=1:length(data)
        if data{i,1} == job
            index = i;
        end
    end
    %Using indices to extract target table
    subData = data{index,4};
    %Extracting proportion of male recipients
    pMale = length(find(subData.Sex=="Male"))/height(subData);
end

%Finding proportion of white recipients
function [pWhite] = white(data,job)
    %Finding index of job
    for i=1:length(data)
        if data{i,1} == job
            index = i;
        end
    end
    %Using indices to extract target table
    subData = data{index,4};
    %Extracting proportion of male recipients
    pWhite = length(find(subData.Race=="White"))/height(subData);
end

