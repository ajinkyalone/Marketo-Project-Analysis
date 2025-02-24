USE email_marketing;
# EMAIL DELIVERY RATE %
SELECT 
    (COUNT(CASE WHEN Activity_Type = 'Delivered' THEN 1 END) * 100.0) / (SELECT COUNT(Email_ID) FROM activities) AS Email_Delivery_Rate
FROM activities;

# OPEN RATE %
SELECT 
    (COUNT(CASE WHEN Activity_Type = 'Open' THEN 1 END) * 100.0) /
    NULLIF(COUNT(CASE WHEN Activity_Type = 'Delivered' THEN 1 END), 0) AS Open_Rate
FROM activities ;
# CTR %
SELECT 
    (COUNT(CASE WHEN Activity_Type = 'Click' THEN 1 END) * 100.0) /
    NULLIF(COUNT(CASE WHEN Activity_Type = 'Open' THEN 1 END), 0) AS CTR
FROM activities ;

#CAMPAIGN ENGAGEMENT RATE %
SELECT Campaign_ID,
    (COUNT(Activity_ID) * 100.0) / (SELECT COUNT(*) FROM activities) AS Engagement_Rate
FROM activities 
join emails on activities.Email_ID = emails.Email_ID
GROUP BY Campaign_ID;

#TOP PERFORMING CAMPAIGN
SELECT 
    c.Campaign_ID, 
    COUNT(a.Activity_ID) AS Total_Activities
FROM activities a 
join Emails e on a.Email_ID = e.Email_ID
join Campaign c  on e.Campaign_ID = c.Campaign_ID
GROUP BY c.Campaign_ID
ORDER BY Total_Activities DESC
LIMIT 10;  -- Top 10 campaigns

#AVG ACTIVITY PER EMAIL
SELECT 
    COUNT(Activity_ID) * 1.0 / (select COUNT(DISTINCT Email_ID)from emails) AS Avg_Activity_Per_Email
FROM activities;


#ACTIVITY BREAKDOWN BY TYPE
SELECT 
    Activity_Type,
    COUNT(Activity_ID) * 100.0 / (SELECT COUNT(*) FROM activities) AS Activity_Breakdown_by_type
FROM activities
GROUP BY Activity_Type;

# EMAIL SENT VS ACTIVITY TIMELINE
SELECT 
    COALESCE(E.Email_Sent_Date, A.Activity_Date) AS Date,
    COUNT(DISTINCT E.Email_ID) AS Emails_Sent,
    COUNT(A.Activity_ID) AS Total_Activities
FROM emails e
LEFT JOIN activities A ON E.Email_ID = A.Email_ID
GROUP BY COALESCE(E.Email_Sent_Date, A.Activity_Date)
ORDER BY Date;


