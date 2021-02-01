plotDF <- priceDF %>%
  left_join(offerDF %>% select(id, symbol), by = "id") %>%
  group_by(id)


plot_ly(
  plotDF, x = ~days_elapsed, y = ~close_perc,
  mode = 'lines', type = 'scatter', color = ~symbol,
  text = ~paste0(
    symbol,
    "<br>Days Elapsed: ", days_elapsed,
    "<br>Close (%): ", round(close_perc, 2) * 100, "%",
    "<br>Date: ", date,
    "<br>Open: ", open,
    "<br>High: ", high,
    "<br>Low: ", low,
    "<br>Close: ", close,
    "<br>Volume: ", volume,
    "<br>Adjusted: ", adjusted
  ),
  hoverinfo = 'text'
) %>%
  layout(
    xaxis = list(title = "Days Since Catalyst"), 
    yaxis = list(
      title = "Closing Price Normalized to Catalyst Date",
      tickformat = "%"
    )
  )

ggplot(plotDF, aes(x = days_elapsed, y = close_perc, group = id)) + 
  geom_line() + 
  scale_y_continuous(limits = c(-2, 2))
