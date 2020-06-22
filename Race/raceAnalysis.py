#Race Analysis
import numpy as np
import pandas as pd

#Loading race proportion and overall data
props = np.load('realProps.npy')
names = pd.read_excel("C:\devel\CampaignFinances\Locater\mass_house_full_update.xlsx")

#Adusting blank lines at end of names
names = names[0:len(props)]
data = names.to_numpy()

print('loaded')
#To help understancing... heres array of races for the props
races = ["Asian","Black","Native","White","MultiRacial","Hispanic"]

"""
In district vs. out of District by race
"""
#inD and outD indices
inD = np.array([])
outD = np.array([])

for i in range(len(data)):
    if names.district[i] == names.repDistrict[i]:
        inD = np.append(inD,[i])
        
    elif names.district[i] <= 161:
        outD = np.append(outD,[i])
        
        
#Racial distribution of inD:
inSums = np.zeros((len(inD),6))
for i in range(len(inD)):
    inSums[i] = props[int(inD[i])] 
    
#Racial distribution of outD:
outSums = np.zeros((len(outD),6))
for i in range(len(outD)):
    outSums[i] = props[int(outD[i])]

#Finding inD proportions and outD proportions:
inR = sum(inSums)/len(inSums)
outR = sum(outSums)/len(outSums)

#Normalizing inR and outR
inR = inR * 100/sum(inR)
outR = outR * 100/sum(outR)

#%Change from inD, want to be negative/low...*NOTE, PINS RACES AGAINST EACHOTHER
pChange = (outR-inR)/inR

"""Average donation amount by races"""
indMounts = np.zeros((len(inD),6))

fails1 = 0
for i in range(len(inD)):
    try:
        indMounts[i] = names.Amount[int(inD[i])]*props[int(inD[i])]
    except:
        fails1 = fails1+1
        continue

indsByRace = sum(indMounts)/sum(inSums)

outdMounts = np.zeros((len(outD),6))
fails2 = 0
for i in range(len(outD)):
    try:
        outdMounts[i] = names.Amount[int(outD[i])]*props[int(outD[i])]
    except:
        fails2 = fails2+1
        continue

outdsByRace = sum(outdMounts)/sum(outSums)

#Throwback... out of district/in district ratio
outInRatio  = sum(outSums)/sum(inSums)


#Money coming from in district vs. money coming from out of district ratio:
moneyRatio = outInRatio*(outdsByRace/indsByRace)

#Printing summary statistics
output = pd.DataFrame(np.array([outInRatio,indsByRace,outdsByRace,moneyRatio]),columns = races, index = ['Out/In Donor Ratio','Average In','Average Out','Out/In Money Ratio'])
pd.set_option("display.max_columns",None)
print(output)
