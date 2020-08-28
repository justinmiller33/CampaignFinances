#scraping census api to get probability of race by names
#using central limit thm to calculate features of contributions by race

import numpy as np
import pandas as pd
import requests
import time

#loading in names
start = time.time()
names = pd.read_excel("C:/devel/CampaignFinances/Locater/house_full_individual.xlsx")
names = names.to_numpy()
print("time to load: "+str(time.time()-start))

#location of donor names in spreadsheet
nl = 9

def getname(names,nl,n):
    surnames = {}

    for i in range(n):
        #gettting your current name (w/ exception handler)
        try:
            current = names[i,nl].split(",")[0].lower()

        except:
            continue
        
        #checking to make sure its not an organization
        if " " not in current:
            
            if current not in surnames:
                surnames[current] = np.array([i])

            else:
                surnames[current] = np.append(surnames[current],[i])
            
    return surnames
        
start = time.time()
surnames = getname(names,nl,len(names))
print("surnames calculated in "+str(time.time()-start))
print(str(len(surnames))+" surnames gathered from "+str(len(names))+" donors")


def getprops(name):

    #enter key since >500 iterations
    key = '9ce90ef20cbbea81efccf3723314a41776a56fdf'
    link = 'https://api.census.gov/data/2010/surname?get=pctwhite,pctblack,pctapi,pcthispanic&name='+name.upper()+'&key='+key

    response = requests.get(link)

    r = response.json()[1][0:4]
    return r


props = np.zeros((len(surnames.keys()),4))
loopstart = time.time()
for i in range(len(surnames.keys())):
    #saving and updating every 100 names
    if i%100 == 99:
        np.save('racepropshousenewer.npy',props)
        print(str((time.time()-loopstart)/i)+" seconds per loop")
        print(str(((len(surnames.keys())-i)*(time.time()-loopstart)/i)/60)+" minutes remaining")
    
    try:
        currentprops = getprops(list(surnames.keys())[i])

        #changing insufficient data to 0's as they approach 0 for large census numbers
        if '(s)' in currentprops:
            for j in range(len(currentprops)):
                if currentprops[j] == '(s)':
                    currentprops[j] = 0
                    
        props[i] = currentprops

    except:
         continue


def normalize(names,nl,surnames,props):
    realprops = np.zeros((len(names),4))
    for i in range(len(surnames)):
        spots = surnames[list(surnames.keys())[i]]
        for j in range(len(spots)):
            realprops[spots[j]] = props[i]

        if i%1000 == 100:
            print(i)

    return realprops

realprops = normalize(names,nl,surnames,props)
np.save('realpropshousenew.npy',realprops)
    
