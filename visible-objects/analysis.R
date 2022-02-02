library(tidyverse)

data <- list.files(path = "data", full.names = TRUE) %>%
  set_names() %>%
  map_dfr(read_csv, .id = "subj_id") %>%
  filter(trial_type == 'video-slider-response') %>%
  filter(str_detect(stimulus, 'stimuli*'))

results <- data %>%
  mutate(response = as.numeric(response)) %>%
  group_by(stimulus) %>%
  summarise(mean = mean(response))
