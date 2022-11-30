# Inequality task - week 4

## Load packages
library(tidyverse)
library(sf)
library(here)
library(janitor)

# read data
HDI <- read_csv(here::here("week4/data", "HDR21-22_Composite_indices_complete_time_series.csv"),
                locale = locale(encoding = "latin1"),
                na = " ", skip=0)
World <- st_read(here::here("week4/data/World_Countries_(Generalized)/World_Countries__Generalized_.shp"))

# select data from HDI
  # the meaning of 'clean_names()':即使用janitor的clean_names函数对列名称做了一定的清洗，里面的空格将会变成下划线，而且大写字母会转化为小写字母。
HDIcols <- HDI %>%
  clean_names() %>%
  select(iso3, country, gii_2019, gii_2010)

# calculate the diff between 2019 & 2010
HDIcols <- HDIcols %>%
  mutate(diff = gii_2019 - gii_2010)

## Join
Join_HDI <- World %>%
  clean_names() %>%
  left_join(.,HDIcols,by=c('country'))
