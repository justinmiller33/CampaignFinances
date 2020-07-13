#Race analysis by candidate
#From Race Analysis
import numpy as np
import pandas as pd
from collections import Counter
from matplotlib import pyplot as plt

#Loading race proportion and overall data
props = np.load('realProps.npy')
names = pd.read_excel("C:\devel\CampaignFinances\Locater\masshousefullformatted.xlsx")

#Adusting blank lines at end of names
names = names[0:len(props)]
data = names.to_numpy()

print('loaded')
#To help understancing... heres array of races for the props
races = ["Asian","Black","Native","White","MultiRacial","Hispanic"]

#Seperating into candidates
#Where rl is location with rep names
rl = 0
#Getting counts
repCount = Counter(data[:,rl])
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
    
#Initializing proportion vector for each representative
repProps = np.zeros((len(reps),6))
#For each rep
for i in range(len(reps)):
    #Finding location of all that reps donors
    locs = np.where(data[:,rl] == reps[i])[0]

    #Add each donors race proportions to a matrix
    tempProps = np.zeros((len(locs),6))
    for j in range(len(locs)):
        tempProps[j] = props[locs[j]]

    #Finding average race and adding it to overall matrix
    repRow = sum(tempProps)/sum(sum(tempProps))
    repProps[i] = repRow
        
"""
Out of district, disregarding race... just to reference
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
    
"""Combining these for all w/ in district vs out for each rep"""

def color_boxplot(data, color, pos=[0], ax=None):
    ax = ax or plt.gca()
    bp = ax.boxplot(data, patch_artist=True,  showmeans=True, positions=pos)
    for item in ['boxes', 'whiskers', 'fliers', 'medians', 'caps']:
        plt.setp(bp[item], color=color)


fig,ax = plt.subplots()
bp1 = color_boxplot(repProps[:,0],'yellow',[1])
bp2 = color_boxplot(repProps[:,1],'black',[2])
#bp3 = color_boxplot(repProps[:,3],'white',[3])
bp3 = color_boxplot(repProps[:,5],'brown',[3])
ax.autoscale()
ax.set(xticks = [1,2,3], xticklabels = ['Asian','Black','Hispanic'])
plt.show()


