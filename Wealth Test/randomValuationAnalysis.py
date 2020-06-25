#Random Home Valuation Analyis
import numpy as np
from matplotlib import pyplot as plt
from matplotlib.ticker import PercentFormatter

#Load in values from randomValuationTest.py
homePrice = np.load('homePrice.npy')
amounts = np.load('amounts.npy')
inDistrict = np.load('inDistrict.npy')
outDistrict = np.load('outDistrict.npy')
randomDonors = np.load('randomDonors.npy')

#Finding failures
failures = np.array([])
for i in range(len(homePrice)):
    if homePrice[i] == 0:
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
