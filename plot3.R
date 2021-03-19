# PREGUNTA 3
#De los cuatro tipos de fuentes indicados por la variable de tipo (puntuales, no
#puntuales, en la carretera, fuera de la carretera), ¿cuáles de estas cuatro 
#fuentes han experimentado disminuciones en las emisiones de 1999 a 2008 para la
#ciudad de Baltimore? ¿Cuáles han visto aumentos en las emisiones de 1999 a 2008?
#Utilice el sistema de trazado ggplot2 para hacer que un diagrama responda a esta 
#pregunta.

#Directorio donde se encuentra la BD
setwd("C:/Users/Mafer/Documents/R-curso4/proyecto")

#librerias
library(dplyr)
library(ggplot2)


#lectura de la BD
NEI <- readRDS("summarySCC_PM25.rds")



#filtrar los datos solo de la ciudad de Baltimore
datos = filter(NEI,fips == "24510")

#Suma de las emisiones totales de la ciudad por año y tipo
datos = NEI %>% group_by(year, type) %>%
summarise(emision=sum(Emissions, na.rm = TRUE))
  
  
#Grafica
g = ggplot(datos, aes(as.factor(year), emision))

g + geom_bar(stat = "identity",fill="dark blue", width = 0.6) + facet_grid(.~type) +
  labs(title = "Emisión Total por tipo en la ciudad de Baltimore, de 1999 a 2008")+
  labs(x = "Año", y = expression("Emisión de "*PM[2.5]))

#Guardar grafica en png
dev.copy(png, file = "plot3.png") #copia la grafica en un archivo png
dev.off() #cerrar el dispositivo png



