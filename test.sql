-- CREATE SALESTABLE 
CREATE TABLE SALETABLE( 
   SALESID   INT              NOT NULL, 
   ORDERID   INT              NOT NULL, 
   CUSTOMER     CHAR(25),
   PRODUCT      CHAR(25),
   DATE     DATE,
   QUANTITY   TINYINT         NOT NULL, 
   UNITPRICE  SMALLMONEY      NOT NULL,      
   PRIMARY KEY (SALESID));
-- INSERT RANDOM DATA IN SALESTABLE
DECLARE @cnt INT = 0;
WHILE @cnt < 40
BEGIN
   INSERT INTO SALETABLE(@cnt, SELECT FLOOR(RAND()*20, CONCAT('C', SELECT FLOOR(RAND()*9)), CONCAT('P', SELECT FLOOR(RAND()*6, SELECT FLOOR(RAND()*3, SELECT FLOOR(RAND()*6, SELECT FLOOR(RAND()*(400-100+1)+100);

   SET @cnt = @cnt + 1;
END;

-- CREATE SALEPROFIT TABLE

CREATE TABLE SALEPROFIT( 
   PRODUCT    CHAR(25)          NOT NULL, 
   PROFITRATIO   TINYINT        NOT NULL, 
   PRIMARY KEY (SALESID));

-- INSERT RANDOM DATA IN SALEPROFIT TABLE
SET @cnt = 0;

WHILE @cnt < 5
BEGIN
   INSERT INTO SALETABLE(CONCAT('P', @cnt), SELECT FLOOR(RAND()*20));

   SET @cnt = @cnt + 1;
END;

-- PART 1 : ALL OF COMPANY SOLD OUT
SELECT  SALEID, SUM(QUANTITY * UNITPRICE)
FROM    SALETABLE;

-- PART 2 :DISTINCT CUSTOME OF COMPANY
SELECT DISTINCT CUSTOMER
FROM    SALETABLE;

-- PART 3 : DISTINCT PRODUCT SOLD OUT 
SELECT PRODUCT, SUM(QUANTITY)
FROM    SALETABLE
GROUP BY PRODUCT;

-- PART 4 : INFORMATION ABOUT CUSTOMERS WHO BUY MORE THAN 1500
SELECT CUSTOMER, SUM(QUANTITY * UNITPRICE), COUNT(PRODUCT), SUM(QUANTITY)
FROM SALETABLE
GROUP BY CUSTOMER, ORDERID
HAVING SUM(QUANTITY * UNITPRICE) > 1500;

-- PART 5 : PROFIT COST  AND PERCENTAGE
SELECT SUM(SUM(ST.QUANTITY * ST.UNITPRICE) * SP.PROFITRATIO / 100), 100 - (SUM(SUM(ST.QUANTITY * ST.UNITPRICE) * SP.PROFITRATIO) / SUM(ST.QUANTITY * ST.UNITPRICE))
FROM SALETABLE AS ST
GROUP BY ST.PRODUCT
INNER JOIN SALEPROFIT AS SP
ON ST.PRODUCT = SP.PRODUCT
ORDER BY PRODUCT
--  PART 6 : COUT OF CUSTOMERS IN EACH DAY
SELECT DATE, CUSTOMER, COUNT(*)
from SALETABLE
GROUP BY DATE, CUSTOMER;

-- CREATE ORGANIZATIONCHART TABLE
CREATE ORGANIZATIONCHART( 
   ID   INT              NOT NULL, 
   NAME   CHAR(25)       NOT NULL, 
   MANAGER     CHAR(25),
   MANAGERID      INT,
   LEVEL    INT,
   PRIMARY KEY (SALESID));

-- INSERT MANGER INFORMATION WITH THEIR LEVEL
INSERT INTO CUSTOMERS (ID,NAME,MANAGER,MANAGERID) 
VALUES (1, 'KEN', NULL, NULL, NULL);
INSERT INTO CUSTOMERS (ID,NAME,MANAGER,MANAGERID) 
VALUES (2, 'HUGO',NULL, NULL, NULL);
INSERT INTO CUSTOMERS (ID,NAME,MANAGER,MANAGERID) 
VALUES (3, 'ALEX', 'KEN', 1), NULL;
INSERT INTO CUSTOMERS (ID,NAME,MANAGER,MANAGERID) 
VALUES (4, 'DYLAN', 'ALEX', 12, NULL);

INSERT INTO ORGANIZATION(ORGLEVEL)
VALUES(1)
WHERE ORGANIZITION.MANAGER IS NULL
VALUES(2)
WHERE ORGANIZITION.NAME INTERSECT ORGANIZITION.MANAGER
VALUES(3)
WHERE ORGANIZITION.ORGLEVEL IS NULL;