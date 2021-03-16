dashboardPage(
    dashboardHeader(title = "Antons Forecasts",
                    titleWidth = 300,
                    dropdownMenu(type = "message",
                                 messageItem(from = "Anton", message = "Hey, thanks for checking out this app! :) "))),
    dashboardSidebar(
      width = 300,
      sidebarMenu(
        menuItem(text = "1. Upload your Data",
                           startExpanded = FALSE,
                           menuSubItem(
                             fileInput("file1", "Upload a csv file", multiple = FALSE, accept = c(".csv")),
                                       icon = NULL),
                           menuSubItem(
                             textInput("sep", label = "Enter the Separator characters:", value = ","),
                                       icon = NULL),
                           menuSubItem(
                             checkboxInput("header", label = "File contains a header", value = TRUE),
                                       icon = NULL)
                  )
      ),
      sidebarMenu(
        menuItem(text = "2. Information abougt Data",
                           statExpanded = FALSE,
                           menuSubItem(
                             selectInput("split", "Percentage of dataset used training", choices = c(50,60,70,80,90), selected = 80),
                             icon = NULL),
                           menuSubItem(
                             numericInput("year", "In what year does your Dataset start?", value = 2000),
                             icon = NULL),
                           menuSubItem(
                             numericInput("freq", "What is the frequency of your data?", value = 12),
                             icon = NULL),
                           menuSubItem(
                             numericInput("forc", "How many periods ahead ahould the forecast go?", value = 12),
                             icon = NULL),
                           menuSubItem(
                             actionButton("plot1start", "Plot the Series"),
                             icon = NULL)
                 )
        ),
      sidebarMenu(
        menuItem(text = "3. Starting the Algorithm",
                 menuSubItem(
                             actionButton("calc1start", "Modelselection"),
                             icon = NULL)
        )
      )
    ),
    dashboardBody(
      h2("1. Data-upload"),
      p(strong("Upload your data by selecting a csv file from your computer in the sidebar")),
      p("Please make sure, that your data contains", em("two columns"), ": a date column and a column of the variable of interest that you want to forecast"),
      
      h2("2. Information about your data"),
      p(strong("Add the information concerning the training-split, the frequency of your data, the starting year and the desired period.")),
      p("You dont know what any of these are? At the bottom of this page you can find additional information."),
      p("You can view your plot by pressing the",em("plot"), "tab below."),
      
      h2("3. Algorithm starts"),
      p(strong("After completing thw two previous steps, you can now start the algorithm by pushing the buttons in the sidebar.")),
      p("You can view your selected Model by pressing the",em("Model"), "tab below."),
      tabsetPanel(
        tabPanel("Your Data", 
                 DTOutput("data")),
        tabPanel("Your Timeseries", 
                 plotOutput("plot1")),
        tabPanel("Your Model", 
                 textOutput("ModelSelection1"))
                 # textOutput("ModelSelection2"))
      ),
      
      
      
      
      
      HTML("<br/>"),
      HTML("<br/>"),
      HTML("<br/>"),
      HTML("<br/>"),
      HTML("<br/>"),
      h4("Explanations"),
      p(strong("Frequency:")),
      p("The interpretation of frequency for time series is generally 'the number of observations in a series if you consider the natural time interval of measurement'. For example, if you measure value of some variable once in a month, and you have data for multiple years, you can use value of 12 for frequency. If you have monthly data over multiple years then your frequency would be 12, since every month repeats after 12 periods. If you das daily data over multiple weeks, your frequency would be seven (incluiding workdays & weekends( or 5 if your data would only incluide workdays.", a(href="https://robjhyndman.com/hyndsight/seasonal-periods/","This article"), "gives you further information on the topic if you are interested.")
    )
)