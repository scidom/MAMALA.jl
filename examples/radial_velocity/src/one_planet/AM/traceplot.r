library(data.table)
library(stringr)

OUTDIR <- "../../../output/one_planet"
SUBOUTDIR <- "AM"

npars <- 6

nmcmc <- 50000
nburnin <- 10000
npostburnin <- nmcmc-nburnin

nmeans <- 10000
ci <- 1
pi <- 2

chains <- t(fread(
  file.path(OUTDIR, SUBOUTDIR, paste("chain", str_pad(ci, 2, pad="0"), ".csv", sep="")), sep=",", header=FALSE
))

chainmean = mean(chains[, pi])

pdf(file=file.path(OUTDIR, SUBOUTDIR, "traceplot.pdf"), width=10, height=6)

plot(
  1:npostburnin,
  chains[, pi],
  type="l",
  ylim=c(2.95, 3.15),
  col="steelblue2",
  xlab="",
  ylab="",
  cex.axis=1.8,
  cex.lab=1.7,
  yaxt="n"
)

axis(
  2,
  at=seq(2.95, 3.15, by=0.05),
  labels=seq(2.95, 3.15, by=0.05),
  cex.axis=1.8,
  las=1
)

lines(
  1:npostburnin,
  rep(chainmean, npostburnin),
  type="l",
  col="orangered1",
  lwd=2
)

dev.off()