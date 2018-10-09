

function(input, output) {

  #data("mcpro_sas_results")
  options(cores=4, parallel=F,mc.cores=4)	
  
  output$main_plot <- renderPlot({
    
    hist(faithful$eruptions,
         probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab = "Duration (minutes)",
         main = "Geyser eruption duration")
    
    if (input$individual_obs) {
      rug(faithful$eruptions)
    }
    
    if (input$density) {
      dens <- density(faithful$eruptions,
                      adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }
    
  })
  # model <- eventReactive(input$train, 
  #                        { 
  #                          future({
  #                          Sys.sleep(5)
  #                          "test"})
  #   
  #   })
  data_hard <- read.csv("../data/dataset_2.csv") 
  data_simple <- read.csv("../data/dataset_1.csv") 

  model <- eventReactive(input$train,
                         {
                           future({mcreg(x=data_hard$method1,y=data_hard$method2,method.reg = "PaBa")})

    })
  model_simple <- eventReactive(input$train_simple,
                         {
                           future({mcreg(x=data_simple$method1,y=data_simple$method2,method.reg = "PaBa")})

    })
  
  # output$message <- renderPrint({model() %...>% print()})
   output$secondplot <- renderPlot({
     model() %...>% plot()
   })
   output$secondplot_simple <- renderPlot({
			model_simple() %...>% plot()
		})
}