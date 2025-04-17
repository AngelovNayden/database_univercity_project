USE CorporateDB;
GO

-- 1) Извеждане на списъка на всички служители
SELECT * FROM employee;

-- 2) Извеждане на служителите, които получават заплати между 10 000 и 12 000
SELECT * FROM employee 
WHERE SALARY BETWEEN 10000 AND 12000;

-- 3) Извеждане на името, номера и заплатата на служителите, които имат фамилия започваща с буква „S“
SELECT NUMBER, NAME, SALARY FROM employee 
WHERE NAME LIKE '%S%';

-- 4) Извеждане на всички продадени стоки в отдел (department) 49 като се показват техните имена, цена и цената им, увеличена с 15%
SELECT i.NAME, i.PRICE AS ORIGINAL_PRICE, i.PRICE * 1.15 AS INCREASED_PRICE
FROM item i
WHERE i.DEPT = 49;

-- 5) Извеждане на имената и теглата на всички резервни части, които се доставят от доставчик с име DEC (да се използва subquery в клаузата WHERE)
SELECT p.NAME, p.WEIGHT
FROM parts p
WHERE p.NUMBER IN (
    SELECT s.PART
    FROM supply s
    WHERE s.SUPPLIER = (
        SELECT NUMBER 
        FROM supplier 
        WHERE NAME = 'DEC'
    )
);

-- 6) Извеждане на името и цвета на всички части, които тежат повече от частта black tape drive (да се използва subquery в клаузата WHERE)
SELECT p.NAME, p.COLOR
FROM parts p
WHERE p.WEIGHT > (
    SELECT WEIGHT 
    FROM parts 
    WHERE NAME = 'tape drive' AND COLOR = 'black'
);

-- 7) Извеждане на средната заплата на всички служители, които се управляват от служител с номер 199
SELECT AVG(SALARY) AS AVERAGE_SALARY
FROM employee
WHERE MANAGER = 199;

-- 8) Извеждане на списъка на стоките по доставчици
SELECT s.NAME AS SUPPLIER_NAME, i.NAME AS ITEM_NAME
FROM supplier s
JOIN item i ON s.NUMBER = i.SUPPLIER
ORDER BY s.NAME, i.NAME;

-- 9) Извеждане на общото тегло на всички стоки, които всеки един доставчик от Масачузетс (код “Mass”) доставя
SELECT s.NAME AS SUPPLIER_NAME, SUM(p.WEIGHT * sp.QUANTITY) AS TOTAL_WEIGHT
FROM supplier s
JOIN supply sp ON s.NUMBER = sp.SUPPLIER
JOIN parts p ON sp.PART = p.NUMBER
JOIN city c ON s.CITY = c.NAME
WHERE c.STATE = 'Mass'
GROUP BY s.NAME;

-- 10)  Увеличете с 5% заплатата на мениджърите на отдели в магазин номер 8, като преди и след това извлечете техния номер, име и заплата

-- Първо показваме сегашните заплати
SELECT e.NUMBER, e.NAME, e.SALARY AS OLD_SALARY
FROM employee e
JOIN dept d ON e.NUMBER = d.MANAGER
WHERE d.STORE = 8;

-- После с актуализираме заплатите
UPDATE employee
SET SALARY = SALARY * 1.05
WHERE NUMBER IN (
    SELECT MANAGER
    FROM dept
    WHERE STORE = 8
);

-- Най-накрая, показваме с актуализираните заплати
SELECT e.NUMBER, e.NAME, e.SALARY AS NEW_SALARY
FROM employee e
JOIN dept d ON e.NUMBER = d.MANAGER
WHERE d.STORE = 8;