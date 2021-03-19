#PREGUNTA 2
#¿Han disminuido las emisiones totales de PM2.5 en la ciudad de Baltimore, Maryland, 
#de 1999 a 2008? Utilice el sistema de trazado base para hacer un diagrama que 
#responda a esta pregunta.

#Directorio donde se encuentra la BD
setwd("C:/Users/Mafer/Documents/R-curso4/proyecto")

#librerias
library(dplyr)

#lectura de la BD
NEI <- readRDS("summarySCC_PM25.rds")


#filtrar los datos solo de la ciudad de Baltimore
datos = filter(NEI,fips == "24510")

#Suma de las emisiones totales de la ciudad por año
datos1 = datos %>% group_by(year) %>%
summarise(sum(Emissions), na.rm=TRUE)

#grafica
plot(datos1$year, datos1$`sum(Emissions)`, col= "pink", lwd=1.5, type = "l",
     xlab = "Año", ylab = expression(PM[2.5] * "(Ton)"), 
     main= expression("Emisión Total de "*PM[2.5]* 
    " en la ciudad de Baltimore"), pch=19)
points(datos1$year, datos1$`sum(Emissions)`, col="pink", lwd=4)

#Guardar grafica en png
dev.copy(png, file = "plot2.png") #copia la grafica en un archivo png
dev.off() #cerrar el dispositivo png



