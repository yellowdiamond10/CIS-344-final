CREATE DATABASE restaurant_reservations;
USE restaurant_reservations;

CREATE TABLE Customers_Table (
	customerId INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    customerName VARCHAR(45) NOT NULL,
    contactInfo VARCHAR(200)
    );

CREATE TABLE reservations (
	reservationId INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    customerId INT NOT NULL,
    reservationTime DATETIME NOT NULL,
    numberOfGuests INT NOT NULL,
    specialRequests VARCHAR(200)
    );


alter table Reservations_Table    
add foreign key(customerId) references Customers_Table(customerId);    

CREATE TABLE DiningPreferences_Table (
	preferenceId INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    customerId INT NOT NULL,
    favoriteTable VARCHAR(45),
    dietaryRestrictions VARCHAR(200)
);

alter table DiningPreferences_Table    
add foreign key(customerId) references Customers_Table(customerId);

DELIMITER //
CREATE PROCEDURE SelectAllCustomers(IN lookupcustomerId INT)
BEGIN
	SELECT * FROM Reservations_Table WHERE customerId = lookupcustomerId;
END//

DELIMITER //
CREATE PROCEDURE addSpecialRequest(IN lookupreservationId INT, IN requests VARCHAR(255))
BEGIN 
	UPDATE Reservations_Table
    SET specialRequests = requests
    WHERE reservationId = lookupreservationId;
END//


DELIMITER //
CREATE PROCEDURE addReservation(IN ncustomerID INT, IN nReservationTime DATETIME, IN nNumber_Of_Guests INT,IN nSpecial_Requests VARCHAR(200))
BEGIN
	INSERT INTO Reservations_Table(customerId, reservationTime, numberOfGuests,specialRequests) VALUES(ncustomerID,nReservationTime,nNumber_Of_Guests,nSpecial_Requests);
END//



INSERT INTO Customers_Table(customerName, contactInfo) VALUES('Daniel','daniel32@aol.com');
END//
INSERT INTO Customers_Table(customerName, contactInfo) VALUES('Jack','jack67@aol.com');
END//
INSERT INTO Customers_Table(customerName, contactInfo) VALUES('Bryan','bryan54@aol.com');
END//

INSERT INTO reservations(customerId, reservationTIme,numberOfGuests,specialRequests) VALUES(1,'2024-06-04 13:44:00',3,'no anchovies');
END//
INSERT INTO reservations(customerId, reservationTIme,numberOfGuests,specialRequests) VALUES(2,'2023-03-10 16:20:00',2,'no pcikles');
END//
INSERT INTO reservations(customerId, reservationTIme,numberOfGuests,specialRequests) VALUES(1,'2024-04-12 08:52:00',10,'big birthday cake');
END//

INSERT INTO DiningPreferences_Table(customerId,favoriteTable,dietaryRestrictions) VALUES(1,'farthest back','no restrictions');
END//
INSERT INTO DiningPreferences_Table(customerId,favoriteTable,dietaryRestrictions) VALUES(2,'near the port','peanuts');
END//
INSERT INTO DiningPreferences_Table(customerId,favoriteTable,dietaryRestrictions) VALUES(3,'near the shore','fish');
END//

SELECT * FROM DiningPreferences_Table;
