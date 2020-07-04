FROM rocker/shiny:3.3.2

RUN apt-get update && apt-get install libcurl4-openssl-dev libv8-3.14-dev -y &&\
  mkdir -p /var/lib/shiny-server/bookmarks/shiny

RUN apt-get install libpq-dev -y

# Download and install library
RUN R -e "install.packages(c('shinydashboard', 'shiny', 'V8'))"


# Download and install application specific libraries
RUN R -e "install.packages(c('leaflet', 'geosphere', 'DBI'))"
RUN R -e "install.packages(c('remotes', 'plogr'))"
RUN R -e "install.packages('RPostgres', dependencies=TRUE, repos='http://cran.rstudio.com/')"

# copy the app to the image COPY shinyapps /srv/shiny-server/
# make all app files readable (solves issue when dev in Windows, but building in Ubuntu)
RUN chmod -R 755 /srv/shiny-server/

CMD ["/usr/bin/shiny-server.sh"]