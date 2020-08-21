#Random donor Home Valuations
import numpy as np
import pandas as pd
from pyzillow.pyzillow import ZillowWrapper, GetDeepSearchResults
import time

#Loading data to numpy array
dataPath = "C:/devel/CampaignFinances/Locater/"
fileName = "mass_house_full_update.xlsx"
names = pd.read_excel(dataPath+fileName)
names = names.to_numpy()
print('Loaded ' + str(len(names)) +' donations')

#Deleting rows with bad addresses
toDelete = np.array([])
opto = 0
for i in range(len(names)):
    if names[i,20] >= 162:
        toDelete = np.append(toDelete,[int(i)])
        continue
    try:
        if '#' in names[i,9]:
            toDelete = np.append(toDelete,[int(i)])
            opto = opto + 1
    except:
        toDelete = np.append(toDelete,[int(i)])
        opto = opto + 1
        
        
names = np.delete(names,toDelete,0)
print('Trimmed to ' + str(len(names)) + ' donations')
print('Intuition trimmed ' +str(opto) + ' values.')
#Function to get price for an address
def getPrice(address, zipcode):

    #API Key Validation
    zillow_data = ZillowWrapper('X1-ZWz1fjckjdd8gb_a2eph')

    #Parsing xml object using pyzillow api
    deep_search_response = zillow_data.get_deep_search_results(address,zipcode)
    result = GetDeepSearchResults(deep_search_response)

    #Extracting valuation range
    valuation = result.zestimate_amount
    #lowValuation = result.zestimate_valuationRange_low
    #highValuation = result.zestimate_valuation_range_high

    #Extracting the year that the homeowner bought the house(optional)
    #yearBought = result.last_sold_date

    return valuation #, str(lowValuation), str(highValuation)


#Array of indices
randomDonors = np.random.choice(np.arange(len(names)),1000,replace=False)

#Metric for successes
successes = 0
failed = 0

#Getting some metadata(amount donated, in district/out of district
amounts = np.zeros(1000)
inDistrict = np.zeros(1000)
outDistrict = np.zeros(1000)
homePrice = np.zeros(1000)

print('Beginning Sample.')
#Counting through each of 1000 samples
sampleCount = 0
for i in randomDonors:

    #Making all zipcodes strings
    names[i][12]=str(names[i][12])

    #Cutting it down to the first 5 digits with a zero at the start(MA)
    if len(names[i][12]) != 5:

        if (names[i][12][0] != "0"):
            names[i][12] = names[i][12][0:4]

        else:
            names[i][12] = names[i][12][0:5]

    if len(names[i][12])!=5:
        names[i][12] = "0"+names[i][12]

    #Concatenating the address
    try:
        address = names[i][9]#+", "+names[i][10]+", "+names[i][11]
        
    #Will only except if address is corrupted/NAN
    except:
        address = ""

    #Getting home data for address/zipcode. Adding it to array.
    try:
        homePrice[sampleCount] = int(getPrice(address,names[i][12]))
    except:
        failed = failed + 1            

    #Updating metadata
    #Amounts
    amounts[sampleCount] = names[i,7]
    #Setting donor and rep districts
    ddistrict = names[i,20]
    rdistrict = names[i,21]
    if ddistrict == rdistrict:
        inDistrict[sampleCount] = 1
    else:
        outDistrict[sampleCount] = 1

    #Printing progress
    print(str(sampleCount+1)+' completed.')
    print('$' + str(homePrice[sampleCount]))
    if homePrice[sampleCount] != 0:
        successes = successes + 1
    print(str(successes) + ' done.')
    print('OIRatio = ' + str(sum(outDistrict)/sum(inDistrict)))
    time.sleep(1)
    
    #Updating sampleCount
    sampleCount = sampleCount + 1

print(str(failed)+' failed')


