USE web_engagement_analysis;
# TOTAL UNIQUE VISITORS
SELECT sum(`Unique Visitors`) AS total_unique_visitors 
FROM web_engagement_data;

#AVG BOUNCE RATE%
SELECT AVG(`Bounce Rate (%)`) AS avg_bounce_rate 
FROM web_engagement_data;

#AVG SESSION DURATION
SELECT AVG(`Avg Session Duration (min)`) AS avg_session_duration 
FROM web_engagement_data;

# TRAFFIC SOURCE BREAKDOWN 
SELECT `Traffic Source`, COUNT(*) AS visit_count 
FROM web_engagement_data 
GROUP BY `Traffic Source` 
ORDER BY visit_count DESC;

#DEVICE USAGE SHARE
SELECT `Device Type`, COUNT(*) AS visit_count 
FROM web_engagement_data
GROUP BY `Device Type` 
ORDER BY visit_count DESC;

# TOP 5 REGION BY UNIQUE VISITORS
SELECT Region, sum(DISTINCT `Unique Visitors`) AS unique_visitors 
FROM web_engagement_data 
GROUP BY Region 
ORDER BY  unique_visitors DESC 
LIMIT 5;

# ENGAGEMENT BY DATE
SELECT date AS ENGAGEMENT_DATE, 
	SUM(`Page Views`) AS total_page_views, 
	SUM(DISTINCT `Unique Visitors`) AS unique_visitors 
FROM web_engagement_data 
GROUP BY date 
ORDER BY ENGAGEMENT_DATE;

