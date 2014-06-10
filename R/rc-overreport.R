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
library(blme)
library(geepack)
library(arm)

# LOAD PRE-CLEANED DATA
d <- read.csv("output/clean-data-for-overreport.csv")
d <- d[order(d$District), ]
ag <- read.csv("data/aggregate.csv")

ag$turnout <- ag$total_votes/ag$eligible_voters

d$Turnout <- NA
for (i in ag$cses_district_id) {
  d$Turnout[d$District == i] <- mean(ag$turnout[ag$cses_district_id == i], na.rm = TRUE)
  print(i)
  print(ag$turnout[ag$cses_district_id == i])
}

# linear model
d$Dif <- d$Cast.Ballot - d$Turnout 
m1 <- lm(Dif ~ log.Magnitude, data = d)
display(m1, detail = TRUE, digits = 3)

# random effects model
m2 <- lmer(Dif ~ log.Magnitude  + (1 | District), data = d)
display(m2, detail = TRUE, digits = 3)

# GEE model
m3 <- geeglm(Dif ~ log.Magnitude, id = d$District, data = d,
             corstr = "exchangeable")
summary(m3)

# Stata-style cluster robust standard errors
# Calculate cluster-robust standard errors Stata-style
m1 <- lm(Dif ~ log.Magnitude, data = d)
M <- length(unique(d$District))
N <- length(d$District)
K <- m1$rank
dfc <- (M/(M - 1)) * ((N - 1)/(N - K))
uj <- apply(estfun(m1), 2, function(x) tapply(x, d$District, sum));
uj <- na.omit(uj)
Sigma <- dfc * sandwich(m1, meat = crossprod(uj)/N)
coeftest(m1, Sigma)

# predicting voting with actual turnout
m4 <- glm(Cast.Ballot ~ Turnout, family = binomial, data = d)
m5 <- glm(Cast.Ballot ~ Turnout*log.Magnitude, family = binomial, data = d)
display(m4)
display(m5)
anova(m4, m5, test = "Chisq")
AIC(m4, m5)
BIC(m4, m5)

