
# ===============================
# Project: Cyclistic Trip Analytics
# Purpose: Behavioural Analysis & Membership Conversion
# ===============================


library(tidyverse)
library(janitor)
library(lubridate)
library(ggplot2)
library(dplyr)
library(lsr)


# =========================================================
#1.0 DATA PREPROCESSING AND TRANSFORMATION
#Data cleaning and aggregation
# =========================================================

Q2019 <- read.csv("Q1_2019.csv") %>% 
  clean_names() %>% 
  rename(ride_id = trip_id,
         start_station = from_station_name,
         end_station = to_station_name) %>%
  distinct(ride_id, .keep_all = TRUE)%>%
  mutate(quarter.1 = "2019", 
         ride_id = as.character(ride_id),
         start_time = ymd_hms(start_time),
         end_time = ymd_hms(end_time),
         start_station = as.character(start_station),
         end_station = as.character(end_station),
         usertype = as.factor(usertype),
         age = as.character(2019 - birthyear),
         gender = ifelse(is.na(gender) | gender == "", 
                         "Unspecified", gender))


Q2020 <- read.csv("Q1_2020.csv") %>% 
  clean_names() %>% 
  rename(bike_type = rideable_type,
         start_time = started_at,
         end_time = ended_at,
         start_station = start_station_name,
         end_station = end_station_name,
         usertype = member_casual,
         bike_type = rideable_type) %>%
  distinct(ride_id, .keep_all = TRUE)%>%
  mutate(quarter.1 = "2020",
         ride_id = as.character(ride_id),
         start_time = ymd_hms(start_time),
         end_time = ymd_hms(end_time),
         start_station = as.character(start_station),
         end_station = as.character(end_station),
         usertype = as.factor(usertype))


q1combined <- bind_rows(Q2019,Q2020) %>%
  mutate (trip_duration = as.numeric(difftime(end_time,start_time, 
                                              units = "mins")),
          trip_duration = as.vector(round(trip_duration,2)),
          trip_month = month(end_time, label = TRUE, abbr = TRUE),
          trip_day = wday(end_time, label=TRUE, abbr=TRUE),
          time = as.numeric(format(start_time, "%H")),
          usertype = recode(usertype,
                            "Customer"   = "casual",
                            "casual"     = "casual",
                            "Subscriber" = "member",
                            "member"     = "member")) %>%
  filter(trip_month %in% c("Jan", "Feb", "Mar")) %>%
  droplevels()%>%
  select(ride_id, start_time, end_time, start_station,
         end_station, usertype,gender, quarter.1,
         time, age, bike_type, trip_duration, trip_month, trip_day)

q1combined <- q1combined[q1combined$trip_duration > 1, ]
q12020D <- q1combined[q1combined$quarter.1 == "2020",]
q12019D <- q1combined[q1combined$quarter.1 == "2019",]



# =========================================================
#2.0 DATA ANALYSIS

#2.1 Overall trips (2019 and 2020 combined)
# =========================================================
totaltrip <- nrow(q1combined)
overall_trips <- table(q1combined$usertype)
Overall_trip_prop <- prop.table(overall_trips)
Overall_percent <- round(overall_trips * 100)

# overall trip by users by year
#2019

totaltrip2019 <- table(q12019D$usertype)
trip_prop_2019 <- prop.table(totaltrip2019)
percent2019 <- round(trip_prop_2019 * 100)


#2020

totaltrip2020 <- table(q12020D$usertype)
trip_prop_2020 <- prop.table(totaltrip2020)
percent2020 <- round(trip_prop_2020 * 100)




#2.2 Trip Volume by usertypes

q1combinedsummary <- q1combined %>%
  group_by(usertype, quarter.1 )%>%
  summarise(total_rides = n(), .groups="drop")

q1totaltrips <- ggplot(q1combinedsummary, 
                       aes(x=quarter.1, y=total_rides, fill=quarter.1))+
  geom_col(position = "dodge") +
  facet_wrap(~usertype)+
  scale_y_continuous(
    labels = scales::label_comma())+
  labs(x="Years (Quarter 1)",
       y="Total rides",
       title="Trip volume in Q1 2019-2020 by users")+
  scale_fill_manual(values = c(
    "2019" = "orange3", 
    "2020" = "darkblue"  ))+
  theme(
    axis.title.x = element_text(face = "bold", size = 11),
    axis.title.y = element_text(face = "bold", size = 11),
    axis.text.x  = element_text( size = 11),
    axis.text.y  = element_text( size = 11), 
    strip.text = element_text(face ="bold", size = 11,colour = "black"))


#assess the relationship between usertype and trip year

q1combined$quarter.1 <- as.factor(q1combined$quarter.1)
q1combined$usertype <- as.factor(q1combined$usertype)

associationTest(~quarter.1+usertype, data=q1combined)



#2.3 Trip Volume by month

month_plot <- ggplot(q1combined, 
                     aes(x=trip_month, fill=quarter.1))+
  geom_bar(position = "dodge") +
  scale_y_continuous(
    labels = scales::label_comma())+ 
  facet_wrap(~usertype)+
  labs(x="Months in Quarter 1",
       y="Total rides",
       title="Total volume by months (Q1 2019-2020)")+
  scale_fill_manual(values = c(
    "2019" = "orange3", 
    "2020" = "darkblue"  ))+
  
  theme(
    axis.title.x = element_text(face = "bold", size = 11),
    axis.title.y = element_text(face = "bold", size = 11),
    axis.text.x  = element_text( size = 11),
    axis.text.y  = element_text( size = 11), strip.text = element_text(
      face = "bold",size = 11,colour = "black"))


#2.4 Trip volume by day

day_plot <- ggplot(q1combined, aes(x=trip_day, fill=quarter.1))+
  geom_bar(position = "dodge") + scale_y_continuous(labels = scales::label_comma())+ 
  facet_wrap(~usertype)+ labs(x="Days of the week",y="Total rides",
                              title="Daily trip volume by usertypes")+
  scale_fill_manual(values = c("2019" = "orange3", "2020" = "darkblue"))+
  theme(axis.title.x = element_text(face = "bold", size = 11),
        axis.title.y = element_text(face = "bold", size = 11),
        axis.text.x  = element_text( size = 11),
        axis.text.y  = element_text( size = 11), 
        strip.text = element_text(face = "bold",size = 11, colour = "black"))


#assess the association between trip day and trip volume
q1combined$trip_day <- as.factor(q1combined$trip_day)
associationTest(~trip_day+usertype, data=q1combined)


#2.5 Hourly trip volume over the years 

hoursum <- q1combined %>%
  mutate(travel_hour = as.numeric(time)) %>%      
  group_by(quarter.1, usertype, travel_hour) %>%
  summarise(totalrides = n(),.groups = "drop"
  )

peakhour <- ggplot(hoursum, aes(x = travel_hour, y = totalrides, 
                                color = quarter.1,  group = quarter.1)) +
  geom_line(linewidth = 1) +
  scale_x_continuous(breaks = 0:23) +
  labs(title = "Hourly Trip Volume in Q1 (2019 vs 2020) by User Type",
       x = "Hours of Day (0–23)",
       y = "Total Trips",
       color = "Year") +
  facet_wrap(~ usertype) +
  scale_color_manual(values = c("2019" = "orange3","2020" = "darkblue")) +
  theme(axis.title.x = element_text(size = 11),
        axis.title.y = element_text(face = "bold", size = 11),
        axis.text.x  = element_text( size = 8),
        axis.text.y  = element_text( size = 11), 
        strip.text = element_text(face = "bold",size = 14,colour = "black"))


# =========================================================

#2.6 TRIP DURATION 2019 - 2020
# =========================================================
q12020D <- q1combined[q1combined$quarter.1 == "2020",]
overall_avg2020 <- mean(q12020D$trip_duration, na.rm=TRUE) # Overall average for 2020
overall_med2020 <- median(q12020D$trip_duration, na.rm=TRUE)#Overall median for 2020

avg2020_byuser <- tapply(q12020D$trip_duration, q12020D$usertype, 
                         mean, na.rm=TRUE)
med2020_byuser <- tapply(q12020D$trip_duration, q12020D$usertype,
                         median, na.rm=TRUE)


tripdur_plot <- ggplot(q1combined, 
                       aes(x=quarter.1, y=trip_duration, fill=quarter.1))+
  stat_summary(fun="mean", geom = "bar", position = "dodge")+
  scale_y_continuous(labels = scales::label_comma())+ facet_wrap(~usertype)+
  labs(x="Years",y="Average trip duration",title="Average trip duration by years")+
  scale_fill_manual(values = c("2019" = "orange3","2020" = "darkblue"  ))+
  theme(legend.position = "none")+
  theme(axis.title.x = element_text(face = "bold", size = 11),
        axis.title.y = element_text(face = "bold", size = 11),
        axis.text.x  = element_text( size = 11),
        axis.text.y  = element_text( size = 11), 
        strip.text = element_text(face = "bold",size = 14,colour = "black"))


#assess the relationship between usertypes and trip duration

independentSamplesTTest(trip_duration ~usertype, 
                        data = q1combined, var.equal = FALSE)




