install.packages("deldir")
install.packages("ggplot2")

library(deldir)
library(ggplot2)

# Creamos dataframe ficticio
mcdonalds <- data.frame(
  name = c("Rambla", "Sants", "Gràcia", "Diagonal Mar", "Glòries", "El Clot", "Poble Nou"),
  x = c(2, 4, 6, 8, 9, 7, 5),
  y = c(8, 4, 9, 2, 6, 5, 7)
)

# Calculamos Voronoi
vor <- deldir(mcdonalds$x, mcdonalds$y)

# Extraemos polígonos del diagrama
tiles <- tile.list(vor)

# Creamos dataframe de los polígonos
library(dplyr)
vor_polys <- lapply(1:length(tiles), function(i) {
  data.frame(x = tiles[[i]]$x,
             y = tiles[[i]]$y,
             id = i,
             name = mcdonalds$name[i])
}) %>% bind_rows()

# Visualizamos
ggplot() +
  geom_polygon(data = vor_polys, aes(x = x, y = y, group = id, fill = name), color = "black", alpha = 0.6) +
  geom_point(data = mcdonalds, aes(x = x, y = y), color = "black", size = 1.1) +
  geom_text(data = mcdonalds, aes(x = x + 0.2, y = y + 0.2, label = name), size = 3) +
  coord_fixed() +
  theme_minimal() +
  labs(
    title = "Zonas de Influencia de McDonald's en Barcelona (Diagrama de Voronoi)",
    subtitle = "Cada región muestra el área más cercana a un local de McDonald's según su posición",
    x = "Posición X (ficticia)", 
    y = "Posición Y (ficticia)", 
    fill = "Ubicación"
  )



