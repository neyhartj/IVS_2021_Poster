## Poster support code
##
## Generate tables and figures for the poster
##

# Packages to load
library(tidyverse)
library(forcats)
library(knitr)
library(kableExtra)

# Project directories
#
# Path to the original project directory
cran_dir <- here::here() %>%
  str_split("/") %>%
  first() %>%
  {.[seq_len(str_which(., "CranberryLab"))]} %>%
  paste0(collapse = "/")
proj_dir <- file.path(cran_dir, "Projects/GermplasmCollectionEAA/")

# Directories
data_dir <- file.path(proj_dir, "Data")
result_dir <- file.path(proj_dir, "Results")
figure_dir <- file.path(proj_dir, "Figures")

fig_dir <- file.path(getwd(), "figures/")


## Dimensions to help with producting figures
paper_width <- 34 # (inches)
paper_height <- 46

one_col <- 0.3013333 * paper_width
two_col <- 0.6266666 * paper_width
three_col <- 0.9279999 * paper_width



# Format Figure 1 ---------------------------------------------------------

# Copy figure 1
file.copy(from = file.path(figure_dir, "cranberry_rutgers_wild_germplasm_origins1.jpg"),
          to = file.path(fig_dir, "figure1.jpg"), overwrite = TRUE)


# Table 1 - bioclim data description --------------------------------------

# Load the bioclim data variable descriptions
# Load the worldclim data
load(file.path(data_dir, "germplasm_origin_bioclim_data.RData"))

table1_toprint <- eaa_environmental_vars %>%
  filter(str_detect(variable, "IC", negate = T)) %>%
  rename(description = full_name, stress_category = class) %>%
  mutate(stress_category = fct_inorder(stress_category)) %>%
  split(.$stress_category) %>%
  map_df(~{
    mutate(.x, stress_category = case_when(
      variable %in% c("bio5", "bio10") ~ "heat",
      variable %in% c("bio6", "bio11") ~ "cold",
      variable %in% c("bio13", "bio16") ~ "flood",
      variable %in% c("bio14", "bio17") ~ "drought",
      TRUE ~ as.character(stress_category)),
      stress_category = str_to_title(stress_category)) %>%
      arrange(stress_category)
  })

# Alternate summary
table1_toprint <- eaa_environmental_vars %>%
  filter(str_detect(variable, "IC", negate = T)) %>%
  rename(description = full_name, stress_category = class) %>%
  mutate(stress_category = str_to_title(stress_category),
         stress_category = fct_inorder(stress_category)) %>%
  arrange(stress_category) %>%
  group_by(stress_category) %>%
  summarize(nVar = n_distinct(variable), example_vars = paste0(description[1:3], collapse = ", ") %>% str_wrap(width = 40))

# Format the table for latex
table1_toprint  %>%
  rename_all(~str_replace_all(., "_", " ") %>% str_to_title()) %>%
  kable(format = "latex", booktabs = T, align = "lcc", linesep = "") %>%
  kable_styling(latex_options = "hold_position")



# Format Figure 2 ---------------------------------------------------------

# Copy figure 2
file.copy(from = file.path(figure_dir, "cranberry_rutgers_wild_germplasm_origins1.jpg"),
          to = file.path(fig_dir, "figure2.jpg"), overwrite = TRUE)




# Format Figure 3 series -------------------------------------------------

# Copy figure 3a
file.copy(from = file.path(figure_dir, "S04_24963382_manhattan_merge.jpg"),
          to = file.path(fig_dir, "figure3a.jpg"), overwrite = TRUE)

# Copy figure 3b
file.copy(from = file.path(figure_dir, "S04_24963382_biovar_effect_plot.jpg"),
          to = file.path(fig_dir, "figure3b.jpg"), overwrite = TRUE)

# Copy figure 3c
file.copy(from = file.path(figure_dir, "S04_24963382_spatial_frequency.jpg"),
          to = file.path(fig_dir, "figure3c.jpg"), overwrite = TRUE)



# Format Figure 4 and 5 series -------------------------------------------------

# Copy figure 4a
file.copy(from = file.path(figure_dir, "sand_topsoil_manhattan_toplot.jpg"),
          to = file.path(fig_dir, "figure4a.jpg"), overwrite = TRUE)

# Copy figure 4b
file.copy(from = file.path(figure_dir, "sand_topsoil_map_effect_toplot.jpg"),
          to = file.path(fig_dir, "figure4b.jpg"), overwrite = TRUE)

# Copy figure 5a
file.copy(from = file.path(figure_dir, "phh2o_topsoil_manhattan_toplot.jpg"),
          to = file.path(fig_dir, "figure5a.jpg"), overwrite = TRUE)

# Copy figure 5b
file.copy(from = file.path(figure_dir, "phh2o_topsoil_map_effect_toplot.jpg"),
          to = file.path(fig_dir, "figure5b.jpg"), overwrite = TRUE)


















