import psycopg2
import sys 

try:
    print(sys.modules['sql_database_password'])
    del sys.modules['sql_database_password']
except:
    print("Importing module/class \"sql_database_password\" of the first time")
finally:
    from sql_database_password import *

class data_preparation:

    def __init__(self, DATABASE: str, HOST: str, USER: str, PORT: str) -> None:
        self.database = DATABASE
        self.host = HOST
        self.user = USER
        self.port = PORT
        self.password = None 
        self.file_name = None

    def sql_server_connect(self):
        if self.password == None:
            self.password = sql_database_password.decrypt_sql_server_password()

        conn = psycopg2.connect(database=self.database,
                        host=self.host,
                        user=self.user,
                        password=self.password,
                        port=self.port)
        conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()
        return cursor    
    
    def execute_sql_query(self, FILE_NAME) -> None:
        self.file_name = FILE_NAME
        file_open_query = open(self.file_name, 'r')
        sqlFile = file_open_query.read()
        file_open_query.close()
        sql_commands = sqlFile.split(';;')
        cursor = data_preparation.sql_server_connect(self)
        for command in sql_commands:
            if command.strip() != '':
                cursor.execute(command)