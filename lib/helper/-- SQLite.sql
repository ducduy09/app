
insert into products values ("prdA31", "sản phẩm 2-B", "assets/images/ImageOffice/SmartFI_Box2.png", 30000, 100, "10%", "27000", 100);
insert into products values ("prdA2", "sản phẩm 2", "assets/images/ImageOffice/L24YK_1.png", 30000, 100, "10%", "27000");
insert into products values ("prdA13", "sản phẩm 3", "assets/images/ImageOffice/Sensor_Final_1.png", 30000, 100, "10%", "27000");
insert into products values ("prdA4", "sản phẩm 4", "assets/images/ImageOffice/SmartFI_Box2.png", 30000, 100, "10%", "27000")
SELECT * FROM products WHERE productId = 'prdA1'

UPDATE linkParts
SET choose = 0
WHERE taskId = "t2.2";

UPDATE users 
SET wallet = 100000 - (SELECT wallet FROM users WHERE id = 1)
WHERE id = 1;

-- ALTER TABLE products insert column;

ALTER TABLE checkLists
       ADD COLUMN checkListJson text 

UPDATE products 
       SET new_column_name = CAST(old_column_name as new_data_type_you_want)

CREATE TABLE IF NOT EXISTS mkbParts(idMkbPart integer PRIMARY KEY, mkbPartName varchar(100), price double, tkVt integer, loaiVt integer, pad varchar(20), 
basicSupplies integer, dateCreate text default CURRENT_TIMESTAMP, creator varchar(20), dateEdit text default CURRENT_TIMESTAMP, editor varchar(20), idUnit integer, status integer, FOREIGN KEY (idUnit) REFERENCES units(idUnit))

CREATE TABLE IF NOT EXISTS units(idUnit integer PRIMARY KEY, unitName varchar(45));

CREATE TABLE IF NOT EXISTS userLogin(userId INTEGER PRIMARY KEY AUTOINCREMENT,userName TEXT,email TEXT,password TEXT, level integer, type Text)

Create table if not exists packageParts(idPackagePart integer primary key, packagePartName varchar(45), packagePartPin int);

Create table if not exists users(id integer primary key, avatar text, name text, age integer, address text);

Create table if not exists brands(idBrand integer primary key, brandName varchar(45), description text);

Create table if not exists mfrParts(idMfrPart integer PRIMARY KEY, idMkbPart integer, idBrand integer, mfrPartName varchar(100), description text,
idPackagePart integer, dataSheet varchar(45), reel integer, dateCreate text default CURRENT_TIMESTAMP, creator varchar(20), dateEdit text default CURRENT_TIMESTAMP, 
editor varchar(20), code varchar(50), status integer, FOREIGN KEY (idPackagePart) REFERENCES packageParts(idPackagePart), 
FOREIGN KEY (idBrand) REFERENCES brands(idBrand), FOREIGN KEY (idMkbPart) REFERENCES mkbParts(idMkbPart));

Create table if not exists linkParts(idLinkPart integer primary key AUTOINCREMENT, choose text, shopName varchar(30), link text, importPrice double, 
idMfrPart integer, prioritize int, FOREIGN KEY (idMfrPart) REFERENCES mfrParts(idMfrPart));

Create table if not exists customers(idCustomer integer primary key, idGroup integer, customerName varchar(45), phone varchar(15), address varchar(200), tax integer, description text, 
FOREIGN KEY (idGroup) REFERENCES customerGroup(idGroup));

Create table if not exists customerGroups(idGroup integer primary key, groupName varchar(45), profit varchar(45), priceSMD double,  priceDIP double, description text);

Create table if not exists checkLists(idCheckList integer primary key, idCustomer integer, checkListDate text, 
checker varchar(45), checkListJson text );

insert into mkbParts(idMkbPart, mkbPartName, price, tkVt, loaiVt, pad, basicSupplies, creator, editor, idUnit, status) values ("100003", "Part Name 3", 15000, 1001, 1, "Pad 2", 1, "Admin", "Admin",1,1)
-- SQLite

UPDATE linkParts SET prioritize = 2 WHERE idLinkPart = 13 
Drop table userLogin;
PRAGMA foreign_key_list(mkbParts);
delete from linkParts where taskId = 't2' and userId = 1
delete from checkLists where idCheckList = 3
delete from userLogin where userId = '5'
SELECT * FROM tasks WHERE userId = '2' and taskId like 't%' and taskId not like 't%.%'
select * from users
select * from userLogin
select * from mfrParts;
select * from linkParts;
select * from checkLists;

PRAGMA foreign_keys = ON

ALTER TABLE orders DROP CONSTRAINT productId;

SELECT * FROM users JOIN userLogin ON users.id = userLogin.userId;
Create table if not exists users(userId integer primary key autoincrement, name text, age integer, address text)

--insert data
INSERT INTO mkbParts (idMkbPart, mkbPartName, price, tkVt, loaiVt, pad, basicSupplies, creator, editor, idUnit, status)
VALUES (100004, 'Part 4', 10.50, 123, 456, 'Pad A', 1, 'John Doe', 'Jane Doe', 1, 1),
       (100005, 'Part 5', 15.75, 789, 101, 'Pad B', 0, 'Alice Smith', 'Bob Johnson', 2, 1),
       (100006, 'Part 6', 8.25, 202, 303, 'Pad C', 1, 'Eve Brown', 'Frank Davis', 3, 0);
INSERT INTO units (idUnit, unitName)
VALUES (1, 'Unit A'),
       (2, 'Unit B'),
       (3, 'Unit C');
INSERT INTO packageParts (idPackagePart, packagePartName, packagePartPin)
VALUES (1001, 'Package 1', 5),
       (1002, 'Package 2', 5),
       (1003, 'Package 3', 8);
INSERT INTO brands (idBrand, brandName, description)
VALUES (1, 'Brand A', 'Description A'),
       (2, 'Brand B', 'Description B'),
       (3, 'Brand C', 'Description C');
INSERT INTO mfrParts (idMfrPart, idMkbPart, idBrand, mfrPartName, description, idPackagePart, dataSheet, reel, creator, editor, code, status)
VALUES (4, 100002, 1, 'Mfr Part 4', 'Description 4', 1001, 'Datasheet A', 100, 'Alex Sandra', 'Jane Doe', 'Code A', 1),
       (5, 100004, 2, 'Mfr Part 5', 'Description 5', 1002, 'Datasheet B', 200, 'Vanhein', 'Bob Johnson', 'Code B', 0),
       (6, 100005, 3, 'Mfr Part 6', 'Description 6', 1002, 'Datasheet C', 150, 'Allain', 'Frank Davis', 'Code C', 1);
INSERT INTO linkParts (choose, shopName, link, importPrice, prioritize, idMfrPart)
VALUES ("đen, 3x4", 'Shop 1', 'http://shop1.com/part11', 2.99,2, 5),  -- sản phẩm 1 có 3 sản phẩm mức ưu tiên lần lượt và có ở 3 shop khác nhau
       ("xanh, 3x4", 'Shop 2', 'http://shop2.com/part12', 1.50,4, 5),
       ("vàng, 3x4", 'Shop 3', 'http://shop3.com/part13', 4.99,3, 5),
       ("đỏ, 6x8", 'Shop 5', 'http://shop5.com/part14', 15.50, 2, 6),  -- sản phẩm 2 có 1 link sản phẩm ở shop 2 
       ("xanh, 6x8", 'Shop 3', 'http://shop3.com/part15', 8.75,1, 6);  -- tương tự trên

insert into orders values ("abcd","prdA1", "1", 30000,"HY _ TQ", 10, 0);
insert into users values (1,"assets/images/p3.jpg", "Admin", 22,"HY _ TQ");


INSERT INTO checkLists (idCustomer, checkListDate, checker, checkListJson) VALUES
(1, '2023-09-13', 'John Doe', 
  '[{"code":1,"quantity":1,"idMfrPart":1,"mfrPartName":"Part name 1","idBrand":1,"brandName":"Brand 1","description":"Description 1","idMkbPart":100001},
    {"code":2,"quantity":10,"idMfrPart":1,"mfrPartName":"Part name 1","idBrand":1,"brandName":"Brand 1","description":"Description 1","idMkbPart":100002}]'
),
(2, '2023-09-13', 'Jane Doe',
  '[{"code":3,"quantity":1,"idMfrPart":3,"mfrPartName":"Part name 3","idBrand":1,"brandName":"Brand 1","description":"Description 1","idMkbPart":100003},
    {"code":4,"quantity":10,"idMfrPart":4,"mfrPartName":"Part name 4","idBrand":1,"brandName":"Brand 1","description":"Description 1","idMkbPart":100004}]'
);
-- view
SELECT mkbParts.idMkbPart, mkbPartName, pad, packagePartPin, prioritize, unitName, basicSupplies, price, importPrice, choose, link, brandName, mfrParts.description, mfrPartName, packagePartName
        FROM mkbParts
        LEFT JOIN mfrParts ON mkbParts.idMkbPart = mfrParts.idMkbPart
        LEFT JOIN units ON mkbParts.idUnit = units.idUnit
        JOIN packageParts ON mfrParts.idPackagePart = packageParts.idPackagePart
        JOIN linkParts ON mfrParts.idMfrPart = linkParts.idMfrPart
        JOIN brands ON mfrParts.idBrand = brands.idBrand
        where prioritize = 1
        GROUP By mkbParts.idMkbPart
-- change type column
ALTER TABLE linkParts RENAME TO linkParts_tmp;
Create table if not exists linkParts(idLinkPart integer primary key AUTOINCREMENT, choose text, shopName varchar(30), link text, importPrice double, 
idMfrPart integer, prioritize int, FOREIGN KEY (idMfrPart) REFERENCES mfrParts(idMfrPart));
INSERT INTO linkParts(idLinkPart, choose, shopName, link, importPrice, idMfrPart)
SELECT idLinkPart, choose, shopName, link, importPrice, idMfrPart FROM linkParts_tmp;
drop table linkParts_tmp;

SELECT * FROM checkLists WHERE checker LIKE '%John Doe%' and idCustomer = 1 and checkListDate = '2023-09-13'

SELECT * FROM linkParts WHERE idLinkPart = "" or idMfrPart =1
SELECT * FROM userLogin WHERE email = 'admin@gmail.com' and password = '123' and type = 'Admin' and status = 1