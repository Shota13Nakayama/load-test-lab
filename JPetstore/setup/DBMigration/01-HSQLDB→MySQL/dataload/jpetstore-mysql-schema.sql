-- jpetstore-mysql-schema.sql

CREATE TABLE supplier (
    suppid INT NOT NULL,
    name VARCHAR(80) NULL,
    status VARCHAR(2) NOT NULL,
    addr1 VARCHAR(80) NULL,
    addr2 VARCHAR(80) NULL,
    city VARCHAR(80) NULL,
    state VARCHAR(80) NULL,
    zip VARCHAR(5) NULL,
    phone VARCHAR(80) NULL,
    PRIMARY KEY (suppid)
);

CREATE TABLE signon (
    username VARCHAR(25) NOT NULL,
    password VARCHAR(25) NOT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE account (
    userid VARCHAR(80) NOT NULL,
    email VARCHAR(80) NOT NULL,
    firstname VARCHAR(80) NOT NULL,
    lastname VARCHAR(80) NOT NULL,
    status VARCHAR(2) NULL,
    addr1 VARCHAR(80) NOT NULL,
    addr2 VARCHAR(40) NULL,
    city VARCHAR(80) NOT NULL,
    state VARCHAR(80) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    country VARCHAR(20) NOT NULL,
    phone VARCHAR(80) NOT NULL,
    PRIMARY KEY (userid)
);

CREATE TABLE profile (
    userid VARCHAR(80) NOT NULL,
    langpref VARCHAR(80) NOT NULL,
    favcategory VARCHAR(30),
    mylistopt INT,
    banneropt INT,
    PRIMARY KEY (userid)
);

CREATE TABLE bannerdata (
    favcategory VARCHAR(80) NOT NULL,
    bannername VARCHAR(255) NULL,
    PRIMARY KEY (favcategory)
);

CREATE TABLE orders (
    orderid INT NOT NULL AUTO_INCREMENT,
    userid VARCHAR(80) NOT NULL,
    orderdate DATETIME NOT NULL,
    shipaddr1 VARCHAR(80) NOT NULL,
    shipaddr2 VARCHAR(80) NULL,
    shipcity VARCHAR(80) NOT NULL,
    shipstate VARCHAR(80) NOT NULL,
    shipzip VARCHAR(20) NOT NULL,
    shipcountry VARCHAR(20) NOT NULL,
    billaddr1 VARCHAR(80) NOT NULL,
    billaddr2 VARCHAR(80) NULL,
    billcity VARCHAR(80) NOT NULL,
    billstate VARCHAR(80) NOT NULL,
    billzip VARCHAR(20) NOT NULL,
    billcountry VARCHAR(20) NOT NULL,
    courier VARCHAR(80) NOT NULL,
    totalprice DECIMAL(10,2) NOT NULL,
    billtofirstname VARCHAR(80) NOT NULL,
    billtolastname VARCHAR(80) NOT NULL,
    shiptofirstname VARCHAR(80) NOT NULL,
    shiptolastname VARCHAR(80) NOT NULL,
    creditcard VARCHAR(80) NOT NULL,
    exprdate VARCHAR(7) NOT NULL,
    cardtype VARCHAR(80) NOT NULL,
    locale VARCHAR(80) NOT NULL,
    PRIMARY KEY (orderid)
);

CREATE TABLE orderstatus (
    orderid INT NOT NULL,
    linenum INT NOT NULL,
    timestamp DATETIME NOT NULL,
    status VARCHAR(2) NOT NULL,
    PRIMARY KEY (orderid, linenum)
);

CREATE TABLE lineitem (
    orderid INT NOT NULL,
    linenum INT NOT NULL,
    itemid VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    unitprice DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (orderid, linenum)
);

CREATE TABLE category (
    catid VARCHAR(10) NOT NULL,
    name VARCHAR(80) NULL,
    descn VARCHAR(255) NULL,
    PRIMARY KEY (catid)
);

CREATE TABLE product (
    productid VARCHAR(10) NOT NULL,
    category VARCHAR(10) NOT NULL,
    name VARCHAR(80) NULL,
    descn VARCHAR(255) NULL,
    PRIMARY KEY (productid),
    FOREIGN KEY (category) REFERENCES category (catid)
);

CREATE INDEX productCat ON product (category);
CREATE INDEX productName ON product (name);

CREATE TABLE item (
    itemid VARCHAR(10) NOT NULL,
    productid VARCHAR(10) NOT NULL,
    listprice DECIMAL(10,2) NULL,
    unitcost DECIMAL(10,2) NULL,
    supplier INT NULL,
    status VARCHAR(2) NULL,
    attr1 VARCHAR(80) NULL,
    attr2 VARCHAR(80) NULL,
    attr3 VARCHAR(80) NULL,
    attr4 VARCHAR(80) NULL,
    attr5 VARCHAR(80) NULL,
    PRIMARY KEY (itemid),
    FOREIGN KEY (productid) REFERENCES product (productid),
    FOREIGN KEY (supplier) REFERENCES supplier (suppid)
);

CREATE INDEX itemProd ON item (productid);

CREATE TABLE inventory (
    itemid VARCHAR(10) NOT NULL,
    qty INT NOT NULL,
    PRIMARY KEY (itemid)
);

CREATE TABLE sequence (
    name VARCHAR(30) NOT NULL,
    nextid INT NOT NULL,
    PRIMARY KEY (name)
);
