library(httr2)
req <- request("https://newsapi.org/v2/everything") |>
  req_url_query(
    q = '`"data science"`',
    from = Sys.Date() - 1,
    pageSize = 10,
    apiKey = Sys.getenv("NEWS_API_KEY")
  )

resp <- req_perform(req)
df <- resp_body_json(resp)


this_datetime <- lubridate::ymd(Sys.Date())
exportJSON <- jsonlite::toJSON(df)
write(exportJSON, glue::glue("data/{this_datetime}.json"))
