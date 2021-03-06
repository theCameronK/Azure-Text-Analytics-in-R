# Azure-Text-Analytics-in-R
This repository is for R-scripts that interact with the Azure Text Analytics API.
https://azure.microsoft.com/en-us/services/cognitive-services/text-analytics/

These scripts send text to the Azure Text Analytics API and return sentiments score, key phrases, and languages detected (1).

Must format input as .csv to be read in.
You can only send 1000 documents at a time.
After importing the table msut have a "id" and "comment" column. The "comment" column is the text to be analyzed.

The example I have posted is the AFI top 100 movie quotes of all time. I change the rank column to be the "id" and the quote to be the "comment" column.

By running staging.R, adding your API key and source .csv, the program will run.

-----------------------------------

The idea is to read in the .csv and turn it into a table. Then reading off the table turn the text and id into acceptable json format and push that to the API. The return json is parsed back into a table, combined with the original table and exported to a .csv as well as a dataFrame that can be manipulated in R.

-----------------------------------
Resources
1) Quick Start Guide - https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/quick-start
2) API Documentation - https://westus.dev.cognitive.microsoft.com/docs/services/TextAnalytics.V2.0/operations/56f30ceeeda5650db055a3c9
3) API Testing console - https://westus.dev.cognitive.microsoft.com/docs/services/TextAnalytics.V2.0/operations/56f30ceeeda5650db055a3c9/console
