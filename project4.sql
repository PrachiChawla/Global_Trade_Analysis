create database Gatt;
use gatt;

-- Show the list of tables in the database
show tables;

-- Display data from key tables
select* from countries;
select* from exports;
select* from imports;
select * from tariffs;
select * from tradeagreements;

#Identify top trading partners for each country
select 
	c1.countryname as exportingcountry,
	c2.countryname as importingcountry,
	sum(e.value) as totaltradevalue
from 
	exports e 
join 
	countries c1 on e.countryid = c1.countryid
join 
     imports i on e.product = i.product
join 
     countries c2 on i.countryid = c2.countryid
group by
     exportingcountry, importingcountry
order by 
	totaltradevalue desc;


#Find the product with the highest tariff rate in each country.
select 
    t.CountryID,
    c.CountryName,
    t.Product,
    t.TariffRate 
from 
    Tariffs t
join 
    countries c on t.countryid=c.countryid 
where
   t.tariffrate = (
      select max(tariffrate) 
      from tariffs t2
      where t2.countryid=t.countryid);


#Trade Imbalance Between the USA and China
select 
    c.countryname,
    e.year,
    sum(e.value) as exports, 
    sum(i.value) as imports ,
    sum(e.value)-sum(i.value) as tradebalance 
from 
    countries c 
join 
	exports e on c.countryid = e.countryid 
join 
    imports i on c.countryid = i.countryid 
where 
    c.countryname in( 'usa' ,'china')
group by 
    c.countryname,e.year
order by
    e.year, tradebalance DESC; 

#Trade Deficit Analysis
select
	c.countryname,
	sum(e.value)-sum(i.value) as tradebalance 
from
	countries c 
join 
    exports e on c.countryid = e.countryid 
join 
    imports i on c.countryid = i.countryid 
group by
	c.countryname 
order by 
	tradebalance asc;

#Identify countries that export more than they import and their trade surplus/deficit.
select 
    c.CountryName,
	sum(e.value) as TotalExports,
	sum(i.value) as TotalImports,
	sum(e.value) - sum(i.value) as TradeBalance
from 
    Countries c 
join 
    Exports e on c.CountryID = e.CountryID 
join
	Imports i on c.CountryID = i.CountryID
group by 
    c.CountryName 
having 
     TradeBalance > 0;

#Classify Export Values
Select
    Product, 
    year, 
    value as ExportValue,
case
   when Value < 1000000 then 'Low'
   when value between 1000000 and 4999999 then 'Moderate'
else 
   'High'
end as 
   ExportCategory
from 
   Exports;

#Identify the year with the highest average tariff rate.
select 
    year, 
    avg(TariffRate) as AvgTariffRate
from 
   Tariffs 
group  by 
   year 
order by 
   AvgTariffRate desc limit 1;

#Find the year in which each product had its highest export value.
select 
    Product, 
    year, 
    value,
    max(value) 
over (partition by Product) as maxexportvalue
from 
   Exports 
order by
    maxexportvalue desc ;







