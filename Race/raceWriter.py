#Csv writer for results from legFinderGlobal.py
import numpy as np
import pandas as pd
import csv

#Writing props to csv

#Load data needed for everything
props = np.load('realProps.npy')



#Open and give md for csv file
with open('races.csv','w') as csvfile:
    fieldnames = ["Asian","Black","Native","White","2+","Hispanic"]
    writer = csv.DictWriter(csvfile,fieldnames=fieldnames)
    writer.writeheader()
    rows = len(props)

    #Loop through each row, checking failures and then assigning reps to rest
    for location in range(rows):
        
        writer.writerow({"Asian":str(props[location,0]),"Black":str(props[location,1]),"Native":str(props[location,2]),"White":str(props[location,3]),"2+":str(props[location,4]),"Hispanic":str(props[location,5])})
            
