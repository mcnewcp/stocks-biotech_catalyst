### this script loads most recent dataset

path <- file.info(list.files(
  here("ROutput/dataset"),
  pattern = "*.rds", full.names = TRUE
)) %>%
  arrange(desc(mtime)) %>%
  rownames_to_column("path") %>%
  slice(1) %>% pull(path)
dataLS <- read_rds(path)
priceDF <- dataLS$priceDF
offerDF <- dataLS$offerDF
tckDF <- dataLS$tckDF
rm(path, dataLS)
