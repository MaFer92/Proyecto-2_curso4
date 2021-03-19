# PREGUNTA 4
#En todo Estados Unidos, ¿cómo han cambiado las emisiones de fuentes relacionadas
#con la combustión de carbón entre 1999 y 2008?

#Directorio donde se encuentra la BD
setwd("C:/Users/Mafer/Documents/R-curso4/proyecto")

#librerias
library(dplyr)
library(ggplot2)

#lecturas de las BD
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#filtrar los datos para el nivel 1 y 3 de SCC
datos = filter(SCC, grepl("[Cc]ombustion", SCC.Level.One))
datos = filter(datos,grepl("[Cc]oal", SCC.Level.Three))

#Unir datos con base a la columna SCC
datos1 = inner_join(NEI, datos, by = "SCC")

#Emisiones totales por año
total = datos1 %>% group_by(year) %>%
summarise(emision = sum(Emissions))

#Grafica
g = ggplot(total, aes(as.factor(year), emision ))

g + geom_bar(stat = "identity", fill = "cyan", width = 0.40) + 
  labs(title = "Emissions from coal combustion-related sources from 1999–2008") +
  labs(x = "Año", y = "Emisión (Ton)")

#Guardar grafica en png
dev.copy(png, file = "plot4.png") #copia la grafica en un archivo png
dev.off() #cerrar el dispositivo png






