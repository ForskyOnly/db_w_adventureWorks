-- 1 Retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle. 

-- SELECT *  
-- FROM humanresources.employee  
-- ORDER BY jobtitle ASC;
-- 

-- 2 Retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname. 

-- SELECT e.*  
-- FROM person.person AS e  
-- ORDER BY LastName ASC;

-- 3 Return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database.
-- The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname

-- SELECT FirstName, LastName, BusinessEntityID as employee_id
-- FROM person.person
-- ORDER BY lastname ASC;


-- 4 return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name. 

-- SELECT productid, productnumber, name
-- FROM Production.Product
-- WHERE SellStartDate is NOT NULL
-- AND production.Product.ProductLine = 'T'
-- ORDER BY name ASC;

-- 5 return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided.
-- Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal. 

-- SELECT subtotal,salesorderid,customerid,orderdate,
-- (TaxAmt*100)/subtotal as TaxPercent
-- FROM sales.salesorderheader
-- ORDER BY subtotal DESC;

-- 6 create a list of unique jobtitles in the employee table in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order. 

-- SELECT DISTINCT jobtitle
-- FROM HumanResources.Employee
-- Order by JobTitle ASC;

-- 7  calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid. 

-- SELECT CustomerID,sum(Freight) as  TotalFreight
-- FROM Sales.SalesOrderHeader
-- Group By CustomerID
-- ORDER BY CustomerID Asc;

-- 8  find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal.
-- Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order. 

-- SELECT customerid,salespersonid, 
-- AVG(subtotal) AS AvgSubtotal,
-- SUM(subtotal) as SumSubtotal
-- FROM sales.salesorderheader
-- GROUP BY customerid, salespersonid
-- ORDER BY customerid DESC;

-- 9 retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500.
-- Return productid and sum of the quantity. Sort the results according to the productid in ascending order.

-- SELECT productid, SUM(quantity) as TotalQtt
-- FROM production.productinventory
-- WHERE Shelf IN ('A', 'C', 'H')
-- GROUP BY productid
-- HAVING SUM(quantity)>500
-- ORDER BY productid ASC;


-- 10  find the total quentity for a group of locationid multiplied by 10.

-- SELECT SUM(quantity) as TotalQtt
-- FROM production.productinventory
-- GROUP BY (locationid*10);

-- 11 find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname. 

-- SELECT p.BusinessEntityID,firstname,lastname,PhoneNumber
-- FROM Person.Person as p
-- Join Person.Personphone as ph
-- ON p.Businessentityid = ph.businessentityid
-- WHERE lastname LIKE '%L%'
-- ORDER BY lastname, firstname;

-- 12 find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. 
-- Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal. 

-- SELECT salespersonid,customerid,sum(subtotal) AS sumSubtotal
-- FROM sales.salesorderheader
-- GROUP BY ROLLUP (salespersonid, customerid);

-- 13 find the sum of the quantity of all combination of group of distinct locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.

-- SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
-- FROM production.productinventory
-- GROUP BY CUBE (locationid, shelf);

-- 14 find the sum of the quantity with subtotal for each locationid. Group the results for all combination of distinct locationid and shelf column. 
-- Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity.

-- SELECT SUM(quantity)AS totalQtt,locationid, shelf
-- FROM production.productinventory
-- GROUP BY GROUPING SETS ( ROLLUP (locationid, shelf), CUBE (locationid, shelf) );

-- 15 find the total quantity for each locationid and calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid.

-- Select locationid, SUM(quantity) AS totalQtt 
-- FROM production.productinventory
-- GROUP BY GROUPING SETS (locationid, ());


-- 16 retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city.

-- SELECT a.City, COUNT(b.AddressID) NoOfEmployees 
-- FROM Person.BusinessEntityAddress as b 
-- INNER JOIN Person.Address AS a 
-- On b.AddressID = a.AddressID
-- GROUP By a.city
-- ORDER BY a.city ASC;

-- 17 retrieve the total sales for each year. Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date. 

-- SELECT YEAR(orderdate) AS "Year",
-- SUM(TotalDue) AS "OrderAmount"  
-- FROM Sales.SalesOrderHeader  
-- GROUP BY YEAR(orderdate)  
-- ORDER BY YEAR(orderdate)ASC;

-- 18 etrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. 
-- Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date.

-- select YEAR(orderdate) AS "Year", SUM(TotalDue) AS TotalDueOrder
-- from Sales.SalesOrderHeader
-- WHERE YEAR(orderdate) <= 2016
-- GROUP BY YEAR(orderdate)
-- ORDER by Year(orderdate);

-- 19 find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order.

-- SELECT ContactTypeID, name
-- From Person.ContactType
-- Where name Like '%Manager%' 
-- ORDER bY ContactTypeID DESC

-- 20 make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.

-- SELECT pp.BusinessEntityID, LastName, FirstName
-- FROM Person.BusinessEntityContact AS pb 
-- INNER JOIN Person.ContactType AS pc
-- ON pc.ContactTypeID = pb.ContactTypeID
-- INNER JOIN Person.Person AS pp
-- ON pp.BusinessEntityID = pb.PersonID
-- WHERE pc.Name = 'Purchasing Manager'
-- ORDER BY LastName, FirstName;

-- 21 retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero.
-- Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
-- Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order. 

-- SELECT ROW_NUMBER() OVER (PARTITION BY pa.PostalCode ORDER BY sp.SalesYTD DESC) AS "Row Number",
-- pp.LastName, sp.SalesYTD, pa.PostalCode
-- FROM Sales.SalesPerson AS sp
-- INNER JOIN Person.Person AS pp 
-- ON sp.BusinessEntityID = pp.BusinessEntityID
-- INNER JOIN Person.Address AS pa 
-- ON pa.AddressID = pp.BusinessEntityID
-- WHERE sp.TerritoryID IS NOT NULL
-- AND sp.SalesYTD <> 0
-- ORDER BY pa.PostalCode ASC, sp.SalesYTD DESC;

-- 22 count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. 
-- Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts. 


-- SELECT pc.ContactTypeID, pc.Name AS CTypeName, COUNT(*) AS NOcontacts
-- FROM Person.BusinessEntityContact AS pbe
-- INNER JOIN Person.ContactType AS pc
-- ON pc.ContactTypeID = pbe.ContactTypeID
-- GROUP BY pc.ContactTypeID, pc.Name
-- HAVING COUNT(*) >= 100
-- ORDER BY COUNT(*) DESC;

-- 23 retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees.
-- In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull. 

-- SELECT FORMAT(he.RateChangeDate, 'yyyy-MM-dd') AS RatechangeDate,
-- CONCAT(pp.firstname, ' ', pp.middlename, ' ', pp.lastname) AS fullname,
-- (40*he.rate) as Weeksalary DESC
-- From HumanResources.EmployeePayHistory as he 
-- INNER JOIN Person.Person as pp
-- On he.BusinessEntityID = pp.BusinessEntityID
-- ORDER BY Fullname ASC;

--  24 calculate and display the latest weekly salary of each employee. Return RateChangeDate, full name (first name, middle name and last name)
--  and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull. 

-- SELECT FORMAT(he.RateChangeDate, 'yyyy-MM-dd') AS RatechangeDate,
-- CONCAT(pp.firstname, ' ', pp.middlename, ' ', pp.lastname) AS fullname,
-- (40*he.rate) as Weeksalary
-- From HumanResources.EmployeePayHistory as he 
-- INNER JOIN Person.Person as pp
-- On he.BusinessEntityID = pp.BusinessEntityID
-- WHERE he.RateChangeDate = (SELECT MAX(RateChangeDate)
-- FROM HumanResources.EmployeePayHistory
-- WHERE BusinessEntityID = he.BusinessEntityID)
-- ORDER BY fullname ASC;

-- 25 find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'.
--  Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity. 

-- SELECT SalesOrderID, ProductID, OrderQty,
-- SUM(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Total Quantity",
-- AVG(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Avg Quantity",
-- COUNT(OrderQty) OVER (PARTITION BY SalesOrderID) AS "No of Orders",
-- MIN(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Min Quantity",
-- MAX(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Max Quantity"
-- FROM Sales.SalesOrderDetail
-- WHERE SalesOrderID IN(43659,43664);

-- 26 find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 
-- and product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity. 

-- SELECT salesorderid AS ordernumber, productid, SUM(orderqty) AS total, 
-- AVG(OrderQty) as avg, COUNT(orderqty) as count
-- FROM sales.SalesOrderDetail
-- WHERE salesorderid in(43659,43664) 
-- AND CAST(ProductID AS VARCHAR(255)) LIKE '71%'
-- GROUP BY salesorderid, productid;

-- 27 retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost. 

-- SELECT salesorderid,
-- suM(unitprice*orderqty) AS totalcost
-- from sales.SalesOrderDetail
-- GROUP BY SalesOrderID
-- HAVING SUM(unitprice*OrderQty) > 100000
-- order BY totalcost DESC;

--  28 retrieve products whose names start with 'Lock Washer'. Return product ID, 
--  and name and order the result set in ascending order on product ID column. 

-- SELECT productid, name 
-- FROM Production.Product
-- WHERE name LIKE '%Lock Washer%'
-- ORDER BY ProductID ;

-- 29 fetch rows from product table and order the result set on an unspecified column listprice. 
-- Return product ID, name, and color of the product. 

-- SELECT productID, name, color 
-- from Production.Product
-- ORDER BY ListPrice;

-- 30 retrieve records of employees. Order the output on year (default ascending order) of hiredate. 
-- Return BusinessEntityID, JobTitle, and HireDate. 

-- SELECT businessentityid, jobtitle, HireDate
-- from HumanResources.Employee
-- ORDER BY Year(HireDate) ASC

-- 31 retrieve those persons whose last name begins with letter 'R'. Return lastname, 
-- and firstname and display the result in ascending order on firstname and descending 
-- order on lastname columns. 

-- SELECT lastname, firstname
-- FROM Person.Person
-- WHERE LastName LIKE 'R%'
-- ORDER BY LastName DESC, FirstName Asc;

-- 32 ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' 
-- and BusinessEntityID in ascending order when SalariedFlag set to 'false'. 
-- Return BusinessEntityID, SalariedFlag columns. 

-- SELECT businessentityid, salariedflag
-- from HumanResources.Employee
-- ORDER BY CASE SalariedFlag WHEN 'true' THEN BusinessEntityID END DESC,
-- CASE WHEN SalariedFlag ='false' THEN BusinessEntityID END;

-- 33 set the result in order by the column TerritoryName when the column 
-- CountryRegionName is equal to '' and by CountryRegionName for all other rows. 

-- SELECT businessentityid, lastname, territoryname, countryregionname
-- from sales.vSalesPerson
-- WHERE TerritoryName IS NOT NULL  
-- ORDER BY CASE WHEN countryregionname ='United States' THEN TerritoryName
-- Else CountryRegionName END;

-- 34 find those persons who lives in a territory and the value of salesytd except 0. 
-- Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' 
-- and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column. 

-- SELECT p.FirstName, p.LastName  
--     ,ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS "Row Number"  
--     ,RANK() OVER (ORDER BY a.PostalCode) AS "Rank"  
--     ,DENSE_RANK() OVER (ORDER BY a.PostalCode) AS "Dense Rank"  
--     ,NTILE(4) OVER (ORDER BY a.PostalCode) AS "Quartile"  
--     ,s.SalesYTD, a.PostalCode  
-- FROM Sales.SalesPerson AS s   
--     INNER JOIN Person.Person AS p   
--         ON s.BusinessEntityID = p.BusinessEntityID  
--     INNER JOIN Person.Address AS a   
--         ON a.AddressID = p.BusinessEntityID  
-- WHERE TerritoryID IS NOT NULL AND SalesYTD <> 0;

-- 35 skip the first 10 rows from the sorted result set and return all remaining rows.

-- SELECT *
-- FROM HumanResources.Department  
-- ORDER BY DepartmentID OFFSET 10 ROWS;

-- 36 skip the first 5 rows and return the next 5 rows from the sorted result set. 

-- SELECT * 
-- FROM HumanResources.Department
-- ORDER By DepartmentID OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

-- 37  list all the products that are Red or Blue in color. Return name, 
-- color and listprice.Sorts this result by the column listprice. 

-- SELECT name, color, listprice
-- from Production.Product
-- WHERE color in('Blue', 'Red')
-- ORDER BY ListPrice;

-- 38 from the SalesOrderDetail table retrieve the product name and any associated sales orders. 
-- Additionally, it returns  any sales orders that don't have any items mentioned in the Product 
-- table as well as any products that have sales orders other than those that are listed there.
-- Return product name, salesorderid. Sort the result set on product name column. 

-- SELECT p.Name, ss.SalesOrderID  
-- FROM Production.Product AS p  
-- FULL OUTER JOIN Sales.SalesOrderDetail AS ss
-- ON p.ProductID = ss.ProductID  
-- ORDER BY p.Name ;

-- 39 retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set.

-- SELECT p.Name, ss.SalesOrderID  
-- FROM Production.Product AS p  
-- LEFT OUTER JOIN Sales.SalesOrderDetail AS ss  
-- ON p.ProductID = ss.ProductID  
-- ORDER BY p.Name ;

-- 40 get all product names and sales order IDs. Order the result set on product name column. 

-- SELECT p.Name, ss.salesorderID
-- FROM Production.Product as p
-- INNER JOIN sales.SalesOrderDetail as ss 
-- On p.ProductID = ss.ProductID
-- order BY p.Name

--  41 retrieve the territory name and BusinessEntityID. The result set includes all salespeople,
-- regardless of whether or not they are assigned a territory. 

-- SELECT ss.Name AS Territory, sp.BusinessEntityID  
-- FROM Sales.SalesTerritory AS ss   
-- RIGHT OUTER JOIN Sales.SalesPerson AS sp  
-- ON ss.TerritoryID = sp.TerritoryID ;

-- 42 find the employee's full name (firstname and lastname) and city from the following tables. 
-- Order the result set on lastname then by firstname.  

-- SELECT concat(RTRIM(p.FirstName),' ', LTRIM(p.LastName)) AS Name, d.City  
-- FROM Person.Person AS p  
-- INNER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID   
-- INNER JOIN  
--    (SELECT bea.BusinessEntityID, a.City   
--     FROM Person.Address AS a  
--     INNER JOIN Person.BusinessEntityAddress AS bea  
--     ON a.AddressID = bea.AddressID) AS d  
-- ON p.BusinessEntityID = d.BusinessEntityID  
-- ORDER BY p.LastName, p.FirstName;

-- 43 return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) 
-- with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname.
-- A SELECT statement after the FROM clause is a derived table. 

-- SELECT businessentityid, firstname,lastname  
-- FROM  
--    (SELECT * FROM person.person  
--     WHERE persontype = 'IN') AS personDerivedTable 
-- WHERE lastname = 'Adams'  
-- ORDER BY firstname;

-- 44 retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al',
-- and a firstname starting with 'M'. 

-- SELECT businessentityid, firstname, lastname
-- FROM Person.Person
-- WHERE LastName LIKE 'AL%' AND FirstName lIKE 'M%' 
-- and BusinessEntityID <=1500

-- 45 find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap'
-- using a derived table with multiple values. 

-- SELECT p.productid, p.name, p.color
-- FROM 
-- (SELECT * FROM production.product
-- WHERE name IN ('Blade', 'Crown Race', 'AWC Logo Cap')
-- ) AS derivedTable
-- JOIN production.product p ON derivedTable.productid = p.productid;

-- 46 display the total number of sales orders each sales representative receives annually. 
-- Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. 
-- Return the year component of the OrderDate, SalesPersonID, and SalesOrderID. 

-- WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
-- AS
-- (
-- SELECT SalesPersonID, SalesOrderID, Year(OrderDate) AS SalesYear
-- FROM Sales.SalesOrderHeader
-- WHERE SalesPersonID IS NOT NULL
-- )
-- SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
-- FROM Sales_CTE
-- GROUP BY SalesYear, SalesPersonID
-- ORDER BY SalesPersonID, SalesYear;

-- 47 find the average number of sales orders for all the years of the sales representatives. 

-- WITH Sales_CTE (SalesPersonID, NumberOfOrders)
-- AS
-- (
--  SELECT SalesPersonID, COUNT(*)
--  FROM Sales.SalesOrderHeader
--  WHERE SalesPersonID IS NOT NULL
--  GROUP BY SalesPersonID
-- )
-- SELECT AVG(NumberOfOrders) AS "Average Sales Per Person"
-- FROM Sales_CTE;

-- 48  retrieve records with the characters green_ in the LargePhotoFileName field. 
-- The following table's columns must all be returned. 

-- SELECT * 
-- FROM Production.ProductPhoto  
-- WHERE LargePhotoFileName LIKE '%green_%' ;

-- 49 retrieve the mailing address for any company that is outside the United States (US) and in a city 
-- whose name starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns. 

-- SELECT AddressLine1, AddressLine2, City, PostalCode, CountryRegionCode    
-- FROM Person.Address AS pa  
-- JOIN Person.StateProvince AS ps 
-- ON pa.StateProvinceID = ps.StateProvinceID  
-- WHERE CountryRegionCode NOT IN ('US')  
-- AND City LIKE 'Pa%' ;

-- 50 fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate column in descending order. 

-- SELECT TOP 20 JobTitle, HireDate  
-- FROM HumanResources.Employee
-- ORDER BY HireDate desc