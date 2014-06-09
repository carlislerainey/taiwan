#--------------------------------------------------------
# NOTE
# Make sure that working directory is set properly, e.g.,
# setwd("~/Dropbox/projects/taiwan/")
#--------------------------------------------------------

# CLEAR WORKSPACE
rm(list = ls())

# LOAD DATA
data <- read.csv("data/cses2_rawdata.txt")

# CREATE A NEW, EMPTY DATA FRAME TO FILL
twn2001 <- NULL
twn2001 <- data.frame(row.names = 1:length(data$B1001))

### Alpha.Polity

# STORE VARIABLE IN NEW DATA FRAME 
twn2001$Alpha.Polity <- data$B1004

### Age

twn2001$Age <- data$B2001
twn2001$Age[twn2001$Age>=997] <- NA
summary(twn2001$Age)

### Age.Squared

twn2001$Age.Squared.by.100 <- ((twn2001$Age)^2)/100
summary(twn2001$Age.Squared.by.100)

### Male

twn2001$Male <- data$B2002
twn2001$Male[twn2001$Male==1] <- 1
twn2001$Male[twn2001$Male==2] <- 0
twn2001$Male[twn2001$Male>2] <- NA
summary(twn2001$Male)

### Education

twn2001$Education <- data$B2003
twn2001$Education[twn2001$Education>=9] <- NA
summary(twn2001$Education)

### Married

twn2001$Married <- data$B2004
twn2001$Married[twn2001$Married==1] <- 1
twn2001$Married[twn2001$Married>1 & twn2001$Married<7] <- 0
twn2001$Married[twn2001$Married>6] <- NA
summary(twn2001$Married)

### Union.Member

twn2001$Union.Member <- data$B2005
twn2001$Union.Member[twn2001$Union.Member==1] <-1
twn2001$Union.Member[twn2001$Union.Member==2] <-0
twn2001$Union.Member[twn2001$Union.Member>2] <-NA
summary(twn2001$Union.Member)

### Employed

twn2001$Employed <- data$B2010
twn2001$Employed[twn2001$Employed == 97] <- NA
twn2001$Employed[twn2001$Employed == 98] <- NA
twn2001$Employed[twn2001$Employed == 99] <- NA 
twn2001$Employed[twn2001$Employed == 1] <- 1
twn2001$Employed[twn2001$Employed > 1] <- 0
 

### SES

twn2001$SES <- data$B2012
twn2001$SES[twn2001$SES == 7] <- NA
twn2001$SES[twn2001$SES == 8] <- NA
twn2001$SES[twn2001$SES == 9] <- NA

# White.Collar
twn2001$White.Collar <- twn2001$SES
twn2001$White.Collar[twn2001$White.Collar != 1] <- 0

# Worker
twn2001$Worker <- twn2001$SES
twn2001$Worker[twn2001$Worker != 2] <- 0
twn2001$Worker[twn2001$Worker == 2] <- 1


### Household.Income

twn2001$Household.Income <- data$B2020
twn2001$Household.Income[twn2001$Household.Income==9] <- NA
twn2001$Household.Income[twn2001$Household.Income==6] <- NA
twn2001$Household.Income[twn2001$Household.Income==7] <- NA
twn2001$Household.Income[twn2001$Household.Income==8] <- NA
summary(twn2001$Household.Income)

### Ethnicity

twn2001$Ethnicity <- data$B2029
twn2001$Ethnicity[twn2001$Ethnicity==997] <- NA
twn2001$Ethnicity[twn2001$Ethnicity==998] <- NA
twn2001$Ethnicity[twn2001$Ethnicity==999] <- NA
summary(twn2001$Ethnicity)

twn2001$Hakka <- rep(0, nrow(twn2001))
twn2001$Hakka[twn2001$Ethnicity == 1] <- 1

twn2001$MinNan <- rep(0, nrow(twn2001))
twn2001$MinNan[twn2001$Ethnicity == 2] <- 1

twn2001$Mainlander <- rep(0, nrow(twn2001))
twn2001$Mainlander[twn2001$Ethnicity == 3] <- 1

### Population.Density

twn2001$Population.Density <- data$B2030
twn2001$Population.Density[twn2001$Population.Density >= 7] <- NA
twn2001$Rural <- twn2001$Population.Density
twn2001$Small.Town <- twn2001$Population.Density
twn2001$Suburb <- twn2001$Population.Density
twn2001$Rural[twn2001$Rural != 1] <- 0
twn2001$Small.Town[twn2001$Small.Town != 2] <- 0
twn2001$Suburb[twn2001$Suburb != 3] <- 0
twn2001$Rural[twn2001$Rural == 1] <- 1
twn2001$Small.Town[twn2001$Small.Town == 2] <- 1
twn2001$Suburb[twn2001$Suburb == 3] <- 1

### District

twn2001$District <- data$B2031

### Cast.Ballot

twn2001$Cast.Ballot <- data$B3004_1
twn2001$Cast.Ballot[twn2001$Cast.Ballot==9] <- NA
twn2001$Cast.Ballot[twn2001$Cast.Ballot==8] <- 0
twn2001$Cast.Ballot[twn2001$Cast.Ballot==7] <- 0
twn2001$Cast.Ballot[twn2001$Cast.Ballot==6] <- NA
twn2001$Cast.Ballot[twn2001$Cast.Ballot==4] <- 0
twn2001$Cast.Ballot[twn2001$Cast.Ballot==2] <- 0
summary(twn2001$Cast.Ballot)


### Represented 

twn2001$Represented <- data$B3023
twn2001$Represented[twn2001$Represented == 2] <- 0
twn2001$Represented[twn2001$Represented == 4] <- 1
twn2001$Represented[twn2001$Represented == 7] <- NA
twn2001$Represented[twn2001$Represented == 8] <- NA
twn2001$Represented[twn2001$Represented == 9] <- NA


### Close.To.Party

twn2001$Close.To.Party <- data$B3028
twn2001$Close.To.Party[twn2001$Close.To.Party==9] <- NA
twn2001$Close.To.Party[twn2001$Close.To.Party==8] <- NA
twn2001$Close.To.Party[twn2001$Close.To.Party==7] <- NA
twn2001$Close.To.Party[twn2001$Close.To.Party==2] <- 0
summary(twn2001$Close.To.Party)

### Contacted

twn2001$Contacted <- data$B3003
twn2001$Contacted[twn2001$Contacted==9] <- NA
twn2001$Contacted[twn2001$Contacted==8] <- NA
twn2001$Contacted[twn2001$Contacted==7] <- NA
twn2001$Contacted[twn2001$Contacted==2] <- 0
summary(twn2001$Contacted)

### Number.Seats

twn2001$Magnitude <- data$B4001
twn2001$Magnitude[twn2001$Magnitude==999] <- NA
twn2001$Magnitude[twn2001$District==1] <- 9  # average for Taipei County
twn2001$Magnitude[twn2001$District==63] <- 10  # average For Taipei City
twn2001$Magnitude[twn2001$District==64] <- 5.5 # Kaohsiung City

twn2001$log.Magnitude <- log(twn2001$Magnitude)

twn2001$SMD[twn2001$Magnitude == 1] <- 1
twn2001$SMD[twn2001$Magnitude > 1] <- 0

### KEEP ONLY COUNTRIES TO BE USED IN THE ANALYSIS

twn2001$Alpha.Polity <- as.character(twn2001$Alpha.Polity)
twn2001$Alpha.Polity[twn2001$Alpha.Polity=="TWN_2001"] <- "Taiwan (2001)"
twn2001 <- twn2001[twn2001$Alpha.Polity == "Taiwan (2001)", ]

main.vars <- c("Cast.Ballot", "Represented", "Close.To.Party", "Contacted", 
                "Magnitude", "log.Magnitude", "SMD", "Age", "Age.Squared.by.100", 
                "Male", "Education", "Married", "Union.Member", 
                "Household.Income", "Rural", "Small.Town", "Suburb", 
                "White.Collar", "Worker", "Hakka", "MinNan", "Mainlander")
mi.vars <- c("Cast.Ballot", "Represented", "Close.To.Party", "Contacted", 
             "log.Magnitude", "Age", "Age.Squared.by.100", 
             "Male", "Education", "Married", "Union.Member", 
             "Household.Income", "Rural", "Small.Town", "Suburb", 
             "White.Collar", "Worker", "Hakka", "MinNan", "Mainlander")
overreport.vars <- c("Cast.Ballot", "log.Magnitude", "Magnitude", "District")

twn2001.main <- twn2001[ , main.vars]
twn2001.mi <- twn2001[ , mi.vars]
twn2001.overreport <- twn2001[ , overreport.vars]



####################################################################

# SAVE THESE DATA
write.csv(twn2001.main, "output/clean-data.csv")
write.csv(twn2001.mi, "output/clean_data-for-mi.csv")
write.csv(twn2001.overreport, "output/clean-data-for-overreport.csv")


####################################################################
