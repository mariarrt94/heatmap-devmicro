#### Script to make graphs for development micro essay 

#### Libraries #####

library(tidyverse)
library(extrafont)
library(scales)
library(readxl)
library(ggplot2)

#### Import data ####

risks_raw <- read_xlsx("Data for graphs.xlsx")

risk_tidy <- risks_raw %>% 
  gather("size", "porc", `0-2 ha`:`>20 ha`)

colors_pal <- c('#17406D','#0F6FC6','#009DD9','#176A7B','#0BD0D9',
                '#10CF9B','#5FF3CB','#A5C249','#C8DA92','#CC0066',
                '#FE001A','#FA5F00','#FEA300')

fontcolor <- '#000f1c'

barplot(rep(1,length(colors_pal)), col=colors_pal)

loadfonts(device="win")

#### Heatmap ####

heat_risk <- risk_tidy %>% 
  ggplot(aes(x=reorder(size, porc, FUN = mean , .desc = TRUE), y = reorder(Factor, porc, FUN = mean , .desc = TRUE))) +
  geom_tile(aes(fill = porc)) +
  geom_text(data = risk_tidy, aes(label = paste(round(porc, digits = 1), "%", sep = ""), 
                                 fontface = "bold", family = 'Century Gothic'), colour = fontcolor, size = 5) +
  scale_fill_gradient(low = "floralwhite", high = "#0F6FC6") +
  theme(legend.position="bottom", axis.title.y = element_blank(),axis.title.x = element_blank(), 
        legend.title=element_blank(),panel.background = element_blank(),
        axis.text = element_text(size = 14, color = "#000f1c", face = "bold", family = 'Century Gothic'),
        legend.text = element_text(size = 10, color = "#000f1c", face = "bold", family = 'Century Gothic'),
        text = element_text(size = 14, color = "#000f1c", face = "bold", family = 'Century Gothic'))

heat_risk

#### Save graphs #####

ggsave("Heatmap risks.jpg",device = "jpeg",plot = heat_risk, width = 28, height = 16, units = "cm")
