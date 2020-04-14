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
        
    return(maxLengths)

def dataExtract(numDistricts, maxLength):
    maxLengths = np.zeros(numDistricts)
    for j in range(numDistricts):
        feature = sf.shapeRecords()[j]
        first = feature.shape.__geo_interface__

        data = np.asarray(first["coordinates"])

        df = np.zeros([2,numDistricts,maxLength])
        

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

        for k in range(len(x)):
            df[0,j,k]=x[k]
            df[1,j,k]=y[k]

    return df

#_____________________________________________________________
        
lengths = lengthFinder(40)
data = dataExtract(40,int(np.max(lengths)))
