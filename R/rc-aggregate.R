#--------------------------------------------------------
# NOTE
# Make sure that working directory is set properly, e.g.,
# setwd("~/Dropbox/projects/taiwan/")
#--------------------------------------------------------

# CLEAR WORKSPACE
rm(list = ls())

# LOAD PACKAGES
library(foreign)
library(sandwich)
library(lmtest)
library(arm)

# LOAD PRE-CLEANED DATA
ag <- read.csv("data/aggregate.csv")

ag$turnout <- ag$total_votes/ag$eligible_voters

# linear model with eligible voters as control
m1 <- lm(turnout ~ log(m) + log(eligible_voters), data = ag)
display(m1, detail = TRUE)
plot(m1)

# drop Lianjiang County
m2 <- lm(turnout ~ log(m) + log(eligible_voters), 
             data = ag, subset = district != "Lianjiang County")
display(m2, detail = TRUE)

# linear model without eligible voters as control
m3 <- lm(turnout ~ log(m), data = ag)
display(m3, detail = TRUE, digits = 3)
V <- vcovHC(m3)
coeftest(m3, V)

