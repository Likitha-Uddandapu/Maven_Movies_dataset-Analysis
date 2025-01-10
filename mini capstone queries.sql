/*SELECT 
    MIN(Rental_Date) AS EarliestDate,
    MAX(Rental_Date) AS LatestDate
FROM 
    Rental;*/
    
/*SELECT 
    Rental_ID, 
    Rental_Date
FROM 
    Rental
ORDER BY 
    Rental_Date asc
LIMIT 50000;*/

-- Month Vs Rentals
SELECT
    DATE_FORMAT(Rental_Date, '%Y-%m') AS RentalMonth,
    COUNT(Rental_ID) AS TotalRentals
FROM
    Rental
GROUP BY
    DATE_FORMAT(Rental_Date, '%Y-%m')
ORDER BY
    RentalMonth ASC;
    
/*SELECT
    DATE_FORMAT(Rental_Date, '%h %p') AS Hour12
    HOUR(Hour12) AS RentalHour,
    COUNT(Rental_ID) AS TotalRentals
FROM
    Rental
GROUP BY
    RentalHour
ORDER BY
    TotalRentals DESC;
SELECT 
    DATE_FORMAT(Rental_Date, '%h %p') AS Hour12
FROM 
    Rental;*/
-- Time Vs Rentals    
SELECT
    DATE_FORMAT(Rental_Date, '%h %p') AS Hour12,
    
    COUNT(Rental_ID) AS TotalRentals
FROM
    Rental
GROUP BY
    hour(rental_date), Hour12
ORDER BY
    TotalRentals DESC;
    
-- Title Vs RentalCount
SELECT
    F.Title,
    COUNT(R.Rental_ID) AS RentalCount
FROM
    Rental R
JOIN
    Inventory I ON R.Inventory_ID = I.Inventory_ID
JOIN
    Film F ON I.Film_ID = F.Film_ID
GROUP BY
    F.Title
ORDER BY
    RentalCount DESC
LIMIT 10;

-- Film Category VS Rental Count
SELECT
    C.Name,
    COUNT(R.Rental_ID) AS RentalCount
FROM
    Rental R
JOIN
    Inventory I ON R.Inventory_ID = I.Inventory_ID
JOIN
    Film F ON I.Film_ID = F.Film_ID
JOIN
    Film_Category FC ON F.Film_ID = FC.Film_ID
JOIN
    Category C ON FC.Category_ID = C.Category_ID
GROUP BY
    C.Name
ORDER BY
    RentalCount DESC;
-- Store and revenue generated
SELECT
    S.StoreID,
    SUM(P.Amount) AS TotalRevenue
FROM
    Payment P
JOIN
    Rental R ON P.RentalID = R.RentalID
JOIN
    Inventory I ON R.InventoryID = I.InventoryID
JOIN
    Store S ON I.StoreID = S.StoreID
GROUP BY
    S.StoreID
ORDER BY
    TotalRevenue DESC
LIMIT 1;

-- Rental Count and Staff Menber
use mavenmovies;
SELECT
    CONCAT(S.First_Name, ' ', S.Last_Name) AS StaffName,
    COUNT(R.Rental_ID) AS RentalCount
FROM
    Rental R
JOIN
    Staff S ON R.Staff_ID = S.Staff_ID
GROUP BY
    StaffName
ORDER BY
    RentalCount DESC;
