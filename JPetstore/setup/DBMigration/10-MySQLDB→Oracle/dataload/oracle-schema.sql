-- jpetstore-oracle-schema.sql

CREATE TABLE supplier (
    suppid NUMBER(10) NOT NULL,
    name VARCHAR2(80),
    status VARCHAR2(2) NOT NULL,
    addr1 VARCHAR2(80),
    addr2 VARCHAR2(80),
    city VARCHAR2(80),
    state VARCHAR2(80),
    zip VARCHAR2(5),
    phone VARCHAR2(80),
    CONSTRAINT pk_supplier PRIMARY KEY (suppid)
);

CREATE TABLE signon (
    username VARCHAR2(25) NOT NULL,
    password VARCHAR2(25) NOT NULL,
    CONSTRAINT pk_signon PRIMARY KEY (username)
);

CREATE TABLE account (
    userid VARCHAR2(80) NOT NULL,
    email VARCHAR2(80) NOT NULL,
    firstname VARCHAR2(80) NOT NULL,
    lastname VARCHAR2(80) NOT NULL,
    status VARCHAR2(2),
    addr1 VARCHAR2(80) NOT NULL,
    addr2 VARCHAR2(40),
    city VARCHAR2(80) NOT NULL,
    state VARCHAR2(80) NOT NULL,
    zip VARCHAR2(20) NOT NULL,
    country VARCHAR2(20) NOT NULL,
    phone VARCHAR2(80) NOT NULL,
    CONSTRAINT pk_account PRIMARY KEY (userid)
);

CREATE TABLE profile (
    userid VARCHAR2(80) NOT NULL,
    langpref VARCHAR2(80) NOT NULL,
    favcategory VARCHAR2(30),
    mylistopt NUMBER(1),
    banneropt NUMBER(1),
    CONSTRAINT pk_profile PRIMARY KEY (userid)
);

CREATE TABLE bannerdata (
    favcategory VARCHAR2(80) NOT NULL,
    bannername VARCHAR2(255),
    CONSTRAINT pk_bannerdata PRIMARY KEY (favcategory)
);

CREATE SEQUENCE orders_seq START WITH 1000 INCREMENT BY 1;

CREATE TABLE orders (
    orderid NUMBER(10) NOT NULL,
    userid VARCHAR2(80) NOT NULL,
    orderdate DATE NOT NULL,
    shipaddr1 VARCHAR2(80) NOT NULL,
    shipaddr2 VARCHAR2(80),
    shipcity VARCHAR2(80) NOT NULL,
    shipstate VARCHAR2(80) NOT NULL,
    shipzip VARCHAR2(20) NOT NULL,
    shipcountry VARCHAR2(20) NOT NULL,
    billaddr1 VARCHAR2(80) NOT NULL,
    billaddr2 VARCHAR2(80),
    billcity VARCHAR2(80) NOT NULL,
    billstate VARCHAR2(80) NOT NULL,
    billzip VARCHAR2(20) NOT NULL,
    billcountry VARCHAR2(20) NOT NULL,
    courier VARCHAR2(80) NOT NULL,
    totalprice NUMBER(10,2) NOT NULL,
    billtofirstname VARCHAR2(80) NOT NULL,
    billtolastname VARCHAR2(80) NOT NULL,
    shiptofirstname VARCHAR2(80) NOT NULL,
    shiptolastname VARCHAR2(80) NOT NULL,
    creditcard VARCHAR2(80) NOT NULL,
    exprdate VARCHAR2(7) NOT NULL,
    cardtype VARCHAR2(80) NOT NULL,
    locale VARCHAR2(80) NOT NULL,
    CONSTRAINT pk_orders PRIMARY KEY (orderid)
);

CREATE TABLE orderstatus (
    orderid NUMBER(10) NOT NULL,
    linenum NUMBER(10) NOT NULL,
    timestamp DATE NOT NULL,
    status VARCHAR2(2) NOT NULL,
    CONSTRAINT pk_orderstatus PRIMARY KEY (orderid, linenum)
);

CREATE TABLE lineitem (
    orderid NUMBER(10) NOT NULL,
    linenum NUMBER(10) NOT NULL,
    itemid VARCHAR2(10) NOT NULL,
    quantity NUMBER(10) NOT NULL,
    unitprice NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_lineitem PRIMARY KEY (orderid, linenum)
);

CREATE TABLE category (
    catid VARCHAR2(10) NOT NULL,
    name VARCHAR2(80),
    descn VARCHAR2(255),
    CONSTRAINT pk_category PRIMARY KEY (catid)
);

CREATE TABLE product (
    productid VARCHAR2(10) NOT NULL,
    category VARCHAR2(10) NOT NULL,
    name VARCHAR2(80),
    descn VARCHAR2(255),
    CONSTRAINT pk_product PRIMARY KEY (productid),
    CONSTRAINT fk_product_1 FOREIGN KEY (category) REFERENCES category (catid)
);

CREATE INDEX productCat ON product (category);
CREATE INDEX productName ON product (name);

CREATE TABLE item (
    itemid VARCHAR2(10) NOT NULL,
    productid VARCHAR2(10) NOT NULL,
    listprice NUMBER(10,2),
    unitcost NUMBER(10,2),
    supplier NUMBER(10),
    status VARCHAR2(2),
    attr1 VARCHAR2(80),
    attr2 VARCHAR2(80),
    attr3 VARCHAR2(80),
    attr4 VARCHAR2(80),
    attr5 VARCHAR2(80),
    CONSTRAINT pk_item PRIMARY KEY (itemid),
    CONSTRAINT fk_item_1 FOREIGN KEY (productid) REFERENCES product (productid),
    CONSTRAINT fk_item_2 FOREIGN KEY (supplier) REFERENCES supplier (suppid)
);

CREATE INDEX itemProd ON item (productid);

CREATE TABLE inventory (
    itemid VARCHAR2(10) NOT NULL,
    qty NUMBER(10) NOT NULL,
    CONSTRAINT pk_inventory PRIMARY KEY (itemid)
);

CREATE TABLE sequence (
    name VARCHAR2(30) NOT NULL,
    nextid NUMBER(10) NOT NULL,
    CONSTRAINT pk_sequence PRIMARY KEY (name)
);

CREATE SEQUENCE ORDER_SEQ START WITH 1 INCREMENT BY 1;
GRANT SELECT ON ORDER_SEQ TO jpetstore;