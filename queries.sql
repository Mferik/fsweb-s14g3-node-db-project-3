-- Multi-Table Sorgu Pratiği

-- Tüm ürünler(product) için veritabanındaki ProductName ve CategoryName'i listeleyin. (77 kayıt göstermeli)

SELECT ProductName,
       CategoryName
  FROM product AS p
       JOIN
       category AS c ON p.categoryid = c.id;



-- 9 Ağustos 2012 öncesi verilmiş tüm siparişleri(order) için sipariş id'si (Id) ve gönderici şirket adını(CompanyName)'i listeleyin. (429 kayıt göstermeli)

SELECT [order].id,
       customer.CompanyName
  FROM [Order]
       JOIN
       customer ON customer.id = [order].customerid
 WHERE orderdate < '2012-08-09';



-- Id'si 10251 olan siparişte verilen tüm ürünlerin(product) sayısını ve adını listeleyin. ProdcutName'e göre sıralayın. (3 kayıt göstermeli)
SELECT product.productname AS [Ürün İsmi],
       count( * ) AS [Ürün Sayısı]
  FROM orderdetail
       JOIN
       product ON orderdetail.productid = product.id
 WHERE orderid = 10251
 GROUP BY orderdetail.productid;



-- Her sipariş için OrderId, Müşteri'nin adını(Company Name) ve çalışanın soyadını(employee's LastName). Her sütun başlığı doğru bir şekilde isimlendirilmeli. (16.789 kayıt göstermeli)

SELECT [order].id,
       customer.companyname,
       employee.lastname
  FROM [Order]
       JOIN
       customer ON customer.id = [order].customerid
       JOIN
       employee ON employee.id = [order].employeeid;
