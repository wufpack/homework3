############################################
#Created by: Kaelin Saul
#Date created: 1/27/2019
#Date revised: 1/28/2019
#Data Analytics Homework 3: Data Carpentry Visualization
############################################

#Clear history
rm(list = ls())

#Load libraries
library(tidyverse)

#Set working directory
getwd()

#Load data
nutrients <- read_csv("data/NutrientInputs.csv")

#Find out the class for Code
class(nutrients$Code)

#Convert Code from character to factor
Code <- as.factor(nutrients$Code)

#Look at code to make sure it is converted to factor
Code

#Look at structure of Code
str(Code)

#Change order of Code factors
Code_reorder <- factor(Code, levels = c("CL", "UCL", "FF", "NFF","A"))

#Look at order of factors for Code
Code_reorder

#Look at Total structure
str(nutrients$Total)

#Assign variable name to ggplot
ggplot(data = nutrients, aes(x = Code_reorder, y = Total)) +
  geom_col(aes(fill = Code_reorder)) +
  scale_fill_brewer(palette = "Paired", guide = FALSE)

#Basic plot separated for each state
ggplot(data = nutrients, aes(x = Code_reorder, y = Total)) +
  geom_col(aes(fill = Code_reorder)) +
  facet_wrap(~ State)

#Add color to the ggplot
ggplot(data = nutrients, aes(x = Code_reorder, y = Total)) +
  geom_col(aes(fill = Code_reorder)) +
  scale_fill_brewer(palette = "Paired", guide = FALSE) +
  facet_wrap(~ State)

#Add labels for a title and x/y axes.
ggplot(data = nutrients, aes(x = Code_reorder, y = Total)) +
  geom_col(aes(fill = Code_reorder)) +
  scale_fill_brewer(palette = "Paired", guide = FALSE) +
  facet_wrap(~ State) +
  labs(x = "N source",
       y = "Total mass of N applied to load surface (kg)") +
  ggtitle ("Nitrogen applied to land surface by source and state - 1987")

#Change spacing for x axis and theme
ggplot(data = nutrients, aes(x = Code_reorder, y = Total)) +
  geom_col(aes(fill = Code_reorder)) +
  scale_fill_brewer(palette = "Paired", guide = FALSE) +
  facet_wrap(~ State) +
  labs(x = "N source",
       y = "Total mass of N applied to load surface (kg)") +
  ggtitle ("Nitrogen applied to land surface by source and state - 1987") +
  theme_bw() +
  theme(axis.text.x =
          element_text(size  = 8))

#Change the scale for the y axis.
ggplot(data = nutrients, aes(x = Code_reorder, y = Total)) +
  geom_col(aes(fill = Code_reorder)) +
  scale_fill_brewer(palette = "Paired", guide = FALSE) +
  facet_wrap(~ State) +
  labs(x = "N source",
       y = "Total mass of N applied to load surface (kg)") +
  ggtitle ("Nitrogen applied to land surface by source and state - 1987") +
  theme_bw() +
  theme(axis.text.x =
          element_text(size  = 8)) +
  ylim(0.0e+00, 8.0e+08)

###END OF CODE