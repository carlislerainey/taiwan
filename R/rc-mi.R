#--------------------------------------------------------
# NOTE
# Make sure that working directory is set properly, e.g.,
# setwd("~/Dropbox/projects/taiwan/")
#--------------------------------------------------------

# CLEAR WORKSPACE
rm(list = ls())

# LOAD PACKAGES
library(BMA)
library(foreign)
library(Amelia)

# LOAD PRE-CLEANED DATA
twn2001 <- read.csv("output/clean-data-for-mi.csv")

n.imp <- 3
mi <- amelia(twn2001, m = n.imp,
             noms = c("Cast.Ballot",
                      "Represented",
                      "Close.To.Party",
                      "Contacted",
                      "Male",
                      "Married",
                      "Union.Member",
                      "Rural",
                      "Small.Town",
                      "Suburb",
                      "White.Collar",
                      "Worker",
                      "Hakka",
                      "MinNan",
                      "Mainlander"),
             ords = c("Education",
                      "Household.Income"),
             idvars = c("X"))

## CASTING A BALLOT

outcome.var <- "Cast.Ballot"
ctrl.vars <- names(twn2001[-c(1, 2, 3, 4, 5, 6, 7, 8)])
key.expl.var <- "log.Magnitude"
all.vars <- c(ctrl.vars, outcome.var, key.expl.var)
expl.vars <- c(ctrl.vars, key.expl.var)

mi.ests <- numeric(n.imp)
pb <- txtProgressBar(min = 0, max = n.imp, style = 3)
for (i in 1:n.imp) {
  mi.data <- mi$imputations[[i]]
  X <- mi.data[, expl.vars]
  y <- mi.data[, outcome.var]
  bma1 <- bic.glm(X, y, glm.family = "binomial", OR = 1000)
  mi.ests[i] <- bma1[[13]]["log.Magnitude"]  
  setTxtProgressBar(pb, i)
}
mean(mi.ests)

## FEELING CLOSE TO A PARTY

outcome.var <- "Close.To.Party"
ctrl.vars <- names(twn2001[-c(1, 2, 3, 4, 5, 6, 7, 8)])
key.expl.var <- "log.Magnitude"
all.vars <- c(ctrl.vars, outcome.var, key.expl.var)
expl.vars <- c(ctrl.vars, key.expl.var)

mi.ests <- numeric(n.imp)
pb <- txtProgressBar(min = 0, max = n.imp, style = 3)
for (i in 1:n.imp) {
  mi.data <- mi$imputations[[i]]
  X <- mi.data[, expl.vars]
  y <- mi.data[, outcome.var]
  bma1 <- bic.glm(X, y, glm.family = "binomial", OR = 1000)
  mi.ests[i] <- bma1[[13]]["log.Magnitude"]  
  setTxtProgressBar(pb, i)
}
mean(mi.ests)

## CONTACTED BY A PARTY

outcome.var <- "Contacted"
ctrl.vars <- names(twn2001[-c(1, 2, 3, 4, 5, 6, 7, 8)])
key.expl.var <- "log.Magnitude"
all.vars <- c(ctrl.vars, outcome.var, key.expl.var)
expl.vars <- c(ctrl.vars, key.expl.var)

mi.ests <- numeric(n.imp)
pb <- txtProgressBar(min = 0, max = n.imp, style = 3)
for (i in 1:n.imp) {
  mi.data <- mi$imputations[[i]]
  X <- mi.data[, expl.vars]
  y <- mi.data[, outcome.var]
  bma1 <- bic.glm(X, y, glm.family = "binomial", OR = 1000)
  mi.ests[i] <- bma1[[13]]["log.Magnitude"]  
  setTxtProgressBar(pb, i)
}
mean(mi.ests)

## REPRESENTED

outcome.var <- "Represented"
ctrl.vars <- names(twn2001[-c(1, 2, 3, 4, 5, 6, 7, 8)])
key.expl.var <- "log.Magnitude"
all.vars <- c(ctrl.vars, outcome.var, key.expl.var)
expl.vars <- c(ctrl.vars, key.expl.var)

mi.ests <- numeric(n.imp)
pb <- txtProgressBar(min = 0, max = n.imp, style = 3)
for (i in 1:n.imp) {
  mi.data <- mi$imputations[[i]]
  X <- mi.data[, expl.vars]
  y <- mi.data[, outcome.var]
  bma1 <- bic.glm(X, y, glm.family = "binomial", OR = 1000)
  mi.ests[i] <- bma1[[13]]["log.Magnitude"]  
  setTxtProgressBar(pb, i)
}
mean(mi.ests)