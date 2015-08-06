#--------------------------------------------------------
# NOTE
# Make sure that working directory is set properly, e.g.,
# setwd("~/Dropbox/projects/taiwan/")
#--------------------------------------------------------

# CLEAR WORKSPACE
rm(list = ls())

# LOAD PACKAGES
library(arm)
library(compactr)
library(texreg)

# LOAD PRE-CLEANED DATA
twn2001 <- read.csv("output/clean-data.csv")

###################################################################
## Cast.Ballot
###################################################################

# ESTIMATE MODEL
m1 <- glm(Cast.Ballot ~ log.Magnitude + Age + Age.Squared.by.100 + 
            Male + Education + Married + Union.Member + 
            Household.Income + Rural + Small.Town + Suburb + 
            White.Collar + Worker + Hakka + MinNan + Mainlander,
            family = binomial, data = twn2001, x = TRUE)

# SIMULATE MODEL
n.sims <- 1000
sim1 <- coef(sim(m1, n = n.sims))
X <- data.frame(m1$x)

# COMPUTE QIS
X.lo <- X.hi <- X
X.lo$log.Magnitude <- 0
X.hi$log.Magnitude <- log(10)
pr.lo <- plogis(as.matrix(X.lo)%*%t(sim1))
pr.hi <- plogis(as.matrix(X.hi)%*%t(sim1))

mean.pr.lo <- apply(pr.lo, 2, mean)
mean.pr.hi <- apply(pr.hi, 2, mean)
qi1 <- quantile(mean.pr.hi - mean.pr.lo, c(.05, .5, .95))

###################################################################
## Represented
###################################################################

# ESTIMATE MODEL
m2 <- glm(Represented ~ log.Magnitude + Age + Age.Squared.by.100 + 
            Male + Education + Married + Union.Member + 
            Household.Income + Rural + Small.Town + Suburb + 
            White.Collar + Worker + Hakka + MinNan + Mainlander,
          family = binomial, data = twn2001, x = TRUE)

# SIMULATE MODEL
n.sims <- 1000
sim1 <- coef(sim(m2, n = n.sims))
X <- data.frame(m1$x)

# COMPUTE QIS
X.lo <- X.hi <- X
X.lo$log.Magnitude <- 0
X.hi$log.Magnitude <- log(10)
pr.lo <- plogis(as.matrix(X.lo)%*%t(sim1))
pr.hi <- plogis(as.matrix(X.hi)%*%t(sim1))

mean.pr.lo <- apply(pr.lo, 2, mean)
mean.pr.hi <- apply(pr.hi, 2, mean)
qi2 <- quantile(mean.pr.hi - mean.pr.lo, c(.05, .5, .95))
  
###################################################################
## Close.To.Party
###################################################################

# ESTIMATE MODEL
m3 <- glm(Close.To.Party ~ log.Magnitude + Age + Age.Squared.by.100 + 
            Male + Education + Married + Union.Member + 
            Household.Income + Rural + Small.Town + Suburb + 
            White.Collar + Worker + Hakka + MinNan + Mainlander,
          family = binomial, data = twn2001, x = TRUE)

# SIMULATE MODEL
n.sims <- 1000
sim1 <- coef(sim(m3, n = n.sims))
X <- data.frame(m1$x)

# COMPUTE QIS
X.lo <- X.hi <- X
X.lo$log.Magnitude <- 0
X.hi$log.Magnitude <- log(10)
pr.lo <- plogis(as.matrix(X.lo)%*%t(sim1))
pr.hi <- plogis(as.matrix(X.hi)%*%t(sim1))

mean.pr.lo <- apply(pr.lo, 2, mean)
mean.pr.hi <- apply(pr.hi, 2, mean)
qi3 <- quantile(mean.pr.hi - mean.pr.lo, c(.05, .5, .95))

###################################################################
## Contacted
###################################################################

# ESTIMATE MODEL
m4 <- glm(Contacted ~ log.Magnitude + Age + Age.Squared.by.100 + 
            Male + Education + Married + Union.Member + 
            Household.Income + Rural + Small.Town + Suburb + 
            White.Collar + Worker + Hakka + MinNan + Mainlander,
          family = binomial, data = twn2001, x = TRUE)

# SIMULATE MODEL
n.sims <- 1000
sim1 <- coef(sim(m4, n = n.sims))
X <- data.frame(m1$x)

# COMPUTE QIS
X.lo <- X.hi <- X
X.lo$log.Magnitude <- 0
X.hi$log.Magnitude <- log(10)
pr.lo <- plogis(as.matrix(X.lo)%*%t(sim1))
pr.hi <- plogis(as.matrix(X.hi)%*%t(sim1))

mean.pr.lo <- apply(pr.lo, 2, mean)
mean.pr.hi <- apply(pr.hi, 2, mean)
qi4 <- quantile(mean.pr.hi - mean.pr.lo, c(.05, .5, .95))

# CREATE FIGURE
pdf("doc/figs/logit.pdf", height = 4, width = 4)
par(mfrow = c(1,1), mar = c(5,1,1,1), oma = c(0,0,0,0))
eplot(xlim = c(-.15, 0.15), ylim = c(1,5),
      anny = FALSE,
      xlab = "Estimated Effect of Moving\nMagnitude from One to Ten",
      text.size = 1.2,
      xlabpos = 3) 
abline(v = 0)
abline(v = .1, lty = 2)
abline(v = .05, lty = 2, col = "grey")

# Cast.Ballot
lines(qi1[c(1,3)], c(4,4), lwd = 2)
points(qi1[2], 4, pch = 19)
text(qi1[2], 4, "Turning Out to Vote", pos = 3)
# Represented
lines(qi2[c(1,3)], c(3,3), lwd = 2)
points(qi2[2], 3, pch = 19)
text(qi2[2], 3, "Feeling Represented", pos = 3)
# Close.To.Party
lines(qi3[c(1,3)], c(2,2), lwd = 2)
points(qi3[2], 2, pch = 19)
text(qi3[2], 2, "Feeling Close to a Party", pos = 3)
# Contacted
lines(qi4[c(1,3)], c(1,1), lwd = 2)
points(qi4[2], 1, pch = 19)
text(qi4[2], 1, "Being Contacted by a Party", pos = 3)
dev.off()

# SAVE TABLE
texreg(list(m1, m2, m3, m4), stars = 0.05,
       #reorder.gof = 2,
       dcolumn = TRUE,
       scriptsize = TRUE,
       float.pos = "h!",
       label = "tab:logit",
       include.bic = FALSE,
       include.aic = FALSE,
       include.loglik = FALSE,
       include.deviance = FALSE,
       use.packages = FALSE,
       include.variance = FALSE,
       file = "doc/tabs/logit.tex",
       caption = "This table shows the estimates from logit models of the four outcomes of interest. Notice that district magnitude does not exert a significant effect on any of the outcomes of interest. Further, the estiamted effect of district magnitude is negative for two of the outcomes, including turning out to vote.  (see Table \\ref{tab:F_partial} for the details)."
)