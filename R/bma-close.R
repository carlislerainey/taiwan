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

outcome.var <- "Close.To.Party"
ctrl.vars <- names(twn2001[-c(1, 2, 3, 4, 5, 6, 7, 8)])
key.expl.var <- "log.Magnitude"

all.vars <- c(ctrl.vars, outcome.var, key.expl.var)
expl.vars <- c(ctrl.vars, key.expl.var)

X <- twn2001[, expl.vars]
y <- twn2001[, outcome.var]

bma1 <- bic.glm(X, y, glm.family = "binomial", OR = 1000)
summary(bma1)

pdf("doc/figs/CloseDensity.pdf", height = 6, width = 9)
par(oma = c(1,1,0,0), mar = c(2,2,3,1), las = 1)
plot(bma1, mfrow = c(4,4), ylim = c(0,1))
dev.off()

pdf("doc/figs/CloseModels.pdf", height = 6, width = 9)
par(mfrow = c(1,1), oma = c(0, 3,0,0))
imageplot.bma(bma1, color = c("red", "blue", "white"))
dev.off()

options(scipen=999)
print(xtable(summary(bma1, digits = 2),
             caption = "A table showing the posterior probabilities that the variables 
      have a non-zero impact on feeling close to a political party, the posterior means and standard deviations, and the 
      best five model specifications and their posterior probabilities. Notice
      particularly that the probability that district magnitude has a non-zero
      effect is estimated to be 0.026.",
             label = "tab:close"), 
      file = "doc/tabs/close_table.tex", size="\\scriptsize")