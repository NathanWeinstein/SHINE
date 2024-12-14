## First specify the packages of interest
packages <- c("BoolNet")

## Now load or install & load all
package_check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
    }
    library(x, character.only = TRUE)
  }
)

source("states_of_interest.R")
shine <- loadNetwork("networks//shine_q.bnet.txt")


path1 <- getPathToAttractor(shine, initial_quiescence)

png(
    file = "plots//Path1.png", # nolint: indentation_linter.
    width = 500,
    height = 4000
)
plotSequence(sequence = path1, title = "Path 1")
# grid.table(t(path1))
dev.off()
