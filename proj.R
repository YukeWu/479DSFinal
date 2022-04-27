if (!require("tidyverse")) {
  install.packages("tidyverse")
  stopifnot(require("tidyverse"))
}

if (!require("tree")) {
  install.packages("tree")
  stopifnot(require("tree"))
}

d = read_csv('merged09Q1.csv') # might need to change this (how to read file in parallel)

df = d %>%  #might need to change this, depends on how many columns and column name actually in the slurm bin bash file 
  mutate(total_time = difftime(Trip_Dropoff_DateTime, Trip_Pickup_DateTime, units = "mins")) %>% 
  separate(Trip_Pickup_DateTime, into = c("Date", "Time"), sep = " ") %>% 
  mutate(Hour =  as.numeric(gsub("\\:.*$", "", Time))) %>% 
  mutate(Part_of_Date = case_when(Hour >= 5 & Hour<=11 ~ "morning",
                                  Hour >= 12 & Hour<=16 ~ "afternoon",
                                  Hour >= 16 & Hour<=24 ~ "evening",
                                  Hour >= 0 & Hour <=4 ~ "midnight")) %>% 
  select(-c(Date, Time, Hour, Trip_Dropoff_DateTime)) %>% 
  mutate(Part_of_Date = as.factor(Part_of_Date)) %>% 
  mutate(total_time = as.numeric(total_time))

df = na.omit(df)

tree1 = tree(Total_Amt ~., data = df) #build regression tree

png("tree.png", width = 600, height = 600) #might need to change name since parallel computing, also don't know whether slurm support png.
# 2. Create the plot
plot(tree1)
text(tree1, pretty = 0, cex = 0.8)
# 3. Close the file
dev.off()
