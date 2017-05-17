# Call up the libraries you need to use to run the app
library(shiny) # Makes shiny apps
library(plyr) # Data manipulation
library(dplyr) # Data manipulation
library(ggplot2) # Elegant plots
library(DT) # Better table options


#rm(list = ls())
# Bring in your data for app
qtimeseries_FDC <- read.csv('data/qtimeseries_FDC3.csv', header=T)
#qtimeseries_FDC <- read.delim("data/qtimeseries_FDC.txt", sep = "\t", header=T)
#str(qtimeseries_FDC)
#summary(qtimeseries_FDC)

#levels(factor(qtimeseries_FDC$fvariable))
#qFDC <- read.table("data/qtimeseries_FDC.txt", header=T)
#qtimeseries_FDC <- read.csv('data/reduced.csv')

#try rds file type (http://stat.ethz.ch/R-manual/R-devel/library/base/html/readRDS.html)
#saveRDS(qtimeseries_FDCa, "qtimeseries_FDC.rds")
## restore it under a different name
#qtimeseries_FDC <- readRDS("qtimeseries_FDC.rds")
#rm(qtimeseries_FDCa)


#qFDC <- read.xls ("qtimeseries_FDC.xlsx", sheet = 1, header = TRUE)
#qFDC <- 
#head(qtimeseries_FDC)
#tail(qtimeseries_FDC)
#str(qtimeseries_FDC)


### in global file, import data and define function for plotting:

# qtimeseries plot function
qplotFunction <- function(data, indicator){
  
  ggplot(data, aes(x=strptime(Date, "%m/%d/%Y"), y=value, fill=factor(fvariable))) + 
    geom_area(alpha=0.7,position="identity") + 
    scale_fill_manual(values=c("#053061","#b8e186"), name = "Stream Discharge Time Series", labels = c("Pre","Post")) + 
    scale_y_sqrt() + ggtitle(paste(data$site, "-", data$sitetype)) +
    theme(legend.position="bottom", panel.grid.major=element_line(color="grey86"), 
          panel.grid.minor=element_blank(), axis.ticks=element_blank(), 
          panel.background=element_rect(fill="white"), axis.text=element_text(size=12), 
          legend.text=element_text(size=12), plot.title = element_text(face='bold',size=15), 
          strip.text.x = element_text(size=12, margin = margin(0.05, 0, 0.05, 0, "cm"))) + 
    ylab("Discharge (cfs)") + xlab("Date") 
}


# fdc plot function
fdcplotFunction <- function(data, indicator){
  
  ggplot(data, aes(x=exceedance.probability, y=flow.value, color=factor(fvariable))) + 
    geom_line(size=2) + 
    scale_color_manual(values=c("#053061","#b8e186"), name = "Annual Flow Duration Curve", labels = c("Pre","Post")) + 
    scale_y_log10(breaks=c(0.1,10,100,1000), labels=c(0.1,10,100,1000)) +
    ggtitle(paste(data$site, "-", data$sitetype)) + 
    theme(legend.position="bottom", panel.grid.major=element_line(color="grey86"), 
          panel.grid.minor=element_blank(), legend.key=element_blank(),
          axis.ticks=element_blank(), panel.background=element_rect(fill="white"), legend.key.width=unit(5, "cm"),
          axis.text=element_text(size=12), title=element_text(size=12), legend.text=element_text(size=12), 
          plot.title = element_text(face='bold',size=15),
          strip.text.x = element_text(size=12, margin = margin(0.05, 0, 0.05, 0, "cm")))+ 
    ylab("Discharge (cfs)") + xlab("Exceedance Probability (%)") 
}












