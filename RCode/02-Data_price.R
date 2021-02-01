### this script loads price data for all relevant tickers and time frames

### build stock dataset from offer table ----------------------------------------------------------
#initialize dataset
priceDF <- tibble()

#wrapping getsybmols with a try catch
my_getSymbols <- function(sym, d1, d2) {
  out <- tryCatch({
      message(paste("Trying", sym))
    getSymbols(
      sym, from = d1, to = d2,
      warnings = FALSE, auto.assign = FALSE
    ) 
  },
  error=function(cond) {
    message(paste("Error encountered for:", sym))
    message("Here's the original error message:")
    message(cond)
    # Choose a return value in case of error
    return(tibble())
  },
  # warning=function(cond) {
  #   message(paste("Warning encountered for:", sym))
  #   message("Here's the original warning message:")
  #   message(cond)
  #   # Choose a return value in case of warning
  #   return(NULL)
  # },
  finally={
    message(paste("Loaded:", sym))
  })    
  return(out)
}

for (i in 1:nrow(offerDF)) {
# for (i in 1:6) {
  isym <- offerDF$symbol[i]
  ioffer_date <- offerDF$filing_date[i]
  id1 <- ioffer_date - days(30)
  id2 <- ioffer_date + days(60)
  
  iTS <- my_getSymbols(isym, id1, id2)
  
  iDF <- tibble(
    date = index(iTS) %>% as.Date()
  ) %>%
    bind_cols(coredata(iTS) %>% as.data.frame()) %>%
    rename_all(~str_remove_all(.x, paste0(isym, "."))) %>%
    rename_all(tolower) %>%
    mutate(id = offerDF$id[i])
  priceDF <- bind_rows(priceDF, iDF)
  rm(i, isym, ioffer_date, id1, id2, iTS, iDF)
}

rm(my_getSymbols)
