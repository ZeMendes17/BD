-- DROP SCHEMA IF EXISTS FLIGHTS;
-- GO;
-- CREATE SCHEMA FLIGHTS;
-- GO

CREATE TABLE FLIGHTS.AIRPORT(
    AirportCode     CHAR(3) NOT NULL,
    City            VARCHAR(15),
    AirportState    VARCHAR(20),
    AirportName     VARCHAR(20) NOT NULL,

    PRIMARY KEY (AirportCode),
    UNIQUE (AirportName)
);

CREATE TABLE FLIGHTS.AIRPLANE_TYPE(
    TypeName        VARCHAR(20) NOT NULL,
    MaxSeats        INT,
    Company         VARCHAR(10),

    PRIMARY KEY (TypeName)
);

CREATE TABLE FLIGHTS.FLIGHT(
    FlightNumber        VARCHAR(6) NOT NULL,
    Airline             VARCHAR(15),
    WeekDays            VARCHAR(100), -- ARRAY THAT STORES WEEKDAYS

    PRIMARY KEY (FlightNumber)
);

CREATE TABLE FLIGHTS.FLIGHT_LEG(
    LegNo               INT NOT NULL,
    FlightNumber        VARCHAR(6) NOT NULL,
    ScheduleDepTime     TIME,
    ScheduleArrTime     TIME,
    ArrAirportCode      CHAR(3) NOT NULL,
    DepAirportCode      CHAR(3) NOT NULL,

    PRIMARY KEY (LegNo, FlightNumber),
    FOREIGN KEY (FlightNumber) REFERENCES FLIGHTS.FLIGHT(FlightNumber),
    FOREIGN KEY (ArrAirportCode) REFERENCES FLIGHTS.AIRPORT(AirportCode),
    FOREIGN KEY (DepAirportCode) REFERENCES FLIGHTS.AIRPORT(AirportCode)
);

CREATE TABLE FLIGHTS.CAN_LAND(
    AirportCode     CHAR(3) NOT NULL,
    TypeName        VARCHAR(20) NOT NULL,

    PRIMARY KEY (AirportCode, TypeName),
    FOREIGN KEY (AirportCode) REFERENCES FLIGHTS.AIRPORT(AirportCode),
    FOREIGN KEY (TypeName) REFERENCES FLIGHTS.AIRPLANE_TYPE(TypeName)
);

CREATE TABLE FLIGHTS.AIRPLANE(
    AirplaneID          VARCHAR(30) NOT NULL,
    TotalNumberSeats    INT,
    TypeName            VARCHAR(20),

    PRIMARY KEY (AirplaneID),
    FOREIGN KEY (TypeName) REFERENCES FLIGHTS.AIRPLANE_TYPE(TypeName)
);

CREATE TABLE FLIGHTS.FARE(
    Code            VARCHAR(10) NOT NULL,
    Amount          DECIMAL(6,2),
    Restrictions    VARCHAR(1000), -- ARRAY WITH THE RESTRICTIONS
    FlightNumber    VARCHAR(6) NOT NULL,

    PRIMARY KEY (Code, FlightNumber),
    FOREIGN KEY (FlightNumber) REFERENCES FLIGHTS.FLIGHT(FlightNumber)
);

CREATE TABLE FLIGHTS.LEG_INSTANCE(
    LegDate             DATE NOT NULL,
    AirplaneID          VARCHAR(30) NOT NULL,
    LegNo               INT NOT NULL,
    FlightNumber        VARCHAR(6) NOT NULL,
    ArrAirportCode      CHAR(3) NOT NULL,
    DepAirportCode      CHAR(3) NOT NULL,
    NoAvailSeats        INT,
    DepTime             TIME,
    ArrTime             TIME,

    PRIMARY KEY (LegDate, AirplaneID, LegNo, FlightNumber),
    FOREIGN KEY (AirplaneID) REFERENCES FLIGHTS.AIRPLANE(AirplaneID),
    FOREIGN KEY (LegNo,FlightNumber) REFERENCES FLIGHTS.FLIGHT_LEG(LegNo,FlightNumber),
    FOREIGN KEY (ArrAirportCode) REFERENCES FLIGHTS.AIRPORT(AirportCode),
    FOREIGN KEY (DepAirportCode) REFERENCES FLIGHTS.AIRPORT(AirportCode),
);

CREATE TABLE FLIGHTS.SEAT(
    NoSeat          INT NOT NULL,
    LegDate         DATE NOT NULL,
    LegNo           INT NOT NULL,
    AirplaneID      VARCHAR(30) NOT NULL,
    FlightNumber    VARCHAR(6) NOT NULL,
    CPhone          CHAR(9),
    CustomerName    VARCHAR(30) NOT NULL,

    PRIMARY KEY (NoSeat, LegDate, LegNo, FlightNumber, AirplaneID),
    FOREIGN KEY (LegDate, AirplaneID, LegNo, FlightNumber) REFERENCES FLIGHTS.LEG_INSTANCE(LegDate, AirplaneID, LegNo, FlightNumber),

);