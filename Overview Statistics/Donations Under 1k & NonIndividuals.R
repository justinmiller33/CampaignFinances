library(tidyverse)
library(mosaic)
library(ggformula) 
library(openintro)
library(clipr)
library(data1135)

Senate_Full_Contribution_Data <- read_excel("Campaign Donations Project/Senate Full Contribution Data.xlsx")
names(Senate_Full_Contribution_Data)

newdata <-filter(Senate_Full_Contribution_Data, Amount<=1000)
View(newdata)

#Prop From NonIndividuals
favstats(Amount~(Record_Type_Description=="Individual"), data=newdata)
gf_boxplot(Amount~(Record_Type_Description=="Individual"), data=newdata, bins=15)

#Feeney NonIndividuals
newdata6 <-filter(Senate_Full_Contribution_Data, Amount<=1000, Recipient=="Feeney, Paul")
favstats(Amount~(Record_Type_Description=="Individual"), data=newdata6)
      
#Total Donations By Sex
favstats(Amount~Sex, data=newdata)
gf_boxplot(~Amount| Sex, data=newdata, bins=15)
          
#Total Donations By Race
favstats(Amount~Race, data=newdata)
gf_boxplot(~Amount| Race, data=newdata, bins=15)


newdata2 <-filter(Senate_Full_Contribution_Data, Amount<=1000, Record_Type_Description == "Individual")

#Individual Donations by Sex
favstats(Amount~Sex, data=newdata2)
gf_boxplot(~Amount| Sex, data=newdata, bins=15)

newdata4 <-filter(Senate_Full_Contribution_Data, Amount<=1000,Amount>=500, Record_Type_Description == "Individual")

#Individual Donations Over $500 by Sex
favstats(Amount~Sex, data=newdata4)

#Individual Donations By Race
favstats(Amount~Race, data=newdata2)
gf_boxplot(~Amount| Race, data=newdata2, bins=15)


#Individual Donations by Recipient
favstats(Amount~Recipient, data=newdata2)
        
#Why are Barry Finegold's Donations so high?
newdata3 <-filter(Senate_Full_Contribution_Data, Amount<=1000, Recipient== "Finegold, Barry R.")
view(newdata3)
favstats(Amount~(Record_Type_Description=="Individual"), data=newdata3)


favstats(Amount~(Recipient== "Finegold, Barry R."), data=newdata2)



