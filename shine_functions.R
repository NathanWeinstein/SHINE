# A function to decide if a state is quiescent
is_quiescent <- function(state){
    if(
        state["barrier_function"] == 1 &&
        state["oxidative_stress"] == 0 &&
        state["glycocalyx_shedding"] == 0 &&
        state["endothelyal_dysfunction"] == 0
    ){
        return(TRUE)
    }else{
        return(FALSE)
    }
}

# A function to analyze an atractor
is_quiescent_attr <- function(attr){
	for (i in rownames(attr)){
		if(is_quiescent(attr[i, ]) == FALSE){
            return(FALSE)
        }
	}
	return(TRUE)
}