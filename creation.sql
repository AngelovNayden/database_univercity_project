﻿-- Създаване на база данни
CREATE DATABASE CorporateDB;
GO

USE CorporateDB;
GO

-- Създаване на таблици

CREATE TABLE city (
    NAME VARCHAR(50) PRIMARY KEY,
    STATE VARCHAR(10)
);

CREATE TABLE store (
    NUMBER INT PRIMARY KEY,
    CITY VARCHAR(50) NOT NULL,
    FOREIGN KEY (CITY) REFERENCES city(NAME)
);

CREATE TABLE dept (
    NUMBER INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    STORE INT NOT NULL,
    FLOOR INT,
    MANAGER INT,
    FOREIGN KEY (STORE) REFERENCES store(NUMBER)
);

CREATE TABLE employee (
    NUMBER INT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    SALARY DECIMAL(10, 2),
    MANAGER INT,
    BIRTHYEAR INT,
    STARTYEAR INT,
    FOREIGN KEY (MANAGER) REFERENCES employee(NUMBER)
);

ALTER TABLE dept
ADD CONSTRAINT FK_DEPT_MANAGER
FOREIGN KEY (MANAGER) REFERENCES employee(NUMBER);

CREATE TABLE supplier (
    NUMBER INT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    CITY VARCHAR(50),
    FOREIGN KEY (CITY) REFERENCES city(NAME)
);

CREATE TABLE item (
    NUMBER INT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    DEPT INT,
    PRICE DECIMAL(10, 2),
    QOH INT,
    SUPPLIER INT,
    FOREIGN KEY (DEPT) REFERENCES dept(NUMBER),
    FOREIGN KEY (SUPPLIER) REFERENCES supplier(NUMBER)
);

CREATE TABLE parts (
    NUMBER INT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    COLOR VARCHAR(50),
    WEIGHT DECIMAL(10, 2),
    QOH INT
);

CREATE TABLE debit (
    NUMBER INT PRIMARY KEY,
    SDATE DATE NOT NULL,
    EMPLOYEE INT,
    ACCOUNT VARCHAR(20),
    FOREIGN KEY (EMPLOYEE) REFERENCES employee(NUMBER)
);

CREATE TABLE sale (
    DEBIT INT,
    ITEM INT,
    QUANTITY INT NOT NULL,
    PRIMARY KEY (DEBIT, ITEM),
    FOREIGN KEY (DEBIT) REFERENCES debit(NUMBER),
    FOREIGN KEY (ITEM) REFERENCES item(NUMBER)
);

CREATE TABLE supply (
    SUPPLIER INT,
    PART INT,
    SHIPDATE DATE,
    QUANTITY INT,
    PRIMARY KEY (SUPPLIER, PART, SHIPDATE),
    FOREIGN KEY (SUPPLIER) REFERENCES supplier(NUMBER),
    FOREIGN KEY (PART) REFERENCES parts(NUMBER)
);