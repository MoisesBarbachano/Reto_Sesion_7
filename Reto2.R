install.packages("rvest")

library(rvest)
library(xml2)
library(dplyr)

theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(theurl)

tables <- html_nodes(file, "table")

table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))  

str(table)

table$Sueldo <- gsub('MXN','',table$Sueldo)
table$Sueldo <- gsub('/mes','',table$Sueldo)
table$Sueldo <- gsub(',','.',table$Sueldo)
table$Sueldo <- gsub("[$),]",'',table$Sueldo)
table$Sueldo <- as.numeric(table$Sueldo)

str(table)

table %>% slice(which.min(table$Sueldo))
table %>% slice(which.max(table$Sueldo))

