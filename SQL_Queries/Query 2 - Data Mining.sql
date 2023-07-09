


-----------------------------------------------------------------------Global_Land_and_Ocean_Air_Method-------------------------------------------------------------------------------------------------------------


ALTER TABLE Global_Land_and_Ocean_Air_Method
	DROP COLUMN IF EXISTS "Anomaly Five-year TAIR",
	DROP COLUMN IF EXISTS "Unc. Five-year TAIR",
	DROP COLUMN IF EXISTS "Anomaly Ten-year TAIR", 
	DROP COLUMN IF EXISTS "Unc. Ten-year TAIR", 
	DROP COLUMN IF EXISTS "Anomaly Twenty-year TAIR", 
	DROP COLUMN IF EXISTS "Unc. Twenty-year TAIR";;


-----------------------------------------------------------------------Global_Land_and_Ocean_Water_Method------------------------------------------------------------------------------------------------------------


ALTER TABLE Global_Land_and_Ocean_Water_Method
	DROP COLUMN IF EXISTS "Anomaly Five-year TWAT",
	DROP COLUMN IF EXISTS "Unc. Five-year TWAT",
	DROP COLUMN IF EXISTS "Anomaly Ten-year TWAT", 
	DROP COLUMN IF EXISTS "Unc. Ten-year TWAT", 
	DROP COLUMN IF EXISTS "Anomaly Twenty-year TWAT", 
	DROP COLUMN IF EXISTS "Unc. Twenty-year TWAT";;

	
---------------------------------------------------------------------------Global_Complete_TAVG---------------------------------------------------------------------------------------------------------


ALTER TABLE Global_Complete_TAVG
	DROP COLUMN IF EXISTS "Anomaly Five-year TAVG",
	DROP COLUMN IF EXISTS "Unc. Five-year TAVG",
	DROP COLUMN IF EXISTS "Anomaly Ten-year TAVG", 
	DROP COLUMN IF EXISTS "Unc. Ten-year TAVG", 
	DROP COLUMN IF EXISTS "Anomaly Twenty-year TAVG", 
	DROP COLUMN IF EXISTS "Unc. Twenty-year TAVG";;

	
---------------------------------------------------------------------------Global_Complete_TMIN---------------------------------------------------------------------------------------------------------


ALTER TABLE Global_Complete_TMIN
	DROP COLUMN IF EXISTS "Anomaly Five-year TMIN",
	DROP COLUMN IF EXISTS "Unc. Five-year TMIN",
	DROP COLUMN IF EXISTS "Anomaly Ten-year TMIN", 
	DROP COLUMN IF EXISTS "Unc. Ten-year TMIN", 
	DROP COLUMN IF EXISTS "Anomaly Twenty-year TMIN", 
	DROP COLUMN IF EXISTS "Unc. Twenty-year TMIN";;
	
	
---------------------------------------------------------------------------Global_Complete_TMAX---------------------------------------------------------------------------------------------------------


ALTER TABLE Global_Complete_TMAX
	DROP COLUMN IF EXISTS "Anomaly Five-year TMAX",
	DROP COLUMN IF EXISTS "Unc. Five-year TMAX",
	DROP COLUMN IF EXISTS "Anomaly Ten-year TMAX", 
	DROP COLUMN IF EXISTS "Unc. Ten-year TMAX", 
	DROP COLUMN IF EXISTS "Anomaly Twenty-year TMAX", 
	DROP COLUMN IF EXISTS "Unc. Twenty-year TMAX";;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Adding a dt column to all tables and deleting the year and month columns
ALTER TABLE Global_Complete_TAVG ADD COLUMN IF NOT EXISTS "dt TAVG" VARCHAR(255); 
UPDATE Global_Complete_TAVG SET "dt TAVG" =  '1' || '-' || "Month" || '-' || "Year"; 
ALTER TABLE Global_Complete_TAVG
	DROP COLUMN IF EXISTS "Month",
	DROP COLUMN IF EXISTS "Year";;
	
ALTER TABLE Global_Complete_TMIN ADD COLUMN IF NOT EXISTS "dt TMIN" VARCHAR(255); 
UPDATE Global_Complete_TMIN SET "dt TMIN" =  '1' || '-' || "Month" || '-' || "Year"; 
ALTER TABLE Global_Complete_TMIN
	DROP COLUMN IF EXISTS "Month",
	DROP COLUMN IF EXISTS "Year";;

ALTER TABLE Global_Complete_TMAX ADD COLUMN IF NOT EXISTS "dt TMAX" VARCHAR(255); 
UPDATE Global_Complete_TMAX SET "dt TMAX" =  '1' || '-' || "Month" || '-' || "Year";
ALTER TABLE Global_Complete_TMAX
	DROP COLUMN IF EXISTS "Month",
	DROP COLUMN IF EXISTS "Year";;
	
ALTER TABLE Global_Land_and_Ocean_Air_Method ADD COLUMN IF NOT EXISTS "dt TAIR" VARCHAR(255); 
UPDATE Global_Land_and_Ocean_Air_Method SET "dt TAIR" =  '1' || '-' || "Month" || '-' || "Year";
ALTER TABLE Global_Land_and_Ocean_Air_Method
	DROP COLUMN IF EXISTS "Month",
	DROP COLUMN IF EXISTS "Year";;
	
ALTER TABLE  Global_Land_and_Ocean_Water_Method ADD COLUMN IF NOT EXISTS "dt TWAT" VARCHAR(255); 
UPDATE Global_Land_and_Ocean_Water_Method SET "dt TWAT" =  '1' || '-' || "Month" || '-' || "Year";
ALTER TABLE Global_Land_and_Ocean_Water_Method
	DROP COLUMN IF EXISTS "Month",
	DROP COLUMN IF EXISTS "Year";;
	
-- Mergin all 5 tables into 1 new table

SELECT Global_Complete_TAVG.*, Global_Complete_TMAX.*, Global_Complete_TMIN.*, Global_Land_and_Ocean_Air_Method.*, Global_Land_and_Ocean_Water_Method.*
INTO Global_Temperature_Data 
FROM Global_Complete_TAVG
    FULL OUTER JOIN Global_Complete_TMAX
        ON Global_Complete_TMAX."dt TMAX" = Global_Complete_TAVG."dt TAVG"
    FULL OUTER JOIN Global_Complete_TMIN
        ON Global_Complete_TMIN."dt TMIN" = Global_Complete_TAVG."dt TAVG"
    FULL OUTER JOIN Global_Land_and_Ocean_Air_Method
        ON Global_Land_and_Ocean_Air_Method."dt TAIR" = Global_Complete_TAVG."dt TAVG"
    FULL OUTER JOIN Global_Land_and_Ocean_Water_Method
    	ON Global_Land_and_Ocean_Water_Method."dt TWAT" = Global_Complete_TAVG."dt TAVG";;
    	
    	
 -- Clean the created data: Deleting the missing rows (old data 1750-1849) and newest incomplete data (2023+)
 

SELECT * --If this returns the correct records, simply change to DELETE
FROM Global_Temperature_Data 
WHERE ("dt TAVG" IS NULL) 
OR ("dt TMAX" IS NULL) 
OR ("dt TMIN" IS NULL);;

DELETE FROM Global_Temperature_Data 
WHERE ("dt TAVG" IS NULL) 
OR ("dt TMAX" IS NULL) 
OR ("dt TMIN" IS NULL);;

-- Rename the dt columns and drop the redundant ones

ALTER TABLE Global_Temperature_Data
RENAME COLUMN "dt TAVG" TO "dt";;


ALTER TABLE Global_Temperature_Data
	DROP COLUMN IF EXISTS "dt TAVG",
	DROP COLUMN IF EXISTS "dt TMAX",
	DROP COLUMN IF EXISTS "dt TMIN", 
	DROP COLUMN IF EXISTS "dt TAIR", 
	DROP COLUMN IF EXISTS "dt TWAT";;

UPDATE Global_Temperature_Data SET "dt"=TO_DATE("dt",'DD/MM/YYYY');;