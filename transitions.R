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

# Load the network and tools
source("shine_functions.R")
source("states_of_interest.R")
shine <- loadNetwork("networks//shine_1.bnet.txt")
path1 <- getPathToAttractor(shine, initial_quiescence)

png(
  file = "plots//quiescence.png", # nolint: indentation_linter.
  width = 500,
  height = 4000
)
plotSequence(sequence = path1, title = "Pah to quiescence")
# grid.table(t(path1))
dev.off()

attr_info <- getAttractors(
  shine,
  type = "synchronous",
  method = "chosen",
  startStates = list(initial_quiescence)
)

atrq <- getAttractorSequence(attr_info, 1)
quiescence <- verify_attractor(atrq, c(quiescent = 1))
if(quiescence){
  print("quiescence reached")
}



