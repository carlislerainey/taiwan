#--------------------------------------------------------
# NOTE
# Make sure that working directory is set properly, e.g.,
# setwd("~/Dropbox/projects/taiwan/")
#--------------------------------------------------------

# CLEAR WORKSPACE
rm(list = ls())

# LOAD PACKAGES
library(BMA)
library(xtable)

# LOAD PRE-CLEANED DATA
twn2001 <- read.csv("output/clean-data.csv")

outcome.var <- "Contacted"
ctrl.vars <- names(twn2001[-c(1, 2, 3, 4, 5, 6, 7, 8)])
key.expl.var <- "log.Magnitude"

all.vars <- c(ctrl.vars, outcome.var, key.expl.var)
expl.vars <- c(ctrl.vars, key.expl.var)

X <- twn2001[, expl.vars]
y <- twn2001[, outcome.var]

bma1 <- bic.glm(X, y, glm.family = "binomial", OR = 1000)
summary(bma1)

var.names <- c("Age", "Age Squared by 100", "Male", "Education",
               "Married", "Union Member", "Household Income",
               "Rural", "Small Town", "Suburb", "White Collar",
               "Worker", "Hakka", "Min Nan", "Mainlander", "log(Magnitude)")

pdf("doc/figs/ContactedDensity.pdf", height = 6, width = 9)
source("R/fn-plot-posterior.R")
par(oma = c(1,1,0,0), mar = c(2,2,3,1), las = 1)
plot.posterior(bma1, mfrow = c(4,4), ylim = c(0,1), names = var.names)
dev.off()

pdf("doc/figs/ContactedModels.pdf", height = 6, width = 9)
source("R/fn-plot-modelspace.R")
par(mfrow = c(1,1), oma = c(0, 3,0,0))
plot.modelspace(bma1, color = c("black", "red", "white"), names = var.names)
dev.off()

options(scipen=999)
print(xtable(summary(bma1, digits = 2),
             caption = "A table showing the posterior probabilities that the variables 
      have a non-zero impact on being contacted by a political party, the posterior means and standard deviations, and the 
      best five model specifications and their posterior probabilities. Notice
      particularly that the probability that district magnitude has a non-zero
      effect is estimated to be 0.023.",
             label = "tab:close"), 
      file = "doc/tabs/contacted_table.tex", size="\\scriptsize")
