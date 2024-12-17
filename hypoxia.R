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

# Now add catecholamine to the last state i the attractor
q_hyp <- tail(path1, n = 1)
q_hyp["O2"] <- 0

# Which state will we reach?
path_cat <- getPathToAttractor(shine, q_hyp)

png(
    file = "plots//hypoxia_effect.png", # nolint: indentation_linter.
    width = 500,
    height = 4000
)
plotSequence(sequence = path_cat, title = "Hypoxia effect")
# grid.table(t(path1))
dev.off()