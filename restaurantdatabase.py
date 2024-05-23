## file name: restaurantdatabase.py
import mysql.connector 
from mysql.connector import Error 

class RestaurantDatabase():
    def __init__(self,
                 host="localhost",
                 port="3306",
                 database="restaurant_reservations",
                 user='root',
                 password='Walt1123.'):

        self.host = host
        self.port = port
        self.database = database
        self.user = user
        self.password = password
        self.connection = None
        self.cursor = None
        self.connect()

    def connect(self):
        try:
            self.connection = mysql.connector.connect(
                host=self.host,
                port=self.port,
                database=self.database,
                user=self.user,
                password=self.password)
            
            if self.connection.is_connected():
                print("Successfully connected to the database")
                return
        except Error as e:
            print("Error while connecting to MySQL", e)

    def addReservation(self, customer_id, reservation_time, number_of_guests, special_requests):
        ''' Method to insert a new reservation into the reservations table '''
        try:
            if self.connection.is_connected():
                self.cursor = self.connection.cursor()
                query = """
                INSERT INTO reservations (customer_id, reservation_time, number_of_guests, special_requests)
                VALUES (%s, %s, %s, %s)
                """
                self.cursor.execute(query, (customer_id, reservation_time, number_of_guests, special_requests))
                self.connection.commit()
                print("Reservation added successfully")
        except mysql.connector.Error as err:
            print(f"Error: {err}")
            self.connection.rollback()
        finally:
            if self.cursor:
                self.cursor.close()

    def getAllReservations(self):
        ''' Method to get all reservations from the reservations table '''
        if self.connection.is_connected():
            self.cursor = self.connection.cursor()
            query = "SELECT * FROM reservations"
            self.cursor.execute(query)
            records = self.cursor.fetchall()
            return records

    def addCustomer(self, customer_name, contact_info):
        ''' Method to add a new customer to the customers table '''
        if self.connection.is_connected():
            self.cursor = self.connection.cursor()
            query = "INSERT INTO customers (customer_name, contact_info) VALUES (%s, %s)"
            self.cursor.execute(query, (customer_name, contact_info))
            self.connection.commit()
            print("Customer added successfully")
            return

    def getCustomerPreferences(self, customer_id):
        ''' Method to retrieve dining preferences for a specific customer '''
        if self.connection.is_connected():
            self.cursor = self.connection.cursor()
            query = "SELECT * FROM diningPreferences WHERE customerId = %s"
            self.cursor.execute(query, (customer_id,))
            preferences = self.cursor.fetchall()
            return preferences

    # Add more methods as needed for restaurant operations

