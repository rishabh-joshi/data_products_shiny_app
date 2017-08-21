library(shiny)
library(MASS)

data("Cars93")
types = levels(Cars93$Type)
origins = levels(Cars93$Origin)
transmissions = levels(Cars93$Man.trans.avail)
airbags = levels(Cars93$AirBags)
driveTrain = levels(Cars93$DriveTrain)

shinyUI(fluidPage(
    fluidRow(
        titlePanel("Pricify - Calculate the price range of your dream car!"),
        h4("Please fill out the following details about your desired car"),
        column(4,
               h4("Basic Details"),
               selectInput('Origin', 'Of non-USA or USA origins', origins),
               selectInput('Type', 'Type of the car', types),
               selectInput('Man.trans.avail', 'Manual Transmission', transmissions)
        ),
        column(4, h4("Intermediate Details"),
               selectInput("AirBags", "Airbags", airbags),
               sliderInput("MPG.city", "MPG in the city", 15, 30, value = 20, step = 0.1),
               # br(),
               selectInput('DriveTrain', 'Drivetrain type', driveTrain)
        ),
        column(4, h4("Technical Details"),
               numericInput("Cylinders", "Number of cylinders", value = 2, min = 1, max = 6, step = 1),
               sliderInput("Horsepower", "Horsepower", 55, 300, value = 100, step = 5),
               sliderInput("EngineSize", "Size of the Engine (litres)", 1, 6, value = 3, step = 0.1)
        ),
        h4("Price for a basic model of your car (in USD):"),
        h3(textOutput("pred.Min.Price")),
        h4("Price for a mid-range model of your car (in USD):"),
        h3(textOutput("pred.Price")),
        h4("Price for a premium model of your car (in USD):"),
        h3(textOutput("pred.Max.Price"))
    )
))