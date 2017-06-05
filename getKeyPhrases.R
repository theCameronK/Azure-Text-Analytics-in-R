getKeyPhrases <- function(ls, key) {
    library(rjson)
    library(httr)
    library(plyr)
    source("getJsonElementStr.R")
    source("getJsonStr.R")

    a <- list()
    for (i in 1:length(ls$comment)) {
        a <- c(a, getJsonElementStr(ls$id[i], ls$comment[i]))
    }

    toJson.text <- getJsonStr(a)
    rm(a)

    write(toJson.text, "toAPI/toAPIQuestionKP.json")

    urlKeyPhrases <- "https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/keyPhrases"

    postCall <- POST(urlKeyPhrases,
              accept_json(),
              config = list(),
              body = upload_file("toAPI/toAPIQuestionKP.json"),
              add_headers("Ocp-Apim-Subscription-Key" = key),
              content_type = "application/json",
              accept = "application/json"
              )

    write(content(postCall, "text"), "fromAPI/fromAPIResponseKP.json")

    toAPI.json <- fromJSON(file = "toAPI/toAPIQuestionKP.json")
    d.i <- lapply(toAPI.json$documents, function(x) { unlist(x) })
    dfReturnTo <- rbind.fill(lapply(d.i, function(x) do.call("data.frame", as.list(x))))

    fromAPI.response <- fromJSON(file = "fromAPI/fromAPIResponseKP.json")
    e.i <- lapply(fromAPI.response$documents, function(x) { unlist(x) })
    dfReturnFrom <- rbind.fill(lapply(e.i, function(x) do.call("data.frame", as.list(x))))

    finalDf <- merge(x = dfReturnTo, y = dfReturnFrom, by.id = "id")
    finalDf$language <- NULL

    return(finalDf)
}