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

#load the network
shine <- loadNetwork("shine_q.bnet.txt")

# Fif the attractors from 100,000 initial random states
attractors <- getAttractors(
    shine,
    type = "synchronous",
    method = "random",
    startStates = 100000
)