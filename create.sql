CREATE DATABASE thriftshop;
\c thriftshop;

CREATE TABLE users (id SERIAL PRIMARY KEY,
                    username VARCHAR,
                    password VARCHAR);

CREATE TABLE products (id SERIAL PRIMARY KEY,
                       product_name VARCHAR ,
                       price  DOUBLE PRECISION);
CREATE TABLE carts (id SERIAL PRIMARY KEY,
                    user_id int,
                    product_id int,
                    quantity int);

CREATE DATABASE thriftshop_test WITH TEMPLATE thriftshop;