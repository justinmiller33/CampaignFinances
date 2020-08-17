#Csv writer for results from legFinderGlobal.py
import numpy as np
import pandas as pd
import csv

#Writing props to csv

#Load data needed for everything
props = np.load('realPropsHouseNew.npy')



#Open and give md for csv file
with open('races.csv','w') as csvfile:
    fieldnames = ["White", "Black", "Asian","Hispanic"]
    writer = csv.DictWriter(csvfile,fieldnames=fieldnames)
    writer.writeheader()
    rows = len(props)

    #Loop through each row, checking failures and then assigning reps to rest
    for location in range(rows):
        
        writer.writerow({"White":str(props[location,0]),"Black":str(props[location,1]),"Asian":str(props[location,2]),"Hispanic":str(props[location,3])})
            
"""

# Writing BISG props to csv
file = 'houseOutput.npy'
output = np.load(file)

with open('output.csv','w') as csvfile:
    fieldnames = ["White","Black","Asian","Hispanic"]
    writer = csv.DictWriter(csvfile,fieldnames=fieldnames)
    writer.writeheader()
    rows = len(output)

    for i in range(rows):
        writer.writerow({"White":str(output[i,0]),"Black":str(output[i,1]),"Asian":str(output[i,2]),"Hispanic":str(output[i,3])})

"""
