library(DBI)
library(RPostgres)

POSTGRES_DATABASE=Sys.getenv(x = "POSTGRES_DATABASE")
POSTGRES_USER=Sys.getenv(x = "POSTGRES_USER")
POSTGRES_PASSWORD=Sys.getenv(x = "POSTGRES_PASSWORD")
POSTGRES_HOST=Sys.getenv(x = "POSTGRES_HOST")
POSTGRES_PORT=Sys.getenv(x = "POSTGRES_PORT")

# database connection
con <- dbConnect(RPostgres::Postgres(),
                 dbname = POSTGRES_DATABASE, 
                 host = POSTGRES_HOST,
                 port = POSTGRES_PORT,
                 user = POSTGRES_USER,
                 password = POSTGRES_PASSWORD
)
# query selectors
queryShipTypes = "SELECT DISTINCT ship_type FROM public.observations ORDER BY ship_type;"
queryShipNames = "SELECT DISTINCT \"SHIPNAME\" FROM public.observations 
                  WHERE ship_type=$1 ORDER BY \"SHIPNAME\";"

queryObservations = "SELECT \"DATETIME\", \"LAT\" , \"LON\", \"DESTINATION\" FROM public.observations 
                  WHERE \"SHIPNAME\"=$1 ORDER BY \"DATETIME\" ASC;"

getShipTypes <- function(){
  res <- dbSendQuery(con, queryShipTypes)
  data <- dbFetch(res)
  dbClearResult(res)
  data
}

getShipNames <- function(shipType){
  res <- dbSendQuery(con, queryShipNames)
  dbBind(res, list(shipType))
  data <- dbFetch(res)
  dbClearResult(res)
  data
}

getShipObservations <- function(shipName){
  res <- dbSendQuery(con, queryObservations)
  dbBind(res, list(shipName))
  data <- dbFetch(res)
  dbClearResult(res)
  data
}

