library(shiny)
library(corrplot)
library(ggcor)
library(markdown)
library(vegan)
library(ggplot2)
library(readr)
library(ade4)
library(colourpicker)

ui <- navbarPage(title="Mantel-test",
                 tabPanel("Corrplot",
                          
                          titlePanel("Make a Mantel Test !"),
                          sidebarLayout(
                            
                            sidebarPanel(
                              fileInput("data",h4("upload Data 1:")),
                              downloadButton("Download", "Download example data1"),
                              
                              fileInput("dat",h4("upload CorrplotData")),
                              downloadButton("Download1", "Download example corrplotdata"),
                              
                              selectInput("var1",
                                          h4("Method of display"),
                                          choices = c("circle"="circle",
                                                      "square"="square",
                                                      "star"="star",
                                                      "pie"="pie",
                                                      "ellipse"="ellipse"
                                          )),
                              selectInput("var2",
                                          h4("LayOut of display"),
                                          choices = c("upper"="upper","lower"="lower")),
                              
                              #spec input
                              radioButtons("condition4",label=h4("spec design"),
                                           choices = c("Default","Customize")),
                              conditionalPanel(
                                condition = "input.condition4=='Customize'",
                                colourInput("var16",label=h5("Label color"),value="black"),
                                sliderInput("var17",label=h5("Label size"),min=3,max=25,value=5),
                              ),
                              
                              #Title ctrl 
                              radioButtons("condition1",label=h4("Add more details"),
                                           choices = list("NULL","Legend Title","Plot Title","Axis text")),
                              conditionalPanel(
                                condition = "input.condition1 =='Legend Title'",
                                textInput("title1", label = h4("line color Title"), value = "Mantel's p"),
                                textInput("title2", label = h4("line size Title"), value = "Mantel's r"),
                                textInput("title3", label = h4("Degree of relevance Titlel"), value = "Pearson's r"),
                                colourInput("var8",label=h5("Legend title colour"),value="black"),
                                sliderInput("var9",label=h5("Legendtitle size"),min=10,max=40,value=14),
                                colourInput("var10",label=h5("Legend text colour"),value="black"),
                                sliderInput("var11",label=h5("Legendtext size"),min=10,max=40,value=14),
                              ),
                              conditionalPanel(
                                condition = "input.condition1 == 'Plot Title'",
                                textInput("var5",label = h4("Add Plot Title"),value=""),
                                colourInput("var6",label="Plot title colour",value="black"),
                                sliderInput("var7",label=h5("Plottitle size"),min=10,max=60,value=20)
                              ),
                              conditionalPanel(
                                condition = "input.condition1 == 'Axis text'",
                                colourInput("var12",label=h5("X-Axis text colour"),value="black"),
                                sliderInput("var13",label=h5("X-Axis text size"),min=10,max=40,value=12),
                                colourInput("var14",label=h5("Y-Axis text colour"),value="black"),
                                sliderInput("var15",label=h5("Y-Axis text size"),min=10,max=40,value=12),
                              ),
                              
                              #color ctrl
                              radioButtons("condition3",label=h4("Color Settings"),
                                           choices = list("Default","PlotcolorSetting","LinecolorSetting")),
                              conditionalPanel(
                                condition = "input.condition3 == 'PlotcolorSetting'",
                                #corr color
                                h4("Plotcolor Settings"),
                                colourInput("col1",label=h5("positive correlation"),value="red"),
                                colourInput("col2",label=h5("weak correlation"),value="white"),
                                colourInput("col3",label=h5("negative correlation"),value="grey")),
                              #line color
                              conditionalPanel(
                                condition = "input.condition3 == 'LinecolorSetting'",
                                h4("Linecolor Settings"),
                                colourInput("linecol1",label=h5("positive correlation"),value="#D95F02"),
                                colourInput("linecol2",label=h5("weak correlation"),value="#1B9E77"),
                                colourInput("linecol3",label=h5("negative correlation"),value="#A2A2A288")),
                              #show P-value
                              radioButtons("var3", label = h4("Show p-value"),
                                           choices = list("Don't show","Show"),
                                           selected = "Don't show"),
                              conditionalPanel(
                                condition = "input.var3 == 'Show'",
                                colourInput("var4",label = h4("number color"),
                                            value="black")),
                              #line size
                              sliderInput("linesize",label=h4("Control line size"),min=1,max=5,value=2),
                              
                              actionButton("submit1",strong("RUN")
                              )
                            ),
                            
                            mainPanel(
                              downloadButton("downloadpdf","Download pdf-file"),
                              downloadButton("downloadsvg","Download svg-file"),
                              plotOutput("corrplot",width="100%",height="1000px")
                            ))
                          
                 ), tabPanel("Help",includeMarkdown("README.md"))
)
