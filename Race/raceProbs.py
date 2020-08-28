<<<<<<< HEAD
#scraping census api to get probability of race by names
#using central limit thm to calculate features of contributions by race
=======
# Scraping census api to get probability of race by names
# Using Central Limit Thm to calculate features of contributions by race
>>>>>>> f9630d523a14cf51a8cb454356b181ae1a87e34a

import numpy as np
import pandas as pd
import requests
import time

<<<<<<< HEAD
#loading in names
=======
# Loading in names
>>>>>>> f9630d523a14cf51a8cb454356b181ae1a87e34a
start = time.time()
names = pd.read_excel("C:/devel/CampaignFinances/Locater/house_full_individual.xlsx")
names = names.to_numpy()
print("time to load: "+str(time.time()-start))

<<<<<<< HEAD
#location of donor names in spreadsheet
nl = 9

def getname(names,nl,n):
    surnames = {}

    for i in range(n):
        #gettting your current name (w/ exception handler)
=======
# Location of donor names in spreadsheet
nl = 9

# Function to get all unique surnames from dataset
def getName(names,nl,n):
    surnames = {}

    for i in range(n):
        # Gettting your current name (w/ exception handler)
>>>>>>> f9630d523a14cf51a8cb454356b181ae1a87e34a
        try:
            current = names[i,nl].split(",")[0].lower()

        except:
            continue
        
<<<<<<< HEAD
        #checking to make sure its not an organization
=======
        # Checking to make sure its not an organization
>>>>>>> f9630d523a14cf51a8cb454356b181ae1a87e34a
        if " " not in current:
            
            if current not in surnames:
                surnames[current] = np.array([i])

            else:
                surnames[current] = np.append(surnames[current],[i])
            
    return surnames

# Starting Run
start = time.time()
surnames = getname(names,nl,len(names))
print("surnames calculated in "+str(time.time()-start))
print(str(len(surnames))+" surnames gathered from "+str(len(names))+" donors")

<<<<<<< HEAD

def getprops(name):
=======
# Function to get racial proportions for each unique surname
def getProps(name):
>>>>>>> f9630d523a14cf51a8cb454356b181ae1a87e34a

    #enter key since >500 iterations
    key = '9ce90ef20cbbea81efccf3723314a41776a56fdf'
    link = 'https://api.census.gov/data/2010/surname?get=pctwhite,pctblack,pctapi,pcthispanic&name='+name.upper()+'&key='+key

    response = requests.get(link)

    r = response.json()[1][0:4]
    return r

# Starting loop through surnames
props = np.zeros((len(surnames.keys()),4))
<<<<<<< HEAD
loopstart = time.time()
for i in range(len(surnames.keys())):
    #saving and updating every 100 names
    if i%100 == 99:
        np.save('racepropshousenewer.npy',props)
        print(str((time.time()-loopstart)/i)+" seconds per loop")
        print(str(((len(surnames.keys())-i)*(time.time()-loopstart)/i)/60)+" minutes remaining")
    
=======
loopStart = time.time()

# For each surname
for i in range(len(surnames.keys())):
    
    #Saving and updating every 100 names
    if i%100 == 99:
    
        np.save('racePropsHouseNewer.npy',props)
        print(str((time.time()-loopStart)/i)+" seconds per loop")
        print(str(((len(surnames.keys())-i)*(time.time()-loopStart)/i)/60)+" minutes remaining")
        
    # Try to get proportions
>>>>>>> f9630d523a14cf51a8cb454356b181ae1a87e34a
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

# Function to map unique surnames to all surnames in dataset
def normalize(names,nl,surnames,props):
<<<<<<< HEAD
    realprops = np.zeros((len(names),4))
=======

    realProps = np.zeros((len(names),4))

    # For each surname
>>>>>>> f9630d523a14cf51a8cb454356b181ae1a87e34a
    for i in range(len(surnames)):
        # Find contributions with that surname
        spots = surnames[list(surnames.keys())[i]]
        
        # Declare that contributor's race proportions
        for j in range(len(spots)):
            realprops[spots[j]] = props[i]

        if i%1000 == 100:
            print(i)

<<<<<<< HEAD
    return realprops

realprops = normalize(names,nl,surnames,props)
np.save('realpropshousenew.npy',realprops)
=======
    return realProps
        
# Saving
realProps = normalize(names,nl,surnames,props)
np.save('realPropsHouseNew.npy',realProps)
>>>>>>> f9630d523a14cf51a8cb454356b181ae1a87e34a
    
