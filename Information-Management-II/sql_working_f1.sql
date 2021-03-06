CREATE DATABASE F1;
USE F1;

CREATE TABLE Car(
	factoryLocation VARCHAR(30) NOT NULL,
    teamName VARCHAR(50) NOT NULL,
    tyres VARCHAR(20) NOT NULL,
    engineManf VARCHAR(30) NOT NULL,
    chassis VARCHAR(10) NOT NULL PRIMARY KEY
);

CREATE TABLE Logistics(
	arrivalDate DATE NOT NULL,
    teamName VARCHAR(50) NOT NULL,
    pickupLocation VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    companyName VARCHAR(40) NOT NULL,
    companyID VARCHAR(10) NOT NULL PRIMARY KEY
);

CREATE TABLE VenueStaff(
	staffName VARCHAR(30) NOT NULL,
    job VARCHAR(50) NOT NULL,
    department VARCHAR(30) NOT NULL,
    venueHead VARCHAR(50) NOT NULL,
    staffID VARCHAR(10) NOT NULL PRIMARY KEY
);

CREATE TABLE RaceVenue(
	raceDay DATE NOT NULL,
    fiaChiefID VARCHAR(10) NOT NULL,
    venueHead VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    trackName VARCHAR(80) NOT NULL,
    venueID VARCHAR(10) NOT NULL PRIMARY KEY
);

CREATE TABLE FIAStaff(
	fiaChiefID VARCHAR(10) NOT NULL PRIMARY KEY,
    fiaChiefName VARCHAR(50) NOT NULL
);

CREATE TABLE Sponsor(
	sponsorID VARCHAR(10) NOT NULL PRIMARY KEY,
    sponsorName VARCHAR(50) NOT NULL,
	industry VARCHAR(50) NOT NULL,
	ownerName VARCHAR(50) NOT NULL
);

CREATE TABLE Driver(
	license VARCHAR(10) NOT NULL PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
    teamName VARCHAR(50) NOT NULL,
	gender char NOT NULL,
	country VARCHAR(50) NOT NULL,
    wins INT,
    salary INT,
    age INT
);

CREATE TABLE Team(
	teamName VARCHAR(50) NOT NULL,
    budget INT,
    sponsorName VARCHAR(50) NOT NULL,
    sponsorID VARCHAR(10) NOT NULL,
    teamOwner VARCHAR(50) NOT NULL,
    teamPrincipal VARCHAR(50) NOT NULL,
    logisticCompany VARCHAR(50) NOT NULL,
    logisticID VARCHAR(10) NOT NULL,
    driverA VARCHAR(50) NOT NULL,
    driverB VARCHAR(50) NOT NULL,
    reserveDriver VARCHAR(50) NOT NULL, 
    country VARCHAR(30) NOT NULL, 
    teamID VARCHAR(10) NOT NULL PRIMARY KEY
);


INSERT INTO Team VALUES("Mercedes AMG Petronas",400,"Petronas","PT","Andy Cowell","Toto Wolff","DHL","DHL1","Lewis Hamilton","Valteri Bottass","Stoffel Vandoorne","Germany","MER");
INSERT INTO Team VALUES("Scuderia Ferrari",400,"Mission Winnow","MW","Louis Camilleri","Mattia Binotto","DHL","DHL1","Sebastian Vettel","Charles Leclerc","Pascal Weherlein","Italy","FER");
INSERT INTO Team VALUES("Red Bull Racing",400,"Aston Martin","AM","Helmut Marko","Christian Horner","UPS","UPS1","Max Verstappen","Alex Albon","Sergio Camarra","Austria","RBR");
INSERT INTO Team VALUES("Mclaren",370,"Gulf","GF","Zak Brown","Andreas Seidl","DHL","DHL1","Carlos Sainz","Lando Norris","Esteban Guitierrez","United Kingdom","MCL");
INSERT INTO Team VALUES("Racing Point",300,"BWT","BWT","Lawrence Stroll","Otmar Szafnauer","DHL","DHL1","Sergio Perez","Lance Stroll","Nico Hulkenberg","United Kingdom","RPF");
INSERT INTO Team VALUES("Renault",320,"Infiniti","INF","Jean Senard","Cyril Abiteboul","DHL","DHL1","Daniel Ricciardo","Esteban Ocon","Guanyu Zhou","France","REN");
INSERT INTO Team VALUES("Scuderia Alpha Tauri",300,"Alpha Tauri","AT","Graham Watson","Franz Tost","UPS","UPS1","Pierre Gasly","Danil Kvyat","Sebastien Buemi","Italy","SAT");
INSERT INTO Team VALUES("Alfa Romeo Racing",270,"Orlen","ORL","John Elkann","Frederic Vasseur","DHL","DHL1","Kimi Raikkonen","Antonio Giovinazzi","Mick Schumacher","Switzerland","ALF");
INSERT INTO Team VALUES("Haas",240,"Richard Mille","RM","Gene Haas","Gunther Steiner","USP","USP1","Romain Grosjean","Kevin Magnussen","Pietro Fittipaldi","USA","HAS");
INSERT INTO Team VALUES("Williams Racing",220,"Lavazza","LZ","Sir Frank Williams","Claire Williams","DHL","DHL1","George Russell","Nicholas Latifi","Jack Aitken","United Kingdom","WIL");


INSERT INTO Car VALUES("Germany","Mercedes AMG Petronas","Pirelli","Mercedes","W11");
INSERT INTO Car VALUES("Italy","Scuderia Ferrari","Pirelli","Ferrari","SF1000");
INSERT INTO Car VALUES("Austria","Red Bull Racing","Pirelli","Honda","RB16");
INSERT INTO Car VALUES("United Kingdom","Mclaren","Pirelli","Renault","MCL35");
INSERT INTO Car VALUES("United Kingdom","Racing Point","Pirelli","Mercedes","RP20");
INSERT INTO Car VALUES("France","Renault","Pirelli","Renault","RS20");
INSERT INTO Car VALUES("Italy","Scuderia Alpha Tauri","Pirelli","Honda","AT01");
INSERT INTO Car VALUES("Switzerland","Alfa Romeo Racing","Pirelli","Ferrari","C39");
INSERT INTO Car VALUES("USA","Haas","Pirelli","Ferrari","VF20");
INSERT INTO Car VALUES("United Kingdom","Williams Racing","Pirelli","Mercedes","FW34");


INSERT INTO FIAStaff VALUES("BG","Brian Gibbons");
INSERT INTO FIAStaff VALUES("GS","Graham Stoker");
INSERT INTO FIAStaff VALUES("TW","Thierry Willemarck");


ALTER TABLE Logistics
DROP COLUMN teamName,
DROP COLUMN arrivalDate,
DROP COLUMN pickupLocation,
DROP COLUMN destination;

INSERT INTO Logistics VALUES("DHL","DHL1");
INSERT INTO Logistics VALUES("UPS","UPS1");


INSERT INTO Sponsor VALUES("PT","Petronas","Oil and Gas","Tengku Aziz");
INSERT INTO Sponsor VALUES("MW","Mission Winnow","Tobacco","Andre Calantzopoulos");
INSERT INTO Sponsor VALUES("AM","Aston Martin","Automotives","Lawrence Stroll");
INSERT INTO Sponsor VALUES("GF","Gulf","Oil and Gas","Eric Johnson");
INSERT INTO Sponsor VALUES("BWT","BWT","Water Treatment","Gerhard Speigner");
INSERT INTO Sponsor VALUES("INF","Infiniti","Automotives","Peyman Kargar");
INSERT INTO Sponsor VALUES("AT","Alpha Tauri","Fashion","Graham Watson");
INSERT INTO Sponsor VALUES("ORL","Orlen","Oil and Petroleum","Daniel Obajtek");
INSERT INTO Sponsor VALUES("RM","Richard Mille","Fashion","Richard Mille");
INSERT INTO Sponsor VALUES("LZ","Lavazza","Beverage","Alberto Lavazza");


ALTER TABLE VenueStaff
DROP venueHead;


INSERT INTO VenueStaff VALUES("David Hall","Venue Chief","Production","PD001"); 
INSERT INTO VenueStaff VALUES("Dennis Bernal","Aero Camera Operator","Production","PD247"); 
INSERT INTO VenueStaff VALUES("Tim Mayer","Camera Observer","Production","PD892"); 
INSERT INTO VenueStaff VALUES("John Reynold","PitLane Camera Operator","Production","PD403"); 
INSERT INTO VenueStaff VALUES("John Reynold","Graphics Developer","Production","PD89"); 
INSERT INTO VenueStaff VALUES("Mark Blundell","Media Systems Engineer","Engineering","E556"); 
INSERT INTO VenueStaff VALUES("Keeva Archer","Track Systems Engineer","Engineering","E318"); 
INSERT INTO VenueStaff VALUES("Nathan Bate","Senior Software Developer","Engineering","E018"); 
INSERT INTO VenueStaff VALUES("Gregory Kane","Press Officer","Business and HR","BHR488"); 
INSERT INTO VenueStaff VALUES("Maira Leigh","Health and Safety Rep","Business and HR","BHR619"); 
INSERT INTO VenueStaff VALUES("Wilfred Richmond","HR Executive","Business and HR","BHR091"); 
INSERT INTO VenueStaff VALUES("Julia Perez","Security Operations Manager","Business and HR","BHR258"); 


INSERT INTO RaceVenue VALUES("2020-7-5","BG","David Hall","Austria","Red Bull Ring","T01");
INSERT INTO RaceVenue VALUES("2020-7-19","BG","David Hall","Hungary","Hungaroring","T02");
INSERT INTO RaceVenue VALUES("2020-8-2","GS","David Hall","United Kingdom","Silverstone Circuit","T03");
INSERT INTO RaceVenue VALUES("2020-8-16","GS","David Hall","Belgium","Circuit de Spa-Francorchamps","T04");
INSERT INTO RaceVenue VALUES("2020-9-6","TW","David Hall","Italy","Autodromo Nazionale di Monza","T05");
INSERT INTO RaceVenue VALUES("2020-9-27","TW","David Hall","Russia","Sochi Autodrom","T06");
INSERT INTO RaceVenue VALUES("2020-10-11","TW","David Hall","Germany","Nurburgring","T07");


INSERT INTO Driver VALUES("F10913","Lewis","Hamilton","Mercedes AMG Petronas","M","United Kingdom",91,35,35);
INSERT INTO Driver VALUES("F12313","Valteri","Bottas","Mercedes AMG Petronas","M","Finland",9,14,31);
INSERT INTO Driver VALUES("F10058","Sebastian","Vettel","Scuderia Ferrari","M","Germany",53,26,33);
INSERT INTO Driver VALUES("F18912","Charles","Leclerc","Scuderia Ferrari","M","Monaco",2,15,23);
INSERT INTO Driver VALUES("F11312","Max","Verstappen","Red Bull Racing","M","Netherlands",9,23,23);
INSERT INTO Driver VALUES("F19002","Alex","Albon","Red Bull Racing","M","Thailand",0,12,24);
INSERT INTO Driver VALUES("F13771","Carlos","Sainz","Mclaren","M","Spain",0,14,26);
INSERT INTO Driver VALUES("F19201","Lando","Norris","Mclaren","M","United Kingdom",0,11,21);
INSERT INTO Driver VALUES("F11981","Sergio","Perez","Racing Point","M","Mexico",1,15,30);
INSERT INTO Driver VALUES("F17268","Lance","Stroll","Racing Point","M","Canada",0,13,22);
INSERT INTO Driver VALUES("F13011","Daniel","Ricciardo","Renault","M","Australia",7,25,31);
INSERT INTO Driver VALUES("F15128","Esteban","Ocon","Renault","M","France",0,12,24);
INSERT INTO Driver VALUES("F17590","Pierre","Gasly","Scuderia Alpha Tauri","M","France",1,12,24);
INSERT INTO Driver VALUES("F14418","Danil","Kvyat","Scuderia Alpha Tauri","M","Russia",0,10,26);
INSERT INTO Driver VALUES("F10780","Kimi","Raikkonen","Alfa Romeo Racing","M","Finland",21,15,41);
INSERT INTO Driver VALUES("F19310","Antonio","Giovinazzi","Alfa Romeo Racing","M","Italy",0,10,26);
INSERT INTO Driver VALUES("F13881","Romain","Grosjean","Haas","M","France",0,13,34);
INSERT INTO Driver VALUES("F14095","Kevin","Magnussen","Haas","M","Denmark",0,11,28);
INSERT INTO Driver VALUES("F18910","George","Russel","Williams Racing","M","United Kingdom",0,9,22);
INSERT INTO Driver VALUES("F19332","Nicholas","Latifi","Williams Racing","M","Canada",0,8,25);


ALTER TABLE Driver ADD CHECK(salary>0);
ALTER TABLE Driver ADD CHECK(gender IN("M","F"));
ALTER TABLE Driver ADD CHECK(teamName IN (Team.teamName));
ALTER TABLE VenueStaff ADD CHECK(department IN("Business and HR","Production","Engineering"));
ALTER TABLE Car ADD CHECK(teamName IN (Team.teamName));
ALTER TABLE Team ADD CHECK(budget>0 AND budget<=400);
ALTER TABLE Team ADD CHECK(sponsorID IN (Sponsors.sponsorID));
ALTER TABLE Driver ADD CHECK(license LIKE ("F1%"));

ALTER TABLE RaceVenue ADD CONSTRAINT fk_FIAchiefID foreign key(fiaChiefID) REFERENCES FIAStaff(fiaChiefID)
ON DELETE SET NULL
ON UPDATE CASCADE;
ALTER TABLE Team ADD CONSTRAINT fk_sponsorID foreign key(sponsorID) REFERENCES Sponsor(sponsorID)
ON DELETE SET NULL
ON UPDATE CASCADE;


CREATE VIEW spectator_view AS SELECT firstName,lastName,Driver.teamName,sponsorName,wins,salary,Driver.country,age
FROM Driver,Team
WHERE Driver.teamName = Team.teamName;

CREATE VIEW technical_view AS SELECT Team.teamName,chassis,engineManf,tyres,budget
FROM Car,Team
WHERE Car.teamName = Team.teamName;

CREATE VIEW steward_view2 AS SELECT DISTINCT FIAchiefID,chassis,Team.teamName,budget,license,firstName,lastName
FROM Car,Team,Driver,FIAstaff
WHERE Car.TeamName = Team.teamName and Driver.teamName = Team.teamName and FIAchiefID="BG";

CREATE ROLE FIA_STAFF;
GRANT SELECT ON steward_view2 TO FIA_STAFF;
GRANT UPDATE,DELETE ON Driver to FIA_STAFF;
GRANT UPDATE,DELETE ON car to FIA_STAFF;
GRANT UPDATE,DELETE ON Team to FIA_STAFF;
GRANT UPDATE,DELETE ON Car to FIA_STAFF;

CREATE ROLE VIEWER;
GRANT SELECT ON spectator_view to VIEWER;

CREATE ROLE ENGINEER;
GRANT SELECT ON technical_view TO ENGINEER;


DELIMITER $$
CREATE TRIGGER sponsor_withdrawl
AFTER DELETE ON sponsor
FOR EACH ROW
BEGIN
DECLARE
	del_id VARCHAR(10);
IF (OLD.sponsorID IS NOT NULL) THEN
	SET@del_id := OLD.sponsorID;
	UPDATE Team
    SET sponsorID = "N/A" AND sponsorName = "N/A"
    WHERE temp = Team.sponsorID;
END IF;
END$$
DELIMITER ;



DELIMITER $$
CREATE TRIGGER deletion_of_team
AFTER DELETE ON Team
FOR EACH ROW
BEGIN
DECLARE
	deleted_name VARCHAR(80);
IF (OLD.teamID IS NOT NULL) THEN
SET@deleted_name:=OLD.teamName;
DELETE FROM Car
where deleted_name=teamName;
END IF;
END$$
DELIMITER ;






