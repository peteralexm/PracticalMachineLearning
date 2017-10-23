setwd("./datasciencecoursera/C5Project")
library(ggplot2)

df <- read.csv("./RepData_PeerAssessment1/activity.csv")

#What is mean total number of steps taken per day?
Sum_steps <- aggregate(cbind(steps)~date, data=df, FUN=sum)


ggplot(Sum_steps, aes(steps))+geom_histogram()+ 
  labs(title="Histogram for Steps") +  labs(x="Age", y="Count")+ylim(0,10)+
  geom_vline(xintercept=mean(Sum_steps$steps), color="red")+
  geom_vline(xintercept=median(Sum_steps$steps, na.rm=FALSE), color="blue")+
  scale_colour_manual(name="Line Color", values=c(myline1="red", myline2="blue", myline3="purple"))

median(Sum_steps$steps)
mean(Sum_steps$steps)
quantile(Sum_steps$steps, 0.5)



#What is the average daily activity pattern?

pattern <- aggregate(cbind(steps)~interval, data=df, FUN=mean)
ggplot(pattern, aes(x=interval, y=steps))+geom_line()

pattern$interval[which.max(pattern$steps)]
       
#Imputing missing values

sum(is.na(df$steps))
df$steps[is.na(df$steps)] <-pattern$steps[pattern$interval %in% df$interval[is.na(df$steps)]] 
Sum_steps <- aggregate(cbind(steps)~date, data=df, FUN=sum)


ggplot(Sum_steps, aes(steps))+geom_histogram()+ 
  labs(title="Histogram for Steps") +  labs(x="Age", y="Count")+ylim(0,10)+
  geom_vline(xintercept=mean(Sum_steps$steps), color="red")+
  geom_vline(xintercept=median(Sum_steps$steps), color="blue")+
  scale_colour_manual(name="Line Color", values=c(myline1="red", myline2="blue", myline3="purple"))

median(Sum_steps$steps)
mean(Sum_steps$steps)

#Are there differences in activity patterns between weekdays and weekends?

df$weekday <- weekdays(as.Date(df$date, format="%Y-%m-%d"), 1)
df$weekday[df$weekday=="Ïí"|df$weekday=="Âò"|df$weekday=="Ñð"|df$weekday=="×ò"|df$weekday=="Ïò"] <- "weekday"
df$weekday[df$weekday=="Ñá"|df$weekday=="Âñ"] <- "weekend"

pattern2 <- aggregate(cbind(steps)~interval+weekday, data=df, FUN=mean)

ggplot(pattern2, aes(x=interval, y=steps))+geom_line()+facet_grid(weekday ~.)



knit2html(input='./datasciencecoursera/C5Project/RepData_PeerAssessment1/PA1_template.Rmd', output='./datasciencecoursera/C5Project/RepData_PeerAssessment1')
