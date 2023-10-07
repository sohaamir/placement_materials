######          Meta-cognition single trial wager experiment      ##########

'ChatGPT prompt'

"Please write an R script to simulate a cognitive task experiment with 60 participants. 
The first 30 participants should be in the high metacognition group and the rest in the low metacognition group. 
Each participant should go through 140 trials with varying levels of difficulty. 
The difficulty of each trial should range between 0.2 and 0.8 and be assigned in a random order. 
Record the following variables:

Pre-trial confidence: Initially pseudorandom, later dependent on the cumulative accuracy of previous trials
Pre-trial wager: Initially pseudorandom, later dependent on the cumulative accuracy of previous trials
Post-trial wager: Depends on whether the trial is easy (difficulty less than 0.5) or difficult (difficulty greater than 0.5)
Post-trial confidence: Depends on the difficulty of the trial
Option correctness: Randomly generated based on the difficulty level
Cumulative accuracy: Calculated as the running mean of option correctness across all previous trials
Total score: Accumulates the score based on whether the participant was correct or not in each trial
Metacognitive score: Calculated based on the correctness of the option and post-trial confidence.

The output should be a data frame where each row corresponds to a single trial of a single participant. 
The data frame should have columns for participant number, trial number, difficulty, pre-trial confidence, 
pre-trial wager, option correctness, post-trial wager, post-trial confidence, cumulative accuracy, total score, 
metacognitive score, and metacognition level."

library(ggplot2)
library(dplyr)
library(tidyverse)
library(ggpubr)
library(lme4)

################################################################################
################################################################################
################################################################################

# Helper function to generate data for one participant
generate_participant_data <- function(participant_number, high_metacognition) {
  # Initialize vectors for the trials
  trials <- 1:140
  difficulties <- rep(c(0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8), each = 20)
  difficulties <- sample(difficulties, length(difficulties))  # randomize the order
  
  # Initialize vectors for the variables
  pre_trial_confidence <- numeric(140)
  pre_trial_wager <- numeric(140)
  post_trial_wager <- numeric(140)
  post_trial_confidence <- numeric(140)
  option_correct <- numeric(140)
  cumulative_accuracy <- numeric(140)
  total_score <- numeric(140)
  metacognitive_score <- numeric(140)
  
  # Create a vector for metacognition level
  metacognition_level <- ifelse(high_metacognition, "high", "low")
  metacognition_level <- rep(metacognition_level, 140)
  
  # Generate data for each trial
  for (i in 1:140) {
    # Pre-trial confidence and wager are pseudorandom in the first trial
    if (i == 1) {
      pre_trial_confidence[i] <- sample(1:10, 1)
      pre_trial_wager[i] <- sample(1:10, 1)
    } else {
      # Pre-trial confidence and wager are based on cumulative accuracy for subsequent trials
      pre_trial_confidence[i] <- round(cumulative_accuracy[i - 1] * 10)
      pre_trial_wager[i] <- round(cumulative_accuracy[i - 1] * 10)
    }
    
    # The option is correct if a random number is less than (1 - difficulty)
    option_correct[i] <- runif(1) < (1 - difficulties[i])
    
    # Update the cumulative accuracy
    if (i == 1) {
      cumulative_accuracy[i] <- option_correct[i]
    } else {
      cumulative_accuracy[i] <- (cumulative_accuracy[i - 1] * (i - 1) + option_correct[i]) / i
    }
    
    # The post-trial wager is based on whether the trial is easy or difficult
    if (high_metacognition) {
      if (difficulties[i] > 0.5) {
        post_trial_wager[i] <- max(pre_trial_wager[i] - 1, 0)
      } else {
        post_trial_wager[i] <- min(pre_trial_wager[i] + 1, 10)
      }
    } else {
      post_trial_wager[i] <- pre_trial_wager[i]
    }
    
    # The post-trial confidence is based on the difficulty of the trial
    if (high_metacognition) {
      post_trial_confidence[i] <- 10 - round(difficulties[i] * 10)
    } else {
      post_trial_confidence[i] <- round(1 + 9 * abs(difficulties[i] - 0.5))
    }
    
    # Update the total score
    if (option_correct[i]) {
      total_score[i] <- pre_trial_wager[i]
    } else {
      total_score[i] <- -pre_trial_wager[i]
    }
    if (i > 1) {
      total_score[i] <- total_score[i - 1] + total_score[i]
    }
    
    # Calculate the metacognitive score
    if (option_correct[i]) {
      metacognitive_score[i] <- post_trial_confidence[i]
    } else {
      metacognitive_score[i] <- 10 - post_trial_confidence[i]
    }
  }
  
  # Return a data frame for this participant
  return(data.frame(participant = rep(participant_number, 140), trial = trials, difficulty = difficulties,
                    pre_trial_confidence = pre_trial_confidence, pre_trial_wager = pre_trial_wager,
                    option_correct = option_correct, post_trial_wager = post_trial_wager,
                    post_trial_confidence = post_trial_confidence, cumulative_accuracy = cumulative_accuracy,
                    total_score = total_score, metacognitive_score = metacognitive_score,
                    metacognition_level = metacognition_level))
}


################################################################################
################################################################################
################################################################################


# Initialize an empty data frame
data <- data.frame()

# Generate data for each participant
for (i in 1:30) {
  data <- rbind(data, generate_participant_data(i, TRUE))  # high metacognition
}
for (i in 31:60) {
  data <- rbind(data, generate_participant_data(i, FALSE))  # low metacognition
}

# percentage of correct answers for each level of difficulty
correct_by_difficulty <- data %>%
  group_by(difficulty) %>%
  summarise(correct_percentage = mean(option_correct) * 100)

# Generate the bar plot
ggplot(correct_by_difficulty, aes(x = difficulty, y = correct_percentage)) +
  geom_col(fill = "steelblue") +
  theme_minimal() +
  labs(title = "Percentage of Correct Answers by Difficulty",
       x = "Difficulty",
       y = "Percentage of Correct Answers") +
  scale_y_continuous(labels = scales::percent)

# Filter the data for the 140th trial only
data_140 <- data %>%
  filter(trial == 140)

# Plot total_score and cumulative_accuracy for the 140th trial
ggplot(data_140, aes(x = total_score, y = cumulative_accuracy, color = metacognition_level)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, size = 1.5, linetype = 1) +
  labs(title = "Total Score vs. Cumulative Accuracy at Trial 140",
       x = "Total Score",
       y = "Cumulative Accuracy") +
  theme_minimal() +
  scale_color_manual(values = c("high" = "blue", "low" = "red")) +
  guides(color = guide_legend(title = "Metacognition Level")) 

# Calculate the mean pre_trial_confidence for each difficulty level
mean_confidence <- aggregate(pre_trial_confidence ~ difficulty, data, FUN = mean)

# Create a bar chart
barplot(mean_confidence$pre_trial_confidence, names.arg = mean_confidence$difficulty,
        xlab = "Difficulty", ylab = "Mean Pre-Trial Confidence",
        main = "Mean Pre-Trial Confidence by Difficulty", col = "blue")

# Calculate the average pre-trial confidence for each cumulative accuracy level
avg_confidence <- aggregate(pre_trial_confidence ~ cumulative_accuracy, data, FUN = mean)

# Plot pre-trial confidence against cumulative accuracy
plot(avg_confidence$cumulative_accuracy, avg_confidence$pre_trial_confidence, 
     xlab = "Cumulative Accuracy", ylab = "Average Pre-Trial Confidence",
     main = "Average Pre-Trial Confidence vs Cumulative Accuracy", col = "blue")

# Calculate the mean pre-trial wager for each level of pre-trial confidence
mean_wager <- aggregate(pre_trial_wager ~ pre_trial_confidence, data, FUN = mean)

# Create a bar chart
barplot(mean_wager$pre_trial_wager, names.arg = mean_wager$pre_trial_confidence,
        xlab = "Pre-Trial Confidence", ylab = "Mean Pre-Trial Wager",
        main = "Mean Pre-Trial Wager by Pre-Trial Confidence", col = "blue")

# Calculate means for each subject and condition
data_means <- data %>%
  group_by(participant, metacognition_level, option_correct) %>%
  summarise(mean_post_trial_confidence = mean(post_trial_confidence))

# Create the violin plot
ggplot(data_means, aes(x = metacognition_level, y = mean_post_trial_confidence, fill = as.factor(option_correct))) +
  geom_violin(alpha = 0.8) +
  geom_jitter(shape = 21, colour = "black", width = 0.2) +
  scale_fill_manual(values = c("#FF0000", "#0000FF")) +
  labs(x = "Metacognition Level", y = "Mean Post-Trial Confidence", fill = "Option Correct (0 = No, 1 = Yes)") +
  theme_minimal() +
  theme(text = element_text(size = 12))


# Calculate the mean metacognitive score for each participant and group
mean_metacognitive <- aggregate(metacognitive_score ~ participant + metacognition_level, data, FUN = mean)

# Set theme options for publication-ready plot
theme_set(theme_bw())
theme_update(plot.title = element_text(size = 12, face = "bold"),
             axis.title.x = element_text(size = 10),
             axis.title.y = element_text(size = 10),
             axis.text = element_text(size = 8),
             legend.title = element_blank(),
             legend.text = element_text(size = 8))

# Plot the mean metacognitive score using a violin plot with individual subject means as black dots
ggplot(mean_metacognitive, aes(x = metacognition_level, y = metacognitive_score, fill = metacognition_level)) +
  geom_violin(alpha = 0.8, size = 0.5) +
  geom_point(color = "black", size = 2, position = position_jitter(width = 0.15)) +
  xlab("Metacognition Level") +
  ylab("Mean Metacognitive Score") +
  ggtitle("Mean Metacognitive Score by Group") +
  scale_fill_manual(values = c("high" = "blue", "low" = "red")) +
  guides(fill = FALSE)

# Calculate the change in confidence for each trial
data$confidence_change <- data$post_trial_confidence - data$pre_trial_confidence

# Calculate the mean change in confidence for each difficulty level and group
mean_change <- aggregate(confidence_change ~ difficulty + metacognition_level, data,
                         FUN = function(x) mean(x, na.rm = TRUE))

# Set theme options for publication-ready plot
theme_set(theme_bw())
theme_update(plot.title = element_text(size = 12, face = "bold"),
             axis.title.x = element_text(size = 10),
             axis.title.y = element_text(size = 10),
             axis.text = element_text(size = 8),
             legend.title = element_blank(),
             legend.text = element_text(size = 8))

# Calculate the change in confidence for each trial
data <- data %>%
  mutate(confidence_change = post_trial_confidence - pre_trial_confidence)

# Calculate the mean change in confidence for each difficulty level and group
mean_change <- data %>%
  group_by(difficulty, metacognition_level) %>%
  summarize(confidence_change = mean(confidence_change, na.rm = TRUE))

# Plot the mean change in confidence using a grouped bar chart
ggplot(mean_change, aes(x = difficulty, y = confidence_change, fill = metacognition_level)) +
  geom_bar(position = position_dodge2(width = 0.7), stat = "identity", color = "black", width = 0.7) +
  geom_text(aes(label = sprintf("%.2f", confidence_change), group = metacognition_level),
            position = position_dodge2(width = 0.7), vjust = -0.5, size = 3) +
  xlab("Difficulty Level") +
  ylab("Mean Change in Confidence") +
  ggtitle("Mean Change in Confidence by Difficulty Level") +
  facet_grid(. ~ metacognition_level, scales = "free_y", space = "free_y") +
  scale_fill_manual(values = c("high" = "blue", "low" = "red")) +
  guides(fill = guide_legend(reverse = TRUE))

# Convert 'difficulty' column to numeric
data$difficulty <- as.numeric(as.character(data$difficulty))

# Calculate the change in wager for each trial based on difficulty level and metacognition group
data$wager_change <- ifelse(data$metacognition_level == "high",
                            ifelse(data$difficulty <= 0.5, data$pre_trial_wager - 1, data$pre_trial_wager + 1),
                            ifelse(data$difficulty <= 0.5, data$pre_trial_wager + 1, data$pre_trial_wager - 1))

# Calculate the mean change in wager for each difficulty level and group
mean_change <- aggregate(wager_change ~ difficulty + metacognition_level, data,
                         FUN = function(x) mean(x, na.rm = TRUE))

# Set theme options for publication-ready plot
theme_set(theme_bw())
theme_update(plot.title = element_text(size = 12, face = "bold"),
             axis.title.x = element_text(size = 10),
             axis.title.y = element_text(size = 10),
             axis.text = element_text(size = 8),
             legend.title = element_blank(),
             legend.text = element_text(size = 8))

# Plot the mean change in wager using a grouped bar chart
ggplot(mean_change, aes(x = factor(difficulty), y = wager_change, fill = metacognition_level)) +
  geom_bar(position = position_dodge(width = 0.8), stat = "identity", color = "black", width = 0.6) +
  geom_text(aes(label = sprintf("%.2f", wager_change), group = metacognition_level),
            position = position_dodge(width = 0.8), vjust = -0.5, size = 3) +
  xlab("Difficulty Level") +
  ylab("Mean Change in Wager") +
  ggtitle("Mean Change in Wager by Difficulty Level") +
  facet_grid(. ~ metacognition_level, scales = "free_y", space = "free_y") +
  scale_fill_manual(values = c("high" = "blue", "low" = "red")) +
  guides(fill = guide_legend(reverse = TRUE))

# Group data by metacognition level
grouped_data <- data %>%
  group_by(metacognition_level)

# Calculate correlation coefficients for each group
correlations <- grouped_data %>%
  summarise(correlation = cor(post_trial_confidence, post_trial_wager, use = "complete.obs"))

# Print correlation coefficients
print(correlations)

# Plot scatter plots for each group
p1 <- ggplot(data[data$metacognition_level == "high",], aes(x = post_trial_confidence, y = post_trial_wager)) +
  geom_point() +
  stat_smooth(method = lm, col = "red") +
  theme_bw() +
  labs(title = "High Metacognition", x = "Post Trial Confidence", y = "Post Trial Wager")

p2 <- ggplot(data[data$metacognition_level == "low",], aes(x = post_trial_confidence, y = post_trial_wager)) +
  geom_point() +
  stat_smooth(method = lm, col = "blue") +
  theme_bw() +
  labs(title = "Low Metacognition", x = "Post Trial Confidence", y = "Post Trial Wager")

# Combine the plots
ggarrange(p1, p2, ncol = 2, common.legend = TRUE)

# Run the mixed-effects model
model <- lmer(post_trial_confidence ~ post_trial_wager * metacognition_level + (1|participant), data = data)

# Print the model summary
summary(model)

# Plot the interaction between post_trial_wager and metacognition_level
interaction_plot <- ggplot(data, aes(x = post_trial_wager, y = post_trial_confidence, color = metacognition_level)) +
  stat_summary(fun = mean, geom = "point", size = 3) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.1, size = 1) +
  stat_smooth(method = "lm", se = FALSE, size = 1, linetype = "solid") +
  theme_bw() +
  labs(x = "Post Trial Wager", y = "Post Trial Confidence") +
  theme(legend.title = element_blank())

print(interaction_plot)


# Filter for every 140th trial
final_scores <- data[data$trial %% 140 == 0, ]

# Create a violin plot
ggplot(final_scores, aes(x = metacognition_level, y = total_score, fill = metacognition_level)) +
  geom_violin(alpha = 0.7) +
  geom_jitter(shape = 21, color = "black", size = 1.5, width = 0.3) +
  stat_summary(fun.data = function(y) data.frame(ymin = quantile(y, 0.25), ymax = quantile(y, 0.75),
                                                 y = mean(y)), geom = "crossbar", width = 0.2, color = "white") +
  scale_fill_manual(values = c("high" = "red", "low" = "blue")) +
  labs(x = "Metacognition Level", y = "Total Score") +
  theme_minimal() +
  theme(text = element_text(size = 16))











