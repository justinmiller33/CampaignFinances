#Classifying each donor as having a public or private job
import numpy as np
import pandas as pd
import csv

donations = pd.read_excel("senate2018.xlsx")

publicLabels = ["State",
"City",
"Town",
"Commonwealth",
"School",
"Public",
"Jail",
"County",
"Prison",
"Umass",
"Massachusetts",
"Schools",
"Police",
"Fire"]

public = np.zeros(len(donations))

for i in range(len(donations)):
    for j in range(len(publicLabels)):
        if publicLabels[j].lower() in str(donations.Employer[i]).lower():
            public[i] = 1


with open('publics.csv', 'w') as csvfile:
            fieldnames = ['public']
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()

            for i in range(len(donations)):
                writer.writerow({'public': str(public[i])})
                

            
        
