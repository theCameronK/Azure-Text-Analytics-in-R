getLanguage <- function(ls, key) {
    library(rjson)
    library(httr)
    library(plyr)
    source("getJsonElementStrLanguage.R")
    source("getJsonStr.R")

    a <- list()
    for (i in 1:length(ls$comment)) {
        a <- c(a, getJsonElementStrLanguage(ls$id[i], ls$comment[i]))
    }

    toJson.text <- getJsonStr(a)
    rm(a)

    write(toJson.text, "toAPI/toAPIQuestionL.json")

    urlLang <- "https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/languages"

    postCall <- POST(urlLang,
              accept_json(),
              config = list(),
              body = upload_file("toAPI/toAPIQuestionL.json"),
              add_headers("Ocp-Apim-Subscription-Key" = key),
              content_type = "application/json",
              accept = "application/json"
              )

    write(content(postCall, "text"), "fromAPI/fromAPIResponseL.json")

    toAPI.json <- fromJSON(file = "toAPI/toAPIQuestionL.json")
    d.i <- lapply(toAPI.json$documents, function(x) { unlist(x) })
    dfReturnTo <- rbind.fill(lapply(d.i, function(x) do.call("data.frame", as.list(x))))

    fromAPI.response <- fromJSON(file = "fromAPI/fromAPIResponseL.json")
    e.i <- lapply(fromAPI.response$documents, function(x) { unlist(x) })
    dfReturnFrom <- rbind.fill(lapply(e.i, function(x) do.call("data.frame", as.list(x))))

    finalDf <- merge(x = dfReturnTo, y = dfReturnFrom, by.id = "id")
    finalDf$language <- NULL

    return(finalDf)
}