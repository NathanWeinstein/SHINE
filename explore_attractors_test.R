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
shine <- loadNetwork("networks//shine_1.bnet.txt")

# Load the attractor (found separately by findattractors.R)
loaded <- load("attractors.RData") # Contains "attr_info"
quiescence <- list(
    all = generateState(shine, c("AA" = 1), default = 1), 
    none = generateState(shine, c("AA" = 0), default = 0), 
    some = generateState(shine, c("AA" = 0), default = 0),
    attr = c(),
    count = 0
)
barrier_function <- list(
    all = generateState(shine, c("AA" = 1), default = 1), 
    none = generateState(shine, c("AA" = 0), default = 0), 
    some = generateState(shine, c("AA" = 0), default = 0),
    attr = c(),
    count = 0
)
oxidative_stress  <- list(
    all = generateState(shine, c("AA" = 1), default = 1), 
    none = generateState(shine, c("AA" = 0), default = 0), 
    some = generateState(shine, c("AA" = 0), default = 0),
    attr = c(),
    count = 0
)
glycocalyx_shedding <- list(
    all = generateState(shine, c("AA" = 1), default = 1), 
    none = generateState(shine, c("AA" = 0), default = 0), 
    some = generateState(shine, c("AA" = 0), default = 0),
    attr = c(),
    count = 0
)
endothelial_dysfunction <- list(
    all = generateState(shine, c("AA" = 1), default = 1), 
    none = generateState(shine, c("AA" = 0), default = 0), 
    some = generateState(shine, c("AA" = 0), default = 0),
    attr = c(),
    count = 0
)
sorting_hat <- function(cond, store, attractor, i){
  browser()
  if(verify_attractor(attractor, cond) == TRUE){
    store$count <- store$count + 1
    store$attr <- c(store$attr, i)
    for(i in rownames(attractor)){
      store$all <- store$all & attractor[i, ]
      store$some <- store$some | attractor[i, ]
    }
  }
  return(store)
}


attractor <- getAttractorSequence(attr_info, 2)
quiescence <- sorting_hat(c(quiescent = 1), quiescence, attractor, 2)
barrier_function <- sorting_hat(c(barrier_function = 1), barrier_function, attractor, 2)
oxidative_stres <- sorting_hat(c(oxidative_stress = 1), oxidative_stress, attractor, 2)
glycocalyx_shedding <- sorting_hat(c(glycocalyx_shedding = 1), glycocalyx_shedding, attractor, 2)
endothelial_dysfunction <- sorting_hat(c(endothelial_dysfunction = 1), endothelial_dysfunction, attractor, 2)

cnames <- colnames(quiescence$all)
quiescence$none <- ! quiescence$some
barrier_function$none <- ! barrier_function$some
oxidative_stress$none <- ! oxidative_stress$some
glycocalyx_shedding$none <- ! glycocalyx_shedding$some
endothelial_dysfunction$none <- ! endothelial_dysfunction$some

