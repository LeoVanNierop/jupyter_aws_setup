#!/usr/bin/env Rscript
install.packages(c("pbdZMQ", "repr", "devtools"))
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()

