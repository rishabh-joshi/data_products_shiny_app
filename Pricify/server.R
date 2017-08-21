library(shiny)
library(MASS)
library(caret)
library(dplyr)
data("Cars93")
shinyServer(function(input, output) {
    
    predictors = Cars93 %>% 
        select(c(Min.Price, Max.Price, Type, 
                 MPG.city, AirBags, DriveTrain, 
                 Cylinders, Horsepower, EngineSize, 
                 Man.trans.avail, Origin)) %>%
        mutate(Cylinders = as.numeric(Cylinders))
    
    # We will use 10 fold cross validation for all the prediction models
    ctrl = trainControl(method = "cv", number = 10)
    mod.Min.Price = train(Min.Price ~ ., data = predictors[,-2], method = "lm", trControl = ctrl)
    mod.Max.Price = train(Max.Price ~ ., data = predictors[,-1], method = "lm", trControl = ctrl)
    
    pred <- reactive({
        Origin = input$Origin
        Type = input$Type
        Man.trans.avail = input$Man.trans.avail
        AirBags = input$AirBags
        MPG.city = input$MPG.city
        DriveTrain = input$DriveTrain
        Cylinders = input$Cylinders
        Horsepower = input$Horsepower
        EngineSize = input$EngineSize
        
        newdata = data.frame(Type, MPG.city, Origin, 
                             Man.trans.avail, AirBags, 
                             DriveTrain, Cylinders, Horsepower, 
                             EngineSize)
        Min.Price = predict(mod.Min.Price, newdata)
        Max.Price = predict(mod.Max.Price, newdata)
        c(Min.Price, Max.Price)
    })
    
    output$pred.Min.Price <- renderText({
        round(pred()[1]*1000)
    })
    output$pred.Price <- renderText({
        round((pred()[1] + pred()[2])* 0.5* 1000)
    })
    output$pred.Max.Price <- renderText({
        round(pred()[2]*1000)
    })
})