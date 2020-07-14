#Random Home Valuation Analyis
import numpy as np
from matplotlib import pyplot as plt
from matplotlib.ticker import PercentFormatter
import pandas as pd
from scipy import stats
import math
from scipy.stats import t

#Getting names formatted
#Loading data to numpy array
dataPath = "C:/devel/CampaignFinances/Locater/"
fileName = "mass_house_full_update.xlsx"
names = pd.read_excel(dataPath+fileName)
names = names.to_numpy()
print('Loaded ' + str(len(names)) +' donations')

#Deleting rows with bad addresses
toDelete = np.array([])
opto = 0
for i in range(len(names)):
    if names[i,20] >= 162:
        toDelete = np.append(toDelete,[int(i)])
        continue
    try:
        if '#' in names[i,9]:
            toDelete = np.append(toDelete,[int(i)])
            opto = opto + 1
    except:
        toDelete = np.append(toDelete,[int(i)])
        opto = opto + 1
        
        
names = np.delete(names,toDelete,0)


#Load in values from randomValuationTest.py
homePrice = np.load('homePrice.npy')
amounts = np.load('amounts.npy')
inDistrict = np.load('inDistrict.npy')
outDistrict = np.load('outDistrict.npy')
randomDonors = np.load('randomDonors.npy')

#Finding failures
notInd = 0
failures = np.array([])
for i in range(len(homePrice)):
    if homePrice[i] == 0:
        failures = np.append(failures,[i])
    elif names[randomDonors[i],3] != 'Individual':
        notInd = notInd + 1
        failures = np.append(failures,[i])

hp = np.delete(homePrice,failures,0)

#Also remove failures from amounts, id, od, and rd
iD = np.delete(inDistrict,failures)
oD = np.delete(outDistrict,failures)
am = np.delete(amounts,failures)
rD = np.delete(randomDonors,failures)

#Getting home prices for in and out
inDistPrices = np.array([])
outDistPrices = np.array([])

for i in range(len(iD)):
    if iD[i] == 1:
        inDistPrices = np.append(inDistPrices,[hp[i]])
    elif oD[i] == 1:
        outDistPrices = np.append(outDistPrices,[hp[i]])

#Plotting a double histogram (on reg and log scale)
#Plug in an even right above max value
#nb = Number of Bins
nb = 20
bins = np.linspace(np.min(inDistPrices),np.max(outDistPrices),nb)

def plot(bins,inDistPrices,outDistPrices):
    plt.hist(inDistPrices, bins, alpha=0.5, label='In District')
    plt.hist(outDistPrices, bins, alpha=0.5, label='Out of District')
    plt.legend(loc='upper right')
    plt.xlabel('LN() of Home Price')
    plt.ylabel('Count of Homes')
    plt.title('Home Price of Donors')
    plt.show()

#plot(bins,inDistPrices,outDistPrices)

bins = np.linspace(np.min(np.log(inDistPrices)),np.max(np.log(outDistPrices)),nb)
plot(bins, np.log(inDistPrices),np.log(outDistPrices))

# Plotting with normal outlined
def plotWithNorm(bins,inDistPrices,outDistPrices):
    
    weights = np.ones(len(inDistPrices)) / len(inDistPrices)
    plt.hist(inDistPrices, bins, weights = weights, alpha=0.5, label='In District','orange')

    weights = np.ones(len(outDistPrices)) / len(outDistPrices)
    plt.hist(outDistPrices, bins, weights = weights, alpha=0.5, label='Out of District','blue')

    plt.legend(loc='upper right')
    plt.xlabel('LN() of Home Price')
    plt.ylabel('Count of Homes')
    plt.title('Home Price of Donors')
    plt.gca().yaxis.set_major_formatter(PercentFormatter(1))

    
def ttest(inDistPrices,outDistPrices,ci):
    #normalizing with logplot
    inDistPrices = np.log(inDistPrices)
    outDistPrices = np.log(outDistPrices)
    
    #Getting degrees of freedom and t value
    df = len(inDistPrices)+len(outDistPrices)-2
    tVal = t.ppf([ci], df)

    #Getting pooled std
    sp = math.sqrt( (len(inDistPrices)*(np.std(inDistPrices)**2)+len(outDistPrices)*(np.std(outDistPrices)**2))/df)
    print(sp)
    #Getting moe
    moe = sp*math.sqrt(1/len(inDistPrices)+1/len(outDistPrices))

    outInterval = [math.e**(np.mean(outDistPrices)-tVal*moe),math.e**(np.mean(outDistPrices+tVal*moe))]

    return outInterval

# Function to put normal curve over data
# Input already normalized arrays (np.log)
def plotNormsExponentiated(normInDist,normOutDist):

    getNormal = lambda data : np.linspace(np.mean(data) - 4*np.std(data), np.mean(data) + 4*np.std(data), 100)
    
    
    plt.plot(math.e**(getNormal(normInDist)), math.e**(stats.norm.pdf(getNormal(normInDist), np.mean(normInDist), np.std(normInDist))))
    plt.plot(math.e**(getNormal(normOutDist)), math.e**(stats.norm.pdf(getNormal(normOutDist), np.mean(normOutDist), np.std(normOutDist))))
    
    plt.show()
    
def plotNorms(normInDist,normOutDist):

    getNormal = lambda data : np.linspace(np.mean(data) - 4*np.std(data), np.mean(data) + 4*np.std(data), 100)
    
    
    plt.plot(getNormal(normInDist), stats.norm.pdf(getNormal(normInDist), np.mean(normInDist), np.std(normInDist))/5)
    plt.plot(getNormal(normOutDist), stats.norm.pdf(getNormal(normOutDist), np.mean(normOutDist), np.std(normOutDist))/5)
    
    plt.show()
    
#Getting interval for out of district mean
ci = 0.95
outInterval = ttest(inDistPrices,outDistPrices,ci)
inLogMean = math.e**(np.mean(np.log(inDistPrices)))

#Getting interval of proportion increase
piMin = (outInterval[0][0] - inLogMean)/inLogMean
piMax = (outInterval[1]-inLogMean)/inLogMean

print('95% CI of Home Price Increase: ' + str([piMin,piMax]))
