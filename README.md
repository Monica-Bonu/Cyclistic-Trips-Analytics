# **Cyclistic Trip Analytics**
### Behavioural Differences and Membership Growth Opportunities


## **Executive Summary**
This project analyses Cyclistic trip data (Q1 2019–2020) to identify behavioural differences between annual members and casual riders. Using descriptive and inferential statistics, the analysis demonstrates that annual members are predominantly weekday commuters with short trips, while casual riders exhibit longer, weekend-oriented usage. These insights inform targeted membership-conversion strategies, including flexible subscription models and timing-based marketing interventions. 


## **Project Overview**
This project analyses behavioural differences between annual members and casual riders using Cyclistic bike-share data from Q1 2019 and Q1 2020. The aim is to generate data-driven insights to inform membership growth and conversion strategy, with a specific focus on converting high-value casual riders into annual subscribers.
The analysis combines descriptive analytics, statistical testing, and strategic interpretation, reflecting a real-world consulting approach in which analytics directly supports business decision-making.
###Business Question
How do annual members and casual riders use Cyclistic bikes differently, and what does this imply for targeted membership conversion strategies?


## **Data scope and methodology**
### **Data scope**
Analytical Scope
•	Data level: Trip-level data (not user-level)
•	Time period: Q1 2019 and Q1 2020 (January–March)
•	User segments: Annual members vs casual riders
Key dimensions analysed:
•	Trip volume (yearly, monthly, daily, hourly)
•	Trip duration
•	Behavioural differences by user type
Findings describe usage patterns across trips, not individual customer lifecycles, due to the absence of persistent user identifiers.

### **Methods**
1. Data preprocessing and transformation
•	Data cleaning and standardisation across years
•	Handling of missing values and duplicate records
•	Extraction of trip duration, trip day, hour, and month

2. Descriptive Analysis
•	Distribution of trips by user type and year
•	Comparison of travel duration by user type and year
•	Identification of temporal usage patterns

3. Inferential Statistics
•	Chi-square tests to assess associations between user type and temporal variables (year and days of the week)
•	Welch’s independent samples t-tests to test differences in average trip duration of users groups

Reporting: R scripts [https://github.com/Monica-Bonu/Cyclistic-Trips-Analytics/blob/main/Data-Analytics-Script.R] and presentation slides


## **Results & Implications**
### **Key Insights**
•	Annual members exhibit short-duration, high-frequency travel concentrated on weekdays and commuting peak hours (8 AM & 5 PM), indicating predominantly work-related usage.
•	Casual riders travel less frequently but for longer durations, with usage concentrated on weekends and off-peak hours (2 PM – 4 PM), indicating non-routine travel.
•	Behavioural differences between the two groups are statistically significant and structural, not random variation.
•	These findings confirm that Cyclistic’s user segments engage with the service for fundamentally different purposes.

### **Strategic Growth Implications**
•	Casual riders present a clear conversion opportunity, particularly the subgroup that engages in long-duration trips.
•	Presenting annual membership as a value-driven, convenient and cost-effective option addresses the needs of high-potential casual riders
•	Introducing flexible or seasonal membership options (e.g. quarterly plans) could reduce commitment barriers for casual riders.
•	Conversion campaigns are best timed to coincide with peak usage seasons, when casual riders are most likely to reassess their mobility needs.


## **Future improvement**
Analysis is trip-based rather than user-based due to data constraints. Expanding the scope of trip data would enable predictive modelling of conversion likelihood and customer lifetime value. Future analytics and conversion strategy would be strengthened if the following data needs were addressed..
•	Persistent user identifiers
•	Demographic and socio-economic data
•	Pricing and spend information
•	Bike type and subscription tenure


## **Additional project details**
### About this Project
This project was completed as part of the Google Data Analytics Professional Certification capstone and is designed to demonstrate:
•	Analytical rigour 
•	Statistical reasoning
•	Business-oriented insight generation
•	Consulting-style communication

### Tool, tests & packages
•	R (tidyverse, ggplot2, lubridate, janitor,lsr)
•	Statistical testing: Chi-square, Welch’s t-test
•	Data visualisation: ggplot2



