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
data = pd.read_excel("housejobsfull.xlsx")
data = data.to_numpy()

#Dict of total number of donations and list of reps
repCount = Counter(data[:,12])
reps = list(repCount.keys())
"""
#Preallocating list for each reps maximum district by # of donors who live their
dists = np.array([])

#Looping through each rep
for i in range(len(reps)):
    tempDist = np.array([])

    #Looping through each row of master datafile
    for j in range(len(data)):
        #If a district was found
        if data[j,20] < 160:
            #If the recepient is our current rep
            if data[j,12] == reps[i]:
                tempDist = np.append(tempDist,[data[j,20]])

    distMode = stats.mode(tempDist).mode[0]
    dists = np.append(dists,[distMode]) 

"""
