CREATE TABLE Video (
    Link VARCHAR2(255) PRIMARY KEY,
    VideoViews NUMBER,
    Title VARCHAR2(255),
    Language VARCHAR2(100),
    Quality NUMBER
);
CREATE TABLE Creator (
    CreatorName VARCHAR2(255),
    CreatorGender VARCHAR2(50),
    Link VARCHAR2(255)
);
CREATE TABLE Channel (
    SubCount NUMBER,
    ChannelViews NUMBER,
    NumVideos NUMBER,
    NumPlaylist NUMBER,
    Link VARCHAR2(255)
);
CREATE TABLE Interaction (
    NumLikes NUMBER,
    NumComments NUMBER,
    CommunityEngagement NUMBER,
    Link VARCHAR2(255)
);


--Question 1
-- "Write a query to determine which language has the highest average video views, indicating potentially trending content languages."
SELECT Language, AVG(VideoViews) AS AverageViews
FROM Video
GROUP BY Language
ORDER BY AverageViews DESC;


--Question 2
--"How can you analyze if there’s a correlation between video quality and community engagement (likes and comments)?"
SELECT Quality, AVG(Numlikes + NumComments) AS AverageEngagement
FROM Video v
JOIN Interaction i ON v.Link = i.Link -- Assuming Link as the common identifier
GROUP BY Quality;


--Question 3
--"Create a query to evaluate the gender diversity of creators among the top 10% most viewed videos."
-- This query requires a modification in the schema to link creators with videos.


--Question 4
--"How would you identify channels that have a high number of subscribers but relatively low video views, suggesting potential areas for content improvement?"
SELECT 
    c.Link,
    c.SubCount,
    SUM(v.VideoViews) AS TotalVideoViews
FROM 
    Channel c
JOIN 
    Video v ON c.Link = v.Link
GROUP BY 
    c.Link, c.SubCount
HAVING 
    c.SubCount > 500 AND SUM(v.VideoViews) < 5000000;



--Question 5
--"Write a SQL query to find out if there’s a significant difference in community engagement (likes + comments) between videos with different quality levels."
SELECT Quality, AVG(Numlikes + NumComments) AS AverageEngagement
FROM Video v
JOIN Interaction i ON v.Link = i.Link
GROUP BY Quality;


--Question 6
--"Can you determine the most common video language among the top 20% most-liked videos, to understand viewer preferences?"
-- This query requires a ranking or percentile function that is not directly supported with the given table structure.


--Question 7
--"How would you compare the average number of views per video against the total subscriber count for each channel, to assess overall channel performance?"
SELECT 
    c.Link,
    c.SubCount,
    AVG(v.VideoViews) AS AverageViewsPerVideo
FROM 
    Channel c
JOIN 
    Video v ON c.Link = v.Link
GROUP BY 
    c.Link, c.SubCount;


--Question 8
--"Create a query to find out which creators’ videos have, on average, the highest number of views, indicating their influence on content popularity."
-- This query requires linking creators with videos, which is not possible with the current table structure.


--Question 9
--"Write a SQL query to analyze the ratio of likes to comments across all videos, to understand audience interaction patterns."
SELECT AVG(Numlikes) AS AverageLikes, AVG(NumComments) AS AverageComments
FROM Interaction;


--Question 10
--"How can you assess channels based on their 'engagement efficiency,' calculated as total community engagement divided by the number of videos, to identify which channels are most effectively engaging their audience?"
SELECT 
    c.Link,
    (SUM(i.Numlikes + i.NumComments + i.CommunityEngagement) / c.NumVideos) AS EngagementEfficiency
FROM 
    Channel c
JOIN 
    Interaction i ON c.Link = i.Link
GROUP BY 
    c.Link, c.NumVideos;






