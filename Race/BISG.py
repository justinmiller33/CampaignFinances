# BISG
import numpy as np
import pandas as pd
import wikipedia
import re

# Load in demographic data
# http://archive.boston.com/news/local/massachusetts/graphics/03_22_11_2010_census_town_population/#
dem = pd.read_excel('demographics.xlsx')

# Here's our mass averages too for towns w/ missing data
# https://www.census.gov/quickfacts/MA
# Same format, [white, whiteProp, black, blackProp, asian, asianProp, hispanic, hispanicProp]
massPop = 6547629 
mass = np.array([massPop * 0.711, 0.711, massPop * 0.09, 0.09, massPop * .072, .072, massPop * 0.124, 0.124])

# Here's our US Counts for Bayes Rule
usPop = 308758105
us = np.array([usPop * 0.601, 0.601, usPop * 0.134, 0.134, usPop * 0.059, 0.059, usPop * 0.185, 0.185])

# Load straight surname proportions by loading the completed xlsx (house or senate)
pathToLocater = 'C:/devel/CampaignFinances/Locater/'
data = pd.read_excel(pathToLocater + "masshousefullformatted.xlsx")

# Getting general surname probs (Just for the 4 Detectables this time)
whiteGen = data.White
asianGen = data.Asian
blackGen = data.Black
hispanicGen = data.Hispanic

# Function to find index of current city in demographic sheet
findCityIndex = lambda subject : np.where(data.City[subject] == dem.Town)[0][0]

# Function to get race values of percentage of US Population of that race
getRaceProps = lambda dem,cityIndex : np.array([dem.White[cityIndex] / us[0], dem.Black[cityIndex] / us[4], dem.Asian[cityIndex] / us[2], dem.Hispanic[cityIndex] / us[6]])

# Getting massachusetts race props
maRaceProps = np.array([mass[0] / us[0], mass[4] / us[4], mass[2] / us[2], mass[6] / us[6]])

# Defaulting cityRaces to maRaceProps
cityRaces = maRaceProps
defaulted = 0

# Output array of BISG probabilities
output = np.zeros((len(data),4))
                  
# Subject is the row number in the overall spreadsheet
def bayes(subject):
    # Globalizing
    global whiteGen
    global asianGen
    global blackGen
    global hispanicGen
    global data
    global dem

    global mass
    global maRaceProps
    global us
    global cityRaces

    global output
    global defaulted

    oldProps = np.array([data.White[subject], data.Asian[subject], data.Black[subject], data.Hispanic[subject]])

    # Check for logic
    # print(oldProps)
    # print(data.City[subject])    

    # If out of mass, I'm not gonna bother to do BISG. Just keep the same probs.
    if data.State[subject] != 'MA':
        # Save subjects output
        output[subject] = np.array([data.White[subject], data.Asian[subject], data.Black[subject], data.Hispanic[subject]])
        # Adjust since surname props are out of 100, not 1.
        output[subject] = output[subject]/100
        
    else:
    # Find the index of city
    # If not in spreadsheet, then keep MA stats as your output (better than nothing)
        try:
            # Get index of props
            cityIndex = findCityIndex(subject)
            # Get raceprops for that city
            cityRaces = getRaceProps(dem,cityIndex)

        # Will except if city not in list of cities
        # Use MA demographics
        except:
            cityRaces = maRaceProps
            defaulted = defaulted + 1

        # For each race: in order white, asian, black, hispanic
        for i in range(4):
                  
            # BISG Formula
            output[subject,i] =  (cityRaces[i] * oldProps[i]) / sum(cityRaces * oldProps)

    # More checks
    # print(cityRaces)
    # return output[subject]


# Running Bayes for all subjects
for subject in range(len(data)):
    bayes(subject)
    if subject%1000 == 500:
        print(subject/len(data))
                
print(defaulted)
