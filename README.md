# shiny-marine
Shiny and R introductory project 

## project steps
### X. UML architecture and business model.
Providing diagram representing architecture dictated by business
requirements. Providing diagram showing relationship within the source
data which will allow us to implement correct data processing and
persistency strategy.

### X. Analyse data.
Using jupyternotebook or R-markdown to provide a pdf/html file showing
data analyse over source data.

So far we have used jupyternotebook where data analyse is presented, in order
to not public the dataset it will be provided in email message.

From the data set we can easily extract ship types and ship names which will
be used in shiny selects. Beside we have removed few records which have 
not valid ship names or by mispeliing or containing wrong business logic at
all. This can be seen more clearly in diagram representing model relationships.

### 0. Pre process data.
Because we are not so skilled in R yet, we will use Python to pre process
data and store it into simple database that could be used when app will be
deployed for example sqlite.

During pre processing data we encounter an issue with distance calcualtion.
So first we need to provide a function to calcuate dinstance between 2 points
and keep the highest distance.

At the moment we have created an approach where we iterate through each 
ship id dataset and compare all observations, so from each ship dataset we need to get a list of observations for which timedelta is around 30 minutes. If we would like
to do it in advance it may take some time so I wonder if it is not better to
calculate it on the fly. The possible solution would be usage of some time 
series database which could efficently filter observations by timedelta ?

For getting timedelta between observations I am thinking as well about a 2d matrix
to get a set of all possible relationships between observations and than run some
efficient operation on matrix.

Part of the work was done on jupyternotebook which will be attached separately
for confidential reasons as it extract information about dataset.

### 1. Create generic interface to read data.
Here we will try to use best techniques we have found so far.

### 2. Access data from shiny app through interface.
Maybe we will use dplyr R library to access data from db latter. We would like
to create kind of generic selectors which could be than used inside server 
handler.

### 3. Integrate custom UI elements (Leaflet.js) and encapsulate ui dropdowns.
Not sure how to cover this point, if possible we will use custom js file for shiny
app.

### 4. Tests
