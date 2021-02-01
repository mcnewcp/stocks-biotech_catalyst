### this script saves the dataset to rds

write_rds(
  list(priceDF = tranDF, offerDF = offerDF, tckDF = tckDF),
  here(paste0("ROutput/dataset/dataset_", Sys.Date(), ".rds"))
)
rm(offerDF, tckDF, tranDF)
