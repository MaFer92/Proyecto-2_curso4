#PREGUNTA 5
#¿Cómo han cambiado las emisiones de fuentes de vehículos de motor entre 1999 y
#2008 en la ciudad de Baltimore?

#Directorio donde se encuentra la BD
setwd("C:/Users/Mafer/Documents/R-curso4/proyecto")

#librerias
library(dplyr)
library(ggplot2)

#lecturas de las BD
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#filtrar los datos para el nivel 2 de SCC que corresponde a vehiculos de motor
datos = filter(SCC, grepl("[Vv]ehicle", SCC.Level.Two))

#Unir datos con base a la columna SCC
datos1 = inner_join(NEI, datos, by = "SCC")

#filtrar solo los datos de la ciudad de Baltimore
datos1 = filter(datos1, fips == "24510")

#Emisiones totales por año
total = datos1 %>% group_by(year) %>%
  summarise(emision = sum(Emissions))

#grafica
g = ggplot(total, aes(as.factor(year), emision))

g + geom_bar(stat = "identity", fill = "purple", width = 0.4) +
  labs(title = "Emissions from motor vehicle sources from 1999 to 2008 in Baltimore City") + 
  labs(x = "Año", y = "Emisión (Ton)")

#Guardar grafica en png
dev.copy(png, file = "plot5.png")
dev.off()
