
library(tidyverse)

dataset <- read.csv("myapp/Samson_Meta_Analysis_Data_Download.csv")

#create prettier dataset for website figures
pretty_dataset <- dataset %>% 
  rename(
    'Directional_Consistency' = 'Directional.Consistency',
    'Perspective_Consistency' = 'Perspective.Consistency',
    'Spacial_Distribution' = 'Spacial.Distribution',
    
  ) %>%
  mutate(
    `Directional_Consistency` = case_when(
      `Directional_Consistency`=='C' ~ 'Consistent',
      `Directional_Consistency`=='I' ~ 'Inconsistent',
      `Directional_Consistency`=='N' ~ 'None'),
    `Perspective_Consistency` = case_when(
      `Perspective_Consistency`=='C' ~ 'Consistent',
      `Perspective_Consistency`=='I' ~ 'Inconsistent',
      `Perspective_Consistency`=='N' ~ 'None'),
    Explicitly.Tracking.Other = case_when(
      Explicitly.Tracking.Other == 'Y' ~ 'Yes',
      Explicitly.Tracking.Other == 'N' ~ 'No'
    ),
    Agent = case_when(
      Agent == 'novel_entity' ~ 'novel entity',
      TRUE ~ Agent
    ),
    RTorError = case_when(
      RTorError == 'RT' ~ "Response Time",
      TRUE ~ RTorError
    )
  ) %>% 
  filter( (RTorError=="Response Time" & (Value > 250 & Value <1200)) | ((RTorError=='Error') & (Value<0.5)) )



filtered_dataset <- read.csv("myapp/Filtered_Samson_Meta_Analysis_Data.csv")

pretty_filtered_dataset <- filtered_dataset %>% 
  rename(
    'Directional_Consistency' = 'Directional.Consistency',
    'Perspective_Consistency' = 'Perspective.Consistency',
    'Spacial_Distribution' = 'Spacial.Distribution',
    
  ) %>% 
  mutate(
    `Directional_Consistency` = case_when(
      `Directional_Consistency`=='C' ~ 'Consistent',
      `Directional_Consistency`=='I' ~ 'Inconsistent',
      `Directional_Consistency`=='N' ~ 'None'),
    `Perspective_Consistency` = case_when(
      `Perspective_Consistency`=='C' ~ 'Consistent',
      `Perspective_Consistency`=='I' ~ 'Inconsistent',
      `Perspective_Consistency`=='N' ~ 'None'),
    Explicitly.Tracking.Other = case_when(
      Explicitly.Tracking.Other == 'Y' ~ 'Yes',
      Explicitly.Tracking.Other == 'N' ~ 'No'
    ),
    Agent = case_when(
      Agent == 'novel_entity' ~ 'novel entity',
      TRUE ~ Agent
    ),
    RTorError = case_when(
      RTorError == 'RT' ~ "Response Time",
      TRUE ~ RTorError
    )
  ) %>% 
  filter( (RTorError=="Response Time" & (Value > 250 & Value <1200)) | ((RTorError=='Error') & (Value<0.5)) )

##Write datasets
#write_csv(pretty_filtered_dataset, "myapp/Filtered_Samson_Meta_Analysis_Data_Plot.csv")
#write_csv(pretty_dataset, "myapp/Samson_Meta_Analysis_Data_Plot.csv")

#Run: shinylive::export("myapp", "docs") to create docs folder, ready to export.



