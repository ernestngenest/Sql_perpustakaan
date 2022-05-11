create database project_akhir
use project_akhir
use master
drop database project_akhir

CREATE TABLE MsEmployee (
 EmployeeID CHAR(5) not null,
 EmployeeName VARCHAR(50) not null, 
 EmployeePhone INT not null,
 EmployeeAddress VARCHAR(255) not null,
 EmployeeDOB date not null,
 EmployeeGender VARCHAR(255) not null,
 EmployeeSalary INT not null,
 EmployeeEmail VARCHAR(255) not null,
 CONSTRAINT check_Email CHECK (EmployeeEmail LIKE '%@Hallo.com'),
 CONSTRAINT check_EmployeeID CHECK (EmployeeID LIKE 'EM[0-9][0-9][0-9]'),
 CONSTRAINT check_Gender CHECK (EmployeeGender IN ('Male','Female')),
 CONSTRAINT pk_emp PRIMARY KEY(EmployeeID)
);

CREATE TABLE MsVendor(
 VendorID CHAR(5) not null,
 VendorName VARCHAR(255) not null,
 VendorPhone INT not null,
 VendorAddress VARCHAR(255) not null,
 VendorEmail VARCHAR(255) not null,
 VendorEstablishedYear INT not null,
 CONSTRAINT Check_VendorID CHECK (VendorID LIKE'VN[0-9][0-9][0-9]'),
 CONSTRAINT pk_Vendor PRIMARY KEY (VendorID),
 CONSTRAINT Check_VendorName CHECK (len(VendorName) > 3),
 CONSTRAINT Check_VendorEmail CHECK (VendorEmail LIKE '%.com'),
);

CREATE TABLE MsCustomer(
 CustomerID CHAR(5) not null,
 CustomerName VARCHAR(255) not null,
 CustomerPhone INT not null,
 CustomerEmail VARCHAR(255) not null,
 CustomerPassword VARCHAR(255),
 CustomerDOB date not null,
 CustomerGender VARCHAR(255),
 CONSTRAINT pk_CustomerID PRIMARY KEY (CustomerID),
 CONSTRAINT check_CustomerID CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
 CONSTRAINT check_CustomerEmail CHECK (CustomerEmail LIKE '%@Hallo.com'),
 CONSTRAINT check_CustomerGender CHECK (CustomerGender IN ('Male','Female'))
);

CREATE TABLE MsCategory(
 IdentificationID CHAR(5),
 CategoryName VARCHAR(255),
 CONSTRAINT pk_IdentificationID PRIMARY KEY (IdentificationID),
 CONSTRAINT check_Identification CHECK (IdentificationID LIKE 'CT[0-9][0-9][0-9]'),
 CONSTRAINT check_CategoryName CHECK (CategoryName NOT IN('Amidopyrine','Phenacetin','Methaqualone'))
);

CREATE TABLE trSalesMedicineDetail(
 SalesDetailID CHAR(5) not null,
 identificationID char(5) not null,
 MedicineName VARCHAR(255) not null,
 MedicinePrice INT not null,
 MedicineDescription VARCHAR(255) not null,
 stock int not null,
 CONSTRAINT pk_Sales PRIMARY KEY (SalesDetailID),
 CONSTRAINT check_SalesID CHECK (SalesDetailID LIKE 'MD[0-9][0-9][0-9]'),
 CONSTRAINT ck_SlMedicinePrice CHECK (MedicinePrice BETWEEN 5000 AND 100000),
 constraint fk_identificationID foreign key (identificationID) references MsCategory(identificationID)
);


create table trSalesTransaction (
	SalesID char (5) not  null,
	EmployeeID char(5) not null,
	SalesDetailID char (5) not null, 
	CustomerID char(5) not null,
	TransactionDate date not null,
	Quantity int not null,
	constraint pk_salesID primary key (SalesID), 
	constraint fk_EmployeeID foreign key (EmployeeID) references MsEmployee(EmployeeID),
	constraint fk_SalesDetailID foreign key (SalesDetailID) references trSalesmedicineDetail(SalesDetailID),
	constraint fk_CostumerID foreign key (CustomerID) references MsCustomer(CustomerID),
	constraint ck_SalesID check ( SalesID like 'SL[0-9][0-9][0-9]')
)



CREATE TABLE trPurchaseMedicineDetail (
 PurchaseDetailID CHAR(5) NOT NULL,
 IdentificationID CHAR(5) NOT NULL,
 MedicineName Varchar(255) NOT NULL,
 MedicinePrice INT NOT NULL,
 MedicineDescriptions varchar(255) NOT NULL,
 MedicineStock INT NOT NULL,

 CONSTRAINT pk_purchaseDetailID PRIMARY KEY (PurchaseDetailID),
 CONSTRAINT fk_IdentificationID2 FOREIGN KEY (IdentificationID) REFERENCES MsCategory(IdentificationID),
 CONSTRAINT ck_purchaseDetailId check(PurchaseDetailID like 'MD[0-9][0-9][0-9]'),
 CONSTRAINT ck_MedicinePrice CHECK (MedicinePrice BETWEEN 5000 AND 100000) 
)

Create table trPurchaseTransaction(
	PurchaseID char(5) not null ,
	EmployeeID char (5) not null,
	VendorID char (5) not null,
	PurchaseDetailID char(5) not null ,
	TransactionDate date not null,
	Quantity int not null,
	Constraint pk_purchaseID primary key (PurchaseID),
	constraint fk_employeeId2 foreign key (EmployeeID) references MsEmployee(EmployeeID) ,
	constraint fk_vendorID foreign key (VendorId) references MsVendor(VendorId),
	constraint fk_PurchaseDetail foreign key (PurchaseDetailID) references trPurchaseMedicineDetail(PurchaseDetailID),
	constraint ck_purchaseId check(PurchaseID like 'PC[0-9][0-9][0-9]')
)

INSERT INTO MsEmployee VALUES 
('EM001','Ceka Wijaya',11111,'0975 Forest Dale Trail','2002-2-1','Male',3500000,'Cekawijaya@Hallo.com'),
('EM002','Kenny',22222,'92 Sugar Alley','2002-3-16','Male',2900000,'Kennyetiawan@Hallo.com'),
('EM003','Bella Putri',33333,'577 Dovetail Park','2001-5-12','Female',4000000,'Bellaputri@Hallo.com'),
('EM004','William Setiadi',44444,'811 Debs Street','2002-7-1','Male',3500000,'Williamsetiadi@Hallo.com'),
('EM005','Tifanny Drisella',55555,'389 Surrey Pass','2001-1-15','Female',5000000,'Tifannydrisella@Hallo.com'),
('EM006','Mike Cleon',66666,'7 Melby Trail','2001-12-12','Male',2500000,'Mikecleon@Hallo.com'),
('EM007','Chen',77777,'19269 Maryland Hill','2002-3-19','Male',3600000,'Chenlong@Hallo.com'),
('EM008','Annabella Jesslyn',88888,'8 Moulton Point','2003-11-20','Female',4500000,'Annabellajesslyn@Hallo.com'),
('EM009','Gon Cuy Mok',99999,'21840 Golden Leaf Avenue','2001-7-26','Male',4560000,'Goncuymok@Hallo.com'),
('EM010','Mythia Sari',10101,'70 Eagle Crest Hill','2003-1-12','Female',4000000,'Mythiasari@Hallo.com'),
('EM011','Christabel Clarista',12121,'20196 Springview Plaza','2002-2-16','Female',3700000,'Christabelclarista@Hallo.com'),
('EM012','Aldo Chung',13131,'2263 Weeping Birch Center','2003-9-11','Male',3000000,'Aldochung@Hallo.com'),
('EM013','Rey Nardo',14141,'920 Bobwhite Trail','2000-12-11','Male',3200000,'Reynardo@Hallo.com'),
('EM014','Roy Kimochi',15151,'47 Darwin Terrace','2003-2-17','Male',3500000,'Roykimochi@Hallo.com'),
('EM015','Berliana Lovel',16161,'49 6th Junction','2001-12-21','Female',4530000,'Berlianalovel@Hallo.com')

INSERT INTO MsVendor VALUES
('VN001','Mitri Medic',17171,'74 Melvin Point','MitriMedic@mart.com',2004),
('VN002','Prim Indo',18181,'2 Grayhawk Parkway','PrimIndo@mart.com',2002),
('VN003','Kebayoran Medica',19191,'905 Goodland Lane','KebayoranMedica@mart.com',2002),
('VN004','Bina Prima',20202,'51745 Bowman Hill','BinaPrima@mart.com',2001),
('VN005','Buana Medica',21211,'848 New Castle Center','BuanaMedica@mart.com',2005),
('VN006','IndoRoh',22232,'3455 Village Green Court','IndoRoh@mart.com',2006),
('VN007','Kimilung Medic',23232,'772 Goodland Park','KimilungMedic@mart.com',2002),
('VN008','Bina Pharma',24242,'1 Merchant Street','BinaPharma@mart.com',2006),
('VN009','Tempo Farma',25252,'31718 Toban Point','TempoFarma@mart.com',2010),
('VN010','Febmedic',26262,'936 Lyons Plaza','Febmedic@mart.com',2009),
('VN011','Sin Medic',27272,'10787 School Drive','SinMedic@mart.com',2011),
('VN012','Parit Pharma',28282,'8 Lien Junction','ParitPharma@mart.com',2014),
('VN013','Bandung Prima',29292,'4 Dapin Avenue','BandungPrima@mart.com',1998),
('VN014','Kinmedic',30303,'2 Veith Terrace','Kinmedic@mart.com',2008),
('VN015','Winmedic',31313,'2 Hermina Park','Winmedic@mart.com',2013)

INSERT INTO MsCustomer VALUES 
('CU001','Robby',32323,'robby@Hallo.com','robby01','2005-2-14','Male'),
('CU002','Kenny',34343,'kenny@Hallo.com','kenny02','2002-3-24','Male'),
('CU003','Serina',35353,'serina@Hallo.com','serina03','2003-3-3','Female'),
('CU004','Michelle',36363,'michelle@Hallo.com','michelle04','2002-11-2','Female'),
('CU005','Naftali',37373,'naftali@Hallo.com','naftali05','2003-12-14','Female'),
('CU006','Philip',38383,'philip@Hallo.com','philip06','2002-10-14','Male'),
('CU007','Saputra',39393,'saputra@Hallo.com','saputra07','2002-4-21','Male'),
('CU008','Rose',40404,'rose@Hallo.com','rose08','2004-6-3','Female'),
('CU009','Rikka',41414,'rika@Hallo.com','rika09','2004-12-14','Female'),
('CU010','Hugo',42424,'hugo@Hallo.com','hugo10','2001-2-22','Male'),
('CU011','Adriel',45454,'adriel@Hallo.com','adriel11','2001-8-14','Male'),
('CU012','Daniel',46464,'daniel@Hallo.com','daniel12','2004-4-12','Male'),
('CU013','Vindy',47474,'vindy@Hallo.com','vindy13','2001-9-16','Female'),
('CU014','Vicky',48484,'vicky@Hallo.com','vicky14','2002-11-13','Male'),
('CU015','John',49494,'john@Hallo.com','john15','2005-10-15','Male')

INSERT INTO MsCategory VALUES
('CT001','obat penenang'),
('CT002','obat anti miskin'),
('CT003','obat infus'),
('CT004','obat pusing'),
('CT005','obat maag'),
('CT006','obat batuk'),
('CT007','obat pilek'),
('CT008','obat panas'),
('CT009','obat sariawan'),
('CT010','obat menstruasi'),
('CT011','obat diare'),
('CT012','obat sakit mata'),
('CT013','obat rambut'),
('CT014','obat luar badan' ),
('CT015','obat gatal')

Insert into trPurchaseMedicineDetail values 
('MD001','CT008','MARGENZA',100000,'Lorem ipsum dolor sit amet',3),
('MD002','CT003','Isotretinoin',34000,'Lorem ipsum dolor sit amet',2),
('MD003','CT005','Escitalopram',60000,'Lorem ipsum dolor sit ame',9),
('MD004','CT012','Rivastigmine',8500,'Lorem ipsum dolor sit ame',7),
('MD005','CT015','Indomethacin',40000,'Lorem ipsum dolor sit ame',3),
('MD006','CT007','Isoxsuorine HCI',83092,'Lorem ipsum dolor sit ame',4),
('MD007','CT013','Zolpidem',90000,'Lorem ipsum dolor sit ame',3),
('MD008','CT011','Verapamil',40099,'Lorem ipsum dolor sit ame',6),
('MD009','CT005','Vasopressin',20000,'Lorem ipsum dolor sit ame',4),
('MD010','CT003','Galantamine',90099,'Lorem ipsum dolor sit ame',4),
('MD011','CT002','Glimepiride',24499,'Lorem ipsum dolor sit ame',3),
('MD012','CT012','Ketoprofen',29099,'Lorem ipsum dolor sit ame',1),
('MD013','CT003','Kloramfenikol',10299,'Lorem ipsum dolor sit ame',8),
('MD014','CT014','Ketorolac',10222,'Lorem ipsum dolor sit ame',7),
('MD015','CT014','Kloramfenikol',15222,'Lorem ipsum dolor sit ame',7),
('MD016','CT008','Isoniazid',15000,'Lorem ipsum dolor sit amet',20),
('MD017','CT004','Salmeterol',20500,'Lorem ipsum dolor sit amet',15),
('MD018','CT010','Estazolam',64000,'Lorem ipsum dolor sit amet',10),
('MD019','CT012','Estrogen',84700,'Lorem ipsum dolor sit amet',7),
('MD020','CT002','Betametason',50300,'Lorem ipsum dolor sit amet',35),
('MD021','CT005','Ketamine',44900,'Lorem ipsum dolor sit amet',10),
('MD022','CT006','Insulin',55000,'Lorem ipsum dolor sit amet',4),
('MD023','CT007','Simvastatin',62700,'Lorem ipsum dolor sit amet',12),
('MD024','CT011','Kaolin',35000,'Lorem ipsum dolor sit amet',8),
('MD025','CT014','Bromelain',35200,'Lorem ipsum dolor sit amet',34)
 
insert into trSalesMedicineDetail values
('MD001','CT008','MARGENZA',100000,'Lorem ipsum dolor sit amet',3),
('MD002','CT003','Isotretinoin',34000,'Lorem ipsum dolor sit amet',2),
('MD003','CT005','Escitalopram',60000,'Lorem ipsum dolor sit ame',9),
('MD004','CT012','Rivastigmine',8500,'Lorem ipsum dolor sit ame',7),
('MD005','CT015','Indomethacin',40000,'Lorem ipsum dolor sit ame',3),
('MD006','CT007','Isoxsuorine HCI',83092,'Lorem ipsum dolor sit ame',4),
('MD007','CT013','Zolpidem',90000,'Lorem ipsum dolor sit ame',3),
('MD008','CT011','Verapamil',40099,'Lorem ipsum dolor sit ame',6),
('MD009','CT005','Vasopressin',20000,'Lorem ipsum dolor sit ame',4),
('MD010','CT003','Galantamine',90099,'Lorem ipsum dolor sit ame',4),
('MD011','CT002','Glimepiride',24499,'Lorem ipsum dolor sit ame',3),
('MD012','CT012','Ketoprofen',29099,'Lorem ipsum dolor sit ame',1),
('MD013','CT003','Kloramfenikol',10299,'Lorem ipsum dolor sit ame',8),
('MD014','CT014','Ketorolac',10222,'Lorem ipsum dolor sit ame',7),
('MD015','CT014','Kloramfenikol',15222,'Lorem ipsum dolor sit ame',7),
('MD016','CT008','Isoniazid',15000,'Lorem ipsum dolor sit amet',20),
('MD017','CT004','Salmeterol',20500,'Lorem ipsum dolor sit amet',15),
('MD018','CT010','Estazolam',64000,'Lorem ipsum dolor sit amet',10),
('MD019','CT012','Estrogen',84700,'Lorem ipsum dolor sit amet',7),
('MD020','CT002','Betametason',50300,'Lorem ipsum dolor sit amet',35),
('MD021','CT005','Ketamine',44900,'Lorem ipsum dolor sit amet',10),
('MD022','CT006','Insulin',55000,'Lorem ipsum dolor sit amet',4),
('MD023','CT007','Simvastatin',62700,'Lorem ipsum dolor sit amet',12),
('MD024','CT011','Kaolin',35000,'Lorem ipsum dolor sit amet',8),
('MD025','CT014','Bromelain',35200,'Lorem ipsum dolor sit amet',34)

insert into trSalesTransaction values
('SL001','EM004','MD017','CU010','2021-1-14',5),
('SL002','EM015','MD023','CU014','2021-7-2',6),
('SL003','EM015','MD025','CU014','2021-3-25',4),
('SL004','EM002','MD024','CU015','2021-4-17',2),
('SL005','EM004','MD020','CU011','2021-5-18',35),
('SL006','EM007','MD014','CU012','2021-6-19',34),
('SL007','EM011','MD013','CU011','2021-7-20',67),
('SL008','EM015','MD011','CU014','2021-5-21',2),
('SL009','EM014','MD007','CU004','2021-2-2',3),
('SL010','EM011','MD005','CU008','2021-2-23',7),
('SL011','EM004','MD006','CU005','2021-4-24',25),
('SL012','EM006','MD002','CU003','2021-3-25',14),
('SL013','EM006','MD004','CU006','2021-4-26',56),
('SL014','EM008','MD008','CU006','2021-5-27',57),
('SL015','EM012','MD021','CU009','2021-7-28',69)

insert into trPurchaseTransaction values
('PC001','EM001','VN015','MD002','2020-1-28',15),
('PC002','EM012','VN013','MD005','2020-2-13',2),
('PC003','EM005','VN004','MD006','2020-2-20',3),
('PC004','EM013','VN001','MD013','2020-3-28',7),
('PC005','EM007','VN014','MD014','2020-4-11',10),
('PC006','EM006','VN004','MD009','2020-4-12',6),
('PC007','EM002','VN002','MD007','2020-5-5',24),
('PC008','EM005','VN005','MD005','2020-5-19',13),
('PC009','EM014','VN001','MD010','2020-6-25',5),
('PC010','EM015','VN012','MD011','2020-7-15',16),
('PC011','EM008','VN003','MD014','2020-7-16',17),
('PC012','EM003','VN001','MD003','2020-8-25',14),
('PC013','EM001','VN007','MD004','2020-10-4',56),
('PC014','EM011','VN001','MD003','2020-11-5',20),
('PC015','EM010','VN011','MD005','2020-12-29',45)

--d
--TRANSACTION FRAM STAFF TO CUSTOMER
	--begin tran
	--customer applying to be member 
		insert into MsCustomer values
		('CU016','anonim','0938302','anonim@Hallo.com','12sm21','2005-2-14','male')
		save tran point1
	--customere buying items 
		
	--staff make update for trSalesTransaction 
	--begin tran 
	go
		create or alter trigger triger_SalesTransaction
		on trSalesTransaction 
		for insert 
		as
		set nocount on 
		if exists(select * from inserted)
				declare @id_trSalesTransaction char(5)
				declare @stock_of_trSalesTransaction int
				declare @new_stock varchar(255),@old_stock varchar(255)
				select @id_trSalesTransaction = SalesDetailID from inserted
				select @stock_of_trSalesTransaction = Quantity from inserted 
				set @old_stock = (select stock from trSalesMedicineDetail where SalesDetailID = @id_trSalesTransaction)
				save tran point2
				--staff update trSalesMedicineDetail 
				update trSalesMedicineDetail
				set stock =- @stock_of_trSalesTransaction
				where SalesDetailID = @id_trSalesTransaction
				save tran point3
				set @new_stock = (select stock from trSalesMedicineDetail where SalesDetailID = @id_trSalesTransaction)
				print ( 'old stock : ' + @old_stock + ' new stock: ' + @new_stock)



		insert into trSalesTransaction values
		('SL030','EM014','MD012','CU013','2021-5-21',2)
	
	
	select * from trSalesTransaction
--commit



--TRANSACTION FROM STAFF TO VENDOR 
	--begin tran 
		--staff got new vendor 
		go
		insert into MsVendor values 
		('VN020','Janmart',18181,'2 Grayhawk Parkway','janmart@mart.com',2002)
		save tran point1
		--staff make trPurchaseTransaction 
		go
		create or alter trigger trigger_PurchaseTransaction
		on trPurchaseTransaction 
		for insert 
		as 			
		set nocount on 
			if exists(select * from inserted)
				declare @id_trPurchaseTransaction char(5)
				declare @stock_PurchaseTransaction int 
				declare @new_stock varchar(255),@old_stock varchar(255)
				select @id_trPurchaseTransaction = PurchaseDetailID from inserted 
				select @stock_PurchaseTransaction = Quantity from inserted
				set @old_stock = (select  MedicineStock from trPurchaseMedicineDetail where PurchaseDetailID = @id_trPurchaseTransaction) 
				-- staff update purchase medicine detail 
				update trPurchaseMedicineDetail
				set MedicineStock += @stock_PurchaseTransaction
				where PurchaseDetailID = @id_trPurchaseTransaction
				set @new_stock = (select  MedicineStock from trPurchaseMedicineDetail where PurchaseDetailID = @id_trPurchaseTransaction) 
				print ( 'old stock : ' + @old_stock + ' new stock: ' + @new_stock)

				
		insert into trPurchaseTransaction values
		('PC018','EM012','VN005','MD006','2005-2-28',3)
		save tran point4
commit 
