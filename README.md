Manuscript, code, and data for "Does District Magnitude Matter? The Case of Taiwan." [[Paper](http://www.carlislerainey.com/papers/taiwan.pdf)]

> A sizable literature on electoral institutions argues that proportional electoral rules lead to higher voter turnout. However, recent work finds little evidence that the effect generalizes beyond western Europe and the theoretical arguments remain sparse, incomplete, and contradictory. I use a well-chosen data set to resolve problems of omitted variable bias and Bayesian model averaging to address model uncertainty and evaluate evidence both for and against the null hypotheses. I find evidence that the proportionality of electoral rules exerts no meaningful effect on turnout or the any of the theoretical mechanisms I test.

# Files

## `data`

- `aggregate.csv`: aggregate, district-level turnout data for the 2001 election in Taiwan. I use this for the robustness checks discussed in footnote 1 on the differences between individual-level and aggregate-level data sets and footnote 5 on the potential problems with self-reporting.
- [missing] `cses2_rawdata.txt`: the raw data from module 2 of the CSES. These data are to large to host on GitHub, so these data can be downloaded from [here](http://www.cses.org/datacenter/module2/data/cses2.zip). This file simply needs to be placed in the `data` subdirectory.

## `doc`

- `apsr_fs.bst`: a custom bibliography style file that I use for LaTeX.
- `bibliography.bib`: a bibliography database for the paper.
- `taiwan.pdf`: a pdf copy of the paper.
- `taiwan.tex`: the LaTeX file to produce the paper.

## `R`

- `bma-close.R`: an R script to do the main analysis for feeling close to a party.
- `bma-contacted.R`: an R script to do the main analysis for being contacted by a party.
- `bma-represented.R`: an R script to do the main analysis for feeling represented by a party.
- `bma-turnout.R`: an R script to do the main analysis for feeling close to a party.
- `clean-data.R`: an R script to clean the raw CSES data.
- `do-all.R`: an R script to run each script in the proper order.
- `fn-plot-model-space.R`: a custom R function to plot the variables included in each model and the posterior probability of that model.
- `fn-plot-posterior.R`: a custom R function to plot the posterior distribution of the averaged models.
- `rc-aggregate.R`: used for the robustness check discussed in footnote 1.
- `rc-logit.R`: used for the robustness check discussed at the end of the paper in the section "Robustness Check with Logistic Regression."
- `rc-mi.R`: used to for the robustness check on multiple imputation discussed in footnote 5.
- `rc-overreport.R`: used for the robustness check discussed in footnote 4.
- `rc-turnout-pred.R`: plot the predicted probability of turning out and the district magnitude. Note discussed in the paper.

# Comments

If you have any comments or suggestion, please [open an issue](https://github.com/carlislerainey/taiwan/issues) or just [e-mail](mailto:carlislerainey@gmail.com) me.

# Replication

To replicate these results, you can use Git to clone this repository or download it as a `.zip` archive. The original CSES data set is too large to host in a GitHub repository, so you need to create a subdirectory called `data`, download [this `.zip` file](http://www.cses.org/datacenter/module2/data/cses2.zip) and unzip it, and move the file `cses2_rawdata.txt` into `data` subdirectory. Once you do this, you can replicate all the results by simply setting the project directory (i.e., `taiwan`) as R's working directory and running the script `do-all.R`. This takes just a couple of minutes. Note that the `do-all.R` script creates a new subdirectories `output`, `doc/figs`, and `doc/tabs` that store all the R output, tables, and figures, respectively.
