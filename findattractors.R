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

shine <- loadNetwork("networks//shine_1.bnet.txt")

# Find the attractors from 100,000 initial random states
attr_info <- getAttractors(
  shine,
  type = "synchronous",
  method = "random",
  startStates = 100000
)

save(
  attr_info,
  file = "attractors.RData"
)
