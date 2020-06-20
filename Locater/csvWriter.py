#Csv writer for results from legFinderGlobal.py
import numpy as np
import pandas as pd
import csv

#Task 1: writing reps to csv


#Load data needed for everything
reps = np.load('reps.npy')
outOfState = np.load('outOfState.npy')
diverged = np.load('diverged.npy')
badAddress = np.load('badAddress.npy')

#Load overall data
data = pd.read_excel("masssenatefullformatted.xlsx")
data = data.to_numpy()



"""
#Block off above this line for part 2
#Starting location for reps
repLoc = 0

#Open and give md for csv file
with open('results.csv','w') as csvfile:
    fieldnames = ["district"]
    writer = csv.DictWriter(csvfile,fieldnames=fieldnames)
    writer.writeheader()
    rows = len(reps)+len(outOfState)+len(diverged)+len(badAddress)

    #Loop through each row, checking failures and then assigning reps to rest
    for i in range(rows):
        if i in outOfState:
            writer.writerow({"district":"161"})
        elif i in diverged:
            writer.writerow({"district":"162"})
        elif i in badAddress:
            writer.writerow({"district":"163"})
        else:
            writer.writerow({"district":str(reps[repLoc])})
            repLoc = repLoc + 1
            
"""
#Block off above this line for part 1
#Task 2: writing estimated districts to csv

#RL IS LOCATION OF REPNAME COLUMN IN SPREADSHEET
rl = 0

repNames = np.load('repNames.npy')
dists = np.load('dists.npy')
counts = np.load('counts.npy')

#Open and give md for csv file
with open('repDistrict.csv','w') as csvfile:
    fieldnames = ["repDistrict","donorCount"]
    writer = csv.DictWriter(csvfile,fieldnames=fieldnames)
    writer.writeheader()
    rows = len(reps)+len(outOfState)+len(diverged)+len(badAddress)

    #Loop through each row, checking failures and then assigning reps to rest
    #Finding the repnum (np.where is broke lmao)
    for i in range(rows):
        for j in range(len(repNames)):
            if repNames[j] == data[i][rl]:
                repNum = j

        #Writing rep district and their total donor count
        writer.writerow({"repDistrict":str(int(dists[repNum])),"donorCount":str(int(counts[repNum]))})


   
