#Using Zillow's API to find the valuation of the donors home
#Will be used as a proxy for wealth of donor

#Loading Libraries
import numpy as np
import pandas as pd
from pyzillow.pyzillow import ZillowWrapper, GetDeepSearchResults
import time


#Function to get price for an address
def getPrice(address, zipcode):

    #API Key Validation
    zillow_data = ZillowWrapper('INSERT_API-KEY')

    #Parsing xml object using pyzillow api
    deep_search_response = zillow_data.get_deep_search_results(address,zipcode)
    result = GetDeepSearchResults(deep_search_response)

    #Extracting valuation range
    valuation = result.zestimate_amount
    lowValuation = result.zestimate_valuationRange_low
    highValuation = result.zestimate_valuation_range_high

    #Extracting the year that the homeowner bought the house(optional)
    #yearBought = result.last_sold_date

    return str(valuation), str(lowValuation), str(highValuation)

#__________________________________________________________________________


#Importing for master spreadsheet (taken from legFinder.py)

names = pd.read_excel("Senate Full Contribution Data.xlsx")
names = names.to_numpy()

#Normalizing zipcodes
toTest = np.array([])
for i in range(len(names)):

    #Making all zipcodes strings
    names[i][6]=str(names[i][6])

    #Cutting it down to the first 5 digits with a zero at the start(MA)
    if len(names[i][6]) != 5:

        toTest = np.append(toTest, [i])        

        if (names[i][6][0] != "0"):
            names[i][6] = names[i][6][0:4]

        else:
            names[i][6] = names[i][6][0:5]

    if len(names[i][6])!=5:
        names[i][6] = "0"+names[i][6]

#With zipcodes normalized, try to find house zestimates.
#Following code takes around 0.3-0.4 seconds per address
        
#Preallocating
data = np.zeros((len(names),3))
for i in range(len(names)):
    
    #Concatenating for proper address format
    address = names[i][3]+", "+names[i][4]+", "+names[i][5]

    #Try except in case of bad addresses or missing zestimates
    try:
        data[i] = getPrice(address,names[i][6])
        
    except:
        continue

