

verify_attractor <- function(attr, conditions){
	for (i in rownames(attr)){
    state <- attr[i, ]
    for (n in names(conditions)){
      if(state[, n] != conditions[n]){
        return(FALSE)
      }
    }
	}
	return(TRUE)
}