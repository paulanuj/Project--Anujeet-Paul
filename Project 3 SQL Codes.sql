-- Create the "EventsManagement" database
CREATE DATABASE EventsManagement;

-- Create the Events table
CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name TEXT,
    Event_Date DATE,
    Event_Location TEXT,
    Event_Description TEXT
);

-- Create the Attendees table
CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,
    Attendee_Name TEXT,
    Attendee_Phone TEXT,
    Attendee_Email TEXT,
    Attendee_City TEXT
);

-- Create the Registrations table with foreign key constraints
CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,
    Event_Id INT REFERENCES Events(Event_Id),
    Attendee_Id INT REFERENCES Attendees(Attendee_Id),
    Registration_Date DATE,
    Registration_Amount NUMERIC
);

-- Insert sample data into the Events table
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
    ('Event 1', '2023-11-10', 'Venue A', 'Description 1'),
    ('Event 2', '2023-12-05', 'Venue B', 'Description 2');

-- Insert sample data into the Attendees table
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
    ('John Doe', '123-456-7890', 'john.doe@example.com', 'City A'),
    ('Jane Smith', '987-654-3210', 'jane.smith@example.com', 'City B');

-- Insert sample data into the Registrations table
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
    (1, 1, '2023-11-01', 50.00),
    (1, 2, '2023-11-03', 50.00),
    (2, 2, '2023-12-02', 60.00);
	
-- Insert a new event
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('New Event', '2023-12-20', 'Venue C', 'Description of the new event');

-- Update event information for an event with a specific Event_Id (replace ID and new values)
UPDATE Events
SET Event_Name = 'Global Summit', Event_Location = 'Grand Hotel Ballroom'
WHERE Event_Id = 3;

-- Delete an event with a specific Event_Id (replace ID)
DELETE FROM Events
WHERE Event_Id = 4;

-- Insert a new attendee
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('New Attendee', '555-555-5555', 'new.attendee@example.com', 'City D');

-- Register an attendee (e.g., Attendee with ID 2) for an event (e.g., Event with ID 1) with registration details
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (1, 2, '2023-11-03', 50.00);

-- Retrieve event details by Event_Id (e.g., Event_Id 3)
SELECT * FROM Events WHERE Event_Id = 3;

-- Retrieve a list of all events
SELECT * FROM Events;

-- Retrieve events within a specific date range (e.g., from '2023-11-01' to '2023-12-31')
SELECT * FROM Events
WHERE Event_Date BETWEEN '2023-11-01' AND '2023-12-31';

-- Retrieve a list of all attendees from 'City A' who registered for any event
SELECT * FROM Attendees WHERE Attendee_City = 'City A' AND Attendee_Id IN (SELECT Attendee_Id FROM Registrations); 

-- Retrieve attendees for a different event by its name ('Event 1')
SELECT Attendees.Attendee_Id, Attendees.Attendee_Name
FROM Registrations
JOIN Attendees ON Registrations.Attendee_Id = Attendees.Attendee_Id
WHERE Registrations.Event_Id = (SELECT Event_Id FROM Events WHERE Event_Name = 'Event 1');

-- Calculate the total registration amount for events that had more than 2 attendees
SELECT Events.Event_Id, Events.Event_Name, SUM(Registrations.Registration_Amount) AS Total_Amount
FROM Events
LEFT JOIN Registrations ON Events.Event_Id = Registrations.Event_Id
GROUP BY Events.Event_Id, Events.Event_Name
HAVING COUNT(Registrations.Attendee_Id) > 2;

-- Calculate the average registration amount for events in a different location ('Venue A')
SELECT Events.Event_Id, Events.Event_Name, AVG(Registrations.Registration_Amount) AS Average_Amount
FROM Events
LEFT JOIN Registrations ON Events.Event_Id = Registrations.Event_Id
WHERE Events.Event_Location = 'Venue A'
GROUP BY Events.Event_Id, Events.Event_Name;


