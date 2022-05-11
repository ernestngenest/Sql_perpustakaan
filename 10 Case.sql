 
use project_akhir
use master

 --1
SELECT [Customer ID] = msc.CustomerID, 
		[Customer Name] = msc.CustomerName,
		[Transaction Date] = CONVERT(CHAR(15), tst.TransactionDate, 107),
		[Medicine Bought] = SUM(tst.Quantity),
		[Customer Gender] = msc.CustomerGender
FROM trSalesTransaction tst
JOIN MsCustomer msc ON msc.CustomerID = tst.CustomerID
WHERE DAY(tst.TransactionDate) between '20' and '30' and msc.CustomerGender = 'Female'
GROUP BY tst.TransactionDate, msc.CustomerID, msc.CustomerName, msc.CustomerGender;


--2 
SELECT [Employee Number] = RIGHT (mse.EmployeeID, 3), 
		[Employee Name] = mse.EmployeeName, 
		[Employee Gender] = mse.EmployeeGender,
		[Customer Served] = CAST(COUNT(tst.CustomerID) AS VARCHAR(15)) + ' customer(s)'
FROM MsEmployee mse
join trSalesTransaction tst ON mse.EmployeeID = tst.EmployeeID
WHERE mse.EmployeeName LIKE '%b%' AND mse.EmployeeGender = 'Female'
GROUP BY mse.EmployeeID, mse.EmployeeName, mse.EmployeeGender;


--3
SELECT [Transaction Date] = tst.TransactionDate, [Employee ID] = tst.EmployeeID, 
		[Customer ID] = msc.CustomerID, [Customer Name] = msc.CustomerName, 
		[Date Of Birth] = CONVERT(CHAR(15), msc.CustomerDOB, 106), 
		[Transaction Count] = COUNT(tst.SalesID), tst.Quantity, [Medicine Price] = tsmd.MedicinePrice, 
		[Total Purchase] = tsmd.MedicinePrice * tst.Quantity
FROM trSalesMedicineDetail tsmd 
	JOIN trSalesTransaction tst ON tsmd.SalesDetailID = tst.SalesDetailID
	JOIN MsCustomer msc ON msc.CustomerID = tst.CustomerID
	JOIN MsEmployee mse ON mse.EmployeeID = tst.EmployeeID
WHERE tst.EmployeeID IN ('EM004', 'EM006', 'EM008') and MONTH(tst.TransactionDate) between '1' and '6'
GROUP BY tst.TransactionDate, tst.EmployeeID,msc.CustomerID, msc.CustomerName, msc.CustomerDOB,
		tst.Quantity, tsmd.MedicinePrice, mse.employeeID
ORDER BY mse.employeeID;


--4
SELECT [Transaction Date] = tpt.TransactionDate, 
		[Vendor Established Year] = msv.VendorEstablishedYear,
		[Employee ID] = mse.EmployeeID, 
		[Employee Name] = mse.EmployeeName,  
		[Local Phone Number] = STUFF(mse.EmployeePhone, 1, 2, '62'),
		[Transaction Done] = COUNT(tpt.EmployeeID), 
		[Total Medicine Bought] = CAST(SUM(tpt.Quantity) AS VARCHAR(15)) + ' item(s)'
FROM trPurchaseTransaction tpt
	JOIN MsEmployee mse ON mse.EmployeeID = tpt.EmployeeID
	JOIN MsVendor msv ON tpt.VendorID = msv.VendorID 
WHERE DAY(tpt.TransactionDate) BETWEEN '10' and '20' AND msv.VendorEstablishedYear > 2000
GROUP BY tpt.TransactionDate, mse.EmployeeID, mse.EmployeeName, mse.EmployeePhone, msv.VendorEstablishedYear;


--5
SELECT [Numeric Medicine ID] = RIGHT(tpmd.IdentificationID,3), 
  [Medicine Name] = UPPER(MedicineName),
  [Category Name] = CategoryName,
  [Price] = CONCAT('Rp. ' , MedicinePrice),
  [MedicineStock] = MedicineStock
  
FROM trPurchaseMedicineDetail tpmd 
	JOIN MsCategory mc ON mc.IdentificationID = tpmd.IdentificationID 

WHERE MedicinePrice > 50000 AND 
 MedicineStock < (SELECT AVG(tst.Quantity) AS AVGquantity FROM trSalesTransaction tst) 
 

--6
SELECT [Employee Code] = STUFF(me.EmployeeID,1,2,'EMPLOYEE'), 
		[Employee Name] = EmployeeName,
		[Transaction Date] = CONVERT(VARCHAR,TransactionDate,103), 
		[Medicine Name] = MedicineName, 
		[Medicine Price] = MedicinePrice, 
		Quantity
FROM MsEmployee me 
	JOIN trSalesTransaction tst ON tst.EmployeeID = me.EmployeeID 
	JOIN trSalesMedicineDetail tsmd ON tsmd.SalesDetailID = tst.SalesDetailID

WHERE DAY(TransactionDate) = 2 AND 
EmployeeSalary < (SELECT AVG(me.EmployeeSalary) AS AVGSalary FROM MsEmployee me)

--7
SELECT [Customer ID] = mc.CustomerID,
		[Customer Name] = CustomerName,
		[Local Customer Phone] = STUFF(mc.CustomerPhone,1,2,'62'),
		[Date Of Birth] = CONVERT(VARCHAR,mc.CustomerDOB,107),
		[Medicine Bought] = CAST(SUM(tst.Quantity) AS VARCHAR(15)) + ' item(s)'

FROM MsCustomer mc JOIN trSalesTransaction tst
ON tst.CustomerID = mc.CustomerID

WHERE CustomerGender != 'Male' AND 
Quantity > (SELECT AVG(tst.Quantity)
	AS AVGtstquantity 
	FROM trSalesTransaction tst)
GROUP BY mc.CustomerID,mc.CustomerName, mc.CustomerPhone,mc.CustomerDOB


--8
SELECT [Employee ID] = mse.EmployeeID, 
		[Employee Name] = LEFT(mse.EmployeeName, CHARINDEX (' ', mse.EmployeeName)), 
		[Salary] = CONCAT('Rp. ', mse.EmployeeSalary),
		[Date Of Birth] = CONVERT(CHAR(15), mse.EmployeeDOB, 107),
		[Transaction Served] = COUNT(tst.SalesID)
FROM MsEmployee mse 
	JOIN trSalesTransaction tst ON mse.EmployeeID = tst.EmployeeID,
	(SELECT [Transaction Served] = AVG(t.[Total Transaction])
	 FROM(
		SELECT [Total Transaction] = CAST(COUNT(trSalesTransaction.EmployeeID) AS int)
		FROM MsEmployee
		JOIN trSalesTransaction ON MsEmployee.EmployeeID = trSalesTransaction.EmployeeID
		WHERE MsEmployee.EmployeeName like ('% %')
		GROUP BY trSalesTransaction.EmployeeID
		 ) AS t 
	) AS average 
GROUP BY mse.EmployeeID, mse.EmployeeName, mse.EmployeeSalary, mse.EmployeeDOB, 
		 tst.EmployeeID, average.[Transaction Served]
HAVING COUNT([Transaction Served])  >  (average.[Transaction Served]);

--9
CREATE view VendorMaximumAverageQuantityViewer as
SELECT v.VendorID,
	v.VendorName,
	concat(AVG(td.MedicineStock),' item(s)')as 'Average Supplied Quantity',
	concat(max(td.MedicineStock), ' item(s)') as 'Maximum Supplied Quantity' 
from 
	MsVendor v 
	JOIN trPurchaseTransaction tr 
	ON v.VendorID = tr.VendorID 
	JOIN trPurchaseMedicineDetail td 
	ON td.PurchaseDetailID = tr.PurchaseDetailID
GROUP by v.VendorID,v.VendorName
HAVING max(td.MedicineStock)>5 and v.VendorName like ('%a%')

-- 10

CREATE VIEW VendorSupplyViewer as
SELECT 'Vendor Number' = right(v.VendorID,3) ,
v.VendorName,v.VendorAddress ,
'Total Supplied Value '= CONCAT('Rp. ',(SUM(td.MedicinePrice*tr.Quantity) )),
'Medicine Type Supplied '= CONCAT(COUNT(td.MedicineStock),' medicine(s)')
FROM MsVendor v 
	JOIN trPurchaseTransaction tr
	ON v.VendorID = tr.VendorID 
	JOIN trPurchaseMedicineDetail td 
	ON td.PurchaseDetailID = tr.PurchaseDetailID
WHERE td.MedicinePrice > 150000
GROUP BY v.VendorID,v.VendorName,v.VendorAddress
HAVING COUNT(td.MedicineStock) < 2

