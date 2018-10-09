

function(input, output) {

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

# Create a Difficult regression
  model <- reactive({
			  if(input$train){
				  data_hard <- read.csv("../data/dataset_2.csv") 
				  out <- mcreg(x=data_hard$method1,y=data_hard$method2,method.reg = "PaBa")
				  return(out)
			  }else{
				  NULL
			  }
		  }
  )
	
  # Create a Simple regression
  model_simple <- reactive({
			 if(input$train_simple){
				 data_simple <- read.csv("../data/dataset_1.csv") 
				 out <- mcreg(x=data_simple$method1,y=data_simple$method2,method.reg = "PaBa")
				 return(out)
			 }else{
				 NULL
			 }
		 }
		 )
   # Produce a plot for the difficult Regression
   output$secondplot <- renderPlot({
			  plot(model())
   })

   # Produce a plot for the simple Regression
   output$secondplot_simple <- renderPlot({			   
			  plot(model_simple())
		})
}