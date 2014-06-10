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
library(arm)

# LOAD PRE-CLEANED DATA
twn2001 <- read.csv("output/clean-data-for-turnout-pred.csv")

outcome.var <- "Cast.Ballot"
ctrl.vars <- names(twn2001[-c(1, 2, 3, 19)])
key.expl.var <- "log.Magnitude"
all.vars <- c(ctrl.vars, outcome.var, key.expl.var)
expl.vars <- c(ctrl.vars)

X <- twn2001[, expl.vars]
y <- twn2001[, outcome.var]
bma1 <- bic.glm(X, y, glm.family = "binomial", OR = 1000)

# PREDICT, MODEL, AND PLOT
twn2001$pred <- predict(bma1, newdata = twn2001, type = "response")
plot(twn2001$log.Magnitude, twn2001$pred)
m0 <- lm(pred ~ log.Magnitude, data = twn2001)
display(m0, digits = 3, detail = TRUE)
abline(m0)
coef(m0)[2]*log(13)

summary(bma1)
cor(twn2001)