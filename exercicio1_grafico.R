#install.packages("ggplot2")
#install.packages("DAAG")

library(ggplot2)
library(DAAG)
library(descr)

head(mtcars)

#Grafico de barras
ggplot(mtcars) + 
  geom_bar(aes(x = as.factor(hp))) +
  labs(x = "Potência", y = "Milhas por galao") +
  ggtitle("Grafico de barra") + 
  theme(plot.title = element_text(hjust = 0.50))

#Histograma
ggplot(mtcars) +
  geom_histogram(aes(x = hp)) +
  labs(x = "Potência", y = "Milhas por galao") +
  ggtitle("Histograma")

#Boxplot
ggplot(mtcars) +
  geom_boxplot(aes(x = as.factor(hp), y = mpg)) +
  labs(x = "Potência", y = "Milhas por galão") +
  ggtitle("Boxplot")
  
#Grafico de dispersao
ggplot(mtcars) +
  geom_point(aes(x = hp, y = mpg)) +
  labs(x = "Potência", y = "Milhas por galão") +
  ggtitle("Grafico de dispersão")

#Grafico de dispersao + Facets
ggplot(mtcars) +
  geom_point(aes(x = hp, y = mpg)) +
  facet_grid(.~mpg)
  labs(x = "Potência", y = "Milhas por galão") +
  ggtitle("Grafico de dispersão")
