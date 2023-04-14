# Load necessary packages
library(ggplot2)
library(dplyr)
library(ggthemes)
library(extrafont)
library(readr)
library(gganimate)
library(gapminder)

# Import avocado sales data
avocado_data <- read_csv("avocado_sales.csv")

# Create a new variable to identify whether a region is in the Northeast or not
avocado_data <-
  avocado_data %>% mutate(isNortheast = (region == 'Albany'))

#Remove the region labels from the chart and plot average avocado prices for each region
ggplot(data = avocado_data, aes(x = region, y = AveragePrice, color = type)) +
  geom_line(aes(linetype = isNortheast), size = 1.5, alpha = 0.8) +
  
  # Add chart titles and labels
  labs(
    title = "Regional Differences in Average Avocado Prices from 2015 to 2018",
    subtitle = "Comparing Prices between Northeast and Other Regions",
    x = "Region",
    y = "Average Price ($)",
    color = "Type:"
  ) +
  
  # Set chart theme and style with white background
  theme_fivethirtyeight() +
  theme(
    axis.text = element_blank(),
    axis.title = element_text(size = 14, face = "bold"),
    panel.background = element_rect(fill = "white", colour = NA),
    plot.background = element_rect(fill = "white", colour = NA),
    legend.background = element_rect(fill = "white", colour = NA),
    panel.grid.major = element_line(colour = "gray90", size = 0.2),
    panel.grid.minor = element_blank(),
    strip.background = element_rect(fill = "white", colour = NA),
    strip.text = element_text(size = 14, face = "bold"),
    plot.title = element_text(size = 24,
                              face = "bold",
                              hjust = 0.5),
    plot.subtitle = element_text(size = 16, hjust = 0.5),
    plot.caption = element_text(size = 12, hjust = 0.5)
  ) +
  
  # Manually set line types and remove legend
  scale_linetype_manual(values = c("solid", "dashed"), guide = "none") +
  
  # Create separate charts for each year using facet_wrap()
  facet_wrap( ~ year, scales = "free_y") +
  
  # Add white background to entire plot
  theme(plot.background = element_rect(fill = "white", color = NA))
