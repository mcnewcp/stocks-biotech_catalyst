#find most recent ticker table and load
path <- file.info(list.files(here("RData/Tickers"), full.names = TRUE)) %>%
  arrange(desc(mtime)) %>%
  rownames_to_column("path") %>%
  slice(1) %>% pull(path)
tckDF <- read_csv(path) %>%
  rename_all(tolower)
rm(path)

#find most recent offerings table and load
path <- file.info(list.files(here("RData/Offerings"), full.names = TRUE)) %>%
  arrange(desc(mtime)) %>%
  rownames_to_column("path") %>%
  slice(1) %>% pull(path)
offerDF <- read_csv(path, skip = 3) %>%
  rename_all(tolower) %>%
  #add row index
  rownames_to_column("id")
rm(path)

