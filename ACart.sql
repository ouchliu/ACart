CREATE TABLE users (
    id          SERIAL PRIMARY KEY,
    name        TEXT UNIQUE NOT NULL,
    role        TEXT NOT NULL,
    age		INT,
    state   	TEXT
);

CREATE TABLE states (
    id          SERIAL PRIMARY KEY,
    name	TEXT
);

CREATE TABLE roles (
    id          SERIAL PRIMARY KEY,
    name	TEXT
);

CREATE TABLE categories (
    id		SERIAL PRIMARY KEY,
    name	TEXT UNIQUE NOT NULL,
    description TEXT 
)

CREATE TABLE products (
    id		SERIAL PRIMARY KEY,
    name	TEXT UNIQUE NOT NULL,
    SKU		INT NOT NULL,
    category    TEXT NOT NULL,
    price	DECIMAL,
    FOREIGN KEY (category) REFERENCES categories(name)
)

INSERT INTO states (name) values ('Alabama');
INSERT INTO states (name) values ('Alaska');
INSERT INTO states (name) values ('Arizona');
INSERT INTO states (name) values ('Arkansas');
INSERT INTO states (name) values ('California');
INSERT INTO states (name) values ('Colorado');
INSERT INTO states (name) values ('Connecticut');
INSERT INTO states (name) values ('Delaware');
INSERT INTO states (name) values ('District of Columbia');
INSERT INTO states (name) values ('Florida');
INSERT INTO states (name) values ('Georgia');
INSERT INTO states (name) values ('Hawaii');
INSERT INTO states (name) values ('Idaho');
INSERT INTO states (name) values ('Illinois');
INSERT INTO states (name) values ('Indiana');
INSERT INTO states (name) values ('Iowa');
INSERT INTO states (name) values ('Kansas');
INSERT INTO states (name) values ('Kentucky');
INSERT INTO states (name) values ('Louisiana');
INSERT INTO states (name) values ('Maine');
INSERT INTO states (name) values ('Maryland');
INSERT INTO states (name) values ('Massachusetts');
INSERT INTO states (name) values ('Michigan');
INSERT INTO states (name) values ('Minnesota');
INSERT INTO states (name) values ('Mississippi');
INSERT INTO states (name) values ('Missouri');
INSERT INTO states (name) values ('Montana');
INSERT INTO states (name) values ('Nebraska');
INSERT INTO states (name) values ('Nevada');
INSERT INTO states (name) values ('New Hampshire');
INSERT INTO states (name) values ('New Jersey');
INSERT INTO states (name) values ('New Mexico');
INSERT INTO states (name) values ('New York');
INSERT INTO states (name) values ('North Carolina');
INSERT INTO states (name) values ('North Dakata');
INSERT INTO states (name) values ('Ohio');
INSERT INTO states (name) values ('Oklahoma');
INSERT INTO states (name) values ('Oregon');
INSERT INTO states (name) values ('Pennsylvania');
INSERT INTO states (name) values ('Rhode Island');
INSERT INTO states (name) values ('South Carolina');
INSERT INTO states (name) values ('South Dakota');
INSERT INTO states (name) values ('Tennessee');
INSERT INTO states (name) values ('Texas');
INSERT INTO states (name) values ('Utah');
INSERT INTO states (name) values ('Vermont');
INSERT INTO states (name) values ('Virginia');
INSERT INTO states (name) values ('Washington');
INSERT INTO states (name) values ('West Virginia');
INSERT INTO states (name) values ('Wisconsin');
INSERT INTO states (name) values ('Wyoming');

INSERT INTO roles (name) values ('Owner');
INSERT INTO roles (name) values ('Customer');



