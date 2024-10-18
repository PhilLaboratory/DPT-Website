library(tidyverse)

Data <- read.csv("Samson_Meta_Analysis_Data.csv")

DataRT <- Data %>% 
  filter(RTorError == 'RT')

DataError <- Data %>% 
  filter(RTorError == 'Error')

#for each case of persp consistency, are there multiple instances of dir consistency? record these cases
varied_dir_RT <- DataRT %>% 
  group_by(Paper, StudyNumber, Perspective.Consistency) %>%
  summarise(
    dir_values = n_distinct(Directional.Consistency)) %>% 
  mutate(filter_condition = paste(Paper, StudyNumber, sep="_")) %>% 
  filter(dir_values > 1)

#for each case of dir consistency, are there multiple instances of persp consistency? record these cases
varied_persp_RT <- DataRT %>% 
  group_by(Paper, StudyNumber, Directional.Consistency) %>%
  summarise(
    persp_values = n_distinct(Perspective.Consistency)) %>% 
  mutate(filter_condition = paste(Paper, StudyNumber, sep="_")) %>% 
  filter(persp_values > 1)

#for each case of persp consistency, are there multiple instances of dir consistency? record these cases
varied_dir_Error <- DataError %>% 
  group_by(Paper, StudyNumber, Perspective.Consistency) %>%
  summarise(
    dir_values = n_distinct(Directional.Consistency)) %>% 
  mutate(filter_condition = paste(Paper, StudyNumber, sep="_")) %>% 
  filter(dir_values > 1)

#for each case of dir consistency, are there multiple instances of persp consistency? record these cases
varied_persp_Error <- DataError %>% 
  group_by(Paper, StudyNumber, Directional.Consistency) %>%
  summarise(
    persp_values = n_distinct(Perspective.Consistency)) %>% 
  mutate(filter_condition = paste(Paper, StudyNumber, sep="_")) %>% 
  filter(persp_values > 1)


#Create data sets for analyses without no direction/perspective
simpleRT <- DataRT %>% filter(Directional.Consistency!=0) %>% filter(Perspective.Consistency!=0) %>%
  mutate(Directional.Consistency=factor(Directional.Consistency),
         Perspective.Consistency=factor(Perspective.Consistency))

simpleError <- DataError %>% filter(Directional.Consistency!=0) %>% filter(Perspective.Consistency!=0) %>%
  mutate(Directional.Consistency=factor(Directional.Consistency),
         Perspective.Consistency=factor(Perspective.Consistency))

#Create data sets for filtered analyses (simply remove all cases where PC and DC covary)
varied_DataError <- DataError %>% 
  mutate(filter_condition = paste(Paper, StudyNumber, sep="_")) %>% 
  filter(filter_condition %in% varied_dir_Error$filter_condition | filter_condition %in% varied_persp_Error$filter_condition)

varied_DataRT <- DataRT %>% 
  mutate(filter_condition = paste(Paper, StudyNumber, sep="_")) %>% 
  filter(filter_condition %in% varied_dir_RT$filter_condition | filter_condition %in% varied_persp_RT$filter_condition)


varied_Data <- rbind(varied_DataError, varied_DataRT)

write.csv(varied_Data, 'Filtered_Samson_Meta_Analysis_Data.csv')

