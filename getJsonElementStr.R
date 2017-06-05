getJsonElementStr <- function(idNum, text, lang = "en") {
    text <- gsub("\"", "", text )
    returnStr <- paste("{\"language\":\"", lang, "\",\"id\":\"", idNum, "\",\"text\":\"", text, "\"}", sep = "")
    return(returnStr)
}