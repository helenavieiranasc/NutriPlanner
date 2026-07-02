import mysql.connector

class ConexaoDB:
    _conn = None

    @classmethod
    def get(cls):
        if cls._conn is None or not cls._conn.is_connected():
            cls._conn = mysql.connector.connect(
                host="127.0.0.1",
                user="root",
                password="root",
                database="nutriplanner",
                auth_plugin="mysql_native_password"
            )
        return cls._conn