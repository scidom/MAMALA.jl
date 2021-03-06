library(data.table)
library(stringr)

cmd_args <- commandArgs()
CURRENTDIR <- dirname(regmatches(cmd_args, regexpr("(?<=^--file=).+", cmd_args, perl=TRUE)))
ROOTDIR <- dirname(dirname(CURRENTDIR))
OUTDIR <- file.path(ROOTDIR, "output")

# OUTDIR <- "../output"

SUBOUTDIR <- "MALA"

nmcmc <- 110000
nburnin <- 10000
npostburnin <- nmcmc-nburnin

ci <- 6
pi <- 17

chains <- t(fread(
  file.path(OUTDIR, SUBOUTDIR, paste("chain", str_pad(ci, 2, pad="0"), ".csv", sep="")), sep=",", header=FALSE
))

chainmean <- mean(chains[, pi])

pdf(file=file.path(OUTDIR, SUBOUTDIR, "tdist_mala_traceplot.pdf"), width=10, height=6)

plot(
  1:npostburnin,
  chains[, pi],
  type="l",
  ylim=c(-5, 5),
  col="steelblue2",
  xlab="",
  ylab="",
  cex.axis=1.8,
  cex.lab=1.7,
  yaxt="n"
)

axis(
  2,
  at=seq(-5, 5, by=1),
  labels=seq(-5, 5, by=1),
  cex.axis=1.8,
  las=1
)

lines(
  1:npostburnin,
  rep(chainmean, npostburnin),
  type="l",
  col="black",
  lwd=2
)

dev.off()
