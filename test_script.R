library(tidyverse)
library(ggplot2)
library(rmarkdown)
library(ggpubr)

data <- read_csv("participant_data.csv")

ggplot(data, aes(x = Height, y = Weight)) +
  geom_point() +
  labs(x = "Height", y = "Weight") +
  ggtitle("Height vs. Weight Scatter Plot")

ggplot(data, aes(x = Height, y = Weight, color = Sex)) +
  geom_point() +
  labs(x = "Height", y = "Weight", color = "Sex") +
  ggtitle("Height vs. Weight Scatter Plot by Sex")

rt_data <- read_csv("rt_data.csv")

ggplot(rt_data, aes(x = Age, y = lesion_volume)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

ggplot(rt_data, aes(x = Sex, y = lesion_volume, fill = Sex)) +
  geom_violin() +
  labs(x = "Sex", y = "Lesion volume", fill = "Sex") +
  theme_bw()


anova_model <- aov(lesion_volume ~ education, data = data)

# Check the ANOVA results
summary(anova_model)


# Subset the data for males and females
male_data <- subset(data, sex == "M")
female_data <- subset(data, sex == "F")

# Run the correlation for males
corr_male <- cor.test(male_data$bmi, male_data$lesion_volume)

# Run the correlation for females
corr_female <- cor.test(female_data$bmi, female_data$lesion_volume)

# Check the correlation results for males
corr_male

# Check the correlation results for females
corr_female
