-- Importing all data from csv files
-- 1. Create tables with predifined columns
-- 2. Import data from csv file to the created table
-- 3. The Goal is to import all the data files and then merge them into 1 csv file containing the following attributes:
--  Monthly and Yearly anomaly and uncertainty for Air method, water method, TAVG, TMIN, TMAX. In total there will be --> 22 columns [2 for month + year and 20 for data]


-----------------------------------------------------------------------Global_Land_and_Ocean_Air_Method-------------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.Global_Land_and_Ocean_Air_Method (
    "Year" INT,
    "Month" INT,
    "Anomaly Monthly TAIR" DOUBLE PRECISION,
    "Unc. Monthly TAIR" DOUBLE PRECISION,
    "Anomaly Annual TAIR" DOUBLE PRECISION,
    "Unc. Annual TAIR" DOUBLE PRECISION,
    "Anomaly Five-year TAIR" DOUBLE PRECISION,
    "Unc. Five-year TAIR" DOUBLE PRECISION,
    "Anomaly Ten-year TAIR" DOUBLE PRECISION,
    "Unc. Ten-year TAIR" DOUBLE PRECISION,
    "Anomaly Twenty-year TAIR" DOUBLE PRECISION,
    "Unc. Twenty-year TAIR" DOUBLE PRECISION
) ;;

CREATE TABLE IF NOT EXISTS Temp_Global_Land_and_Ocean_Air_Method AS SELECT * FROM Global_Land_and_Ocean_Air_Method WHERE false;;

COPY Temp_Global_Land_and_Ocean_Air_Method -- no need to specilly if all comlumns are needed
FROM '/Users/atsoc/Python_files/Machine_Learning/Kaggle/Climate Change/Data_prepared/Global_Land_and_Ocean_Air_Method.csv'
DELIMITER ';'
CSV HEADER;;

INSERT INTO Global_Land_and_Ocean_Air_Method SELECT * 
FROM Temp_Global_Land_and_Ocean_Air_Method
EXCEPT
SELECT * 
FROM Global_Land_and_Ocean_Air_Method;;
 
DROP TABLE IF EXISTS Temp_Global_Land_and_Ocean_Air_Method;;

-----------------------------------------------------------------------Global_Land_and_Ocean_Water_Method------------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.Global_Land_and_Ocean_Water_Method
(
    "Year" INT,
    "Month" INT,
    "Anomaly Monthly TWAT" DOUBLE PRECISION,
    "Unc. Monthly TWAT" DOUBLE PRECISION,
    "Anomaly Annual TWAT" DOUBLE PRECISION,
    "Unc. Annual TWAT" DOUBLE PRECISION,
    "Anomaly Five-year TWAT" DOUBLE PRECISION,
    "Unc. Five-year TWAT" DOUBLE PRECISION,
    "Anomaly Ten-year TWAT" DOUBLE PRECISION,
    "Unc. Ten-year TWAT" DOUBLE PRECISION,
    "Anomaly Twenty-year TWAT" DOUBLE PRECISION,
    "Unc. Twenty-year TWAT" DOUBLE PRECISION
) ;;

CREATE TABLE IF NOT EXISTS Temp_Global_Land_and_Ocean_Water_Method AS SELECT * FROM Global_Land_and_Ocean_Water_Method WHERE false;;

COPY Temp_Global_Land_and_Ocean_Water_Method -- no need to specilly if all comlumns are needed
FROM '/Users/atsoc/Python_files/Machine_Learning/Kaggle/Climate Change/Data_prepared/Global_Land_and_Ocean_Water_Method.csv'
DELIMITER ';'
CSV HEADER;;

INSERT INTO Global_Land_and_Ocean_Water_Method SELECT * 
FROM Temp_Global_Land_and_Ocean_Water_Method
EXCEPT
SELECT * 
FROM Global_Land_and_Ocean_Water_Method;;
 
DROP TABLE IF EXISTS Temp_Global_Land_and_Ocean_Water_Method;;	

---------------------------------------------------------------------------Global_Complete_TAVG---------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.Global_Complete_TAVG 
(
    "Year" VARCHAR(255),
    "Month" VARCHAR(255),
    "Anomaly Monthly TAVG" DOUBLE PRECISION,
    "Unc. Monthly TAVG" DOUBLE PRECISION,
    "Anomaly Annual TAVG" DOUBLE PRECISION,
    "Unc. Annual TAVG" DOUBLE PRECISION,
    "Anomaly Five-year TAVG" DOUBLE PRECISION,
    "Unc. Five-year TAVG" DOUBLE PRECISION,
    "Anomaly Ten-year TAVG" DOUBLE PRECISION,
    "Unc. Ten-year TAVG" DOUBLE PRECISION,
    "Anomaly Twenty-year TAVG" DOUBLE PRECISION,
    "Unc. Twenty-year TAVG" DOUBLE PRECISION
) ;;

CREATE TABLE IF NOT EXISTS Temp_Global_Complete_TAVG AS SELECT * FROM Global_Complete_TAVG WHERE false;;

COPY Temp_Global_Complete_TAVG -- no need to specilly if all comlumns are needed
FROM '/Users/atsoc/Python_files/Machine_Learning/Kaggle/Climate Change/Data_prepared/Global_Complete_TAVG.csv'
DELIMITER ';'
CSV HEADER;;

INSERT INTO Global_Complete_TAVG SELECT * 
FROM Temp_Global_Complete_TAVG
EXCEPT
SELECT * 
FROM Global_Complete_TAVG;;
 
DROP TABLE IF EXISTS Temp_Global_Complete_TAVG;;	

---------------------------------------------------------------------------Global_Complete_TMIN---------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.Global_Complete_TMIN 
(
    "Year" INT,
    "Month" INT,
    "Anomaly Monthly TMIN" DOUBLE PRECISION,
    "Unc. Monthly TMIN" DOUBLE PRECISION,
    "Anomaly Annual TMIN" DOUBLE PRECISION,
    "Unc. Annual TMIN" DOUBLE PRECISION,
    "Anomaly Five-year TMIN" DOUBLE PRECISION,
    "Unc. Five-year TMIN" DOUBLE PRECISION,
    "Anomaly Ten-year TMIN" DOUBLE PRECISION,
    "Unc. Ten-year TMIN" DOUBLE PRECISION,
    "Anomaly Twenty-year TMIN" DOUBLE PRECISION,
    "Unc. Twenty-year TMIN" DOUBLE PRECISION
) ;;

CREATE TABLE IF NOT EXISTS Temp_Global_Complete_TMIN AS SELECT * FROM Global_Complete_TMIN WHERE false;;

COPY Temp_Global_Complete_TMIN -- no need to specilly if all comlumns are needed
FROM '/Users/atsoc/Python_files/Machine_Learning/Kaggle/Climate Change/Data_prepared/Global_Complete_TMIN.csv'
DELIMITER ';'
CSV HEADER;;

INSERT INTO Global_Complete_TMIN SELECT * 
FROM Temp_Global_Complete_TMIN
EXCEPT
SELECT * 
FROM Global_Complete_TMIN;;
 
DROP TABLE IF EXISTS Temp_Global_Complete_TMIN;;	

---------------------------------------------------------------------------Global_Complete_TMAX---------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.Global_Complete_TMAX
(
    "Year" INT,
    "Month" INT,
    "Anomaly Monthly TMAX" DOUBLE PRECISION,
    "Unc. Monthly TMAX" DOUBLE PRECISION,
    "Anomaly Annual TMAX" DOUBLE PRECISION,
    "Unc. Annual TMAX" DOUBLE PRECISION,
    "Anomaly Five-year TMAX" DOUBLE PRECISION,
    "Unc. Five-year TMAX" DOUBLE PRECISION,
    "Anomaly Ten-year TMAX" DOUBLE PRECISION,
    "Unc. Ten-year TMAX" DOUBLE PRECISION,
    "Anomaly Twenty-year TMAX" DOUBLE PRECISION,
    "Unc. Twenty-year TMAX" DOUBLE PRECISION
);;

CREATE TABLE IF NOT EXISTS Temp_Global_Complete_TMAX AS SELECT * FROM Global_Complete_TMAX WHERE false;;

COPY Temp_Global_Complete_TMAX -- no need to specilly if all comlumns are needed
FROM '/Users/atsoc/Python_files/Machine_Learning/Kaggle/Climate Change/Data_prepared/Global_Complete_TMAX.csv'
DELIMITER ';'
CSV HEADER;;

INSERT INTO Global_Complete_TMAX SELECT * 
FROM Temp_Global_Complete_TMAX
EXCEPT
SELECT * 
FROM Global_Complete_TMAX;;
 
DROP TABLE IF EXISTS Temp_Global_Complete_TMAX;;	