
# Make sure that working directory is set properly, e.g.,
# setwd("~/Dropbox/projects/taiwan/")

# Clear workspace
rm(list = ls())

# Create directory for output
dir.create(path = "output", showWarnings = FALSE)
dir.create(path = "doc/figs", showWarnings = FALSE)
dir.create(path = "doc/tabs", showWarnings = FALSE)

# Do each part of the analysis
source("R/clean-data.R", echo = TRUE)
source("R/bma-close.R", echo = TRUE)
source("R/bma-contacted.R", echo = TRUE)
source("R/bma-represented.R", echo = TRUE)
source("R/bma-turnout.R", echo = TRUE)