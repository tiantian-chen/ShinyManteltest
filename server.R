#server design
server <- function(input,output){
  
  # download example data
  output$Download <- downloadHandler(
    filename <- function(){
      paste("test-data1.csv")
    },
    content <- function(file) {
      input_file <- "test-data1.csv"
      exampl <- read.csv(input_file,header = F)
      write.table(exampl, file = file,row.names = F, quote = F,col.names = F,
                  sep = ",") 
    }, contentType = 'text/csv')
  
  output$Download1 <- downloadHandler(
    filename <- function(){
      paste("test-data2.csv")
    },
    content <- function(file) {
      input_file <- "test-data2.csv"
      example <- read.csv(input_file)
      write.csv(example, file = file,row.names = F, quote = F)
    }, contentType = 'text/csv')
  
  #download plot
  output$downloadpdf <- downloadHandler(
    filename = function(){
      paste("corrplot.pdf")},
    content <- function(file){
      pdf(file,width = 10,height = 10)
      print(lingcun)
      dev.off()
    },contentType = "application/pdf"
  )
  output$downloadsvg <- downloadHandler(
    filename = function(){
      paste("corrplot.svg")},
    content <- function(file){
      svg(file,width = 10,height = 10)
      print(lingcun)
      dev.off()
    },contentType = "application/svg"
  )
  
  #line size
  linesiz <- reactive({
    linesiz <- input$linesize
    if(linesiz==1){
      size <- c(0.25,0.5,1)
    }else if(linesiz==2){
      size <- c(0.5,1,2)
    }else if(linesiz==3){
      size <- c(1,2,4)
    }else if (linesiz==4){
      size <- c(1.5,3,6)
    }else if (linesiz==5){
      size <- c(2,4,8)
    }
  })
  
  #main 
  observeEvent(input$submit1,{
    var1 <- input$var1
    if(var1 == "square"){
      type <- "geom_square()"
    }
    if(var1 == "circle"){
      type <- "geom_circle2()"}
    if(var1 == "star"){
      type <- "geom_star()"}
    if(var1 == "pie"){
      type <- "geom_pie2()"}
    if(var1 == "ellipse"){
      type <- "geom_ellipse2()"}
    
    var3 <- input$var3
    if(var3 == "Show"){
      number <- "geom_number(aes(num=r),color=input$var4,size=4.5,fontface='bold')"}
    if(var3=="Don't show"){
      number <- ""}
    
    b <- input$data$datapath
    if(!is.null(b)){
      v <- read.csv(file=b,header = F)
      
    }
    
    c <- input$dat$datapath
    if(!is.null(c)){
      y <- read.csv(file=c)
      
    }
    
    data_test <- v
    data_spec1 <- as.data.frame(lapply(data_test[-c(1,2),],as.numeric))
    names(data_spec1) <- data_test[2,]
    lis <- c(t(data_test[1,]))
    unilis <- unique(lis)
    aio <- lapply(unique(unilis),function(x){
      which(lis == x)
    })
    names(aio) <- unilis
    #to get mantel 
    mantel <- mantel_test(
      mantel.fun = "mantel.randtest",
      spec = data_spec1 ,
      env = y ,
      spec.select = aio) %>%  
      mutate(rd = cut(r, breaks = c(-Inf, 0.2, 0.4, Inf), 
                      labels = c("< 0.2", "0.2 - 0.4", ">= 0.4")), 
             pd = cut(p.value, breaks = c(-Inf, 0.01, 0.05, Inf), 
                      labels = c("< 0.01", "0.01 - 0.05", ">= 0.05"))) 
    
    #make a plot
    output$corrplot <- renderPlot({
      size <- linesiz()
      lingcun <<- quickcor(y, type = input$var2) +
        scale_fill_gradient2(low = input$col3,mid = input$col2,high = input$col1) +
        eval(parse(text = type))+
        eval(parse(text = number))+
        anno_link(aes(colour = pd, size = rd), data = mantel,label.size = input$var17,label.colour = input$var16) + 
        scale_size_manual(values = c(size[1],size[2],size[3])) + 
        scale_colour_manual(values = c(input$linecol1, input$linecol2, input$linecol3)) + 
        guides(size = guide_legend(title = input$title2, 
                                   override.aes = list(colour = "grey35"),  
                                   order = 2), 
               colour = guide_legend(title = input$title1,  
                                     override.aes = list(size = 3),  
                                     order = 1), 
               fill = guide_colorbar(title = input$title3, order = 3))+
        ggtitle(input$var5)+
        theme(legend.title = element_text(face = "italic",color = input$var8,size = input$var9),
              plot.title = element_text(face = "bold",hjust = 0.5,margin = margin(24, 0, 24, 0),color = input$var6,size=input$var7),
              plot.title.position = "plot",
              legend.text = element_text(color = input$var10,size=input$var11),
              axis.text.x = element_text(color = input$var12, size = input$var13),
              axis.text.y = element_text(color=input$var14,size=input$var15),
        )
      lingcun
    })
  })
}
