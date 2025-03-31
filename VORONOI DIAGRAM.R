
install.packages("deldir")
install.packages("ggplot2")
library(deldir)
library(ggplot2)

# Datos: coordenadas de los McDonald's
mcdonalds <- data.frame(
  name = c("Rambla", "Sants", "Gràcia", "Diagonal Mar", "Glòries", "El Clot", "Poble Nou"),
  x = c(2, 4, 6, 8, 9, 7, 5),
  y = c(8, 4, 9, 2, 6, 5, 7)
)

# Calculamos el diagrama de voronoi
vor <- deldir(mcdonalds$x, mcdonalds$y)

# Convertimos en dataframe
vor_df <- as.data.frame(vor$dirsgs)

# Visualización con ggplot2
ggplot() +
  geom_segment(data = vor_df, aes(x = x1, y = y1, xend = x2, yend = y2), color = "black") +
  geom_point(data = mcdonalds, aes(x = x, y = y), color = "red", size = 3) +
  geom_text(data = mcdonalds, aes(x = x + 0.2, y = y + 0.2, label = name), size = 3) +
  coord_fixed() +
  theme_minimal() +
  labs(title = "Diagrama de Voronoi - McDonald's 🍔", x = "X", y = "Y")
