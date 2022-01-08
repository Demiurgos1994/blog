## Load the library
library(googleAnalyticsR)


## Authenticate
ga_auth()

## Make a GA API Call
ga_data <- google_analytics(
  viewId = 211685946,
  date_range = c(Sys.Date()-7, Sys.Date()),
  dimensions = 'date',
  metrics = 'users',
  anti_sample = T
)