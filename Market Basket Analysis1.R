
## Loading Packages

library(tidyverse)
library(arules)
library(ggplot2)
library(arulesViz)
library(knitr)
library(dplyr)
library(plyr)
library(magrittr)
library(readxl)
library(RColorBrewer)

Data <- read.csv("C:/Users/rkoni/Downloads/archive/BD customer1.csv")

## Manipulating the data-frame

Data.transaction <- ddply(Data, c("BillNo", "CustomerID"),
                          function(df) paste(df$Itemname, collapse = (",")))

view(Data.transaction)

Data.transaction$BillNo <- NULL
Data.transaction$CustomerID <- NULL

colnames(Data.transaction) <-  c("ItemName")

## Saving Transaction Data

write.csv(Data.transaction, "Sold Product", quote = F, row.names = F)

Sold.poroduct <- read.transactions("C:/Users/rkoni/OneDrive/Documents/Sold Product", 
                                   format = "basket", sep = "," )

summary(Sold.poroduct)

## Determining Association Rule

rules.1 <- apriori(Sold.poroduct, parameter = list(supp = 0.002, conf = 0.05))

rules.1 <- sort(rules.1, by = "lift")

inspect(rules.1[1:5])

# Ploting Graphs

plot(rules.1, method = "grouped", col = "blue")

plot(rules.1, method = "graph", col = "blue")







