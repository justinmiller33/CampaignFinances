#Analysis on matts spreadsheet
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from scipy import stats

file = 'houseCandidatesUpdated.xlsx'
data = pd.read_excel(file)


#Getting list of winner and loser indices
winnerInd = data['Winner?'] == "Winner"
loserInd = data['Winner?'] == "Loser"


#Plotting three on top of each other
income = data['20th_Percentile_HH_Income']
outProp = data['out.prop']


#plt.plot(income[winnerInd],outProp[winnerInd],'*')

income = data['Median_HH_Income']
#income = data['20th_Percentile_HH_Income']

plt.plot(income[loserInd],outProp[loserInd],'*')

print(stats.linregress(income[loserInd],outProp[loserInd]))



#plt.plot(income[winnerInd],outProp[winnerInd],'*')


plt.show()
