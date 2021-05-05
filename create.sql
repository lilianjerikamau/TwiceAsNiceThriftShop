CREATE DATABASE thriftshop;
\c thriftshop;

CREATE TABLE users (id SERIAL PRIMARY KEY,
                    username VARCHAR,
                    password VARCHAR);

CREATE TABLE products (id SERIAL PRIMARY KEY,
                       user_id int,
                       product_name VARCHAR ,
                       price int,
                        image VARCHAR );

CREATE TABLE carts (id SERIAL PRIMARY KEY,
                    user_id int,
                    product_name VARCHAR,
                    product_id int,
                    image VARCHAR,
                    price int,
                    quantity int);
CREATE DATABASE thriftshop_test WITH TEMPLATE thriftshop;