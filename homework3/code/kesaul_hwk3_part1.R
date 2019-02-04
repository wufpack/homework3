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

#Load data
surveys_complete <- read_csv("C:/Users/kesau/Documents/~/data-carpentry/data_output/surveys_complete.csv")

#Check dimensions of surveys_complete
dim(surveys_complete)

#Plotting with ggplot2

#Use ggplot to set data frame using the data argument
ggplot(data = surveys_complete)

#Use mapping to define the aesthetics function for x/y variables.
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

#Different geoms in ggplot2:
#* `geom_point()` for scatter plots, dot plots, etc.
#* `geom_boxplot()` for, well, boxplots!
#* `geom_line()` for trend lines, time series, etc.  

#Continuous variables so use geom_point
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

#Create a variable called surveys_plot to assign to the plot
surveys_plot <- ggplot(data = surveys_complete, 
                       mapping = aes(x = weight, y = hindfoot_length))
#Draw the surveys_plot with points.
surveys_plot + 
  geom_point()

# Correct syntax for adding layers.
surveys_plot +
  geom_point() +

#Below does not add the new layer and will return an error message.
surveys_plot
+ geom_point()

#Plotting with ggplot2 Challenge
#Hexagonal binning based on observations
install.packages("hexbin")
library(hexbin)

#View the new plot using hexagon binning. 
surveys_plot +
  geom_hex()

#What are some strengths/weaknesses of hexagonal bin plot over scatter plot?
#Hexagonal bin plot was weigthed based on the number of observations with the same weight and hindfoot length.
#One downside is that some of the hexagon shading makes it group areas as opposed to seeing only specific points.

#Building your plots iteratively

#Start by laying out the data and the ggplot function with mapping and geom:
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

#Modify to add transparency to avoid overplotting & see trends using alpha.
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)   #0.1 means that the points will be more transparent

#Change the color of the points with same level of transparency.
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue")

#Add color argument to see different species observations in different colors.
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))

#Move color into the mapping argument instead but same result.
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_point(alpha = 0.1)

#Changing the geom style does not affect the color if still specified by species id
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_jitter(alpha = 0.1)

#Building your plots iteratively Challenge

#Create scatter plot of weight over species id with the plot types shown in different colors.
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight, color = plot_type)) +
  geom_point()
#Is this the best way to display this type of data?
#No, because it is hard to distinguish between the different plot types based on species id.

#Boxplot

#Visualize the weight distribution of within each species:
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot()

#Add points to boxplot
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato")

#Boxplot Challenge
#Use violin geom instead of boxplot to show density of points.
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_violin()
#Change the scale of the axes to better see the distribution
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_violin() +
  scale_y_log10()
#Explore distribution of hindfoot length by creating a boxplot and overlaying boxplot on jitter plot.
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.3, color = "purple") +
  geom_boxplot(alpha = 0)

#Add color to the data points on boxplot based on plot where sample was taken.
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length, color = plot_id)) +
  geom_jitter(alpha = 0.3) +
  geom_boxplot(alpha = 0)
#Graph displays plot id in varying shades of blue based on number. It is hard to tell difference between plot ids.

#Change the type of plot id from integer to factor.
plot_id <- as.factor(surveys_complete$plot_id)
class(plot_id)
#run code = factor
str(plot_id)
#code run = Factor w/ 24 levels

#Re-do previous plot:
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length, color = plot_id)) +
  geom_jitter(alpha = 0.3) +
  geom_boxplot(alpha = 0)
# I don't see much difference between the two plots.

#Plotting time series data

#Find the number of counts for each species each year.
#Count the records within each group (year and species)
yearly_counts <- surveys_complete %>%
  count(year, species_id)

#Use line graph to look at time series data with years on x and counts on y axes
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line()
#Plotted total species counts.

#Need to specify in order to separate by species using group argument.
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line()

#Add color so can distinguish between species and color argument auto-groups.
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, color = species_id)) +
  geom_line()

#Faceting - split one plot into multiple plots based on factor using facet_wrap
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id)

#Want to split species even further based on sex by counting based on year, species, and sex.
yearly_sex_counts <- surveys_complete %>%
  count(year, species_id, sex)

#Use facet to split up each species based on sex.
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id)

#Remove the grid and set background to white to be more printer-friendly.
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank())

#ggplot2 themes
#List of themes available at: http://docs.ggplot2.org/current/ggtheme.html

#Challenge
#Create a plot that depicts how the average weight of each species changes through the years.
#Group by species_id and year and then find the average using mean function
avg_weight <- surveys_complete %>%
  group_by(species_id, year) %>%
  summarize(mean_sp_weight = mean(weight))

#Create one plot with colors to distinguish different species.
ggplot(data = avg_weight, mapping = aes(x = year, y = mean_sp_weight, color = species_id)) +
  geom_line() +
  theme_bw() +
  theme(panel.grid = element_blank())

#Create different plots that separates out each species to look at the average weight per year.
ggplot(data = avg_weight, mapping = aes(x = year, y = mean_sp_weight)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank())

#Modify the previous code to look at how males and females average weight changes with time.

#First add sex as a variable to group by.
avg_weight_sex <- surveys_complete %>%
  group_by(species_id, year, sex) %>%
  summarize(mean_sp_sex_weight = mean(weight))

#One column and facet by rows
ggplot(data = avg_weight_sex, mapping = aes(x = year, y = mean_sp_sex_weight, color = species_id)) +
  geom_line() +
  facet_grid(sex ~ .) +
  theme_bw() +
  theme(panel.grid = element_blank())

#Facet by columns and one row
ggplot(data = avg_weight_sex, mapping = aes(x = year, y = mean_sp_sex_weight, color = species_id)) +
  geom_line() +
  facet_grid(. ~ sex) +
  theme_bw() +
  theme(panel.grid = element_blank())

#Customization

#Add titles to the overall plot and x/y axes using labs function.
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  labs(title = "Observed species in time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw()

#Increase the font size in the theme function.
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  labs(title = "Observed species in time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(text=element_text(size = 16))

#Can't read the year (x axis) labels so change orientation using angle argument.
ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  labs(title = "Observed species in time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        text = element_text(size = 16))

#Can save so that you can use same theme in the future by giving it a variable name.
grey_theme <- theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
                    axis.text.y = element_text(colour = "grey20", size = 12),
                    text = element_text(size = 16))

#So when you want to create another graph with the same formatting:
ggplot(surveys_complete, aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot() +
  grey_theme

#Customization Challenge

#Change the thickness of the lines using size in the geom function.
ggplot(data = avg_weight, mapping = aes(x = year, y = mean_sp_weight, color = species_id)) +
  geom_line(size = 1.5) +
  theme_bw() +
  theme(panel.grid = element_blank())

#Change the name of the legend or the labels of the legend.
ggplot(data = avg_weight, mapping = aes(x = year, y = mean_sp_weight, color = species_id)) +
  geom_line(size = 1.5) +
  labs(title = "Species' average weight over time",
       x = "Year of observation",
       y = "Average species' weight") +
  scale_color_discrete(name = "Species",
                       labels = c("Donkey", "Dog", "Deer", "Nightingale", "Ocelot", "Ostrich", "Peacock", "Parrot", "Pig", "Panther", "Pheasant", "Rabbit", "Raccoon", "Snake")) +
  theme_bw() +
  theme(panel.grid = element_blank())


#Arranging and exporting plots

#Install package
install.packages("gridExtra")

#Load library
library(gridExtra)

#Create two plots in the same graphic.
spp_weight_boxplot <- ggplot(data = surveys_complete, 
                             mapping = aes(x = species_id, y = weight)) +
  geom_boxplot() +
  xlab("Species") + ylab("Weight (g)") +
  scale_y_log10()

spp_count_plot <- ggplot(data = yearly_counts, 
                         mapping = aes(x = year, y = n, color = species_id)) +
  geom_line() + 
  xlab("Year") + ylab("Abundance")

grid.arrange(spp_weight_boxplot, spp_count_plot, ncol = 2, widths = c(4, 6))

#Create a new plot called my_plot
my_plot <- ggplot(data = yearly_sex_counts, 
                  mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  labs(title = "Observed species in time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        text=element_text(size = 16))

#Save the plot using ggsave function.
ggsave("fig_output/yearly_sex_counts.png", my_plot, width = 15, height = 10)

# This also works for grid.arrange() plots
combo_plot <- grid.arrange(spp_weight_boxplot, spp_count_plot, ncol = 2, widths = c(4, 6))

#Save image using ggsave function.
ggsave("fig_output/combo_plot_abun_weight.png", combo_plot, width = 10, dpi = 300)

#####END OF CODE