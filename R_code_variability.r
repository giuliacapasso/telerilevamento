# R code variability

library(raster)
library(RStoolbox) # for image viewing and variability calculation
library(ggplot2) # for ggplot plotting
library(patchwork) # multiframe with ggplot2 graphs
# install.packages("viridis")
library(viridis)

setwd("~/Desktop/lab_/")

# Exercise: import the Similaun image
similaun <- brick("sentinel.png")

# band1 = NIR
# band2 = red
# band3 = green

# Exercise: plot the image by the ggRGB function
ggRGB(similaun, 1, 2, 3)

# NIR on g component
ggRGB(similaun, 2, 1, 3)

# Exercise: plot the two graphs one beside the other
sim1 <- ggRGB(similaun, 1, 2, 3)
sim2 <- ggRGB(similaun, 2, 1, 3)

# Thanks to patchwork!: 
sim1+sim2

# Exercise: plot one graph on top of the other
sim1/sim2

# Exercise - 4 plots: 
(sim1+sim2)/(sim1+sim2)

# calculation of variability over NIR
nir <- similaun[[1]]

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) #sd=deviazione standard ovvero dove ricade il 68% dei valori

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(sd3, col=clsd)

# plotting with ggplot
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))

# with viridis
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

# cividis
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")

# magma
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# inferno
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")

sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
# inferno
ggplot() + 
geom_raster(sd7, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")
