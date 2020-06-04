#Csv writer for results from legFinderGlobal.py
import numpy as np
import csv

#Load data
reps = np.load('reps.npy')
outOfState = np.load('outOfState.npy')
diverged = np.load('diverged.npy')
badAddress = np.load('badAddress.npy')

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
            writer.writerow({"district":"41"})
        elif i in diverged:
            writer.writerow({"district":"42"})
        elif i in badAddress:
            writer.writerow({"district":"41"})
        else:
            writer.writerow({"district":str(reps[repLoc])})
            repLoc = repLoc + 1
            
