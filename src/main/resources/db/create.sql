SET MODE PostgreSQL;

CREATE TABLE IF NOT EXISTS users (
                                     id int PRIMARY KEY auto_increment,
                                     first_name VARCHAR,
                                     username VARCHAR,
                                     email VARCHAR,
                                     password VARCHAR
);
SET MODE PostgreSQL;

CREATE TABLE IF NOT EXISTS products (
                                     id int PRIMARY KEY auto_increment,
                                    user_id int,
                                    image VARCHAR ,
                                    product_name VARCHAR ,
                                    price int
);
CREATE TABLE IF NOT EXISTS carts (
                                        id int PRIMARY KEY auto_increment,
                                        user_id int,
                                        product_id int,
                                        image VARCHAR ,
                                        product_name VARCHAR ,
                                        price int,
                                        quantity int
);