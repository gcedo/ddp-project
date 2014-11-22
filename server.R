
# This is the server logic for a Shiny web application.

library(shiny)
library(reshape)
library(reshape2)
library(ggplot2)
library(plyr)

shinyServer(function(input, output) {
      original.data = read.table('foreigners.csv', header = T, sep = ";")
      data = melt(original.data, id=c("Cittadinanza", "Genere"), variable_name = "Year")
      data[, "Year"] = as.numeric(gsub("X", "", data[,"Year"]))
      data$value = as.numeric(gsub(",", ".",as.character(data$value)))
      data = dcast(data, Cittadinanza + Year ~ Genere, value.var = "value")
      data$Total = data$Femmine + data$Maschi
      data = data[complete.cases(data),]
      top.countries = head(arrange(data[data$Year == 2013,], -Total), input$bins)$Cittadinanza
      data.top = data[data$Cittadinanza %in% top.countries,]
      data.top$Cittadinanza = gsub(pattern = "Per\xf9", replacement = "Peru", x = data.top$Cittadinanza)

  output$demographics <- renderPlot({
      p = qplot(x = Year, y = Total, data = data.top, colour = Cittadinanza, geom = "line") + theme(legend.position="none")
      p + geom_text(data = data.top[data.top$Year == 2013, ], aes(label = Cittadinanza), vjust=-.5)
  })

})
