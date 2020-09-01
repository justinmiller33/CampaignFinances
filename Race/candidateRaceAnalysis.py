#Race analysis by candidate
#From Race Analysis
import numpy as np
import pandas as pd
from collections import Counter
from matplotlib import pyplot as plt

#Loading race proportion and overall data
props = np.load('houseFinalOutputNew.npy')
names = pd.read_excel("C:/devel/CampaignFinances/Locater/house_full_individual.xlsx")

#Adusting blank lines at end of names
data = names.to_numpy()

print('loaded')
#To help understancing... heres array of races for the props
races = ["White","Black","Asian","Hispanic"]

#Seperating into candidates
#Where rl is location with rep names
rl = 0
#Getting counts
repCount = Counter(names.Filer_Full_Name_Reverse)
reps = list(repCount.keys())

"""
Optional, cutting out reps with less than a certain # of donations
"""
trimmedReps = np.array([])
cutoff = 100
for i in range(len(reps)):
    if repCount[reps[i]] >= cutoff:
        trimmedReps = np.append(trimmedReps,[reps[i]])

print(len(reps))
reps = trimmedReps
print(len(reps))

# Overall rep Proportions
#Initializing proportion vector for each representative
repProps = np.zeros((len(reps),4))
#For each rep
for i in range(len(reps)):
    #Finding location of all that reps donors
    locs = np.where(names.Filer_Full_Name_Reverse == reps[i])[0]

    #Add each donors race proportions to a matrix
    tempProps = np.zeros((len(locs),4))
    for j in range(len(locs)):
        tempProps[j] = props[locs[j]]

    #Finding average race and adding it to overall matrix
    repRow = sum(tempProps)/sum(sum(tempProps))
    repProps[i] = repRow

# Rep proportions by in and out of district
inRepProps = np.zeros((len(reps),4))
outRepProps = np.zeros((len(reps),4))
"""
# For each rep
for i in range(len(reps)):
    
    # Finding location of all that reps donors
    locs = np.where(names.Filer_Full_Name_Reverse == reps[i])[0]

    # Arrays of toDelete for in and out of district cases
    toDeleteForIn = np.array([])
    toDeleteForOut = np.array([])

    # Looping through locations for that rep
    for j in range(len(locs)):
        
        # If out of district, add to delete array for in
        if data[locs[j],14] != data[locs[j],15] and data[locs[j],14] <= 161:
            toDeleteForIn = np.append(toDeleteForIn, j)

        # Else, add to the delete for out array
        elif data[locs[j],14] == data[locs[j],15]:
            toDeleteForOut = np.append(toDeleteForOut, j)

  
        
    # Deleting for both inLocs and outLocs
    inLocs = np.delete(locs,toDeleteForIn)
    outLocs = np.delete(locs,toDeleteForOut)

    #Add each donors race proportions to a matrix
    inTempProps = np.zeros((len(inLocs),4))
    outTempProps = np.zeros((len(outLocs),4))

    # Looping through locs for in and out, adding to proportion matrices
    for k in range(len(inLocs)):
        inTempProps[k] = props[inLocs[k]]

    for k in range(len(outLocs)):
        outTempProps[k] = props[outLocs[k]]

    #Finding average race and adding it to overall matrix
    inRepRow = sum(inTempProps)/sum(sum(inTempProps))
    inRepProps[i] = inRepRow

    outRepRow = sum(outTempProps)/sum(sum(outTempProps))
    outRepProps[i] = outRepRow
 """   
"""
Out of district, disregarding race... just to reference
"""
"""
#Location of donor district and rep district
#For each rep
oiRatio = np.zeros(len(reps))
for i in range(len(reps)):
    #Finding location of all that reps donors
    locs = np.where(data[:,rl] == reps[i])[0]

    indTemp = 0
    oodTemp = 0
    for j in range(len(locs)):
        if data[locs[j],14] == data[locs[j],15]:
            indTemp = indTemp+1
        elif data[locs[j],14] <= 161:
            oodTemp = oodTemp+1

    oiRatio[i] = oodTemp/indTemp
 """   
"""Combining these for all w/ in district vs out for each rep"""

def color_boxplot(data, color, pos=[0], ax=None):
    ax = ax or plt.gca()
    bp = ax.boxplot(data, patch_artist=True,  showmeans=True, positions=pos)
    for item in ['boxes', 'whiskers', 'fliers', 'medians', 'caps']:
        plt.setp(bp[item], color=color)


fig,ax = plt.subplots()
bp1 = color_boxplot(repProps[:,0],'white',[1])
bp2 = color_boxplot(repProps[:,1],'black',[2])
bp3 = color_boxplot(repProps[:,2],'yellow',[3])
bp4 = color_boxplot(repProps[:,3],'brown',[4])
ax.autoscale()
ax.set(xticks = [1,2,3,5], xticklabels = ['White','Black','Asian','Hispanic'])
plt.show()


