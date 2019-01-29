## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, comment="", message=FALSE, warning=FALSE, cache=TRUE, fig.width = 4, fig.height = 4)
options(width=80)

## ----install, eval=FALSE-------------------------------------------------
## install.packages(c("tidyverse",
##                    "nycflights13"))

## ----install_tidyverse, eval=FALSE---------------------------------------
## install.packages("tidyverse")

## ----load_tydiverse------------------------------------------------------
library(tidyverse)

## ----iris----------------------------------------------------------------
head(iris)

## ----create_tible--------------------------------------------------------
iris.tib <- as_tibble(iris)
iris.tib

## ----create_new----------------------------------------------------------
tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)

## ----change_print--------------------------------------------------------
print(iris.tib, n = 10, width = Inf)

## ----change_print2-------------------------------------------------------
print(iris.tib, n = 10, width = 25)

## ----subsetting----------------------------------------------------------
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

# Extract by name
df$x
df[["x"]]
# Extract by position
df[[1]]

## ----compare-------------------------------------------------------------
library(readr)
system.time(dd1 <- read.delim("../../data/genome.txt"))
system.time(dd2 <- read_delim("../../data/genome.txt", 
                              delim="\t"))
dim(dd2)

## ----compare_read--------------------------------------------------------
head(dd1)
dd2

## ----load_data-----------------------------------------------------------
library(nycflights13)
library(tidyverse)

## ----show_flights--------------------------------------------------------
flights

## ----filter--------------------------------------------------------------
jan1 <- filter(flights, month == 1, day == 1)

## ----filter2-------------------------------------------------------------
(jan1 <- filter(flights, month == 1, day == 1))

## ----example_boolean1----------------------------------------------------
filter(flights, month == 11 | month == 12)

## ----example_boolean2----------------------------------------------------
filter(flights, !(arr_delay > 120 | dep_delay > 120))

## ----arrange-------------------------------------------------------------
arrange(flights, year, month, day)

## ----arrange2------------------------------------------------------------
arrange(flights, desc(dep_delay))

## ----select--------------------------------------------------------------
select(flights, year, month, day)

## ----select2-------------------------------------------------------------
select(flights, year:day)

## ----select3-------------------------------------------------------------
select(flights, -(year:day))

## ----add_var-------------------------------------------------------------
flights_sml <- select(flights, 
  year:day, 
  ends_with("delay"), 
  distance, 
  air_time
)
mutate(flights_sml,
  gain = dep_delay - arr_delay,
  speed = distance / air_time * 60
)

## ----transmute-----------------------------------------------------------
transmute(flights,
  gain = dep_delay - arr_delay,
  hours = air_time / 60,
  gain_per_hour = gain / hours
)

## ----summary-------------------------------------------------------------
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

## ----summary2------------------------------------------------------------
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

## ----pipe----------------------------------------------------------------
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")
delay

## ----plot_pipe-----------------------------------------------------------
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

## ----pipe_use------------------------------------------------------------
delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")
delays

## ----group_var-----------------------------------------------------------
flights %>%
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay, na.rm=TRUE),
    avg_delay2 = mean(arr_delay[arr_delay > 0], na.rm=TRUE) 
  )

## ------------------------------------------------------------------------
sessionInfo()

