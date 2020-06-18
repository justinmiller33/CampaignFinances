#Naive assignment of senate/house district numbers
#To be run after legFinderGlobal's results.csv is copied into the main datafile
"""
INTUITION:
Find the most common donor district... assume thats the in district.
Pretty simple, but will be right almost all the time and easy to see where its wrong
"""
import numpy as np
import pandas as pd
from collections import Counter
from scipy import stats

#Extract Data
data = pd.read_excel("masshousefullformatted.xlsx")
data = data.to_numpy()

#BELOW CHANGES EVERY RUN
#rl is the excel column that has the rep names in it
rl = 0
#dl is the excel column that has district num in it
dl = 14

#Dict of total number of donations and list of reps
repCount = Counter(data[:,rl])
reps = list(repCount.keys())

#Preallocating list for each reps maximum district by # of donors who live their
dists = np.array([])
counts = np.array([])


#Looping through each rep
for i in range(len(reps)):
    tempDist = np.array([])

    #Looping through each row of master datafile
    for j in range(len(data)):
        #If a district was found
        if data[j,dl] < 160:
            #If the recepient is our current rep
            if data[j,rl] == reps[i]:
                tempDist = np.append(tempDist,[data[j,dl]])

    #tempCount = count of donors for that recipient
    
    tempCount = repCount[reps[i]]
    #If all donors were out of district
    try:
        distMode = stats.mode(tempDist).mode[0]
    except:
        distMode = 164
        
    dists = np.append(dists,[distMode])
    counts = np.append(counts,[tempCount])
            
"""
np.save('repNames',reps)
np.save('dists',dists)
np.save('counts',counts)
"""
