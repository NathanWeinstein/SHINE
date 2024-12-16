## First specify the packages of interest
packages <- c("BoolNet", "VennDiagram")

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
  startStates = 100000
)

active_in_all_quiescent <- generateState(shine, c("AA" = 1), default = 1)
active_in_any_quiescent <- generateState(shine, c("AA" = 0), default = 0)
for(i in seq_along(attr_info$attractors)){
	attractor <- getAttractorSequence(attr_info, i)
	if(is_quiescent_attr(attractor)){
    for(i in rownames(attractor)){
      active_in_all_quiescent <- active_in_all_quiescent & attractor[i, ]
      active_in_any_quiescent <- active_in_any_quiescent | attractor[i, ]
    }
  }
}


print("The nodes active in all quiescent attractors are:")
cnames <- colnames(active_in_all_quiescent)
active_in_all <- cnames[active_in_all_quiescent]
print(active_in_all)
print("The nodes inactive in all quiescent attractors are:")
inactive_in_all <- cnames[!active_in_any_quiescent]
print(inactive_in_all)

# Find the genes that are active in some but not all quiescent attractor states.
groups <- list(
  active = cnames[active_in_any_quiescent],
  inactive = cnames[!active_in_all_quiescent]
)

active_in_some_not_all <- intersect(groups$active, groups$inactive)
print("The nodes inactive in some, but not all quiescent attractors are:")
print(active_in_some_not_all)
save(
  active_in_all,
  inactive_in_all,
  active_in_some_not_all,
  file = "quiescence.RData"
)
