
------------------------------------------------------------------------------------------------

-- Exporting all 5 tables into individual csv files in a separate folder

COPY (SELECT * FROM Global_Temperature_Data ORDER BY dt ASC) TO '/Users/atsoc/Python_files/Machine_Learning/Kaggle/Climate Change/Data_Prepared/Global_Temperatures_Data.csv' DELIMITER ',' CSV HEADER;;
