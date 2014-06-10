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
rownames(ag) <- ag$district

# linear model with eligible voters as control
m1 <- lm(turnout ~ log(m) + log(eligible_voters), data = ag)
display(m1, detail = TRUE)

png("memo/figs/cooks.png", height = 5, width = 6, res = 72, units = "in")
par(mfrow = c(1, 1), oma = c(0,0,0,0), mar = c(6,4,2,2))
plot(m1, which = 5)
dev.off()

# drop Lianjiang County
m2 <- lm(turnout ~ log(m) + log(eligible_voters), 
             data = ag, subset = district != "Lianjiang County")
display(m2, detail = TRUE)

# linear model without eligible voters as control
m3 <- lm(turnout ~ log(m), data = ag)
display(m3, detail = TRUE, digits = 3)
V <- vcovHC(m3)
coeftest(m3, V, digits = 3)

# just a scatterplot of turnout and magnitude
m1 <- lm(turnout ~ log(m), data = ag)
display(m1, detail = TRUE, digits = 3)
m2 <- rlm(turnout ~ log(m), data = ag, method = "M")
summary(m2, detail = TRUE)

png("memo/figs/scatter.png", height = 5, width = 6, res = 72, units = "in")
par(mfrow = c(1, 1), oma = c(0,0,0,0), mar = c(5,4,2,2))
plot(log(ag$m), ag$turnout, xlab = "log(m)", ylab = "turnout")
abline(m1, col = "black", lwd = 3, lty = 1)
abline(m2, col = "red", lwd = 3, lty = 2)
legend(x = 1.4, y = .62, 
       legend = c("OLS Estimation", "M Estimation"),
       lwd = 2, lty = c(1, 2), col = c("black", "red"),
       bty = "n")
dev.off()

