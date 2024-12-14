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

# Load the network and initial state.
source("states_of_interest.R")
source("shine_functions.R")
shine <- loadNetwork("networks//shine_q.bnet.txt")

# Find the attractors from 100,000 initial random states
attr_info <- getAttractors(
  shine,
  type = "synchronous",
  method = "random",
  startStates = 10000
)

active_in_all_quiescent <- generateState(shine, c("AA" = 1), default = 1)
active_in_any_quiescent <- generateState(shine, c("AA" = 0), default = 0)
for(i in seq_along(attr_info$attractors)){
	attractor <- getAttractorSequence(attr_info, i)
	if(is_quiescent_attr(attractor)){
    print(i)
    for(i in rownames(attractor)){
      active_in_all_quiescent <- active_in_all_quiescent & attractor[i, ]
      active_in_any_quiescent <- active_in_any_quiescent | attractor[i, ]
    }
  }
}


print("The nodes active in all quiescent attractors are:")
# print(active_in_all_quiescent)
cnames <- colnames(active_in_all_quiescent)
print(cnames[active_in_all_quiescent])
print("The nodes inactive in all quiescent attractors are:")
print(cnames[!active_in_any_quiescent])