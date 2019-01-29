## ----data----------------------------------------------------------------
library(tidyverse)
diamonds
count(diamonds, cut)

## ----empty---------------------------------------------------------------
ggplot(data = diamonds)

## ----dist_cat------------------------------------------------------------
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

## ----dist_cont-----------------------------------------------------------
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

## ----dist_2--------------------------------------------------------------
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

## ----boxplot-------------------------------------------------------------
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

## ----boxplot2------------------------------------------------------------
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, 
                                         FUN = median), 
                             y = hwy))

## ----boxplot_flipped-----------------------------------------------------
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, 
                                         FUN = median), 
                             y = hwy)) +  coord_flip()

## ----improved_boxplot, fig.height=2.5------------------------------------
ggplot(iris, aes(x=Species, y=Sepal.Width) ) +
  geom_boxplot(alpha=0.3, outlier.colour = "blue") +
  geom_point(stat= "summary", fun.y=mean, 
             shape=16, size=1.5, color="red") +
  geom_jitter(width = 0.1, alpha = 0.2)

## ----two_cat, fig.height=3, fig.width=4.5--------------------------------
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))

## ----get_count-----------------------------------------------------------
diamonds %>% 
  count(color, cut)

## ----visualize, fig.height=2, fig.width=4--------------------------------
diamonds %>% 
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) +
    geom_tile(mapping = aes(fill = n))

## ----2cont , fig.height=2.5, fig.width=3.5-------------------------------
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))

## ----plot_alpha, fig.height=2.5------------------------------------------
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), 
             alpha = 1 / 100)

## ----bin_2cont-----------------------------------------------------------
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))

## ----lm_info, eval=FALSE-------------------------------------------------
## library(ggpmisc)
## set.seed(1234)
## iris <- mutate(iris,
##                Y = 1.5 + 3.2*Sepal.Width +
##                  rnorm(nrow(iris)))
## ggplot(iris, aes(x = Sepal.Width, y = Y)) +
##   geom_smooth(method = "lm", se=FALSE, color="black",
##               formula = y ~ x) +
##   stat_poly_eq(formula = y ~ x,
##                aes(label = paste(..eq.label.., ..rr.label..,
##                                  sep = "~~~")),
##                parse = TRUE) +
##   geom_point()

## ----lm_info_plot, echo=FALSE--------------------------------------------
library(ggpmisc)
set.seed(1234)
iris <- mutate(iris,
               Y = 1.5 + 3.2*Sepal.Width +
                 rnorm(nrow(iris)))
ggplot(iris, aes(x = Sepal.Width, y = Y)) +
  geom_smooth(method = "lm", se=FALSE, color="black",
              formula = y ~ x) +
  stat_poly_eq(formula = y ~ x,
               aes(label = paste(..eq.label.., ..rr.label.., 
                                 sep = "~~~")),
               parse = TRUE) +
  geom_point()

## ----get_gene_expr-------------------------------------------------------
load("../../data/genes.Rdata")
genes

## ----plot_genes, fig.width=7---------------------------------------------
ggplot(genes, aes(rate, expression, color = nutrient)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    facet_wrap(~name + systematic_name, scales = "free_y")

## ----plot_with_r, eval=FALSE---------------------------------------------
## par(mar = c(1.5, 1.5, 1.5, 1.5))
## 
## colors <- 1:6
## names(colors) <- unique(genes$nutrient)
## 
## m <- matrix(c(1:20, 21, 21, 21, 21), nrow = 6,
##             ncol = 4, byrow = TRUE)
## layout(mat = m, heights = c(.18, .18, .18, .18, .18, .1))
## 
## genes$combined <- paste(genes$name, genes$systematic_name)
## for (gene in unique(genes$combined)) {
##     sub_data <- filter(genes, combined == gene)
##     plot(expression ~ rate, sub_data,
##          col = colors[sub_data$nutrient], main = gene)
##     for (n in unique(sub_data$nutrient)) {
##         m <- lm(expression ~ rate,
##                 filter(sub_data, nutrient == n))
##         if (!is.na(m$coefficients[2])) {
##             abline(m, col = colors[n])
##         }
##     }
## }
## 
## # create a new plot for legend
## plot(1, type = "n", axes = FALSE, xlab = "", ylab = "")
## legend("top", names(colors), col = colors, horiz = TRUE, lwd = 4)

## ----plot_with_r_show, echo=FALSE----------------------------------------
par(mar = c(1.5, 1.5, 1.5, 1.5))

colors <- 1:6
names(colors) <- unique(genes$nutrient)

m <- matrix(c(1:20, 21, 21, 21, 21), nrow = 6, 
            ncol = 4, byrow = TRUE)
layout(mat = m, heights = c(.18, .18, .18, .18, .18, .1))

genes$combined <- paste(genes$name, genes$systematic_name)
for (gene in unique(genes$combined)) {
    sub_data <- filter(genes, combined == gene)
    plot(expression ~ rate, sub_data, col = colors[sub_data$nutrient], main = gene)
    for (n in unique(sub_data$nutrient)) {
        m <- lm(expression ~ rate, 
                filter(sub_data, nutrient == n))
        if (!is.na(m$coefficients[2])) {
            abline(m, col = colors[n])
        }
    }
}
# create a new plot for legend
plot(1, type = "n", axes = FALSE, xlab = "", ylab = "")
legend("top", names(colors), col = colors, horiz = TRUE, lwd = 4)

## ----mtcars--------------------------------------------------------------
mtcars[1:5,1:8]

## ----plot_mtcars---------------------------------------------------------
ggplot(mtcars) +         # data
  aes(x = mpg, y=wt) +   # Aesthetics
  geom_point()           # geometry (layer)  

## ----plot_mtcars2--------------------------------------------------------
ggplot(mtcars) +         # data
  aes(x = mpg, y=wt) +   # Aesthetics
  geom_point() +         # geometry (layer)  
  theme_minimal()        # theme 

## ----area----------------------------------------------------------------
ggplot(mtcars) +        
  aes(sample = mpg) + stat_qq()

## ----tips----------------------------------------------------------------
data(tips, package="reshape2")
head(tips)

## ----facet---------------------------------------------------------------
sp <- ggplot(tips, aes(x=total_bill, y=tip/total_bill)) +
  geom_point()
sp

## ----grid_vertical-------------------------------------------------------
# vertical direction
sp + facet_grid(sex ~ .)

## ----grid_horiz----------------------------------------------------------
# horizontal direction
sp + facet_grid(. ~ sex)

## ----grid_two------------------------------------------------------------
# Divide with "sex" vertical, "day" horizontal
sp + facet_grid(sex ~ day)

## ----wrap, fig.height=2--------------------------------------------------
# Divide by day, going horizontally and wrapping with 2 columns
sp + facet_wrap( ~ day, ncol=2)

## ----reverse_label, eval=FALSE-------------------------------------------
## # Reverse each strings in a character vector
## reverse <- function(strings) {
##     strings <- strsplit(strings, "")
##     vapply(strings, function(x) {
##         paste(rev(x), collapse = "")
##     }, FUN.VALUE = character(1))
## }
## 
## sp + facet_grid(. ~ sex, labeller=labeller(sex = reverse))

## ----reverse_label_plot, echo=FALSE--------------------------------------
# Reverse each strings in a character vector
reverse <- function(strings) {
    strings <- strsplit(strings, "")
    vapply(strings, function(x) {
        paste(rev(x), collapse = "")
    }, FUN.VALUE = character(1))
}

sp + facet_grid(. ~ sex, labeller=labeller(sex = reverse))

## ----modifying-----------------------------------------------------------
sp + facet_grid(sex ~ day) +
    theme(strip.text.x = element_text(size=8, angle=75),
          strip.text.y = element_text(size=12, face="bold"),
          strip.background = element_rect(colour="brown",
                                          fill="tomato"))

## ------------------------------------------------------------------------
sessionInfo()

