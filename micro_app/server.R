

function(input, output) {

  #data("mcpro_sas_results")
  
  
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
  model <- eventReactive(input$train,
                         {
                           future({mcreg(x=mcpro_sas_results[[7]]$method1,y=mcpro_sas_results[[7]]$method2,method.reg = "PaBa")})

    })
  
  # output$message <- renderPrint({model() %...>% print()})
   output$secondplot <- renderPlot({
     model() %...>% plot()
   })
}