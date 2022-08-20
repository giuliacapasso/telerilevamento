# 1 multivariate analysis # 2 heterogeneity analysis

library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)

setwd("~/Desktop/lab_/")

similaun <- brick("sentinel.png")

# band1 = NIR
# band2 = red
# band3 = green

ggRGB(similaun, 1, 2, 3)

#rasterPCA> extract a single layer with multivariate analysis> starting from three layers, we compact in a single layer
simPCA <- rasterPCA(similaun)
simPCA
summary(simPCA$model)
plot(simPCA$map)

pc1sim <- simPCA$map$PC1
pc2sim <- simPCA$map$PC2
pc3sim <- simPCA$map$PC3
 
ggplot() + geom_raster(pc1sim, mapping = aes(x=x, y=y, fill=PC1))


# calculation of the variability on one of the components that shows the maximum variability with the ##focal function
# Standard deviation of PC1
sd_sim_PC1 <- focal(pc1sim, matrix(1/9, 3, 3), fun=sd)

# Map by ggplot the standard deviation of the first proncipal component

ggplot() + 
geom_raster(sd_sim_PC1, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "cividis") + 
ggtitle("Standard deviation of the first PC")

# images altogether 
 
im1 <- ggRGB(similaun, 3, 2, 1)
g1 <- ggplot() + geom_raster(pc1sim, mapping = aes(x=x, y=y, fill=PC1))
im3 <- ggplot() + geom_raster(sd_sim_PC1, mapping =aes(x=x, y=y, fill=layer)) + scale_fill_viridis(option = "inferno")

im1 + g1 + im3 



p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)

p224r63_2011

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)

pairs(p224r63_2011)

# aggregate cells: resampling (ricampionamento)
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

summary(p224r63_2011res_pca$model)

# dev.off()
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

