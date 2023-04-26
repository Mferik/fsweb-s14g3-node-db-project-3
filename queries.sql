-- Multi-Table Sorgu Pratiği

-- Tüm ürünler(product) için veritabanındaki ProductName ve CategoryName'i listeleyin. (77 kayıt göstermeli)

SELECT p.ProductName,
       p.CategoryName
  FROM product AS p
       JOIN
       category AS c ON p.categoryid = c.id;



-- 9 Ağustos 2012 öncesi verilmiş tüm siparişleri(order) için sipariş id'si (Id) ve gönderici şirket adını(CompanyName)'i listeleyin. (429 kayıt göstermeli)

SELECT [Order].id as 'Siparis ID',
       customer.CompanyName
  FROM [Order]
       JOIN
       customer ON Customer.id = [Order].Customerid
 WHERE OrderDate < '2012-08-09';



-- Id'si 10251 olan siparişte verilen tüm ürünlerin(product) sayısını ve adını listeleyin. ProdcutName'e göre sıralayın. (3 kayıt göstermeli)
SELECT p.Productname AS [Ürün İsmi],
       count( * ) AS [Ürün Sayısı]
  FROM OrderDetail as od
       JOIN
       Product as p ON od.productid = p.id
 WHERE Orderid = 10251
 GROUP BY od.productid;



-- Her sipariş için OrderId, Müşteri'nin adını(Company Name) ve çalışanın soyadını(employee's LastName). Her sütun başlığı doğru bir şekilde isimlendirilmeli. (16.789 kayıt göstermeli)

SELECT [Order].id,
       cu.companyname AS [Şirket İsmi],
       e.lastname AS [Çalışanın Soyismi]
  FROM [Order]
       JOIN
       customer AS cu ON cu.id = [Order].customerid
       JOIN
       employee AS e ON e.id = [Order].employeeid;



--! ESNEK GÖREVLER

-- Her gönderici tarafından gönderilen gönderi sayısını bulun.
SELECT c.CustomerName,Count(*) FROM [Orders] as o
JOIN Customers as c on o.CustomerID = c.CustomerID
GROUP BY o.CustomerId
ORDER BY Count(*) desc

-- Sipariş sayısına göre ölçülen en iyi performans gösteren ilk 5 çalışanı bulun.
SELECT e.FirstName, e.LastName, count(*) FROM [Orders] as o
join Employees as e on e.EmployeeId = o.EmployeeId
GROUP BY o.EmployeeId
order by Count(*) desc
limit(5)


-- Gelir olarak ölçülen en iyi performans gösteren ilk 5 çalışanı bulun.
SELECT od.ProductID,
       e.FirstName,
       e.LastName,
       Sum(od.Quantity * p.Price) AS [Siparis Tutarı]
  FROM OrderDetails AS od
       JOIN
       Orders AS o ON od.OrderID = o.OrderID
       JOIN
       Products AS p ON od.ProductID = p.ProductID
       JOIN
       Employees AS e ON e.EmployeeID = o.EmployeeID
 GROUP BY o.EmployeeId
 ORDER BY Sum(od.Quantity * p.Price) DESC
 LIMIT 5;



-- En az gelir getiren kategoriyi bulun.
SELECT c.CategoryName
       Sum(od.Quantity * p.Price) AS [Siparis Tutarı]
  FROM OrderDetails AS od
       JOIN
       Orders AS o ON od.OrderID = o.OrderID
       JOIN
       Products AS p ON od.ProductID = p.ProductID
       JOIN
       Categories AS c ON c.CategoryID = p.CategoryID
 GROUP BY o.EmployeeId
 ORDER BY Sum(od.Quantity * p.Price) asc
 LIMIT 1;



-- En çok siparişi olan müşteri ülkesini bulun.
SELECT c.CustomerName,c.Country, count(*) as "Siparis Sayısı" FROM [Orders] as o 
JOIN Customers as c on c.CustomerID = o.CustomerID
GROUP BY o.CustomerID
ORDER BY Count(*) desc
LIMIT 1