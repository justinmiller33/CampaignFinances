#In District handler for all 2018 races
import numpy as np
import pandas as pd

#Loading and converting
reps = pd.read_excel("reps2018.xlsx")
reps = reps.to_numpy()
donations = pd.read_excel("senate2018.xlsx")

#Detailing hash
dHash = np.array([38,33,25,21,15,7,16,35,36,39,14,22,20,23,9,5,6,18,34,10,4,28,43,

#For each donor
for i in range(len(donations)):
    if donations.district[i]
