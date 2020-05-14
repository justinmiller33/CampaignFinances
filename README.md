# CampaignFinances
Ongoing research on the campaign fundraising in Massachusetts State Elections.

## Topics of Focus
People's Pledge
  
In District vs. Out of District Donations
  
Homophily
  
Wealth Distribution Among Donors

Representative Effectiveness Rates

## Navigation
### Data Files:
- Senate Full Contribution Data.xlsx: Comprehensive Donation Data for 27 State Senators with Competitive Elections from 2008-Present

- Data On Senate Districts.xlsx: Demographic Data on each of the above districts.

### Code and Created Files:
**1. District Locating: Testing ratios of In District and Out of District Donations using Shapefile Data**
- legFinder.py: Address Extraction and Normalization, Geolocation, District Identification from SENATE2012_POLY.shp
- orderedDistricts.csv: Output from legFinder.py 

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

## Contributors
Matthew Katz - Boston College - katzmn@bc.edu

Justin Miller - Northeastern University - miller.justi@northeastern.edu

Sethu Odayappan - Harvard College - sodayappan@college.harvard.edu
