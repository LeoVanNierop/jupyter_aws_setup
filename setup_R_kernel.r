#!/usr/bin/env Rscript
install.packages(c("pbdZMQ", "repr", "devtools"), repos="http://cran.rstudio.com/")
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()

