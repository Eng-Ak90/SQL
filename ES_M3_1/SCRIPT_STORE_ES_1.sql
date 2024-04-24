-- Creazione della tabella Store
CREATE TABLE Store (
    IdStore INT PRIMARY KEY NOT NULL,
    StoreAddress VARCHAR(255),
    PhoneNumberStore VARCHAR(20)
);
CREATE TABLE WorkingPlace (
    WorkStartDate DATE,
    WorkEndDate DATE,
    Role VARCHAR(100),
    IdStore INT,
    FiscalCode VARCHAR(20), -- Modifica la dimensione della colonna a VARCHAR(20)
    FOREIGN KEY (IdStore) REFERENCES Store(IdStore),
    FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode)
);
CREATE TABLE Employee (
    FiscalCode VARCHAR(20) PRIMARY KEY NOT NULL,
    Name VARCHAR(50),
    Surname VARCHAR(50),
    School VARCHAR(100),
    PhoneNumberWorker VARCHAR(20)
);

-- Creazione della tabella VideoGame
CREATE TABLE VideoGame (
    VideoGameId INT PRIMARY KEY NOT NULL,
    Title VARCHAR(100),
    Platform VARCHAR(50),
    ReleaseYear INT,
    Price DECIMAL(10, 2),
    IdStore INT,
    FOREIGN KEY (IdStore) REFERENCES Store(IdStore)
);
-- Creazione della tabella VideoGameInventory
CREATE TABLE VideoGameInventory (
    InventoryId INT PRIMARY KEY NOT NULL,
    VideoGameId INT,
    Quantity INT,
    FOREIGN KEY (VideoGameId) REFERENCES VideoGame(VideoGameId)
);
-- Creazione della tabella GameOrder
CREATE TABLE GameOrder (
    OrderId INT PRIMARY KEY NOT NULL,
    OrderDate DATE,
    IdStore INT,
    FiscalCode VARCHAR(20),
    FOREIGN KEY (IdStore) REFERENCES Store(IdStore),
    FOREIGN KEY (FiscalCode) REFERENCES Employee(FiscalCode)
);

-- Creazione della tabella GameOrderItem
employeeemployeeemployeeCREATE TABLE GameOrderItem (
    OrderItemId INT PRIMARY KEY NOT NULL,
    OrderId INT,
    VideoGameId INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderId) REFERENCES GameOrder(OrderId),
    FOREIGN KEY (VideoGameId) REFERENCES VideoGame(VideoGameId)
);