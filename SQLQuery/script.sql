CREATE DATABASE formula1;

USE formula1;



CREATE TABLE circuits(
circuitID INT,
circuitRef VARCHAR(100),
name VARCHAR(100),
location VARCHAR(50),
country VARCHAR(50),
lat DECIMAL(8,4),
lng DECIMAL(8,4),
alt INT,
url VARCHAR(1000),
PRIMARY KEY(circuitID)
);


LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\circuits.csv' 
INTO TABLE circuits
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE constructors(
constructorID INT,
constructorRef VARCHAR(100),
name VARCHAR(100),
nationality VARCHAR(100),
url VARCHAR(1000),
PRIMARY KEY(constructorID)
);

LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\constructors.csv'
INTO TABLE constructors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE constructorResults(
constructorResultsID INT,
raceID INT,
constructorID INT,
points INT,
status VARCHAR(20),
PRIMARY KEY(constructorResultsID),
FOREIGN KEY(constructorID) REFERENCES constructors(constructorID)
);

LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\constructorResults.csv'
INTO TABLE constructorResults
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE constructorStandings(
constructorStandingsID INT,
raceID INT,
constructorID INT,
points INT,
position INT,
positionText CHAR(5),
wins INT,
PRIMARY KEY(constructorStandingsID),
FOREIGN KEY(constructorID) REFERENCES constructors(constructorID)
);

LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\constructorStandings.csv'
INTO TABLE constructorStandings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE drivers(
driverID INT,
driverRef VARCHAR(100),
number INT,
code CHAR(5),
forename VARCHAR(20),
surname VARCHAR(20),
dob VARCHAR(20),
nationality VARCHAR(50),
url VARCHAR(1000),
PRIMARY KEY(driverID)
);


LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\drivers.csv'
INTO TABLE drivers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE drivers;

CREATE TABLE driverStandings(
driverStandingsID INT,
raceID INT,
driverID INT,
points INT,
position INT,
positionText CHAR(5),
wins INT,
PRIMARY KEY(driverStandingsID),
UNIQUE KEY(raceID, driverID)
);

LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\driverStandings.csv'
INTO TABLE driverStandings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE driverStandings;




SET FOREIGN_KEY_CHECKS = 0;


SHOW ENGINE INNODB STATUS;


CREATE TABLE lapTimes(
raceID INT,
driverID INT,
lap INT,
position INT,
time VARCHAR(25),
milliseconds INT,
PRIMARY KEY(raceID, driverID, lap),
FOREIGN KEY(raceID, driverID) REFERENCES driverStandings(raceID, driverID)
);



LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\lapTimes.csv'
INTO TABLE lapTimes
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE pitStops(
raceID INT,
driverID INT,
stop CHAR(2),
lap CHAR(2),
time VARCHAR(25),
duration VARCHAR(25),
milliseconds VARCHAR(25),
PRIMARY KEY(raceID, driverID, stop),
FOREIGN KEY(raceID, driverID) REFERENCES driverStandings(raceID, driverID)
);


LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\pitStops.csv'
INTO TABLE pitStops
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE qualifying(
qualifyingID INT,
raceID INT,
driverID INT,
constructorID INT,
number INT,
position INT,
q1 VARCHAR(25),
q2 VARCHAR(25),
q3 VARCHAR(25),
PRIMARY KEY(qualifyingID),
UNIQUE KEY(raceID, driverID,constructorID)
);


LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\qualifying.csv'
INTO TABLE qualifying
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE races(
raceID INT,
year VARCHAR(10),
round INT,
circuitID INT,
name VARCHAR(50),
date VARCHAR(25),
time VARCHAR(25),
url VARCHAR(1000),
PRIMARY KEY(raceID),
FOREIGN KEY(circuitID) REFERENCES circuits(circuitID),
FOREIGN KEY(year) REFERENCES seasons(year)
);


LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\races.csv'
INTO TABLE races
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE seasons(
year VARCHAR(10),
url VARCHAR(1000),
PRIMARY KEY(year)
);

LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\seasons.csv'
INTO TABLE seasons
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE status(
statusID INT,
status VARCHAR(50),
PRIMARY KEY(statusID)
);


LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\status.csv'
INTO TABLE status
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE results(
resultsID INT,
raceID INT,
driverID INT,
constructorID INT,
number INT,
grid INT,
position INT,
positionText CHAR(5),
positionOrder INT,
points INT,
laps INT,
time VARCHAR(25),
milliseconds VARCHAR(25),
fastestLap INT,
rank INT,
fastestLapTime VARCHAR(25),
fastestLapSpeed VARCHAR(25),
statusID INT,
PRIMARY KEY(resultsID),
FOREIGN KEY(raceID) REFERENCES races(raceID),
FOREIGN KEY(driverID) REFERENCES drivers(driverID),
FOREIGN KEY(constructorID) REFERENCES constructors(constructorID),
FOREIGN KEY(statusID) REFERENCES status(statusID),
FOREIGN KEY(raceID, driverID, constructorID) REFERENCES qualifying(raceID, driverID, constructorID),
FOREIGN KEY(raceID, driverID) REFERENCES driverStandings(raceID, driverID)
);


LOAD DATA LOCAL INFILE 'C:\Users\skrei\Desktop\dbms proj\results.csv'
INTO TABLE results
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;










