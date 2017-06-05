getJsonElementStrLanguage <- function(idNum, text) {
    text <- gsub("\"", "", text)
    returnStr <- paste("{\"id\":\"", idNum, "\",\"text\":\"", text, "\"}", sep = "")
    return(returnStr)
}