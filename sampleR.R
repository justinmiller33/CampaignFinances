#Sample Script Highlighting Benefits of GITHUB Collaboration

#Load some libraries
library(tidyverse)
library(mosaic)
library(ggformula) 
library(openintro)
library(clipr)
library(readxl)


#Github is best for making code universal (can run on any of our laptops)


#Example: Data Path
#This path will be the same for any of our computers 
path <- "/devel/CampaignFinances/";

#For any upload, we can input the file
file1 <- "Senate Full Contribution Data.xlsx";
file2 <- "orderedDistricts.csv";

#Then you can load any file in repository
#Just concatanate with the path
df <- read_excel(paste(path, file1, sep = ''));
rawData <- read.csv(paste(path, file2, sep = ''));
