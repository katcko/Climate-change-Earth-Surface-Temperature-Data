from cryptography.fernet import Fernet

class sql_database_password:

    def __init__(self) -> None:
        pass

    def encrypt_sql_server_password() -> None:
        key = Fernet.generate_key()
        with open('SQL_server_password/key_pwd.bin', 'wb') as file_object:
            file_object.write(key)

        cipher_suite = Fernet(key)
        user_input_pwd = input("User Input of the password for SQL database")
        ciphered_text = cipher_suite.encrypt(bytes(user_input_pwd, 'utf-8'))   #required to be bytes
        with open('SQL_server_password/mssqltip_bytes.bin', 'wb') as file_object:
            file_object.write(ciphered_text)
        print(f'encrypted pwd: {user_input_pwd}')

    def decrypt_sql_server_password() -> str:
        with open('SQL_server_password/key_pwd.bin', 'rb') as file_object:
            for line in file_object:
                encryption_key = line
        cipher_suite_decript = Fernet(encryption_key)

        with open('SQL_server_password/mssqltip_bytes.bin', 'rb') as file_object:
            for line in file_object:
                encryptedpwd = line
            cipher_suite_decript = Fernet(encryption_key)
            uncipher_text = (cipher_suite_decript.decrypt(encryptedpwd))
            plain_text_encryptedpassword = bytes(uncipher_text).decode("utf-8")

        return plain_text_encryptedpassword