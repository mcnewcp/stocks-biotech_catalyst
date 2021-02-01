### this script transforms price data

tranDF <- priceDF %>%
  #join with catalyst dates
  left_join(offerDF %>% select(id, filing_date), by = "id") %>%
  #compute days elapsed
  mutate(
    days_elapsed = as.numeric(date - filing_date)
  )

#initialize prices at days_elapsed = 0
p0DF <- tranDF %>%
  filter(days_elapsed == 0) %>%
  rename(close_t0 = close) %>%
  distinct(id, close_t0)

tranDF <- tranDF %>%
  #join with initialized prices
  left_join(p0DF, by = "id") %>%
  #calculate percentages
  mutate(close_perc = (close-close_t0)/close_t0) %>%
  select(-filing_date, -close_t0)
rm(p0DF, priceDF)
