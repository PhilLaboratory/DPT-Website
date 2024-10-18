
library(shiny)
library(plotly)
library(shinythemes)
library(bslib)
library(rsconnect)



#Read in full dataset
DPT_Download <- read.csv("Samson_Meta_Analysis_Data_Download.csv")
DPT_df <- read.csv("Samson_Meta_Analysis_Data_Plot.csv") 
DPT_df_filtered <- read.csv("Filtered_Samson_Meta_Analysis_Data_Plot.csv")


# Define UI for application that draws a plot
ui <- fluidPage(
  theme = bs_theme(version = 4, bootswatch = "minty"),
  navbarPage(title = "PhiLab.data/",
        tabPanel("The Dot Perspective Task",
            tags$h1("The Dot Perspective Task"),
            tags$p("Explore the DPT by selecting instances of the following important variables. For more information about these variables, please read below and review the related ", a(href = "https://doi.org/10.31219/osf.io/zkgyt", "manuscript"), ". For more flexible analyses and additional information about this dataset, please visit this project's", a(href = "https://doi.org/10.7910/DVN/MBRXFK", "Dataverse Repository"), "."),
            tags$p("Error or Response Time: Select dependent variable"),
            tags$p("Filter Data: Optionally, select 'Deconfounded Data.' If selected, data in which perspective and directional consistency covary will be filtered out."),
            tags$p("X-Axis: Select primary independent variable"),
            tags$p("Secondary Comparison: Select secondary independent variable"),
            headerPanel("Explore the DPT"),
            uiOutput("secondSelection"),
            sidebarLayout(
              sidebarPanel(
                selectInput(inputId = 'measure', label = "Error or Response Time:", choices = c("Response Time" = "Response Time", "Error" = "Error")),
                selectInput(inputId = 'filter', label = "Filter Data", choices = c('All Data' = 'all', 'Deconfounded Data' = 'deconfounded')),
                selectInput(inputId = 'x_axis', label = 'X-Axis:', 
                        choices = c('Directional Consistency' = "Directional_Consistency", 
                                  'Perspective Consistency' = 'Perspective_Consistency',
                                  'Spacial Distribution' = 'Spacial_Distribution')),
                selectInput(inputId = 'secondary', label = "Secondary Comparison:", 
                        choices = c('Explicilty Tracking Other' = 'Explicitly.Tracking.Other',
                                  "Time Limit (ms)" = "Timeout", 
                                  "Agent" = "Agent",
                                  "None" = "None")),
                selectInput(inputId = 'type', label = 'Graph Type:', 
                        choices = c('violin' = 'violin', 
                                    'box' = 'box'))),
          mainPanel(
            plotlyOutput('DPT_plot'),
            tags$br(),
            tags$p("*Hover over individual points for more informaiton about the data point, and the source publication."),
            tags$p("*Click and drag to zoom in. Double click to zoom back out."),
            tags$h4("Independent Variables:"),
            tags$li("Directional Consistency: Consistency between the number of dots a directional stimulus is oriented towards, and the total number of dots within a scene. 'None' when there is no directional stimulus."),
            tags$li("Perspective Consistency: Consistency between the number of dots visible to an agent, and the total number of dots within the scene. 'None' when there is no agent."),
            tags$li("Spacial Distribution: Are all dots portrayed in the same location ('together' spacial distribution) or are dots sometimes portrayed in multiple locations or groupings ('varied' spacial distribution). This is determined by experimental stimulus design."), 
            tags$li("Explicitly Tracking Other: Are participants explicitly asked to attend to the perspective of the 'other' (i.e. the avatar or analogous stimulus)? This occurs when 'self' and 'other' trials are intermixed, when 'other' trials precede 'self' trials, or when participants are otherwise explicitly instructed to track the other's perspective."),
            tags$li("Time Limit: How long were participants given to respond to each trial (ms)?"),
            tags$li("Agent: What agent or other object was depicted as the central stimulus? Agent=='avatar' is used for studies directly replicating Samson et al. 2010.")
              )
          )),
   # tabPanel(title = "Download Materials", 
   #          tags$h1("Downloadable Materials:"),
   #          tags$p("Please review the relevant Instruction Books prior to analyzing the following materials. For more information about the proceedures involved in collecting this data, refer to the linked publications."),
   #          tags$hr(),
   #          tags$h4("The Dot Perspective Task"),
   #          downloadLink("DPTdownload", "Download DPT Dataset"),
   #          tags$br(),
   #          downloadLink("DPTDataDictionary", "Download DPT Data Dictionary"),
   #          tags$br(),
   #          tags$a(href = "https://doi.org/10.31219/osf.io/zkgyt", "Connecting the Dots Manuscript"),
   #          tags$hr(),
   #          tags$p()),
    tabPanel(title = "About", 
             tags$h1("PhiLab.Data"),
             tags$div("This site hosts interactive supplemental materials related to work from the Dartmouth College PhiLab. More information about the lab, including members and ongoing projects can be found on the",
             tags$a(href="phillab.host.dartmouth.edu", "Lab Website")),
             tags$hr(),
             tags$h3("Contributors"),
             tags$br(),
             fluidRow(
               column(3,
                      tags$img(height = 150,
                               width = 150,
                               src = "profile_shin.png")),
               column(7,
                      tags$h5("Steven Shin"),
                      tags$p("Research Assistant"),
                      tags$p("Dartmouth College department of Cognitive Science"),
                      tags$p("steven.m.shin.23@dartmouth.edu"))),
             tags$br(),
             fluidRow(
               column(3,
                      tags$img(height = 150,
                               width = 150,
                               src = "profile_holland.png")),
               column(7,
                      tags$h5("Catherine Holland"),
                      tags$p("Graduate Researcher"),
                      tags$p("Dartmouth College department of Cognitive Science"),
                      tags$p("catherine.anne.holland@gmail.com"))),
             tags$br(),
             fluidRow(
               column(3,
                      tags$img(height = 150,
                               width = 150,
                               src = "profile_phillips.png")),
               column(7,
                      tags$h5("Jonathan Phillips"),
                      tags$p("Principal Investigator"),
                      tags$p("Assistant Professor"),
                      tags$p("Dartmouth College Department of Cognitive Science"),
                      tags$p("jonathan.s.phillips@dartmouth.edu"))),
             tags$hr(),
             tags$h3("Contact"),
             tags$p("For questions about individual datasets, please contact the corresponding author(s) of the related publications."),
             tags$p("More general questions can be directed to cogsciphillab@gmail.com"),
             tags$hr(),
             tags$h3("Citations"),
             tags$h6("This site contains data taken from the following publications:"),
             tags$li("Marshall, J., Gollwitzer, A., & Santos, L. R. (2018). Does altercentric interference rely on mentalizing?: Results from two level-1 perspective-taking tasks. PloS one, 13(3), e0194101."),
             tags$li("O’Grady, C., Scott-Phillips, T., Lavelle, S., & Smith, K. (2020). Perspective-taking is spontaneous but not automatic. Quarterly Journal of Experimental Psychology, 73(10), 1605-1628."),
             tags$li("Ferguson, H., Brunsdon, V., Bradford, E. (2018). Age of avatar modulates the altercentric bias in a visual perspective-taking task: ERP and behavioral evidence. Cognitive, Affective, & Behavioral Neuroscience, 18(6), 1298–1319. https://doi.org/10.3758/s13415-018-0641-1"),
             tags$li("O'Grady, C., Scott-Phillips, T., Lavelle, S., & Smith, K. (2017). The dot perspective task revisited: Evidence for directional effects. Cognitive Science."),
             tags$li("Wang, J., Tseng, P., Juan, C., Frisson, S., & Apperly, I. (2019). Perspective-taking across cultures: shared biases in Taiwanese and British adults. Royal Society Open Science, 6(11), 190540–190540. https://doi.org/10.1098/rsos.190540"),
             tags$li("Westra, E., Terrizzi, B., van Baal, S., Beier, J., & Michael, J. (2021). EXPRESS: Beyond avatars and arrows: Testing the mentalizing and submentalizing hypotheses with a novel entity paradigm. Quarterly Journal of Experimental Psychology (2006), 17470218211007388–17470218211007388. https://doi.org/10.1177/17470218211007388"),
             tags$li("Todd, A., Simpson, A., & Cameron, C. (2019). Time pressure disrupts level-2, but not level-1, visual perspective calculation: A process-dissociation analysis. Cognition, 189, 41–54. https://doi.org/10.1016/j.cognition.2019.03.002"),
             tags$li("Todd, A. R., Cameron, C. D., & Simpson, A. J. (2021). The goal-dependence of level-1 and level-2 visual perspective calculation. Journal of Experimental Psychology: Learning, Memory, and Cognition, 47(6), 948."),
             tags$li("Furlanetto, T., Becchio, C., Samson, D., & Apperly, I. (2016). Altercentric interference in level 1 visual perspective taking reflects the ascription of mental states, not submentalizing. Journal of Experimental Psychology. Human Perception and Performance, 42(2), 158–163. https://doi.org/10.1037/xhp0000138"),
             tags$li("Todd, A., & Simpson, A. (2016). Anxiety impairs spontaneous perspective calculation: Evidence from a level-1 visual perspective-taking task. Cognition, 156, 88–94. https://doi.org/10.1016/j.cognition.2016.08.004"),
              tags$li("Todd, A., Cameron, C., & Simpson, A. (2017). Dissociating processes underlying level-1 visual perspective taking in adults. Cognition, 159, 97–101. https://doi.org/10.1016/j.cognition.2016.11.010"),
              tags$li("Simpson, A. J., & Todd, A. R. (2017). Intergroup visual perspective-taking: Shared group membership impairs self-perspective inhibition but may facilitate perspective calculation. Cognition, 166, 371-381."),
              tags$li("Gardner, M., Hull, Z., Taylor, D., & Edmonds, C. (2018). “Spontaneous” visual perspective-taking mediated by attention orienting that is voluntary and not reflexive. Quarterly Journal of Experimental Psychology (2006), 71(4), 1020–1029."),
              tags$li("Gardner, M. R., Bileviciute, A. P., & Edmonds, C. J. (2018). Implicit mentalizing during level-1 visual perspective-taking indicated by dissociation with attention orienting. Vision, 2(1), 3."),
              tags$li("Santiesteban, I., Catmur, C., Hopkins, S. C., Bird, G., & Heyes, C. (2014). Avatars and arrows: Implicit mentalizing or domain-general processing?. Journal of Experimental Psychology: Human Perception and Performance, 40(3), 929."),
              tags$li("Capozzi, F., Cavallo, A., Furlanetto, T., & Becchio, C. (2014). Altercentric intrusions from multiple perspectives: Beyond dyads. PloS one, 9(12), e114210."),
              tags$li("Qureshi, A. W., Apperly, I. A., & Samson, D. (2010). Executive function is necessary for perspective selection, not Level-1 visual perspective calculation: Evidence from a dual-task study of adults. Cognition, 117(2), 230-236."),
              tags$li("Qureshi, A., & Monk, R. (2018). Executive function underlies both perspective selection and calculation in Level-1 visual perspective taking. Psychonomic Bulletin & Review, 25(4), 1526–1534. https://doi.org/10.3758/s13423-018-1496-8"),
              tags$li("Qureshi, A. W., Monk, R. L., Samson, D., & Apperly, I. A. (2020). Does interference between self and other perspectives in theory of mind tasks reflect a common underlying process? Evidence from individual differences in theory of mind and inhibitory control. Psychonomic bulletin & review, 27, 178-190."),
              tags$li("Ferguson, H., Apperly, I., & Cane, J. (2017). Eye tracking reveals the cost of switching between self and other perspectives in a visual perspective-taking task. The Quarterly Journal of Experimental Psychology, 70(8), 1646–1660."),
              tags$li("Drayton, L. A., Santos, L. R., & Baskin-Sommers, A. (2018).Psychopaths fail to automatically take the perspec-tive of others.Proceedings of the National Academy ofSciences,115(13), 3302–3307."),
              tags$li("Sæther, L., Roelfs, D., Moberget, T., Andreassen, O., Elvsåshagen, T., Jönsson, E., & Vaskinn, A. (2021). Exploring neurophysiological markers of visual perspective taking: Methodological considerations. International Journal of Psychophysiology, 161, 1–12. https://doi.org/10.1016/j.ijpsycho.2020.12.006"),
              tags$li("Deliens, G., Bukowski, H., Slama, H., Surtees, A., Cleeremans, A., Samson, D. and Peigneux, P. (2018), The impact of sleep deprivation on visual perspective taking. J Sleep Res, 27: 175-183. https://doi.org/10.1111/jsr.12595"),
              tags$li("Deroualle, D., Toupet, M., van Nechel, C., Duquesne, U., Hautefort, C., & Lopez, C. (2017). Anchoring the Self to the Body in Bilateral Vestibular Failure. PloS One, 12(1), e0170488–e0170488. https://doi.org/10.1371/journal.pone.0170488"),
              tags$li("Doi, H., Kanai, C., Tsumura, N., Shinohara, K., & Kato, N. (2020). Lack of implicit visual perspective taking in adult males with autism spectrum disorders. Research in Developmental Disabilities, 99, 103593–103593. https://doi.org/10.1016/j.ridd.2020.103593"),
              tags$li("Simonsen, A., Mahnkeke, M. I., Fusaroli, R., Wolf, T., Roepstorff, A., Michael, J., ... & Bliksted, V. (2020). Distinguishing oneself from others: Spontaneous perspective-taking in first-episode schizophrenia and its relation to mentalizing and psychotic symptoms. Schizophrenia Bulletin Open, 1(1), sgaa053."),
              tags$li("Ramsey, R., Hansen, P., Apperly, I., & Samson, D. (2013). Seeing It My Way or Your Way: Frontoparietal Brain Areas Sustain Viewpoint-independent Perspective Selection Processes. Journal of Cognitive Neuroscience, 25(5), 670–684. https://doi.org/10.1162/jocn_a_00345"),
              tags$li("Pavlidou, A., Ferrè, E., & Lopez, C. (2018). Vestibular stimulation makes people more egocentric. Cortex, 101, 302–305. https://doi.org/10.1016/j.cortex.2017.12.005"),
              tags$li("Pavlidou, A., Gallagher, M., Lopez, C., & Ferrè, E. (2019). Let’s share our perspectives, but only if our body postures match. Cortex, 119, 575–579. https://doi.org/10.1016/j.cortex.2019.02.019"),
              tags$li("Cole, G., Atkinson, M., Le, A., & Smith, D. (2016). Do humans spontaneously take the perspective of others? Acta Psychologica, 164, 165–168."),
              tags$li("Mccleery, J., Surtees, A., Graham, K., Richards, J., & Apperly, I. (2011). The neural and cognitive time course of theory of mind. The Journal of Neuroscience : the Official Journal of the Society for Neuroscience, 31(36), 12849–12854."),
              tags$li("Surtees, A., & Apperly, I. (2012). Egocentrism and Automatic Perspective Taking in Children and Adults. Child Development, 83(2), 452–460."),
              tags$li("Surtees, A., Samson, D., & Apperly, I. (2016). Unintentional perspective-taking calculates whether something is seen, but not how it is seen. Cognition, 148, 97–105. https://doi.org/10.1016/j.cognition.2015.12.010"),
              tags$li("Langton, Stephen R. H. (2018). I Don’t See It Your Way: The Dot Perspective Task Does Not Gauge Spontaneous Perspective Taking. Vision (Basel), 2(1)."),
              tags$li("Wilson, C., Soranzo, A., & Bertamini, M. (2017). Attentional interference is modulated by salience not sentience. Acta Psychologica, 178, 56–65"),
              tags$li("Schwarzkopf, S., Schilbach, L., Vogeley, K., & Timmermans, B. (2014). “Making it explicit” makes a difference: Evidence for a dissociation of spontaneous and intentional level 1 perspective taking in high-functioning autism. Cognition, 131(3), 345–354. https://doi.org/10.1016/j.cognition.2014.02.003"),
              tags$li("Santiesteban, I., Kaur, S., Bird, G., & Catmur, C. (2017). Attentional processes, not implicit mentalizing, mediate performance in a perspective-taking task: Evidence from stimulation of the temporoparietal junction. NeuroImage (Orlando, Fla.), 155, 305–311. https://doi.org/10.1016/j.neuroimage.2017.04.055"),
              tags$li("Bukowski, H., & Samson, D. (2017). New Insights into the Inter-Individual Variability in Perspective Taking. Vision (Basel), 1(1), 8–. https://doi.org/10.3390/vision1010008"),
              tags$li("Schurz, K. (2015). Clarifying the role of theory of mind areas during visual perspective taking: Issues of spontaneity and domain-specificity. NeuroImage (Orlando, Fla.), 117, 386–396."),
  
             )))
    
  

# Define server logic 
server <- function(input, output) {

data <- reactive({
    if (input$filter == 'all') {
      filtered_data <- filter(DPT_df, RTorError == input$measure)
    } else {
      filtered_data <- filter(DPT_df_filtered, RTorError == input$measure)#REVISIT TO FIX
    }
    filtered_data
  })
 


  output$DPT_plot <- renderPlotly({ 
  
    if(input$secondary == "None") {split <- NA}
    else {split = ~get(input$secondary)}
    
    dpt_graph <- data() %>% 
      plot_ly() %>% 
      add_trace(
        x = ~get(input$x_axis),
        y = ~Value,
        split = split,
        type = input$type,
        points = 'all',
        marker = list(opacity = 0.4, size = 1.5),
        jitter = 0.7,
        pointpos = 0,
        box = list(visible = TRUE),
        text = ~Paper)%>% 
      layout(
        violinmode = 'group',
        boxmode = 'group',
        violingap = 0.1,
        xaxis = list(
          title = input$x_axis),
        yaxis = list(title = input$measure)) %>% 
      config(displayModeBar = FALSE)
    
  })
  
  
  
    output$DPTdownload <- downloadHandler( 
      filename = "DPT_Dataset.csv",
      content = function(file) {
        write.csv(DPT_Download, file)
        })
    output$DPTDataDictionary <- downloadHandler( 
      filename = "DPT_Data_Dictionary.pdf",
      content = function(file) {
        file.copy("DPT_Data_Dictionary.pdf", file)
      })
  }

# Run the application 
shinyApp(ui = ui, server = server)


# data <- reactive( {}) -- creates reactive value to use later (ex in multiple renders) technically creates a function
# actionButton -- button that does something (eg download)
# observe() reruns block of code you pass everytibe the observer is invalidated
# eventReactive(reactive value(s), code to rebuild reactive object when reactive values are invalidated) --only respondes when specified reactive values are invalidated