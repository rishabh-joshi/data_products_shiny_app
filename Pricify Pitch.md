Pricify - The Car Budget App
========================================================
author: Rishabh Joshi
date: August 20, 2017
autosize: true
font-family: cursive;
transition: rotate
transition-speed: slow



Introduction
========================================================

- We all want to purchase that new dream car, but the idea of calculating a budget is so intimidating that we choose to not even think about it.

- Enter [Pricify](https://rishabhjoshi.shinyapps.io/pricify/). Let it do all the boring and taxing process of computing your car budget for you!

- [Click here](https://rishabhjoshi.shinyapps.io/pricify/) to open open Pricify in your browser. 

What is Pricify?
========================================================

- [Pricify](https://rishabhjoshi.shinyapps.io/pricify/) is a web based application that uses a prediction algorithm to calculate the price of your car.

- [Pricify](https://rishabhjoshi.shinyapps.io/pricify/) lets you weigh different features of your dream car, from very basic (for the layman) to technical (for the experts).

- [Pricify](https://rishabhjoshi.shinyapps.io/pricify/) makes use of a linear model to predict the price of a basic, mid-range, and premium version of the vehicle.

How do you operate Pricify?
========================================================
- [Pricify](https://rishabhjoshi.shinyapps.io/pricify/) is designed to be used by the general public and does not require any technical expertise.

- The application starts off with all the required fields initialized to their most common values.

- The user can enter the basic and intermediate details about their car. The more experienced and knowledgable user can alter the technical details to get the price estimate of their car.

- [Pricify](https://rishabhjoshi.shinyapps.io/pricify/) will then show you what a basic, mid-range, and a premium model of a car will cost based on your specifiactions.

Code Demonstration
========================================================


<font size=5> 
- For the programmers out there, here is a snippet of the underlying code. A linear model is trained with 10-fold cross validation based on the predictors. The value of these predictors are specified by the users. An example prediction of the price of a basic, mid-range and premium model is shown.


```r
ctrl = trainControl(method = "cv", number = 10)

mod.Min.Price = train(Min.Price ~ ., data = predictors[,-2], method = "lm", trControl = ctrl)

mod.Max.Price = train(Max.Price ~ ., data = predictors[,-1], method = "lm", trControl = ctrl)

newdata = data.frame(Type = "Compact", MPG.city = 20, Origin = "USA", Man.trans.avail = "No", 
                     AirBags = "Driver & Passenger", DriveTrain = "4WD", Cylinders = 2, 
                     Horsepower = 100, EngineSize = 3)

Min.Price = predict(mod.Min.Price, newdata)

Max.Price = predict(mod.Max.Price, newdata)

Medium.Price = 0.5 * (Min.Price + Max.Price)

round(c(Min.Price, Medium.Price, Max.Price)*1000)
```

```
    1     1     1 
14378 18004 21631 
```
</font>
