import shapefile
import numpy as np
import matplotlib.pyplot as plt
import time

sf = shapefile.Reader("C:/devel/CampaignFinances/Locater/senate2012/SENATE2012_POLY.shp")

for k in range(1,41):
    for j in range(k):
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

        
        plt.plot(x,y)

    if k%5 == 0:
        plt.show()
    
    


