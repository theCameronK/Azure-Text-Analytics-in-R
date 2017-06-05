getJsonStr <- function(ls) {
    elementStr <- paste(ls, collapse = ',')
    mainStr <- paste("{\"documents\":[", elementStr, "]}", sep = "")
    return(mainStr)
}