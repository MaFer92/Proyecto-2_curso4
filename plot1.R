# PREGUNTA 1
#¿Han disminuido las emisiones totales de PM2.5 en los Estados Unidos de 1999 a 2008?
#Utilizando el sistema de trazado base, haga un diagrama que muestre la emisión total 
#de PM2.5 de todas las fuentes para cada uno de los años 1999, 2002, 2005 y 2008.

#Directorio donde se encuentra la BD
setwd("C:/Users/Mafer/Documents/R-curso4/proyecto")

#librerias
library(dplyr)

#lectura de la BD
NEI <- readRDS("summarySCC_PM25.rds")


#Suma de emisiones totales
datos = NEI %>%  group_by(year) %>% 
summarise(sum(Emissions), na.rm=TRUE)


#Grafica
plot(datos$year, datos$`sum(Emissions)`, pch =19, xlab = "Año", 
     ylab = expression(PM[2.5]* "(Ton)"), col= "purple", 
     main = expression("Emisión Total de  "*PM[2.5]), type="l", lwd =1.5)
points(datos$year, datos$`sum(Emissions)`, pch = 19, col="purple", lwd = 4)

#Guardar grafica en png
dev.copy(png, file = "plot1.png") #copia la grafica en un archivo png
dev.off() #cerrar el dispositivo png
