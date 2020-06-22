#Scraping census api to get probability of race by names
#Using Central Limit Thm to calculate features of contributions by race

import numpy as np
import pandas as pd
import requests
import time

#Loading in names
start = time.time()
names = pd.read_excel("C:\devel\CampaignFinances\Locater\masssenatefullformatted.xlsx")
names = names.to_numpy()
print("TIME TO LOAD: "+str(time.time()-start))

#Location of donor names in spreadsheet
nl = 2

def getName(names,nl,n):
    surnames = {}

    for i in range(n):
        #Gettting your current name (w/ exception handler)
        try:
            current = names[i,nl].split(",")[0].lower()

        except:
            continue
        
        #Checking to make sure its not an organization
        if " " not in current:
            
            if current not in surnames:
                surnames[current] = np.array([i])

            else:
                surnames[current] = np.append(surnames[current],[i])
            
    return surnames
        
start = time.time()
surnames = getName(names,nl,len(names))
print("Surnames calculated in "+str(time.time()-start))
print(str(len(surnames))+" surnames gathered from "+str(len(names))+" donors")


def getProps(name):

    #Enter key since >500 iterations
    key = '9ce90ef20cbbea81efccf3723314a41776a56fdf'
    link = 'https://api.census.gov/data/2010/surname?get=PCTAPI,PCTBLACK,PCTAIAN,PCTWHITE,PCT2PRACE,PCTHISPANIC&NAME='+name.upper()+'&key='+key

    response = requests.get(link)

    r = response.json()[1][0:6]
    return r


props = np.zeros((len(surnames.keys()),6))
loopStart = time.time()
for i in range(len(surnames.keys())):
    #Saving and updating every 100 names
    if i%100 == 99:
        np.save('racePropsSenate',props)
        print(str((time.time()-loopStart)/i)+" seconds per loop")
        print(str(((len(surnames.keys())-i)*(time.time()-loopStart)/i)/60)+" minutes remaining")
    
    try:
        currentProps = getProps(list(surnames.keys())[i])

        #Changing insufficient data to 0's as they approach 0 for large census numbers
        if '(S)' in currentProps:
            for j in range(len(currentProps)):
                if currentProps[j] == '(S)':
                    currentProps[j] = 0
                    
        props[i] = currentProps

    except:
         continue


def normalize(names,nl,surnames,props):
    realProps = np.zeros((len(names),6))
    for i in range(len(surnames)):
        spots = surnames[list(surnames.keys())[i]]
        for j in range(len(spots)):
            realProps[spots[j]] = props[i]

        if i%1000 == 100:
            print(i)

    return realProps
        
    
    
realProps = normalize(names,nl,surnames,props)
np.save('realPropsSenate',realProps)
    
