library(ggplot2)
library(data.table)

df <- fread('Economist_Assignment_Data.csv',drop=1)

pl <- ggplot(df,aes(x=CPI,y=HDI)) + geom_point(shape=1,size=4,aes(color=factor(Region))) 
pl2 <- pl+ geom_smooth(aes(group=1),method = 'lm',formula = y~log(x),se=FALSE,color='red')
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)
pl4 <- pl3 + theme_bw() + scale_x_continuous(name="Corruption Perceptions Index, 2011 (10=least corrupt)",limit=c(1,10),breaks = 1:10)+ scale_y_continuous(name="Human Development Index, 2011 (1=Best)", limit=c(0.2,1.0)) + ggtitle("Corruption and Human development")
pl5 <- pl4 + theme(plot.title = element_text(hjust = 0.5))
print(pl5)