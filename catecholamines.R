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
q_cat <- tail(path1, n = 1)
q_cat["EPI"] <- 1
q_cat["NE"] <- 1

# Which state will we reach?
path_cat <- getPathToAttractor(shine, q_cat)

png(
    file = "plots//catecholamine_effect.png", # nolint: indentation_linter.
    width = 500,
    height = 4000
)
plotSequence(sequence = path_cat, title = "Catecholamine effect")
# grid.table(t(path1))
dev.off()