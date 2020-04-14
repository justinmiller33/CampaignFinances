import shapefile
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

#Reading Data from .shp file
sf = shapefile.Reader("/Users/justi/OneDrive/Documents/datasets/OCPF Data/senate2012/SENATE2012_POLY.shp")

def lengthFinder(numDistricts):
    maxLengths = np.zeros(numDistricts)
    for j in range(numDistricts):
        feature = sf.shapeRecords()[j]
        first = feature.shape.__geo_interface__

        data = np.asarray(first["coordinates"])

        x = np.array([])
        y = np.array([])

        #Don't need to identify specific values, just use exception handling
        #if j>0 and j<7 or j>14 and j<17 or j==18:
        try:
            for i in range (np.size(data[0][0], axis=0)):
                x = np.append([x],data[0][0][i][0])
                y = np.append([y],data[0][0][i][1])

        except:
            try:
        #elif j<13: #and j!=:
                for i in range (np.size(data, axis=1)):
                    x = np.append([x],data[:,i][0][0])
                    y = np.append([y],data[:,i][0][1])
            except:
        #else:
                for i in range (np.size(data[0], axis=0)):
                    x = np.append([x],data[0][i][0])
                    y = np.append([y],data[0][i][1])

        maxLengths[j] = len(x)
        
    return(sum(maxLengths)-39)

def dataExtract(numDistricts, length):
    maxLengths = np.zeros(numDistricts)
    df = np.zeros([length,5])
    prevInd = 0
    for j in range(numDistricts):
        feature = sf.shapeRecords()[j]
        first = feature.shape.__geo_interface__

        data = np.asarray(first["coordinates"])

        x = np.array([])
        y = np.array([])

        #Wierd ass data
        #Don't need to identify specific values, just use exception handling

        try:
            for i in range (np.size(data[0][0], axis=0)):
                x = np.append([x],data[0][0][i][0])
                y = np.append([y],data[0][0][i][1])
        except:
            try:
                for i in range (np.size(data, axis=1)):
                    x = np.append([x],data[:,i][0][0])
                    y = np.append([y],data[:,i][0][1])
            except:
                for i in range (np.size(data[0], axis=0)):
                    x = np.append([x],data[0][i][0])
                    y = np.append([y],data[0][i][1])

        for k in range(prevInd,prevInd+i):
            df[k] = np.array([x[k-prevInd], x[k-prevInd+1], y[k-prevInd], y[k-prevInd+1],j])

        df[k+1] = np.array([x[len(x)-1], x[0], y[len(x)-1], y[0], j])
        prevInd = k+1

    return(df)

def algorithm(data, meters):
    crosses = np.zeros(40)
    for i in range(len(data)):
        if data[i,0] > meters[0] or data[i,1] > meters[0]:
            if data[i,2] < meters[1] and data[i,3] > meters[1] or data[i,2] > meters[1] and data[i,3] < meters[1]:
                crosses[int(data[i,4])] = crosses[int(data[i,4])]+1
                
    if sum(crosses%2)==1:
        return np.argmax(crosses%2)
    else:
        return crosses

#-------------------------------------------------------------

length = int(lengthFinder(40))
df = dataExtract(40,length)
#coords = coordLookup(address)
#meters = converter(coords)
meters = np.array([200000,880000])

district = algorithm(df,meters)

print(district)

