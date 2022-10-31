---Purpose: Build a database with a hotel dataset in other to develop SQL query that will be copied into power bi,
---for ETL and visualization. This will help us answer the following questions
---1.Is our hotel revenue growing by year? We have two hoteltypes so it would be good to segment revenue by hotel type
---2.Should we increase our parking lot size? We want to understand if there is a trend in guests with personal cars.
---3.What trend can we see in the data? Focus on average daily rates & gueststo explore seasonality.

---Checked table content of the tables in the database 'Projects'
select* from dbo.['2018$']
select* from dbo.['2019$']
select* from dbo.['2020$']

---Combined the three tables in the database to get one unified table
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select* from dbo.['2020$']

---Is our hotel revenue growing by year? 
---First lets create a temporary table using the WITH CLAUSE
with hotels as(
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select* from dbo.['2020$'])
select* from hotels
---There is no revenue column in our database or temporary table. 
---Thus the need to create one from the adr(Average Daily Rates),
---Stays_in_week_nights and stays_in_weekend_nights column

---Now lets add the total_stays
with hotels as(
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select* from dbo.['2020$'])
---select* from hotels
select stays_in_week_nights + stays_in_weekend_nights from hotels

---Now lets calculate the revenue generated from the total_stays. *adr=average daily rates
with hotels as(
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select* from dbo.['2020$'])
---select* from hotels
select (stays_in_week_nights + stays_in_weekend_nights)*adr as revenue from hotels

---Next is to check whether our revenue is increasing by year
with hotels as(
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select* from dbo.['2020$'])
---select* from hotels
select arrival_date_year,
sum ((stays_in_week_nights + stays_in_weekend_nights)*adr) as revenue from hotels
group by arrival_date_year

---Now lets segment the revenue by hotel type
with hotels as(
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select* from dbo.['2020$'])
---select* from hotels
select arrival_date_year,hotel,
sum ((stays_in_week_nights + stays_in_weekend_nights)*adr) as revenue from hotels
group by arrival_date_year,hotel

---Let round the output to 2 decimal places
with hotels as(
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select* from dbo.['2020$'])
---select* from hotels
select arrival_date_year,hotel,
round (sum ((stays_in_week_nights + stays_in_weekend_nights)*adr),2) as revenue from hotels
group by arrival_date_year,hotel

---lets join the other tables(market segment + meal cost) table to the hotels table in order to develop an SQL for power bi 
with hotels as(
select* from dbo.['2018$']
union
select* from dbo.['2019$']
union
select* from dbo.['2020$'])
select* from hotels
left join dbo.market_segment$
on hotels.market_segment=market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal=hotels.meal

---Now let open our power bi so that we can copy and load in our above SQL into power bi 
---for visualization in order to answer the following questions
---1.Is our hotel revenue growing by year? We have two hoteltypes so it would be good to segment revenue by hotel type
---2.Should we increase our parking lot size? We want to understand if there is a trend in guests with personal cars.
---3.What trend can we see in the data? Focus on average daily rates & gueststo explore seasonality.