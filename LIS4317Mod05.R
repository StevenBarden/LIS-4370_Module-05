# Assignment  : LIS4317 - Module 5 Assignment - Visualization
# Purpose     : Create Part-to-Whole and Ranking visualizations using Plotly in R
# Author      : Steven Barden
# Created     : 2025-02-19-1200-00
# Modified    : 2025-02-20-0145-11
# Description : Visualizes dataset using Part-to-Whole and Ranking frameworks

# --- BEGIN SCRIPT ---

# Load required packages
required_packages <- c("readxl", "plotly", "tidyverse", "htmlwidgets", "beepr")

check_and_load_library <- function(package) {
  if (!require(package, character.only = TRUE)) {
    tryCatch({
      cat("Installing package:", package, "\n")
      install.packages(package, repos = "http://cran.us.r-project.org")
      library(package, character.only = TRUE)
      cat("Successfully loaded:", package, "\n")
    }, error = function(e) {
      stop(paste("Failed to install/load package:", package, "-", e$message))
    })
  } else {
    cat("Package already loaded:", package, "\n")
  }
}

# Load packages
lapply(required_packages, check_and_load_library)

# Ensure Output directory exists
output_dir <- "Output"
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
  cat("Created 'Output' directory.\n")
} else {
  cat("'Output' directory already exists.\n")
}

# --- DATA LOADING ---
tryCatch({
  dataset <- read_excel("Module # 5.xlsx")
  print(head(dataset))
}, error = function(e) {
  stop("Error loading dataset: ", e$message)
})

# --- PART-TO-WHOLE VISUALIZATION ---
part_to_whole_plot <- plot_ly(dataset, labels = ~`Average Position`, values = ~Time, type = 'pie') %>%
  layout(title = "Part-to-Whole Visualization: Average Position vs. Time")

# Save as HTML in Output directory
htmlwidgets::saveWidget(part_to_whole_plot, file.path(output_dir, "Part_to_Whole_Visualization.html"))

# --- RANKING VISUALIZATION ---
ranking_plot <- plot_ly(dataset, x = ~`Average Position`, y = ~Time, type = 'bar') %>%
  layout(title = "Ranking Visualization: Average Position vs. Time", xaxis = list(title = "Average Position"), yaxis = list(title = "Time"))

# Save as HTML in Output directory
htmlwidgets::saveWidget(ranking_plot, file.path(output_dir, "Ranking_Visualization.html"))

# Display plots in viewer
part_to_whole_plot
ranking_plot

# Notification when script completes
cat("\n--- Script completed successfully! Check the 'Output' directory for HTML files. ---\n")
beepr::beep(3)

# --- END OF SCRIPT ---
