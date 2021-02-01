### this project investigates biotech stock prices compared to catalysts 

if (!require(pacman)) {install.packages("pacman")}
p_load(
  tidyverse,
  here,
  tidyquant,
  plotly
)

### Operators -------------------------------------------------------------------------------------
compile <- FALSE #should data be compiled form source?


### Data ------------------------------------------------------------------------------------------
if(compile) {
  source(here("RCode/01-Data_tables.R")) #load tickers and catalyst data
  source(here("RCode/02-Data_price.R")) #pull stock data
  source(here("RCode/03-Data_transform.R")) #transform data
  source(here("RCode/04-Data_save.R"))
}
rm(compile)
source(here("RCode/05-Data_load.R"))

### Output ----------------------------------------------------------------------------------------
