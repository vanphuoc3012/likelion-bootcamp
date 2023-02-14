CREATE TABLE CAMPUS (
    CampusID VARCHAR2(5) NOT NULL,
    CampusName VARCHAR2(100) NOT NULL,
    Street VARCHAR2(100) NOT NULL,
    City VARCHAR2(100) NOT NULL,
    State VARCHAR2(100) NOT NULL,
    Zip VARCHAR2(100) NOT NULL,
    Phone VARCHAR2(100) NOT NULL,
    CampusDiscount DECIMAL(2, 2) NOT NULL
);


CREATE TABLE POSITION (
    PositionID VARCHAR2(5) NOT NULL,
    POSITION VARCHAR2(100) NOT NULL,
    YearlyMembershipFee DECIMAL(7, 2) NOT NULL
);


CREATE TABLE MEMBERS (
    MemberID VARCHAR2(5) NOT NULL,
    LastName VARCHAR2(100) NOT NULL,
    FirstName VARCHAR2(100) NOT NULL,
    CampusAddress VARCHAR2(100) NOT NULL,
    CampusPhone VARCHAR2(100) NOT NULL,
    CampusID VARCHAR2(5) NOT NULL,
    PositionID VARCHAR2(5) NOT NULL,
    ContractDuration INTEGER NOT NULL
);


CREATE TABLE PRICES (
    FoodItemTypeID NUMBER(20) NOT NULL,
    MealType VARCHAR2(100) NOT NULL,
    MealPrice DECIMAL(7, 2) NOT NULL
);


CREATE TABLE FoodItems (
    FoodItemID VARCHAR2(5) NOT NULL,
    FoodItemName VARCHAR2(100) NOT NULL,
    FoodItemTypeID VARCHAR2(5) NOT NULL
);


CREATE TABLE Orders (
    OrderID VARCHAR2(5) NOT NULL,
    MemberID VARCHAR2(5) NOT NULL,
    OrderDate VARCHAR2(25) NOT NULL
);


CREATE TABLE OrderLine (
    OrderID VARCHAR2(5) NOT NULL,
    FoodItemsID VARCHAR2(5) NOT NULL UNIQUE,
    Quantity INTEGER NOT NULL
);


-- Primary key
ALTER TABLE CAMPUS ADD CONSTRAINT PK_CAMPUS PRIMARY KEY (CampusID);
ALTER TABLE POSITION ADD CONSTRAINT PK_POSITION PRIMARY KEY (PositionID);
ALTER TABLE MEMBERS ADD CONSTRAINT PK_MEMBERS PRIMARY KEY (MemberID);
ALTER TABLE PRICES ADD CONSTRAINT PK_PRICES PRIMARY KEY (FoodItemTypeID);
ALTER TABLE FoodItems ADD CONSTRAINT PK_FoodItems PRIMARY KEY (FoodItemID);
ALTER TABLE Orders ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID);
ALTER TABLE OrderLine ADD CONSTRAINT PK_OrderLine PRIMARY KEY (OrderID, FoodItemsID);


-- Foreign key
ALTER TABLE MEMBERS ADD CONSTRAINT FK_MEMBERS_POSITON FOREIGN KEY (PositionID) REFERENCES POSITION (PositionID);
ALTER TABLE FoodItems ADD CONSTRAINT FK_FoodItems_PRICES FOREIGN KEY (FoodItemTypeID) REFERENCES PRICES (FoodItemTypeID);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_MEMBERS FOREIGN KEY (MemberID) REFERENCES MEMBERS (MemberID);
ALTER TABLE OrderLine ADD CONSTRAINT FK_OrderLine_Orders FOREIGN KEY (OrderID) REFERENCES Orders (OrderID);
ALTER TABLE OrderLine ADD CONSTRAINT FK_OrderLine_FoodItems FOREIGN KEY (FoodItemsID) REFERENCES FoodItems (FoodItemID);


-- Seuqence
CREATE SEQUENCE Price_FoodItemTypeID_SEQ;


-- Campus;
INSERT INTO CAMPUS VALUES ('1', 'IUPUI', '425 University Blvd.','Indianapolis', 'IN', '46202', '317-274-4591',.08 ); 
INSERT INTO CAMPUS VALUES ('2', 'Indiana University', '107 S. Indiana Ave.','Bloomington', 'IN', '47405', '812-855-4848',.07 );
INSERT INTO CAMPUS VALUES ('3', 'Purdue University', '475 Stadium Mall Drive','West Lafayette', 'IN', '47907', '765-494-1776',.06 );

-- Position
INSERT INTO Position
VALUES ('1', 'Lecturer', 1050.50);
INSERT INTO Position
VALUES ('2', 'Associate Professor', 900.50);
INSERT INTO Position
VALUES ('3', 'Assistant Professor', 875.50);
INSERT INTO Position
VALUES ('4', 'Professor', 700.75);
INSERT INTO Position
VALUES ('5', 'Full Professor', 500.50);


-- Members
INSERT INTO Members
VALUES ('1', 'Ellen', 'Monk', '009 Purnell', '812-123-1234', '2', '5', 12);
INSERT INTO Members
VALUES ('2', 'Joe', 'Brady', '008 Statford Hall', '765-234-2345', '3', '2', 10);
INSERT INTO Members
VALUES ('3', 'Dave', 'Davidson', '007 Purnell', '812-345-3456', '2', '3', 10);
INSERT INTO Members
VALUES ('4', 'Sebastian', 'Cole', '210 Rutherford Hall', '765-234-2345', '3', '5', 10);
INSERT INTO Members
VALUES ('5', 'Michael', 'Doo', '66C Peobody', '812-548-8956', '2', '1', 10);
INSERT INTO Members
VALUES ('6', 'Jerome', 'Clark', 'SL 220', '317-274-9766', '1', '1', 12);
INSERT INTO Members
VALUES ('7', 'Bob', 'House', 'ET 329', '317-278-9098', '1', '4', 10);
INSERT INTO Members
VALUES ('8', 'Bridget', 'Stanley', 'SI 234', '317-274-5678', '1', '1', 12);
INSERT INTO Members
VALUES ('9', 'Bradley', 'Wilson', '334 Statford Hall', '765-258-2567', '3', '2', 10);


-- Prices
INSERT INTO Prices
VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Beer/Wine', 5.50);
INSERT INTO Prices
VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Dessert', 2.75);
INSERT INTO Prices
VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Dinner', 15.50);
INSERT INTO Prices
VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Soft Drink', 2.50);
INSERT INTO Prices
VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Lunch', 7.25);


-- FoodItems
INSERT INTO FoodItems
VALUES ('10001', 'Lager', '1');
INSERT INTO FoodItems
VALUES ('10002', 'Red Wine', '1');
INSERT INTO FoodItems
VALUES ('10003', 'White Wine', '1');
INSERT INTO FoodItems
VALUES ('10004', 'Coke', '4');
INSERT INTO FoodItems
VALUES ('10005', 'Coffee', '4');
INSERT INTO FoodItems
VALUES ('10006', 'Chicken a la King', '3');
INSERT INTO FoodItems
VALUES ('10007', 'Rib Steak', '3');
INSERT INTO FoodItems
VALUES ('10008', 'Fish and Chips', '3');
INSERT INTO FoodItems
VALUES ('10009', 'Veggie Delight', '3');
INSERT INTO FoodItems
VALUES ('10010', 'Chocolate Mousse', '2');
INSERT INTO FoodItems
VALUES ('10011', 'Carrot Cake', '2');
INSERT INTO FoodItems
VALUES ('10012', 'Fruit Cup', '2');
INSERT INTO FoodItems
VALUES ('10013', 'Fish and Chips', '5');
INSERT INTO FoodItems
VALUES ('10014', 'Angus and Chips', '5');
INSERT INTO FoodItems
VALUES ('10015', 'Cobb Salad', '5');

 
-- Orders
INSERT INTO Orders
VALUES ( '1', '9', 'March 5, 2005' );
INSERT INTO Orders
VALUES ( '2', '8', 'March 5, 2005' );
INSERT INTO Orders
VALUES ( '3', '7', 'March 5, 2005' );
INSERT INTO Orders
VALUES ( '4', '6', 'March 7, 2005' );
INSERT INTO Orders
VALUES ( '5', '5', 'March 7, 2005' );
INSERT INTO Orders
VALUES ( '6', '4', 'March 10, 2005' );
INSERT INTO Orders
VALUES ( '7', '3', 'March 11, 2005' );
INSERT INTO Orders
VALUES ( '8', '2', 'March 12, 2005' );
INSERT INTO Orders
VALUES ( '9', '1', 'March 13, 2005' );


-- OrderLine
INSERT INTO OrderLine
VALUES ( '1', '10001', 1 );
INSERT INTO OrderLine
VALUES ( '1', '10006', 1 );
INSERT INTO OrderLine
VALUES ( '1', '10012', 1 );
INSERT INTO OrderLine
VALUES ( '2', '10004', 2 );
INSERT INTO OrderLine
VALUES ( '2', '10013', 1 );
INSERT INTO OrderLine
VALUES ( '2', '10014', 1 );
INSERT INTO OrderLine
VALUES ( '3', '10005', 1 );
INSERT INTO OrderLine
VALUES ( '3', '10011', 1 );
INSERT INTO OrderLine
VALUES ( '4', '10005', 2 );
INSERT INTO OrderLine
VALUES ( '4', '10004', 2 );
INSERT INTO OrderLine
VALUES ( '4', '10006', 1 );
INSERT INTO OrderLine
VALUES ( '4', '10007', 1 );
INSERT INTO OrderLine
VALUES ( '4', '10010', 2 );
INSERT INTO OrderLine
VALUES ( '5', '10003', 1 );
INSERT INTO OrderLine
VALUES ( '6', '10002', 2 );
INSERT INTO OrderLine
VALUES ( '7', '10005', 2 );
INSERT INTO OrderLine
VALUES ( '8', '10005', 1 );
INSERT INTO OrderLine
VALUES ( '8', '10011', 1 );
INSERT INTO OrderLine
VALUES ( '9', '10001', 1 );
 
 
SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'CAMPUS';

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'POSITION';

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'MEMBERS';

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'PRICES';

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'FOODITEMS';

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'ORDERS';

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'ORDERLINE';

--Cau 2
SELECT owner,table_name FROM all_tables;
--Cach 2: SELECT table_name FROM user_tables;

-- Cau 3
SELECT sequence_name FROM user_sequences;

-- Cau 4
SELECT FirstName, LastName, Position, CampusName,  TO_CHAR(YearlyMembershipFee / 12, 'fm99D00') Monthly_Dues
FROM MEMBERS
    JOIN POSITION USING(PositionID)
    JOIN CAMPUS USING(CampusID)
ORDER BY 4 DESC, 2 ASC;