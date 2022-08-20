# CampaignFinances
Concluded research on the inequalities present in campaign fundraising for Massachusetts State Elections.
[Final Report.](http://www.inquiriesjournal.com/articles/1864/democratic-misrepresentation-a-quantitative-analysis-of-out-of-district-state-campaign-fundraising)

## Topics of Focus
**Disparity Caused by Out of District Donations**

Economic

Occupational

Racial

## Scripts Cited in Final Report
**Locater/legFinderGlobal.py:** Geolocate and Identify donor's political district from address data.<br>
**Race/raceProbs.py:** Generate racial probabilites for each donor based off of US census surname API. <br>
**Race/BISG.py:** Improve racial probabilities for each donor by considering the demographics of user town or neighborhood.

## Navigation
### Data Files:
- Senate Full Contribution Data.xlsx: Comprehensive Donation Data for 27 **State Senators** with Competitive Elections from 2008-Present

- Data On Senate Districts.xlsx: Demographic Data on each of the above districts.

- senate2018.xlsx: All 2016/18 Cycle political donations to all **senate contendees**, regardless of competition.

- housejobs.xlsx: All donations to **house contendees** with listed jobs for Out of District Analysis by Socioeconomic Status

- mass_house_full_update.xlsx/mass_senate_full.xlsx: All **house contendees** and **senate contendees** donations on 2016/18 Cycle.

- houseCandidatesUpdated.xlsx: Metadata on the campaign status and demographics of a candidate and their district for the 2016/2018 Cycle.

- demographics.xlsx: Racial demographics of MA towns & large Boston neighborhoods for BISG.

### Code and Created Files:
**1. District Locating: Testing ratios of In District and Out of District Donations using Shapefile Data**
- legFinder.py: Address Extraction and Normalization, Geolocation, District Identification from SENATE2012_POLY.shp
- orderedDistricts.csv: Output from legFinder.py 
- legMapper.py: Insures successful shapefile conversion by visualizing target districts
![senateMap](https://github.com/justinmiller33/CampaignFinances/blob/master/DistrictLocating/senateDistrictMap.png)

**2. Overview Statistics: Visualizing Discrepancies between District Donation Ratios and Demographics**
- SenateData_RAnalysis.Rmd: Calculating In District Vs. Out of District Contribution Proportions

**3. Contribution Analytics: In depth analytics of Individual Donations and Demographics**
- completeDistributionAnalysis.m: More district location, preparing data for demographic-based analytics
- dataAnalysis.m: Linear Regressions investigating relation between donations and demographics

**4. Wealth Distributions: Analysis of donations taking each individuals home price into account.**
- donorHouseValuations.py: Using Home Valuation API to estimate home prices in Feeney's District
- FeeneyWithHomes.mat: MATLAB table combining Full Contribution Data with Home Estimates
- wealthDistributionAnalysis.m: Analyzing relations between home prices and donor behavior
- occupationsAndWealth.m: Running frequency analysis on donor's listed occupation
- AverageDonationsByProfession.twb: Tableau Workbook showing relation between donations and jobs
- fullOccupationAndWealth.m: Drawing relationships from Job titles
- jobIdp.xlsx: Table of Job Title, In District Donation percentage, and other demographic stats
![tableau](https://github.com/justinmiller33/CampaignFinances/blob/master/WealthDistributions/donationsByProffession.PNG)

**5. 2018 Elections Only: Normalizing Occupation Distributions by using only 2018 Data**
- LegFinderB.py: Modified legFinder.py with similar functionality for 2018 dataset
- orderedDistrictsB.csv: output from LegFinderB.py
- OccupationSenateData.png: table of average donations by job category

![jobs](https://github.com/justinmiller33/CampaignFinances/blob/master/2018ElectionsOnly/OccupationSenateData.PNG)

**6. Locater**
- legFinderGlobal.py: Modified from **LegFinder.py** to map districts of any state given a house or senate shapefile
- mass_house_full_update/massHouseFullFormatted.xlsx: Partitions of all donations to house races in 2016-2018 cycle
= mass_senate_full/massSenateFullFormatted.xlsx: Partitions of all donations to senate races in 2016-2018 cycle
= naiveDistrictAssigner.py: Assigning assumed district of recepient by identifying the most common district of origin of their donors. NAIVE... REQUIRES A MANUAL CHECK THROUGH MA's ONLINE REPRESENTATIVE LOOKUP TOOL
- csvWriter.py: writes legFinder and districtAssigner results to a csv

**7. Race**
- raceProbs.py: Scraping Census API to extract likelihoods of each donor's race
- raceWriter.py: Writing race proportions to races.csv
- raceAnalysis: Using CLT to estimate donor trends by race... E.g. Average Amount, Out of District Influence, etc...

**8. Wealth Test**
- randomValuationTest.py: Taking 1000 random samples from dataset and finding home zestimate
- randomValuationAnalysis.py: Exploring relationships between home price, amount, and district status
![wealthDist](https://github.com/justinmiller33/CampaignFinances/blob/master/WealthTest/donorHomePrice.png)

**9. Multiple Donors**
- candSummary.py: Exploring relationships between district demographic data and donation trends.
- bipartateGraph.py: Creating network of candidates connected by shared donors for Senate and House campaigns.

![networkGif](https://github.com/justinmiller33/justinmiller33.github.io/blob/master/network.gif)

## Tools and Attributions

**- Python**
**- R**
**- MATLAB**
**- Tableau -**
- OCPF of Massachusetts Open Data
- United States Census
- OpenStreetMap-Nominatim
- Zillow Home Valuation API






## Contributors
Matthew Katz - Boston College - katzmn@bc.edu

Justin Miller - Northeastern University - miller.justi@northeastern.edu

Sethu Odayappan - Harvard College - sodayappan@college.harvard.edu
