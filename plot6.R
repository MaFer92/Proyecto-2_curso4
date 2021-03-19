#PREGUNTA 6
#Compare las emisiones de fuentes de vehículos de motor en la ciudad de Baltimore
#con las emisiones de fuentes de vehículos de motor en el condado de Los Ángeles,
#California. ¿Qué ciudad ha experimentado mayores cambios a lo largo del tiempo 
#en las emisiones de los vehículos de motor?

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

#filtrar solo los datos de la ciudad de Baltimore y Los Angeles
datos1 = filter(datos1, fips == "24510" | fips == "06037")

#Emisiones totales por año
total = datos1 %>% group_by(year, fips) %>%
  summarise(emision = sum(Emissions))

#cambio de codigo a letras
for(i in seq_len(dim(total)[1])){
  if(total$fips[i] == "24510"){
    total$fips[i] = " Baltimore City"
  }else{
    total$fips[i] = "Los Angeles County"
  }
}

#grafica
g = ggplot(total, aes(as.factor(year), emision, fill= fips))

g + geom_bar(stat = "identity", width = 0.4) +  facet_grid(.~fips) + 
  labs(title= "Emisiones de fuentes de vehículos de motor de 1999 a 2008") + 
  labs(x = "Año", y = "Emisiones (Ton)")

#guardar la grafica
dev.copy(png, file = "plot6.png")
dev.off()
