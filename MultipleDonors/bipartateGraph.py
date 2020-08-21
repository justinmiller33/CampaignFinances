#Bipartate graph of people with common donors
#Loading data
import numpy as np
import pandas as pd
from collections import Counter
import math
import networkx as nx
from matplotlib import pyplot as plt

dataPath = "C:/devel/CampaignFinances/Locater/"
fileName = "mass_senate_full.xlsx"
names = pd.read_excel(dataPath+fileName)
names = names.to_numpy()
print('Loaded ' + str(len(names)) +' donations')


fileName = "mass_house_full_update.xlsx"
names2 = pd.read_excel(dataPath+fileName)
names2 = names2.to_numpy()
print('Loaded ' + str(len(names2)) +' more donations')


names = np.concatenate((names, names2), axis=0)
print('yeeted')

#Initializing counter
cnt = Counter()

#Making an personal identifier out of a namecity combo (! as delimiter for later)
nameCity = np.array([])
for i in range(len(names)):
    nameCity = np.append(nameCity, [str(names[i,8])+'!'+str(names[i,10])])

print("ID's Loaded")

#Function to make it easy to get ID
getID = lambda index : str(names[index,8])+'!'+str(names[index,10])
    

#Making count of donors and number of donations
for name in nameCity:
    cnt[name] += 1

repCnt = Counter()
#Making list of recipient names
for repName in names[:,5]:
    repCnt[repName] += 1
    

#For each donor
donors = np.array([])
values = np.array([])
for i in range(len(list(cnt.values()))):
    #tempValue for that donors # of donations
    tempVal = list(cnt.values())[i]

    #If its more than one, put them in contention for the bipartate graph
    if tempVal > 1:
        donors = np.append(donors, [list(cnt.keys())[i]])
        values = np.append(values,[tempVal])


graph = np.zeros((len((list(repCnt.keys()))),len(list(repCnt.keys()))))
#Looping through each donor
for i in range(len(donors)):
    if i%100 == 50:
        print(i)
        
    #List of each reps accepting donations from this donor
    repList = np.array([])
    
    #For each row in names
    for j in range(len(names)):
        
        #If we hit that donor
        if getID(j) == donors[i]:
    
            #Add the rep at that donation index (if not already in there)
            tempRep = names[j,5]
            repWhere = int(np.where(tempRep == np.array(list(repCnt.keys())))[0][0])
           
            if repWhere not in repList:
                repList = np.append(repList, [repWhere])

    #Exit if replist is just 1 (only loop through graph for those with different reps)
    if len(repList) <= 1:
        continue
    
    #Initializing loop to get all combinations of repList
    for j in range(len(repList)):
        for k in range(len(repList)):
            if repList[j] != repList[k]:
                graph[int(repList[j]),int(repList[k])] += 1



def trim(graph,cutoff):
	for i in range(len(graph)):
		for j in range(len(graph)):
			if graph[i,j] < cutoff * max(math.floor(list(repCnt.values())[i]),math.floor(list(repCnt.values())[j])):
				graph[i,j] = 0

	#Graph Trimmed
	return graph

def weighted(graph,repLabel):

    loc = lambda name : np.where(repLabel == name)[0][0] 
    G = nx.Graph()

    for i in range(len(graph)):
        for j in range(len(graph)):
            G.add_edge(repLabel[i],repLabel[j],weight = graph[i,j])

    esen=[(u,v) for (u,v,d) in G.edges(data=True) if loc(u) <= 64 and loc(v) <= 64 ]
    eboth=[(u,v) for (u,v,d) in G.edges(data=True) if (loc(u) <= 64 and loc(v) > 64) or (loc(u) > 64 and loc(v) <=64)]
    erep=[(u,v) for (u,v,d) in G.edges(data=True) if loc(u) > 64 and loc(v) > 64]

    #Getting node colors
    colorMap = []
    for node in G:
        if loc(node) > 64:
            colorMap.append('blue')
        else:
            colorMap.append('red')
            
    #Colors for in senate vs in reps vs inbetween
    pos=nx.spring_layout(G)
    
    #Nodes
    nx.draw_networkx_nodes(G,pos, node_size=300,node_color = colorMap, alpha = .7)
   
    
    #Edges
    #nx.draw_networkx_edges(G,pos,edgelist=erep,width=1, edge_color = 'b', alpha = 0.5)
    #nx.draw_networkx_edges(G,pos,edgelist=esen,width=1, edge_color = 'r', alpha = 0.5)
    nx.draw_networkx_edges(G,pos,edgelist=eboth,width=1, alpha = 0.5)

    nx.draw(G, node_color=color_map)
    
    plt.show()

#Cutoff is proportion of total donations to the bigger candidate in the group
cutoff = .01
gt = trim(graph,cutoff)

#Labeling
reps = list(repCnt.keys())
labels = {}
for i in range(len(reps)):
    labels[i] = reps[i]
    

G = nx.from_numpy_matrix(gt)
pos=nx.spring_layout(G)

nx.draw(G)
plt.show()
