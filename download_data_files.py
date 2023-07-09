import requests 
import csv
import numpy as np
import re

class download:

    def __init__(self, URL):
        self.url = URL

    def download_data_to_file(self):
        CSV_FILE_NAME = 'Data_Prepared/' + '_'.join(self.url.split('/')[-2:]).split('_complete.txt')[0] + '.csv'  
        COLUMN_NAME = re.split(r'Complete_|_complete.txt', self.url)[1]
        response= requests.get(self.url)
        i, previous_string_line = 1, '' # i = 1 as first row in a file is 1 not 0
        dataset_beginning_row = np.inf
        with open(CSV_FILE_NAME, 'w', newline='') as file:
            writer = csv.writer(file, delimiter=';')
            for line in response.iter_lines():
                current_string_line = line.decode('utf-8')
                if len(current_string_line) == 1 and previous_string_line.find('20') != -1:
                    break
                elif current_string_line.find('Year') != -1 and (current_string_line.find('Month') != -1 and current_string_line.find('Anomaly') != -1):
                    dataset_beginning_row = i+2
                    header_line_first = previous_string_line.split('%')[1].split()
                    header_line_second = line.decode('utf-8').split('%')[1].split(',')
                    header_line_second = [ele.split()[0] for ele in header_line_second]
                    header_line_first_temp = [ele for ele in header_line_first for i in range(2)]
                    header_to_csv_file = header_line_second[0:2] + ["{}{:02}".format(b_, ' ' + a_ + ' ' + COLUMN_NAME) for a_, b_ in zip(header_line_first_temp, header_line_second[2:])]
                    writer.writerow(header_to_csv_file)
                elif i >= dataset_beginning_row:
                    writer.writerow(line.decode('utf-8').split())
                i+=1
                previous_string_line = current_string_line

    def download_data_to_two_files(self):
        CSV_FILE_NAME_AIR = 'Data_Prepared/' + '_'.join(self.url.split('/')[-2:]).split('_complete.txt')[0] + '_Air_Method.csv'
        COLUMN_NAME_AIR = 'TAIR'
        CSV_FILE_NAME_WATER = 'Data_Prepared/' + '_'.join(self.url.split('/')[-2:]).split('_complete.txt')[0] + '_Water_Method.csv' 
        COLUMN_NAME_WAT = 'TWAT'
        response= requests.get(self.url)
        i, j, line_counter, previous_string_line = 1, 1, 1, '' # i = 1 as first row in a file is 1 not 0
        dataset_beginning_row = np.inf
        air_method_line, water_method_line, file_threshold = None, None, None
        
        # Loop one is to define the file name
        for line in response.iter_lines():
            current_string_line = line.decode('utf-8')
            if current_string_line.find('Temperature Inferred') != -1 and current_string_line.find('from Air Temperatures') != -1:
                air_method_line = line_counter  
            elif current_string_line.find('Temperature Inferred') != -1 and current_string_line.find('from Water Temperatures') != -1:
                water_method_line = line_counter  
            line_counter += 1

        if air_method_line < water_method_line:
            first_file_name = CSV_FILE_NAME_AIR
            second_file_name = CSV_FILE_NAME_WATER
            file_threshold = water_method_line
            first_column_name, second_column_name = COLUMN_NAME_AIR, COLUMN_NAME_WAT
        else:
            first_file_name = CSV_FILE_NAME_WATER
            second_file_name = CSV_FILE_NAME_AIR
            file_threshold = air_method_line
            first_column_name, second_column_name = COLUMN_NAME_WAT, COLUMN_NAME_AIR

        with open(first_file_name, 'w', newline='') as file:
            writer = csv.writer(file, delimiter=';')
            for line in response.iter_lines():
                current_string_line = line.decode('utf-8')
                if len(current_string_line) == 1 and previous_string_line.find('20') != -1:
                    break
                elif current_string_line.find('Year') != -1 and (current_string_line.find('Month') != -1 and current_string_line.find('Anomaly') != -1):
                    dataset_beginning_row = i+2
                    header_line_first = previous_string_line.split('%')[1].split()
                    header_line_second = line.decode('utf-8').split('%')[1].split(',')
                    header_line_second = [ele.split()[0] for ele in header_line_second]
                    header_line_first_temp = [ele for ele in header_line_first for x in range(2)]
                    header_to_csv_file = header_line_second[0:2] + ["{}{:02}".format(b_, ' ' + a_ + ' ' + first_column_name) for a_, b_ in zip(header_line_first_temp, header_line_second[2:])]
                    writer.writerow(header_to_csv_file)
                elif i >= dataset_beginning_row:
                    writer.writerow(line.decode('utf-8').split())
                i+=1
                previous_string_line = current_string_line

        with open(second_file_name, 'w', newline='') as file:
            writer = csv.writer(file, delimiter=';')
            for line in response.iter_lines():
                current_string_line = line.decode('utf-8')
                if (len(current_string_line) == 1 and j > file_threshold) and previous_string_line.find('20') != -1:
                    break
                elif (current_string_line.find('Year') != -1 and j > file_threshold) and (current_string_line.find('Month') != -1 and current_string_line.find('Anomaly') != -1):
                    dataset_beginning_row = j+2
                    header_line_first = previous_string_line.split('%')[1].split()
                    header_line_second = line.decode('utf-8').split('%')[1].split(',')
                    header_line_second = [ele.split()[0] for ele in header_line_second]
                    header_line_first_temp = [ele for ele in header_line_first for x in range(2)]
                    header_to_csv_file = header_line_second[0:2] + ["{}{:02}".format(b_, ' ' + a_ + ' ' + second_column_name) for a_, b_ in zip(header_line_first_temp, header_line_second[2:])]
                    writer.writerow(header_to_csv_file)
                elif (j >= dataset_beginning_row and j > file_threshold + 2):
                    writer.writerow(line.decode('utf-8').split())
                j+=1
                previous_string_line = current_string_line