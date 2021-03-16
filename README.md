# ForecastingApp
Hi there :)
in this repo, you can find my work on a forecasting app for automated timeseries forecasting.
I was in my business forecasting class, thinking that the used functions should be relatively easily automated.
So I started coding an RMD, where you only need to put in the data and a little bit of information, such as the frequency, the start year of your data and the forecasting period.
The algorithm itself will then run 5 different models (different MA, different Holt.Winters and ARIMA) and establish the best fit based on test RMSE.
That model then gets used to forecast the next period.

While this code runs nicely in rstudio, I wanted it to be used by people that do not know any coding. So I did a course on udemy to learn about the shiny package, which quickly grew on me.
After now having set up most of the UI, I still need to do some tweaking to the code for the modelselection to be output correctly.
