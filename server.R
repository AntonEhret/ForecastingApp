function(input, output){
  
#' **Output for Datasummary**
  output$data <- renderDT({
    #' loading data
    req(input$file1) #app doesnt return error when there is no data yet selected
    data <- read.csv(input$file1$datapath, header = input$header, sep = input$sep)
    return(datatable(data))
  })
  
#' **Plot of whole TS**
  plot1 <- eventReactive(input$plot1start, {
    var <- data[,2]
    yourData <- ts(var
                    , start = c(input$year, 01)
                    , frequency = input$freq)
    options(scipen=999)
    plot(as.matrix(yourData))
  })
  output$plot1 <- renderPlot(plot1())

#' **Modelselection**
  ModelSelect1 <- eventReactive(input$calc1start, {
    options(scipen=999)
    #' @splitting
    var <- data[,2][1:(round(dim(data)[1]*((input$split)/100)))]
    insamp <- ts(var
                 , start = c(input$year, 01)
                 , frequency = input$freq)
    outsamp <- data[,2][(round(dim(data)[1][1]*(input$split/100))) : dim(data)[1]]
    outsamp <- as.vector(unlist(outsamp))
    #' @models
    #' Setting up
    h <- length(outsamp) #for forecasting period
    l <- list() #for models
    f <- list() #for forecasts
    a <- list() #for accuracy
    #' Running models
    #Models
    l[[1]] <- ma(insamp
                 , order = input$freq
                 , centre = TRUE
    )
    l[[2]] <- ma(insamp, order = input$freq*2, centre = TRUE)
    l[[3]] <- HoltWinters(insamp)
    l[[4]] <- HoltWinters(insamp, seasonal = "multiplicative")
    l[[5]] <- auto.arima(insamp)
    #Forecast & accuracy
    for (i in seq(1:5)){
      f[[i]] <- forecast(l[[i]], h = h)
      a[[i]] <- accuracy(f[[i]], outsamp)
    }
    
    #' @model assessment
    #setting up sequence to only get the test-dataset assessment
    test <- seq(2,length(a)*2,2)
    #putting all accuraciy() in a dataframe
    assessment <- ldply(a,data.frame)[test,]
    rownames(assessment) <- c("MA one Season", "MA two Seasons", "HoltWinters additive", "HoltWinders multiplicative", "Auto Arima")
    #Modelselection based on RMSE
    chosen.model <- which.min(assessment$RMSE)
    
    if (chosen.model == 1) {
      mod <- ma(insamp, order = input$freq, centre = TRUE)
      message <- "Smallest RMSE was obtained by using centered moving average taking averages of one season"
    } else if (chosen.model == 2) {
      mod <- ma(insamp, order = input$freq*2, centre = TRUE)
      message <- "Smallest RMSE was obtained by using centered moving average taking averages of two seasons" 
    } else if (chosen.model == 3) {
      mod <- HoltWinters(insamp)
      message <- "Smallest RMSE was obtained by using HoltWinters with additive seasonal component"
    } else if (chosen.model == 4) {
      mod <- HoltWinters(insamp, seasonal = "multiplicative")
      message <- "Smallest RMSE was obtained by using HoltWinters with multiplicative seasonal component"
    } else {
      mod <- Arima(insamp, model=l[[5]])
      message <- "Smallest RMSE was obtained by using auto.arima"
    }
    message
  })
  output$ModelSelection1 <- renderText(ModelSelect1())
  
  ModelSelect2 <- eventReactive(input$calc1start, {
    assessment
  })
  output$ModelSelection2 <- renderDataTable(ModelSelect2())
}
