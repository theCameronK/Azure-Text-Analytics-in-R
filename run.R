run <- function(data, filePathOut, key) {
    library(digest)
    source("getSentiment.R")
    source("getKeyPhrases.R")
    source("getLanguage.R")

    test.data = data
    ld <- length(test.data)
    #----------------------------------
    #api calls
    dfS <- getSentiment(test.data, key)
    dfKP <- getKeyPhrases(test.data, key)
    dfL <- getLanguage(test.data, key)

    #-------------------------------------------------
    #making tabels pretty
    dfSM <- merge(x = test.data, y = dfS, by = "id")
    dfSM$text <- NULL

    dfLM <- merge(x = dfSM, y = dfL, by = "id")
    dfLM$text <- NULL
    dfLM$detectedLanguages.iso6391Name <- NULL
    dfLM$detectedLanguages.score <- NULL

    dfKPM <- merge(x = dfLM, y = dfKP, by = "id")
    dfKPM$text <- NULL

    finalDf <- dfKPM
    colnames(finalDf)[ld + 2] <- "detectedLanguages"

    i <- sapply(finalDf, is.factor)
    finalDf[i] <- lapply(finalDf[i], as.character)
    finalDf$score <- as.numeric(finalDf$score)

    finalDf[is.na(finalDf)] <- ""

    ld9 <- ld + 3
    ld10 <- ld + 4
    lm1 <- length(finalDf) -1 

    if (length(finalDf) > 9) {
        for (k in ld9:lm1) {
            finalDf[, ld9] <- cbind(finalDf[, ld9], finalDf[, ld10])
            finalDf[, ld10] <- NULL
        }

        colNumKP <- length(finalDf$keyPhrases[1,])
        rowNumKP <- length(finalDf$keyPhrases[, 1])

        colnames(finalDf)[ld9] <- "keyPhrases"

        for (m in 1:rowNumKP) {
            finalDf$keyPhrases[m,] <- sort(finalDf$keyPhrases[m,], decreasing = TRUE)
        }

        for (l in 1:colNumKP) {
            if (identical(finalDf$keyPhrases[, l], rep("", rowNumKP))) {
                finalDf$keyPhrases <- finalDf$keyPhrases[, - l]
            }
        }
    }

    #--------------------------------------------------------------------------------
    #writing to csv
    write.csv(finalDf, filePathOut, row.names = FALSE)

    return(finalDf)
}