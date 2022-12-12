# 1.Import the csv file to a table in the database.

create database mini2;
use mini2;



# 2.Remove the column 'Player Profile' from the table.

SELECT * FROM `ICC Test Batting Figures`;
ALTER TABLE `ICC Test Batting Figures` DROP `Player Profile`;

# 3.Extract the country name and player names from the given data and store it in seperate columns for further usage.

alter table `ICC Test Batting Figures` add column Player_Name varchar(100);
alter table `ICC Test Batting Figures` add column Country varchar(10);
SELECT * FROM `ICC Test Batting Figures`;
update `ICC Test Batting Figures` set Player_Name = substring_index(Player,'(',1);
update `ICC Test Batting Figures` set Country = substring_index(Player,'(',-1);
update `ICC Test Batting Figures` set Country = trim(trailing ')' from Country);

SELECT * FROM `ICC Test Batting Figures`;


# 4.From the column 'Span' extract the start_year and end_year and store them in seperate columns for further usage.

alter table `ICC Test Batting Figures` add column start_year int;
alter table `ICC Test Batting Figures` add column end_year int;
SELECT * FROM `ICC Test Batting Figures`;
update `ICC Test Batting Figures` set start_year = substr(Span,1,4);
update `ICC Test Batting Figures` set end_year = substr(Span,6,4);

SELECT * FROM `ICC Test Batting Figures`;

# 5.The column 'HS' has the highest score scored by the player so far in any given match. 
#  The column also has details if the player had completed the match in a NOT OUT status. 
#  Extract the data and store the highest runs and the NOT OUT status in different columns.

alter table `ICC Test Batting Figures` add column Not_out varchar(100);
alter table `ICC Test Batting Figures` add column Highest_Runs int;
SELECT * FROM `ICC Test Batting Figures`;
update `ICC Test Batting Figures` set Not_out = (
Case when HS like '%*' then 'Yes'
else 'No'
end);

update `ICC Test Batting Figures` set Highest_Runs = (
Case when HS like '%*' then trim(trailing '*' from HS)
else HS
end);

SELECT * FROM `ICC Test Batting Figures`;

# 6.Using the data given, considering the players who were active in the year of 2019, 
# create a set of batting order of best 6 players using the selection criteria of those 
# who have a good average score across all matches for India.

select *, rank() over (order by Avg desc) as Avg_Rank from `ICC Test Batting Figures` 
where Country like '%INDIA%' and end_year like '%2019%'
limit 6;


#7.Using the data given, considering the players who were active in the year of 2019, 
# create a set of batting order of best 6 players using the selection criteria of those
# who have highest number of 100s across all matches for India.

select *, rank() over (order by `100` desc) as 100_Rank from `ICC Test Batting Figures` 
where Country like '%INDIA%' and end_year like '%2019%'
limit 6;

# 8.Using the data given, considering the players who were active in the year of 2019, 
# create a set of batting order of best 6 players using 2 selection criterias of your own for India.

select *, rank() over (order by (`100`+`50`) desc) as 100_50_Rank from `ICC Test Batting Figures` 
where Country like '%INDIA%' and end_year like '%2019%'
limit 6;
select *, rank() over (order by Mat) as Mat_Rank from `ICC Test Batting Figures` 
where Country like '%INDIA%' and end_year like '%2019%'
limit 6;
select *, rank() over (order by Mat desc) as Mat_Rank from `ICC Test Batting Figures` 
where Country like '%INDIA%' and end_year like '%2019%'
limit 6;

#9.Create a View named ‘Batting_Order_GoodAvgScorers_SA’ using the data given, considering the players 
# who were active in the year of 2019, create a set of batting order of best 6 players using the selection criteria of those 
# who have a good average score across all matches for South Africa.

create view Batting_Order_GoodAvgScorers_SA as (
select *, rank() over (order by Avg desc) as Avg_Rank from `ICC Test Batting Figures` 
where Country like 'SA' and end_year like '%2019%'
limit 6
);
select * from Batting_Order_GoodAvgScorers_SA;

#10.Create a View named ‘Batting_Order_HighestCenturyScorers_SA’ Using the data given, 
# considering the players who were active in the year of 2019, 
# create a set of batting order of best 6 players using the selection criteria of those 
# who have highest number of 100s across all matches for South Africa.

create view Batting_Order_HighestCenturyScorers_SA as (
select *, rank() over (order by `100` desc) as Avg_Rank from `ICC Test Batting Figures` 
where Country like 'SA' and end_year like '%2019%'
limit 6
);

select * from Batting_Order_HighestCenturyScorers_SA;