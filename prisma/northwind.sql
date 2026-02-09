--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;



SET default_tablespace = '';

SET default_with_oids = false;


---
--- drop tables
---

DROP TABLE IF EXISTS employee_territories;
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS shippers;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS territories;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS employees;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    category_id uuid NOT NULL,
    category_name character varying(15) NOT NULL,
    description text
);



--
-- Name: customers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE customers (
    customer_id uuid NOT NULL,
    company_name character varying(40) NOT NULL,
    contact_name character varying(30),
    contact_title character varying(30),
    address character varying(60),
    city character varying(15),
    region character varying(15),
    postal_code character varying(10),
    country character varying(15),
    phone character varying(24),
    fax character varying(24)
);


--
-- Name: employees; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE employees (
    employee_id uuid NOT NULL,
    last_name character varying(20) NOT NULL,
    first_name character varying(10) NOT NULL,
    title character varying(30),
    title_of_courtesy character varying(25),
    birth_date date,
    hire_date date,
    address character varying(60),
    city character varying(15),
    region character varying(15),
    postal_code character varying(10),
    country character varying(15),
    home_phone character varying(24),
    extension character varying(4),
    notes text,
    reports_to uuid,
    photo_path character varying(255)
);


--
-- Name: employee_territories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE employee_territories (
    employee_id uuid NOT NULL,
    territory_id uuid NOT NULL
);




--
-- Name: order_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE order_details (
    order_id uuid NOT NULL,
    product_id uuid NOT NULL,
    unit_price real NOT NULL,
    quantity smallint NOT NULL,
    discount real NOT NULL
);


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE orders (
    order_id uuid NOT NULL,
    customer_id uuid,
    employee_id uuid,
    order_date date,
    required_date date,
    shipped_date date,
    ship_via uuid,
    freight real,
    ship_name character varying(40),
    ship_address character varying(60),
    ship_city character varying(15),
    ship_region character varying(15),
    ship_postal_code character varying(10),
    ship_country character varying(15)
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE products (
    product_id uuid NOT NULL,
    product_name character varying(40) NOT NULL,
    supplier_id uuid,
    category_id uuid,
    quantity_per_unit character varying(20),
    unit_price real,
    units_in_stock smallint,
    units_on_order smallint,
    reorder_level smallint,
    discontinued boolean NOT NULL
);


--
-- Name: region; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE region (
    region_id uuid NOT NULL,
    region_description character varying(60) NOT NULL
);


--
-- Name: shippers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE shippers (
    shipper_id uuid NOT NULL,
    company_name character varying(40) NOT NULL,
    phone character varying(24)
);



--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE suppliers (
    supplier_id uuid NOT NULL,
    company_name character varying(40) NOT NULL,
    contact_name character varying(30),
    contact_title character varying(30),
    address character varying(60),
    city character varying(15),
    region character varying(15),
    postal_code character varying(10),
    country character varying(15),
    phone character varying(24),
    fax character varying(24),
    homepage text
);


--
-- Name: territories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE territories (
    territory_id uuid NOT NULL,
    territory_description character varying(60) NOT NULL,
    region_id uuid NOT NULL
);



--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO categories VALUES ('6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', 'Beverages', 'Soft drinks, coffees, teas, beers, and ales');
INSERT INTO categories VALUES ('35a9d0ed-3417-4b37-948f-43df3219c5c8', 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings');
INSERT INTO categories VALUES ('27c8a25b-ab1b-47a4-afd3-f2158e424ad9', 'Confections', 'Desserts, candies, and sweet breads');
INSERT INTO categories VALUES ('d4abd129-8b40-4595-a8ff-3fa4b04d566c', 'Dairy Products', 'Cheeses');
INSERT INTO categories VALUES ('611cbaf4-b389-4bd1-ac3f-70377675588c', 'Grains/Cereals', 'Breads, crackers, pasta, and cereal');
INSERT INTO categories VALUES ('573a2320-b924-477b-8c65-55825aeaf906', 'Meat/Poultry', 'Prepared meats');
INSERT INTO categories VALUES ('308b9b98-9ff2-4fff-975e-e61770d75533', 'Produce', 'Dried fruit and bean curd');
INSERT INTO categories VALUES ('dabe8426-04f2-4b8c-85d4-e6289ee880e6', 'Seafood', 'Seaweed and fish');



--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO customers VALUES ('817f71c0-4a9e-4196-b6be-2be0c2a53d85', 'Ember Trading House', 'Penelope Flores', 'Assistant Sales Representative', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany', '030-0074321', '030-0076545');
INSERT INTO customers VALUES ('ccee083f-d880-4792-b08c-4059192a96a7', 'Kingston Supply Group', 'Nathan Butler', 'Marketing Manager', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico', '(5) 555-4729', '(5) 555-3745');
INSERT INTO customers VALUES ('a3cd2482-6d56-4140-b063-ec86ab178603', 'Xenon Retail Corp', 'Scarlett Perry', 'Sales Manager', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico', '(5) 555-3932', NULL);
INSERT INTO customers VALUES ('0d8202b4-6a2c-42ce-8e57-8626b3dc1364', 'Delta Commerce Partners', 'Zoe Barnes', 'Accounting Manager', '120 Hanover Sq.', 'London', NULL, 'WA1 1DP', 'UK', '(171) 555-7788', '(171) 555-6750');
INSERT INTO customers VALUES ('216c4816-2434-466a-98ee-252ad3d9d933', 'Alpine Trading Solutions', 'Jack Cooper', 'Sales Manager', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden', '0921-12 34 65', '0921-12 34 67');
INSERT INTO customers VALUES ('aaa1023c-07bb-4f15-8278-1f9c43d16275', 'Atlas Trading Partners', 'Ethan Woods', 'Assistant Sales Representative', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany', '0621-08460', '0621-08924');
INSERT INTO customers VALUES ('d00b541e-ef93-4148-9fe8-e36d3d9ce734', 'Ironwood Retail Partners', 'Vincent Price', 'Marketing Assistant', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France', '88.60.15.31', '88.60.15.32');
INSERT INTO customers VALUES ('9f303dd7-f723-44ca-83ab-1076b4d8c364', 'Mercury Wholesale Group', 'Oliver Russell', 'Marketing Assistant', 'C/ Araquil, 67', 'Madrid', NULL, '28023', 'Spain', '(91) 555 22 82', '(91) 555 91 99');
INSERT INTO customers VALUES ('023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'Willow Supply Group', 'Evelyn Hall', 'Order Administrator', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France', '91.24.45.40', '91.24.45.41');
INSERT INTO customers VALUES ('b331de10-47a7-468f-98db-ad5c2d1a041f', 'Teak Wholesale Co', 'Abigail Wood', 'Sales Manager', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada', '(604) 555-4729', '(604) 555-3745');
INSERT INTO customers VALUES ('cd654708-1a85-4fcf-a5a4-777b0c069ba5', 'Unity Distribution Ltd', 'Penelope Henderson', 'Order Administrator', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK', '(171) 555-1212', NULL);
INSERT INTO customers VALUES ('26240386-a6ca-4a18-910d-904cde61d93b', 'Dawn Supply Ltd', 'Hannah Russell', 'Sales Manager', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina', '(1) 135-5555', '(1) 135-4892');
INSERT INTO customers VALUES ('fcbb08d1-ce02-4951-a597-066be861a06d', 'Quince Commerce Solutions', 'Natalie Price', 'Owner', 'Sierras de Granada 9993', 'México D.F.', NULL, '05022', 'Mexico', '(5) 555-3392', '(5) 555-7293');
INSERT INTO customers VALUES ('346cfbc3-e2c8-4c26-92ec-df34bad2e944', 'Glacier Commerce Ltd', 'Isabella Stewart', 'Sales Associate', 'Hauptstr. 29', 'Bern', NULL, '3012', 'Switzerland', '0452-076545', NULL);
INSERT INTO customers VALUES ('1d3de59b-fd0b-4277-8192-b02fda2e41db', 'Oak Retail Systems', 'Ethan Stewart', 'Assistant Sales Representative', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil', '(11) 555-7647', NULL);
INSERT INTO customers VALUES ('b272f285-be56-42e4-9a3b-b1ca1e35c44c', 'Magnolia Distribution Co', 'James Butler', 'Assistant Sales Agent', 'Berkeley Gardens 12  Brewery', 'London', NULL, 'WX1 6LT', 'UK', '(171) 555-2282', '(171) 555-9199');
INSERT INTO customers VALUES ('2a76dd54-c4c4-410f-bc6c-4d9f8a992e4d', 'Arbor Distribution Co', 'Ella Robinson', 'Assistant Sales Agent', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany', '0241-039123', '0241-059428');
INSERT INTO customers VALUES ('c81e7c16-d8f1-43a8-a1c4-27847709ce21', 'Elm Commerce Group', 'Alexander Baker', 'Assistant Sales Representative', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France', '40.67.88.88', '40.67.89.89');
INSERT INTO customers VALUES ('00c51812-32fe-4ea7-93cd-6ac81afcce12', 'Phoenix Trading Inc', 'Gabriel Wallace', 'Sales Agent', '35 King George', 'London', NULL, 'WX3 6FW', 'UK', '(171) 555-0297', '(171) 555-3373');
INSERT INTO customers VALUES ('1b7d3237-76cf-49fc-89a7-2e7668507cde', 'Hawthorn Distribution Co', 'Abigail Sullivan', 'Sales Manager', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria', '7675-3425', '7675-3426');
INSERT INTO customers VALUES ('1d42c341-838e-44f6-9a56-d831af2dfcff', 'Jetty Trading Solutions', 'Violet Bailey', 'Sales Representative', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil', '(11) 555-9857', NULL);
INSERT INTO customers VALUES ('6eaab654-3a74-4457-bbb8-ed846e39edf0', 'Zephyr Wholesale Co', 'Violet Murphy', 'Assistant Sales Representative', 'C/ Moralzarzal, 86', 'Madrid', NULL, '28034', 'Spain', '(91) 555 94 44', '(91) 555 55 93');
INSERT INTO customers VALUES ('c215d346-d4e2-43cc-911e-2e4fd17a370d', 'Grove Wholesale Ltd', 'Nathan Flores', 'Owner', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France', '20.16.10.16', '20.16.10.17');
INSERT INTO customers VALUES ('42a480f6-9c97-44c5-b327-9198e5e274e4', 'Nutmeg Trading Partners', 'Ella Torres', 'Marketing Assistant', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden', '0695-34 67 21', NULL);
INSERT INTO customers VALUES ('93eee301-36bd-466c-af34-ac22fd4afdb7', 'Cedar Distribution Partners', 'Matthew Clark', 'Sales Representative', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany', '089-0877310', '089-0877451');
INSERT INTO customers VALUES ('77ffa2f5-8e8d-41b5-9af1-52327fcfb0c7', 'Frontier Goods International', 'Lillian Wood', 'Marketing Assistant', '54, rue Royale', 'Nantes', NULL, '44000', 'France', '40.32.21.21', '40.32.21.20');
INSERT INTO customers VALUES ('05464425-fc77-4a44-9a69-5f6f6ec147b9', 'Crimson Distribution Co', 'William Butler', 'Sales Manager', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy', '011-4988260', '011-4988261');
INSERT INTO customers VALUES ('73ac725b-10e5-410f-bddd-d9c60fd0ec46', 'Acorn Trading House', 'Layla Bailey', 'Sales Representative', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal', '(1) 354-2534', '(1) 354-2535');
INSERT INTO customers VALUES ('d3cbab71-5f3b-4754-9ccb-19e009469e7b', 'Summit Trade Group', 'Isabella Bell', 'Assistant Sales Agent', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '08022', 'Spain', '(93) 203 4560', '(93) 203 4561');
INSERT INTO customers VALUES ('74661752-05c4-445c-9b23-573d5c0d6e19', 'Kapok Supply Solutions', 'Bella Kelly', 'Sales Representative', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain', '(95) 555 82 82', NULL);
INSERT INTO customers VALUES ('f7f06986-6907-4481-92af-bfc5511a56e7', 'Ultra Retail Systems', 'Oliver Anderson', 'Marketing Assistant', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil', '(11) 555-9482', NULL);
INSERT INTO customers VALUES ('db47b86c-f70d-48c0-8d2b-e1d98894bc00', 'Xavier Trading Partners', 'Leah Lopez', 'Sales Associate', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA', '(503) 555-7555', NULL);
INSERT INTO customers VALUES ('4778376a-e73d-4c29-9124-abc9f9265689', 'Umbra Retail Partners', 'Grace Cole', 'Order Administrator', '5ª Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela', '(2) 283-2951', '(2) 283-3397');
INSERT INTO customers VALUES ('ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', 'Emerald Trading Group', 'Joseph Green', 'Order Administrator', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil', '(21) 555-0091', '(21) 555-8765');
INSERT INTO customers VALUES ('0ef4332c-6383-486b-a577-0156519db661', 'Beacon Supply Co', 'Isabella King', 'Accounting Manager', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela', '(5) 555-1340', '(5) 555-1948');
INSERT INTO customers VALUES ('e90985b6-e765-4c89-895f-fa2337e72a16', 'Gateway Trading House', 'Ethan Flores', 'Order Administrator', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA', '(503) 555-6874', '(503) 555-2376');
INSERT INTO customers VALUES ('a21a6b01-37f1-4462-95f2-595326e090f6', 'Yew Commerce Systems', 'Jonathan Ward', 'Assistant Sales Agent', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland', '2967 542', '2967 3333');
INSERT INTO customers VALUES ('76b913eb-25b1-4e3a-9fa9-ee6179e5489e', 'Highland Trading House', 'Aurora Murphy', 'Sales Associate', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK', '(198) 555-8888', NULL);
INSERT INTO customers VALUES ('bf9c8246-f18b-45ec-8733-a1728259b5a6', 'Fir Trading Systems', 'Emma King', 'Sales Associate', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany', '0555-09876', NULL);
INSERT INTO customers VALUES ('18ac5db2-45c7-43e3-8672-977d5befdb5a', 'Driftwood Supply Co', 'Claire Turner', 'Sales Representative', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France', '30.59.84.10', '30.59.85.11');
INSERT INTO customers VALUES ('3130b75e-08d7-4937-bfde-1974a03c950a', 'Spruce Distribution Ltd', 'Evelyn Griffin', 'Sales Representative', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France', '61.77.61.10', '61.77.61.11');
INSERT INTO customers VALUES ('1ea1f996-0e67-4874-b697-9817333eeb70', 'Eden Commerce Group', 'Nora Hayes', 'Marketing Assistant', '1900 Oak St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada', '(604) 555-3392', '(604) 555-7293');
INSERT INTO customers VALUES ('c4ff5bd7-09c1-4721-b196-e259f82a77d3', 'Yarrow Commerce Ltd', 'Jonathan Washington', 'Assistant Sales Representative', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA', '(509) 555-7969', '(509) 555-6221');
INSERT INTO customers VALUES ('79222616-f296-416f-a386-57a31c0d15d7', 'Valor Distribution Co', 'Evan Watson', 'Marketing Manager', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany', '069-0245984', '069-0245874');
INSERT INTO customers VALUES ('c71720d2-cb57-45c6-8b31-7a7b96f72646', 'Olympus Distribution Co', 'Samuel Wright', 'Sales Manager', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA', '(415) 555-5938', NULL);
INSERT INTO customers VALUES ('dee5c028-aa79-4d8c-b27c-043afa72bce1', 'Westwind Merchants', 'Joshua Patterson', 'Sales Associate', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela', '(9) 331-6954', '(9) 331-7256');
INSERT INTO customers VALUES ('e03bf9cd-810e-46fd-b925-48e73c12756a', 'Inlet Retail Partners', 'Jack Ford', 'Marketing Assistant', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela', '(8) 34-56-12', '(8) 34-93-93');
INSERT INTO customers VALUES ('e56705d0-d0c1-463d-a72a-43b95b4e4c45', 'Pine Supply Group', 'Henry Graham', 'Sales Representative', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA', '(503) 555-9573', '(503) 555-9646');
INSERT INTO customers VALUES ('53e16308-5b76-4e70-b284-fe5958e79a0e', 'Jade Distribution Co', 'Alexander Phillips', 'Sales Manager', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy', '035-640230', '035-640231');
INSERT INTO customers VALUES ('eb488881-56d2-4219-a3b5-26ff37fb74be', 'Cobalt Commerce Group', 'Ryan Perry', 'Assistant Sales Agent', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium', '(02) 201 24 67', '(02) 201 24 68');
INSERT INTO customers VALUES ('5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', 'Nordic Wholesale Ltd', 'Aurora Mitchell', 'Owner', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada', '(514) 555-8054', '(514) 555-8055');
INSERT INTO customers VALUES ('404621e7-d665-4801-bfce-aa17d22b435f', 'Neptune Commerce Ltd', 'Victoria Phillips', 'Accounting Manager', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany', '0342-023176', NULL);
INSERT INTO customers VALUES ('1e6dd3f8-3c44-4fac-9b97-016270116762', 'Frost Supply Partners', 'Lillian Henderson', 'Sales Manager', 'South House 300 Queensbridge', 'London', NULL, 'SW7 1RZ', 'UK', '(171) 555-7733', '(171) 555-2530');
INSERT INTO customers VALUES ('ee578022-9abf-46ca-ad0e-76be2b19007c', 'Bloom Trading Partners', 'Gabriel Washington', 'Marketing Assistant', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina', '(1) 135-5333', '(1) 135-5535');
INSERT INTO customers VALUES ('7353f783-745c-41a9-8fe0-367246437f6d', 'Glade Distribution Systems', 'Harper Phillips', 'Sales Manager', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA', '(907) 555-7584', '(907) 555-2880');
INSERT INTO customers VALUES ('cb2bf788-805e-4ed2-b25d-ddce939f06b1', 'Pinnacle Retail Co', 'Ella Long', 'Accounting Manager', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany', '0221-0644327', '0221-0765721');
INSERT INTO customers VALUES ('d9630e3e-5a90-4505-ad58-9a7976e7ce51', 'Lunar Trading Co', 'Grace Cox', 'Sales Representative', '265, boulevard Charonne', 'Paris', NULL, '75012', 'France', '(1) 42.34.22.66', '(1) 42.34.22.77');
INSERT INTO customers VALUES ('078abbfd-fbac-4432-9528-c7a98ea5351c', 'Vector Trading House', 'Alexander Nelson', 'Assistant Sales Representative', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico', '(5) 552-3745', '(5) 545-3745');
INSERT INTO customers VALUES ('95ddaae9-9c82-4259-b319-1a46588a652a', 'Pacific Trading House', 'Grace James', 'Sales Agent', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria', '6562-9722', '6562-9723');
INSERT INTO customers VALUES ('82e1941f-8f2c-4015-bcec-36ec4ab51900', 'Quantum Retail Solutions', 'Amelia Evans', 'Sales Representative', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal', '(1) 356-5634', NULL);
INSERT INTO customers VALUES ('b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', 'Crown Retail Solutions', 'Anthony Howard', 'Owner', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil', '(21) 555-4252', '(21) 555-4545');
INSERT INTO customers VALUES ('d052d4e1-5069-4431-ba2f-4965bf158b31', 'Mosaic Supply Solutions', 'Andrew Hamilton', 'Assistant Sales Agent', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil', '(11) 555-1189', NULL);
INSERT INTO customers VALUES ('748b439f-112d-44fa-91a4-670ef32d1621', 'Bronson Wholesale Ltd', 'Scarlett Patterson', 'Sales Associate', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany', '0372-035188', NULL);
INSERT INTO customers VALUES ('c409b555-9e62-4606-b2ff-63dacb2c17dc', 'Liberty Trading Partners', 'Chloe King', 'Sales Manager', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina', '(1) 123-5555', '(1) 123-5556');
INSERT INTO customers VALUES ('2569e109-6d44-4f1a-8919-db63efb4ca9e', 'Echo Distribution Ltd', 'Ian Turner', 'Assistant Sales Agent', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA', '(505) 555-5939', '(505) 555-3620');
INSERT INTO customers VALUES ('19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', 'Imperial Foods Corp', 'Hannah Brooks', 'Marketing Manager', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy', '0522-556721', '0522-556722');
INSERT INTO customers VALUES ('08593d96-6aac-44cc-9aff-b5c963fc26db', 'Orion Distribution Partners', 'Charlotte Griffin', 'Sales Agent', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil', '(21) 555-3412', NULL);
INSERT INTO customers VALUES ('2fc6d112-e8e0-40a2-851d-b21b5b07972f', 'Rowan Trading House', 'Benjamin Hayes', 'Assistant Sales Agent', 'Grenzacherweg 237', 'Genève', NULL, '1203', 'Switzerland', '0897-034214', NULL);
INSERT INTO customers VALUES ('689c7f09-ae86-48b0-838d-dc4c046c757d', 'Diamond Retail Solutions', 'Cameron Howard', 'Sales Agent', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain', '(91) 745 6200', '(91) 745 6210');
INSERT INTO customers VALUES ('070ee85e-07e7-4886-bf50-ba55c77160d9', 'Juniper Trading House', 'Violet Nelson', 'Marketing Manager', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway', '07-98 92 35', '07-98 92 47');
INSERT INTO customers VALUES ('20f34a05-8fca-4a71-be1b-c9188bad6df0', 'Flora Trading House', 'Savannah Gray', 'Sales Manager', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA', '(208) 555-8097', NULL);
INSERT INTO customers VALUES ('21c8bb0f-dfb4-460c-9136-0ca192e08207', 'Jupiter Retail Systems', 'Aurora Cooper', 'Owner', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK', '(171) 555-1717', '(171) 555-5646');
INSERT INTO customers VALUES ('f0d1b9c9-9e00-4a54-8276-07cced1288be', 'Maple Commerce Solutions', 'Tyler Martinez', 'Order Administrator', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark', '31 12 34 56', '31 13 35 57');
INSERT INTO customers VALUES ('e6914765-3d71-472f-9efd-119e184b3c0a', 'Windsor Supply Group', 'Madison Lewis', 'Marketing Assistant', '25, rue Lauriston', 'Paris', NULL, '75016', 'France', '(1) 47.55.60.10', '(1) 47.55.60.20');
INSERT INTO customers VALUES ('39a6fd07-d871-4d12-889a-1bfd8d79dea2', 'Quartz Retail Group', 'Alexander Wallace', 'Marketing Manager', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA', '(307) 555-4680', '(307) 555-6525');
INSERT INTO customers VALUES ('cac0dfc7-9686-4f1b-9cba-4ca27683da64', 'Titan Commerce Partners', 'Violet Long', 'Assistant Sales Agent', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium', '(071) 23 67 22 20', '(071) 23 67 22 21');
INSERT INTO customers VALUES ('4df2df85-b445-43b3-a8a6-f5b65d0cc8c8', 'Zenith Commerce Group', 'Ethan Mitchell', 'Sales Representative', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA', '(503) 555-3612', NULL);
INSERT INTO customers VALUES ('56184b85-2929-4ae4-8933-685e484b9933', 'Sterling Trade Partners', 'Christopher Price', 'Assistant Sales Representative', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA', '(406) 555-5834', '(406) 555-8083');
INSERT INTO customers VALUES ('7379764d-d1e9-4e61-9016-7d804b30c2eb', 'Kestrel Supply Group', 'Thomas Diaz', 'Marketing Manager', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany', '0251-031259', '0251-035695');
INSERT INTO customers VALUES ('af2ae79f-291f-425a-ad9a-81f7064ca7e5', 'Lagoon Commerce Ltd', 'Stella Perez', 'Marketing Manager', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico', '(5) 555-2933', NULL);
INSERT INTO customers VALUES ('ce6bfe1b-34e1-4750-a003-271ce4dc6912', 'Keystone Supply Chain', 'Madison Stewart', 'Accounting Manager', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil', '(11) 555-2167', '(11) 555-2168');
INSERT INTO customers VALUES ('91e82c3d-bf19-4224-9571-a65057c5916e', 'Crestview Distribution Ltd', 'Claire Wright', 'Sales Representative', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA', '(206) 555-8257', '(206) 555-2174');
INSERT INTO customers VALUES ('350fda94-3e7d-4a1f-8408-fe06024eca1e', 'Ivory Retail Systems', 'Sebastian Price', 'Marketing Manager', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark', '86 21 32 43', '86 22 33 44');
INSERT INTO customers VALUES ('0668ebca-a25a-4c6a-b84c-7943bf00171e', 'Redwood Supply Partners', 'Nora Barnes', 'Assistant Sales Representative', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France', '78.32.54.86', '78.32.54.87');
INSERT INTO customers VALUES ('0f950417-4cef-4220-9648-bf424a6da513', 'Yellowstone Supply Co', 'Nicholas West', 'Assistant Sales Representative', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France', '26.47.15.10', '26.47.15.11');
INSERT INTO customers VALUES ('c628d310-118f-4d17-83c4-1cfcc82954a9', 'Vine Trading Solutions', 'Sophia Collins', 'Sales Manager', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany', '0711-020361', '0711-035428');
INSERT INTO customers VALUES ('af354600-23a9-4298-9157-75ff7c92a119', 'Riverside Supply Co', 'Jonathan Wallace', 'Sales Manager', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland', '981-443655', '981-443655');
INSERT INTO customers VALUES ('5506f7ee-50bd-4a1e-a15d-b6f223d32c67', 'Horizon Merchants', 'Jonathan Alexander', 'Assistant Sales Representative', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil', '(14) 555-8122', NULL);
INSERT INTO customers VALUES ('2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', 'Silver Commerce Ltd', 'Jonathan Rogers', 'Assistant Sales Representative', '305 - 14th Ave. S. Suite 3B', 'Seattle', 'WA', '98128', 'USA', '(206) 555-4112', '(206) 555-4115');
INSERT INTO customers VALUES ('01a81542-e365-4854-a3ae-fb1d7e0a4fa2', 'Harbor Wholesale Co', 'Addison Ford', 'Marketing Assistant', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland', '90-224 8858', '90-224 8858');
INSERT INTO customers VALUES ('b4dc01c6-29d9-4799-b914-9424e6e210d9', 'Trident Trading Solutions', 'Charlotte Nelson', 'Accounting Manager', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland', '(26) 642-7012', '(26) 642-7012');


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO employees VALUES ('825cc0d3-bb19-4f15-ac61-dcbcfe584c76', 'Harrison', 'Marcus', 'Sales Representative', 'Ms.', '1976-09-11', '2020-02-03', '507 - 20th Ave. E.\nApt. 2A', 'Seattle', 'WA', '98122', 'USA', '(206) 555-9857', '5467', 'Education includes a BA in psychology from Colorado State University in 1970.  He also completed The Art of the Cold Call.  Marcus is a member of Toastmasters International.', 'b9f5fb6a-b20a-4759-8023-f59236f928df');
INSERT INTO employees VALUES ('b9f5fb6a-b20a-4759-8023-f59236f928df', 'Chen', 'Victoria', 'Vice President, Sales', 'Dr.', '1979-11-23', '2020-05-18', '908 W. Capital Way', 'Tacoma', 'WA', '98401', 'USA', '(206) 555-9482', '3457', 'Victoria received her BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  She is fluent in French and Italian and reads German.  She joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993.  Victoria is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.', NULL);
INSERT INTO employees VALUES ('c026b6c4-2083-4b52-bf06-c51e91346627', 'Patel', 'Rajesh', 'Sales Representative', 'Ms.', '1991-06-03', '2020-01-04', '722 Moss Bay Blvd.', 'Kirkland', 'WA', '98033', 'USA', '(206) 555-3412', '3355', 'Rajesh has a BS degree in chemistry from Boston College (1984).  He has also completed a certificate program in food retailing management.  Rajesh was hired as a sales associate in 1991 and promoted to sales representative in February 1992.', 'b9f5fb6a-b20a-4759-8023-f59236f928df');
INSERT INTO employees VALUES ('24f6fcba-8f96-403a-b31d-1835b5ca16dc', 'O''Brien', 'Katherine', 'Sales Representative', 'Mrs.', '1965-06-23', '2021-02-04', '4110 Old Redmond Rd.', 'Redmond', 'WA', '98052', 'USA', '(206) 555-8122', '5176', 'Katherine holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966).  She was assigned to the London office temporarily from July through November 1992.', 'b9f5fb6a-b20a-4759-8023-f59236f928df');
INSERT INTO employees VALUES ('db5e3cae-2e6e-4d67-8b38-df1833f9d75f', 'Martinez', 'Sofia', 'Sales Manager', 'Mr.', '1982-12-06', '2021-07-21', '14 Garrett Hill', 'London', NULL, 'SW1 8JR', 'UK', '(71) 555-4848', '3453', 'Sofia Martinez graduated from St. Andrews University, Scotland, with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992, she spent 6 months in an orientation program at the Seattle office and then returned to her permanent post in London.  She was promoted to sales manager in March 1993.  Ms. Martinez has completed the courses Successful Telemarketing and International Sales Management.  She is fluent in French.', 'b9f5fb6a-b20a-4759-8023-f59236f928df');
INSERT INTO employees VALUES ('c6872c35-2819-4dc3-9c98-95f7489fac25', 'Anderson', 'James', 'Sales Representative', 'Mr.', '1991-04-05', '2021-07-21', 'Coventry House\nMiner Rd.', 'London', NULL, 'EC2 7JR', 'UK', '(71) 555-7773', '428', 'James is a graduate of Sussex University (MA, economics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986).  He has also taken the courses Multi-Cultural Selling and Time Management for the Sales Professional.  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f');
INSERT INTO employees VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', 'Williams', 'Diana', 'Sales Representative', 'Mr.', '1988-03-02', '2021-10-06', 'Edgeham Hollow\nWinchester Way', 'London', NULL, 'RG1 9SP', 'UK', '(71) 555-5598', '465', 'Diana Williams served in the Peace Corps and traveled extensively before completing her degree in English at the University of Michigan in 1992, the year she joined the company.  After completing a course entitled Selling in Europe, she was transferred to the London office in March 1993.', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f');
INSERT INTO employees VALUES ('a8eaa9a6-24c0-47b2-84e3-0c701ff76480', 'Rodriguez', 'Carlos', 'Inside Sales Coordinator', 'Ms.', '1985-10-13', '2021-12-07', '4726 - 11th Ave. N.E.', 'Seattle', 'WA', '98105', 'USA', '(206) 555-1189', '2344', 'Carlos received a BA in psychology from the University of Washington.  He has also completed a course in business French.  He reads and writes French.', 'b9f5fb6a-b20a-4759-8023-f59236f928df');
INSERT INTO employees VALUES ('bd734f3c-b888-489c-a098-4395f9565d97', 'Bennett', 'Rachel', 'Sales Representative', 'Ms.', '1993-10-31', '2022-08-19', '7 Houndstooth Rd.', 'London', NULL, 'WG2 7LT', 'UK', '(71) 555-4444', '452', 'Rachel has a BA degree in English from St. Lawrence College.  She is fluent in French and German.', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f');


--
-- Data for Name: employee_territories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO employee_territories VALUES ('825cc0d3-bb19-4f15-ac61-dcbcfe584c76', 'bbd4abea-6e83-4b55-a6d5-a66c172530dc');
INSERT INTO employee_territories VALUES ('825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '9283f0d9-ab2e-4c15-81c1-3d6a9a554a6c');
INSERT INTO employee_territories VALUES ('b9f5fb6a-b20a-4759-8023-f59236f928df', '1814d03a-afa9-4529-9eef-887ea9439233');
INSERT INTO employee_territories VALUES ('b9f5fb6a-b20a-4759-8023-f59236f928df', '69041f5f-6f18-460f-8f8b-d390bca2606d');
INSERT INTO employee_territories VALUES ('b9f5fb6a-b20a-4759-8023-f59236f928df', '3f4e2289-0b80-4281-bf91-346750bffd31');
INSERT INTO employee_territories VALUES ('b9f5fb6a-b20a-4759-8023-f59236f928df', '0bd1b02a-2203-4ade-83f8-6d13208cf145');
INSERT INTO employee_territories VALUES ('b9f5fb6a-b20a-4759-8023-f59236f928df', 'c00d5757-90e3-4543-a216-4d06463a6a2c');
INSERT INTO employee_territories VALUES ('b9f5fb6a-b20a-4759-8023-f59236f928df', '53451b36-7fd1-45eb-a449-3d39501b9e19');
INSERT INTO employee_territories VALUES ('b9f5fb6a-b20a-4759-8023-f59236f928df', 'e2898cd2-dd18-4d96-8b10-fdd0788aa66d');
INSERT INTO employee_territories VALUES ('c026b6c4-2083-4b52-bf06-c51e91346627', '11c2b222-5a4a-441b-ac0a-975eb288fb04');
INSERT INTO employee_territories VALUES ('c026b6c4-2083-4b52-bf06-c51e91346627', 'b42ebb0d-5413-47e5-bf21-d334c51ff111');
INSERT INTO employee_territories VALUES ('c026b6c4-2083-4b52-bf06-c51e91346627', 'bfb34165-e4c9-485e-ac64-16f2c1fb5cca');
INSERT INTO employee_territories VALUES ('c026b6c4-2083-4b52-bf06-c51e91346627', 'ee317c38-b9f5-41f9-9b0f-d91370c61900');
INSERT INTO employee_territories VALUES ('24f6fcba-8f96-403a-b31d-1835b5ca16dc', 'e8ea23e4-be6e-4fdd-9920-50180caa87c8');
INSERT INTO employee_territories VALUES ('24f6fcba-8f96-403a-b31d-1835b5ca16dc', '9a7ffaaa-04e3-485e-9748-1209a8814e68');
INSERT INTO employee_territories VALUES ('24f6fcba-8f96-403a-b31d-1835b5ca16dc', '59343735-23f9-476f-b4ae-7d33cd96ac48');
INSERT INTO employee_territories VALUES ('db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '865db6b0-c58b-40b7-afe3-f908fc0de5ea');
INSERT INTO employee_territories VALUES ('db5e3cae-2e6e-4d67-8b38-df1833f9d75f', 'cbebd163-da08-4159-bee0-435c3995b95d');
INSERT INTO employee_territories VALUES ('db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '3cb6cf7c-d7d0-49e0-a75a-810e17a47650');
INSERT INTO employee_territories VALUES ('db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '6e2d65af-302b-4b55-8fe9-1d7d3695e36b');
INSERT INTO employee_territories VALUES ('db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '10579c0a-6e5f-49ee-aa27-eb3fb465dccd');
INSERT INTO employee_territories VALUES ('db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '61e1d7e7-6c5c-495f-ba05-e8ae8c115efd');
INSERT INTO employee_territories VALUES ('db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '98ffe550-91e5-4a50-a829-b22e03a0a71c');
INSERT INTO employee_territories VALUES ('c6872c35-2819-4dc3-9c98-95f7489fac25', 'aad179cf-1f85-4223-9c42-b36951615999');
INSERT INTO employee_territories VALUES ('c6872c35-2819-4dc3-9c98-95f7489fac25', '6cf833b6-02d5-4015-8a6a-4d3125da802b');
INSERT INTO employee_territories VALUES ('c6872c35-2819-4dc3-9c98-95f7489fac25', '9a0b5e91-0467-419e-814d-ca3300aab25d');
INSERT INTO employee_territories VALUES ('c6872c35-2819-4dc3-9c98-95f7489fac25', 'e4315f01-225a-45b1-bb0f-4b6cced1888e');
INSERT INTO employee_territories VALUES ('c6872c35-2819-4dc3-9c98-95f7489fac25', 'cea22556-9e86-4dd5-b86c-6ea9dca45bfc');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', 'bc6942b8-1f18-4f04-8a69-0520ccda0095');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '1395c8fa-39d7-49dd-9d40-28e2e087dbb7');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '39ff0377-40ae-4a83-a06b-a1ca0f96575e');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', 'ef3be036-77db-47e9-bd48-16cae9a06d44');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '93aeba80-903d-489a-abe3-174242c4e1f5');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '479c3d42-e4e5-49e5-ae22-9ccc67c5b31d');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '633b3fbe-793c-4a52-b53a-8944fa38a17d');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '1eaee084-741b-461d-86d1-2744df3d7c5c');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', 'b4d54544-d024-4a75-852d-5b09f1e5d402');
INSERT INTO employee_territories VALUES ('8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2eebcd57-b7c8-469a-bb2c-7a43d3d29190');
INSERT INTO employee_territories VALUES ('a8eaa9a6-24c0-47b2-84e3-0c701ff76480', 'd54adbce-e295-4bbc-9a48-ac9650e4df3a');
INSERT INTO employee_territories VALUES ('a8eaa9a6-24c0-47b2-84e3-0c701ff76480', 'ac780f30-c0e3-409c-8874-6b9e6da13d8d');
INSERT INTO employee_territories VALUES ('a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '82dfffbd-34ed-4e9a-830d-bdd4ceacfff6');
INSERT INTO employee_territories VALUES ('a8eaa9a6-24c0-47b2-84e3-0c701ff76480', 'd854d549-1423-4d76-9aa7-60f9c2b6d675');
INSERT INTO employee_territories VALUES ('bd734f3c-b888-489c-a098-4395f9565d97', '389a9a10-5f51-4255-b5cb-e0ed03b80356');
INSERT INTO employee_territories VALUES ('bd734f3c-b888-489c-a098-4395f9565d97', '19436eac-b83a-4c50-90a1-1d87cfa0de22');
INSERT INTO employee_territories VALUES ('bd734f3c-b888-489c-a098-4395f9565d97', 'df4e761b-b908-4343-8542-b531ac6d74fa');
INSERT INTO employee_territories VALUES ('bd734f3c-b888-489c-a098-4395f9565d97', '6936328e-3e95-4c65-8575-1c71875123bf');
INSERT INTO employee_territories VALUES ('bd734f3c-b888-489c-a098-4395f9565d97', 'c5bb490d-a894-4169-b277-1c5c75861e7e');
INSERT INTO employee_territories VALUES ('bd734f3c-b888-489c-a098-4395f9565d97', 'e334b581-c942-44ce-b2e6-56408e57a21c');
INSERT INTO employee_territories VALUES ('bd734f3c-b888-489c-a098-4395f9565d97', '6167fb2e-c146-4b42-a69d-7a2d449c1672');


--
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO order_details VALUES ('82c06d86-0d6a-4454-9919-3d739d636ce4', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 14, 12, 0);
INSERT INTO order_details VALUES ('82c06d86-0d6a-4454-9919-3d739d636ce4', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 9.80000019, 10, 0);
INSERT INTO order_details VALUES ('82c06d86-0d6a-4454-9919-3d739d636ce4', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 5, 0);
INSERT INTO order_details VALUES ('f86a570a-6b98-4fd0-b959-e30a6392a2f9', '38262c84-2325-4c54-a537-7fd358d8b35e', 18.6000004, 9, 0);
INSERT INTO order_details VALUES ('f86a570a-6b98-4fd0-b959-e30a6392a2f9', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 42.4000015, 40, 0);
INSERT INTO order_details VALUES ('ad387250-f71c-42ba-8645-f1c53a76bc32', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 10, 0);
INSERT INTO order_details VALUES ('ad387250-f71c-42ba-8645-f1c53a76bc32', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 42.4000015, 35, 0.150000006);
INSERT INTO order_details VALUES ('ad387250-f71c-42ba-8645-f1c53a76bc32', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 15, 0.150000006);
INSERT INTO order_details VALUES ('f93cf4c1-ad7a-4daa-abbb-d56e2d67b124', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 16.7999992, 6, 0.0500000007);
INSERT INTO order_details VALUES ('f93cf4c1-ad7a-4daa-abbb-d56e2d67b124', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 15.6000004, 15, 0.0500000007);
INSERT INTO order_details VALUES ('f93cf4c1-ad7a-4daa-abbb-d56e2d67b124', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 20, 0);
INSERT INTO order_details VALUES ('83f2abd6-53de-45cc-a659-bf1f4ffcd00b', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 64.8000031, 40, 0.0500000007);
INSERT INTO order_details VALUES ('83f2abd6-53de-45cc-a659-bf1f4ffcd00b', 'd2394847-8829-4bec-b968-170c8429022f', 2, 25, 0.0500000007);
INSERT INTO order_details VALUES ('83f2abd6-53de-45cc-a659-bf1f4ffcd00b', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 40, 0);
INSERT INTO order_details VALUES ('a84a490a-5f89-437c-82d7-adcb7a5bcb6d', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 20, 0);
INSERT INTO order_details VALUES ('a84a490a-5f89-437c-82d7-adcb7a5bcb6d', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 42, 0);
INSERT INTO order_details VALUES ('a84a490a-5f89-437c-82d7-adcb7a5bcb6d', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 16, 40, 0);
INSERT INTO order_details VALUES ('ba030db5-8b56-4727-9844-69cd3de9ba12', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 15, 0.150000006);
INSERT INTO order_details VALUES ('ba030db5-8b56-4727-9844-69cd3de9ba12', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 21, 0.150000006);
INSERT INTO order_details VALUES ('ba030db5-8b56-4727-9844-69cd3de9ba12', '35757ead-53a9-44f2-a023-f8950dd9eeac', 8, 21, 0);
INSERT INTO order_details VALUES ('973006d2-24f6-44b9-a9d1-d079e92fb88d', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 20, 0);
INSERT INTO order_details VALUES ('973006d2-24f6-44b9-a9d1-d079e92fb88d', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 35, 0);
INSERT INTO order_details VALUES ('973006d2-24f6-44b9-a9d1-d079e92fb88d', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 15.1999998, 25, 0);
INSERT INTO order_details VALUES ('973006d2-24f6-44b9-a9d1-d079e92fb88d', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 30, 0);
INSERT INTO order_details VALUES ('7b4bc9de-2de5-4871-a282-497ea319beb1', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 15, 0);
INSERT INTO order_details VALUES ('7b4bc9de-2de5-4871-a282-497ea319beb1', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 12, 0);
INSERT INTO order_details VALUES ('d13abecc-daf1-49ef-af49-8646262b5788', '53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 35.0999985, 25, 0);
INSERT INTO order_details VALUES ('d13abecc-daf1-49ef-af49-8646262b5788', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 6, 0);
INSERT INTO order_details VALUES ('d13abecc-daf1-49ef-af49-8646262b5788', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 15, 0);
INSERT INTO order_details VALUES ('0153dd62-f5d9-424a-be26-ac73e9a31c38', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 50, 0.200000003);
INSERT INTO order_details VALUES ('0153dd62-f5d9-424a-be26-ac73e9a31c38', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 17, 65, 0.200000003);
INSERT INTO order_details VALUES ('0153dd62-f5d9-424a-be26-ac73e9a31c38', '557b229c-18fe-43e9-a440-ff4260ee4d86', 25.6000004, 6, 0.200000003);
INSERT INTO order_details VALUES ('42bf8757-021d-4913-81b4-8101acce2671', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 10, 0);
INSERT INTO order_details VALUES ('42bf8757-021d-4913-81b4-8101acce2671', '8ad0f836-43df-42d9-a992-e1fee45d28d8', 20.7999992, 1, 0);
INSERT INTO order_details VALUES ('68cde686-6552-4bac-ae6a-a947347f345e', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 16, 0.25);
INSERT INTO order_details VALUES ('68cde686-6552-4bac-ae6a-a947347f345e', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 15.6000004, 50, 0);
INSERT INTO order_details VALUES ('68cde686-6552-4bac-ae6a-a947347f345e', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 15, 0.25);
INSERT INTO order_details VALUES ('68cde686-6552-4bac-ae6a-a947347f345e', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 21, 0.25);
INSERT INTO order_details VALUES ('50263d76-fa99-4808-8586-b3acccf54ed4', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 20, 0);
INSERT INTO order_details VALUES ('50263d76-fa99-4808-8586-b3acccf54ed4', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 20, 0);
INSERT INTO order_details VALUES ('cfd98252-e96f-41ef-a3cb-590de2310d40', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 17, 12, 0.200000003);
INSERT INTO order_details VALUES ('cfd98252-e96f-41ef-a3cb-590de2310d40', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 24, 15, 0);
INSERT INTO order_details VALUES ('cfd98252-e96f-41ef-a3cb-590de2310d40', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 2, 0);
INSERT INTO order_details VALUES ('4d60f80b-b6ed-44a1-81c6-1533a78d979d', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 60, 0.25);
INSERT INTO order_details VALUES ('4d60f80b-b6ed-44a1-81c6-1533a78d979d', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 28, 0);
INSERT INTO order_details VALUES ('4d60f80b-b6ed-44a1-81c6-1533a78d979d', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 60, 0.25);
INSERT INTO order_details VALUES ('4d60f80b-b6ed-44a1-81c6-1533a78d979d', '35757ead-53a9-44f2-a023-f8950dd9eeac', 8, 36, 0.25);
INSERT INTO order_details VALUES ('3759e4e7-3808-439f-a572-bb6bd22ea0be', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 35, 0);
INSERT INTO order_details VALUES ('3759e4e7-3808-439f-a572-bb6bd22ea0be', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 25, 0.150000006);
INSERT INTO order_details VALUES ('903711d1-0913-4ad0-9a4c-cada906e1ac3', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 30, 0);
INSERT INTO order_details VALUES ('903711d1-0913-4ad0-9a4c-cada906e1ac3', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 20, 0);
INSERT INTO order_details VALUES ('469b8281-8db3-4792-8c42-7c4b466fff47', 'faa17edb-402d-402a-a859-af6b8321f8da', 30.3999996, 12, 0.0500000007);
INSERT INTO order_details VALUES ('7b6b1938-d775-412a-afeb-c0af7c8dc726', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 50, 0);
INSERT INTO order_details VALUES ('7b6b1938-d775-412a-afeb-c0af7c8dc726', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 70, 0.150000006);
INSERT INTO order_details VALUES ('7b6b1938-d775-412a-afeb-c0af7c8dc726', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 15, 0.150000006);
INSERT INTO order_details VALUES ('af14173b-e5c5-4f7d-bbf0-f65530765766', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 10, 0);
INSERT INTO order_details VALUES ('af14173b-e5c5-4f7d-bbf0-f65530765766', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 4, 0);
INSERT INTO order_details VALUES ('4ab90db1-b3b0-4cf5-95af-baee82fac1df', 'd2394847-8829-4bec-b968-170c8429022f', 2, 60, 0.0500000007);
INSERT INTO order_details VALUES ('4ab90db1-b3b0-4cf5-95af-baee82fac1df', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 20, 0.0500000007);
INSERT INTO order_details VALUES ('1bfac9e6-25ce-4433-abb1-f743dd51d6e4', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 15.1999998, 30, 0);
INSERT INTO order_details VALUES ('1bfac9e6-25ce-4433-abb1-f743dd51d6e4', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 36.7999992, 25, 0);
INSERT INTO order_details VALUES ('7d13b90a-7e30-4285-8292-408e8056e2cd', 'd2394847-8829-4bec-b968-170c8429022f', 2, 24, 0);
INSERT INTO order_details VALUES ('517ad1a2-20df-430f-88cf-86e5b100ae04', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 64.8000031, 6, 0);
INSERT INTO order_details VALUES ('517ad1a2-20df-430f-88cf-86e5b100ae04', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 40, 0);
INSERT INTO order_details VALUES ('517ad1a2-20df-430f-88cf-86e5b100ae04', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 24, 0);
INSERT INTO order_details VALUES ('b99f800e-420f-4c86-b1f9-f48f1a165fa6', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 24.7999992, 24, 0.0500000007);
INSERT INTO order_details VALUES ('b99f800e-420f-4c86-b1f9-f48f1a165fa6', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 15, 0.0500000007);
INSERT INTO order_details VALUES ('b99f800e-420f-4c86-b1f9-f48f1a165fa6', 'd2394847-8829-4bec-b968-170c8429022f', 2, 20, 0);
INSERT INTO order_details VALUES ('b99f800e-420f-4c86-b1f9-f48f1a165fa6', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 60, 0.0500000007);
INSERT INTO order_details VALUES ('b99f800e-420f-4c86-b1f9-f48f1a165fa6', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 33, 0.0500000007);
INSERT INTO order_details VALUES ('23f99487-8364-4da1-97f3-b4bea62b94bf', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 20, 0);
INSERT INTO order_details VALUES ('23f99487-8364-4da1-97f3-b4bea62b94bf', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 7, 0);
INSERT INTO order_details VALUES ('d5d0e012-83f1-4148-a81d-0daf95147d6a', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 12, 0.0500000007);
INSERT INTO order_details VALUES ('d5d0e012-83f1-4148-a81d-0daf95147d6a', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 6, 0.0500000007);
INSERT INTO order_details VALUES ('88041a74-4153-4573-882f-f69d35b0d925', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 24.7999992, 15, 0);
INSERT INTO order_details VALUES ('88041a74-4153-4573-882f-f69d35b0d925', '1b513001-91dd-4c4b-a64d-4e84520ee747', 4.80000019, 10, 0);
INSERT INTO order_details VALUES ('6354b418-a0bc-484d-b22f-9c70917edab0', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 20, 0);
INSERT INTO order_details VALUES ('6354b418-a0bc-484d-b22f-9c70917edab0', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 12, 0);
INSERT INTO order_details VALUES ('7f06a4dd-06f2-4e98-b94d-ad46aebd65eb', '493f4894-c1cd-4285-9a14-219180421e20', 15.5, 16, 0);
INSERT INTO order_details VALUES ('7f06a4dd-06f2-4e98-b94d-ad46aebd65eb', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 15, 0);
INSERT INTO order_details VALUES ('7f06a4dd-06f2-4e98-b94d-ad46aebd65eb', '6b840857-464e-4c75-b887-ee21d918ee05', 35.0999985, 8, 0);
INSERT INTO order_details VALUES ('7f06a4dd-06f2-4e98-b94d-ad46aebd65eb', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 12, 25, 0);
INSERT INTO order_details VALUES ('b3947aa8-a583-4c10-bdd3-b6c00d38b531', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 15, 0.25);
INSERT INTO order_details VALUES ('3b142c25-f586-4530-b513-e832c6f4c48e', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 12, 0);
INSERT INTO order_details VALUES ('3b142c25-f586-4530-b513-e832c6f4c48e', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 20, 0);
INSERT INTO order_details VALUES ('3b142c25-f586-4530-b513-e832c6f4c48e', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 30, 0);
INSERT INTO order_details VALUES ('5a9d3203-de0a-4311-a29c-f2099a893530', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 1, 0);
INSERT INTO order_details VALUES ('5a9d3203-de0a-4311-a29c-f2099a893530', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 6, 0);
INSERT INTO order_details VALUES ('5a9d3203-de0a-4311-a29c-f2099a893530', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 4, 0);
INSERT INTO order_details VALUES ('13a02c62-d15d-45bd-a9b4-29edcb24d6ed', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 6, 0);
INSERT INTO order_details VALUES ('13a02c62-d15d-45bd-a9b4-29edcb24d6ed', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 15.6000004, 2, 0);
INSERT INTO order_details VALUES ('08ba8173-6e53-43b4-9ec8-0585ffd17c14', '0684ad85-cbf4-4340-b11e-e3c9caf11ee1', 12.3999996, 20, 0);
INSERT INTO order_details VALUES ('08ba8173-6e53-43b4-9ec8-0585ffd17c14', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 18, 0);
INSERT INTO order_details VALUES ('08ba8173-6e53-43b4-9ec8-0585ffd17c14', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 35, 0);
INSERT INTO order_details VALUES ('08ba8173-6e53-43b4-9ec8-0585ffd17c14', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 3, 0);
INSERT INTO order_details VALUES ('f6c55541-77c9-4530-969a-1b23e1a2fe20', '53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 35.0999985, 15, 0.25);
INSERT INTO order_details VALUES ('f6c55541-77c9-4530-969a-1b23e1a2fe20', '493f4894-c1cd-4285-9a14-219180421e20', 15.5, 21, 0);
INSERT INTO order_details VALUES ('f6c55541-77c9-4530-969a-1b23e1a2fe20', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 20, 0.25);
INSERT INTO order_details VALUES ('f6c55541-77c9-4530-969a-1b23e1a2fe20', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 11.1999998, 5, 0.25);
INSERT INTO order_details VALUES ('7ad09a00-f69b-4c4f-b19e-4e0548aad1dc', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 14.3999996, 45, 0.200000003);
INSERT INTO order_details VALUES ('7ad09a00-f69b-4c4f-b19e-4e0548aad1dc', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 40, 0.200000003);
INSERT INTO order_details VALUES ('7ad09a00-f69b-4c4f-b19e-4e0548aad1dc', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 36, 0.200000003);
INSERT INTO order_details VALUES ('e453ac16-6022-4ec3-a24e-eb44fd85783f', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 100, 0);
INSERT INTO order_details VALUES ('e453ac16-6022-4ec3-a24e-eb44fd85783f', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 40, 0);
INSERT INTO order_details VALUES ('e90b4678-0c6b-4183-908e-b3f33b45ac31', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 40, 0.150000006);
INSERT INTO order_details VALUES ('e90b4678-0c6b-4183-908e-b3f33b45ac31', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 11.1999998, 20, 0);
INSERT INTO order_details VALUES ('e90b4678-0c6b-4183-908e-b3f33b45ac31', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 15, 0.150000006);
INSERT INTO order_details VALUES ('4ad00383-76e1-4535-bbd2-ca7b97af3620', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 10, 0.100000001);
INSERT INTO order_details VALUES ('4ad00383-76e1-4535-bbd2-ca7b97af3620', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 3, 0.100000001);
INSERT INTO order_details VALUES ('dc8c8954-a6b8-41fc-a028-d3605068ebc0', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 8, 30, 0);
INSERT INTO order_details VALUES ('dc8c8954-a6b8-41fc-a028-d3605068ebc0', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 9, 0);
INSERT INTO order_details VALUES ('69e0f682-ac30-42e5-bff4-9743d894ce6a', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 17, 20, 0);
INSERT INTO order_details VALUES ('69e0f682-ac30-42e5-bff4-9743d894ce6a', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 15, 0);
INSERT INTO order_details VALUES ('69e0f682-ac30-42e5-bff4-9743d894ce6a', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 16, 15, 0);
INSERT INTO order_details VALUES ('69e0f682-ac30-42e5-bff4-9743d894ce6a', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 10, 0);
INSERT INTO order_details VALUES ('76afbd62-e5b1-4c1d-ad60-fa5ab1fe9acd', '1b513001-91dd-4c4b-a64d-4e84520ee747', 4.80000019, 20, 0.100000001);
INSERT INTO order_details VALUES ('76afbd62-e5b1-4c1d-ad60-fa5ab1fe9acd', '493f4894-c1cd-4285-9a14-219180421e20', 15.5, 24, 0.100000001);
INSERT INTO order_details VALUES ('76afbd62-e5b1-4c1d-ad60-fa5ab1fe9acd', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 42.4000015, 2, 0.100000001);
INSERT INTO order_details VALUES ('75d7c5cb-0558-4127-a708-90ddb4faef48', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 64.8000031, 20, 0);
INSERT INTO order_details VALUES ('e1487d2e-79ed-4988-bdff-0eeaf7b606ed', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 50, 12, 0);
INSERT INTO order_details VALUES ('e1487d2e-79ed-4988-bdff-0eeaf7b606ed', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 10, 0);
INSERT INTO order_details VALUES ('e1487d2e-79ed-4988-bdff-0eeaf7b606ed', '6b840857-464e-4c75-b887-ee21d918ee05', 35.0999985, 5, 0);
INSERT INTO order_details VALUES ('e1487d2e-79ed-4988-bdff-0eeaf7b606ed', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 6, 0);
INSERT INTO order_details VALUES ('66b6a018-f0b7-4236-aeae-faeebe53c8ff', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 14.3999996, 18, 0);
INSERT INTO order_details VALUES ('66b6a018-f0b7-4236-aeae-faeebe53c8ff', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 15, 0);
INSERT INTO order_details VALUES ('66b6a018-f0b7-4236-aeae-faeebe53c8ff', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 36.7999992, 15, 0);
INSERT INTO order_details VALUES ('66b6a018-f0b7-4236-aeae-faeebe53c8ff', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 21, 0);
INSERT INTO order_details VALUES ('66b6a018-f0b7-4236-aeae-faeebe53c8ff', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 6, 0);
INSERT INTO order_details VALUES ('8259e17a-a4d7-4d7d-8bb1-133b49ce7fda', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 4, 0);
INSERT INTO order_details VALUES ('c9e74798-ae1c-4d6b-9d4f-49fb18d348bc', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 12, 0);
INSERT INTO order_details VALUES ('c9e74798-ae1c-4d6b-9d4f-49fb18d348bc', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 30, 0);
INSERT INTO order_details VALUES ('c9e74798-ae1c-4d6b-9d4f-49fb18d348bc', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 15, 0);
INSERT INTO order_details VALUES ('464792f5-a704-4090-a9a2-8687fe12ab36', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 60, 0);
INSERT INTO order_details VALUES ('464792f5-a704-4090-a9a2-8687fe12ab36', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 20, 0);
INSERT INTO order_details VALUES ('ede4432f-d5e5-4dc3-a9e0-4017c5d815a2', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 40, 0);
INSERT INTO order_details VALUES ('ede4432f-d5e5-4dc3-a9e0-4017c5d815a2', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 15.1999998, 40, 0.25);
INSERT INTO order_details VALUES ('ede4432f-d5e5-4dc3-a9e0-4017c5d815a2', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 30, 0.25);
INSERT INTO order_details VALUES ('ede4432f-d5e5-4dc3-a9e0-4017c5d815a2', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 15, 0);
INSERT INTO order_details VALUES ('7ccecfa5-62ed-4d0a-8729-e3850d016619', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 15, 0);
INSERT INTO order_details VALUES ('7ccecfa5-62ed-4d0a-8729-e3850d016619', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 20, 0);
INSERT INTO order_details VALUES ('8bfd82e5-0dd2-4865-b3f4-b63700389cb4', '309dcfa3-7eea-4a14-9795-f8693838c3bd', 13.6000004, 30, 0);
INSERT INTO order_details VALUES ('8bfd82e5-0dd2-4865-b3f4-b63700389cb4', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 20, 0);
INSERT INTO order_details VALUES ('91ece67a-94f9-4939-94d8-44bd019a4a59', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 10, 0);
INSERT INTO order_details VALUES ('91ece67a-94f9-4939-94d8-44bd019a4a59', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 20, 0);
INSERT INTO order_details VALUES ('4b744b50-bfe7-4aca-9446-fb8dfede226d', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 40, 0);
INSERT INTO order_details VALUES ('4b744b50-bfe7-4aca-9446-fb8dfede226d', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 28, 0);
INSERT INTO order_details VALUES ('4b744b50-bfe7-4aca-9446-fb8dfede226d', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 36.7999992, 12, 0);
INSERT INTO order_details VALUES ('88381dbd-4311-4497-a111-dc562948ab44', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 40, 0.100000001);
INSERT INTO order_details VALUES ('88381dbd-4311-4497-a111-dc562948ab44', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 30, 0.100000001);
INSERT INTO order_details VALUES ('88381dbd-4311-4497-a111-dc562948ab44', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 15, 0.100000001);
INSERT INTO order_details VALUES ('cf1fc47a-53be-4883-88ca-bef9f131c2eb', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 16, 30, 0);
INSERT INTO order_details VALUES ('cf1fc47a-53be-4883-88ca-bef9f131c2eb', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 10, 0);
INSERT INTO order_details VALUES ('cf1fc47a-53be-4883-88ca-bef9f131c2eb', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 2, 0);
INSERT INTO order_details VALUES ('28fb28b5-b1a4-4cd7-8805-6896d7faecf5', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 50, 25, 0.100000001);
INSERT INTO order_details VALUES ('28fb28b5-b1a4-4cd7-8805-6896d7faecf5', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 25, 0.100000001);
INSERT INTO order_details VALUES ('28fb28b5-b1a4-4cd7-8805-6896d7faecf5', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 30, 0.100000001);
INSERT INTO order_details VALUES ('c4e5d8e4-81c1-4ba3-baa6-d9ddf370a550', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 10, 0);
INSERT INTO order_details VALUES ('c4e5d8e4-81c1-4ba3-baa6-d9ddf370a550', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 10, 0);
INSERT INTO order_details VALUES ('c4e5d8e4-81c1-4ba3-baa6-d9ddf370a550', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 5, 0);
INSERT INTO order_details VALUES ('12899056-0c26-4ff0-be55-b0421cdeff38', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 10, 0);
INSERT INTO order_details VALUES ('12899056-0c26-4ff0-be55-b0421cdeff38', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 3, 0);
INSERT INTO order_details VALUES ('3bf11ac5-f275-4591-a6ee-72f0662f7d62', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 1, 0);
INSERT INTO order_details VALUES ('3bf11ac5-f275-4591-a6ee-72f0662f7d62', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 5, 0);
INSERT INTO order_details VALUES ('1087f41f-e728-4220-8fef-e958cf1e3ebe', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 17.6000004, 20, 0);
INSERT INTO order_details VALUES ('1087f41f-e728-4220-8fef-e958cf1e3ebe', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 20, 30, 0);
INSERT INTO order_details VALUES ('1087f41f-e728-4220-8fef-e958cf1e3ebe', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 11.1999998, 2, 0);
INSERT INTO order_details VALUES ('1087f41f-e728-4220-8fef-e958cf1e3ebe', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 36.7999992, 20, 0);
INSERT INTO order_details VALUES ('1087f41f-e728-4220-8fef-e958cf1e3ebe', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 3, 0);
INSERT INTO order_details VALUES ('3500e39e-014d-49a1-bfc1-2029049649af', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 10, 0);
INSERT INTO order_details VALUES ('3500e39e-014d-49a1-bfc1-2029049649af', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 5, 0);
INSERT INTO order_details VALUES ('bdd94223-6b8a-43c0-a28f-ce6fdeb26c74', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 11.1999998, 6, 0);
INSERT INTO order_details VALUES ('bdd94223-6b8a-43c0-a28f-ce6fdeb26c74', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 7, 0);
INSERT INTO order_details VALUES ('14b54ea5-2e11-49ea-9fd0-8fbb688e4047', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 4, 0);
INSERT INTO order_details VALUES ('14b54ea5-2e11-49ea-9fd0-8fbb688e4047', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 36.7999992, 24, 0);
INSERT INTO order_details VALUES ('14b54ea5-2e11-49ea-9fd0-8fbb688e4047', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 20, 0);
INSERT INTO order_details VALUES ('14b54ea5-2e11-49ea-9fd0-8fbb688e4047', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 10, 0);
INSERT INTO order_details VALUES ('f4f17687-ff43-4d12-ac7c-4f936d5a51ba', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 15.1999998, 12, 0);
INSERT INTO order_details VALUES ('e8c586bc-51df-498b-ad00-1d8b73fe143f', '557b229c-18fe-43e9-a440-ff4260ee4d86', 25.6000004, 40, 0.100000001);
INSERT INTO order_details VALUES ('e8c586bc-51df-498b-ad00-1d8b73fe143f', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 10.6000004, 30, 0.100000001);
INSERT INTO order_details VALUES ('e8c586bc-51df-498b-ad00-1d8b73fe143f', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 25, 0.100000001);
INSERT INTO order_details VALUES ('9b978ddd-7373-49be-833f-e3e1a488771c', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 11.1999998, 14, 0);
INSERT INTO order_details VALUES ('9b978ddd-7373-49be-833f-e3e1a488771c', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 30, 0);
INSERT INTO order_details VALUES ('5095fdc8-4299-41be-8668-92fe626ca5d6', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 10, 0);
INSERT INTO order_details VALUES ('5095fdc8-4299-41be-8668-92fe626ca5d6', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 70, 0);
INSERT INTO order_details VALUES ('e35bc919-4cff-4778-8de2-0f4de97e3563', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 14.3999996, 20, 0);
INSERT INTO order_details VALUES ('d62f1556-d144-4e76-a84a-b4faf7bc87fb', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 20, 0);
INSERT INTO order_details VALUES ('d62f1556-d144-4e76-a84a-b4faf7bc87fb', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 6, 0);
INSERT INTO order_details VALUES ('ad586c96-5f57-4d17-b25c-086f1a67cacb', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 8, 0);
INSERT INTO order_details VALUES ('ad586c96-5f57-4d17-b25c-086f1a67cacb', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 14, 0);
INSERT INTO order_details VALUES ('ad586c96-5f57-4d17-b25c-086f1a67cacb', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 30, 0);
INSERT INTO order_details VALUES ('107a378c-c3bf-4fa0-9240-82bfd71847cd', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 30, 0);
INSERT INTO order_details VALUES ('4b4f4620-d580-4023-bcf0-37ea510cd5bb', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 10, 0);
INSERT INTO order_details VALUES ('82d07ae4-4e72-42b8-b462-be09210f8c47', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 5.5999999, 20, 0);
INSERT INTO order_details VALUES ('665fb271-4dae-43e6-af04-d29feb9589e1', '0684ad85-cbf4-4340-b11e-e3c9caf11ee1', 12.3999996, 5, 0);
INSERT INTO order_details VALUES ('665fb271-4dae-43e6-af04-d29feb9589e1', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 11.1999998, 4, 0);
INSERT INTO order_details VALUES ('665fb271-4dae-43e6-af04-d29feb9589e1', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 4, 0);
INSERT INTO order_details VALUES ('57e3dde3-7be5-46c3-aae2-3720d8785d01', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 21, 0.150000006);
INSERT INTO order_details VALUES ('57e3dde3-7be5-46c3-aae2-3720d8785d01', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 70, 0.150000006);
INSERT INTO order_details VALUES ('57e3dde3-7be5-46c3-aae2-3720d8785d01', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 30, 0);
INSERT INTO order_details VALUES ('57e3dde3-7be5-46c3-aae2-3720d8785d01', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 40, 0.150000006);
INSERT INTO order_details VALUES ('57e3dde3-7be5-46c3-aae2-3720d8785d01', '6b840857-464e-4c75-b887-ee21d918ee05', 35.0999985, 80, 0.150000006);
INSERT INTO order_details VALUES ('64c0df99-fb77-4439-ad63-14aa7f73fb75', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 20, 6, 0);
INSERT INTO order_details VALUES ('64c0df99-fb77-4439-ad63-14aa7f73fb75', '1b513001-91dd-4c4b-a64d-4e84520ee747', 4.80000019, 12, 0);
INSERT INTO order_details VALUES ('64c0df99-fb77-4439-ad63-14aa7f73fb75', '38262c84-2325-4c54-a537-7fd358d8b35e', 18.6000004, 9, 0);
INSERT INTO order_details VALUES ('64c0df99-fb77-4439-ad63-14aa7f73fb75', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 4, 0);
INSERT INTO order_details VALUES ('64c0df99-fb77-4439-ad63-14aa7f73fb75', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 40, 0);
INSERT INTO order_details VALUES ('51f25678-c558-4034-ac1b-6c77d7f6e8d6', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 17.6000004, 24, 0);
INSERT INTO order_details VALUES ('51f25678-c558-4034-ac1b-6c77d7f6e8d6', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 15.6000004, 16, 0);
INSERT INTO order_details VALUES ('51f25678-c558-4034-ac1b-6c77d7f6e8d6', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 50, 0);
INSERT INTO order_details VALUES ('b9b802ff-1421-487f-b637-f69db23f435e', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 25, 0.200000003);
INSERT INTO order_details VALUES ('b9b802ff-1421-487f-b637-f69db23f435e', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 50, 0.200000003);
INSERT INTO order_details VALUES ('b9b802ff-1421-487f-b637-f69db23f435e', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 35, 0.200000003);
INSERT INTO order_details VALUES ('b9b802ff-1421-487f-b637-f69db23f435e', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 10.6000004, 30, 0.200000003);
INSERT INTO order_details VALUES ('75765a20-3cea-4531-b563-87d60f5b3afc', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 9, 0);
INSERT INTO order_details VALUES ('75765a20-3cea-4531-b563-87d60f5b3afc', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 40, 0);
INSERT INTO order_details VALUES ('75765a20-3cea-4531-b563-87d60f5b3afc', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 10, 0);
INSERT INTO order_details VALUES ('3e111971-389d-4b32-bbf8-c83523c0c4d4', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 10, 0.0500000007);
INSERT INTO order_details VALUES ('3e111971-389d-4b32-bbf8-c83523c0c4d4', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 8, 0.0500000007);
INSERT INTO order_details VALUES ('3e111971-389d-4b32-bbf8-c83523c0c4d4', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 210.800003, 20, 0.0500000007);
INSERT INTO order_details VALUES ('3e111971-389d-4b32-bbf8-c83523c0c4d4', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 12, 0.0500000007);
INSERT INTO order_details VALUES ('e990a789-4b40-4541-b651-9bf29bafd6c0', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 50, 0.150000006);
INSERT INTO order_details VALUES ('e990a789-4b40-4541-b651-9bf29bafd6c0', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 25, 0.150000006);
INSERT INTO order_details VALUES ('329109b0-0c42-4857-9f55-a91dcbb4124e', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 15, 0);
INSERT INTO order_details VALUES ('0437498b-ecaf-4916-8c85-e0f29069e169', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 50, 40, 0.200000003);
INSERT INTO order_details VALUES ('0437498b-ecaf-4916-8c85-e0f29069e169', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 11.1999998, 10, 0.200000003);
INSERT INTO order_details VALUES ('0437498b-ecaf-4916-8c85-e0f29069e169', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 7.5999999, 16, 0.200000003);
INSERT INTO order_details VALUES ('8cb5dfe3-ac5e-4de8-ba4f-65833e3beec3', '38262c84-2325-4c54-a537-7fd358d8b35e', 18.6000004, 10, 0);
INSERT INTO order_details VALUES ('8cb5dfe3-ac5e-4de8-ba4f-65833e3beec3', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 10, 0.100000001);
INSERT INTO order_details VALUES ('8cb5dfe3-ac5e-4de8-ba4f-65833e3beec3', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 40, 0.100000001);
INSERT INTO order_details VALUES ('473ff3eb-ab48-443e-8901-354f1ca46953', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 5.5999999, 8, 0);
INSERT INTO order_details VALUES ('473ff3eb-ab48-443e-8901-354f1ca46953', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 10, 0);
INSERT INTO order_details VALUES ('05e9245c-1788-4dc3-9ea9-c28cf2726357', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 7, 0.200000003);
INSERT INTO order_details VALUES ('05e9245c-1788-4dc3-9ea9-c28cf2726357', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 25, 0.200000003);
INSERT INTO order_details VALUES ('05e9245c-1788-4dc3-9ea9-c28cf2726357', '557b229c-18fe-43e9-a440-ff4260ee4d86', 25.6000004, 6, 0.200000003);
INSERT INTO order_details VALUES ('05e9245c-1788-4dc3-9ea9-c28cf2726357', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 42.4000015, 48, 0.200000003);
INSERT INTO order_details VALUES ('3081f4bf-0353-41e5-8a2e-3f6053a5810d', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 17.6000004, 18, 0.100000001);
INSERT INTO order_details VALUES ('c3e3b53b-379c-4b72-ba14-efdc3e29691b', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 7.19999981, 40, 0);
INSERT INTO order_details VALUES ('c3e3b53b-379c-4b72-ba14-efdc3e29691b', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 24, 0);
INSERT INTO order_details VALUES ('c3e3b53b-379c-4b72-ba14-efdc3e29691b', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 15.1999998, 20, 0);
INSERT INTO order_details VALUES ('c3e3b53b-379c-4b72-ba14-efdc3e29691b', '8ad0f836-43df-42d9-a992-e1fee45d28d8', 20.7999992, 28, 0);
INSERT INTO order_details VALUES ('c3e3b53b-379c-4b72-ba14-efdc3e29691b', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 25, 0);
INSERT INTO order_details VALUES ('7c013a08-a00f-4534-97da-a023f152a945', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 20, 0);
INSERT INTO order_details VALUES ('7c013a08-a00f-4534-97da-a023f152a945', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 15, 0);
INSERT INTO order_details VALUES ('e5a2ae85-aff8-440a-946b-54deade8a779', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 17.6000004, 10, 0);
INSERT INTO order_details VALUES ('e5a2ae85-aff8-440a-946b-54deade8a779', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 70, 0.0500000007);
INSERT INTO order_details VALUES ('e5a2ae85-aff8-440a-946b-54deade8a779', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 28, 0);
INSERT INTO order_details VALUES ('45b09b2d-5b05-4609-94f3-4d4b0b046285', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 50, 20, 0.0500000007);
INSERT INTO order_details VALUES ('45b09b2d-5b05-4609-94f3-4d4b0b046285', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 12, 0.0500000007);
INSERT INTO order_details VALUES ('45b09b2d-5b05-4609-94f3-4d4b0b046285', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 36.7999992, 40, 0.0500000007);
INSERT INTO order_details VALUES ('29677352-a658-49ec-b942-984e05d47920', 'd2394847-8829-4bec-b968-170c8429022f', 2, 8, 0);
INSERT INTO order_details VALUES ('29677352-a658-49ec-b942-984e05d47920', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 9, 0.150000006);
INSERT INTO order_details VALUES ('168087aa-a0e9-494b-8fba-f11d19411031', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 24, 0.200000003);
INSERT INTO order_details VALUES ('168087aa-a0e9-494b-8fba-f11d19411031', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 56, 0.200000003);
INSERT INTO order_details VALUES ('168087aa-a0e9-494b-8fba-f11d19411031', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 15.1999998, 40, 0.200000003);
INSERT INTO order_details VALUES ('168087aa-a0e9-494b-8fba-f11d19411031', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 40, 0.200000003);
INSERT INTO order_details VALUES ('fc90f235-e654-4d26-8d7f-3e67d03a8dc5', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 50, 0);
INSERT INTO order_details VALUES ('fc90f235-e654-4d26-8d7f-3e67d03a8dc5', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 4, 0.0500000007);
INSERT INTO order_details VALUES ('fc90f235-e654-4d26-8d7f-3e67d03a8dc5', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 15, 0);
INSERT INTO order_details VALUES ('700a2a51-c68c-4ce2-91e6-280d2712ffe5', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 17.6000004, 35, 0);
INSERT INTO order_details VALUES ('700a2a51-c68c-4ce2-91e6-280d2712ffe5', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 32, 70, 0.25);
INSERT INTO order_details VALUES ('349d5229-a3e5-426d-82df-27af267c7192', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 32, 70, 0);
INSERT INTO order_details VALUES ('349d5229-a3e5-426d-82df-27af267c7192', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 80, 0);
INSERT INTO order_details VALUES ('349d5229-a3e5-426d-82df-27af267c7192', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 11.1999998, 9, 0);
INSERT INTO order_details VALUES ('489603ab-94e5-4f90-8647-f4d5bd144b78', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 36, 0.100000001);
INSERT INTO order_details VALUES ('489603ab-94e5-4f90-8647-f4d5bd144b78', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 20, 0);
INSERT INTO order_details VALUES ('d0cca777-1d8e-4be9-985e-8b0679a64406', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 11.1999998, 10, 0);
INSERT INTO order_details VALUES ('d0cca777-1d8e-4be9-985e-8b0679a64406', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 50, 0.150000006);
INSERT INTO order_details VALUES ('d0cca777-1d8e-4be9-985e-8b0679a64406', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 4, 0);
INSERT INTO order_details VALUES ('d0cca777-1d8e-4be9-985e-8b0679a64406', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 6, 0.150000006);
INSERT INTO order_details VALUES ('96b194d5-ee5d-4949-bb55-5aa663077268', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 14.3999996, 15, 0.150000006);
INSERT INTO order_details VALUES ('96b194d5-ee5d-4949-bb55-5aa663077268', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 7.19999981, 25, 0);
INSERT INTO order_details VALUES ('0f60b51e-3d80-454f-af12-fca02bff10a7', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 24, 0);
INSERT INTO order_details VALUES ('d1222e23-ea22-4673-aa30-8228e24fd15c', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 13, 15, 0.100000001);
INSERT INTO order_details VALUES ('d1222e23-ea22-4673-aa30-8228e24fd15c', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 18, 0.100000001);
INSERT INTO order_details VALUES ('d348eb64-9a51-44c0-9b2b-60620909185a', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 210.800003, 20, 0.0500000007);
INSERT INTO order_details VALUES ('d348eb64-9a51-44c0-9b2b-60620909185a', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 13, 0);
INSERT INTO order_details VALUES ('d348eb64-9a51-44c0-9b2b-60620909185a', '493f4894-c1cd-4285-9a14-219180421e20', 15.5, 77, 0.0500000007);
INSERT INTO order_details VALUES ('d348eb64-9a51-44c0-9b2b-60620909185a', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 10, 0.0500000007);
INSERT INTO order_details VALUES ('ac2e52fe-1141-4846-9128-e0b583f47c13', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 10, 0);
INSERT INTO order_details VALUES ('ac2e52fe-1141-4846-9128-e0b583f47c13', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 20, 0.150000006);
INSERT INTO order_details VALUES ('e8ed9778-df0b-4e1c-a90e-2fa6127e03a3', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 12, 0.200000003);
INSERT INTO order_details VALUES ('e8ed9778-df0b-4e1c-a90e-2fa6127e03a3', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 210.800003, 50, 0.200000003);
INSERT INTO order_details VALUES ('0b0eb553-3299-4e40-a077-dcb2f1b4691d', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 14.3999996, 12, 0);
INSERT INTO order_details VALUES ('0b0eb553-3299-4e40-a077-dcb2f1b4691d', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 4, 0);
INSERT INTO order_details VALUES ('783a8826-cbc3-4f6b-895b-7c745d7b8a45', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 25, 0);
INSERT INTO order_details VALUES ('783a8826-cbc3-4f6b-895b-7c745d7b8a45', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 15.6000004, 25, 0);
INSERT INTO order_details VALUES ('aec74b64-be80-41ea-9fc4-8f08596e10cd', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 30, 0);
INSERT INTO order_details VALUES ('aec74b64-be80-41ea-9fc4-8f08596e10cd', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 12, 0);
INSERT INTO order_details VALUES ('aec74b64-be80-41ea-9fc4-8f08596e10cd', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 20, 0);
INSERT INTO order_details VALUES ('42d67757-88fd-4610-bbab-edeeff1c5535', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 24.7999992, 30, 0.200000003);
INSERT INTO order_details VALUES ('42d67757-88fd-4610-bbab-edeeff1c5535', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 16, 0);
INSERT INTO order_details VALUES ('42d67757-88fd-4610-bbab-edeeff1c5535', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 8, 0.200000003);
INSERT INTO order_details VALUES ('e0f10858-09b1-4c3f-9ff0-c08d4f501b1d', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 10, 0.0500000007);
INSERT INTO order_details VALUES ('e0f10858-09b1-4c3f-9ff0-c08d4f501b1d', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 11.1999998, 10, 0.0500000007);
INSERT INTO order_details VALUES ('e0f10858-09b1-4c3f-9ff0-c08d4f501b1d', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 15.1999998, 20, 0.0500000007);
INSERT INTO order_details VALUES ('0ee48f5a-d7e4-415f-968f-43b5474e5d80', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 56, 0.0500000007);
INSERT INTO order_details VALUES ('0ee48f5a-d7e4-415f-968f-43b5474e5d80', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 70, 0.0500000007);
INSERT INTO order_details VALUES ('0ee48f5a-d7e4-415f-968f-43b5474e5d80', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 80, 0.0500000007);
INSERT INTO order_details VALUES ('69d88805-775e-476d-83b5-eef75d4d8b38', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 30, 0);
INSERT INTO order_details VALUES ('69d88805-775e-476d-83b5-eef75d4d8b38', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 35, 0);
INSERT INTO order_details VALUES ('69d88805-775e-476d-83b5-eef75d4d8b38', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 210.800003, 10, 0);
INSERT INTO order_details VALUES ('69d88805-775e-476d-83b5-eef75d4d8b38', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 16, 35, 0);
INSERT INTO order_details VALUES ('69d88805-775e-476d-83b5-eef75d4d8b38', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 28, 0);
INSERT INTO order_details VALUES ('f36fe825-330a-44c5-a1cf-5d78522275a8', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 54, 0.100000001);
INSERT INTO order_details VALUES ('f36fe825-330a-44c5-a1cf-5d78522275a8', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 55, 0.100000001);
INSERT INTO order_details VALUES ('3627e278-3e34-4b30-8158-8465408d4ac6', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 11.1999998, 50, 0);
INSERT INTO order_details VALUES ('3627e278-3e34-4b30-8158-8465408d4ac6', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 42.4000015, 20, 0);
INSERT INTO order_details VALUES ('3627e278-3e34-4b30-8158-8465408d4ac6', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 24, 0);
INSERT INTO order_details VALUES ('d937a9a1-d038-46ef-b1a0-887503049ac3', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 20, 0);
INSERT INTO order_details VALUES ('d937a9a1-d038-46ef-b1a0-887503049ac3', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 12, 0);
INSERT INTO order_details VALUES ('d937a9a1-d038-46ef-b1a0-887503049ac3', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 12, 0);
INSERT INTO order_details VALUES ('fda4610f-bd4e-44f7-8d96-e6ec0779f82f', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 30, 0);
INSERT INTO order_details VALUES ('fda4610f-bd4e-44f7-8d96-e6ec0779f82f', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 5, 0);
INSERT INTO order_details VALUES ('5659ee93-fb08-449a-8e2e-e1ef619d0261', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 24, 0);
INSERT INTO order_details VALUES ('dae8f2d1-4175-4192-8a98-90b1e016a31e', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 5, 0);
INSERT INTO order_details VALUES ('dae8f2d1-4175-4192-8a98-90b1e016a31e', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 5, 0);
INSERT INTO order_details VALUES ('7deef82d-60b1-41f9-97e2-5d3b31a4e450', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 11.1999998, 36, 0);
INSERT INTO order_details VALUES ('7deef82d-60b1-41f9-97e2-5d3b31a4e450', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 18, 0);
INSERT INTO order_details VALUES ('7deef82d-60b1-41f9-97e2-5d3b31a4e450', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 15, 0);
INSERT INTO order_details VALUES ('7deef82d-60b1-41f9-97e2-5d3b31a4e450', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 7, 0);
INSERT INTO order_details VALUES ('b8315d45-7a97-4d4e-b39f-53a77916491b', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 5, 0.100000001);
INSERT INTO order_details VALUES ('b8315d45-7a97-4d4e-b39f-53a77916491b', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 13, 0.100000001);
INSERT INTO order_details VALUES ('b8315d45-7a97-4d4e-b39f-53a77916491b', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 15.6000004, 25, 0);
INSERT INTO order_details VALUES ('b8315d45-7a97-4d4e-b39f-53a77916491b', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 35, 0.100000001);
INSERT INTO order_details VALUES ('02a3c1e0-cbad-4cd3-ae18-63a7ef933226', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 20, 0);
INSERT INTO order_details VALUES ('02a3c1e0-cbad-4cd3-ae18-63a7ef933226', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 18, 0.25);
INSERT INTO order_details VALUES ('c0ab77b1-48e8-439e-8174-09373d01b026', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 14.3999996, 15, 0.150000006);
INSERT INTO order_details VALUES ('c0ab77b1-48e8-439e-8174-09373d01b026', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 30, 0);
INSERT INTO order_details VALUES ('c0ab77b1-48e8-439e-8174-09373d01b026', '35757ead-53a9-44f2-a023-f8950dd9eeac', 8, 20, 0.150000006);
INSERT INTO order_details VALUES ('a59c0bc7-5a6d-4bb6-b986-ff7e46fb4fe4', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 15.1999998, 6, 0.200000003);
INSERT INTO order_details VALUES ('fbca218a-6267-42d3-a0d4-474f1475a7b8', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 64.8000031, 12, 0.25);
INSERT INTO order_details VALUES ('fbca218a-6267-42d3-a0d4-474f1475a7b8', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 210.800003, 40, 0.25);
INSERT INTO order_details VALUES ('fbca218a-6267-42d3-a0d4-474f1475a7b8', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 70, 0.25);
INSERT INTO order_details VALUES ('fbca218a-6267-42d3-a0d4-474f1475a7b8', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 42, 0.25);
INSERT INTO order_details VALUES ('4ad125b6-e2d3-42c3-a87d-e7d868732b1f', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 10.6000004, 80, 0.200000003);
INSERT INTO order_details VALUES ('4ad125b6-e2d3-42c3-a87d-e7d868732b1f', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 50, 0.200000003);
INSERT INTO order_details VALUES ('f0374539-42f2-4c25-9b7b-9be511f28ee7', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 30, 0);
INSERT INTO order_details VALUES ('f0374539-42f2-4c25-9b7b-9be511f28ee7', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 10.6000004, 15, 0);
INSERT INTO order_details VALUES ('f5bc86c4-540c-4529-b543-b7109a1b9528', '38262c84-2325-4c54-a537-7fd358d8b35e', 18.6000004, 15, 0);
INSERT INTO order_details VALUES ('f5bc86c4-540c-4529-b543-b7109a1b9528', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 10, 0);
INSERT INTO order_details VALUES ('4c822e5d-a194-4040-98dd-e68bf90acb10', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 42, 0.0500000007);
INSERT INTO order_details VALUES ('694291f0-1ee7-40d2-8802-9dcc89c7caf3', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 20, 0.150000006);
INSERT INTO order_details VALUES ('694291f0-1ee7-40d2-8802-9dcc89c7caf3', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 20, 0.150000006);
INSERT INTO order_details VALUES ('9981c9b7-813d-4e9b-bcea-993af63d3509', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 6, 0);
INSERT INTO order_details VALUES ('6dde5cd8-15c4-4ba0-8521-fc4d6c5fbea6', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 8, 0.100000001);
INSERT INTO order_details VALUES ('6dde5cd8-15c4-4ba0-8521-fc4d6c5fbea6', '6b840857-464e-4c75-b887-ee21d918ee05', 35.0999985, 16, 0.100000001);
INSERT INTO order_details VALUES ('6dde5cd8-15c4-4ba0-8521-fc4d6c5fbea6', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 20, 0.100000001);
INSERT INTO order_details VALUES ('4f169ffd-44e5-4dce-9a89-60be90561f09', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 18, 0.100000001);
INSERT INTO order_details VALUES ('4f169ffd-44e5-4dce-9a89-60be90561f09', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 20, 0.100000001);
INSERT INTO order_details VALUES ('4f169ffd-44e5-4dce-9a89-60be90561f09', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 6, 0.100000001);
INSERT INTO order_details VALUES ('4f169ffd-44e5-4dce-9a89-60be90561f09', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 30, 0);
INSERT INTO order_details VALUES ('e843b9d7-5133-4dc6-852f-64b51732e027', '35757ead-53a9-44f2-a023-f8950dd9eeac', 8, 14, 0);
INSERT INTO order_details VALUES ('9875f5ce-7318-4b0e-8d7b-c9de6348705d', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 17, 32, 0);
INSERT INTO order_details VALUES ('9875f5ce-7318-4b0e-8d7b-c9de6348705d', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 50, 9, 0);
INSERT INTO order_details VALUES ('9875f5ce-7318-4b0e-8d7b-c9de6348705d', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 14, 0);
INSERT INTO order_details VALUES ('9875f5ce-7318-4b0e-8d7b-c9de6348705d', 'd2394847-8829-4bec-b968-170c8429022f', 2, 60, 0);
INSERT INTO order_details VALUES ('9875f5ce-7318-4b0e-8d7b-c9de6348705d', '35757ead-53a9-44f2-a023-f8950dd9eeac', 8, 50, 0);
INSERT INTO order_details VALUES ('ed6796a4-7d83-48d3-b9e4-8cbe930c5505', '1b513001-91dd-4c4b-a64d-4e84520ee747', 4.80000019, 20, 0);
INSERT INTO order_details VALUES ('ed6796a4-7d83-48d3-b9e4-8cbe930c5505', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 13, 15, 0);
INSERT INTO order_details VALUES ('ed6796a4-7d83-48d3-b9e4-8cbe930c5505', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 20, 0);
INSERT INTO order_details VALUES ('d77f05d7-85ff-4150-bc24-7324661e6e26', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 64.8000031, 28, 0);
INSERT INTO order_details VALUES ('d77f05d7-85ff-4150-bc24-7324661e6e26', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 15, 0);
INSERT INTO order_details VALUES ('e22aa677-c328-4b23-829a-d16c08cb794b', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 24, 10, 0.200000003);
INSERT INTO order_details VALUES ('e22aa677-c328-4b23-829a-d16c08cb794b', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 20, 0.200000003);
INSERT INTO order_details VALUES ('e22aa677-c328-4b23-829a-d16c08cb794b', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 8, 0.200000003);
INSERT INTO order_details VALUES ('6aac1019-d358-441a-8b28-56193ddde612', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 15, 0);
INSERT INTO order_details VALUES ('6aac1019-d358-441a-8b28-56193ddde612', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 11.1999998, 10, 0);
INSERT INTO order_details VALUES ('8631b4cf-4656-4f36-8bfd-40bc0e72b504', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 15, 0);
INSERT INTO order_details VALUES ('8631b4cf-4656-4f36-8bfd-40bc0e72b504', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 6, 0);
INSERT INTO order_details VALUES ('8631b4cf-4656-4f36-8bfd-40bc0e72b504', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 12, 0);
INSERT INTO order_details VALUES ('8631b4cf-4656-4f36-8bfd-40bc0e72b504', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 15, 0);
INSERT INTO order_details VALUES ('321deeeb-9e3a-4776-ad15-71a7a9a775a3', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 7.5999999, 15, 0.200000003);
INSERT INTO order_details VALUES ('321deeeb-9e3a-4776-ad15-71a7a9a775a3', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 5.5999999, 20, 0.200000003);
INSERT INTO order_details VALUES ('321deeeb-9e3a-4776-ad15-71a7a9a775a3', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 40, 0);
INSERT INTO order_details VALUES ('d73f5254-a658-46ce-a5ff-79c3ca91308f', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 24.7999992, 16, 0);
INSERT INTO order_details VALUES ('d73f5254-a658-46ce-a5ff-79c3ca91308f', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 15, 0);
INSERT INTO order_details VALUES ('d73f5254-a658-46ce-a5ff-79c3ca91308f', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 20, 0);
INSERT INTO order_details VALUES ('d73f5254-a658-46ce-a5ff-79c3ca91308f', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 30, 0);
INSERT INTO order_details VALUES ('14f787ba-1445-458f-ae22-6fc49e0c90d0', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 60, 0.100000001);
INSERT INTO order_details VALUES ('14f787ba-1445-458f-ae22-6fc49e0c90d0', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 40, 0.100000001);
INSERT INTO order_details VALUES ('14f787ba-1445-458f-ae22-6fc49e0c90d0', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 45, 0);
INSERT INTO order_details VALUES ('14f787ba-1445-458f-ae22-6fc49e0c90d0', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 24, 0.100000001);
INSERT INTO order_details VALUES ('e14d681d-d9c0-4f2f-b9bf-4956a0e37543', '1b513001-91dd-4c4b-a64d-4e84520ee747', 4.80000019, 18, 0);
INSERT INTO order_details VALUES ('0038d1e9-42fc-4c4c-a9de-2b27fb7c1042', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 50, 0);
INSERT INTO order_details VALUES ('338d5c10-c260-4b11-a831-2486e69d0487', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 25, 0.25);
INSERT INTO order_details VALUES ('338d5c10-c260-4b11-a831-2486e69d0487', '38262c84-2325-4c54-a537-7fd358d8b35e', 18.6000004, 42, 0.25);
INSERT INTO order_details VALUES ('338d5c10-c260-4b11-a831-2486e69d0487', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 11.1999998, 7, 0.25);
INSERT INTO order_details VALUES ('338d5c10-c260-4b11-a831-2486e69d0487', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 70, 0.25);
INSERT INTO order_details VALUES ('338d5c10-c260-4b11-a831-2486e69d0487', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 32, 0);
INSERT INTO order_details VALUES ('ac32d227-90db-4073-86f6-78921493a1bf', '1b513001-91dd-4c4b-a64d-4e84520ee747', 4.80000019, 10, 0);
INSERT INTO order_details VALUES ('ac32d227-90db-4073-86f6-78921493a1bf', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 10, 0);
INSERT INTO order_details VALUES ('2fb9d4b3-e84d-4e4e-a9dc-67b91e6f68df', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 28, 0.100000001);
INSERT INTO order_details VALUES ('2fb9d4b3-e84d-4e4e-a9dc-67b91e6f68df', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 70, 0.100000001);
INSERT INTO order_details VALUES ('2fb9d4b3-e84d-4e4e-a9dc-67b91e6f68df', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 8, 0);
INSERT INTO order_details VALUES ('ffe78d78-6acc-426a-8b5d-257bb25b7217', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 7.19999981, 40, 0);
INSERT INTO order_details VALUES ('ffe78d78-6acc-426a-8b5d-257bb25b7217', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 60, 0);
INSERT INTO order_details VALUES ('ffe78d78-6acc-426a-8b5d-257bb25b7217', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 21, 0);
INSERT INTO order_details VALUES ('7a1bae58-bffe-4adc-aaeb-efea92b11558', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 10, 0.150000006);
INSERT INTO order_details VALUES ('7a1bae58-bffe-4adc-aaeb-efea92b11558', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 42.4000015, 18, 0.150000006);
INSERT INTO order_details VALUES ('963ecfa0-7547-4bfe-b0b2-da0d610a515a', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 30, 0);
INSERT INTO order_details VALUES ('963ecfa0-7547-4bfe-b0b2-da0d610a515a', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 120, 0.100000001);
INSERT INTO order_details VALUES ('22d3a6e3-c7dc-4921-8053-a33305655cab', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 60, 0);
INSERT INTO order_details VALUES ('22d3a6e3-c7dc-4921-8053-a33305655cab', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 30, 0);
INSERT INTO order_details VALUES ('22d3a6e3-c7dc-4921-8053-a33305655cab', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 35, 0);
INSERT INTO order_details VALUES ('22d3a6e3-c7dc-4921-8053-a33305655cab', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 14, 0);
INSERT INTO order_details VALUES ('71dd06dc-ef76-4ca4-bc7c-67571e83f6bc', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 21, 0);
INSERT INTO order_details VALUES ('71dd06dc-ef76-4ca4-bc7c-67571e83f6bc', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 35, 0);
INSERT INTO order_details VALUES ('71dd06dc-ef76-4ca4-bc7c-67571e83f6bc', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 16, 30, 0);
INSERT INTO order_details VALUES ('5efdbc16-7f0c-4ced-9afa-b8ed915b0d89', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 18, 0);
INSERT INTO order_details VALUES ('5efdbc16-7f0c-4ced-9afa-b8ed915b0d89', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 70, 0);
INSERT INTO order_details VALUES ('5efdbc16-7f0c-4ced-9afa-b8ed915b0d89', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 20, 0);
INSERT INTO order_details VALUES ('5efdbc16-7f0c-4ced-9afa-b8ed915b0d89', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 60, 0);
INSERT INTO order_details VALUES ('3ca8d08b-aa3c-49e3-9f31-74d52b431e62', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 7.19999981, 60, 0);
INSERT INTO order_details VALUES ('3ca8d08b-aa3c-49e3-9f31-74d52b431e62', '6b840857-464e-4c75-b887-ee21d918ee05', 35.0999985, 65, 0);
INSERT INTO order_details VALUES ('ff8c1665-29c7-4606-98fb-156afb72ee6e', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 21, 0.150000006);
INSERT INTO order_details VALUES ('ff8c1665-29c7-4606-98fb-156afb72ee6e', 'd81d4aa0-e0af-41eb-9ba1-42e8ee9559ef', 10.1999998, 70, 0.150000006);
INSERT INTO order_details VALUES ('791effc7-83e6-400e-8d6b-43cfd7f7e07b', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 30, 0.0500000007);
INSERT INTO order_details VALUES ('791effc7-83e6-400e-8d6b-43cfd7f7e07b', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 11.1999998, 40, 0.0500000007);
INSERT INTO order_details VALUES ('791effc7-83e6-400e-8d6b-43cfd7f7e07b', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 16, 30, 0.0500000007);
INSERT INTO order_details VALUES ('b22fce26-40a8-4b59-977a-8cc82e4db6c3', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 8, 50, 0);
INSERT INTO order_details VALUES ('7fb39fe3-37a4-4fa6-acac-af8cb8f56d07', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 14.3999996, 10, 0);
INSERT INTO order_details VALUES ('7fb39fe3-37a4-4fa6-acac-af8cb8f56d07', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 30, 0.100000001);
INSERT INTO order_details VALUES ('7fb39fe3-37a4-4fa6-acac-af8cb8f56d07', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 42, 0.100000001);
INSERT INTO order_details VALUES ('7fb39fe3-37a4-4fa6-acac-af8cb8f56d07', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 15.1999998, 5, 0.100000001);
INSERT INTO order_details VALUES ('7fb39fe3-37a4-4fa6-acac-af8cb8f56d07', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 2, 0.100000001);
INSERT INTO order_details VALUES ('3d5e1ea2-97ea-4ad0-ad37-f5afb86774f8', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 30, 0);
INSERT INTO order_details VALUES ('3d5e1ea2-97ea-4ad0-ad37-f5afb86774f8', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 15, 0);
INSERT INTO order_details VALUES ('3d5e1ea2-97ea-4ad0-ad37-f5afb86774f8', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 15, 0);
INSERT INTO order_details VALUES ('52b0a8e8-99e6-46b2-9187-28687492f13a', '8ad0f836-43df-42d9-a992-e1fee45d28d8', 20.7999992, 10, 0);
INSERT INTO order_details VALUES ('52b0a8e8-99e6-46b2-9187-28687492f13a', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 6, 0);
INSERT INTO order_details VALUES ('52b0a8e8-99e6-46b2-9187-28687492f13a', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 35, 0);
INSERT INTO order_details VALUES ('69512693-18ac-4dd9-8c63-111ced64fddc', '38262c84-2325-4c54-a537-7fd358d8b35e', 18.6000004, 12, 0);
INSERT INTO order_details VALUES ('69512693-18ac-4dd9-8c63-111ced64fddc', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 12, 0);
INSERT INTO order_details VALUES ('a529d48b-e5c3-4be6-be04-a24a56c1f38a', 'd2394847-8829-4bec-b968-170c8429022f', 2, 49, 0);
INSERT INTO order_details VALUES ('a529d48b-e5c3-4be6-be04-a24a56c1f38a', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 16, 0);
INSERT INTO order_details VALUES ('e916eddd-c929-4214-9872-26a956af348f', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 25, 0.200000003);
INSERT INTO order_details VALUES ('e916eddd-c929-4214-9872-26a956af348f', '493f4894-c1cd-4285-9a14-219180421e20', 15.5, 40, 0.200000003);
INSERT INTO order_details VALUES ('e916eddd-c929-4214-9872-26a956af348f', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 9, 0.200000003);
INSERT INTO order_details VALUES ('b17bd726-b5b9-4cdb-95b4-9223da29dd1d', '38262c84-2325-4c54-a537-7fd358d8b35e', 18.6000004, 20, 0.100000001);
INSERT INTO order_details VALUES ('156c58dd-60c6-42b9-a350-1eb9fd2f6fe2', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 14.3999996, 24, 0);
INSERT INTO order_details VALUES ('156c58dd-60c6-42b9-a350-1eb9fd2f6fe2', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 40, 0);
INSERT INTO order_details VALUES ('156c58dd-60c6-42b9-a350-1eb9fd2f6fe2', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 14, 0);
INSERT INTO order_details VALUES ('7c9d1b33-c5d5-45d1-bd17-e8c15c31257d', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 18, 0.0500000007);
INSERT INTO order_details VALUES ('7c9d1b33-c5d5-45d1-bd17-e8c15c31257d', 'd2394847-8829-4bec-b968-170c8429022f', 2, 50, 0);
INSERT INTO order_details VALUES ('890fe993-54a5-4eb8-9bca-61e04f220a3e', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 2, 0);
INSERT INTO order_details VALUES ('890fe993-54a5-4eb8-9bca-61e04f220a3e', 'd2394847-8829-4bec-b968-170c8429022f', 2, 20, 0);
INSERT INTO order_details VALUES ('83a7b260-1175-4590-b35d-a6fd37ad5826', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 20, 0);
INSERT INTO order_details VALUES ('83a7b260-1175-4590-b35d-a6fd37ad5826', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 10, 0);
INSERT INTO order_details VALUES ('83a7b260-1175-4590-b35d-a6fd37ad5826', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 15.6000004, 20, 0);
INSERT INTO order_details VALUES ('1e0f2776-1ce3-47d9-aad0-a69bdd9c326a', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 210.800003, 50, 0);
INSERT INTO order_details VALUES ('1e0f2776-1ce3-47d9-aad0-a69bdd9c326a', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 2, 0.25);
INSERT INTO order_details VALUES ('1e0f2776-1ce3-47d9-aad0-a69bdd9c326a', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 36, 0.25);
INSERT INTO order_details VALUES ('1e0f2776-1ce3-47d9-aad0-a69bdd9c326a', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 35, 0);
INSERT INTO order_details VALUES ('a7e92be2-d778-40bf-87a0-e8849465bd9b', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 60, 0);
INSERT INTO order_details VALUES ('a7e92be2-d778-40bf-87a0-e8849465bd9b', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 7.5999999, 55, 0);
INSERT INTO order_details VALUES ('a7e92be2-d778-40bf-87a0-e8849465bd9b', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 22.7999992, 16, 0);
INSERT INTO order_details VALUES ('a7e92be2-d778-40bf-87a0-e8849465bd9b', '35757ead-53a9-44f2-a023-f8950dd9eeac', 8, 15, 0);
INSERT INTO order_details VALUES ('0e144a17-9f6c-4ed7-9fd2-a2f56673fb8e', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 60, 0.0500000007);
INSERT INTO order_details VALUES ('0e144a17-9f6c-4ed7-9fd2-a2f56673fb8e', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 20, 0.0500000007);
INSERT INTO order_details VALUES ('76caa919-1346-4780-9ebd-537891fabd18', 'af59c8a6-47cb-48a5-888b-b4f1f195656e', 77.5999985, 20, 0.100000001);
INSERT INTO order_details VALUES ('76caa919-1346-4780-9ebd-537891fabd18', '1b513001-91dd-4c4b-a64d-4e84520ee747', 4.80000019, 2, 0.100000001);
INSERT INTO order_details VALUES ('76caa919-1346-4780-9ebd-537891fabd18', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 8, 0.100000001);
INSERT INTO order_details VALUES ('76caa919-1346-4780-9ebd-537891fabd18', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 12, 20, 0.100000001);
INSERT INTO order_details VALUES ('a4725a41-9d5b-48fb-a387-2f4f606782b7', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 4, 0.150000006);
INSERT INTO order_details VALUES ('a4725a41-9d5b-48fb-a387-2f4f606782b7', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 30, 0);
INSERT INTO order_details VALUES ('a4725a41-9d5b-48fb-a387-2f4f606782b7', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 15, 0.150000006);
INSERT INTO order_details VALUES ('a4725a41-9d5b-48fb-a387-2f4f606782b7', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 10, 0.150000006);
INSERT INTO order_details VALUES ('af53087d-25e3-41aa-acaf-c50802f4d434', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 2, 0);
INSERT INTO order_details VALUES ('76fbf3b0-961e-4ae2-aac3-d5eeb1245c2b', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 14, 0);
INSERT INTO order_details VALUES ('76fbf3b0-961e-4ae2-aac3-d5eeb1245c2b', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 20, 0);
INSERT INTO order_details VALUES ('c6c0e72c-6c6c-458f-b569-666b245194d0', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 60, 0.200000003);
INSERT INTO order_details VALUES ('c6c0e72c-6c6c-458f-b569-666b245194d0', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 210.800003, 49, 0.200000003);
INSERT INTO order_details VALUES ('c6c0e72c-6c6c-458f-b569-666b245194d0', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 30, 0.200000003);
INSERT INTO order_details VALUES ('a9eb360c-be27-49b9-aba9-150f47df869a', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 10, 0.25);
INSERT INTO order_details VALUES ('a9eb360c-be27-49b9-aba9-150f47df869a', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 20, 0.25);
INSERT INTO order_details VALUES ('5b412191-7680-4897-87a1-1c2fce5e458b', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 5, 0);
INSERT INTO order_details VALUES ('5b412191-7680-4897-87a1-1c2fce5e458b', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 7, 0);
INSERT INTO order_details VALUES ('2a72c5a7-5625-4ef9-9c13-9e179e189ba9', '38262c84-2325-4c54-a537-7fd358d8b35e', 18.6000004, 35, 0);
INSERT INTO order_details VALUES ('fa5436eb-f8a2-4785-954e-0f1097b58fb6', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 20, 0);
INSERT INTO order_details VALUES ('615e57f6-b219-4671-9594-0009fb6b4d12', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 13, 40, 0);
INSERT INTO order_details VALUES ('615e57f6-b219-4671-9594-0009fb6b4d12', '6b840857-464e-4c75-b887-ee21d918ee05', 35.0999985, 35, 0.25);
INSERT INTO order_details VALUES ('53831dfa-7463-4597-b026-3db2250d38e5', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 45, 0.200000003);
INSERT INTO order_details VALUES ('53831dfa-7463-4597-b026-3db2250d38e5', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 50, 0);
INSERT INTO order_details VALUES ('53831dfa-7463-4597-b026-3db2250d38e5', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 30, 0);
INSERT INTO order_details VALUES ('53831dfa-7463-4597-b026-3db2250d38e5', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 70, 0.200000003);
INSERT INTO order_details VALUES ('ab0770de-8e8a-4ea9-b7da-af2237a520a9', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 50, 0.25);
INSERT INTO order_details VALUES ('ab0770de-8e8a-4ea9-b7da-af2237a520a9', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 50, 0.25);
INSERT INTO order_details VALUES ('ab0770de-8e8a-4ea9-b7da-af2237a520a9', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 7.5999999, 30, 0.25);
INSERT INTO order_details VALUES ('48290a08-2617-4ad2-8320-71a394ef7c17', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 10, 0);
INSERT INTO order_details VALUES ('48290a08-2617-4ad2-8320-71a394ef7c17', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 40, 0);
INSERT INTO order_details VALUES ('9e9a82dd-cb1f-4650-8510-a31cae4a6d0f', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 28, 0);
INSERT INTO order_details VALUES ('65a60a0c-ffb7-465b-b10d-50f14434bb27', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 6, 0);
INSERT INTO order_details VALUES ('65a60a0c-ffb7-465b-b10d-50f14434bb27', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 18, 0.150000006);
INSERT INTO order_details VALUES ('9800c582-05a2-4c3d-96bc-037057106ebb', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 10, 0);
INSERT INTO order_details VALUES ('9800c582-05a2-4c3d-96bc-037057106ebb', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 16.7999992, 12, 0);
INSERT INTO order_details VALUES ('9800c582-05a2-4c3d-96bc-037057106ebb', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 10, 0);
INSERT INTO order_details VALUES ('ac518e11-401d-4712-a060-320814a3f88a', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 5, 0);
INSERT INTO order_details VALUES ('ac518e11-401d-4712-a060-320814a3f88a', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 40, 0.100000001);
INSERT INTO order_details VALUES ('ac518e11-401d-4712-a060-320814a3f88a', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 30, 0.100000001);
INSERT INTO order_details VALUES ('ac518e11-401d-4712-a060-320814a3f88a', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 24, 0.100000001);
INSERT INTO order_details VALUES ('ed4b47db-7675-4972-944b-8d27a248cbfb', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 15, 0);
INSERT INTO order_details VALUES ('358fb589-764e-43c8-b095-b7e4324da98b', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 15, 0.200000003);
INSERT INTO order_details VALUES ('358fb589-764e-43c8-b095-b7e4324da98b', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 11.1999998, 20, 0.200000003);
INSERT INTO order_details VALUES ('358fb589-764e-43c8-b095-b7e4324da98b', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 15.6000004, 15, 0.200000003);
INSERT INTO order_details VALUES ('56065909-525d-455a-865a-c01af709f980', 'faa17edb-402d-402a-a859-af6b8321f8da', 30.3999996, 15, 0);
INSERT INTO order_details VALUES ('56065909-525d-455a-865a-c01af709f980', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 16, 0);
INSERT INTO order_details VALUES ('56065909-525d-455a-865a-c01af709f980', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 6, 0);
INSERT INTO order_details VALUES ('56065909-525d-455a-865a-c01af709f980', '35757ead-53a9-44f2-a023-f8950dd9eeac', 8, 30, 0);
INSERT INTO order_details VALUES ('88ca9a13-a927-428a-a012-7ce0ed971aab', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 45, 0.150000006);
INSERT INTO order_details VALUES ('88ca9a13-a927-428a-a012-7ce0ed971aab', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 49, 0.150000006);
INSERT INTO order_details VALUES ('88ca9a13-a927-428a-a012-7ce0ed971aab', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 24, 0.150000006);
INSERT INTO order_details VALUES ('88ca9a13-a927-428a-a012-7ce0ed971aab', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 22.7999992, 90, 0.150000006);
INSERT INTO order_details VALUES ('ea344696-a00c-49e8-9dc6-a80c35c166d3', '53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 35.0999985, 50, 0);
INSERT INTO order_details VALUES ('631605ce-cb2a-4987-8d38-7e797a28d6d6', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 30, 0);
INSERT INTO order_details VALUES ('631605ce-cb2a-4987-8d38-7e797a28d6d6', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 80, 0);
INSERT INTO order_details VALUES ('631605ce-cb2a-4987-8d38-7e797a28d6d6', '309dcfa3-7eea-4a14-9795-f8693838c3bd', 13.6000004, 60, 0);
INSERT INTO order_details VALUES ('ba055ac4-dff7-49c8-8310-07fbe3e93724', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 6, 0.200000003);
INSERT INTO order_details VALUES ('ba055ac4-dff7-49c8-8310-07fbe3e93724', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 12, 0);
INSERT INTO order_details VALUES ('c8016d0d-0100-4b92-a646-c20154c6b4d1', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 31.2000008, 10, 0);
INSERT INTO order_details VALUES ('c8016d0d-0100-4b92-a646-c20154c6b4d1', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 15, 0);
INSERT INTO order_details VALUES ('c8016d0d-0100-4b92-a646-c20154c6b4d1', '61f41763-1ece-4378-810f-0a866a077be5', 14.3999996, 8, 0);
INSERT INTO order_details VALUES ('c8016d0d-0100-4b92-a646-c20154c6b4d1', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 30, 0);
INSERT INTO order_details VALUES ('96ddc922-1480-4dbb-8492-bd47d54d717d', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 6, 0);
INSERT INTO order_details VALUES ('96ddc922-1480-4dbb-8492-bd47d54d717d', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 15, 0);
INSERT INTO order_details VALUES ('fba14cae-c850-4f94-8258-a058f765b2ce', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 12, 0.100000001);
INSERT INTO order_details VALUES ('fba14cae-c850-4f94-8258-a058f765b2ce', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 20, 0.100000001);
INSERT INTO order_details VALUES ('fba14cae-c850-4f94-8258-a058f765b2ce', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 3, 0.100000001);
INSERT INTO order_details VALUES ('fba14cae-c850-4f94-8258-a058f765b2ce', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 5.5999999, 15, 0.100000001);
INSERT INTO order_details VALUES ('2a272b6c-df13-42e2-8925-f9f33215a3aa', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 40, 0);
INSERT INTO order_details VALUES ('2a272b6c-df13-42e2-8925-f9f33215a3aa', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 35, 0);
INSERT INTO order_details VALUES ('2a272b6c-df13-42e2-8925-f9f33215a3aa', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 2, 0);
INSERT INTO order_details VALUES ('2de3ba01-2a5a-4f07-94d9-b995288182bb', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 6, 0);
INSERT INTO order_details VALUES ('2de3ba01-2a5a-4f07-94d9-b995288182bb', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 20, 0);
INSERT INTO order_details VALUES ('a3713045-4330-4011-af01-611ff7a1a867', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 24.7999992, 14, 0);
INSERT INTO order_details VALUES ('a3713045-4330-4011-af01-611ff7a1a867', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 5.5999999, 20, 0);
INSERT INTO order_details VALUES ('a3713045-4330-4011-af01-611ff7a1a867', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 39.4000015, 35, 0);
INSERT INTO order_details VALUES ('1611192f-4abc-4a91-9fb3-937e53eac7c1', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 24.7999992, 20, 0.200000003);
INSERT INTO order_details VALUES ('1611192f-4abc-4a91-9fb3-937e53eac7c1', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 6, 0.200000003);
INSERT INTO order_details VALUES ('a42adc23-cf54-41ae-9e06-03b4e7dbb09a', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 120, 0.100000001);
INSERT INTO order_details VALUES ('a42adc23-cf54-41ae-9e06-03b4e7dbb09a', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 35, 0.100000001);
INSERT INTO order_details VALUES ('a42adc23-cf54-41ae-9e06-03b4e7dbb09a', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 28, 0.100000001);
INSERT INTO order_details VALUES ('a42adc23-cf54-41ae-9e06-03b4e7dbb09a', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 55, 0.100000001);
INSERT INTO order_details VALUES ('b462bacb-6603-4be0-bd66-cb483d01f568', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 15, 0);
INSERT INTO order_details VALUES ('b462bacb-6603-4be0-bd66-cb483d01f568', '493f4894-c1cd-4285-9a14-219180421e20', 15.5, 100, 0.0500000007);
INSERT INTO order_details VALUES ('3ed8d7ad-745a-416f-938f-5374fff9e27b', 'd81d4aa0-e0af-41eb-9ba1-42e8ee9559ef', 10.1999998, 15, 0.100000001);
INSERT INTO order_details VALUES ('3ed8d7ad-745a-416f-938f-5374fff9e27b', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 25, 0.100000001);
INSERT INTO order_details VALUES ('ec683815-0bf7-495f-8dc5-1cfb6a0000ca', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 20, 0.200000003);
INSERT INTO order_details VALUES ('ec683815-0bf7-495f-8dc5-1cfb6a0000ca', 'd2394847-8829-4bec-b968-170c8429022f', 2, 20, 0.200000003);
INSERT INTO order_details VALUES ('ec683815-0bf7-495f-8dc5-1cfb6a0000ca', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 10, 0.200000003);
INSERT INTO order_details VALUES ('da2d6c6f-db56-4238-93f1-3f249fd533f7', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 20, 0);
INSERT INTO order_details VALUES ('da2d6c6f-db56-4238-93f1-3f249fd533f7', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 50, 0);
INSERT INTO order_details VALUES ('da2d6c6f-db56-4238-93f1-3f249fd533f7', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 22.7999992, 25, 0);
INSERT INTO order_details VALUES ('da2d6c6f-db56-4238-93f1-3f249fd533f7', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 30, 0);
INSERT INTO order_details VALUES ('4a381afe-70fa-42c3-8b78-b91a5ffac1b4', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 40, 0.150000006);
INSERT INTO order_details VALUES ('4a381afe-70fa-42c3-8b78-b91a5ffac1b4', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 16, 21, 0.150000006);
INSERT INTO order_details VALUES ('ebe03178-8c50-4e1e-87f0-2e7ca5c18c71', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 36, 0);
INSERT INTO order_details VALUES ('2c54f6a6-742b-44a1-be8f-8f3878d10080', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 30, 0);
INSERT INTO order_details VALUES ('2c54f6a6-742b-44a1-be8f-8f3878d10080', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 30, 0);
INSERT INTO order_details VALUES ('2c54f6a6-742b-44a1-be8f-8f3878d10080', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 36.7999992, 20, 0);
INSERT INTO order_details VALUES ('2c54f6a6-742b-44a1-be8f-8f3878d10080', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 15, 0);
INSERT INTO order_details VALUES ('2c54f6a6-742b-44a1-be8f-8f3878d10080', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 50, 0);
INSERT INTO order_details VALUES ('ba3d61f0-f4ee-4511-80b4-50415d86de78', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 24, 16, 0.0500000007);
INSERT INTO order_details VALUES ('ba3d61f0-f4ee-4511-80b4-50415d86de78', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 20, 0.0500000007);
INSERT INTO order_details VALUES ('ba3d61f0-f4ee-4511-80b4-50415d86de78', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 40, 0);
INSERT INTO order_details VALUES ('3f3e83d7-af16-46d9-b0a9-489a435a511c', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 21, 0.25);
INSERT INTO order_details VALUES ('3f3e83d7-af16-46d9-b0a9-489a435a511c', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 4, 0.25);
INSERT INTO order_details VALUES ('1f7a33b9-5d00-4abf-b7b4-13bb8d885bed', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 40, 0.25);
INSERT INTO order_details VALUES ('1f7a33b9-5d00-4abf-b7b4-13bb8d885bed', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 28, 0.25);
INSERT INTO order_details VALUES ('1f7a33b9-5d00-4abf-b7b4-13bb8d885bed', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 60, 0.25);
INSERT INTO order_details VALUES ('c682a85b-f60d-4cf6-bf6e-a5e5b99bb0c5', '1b513001-91dd-4c4b-a64d-4e84520ee747', 4.80000019, 1, 0);
INSERT INTO order_details VALUES ('c682a85b-f60d-4cf6-bf6e-a5e5b99bb0c5', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 7.19999981, 21, 0);
INSERT INTO order_details VALUES ('0a28bbf3-38bb-4334-b058-938f34af0560', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 21, 0);
INSERT INTO order_details VALUES ('0a28bbf3-38bb-4334-b058-938f34af0560', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 11.1999998, 50, 0);
INSERT INTO order_details VALUES ('2e8ecf9f-e2ce-478e-b828-6111c8bdaace', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 17.6000004, 16, 0.200000003);
INSERT INTO order_details VALUES ('2e8ecf9f-e2ce-478e-b828-6111c8bdaace', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 36.7999992, 3, 0);
INSERT INTO order_details VALUES ('2e8ecf9f-e2ce-478e-b828-6111c8bdaace', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 30, 0.200000003);
INSERT INTO order_details VALUES ('2e8ecf9f-e2ce-478e-b828-6111c8bdaace', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 20, 0);
INSERT INTO order_details VALUES ('ed2fcf6f-4b85-496d-a9b8-46f564002127', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 25, 0);
INSERT INTO order_details VALUES ('ed2fcf6f-4b85-496d-a9b8-46f564002127', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 99, 18, 0.100000001);
INSERT INTO order_details VALUES ('ed2fcf6f-4b85-496d-a9b8-46f564002127', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 20, 0);
INSERT INTO order_details VALUES ('ed2fcf6f-4b85-496d-a9b8-46f564002127', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 7.5999999, 30, 0.100000001);
INSERT INTO order_details VALUES ('ed2fcf6f-4b85-496d-a9b8-46f564002127', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 13, 25, 0);
INSERT INTO order_details VALUES ('af60e792-2aef-4a2b-b20d-d8797443f570', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 10, 0);
INSERT INTO order_details VALUES ('af60e792-2aef-4a2b-b20d-d8797443f570', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 9.60000038, 5, 0);
INSERT INTO order_details VALUES ('4e6e5f4c-af33-4ddc-b5ac-fb38fe982244', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 28, 0);
INSERT INTO order_details VALUES ('4e6e5f4c-af33-4ddc-b5ac-fb38fe982244', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 11.1999998, 12, 0);
INSERT INTO order_details VALUES ('dad7a7cc-c14f-44d8-8088-5ce6ba7837b7', '6cb25a55-c162-4d91-859b-6c7f5f966462', 20.7000008, 8, 0);
INSERT INTO order_details VALUES ('dad7a7cc-c14f-44d8-8088-5ce6ba7837b7', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 36.7999992, 15, 0);
INSERT INTO order_details VALUES ('0671413f-bbb5-4874-b7bc-ddd6bec1b99b', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 40, 0.150000006);
INSERT INTO order_details VALUES ('0671413f-bbb5-4874-b7bc-ddd6bec1b99b', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 35, 0.150000006);
INSERT INTO order_details VALUES ('0671413f-bbb5-4874-b7bc-ddd6bec1b99b', '493f4894-c1cd-4285-9a14-219180421e20', 15.5, 2, 0.150000006);
INSERT INTO order_details VALUES ('ec6287b4-e4a0-4ac4-a256-698b051fac2e', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 50, 30, 0);
INSERT INTO order_details VALUES ('ec6287b4-e4a0-4ac4-a256-698b051fac2e', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 7.19999981, 15, 0);
INSERT INTO order_details VALUES ('ec6287b4-e4a0-4ac4-a256-698b051fac2e', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 8, 0);
INSERT INTO order_details VALUES ('204fcb58-517a-4c75-a1ea-2e0df26b1e36', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 24, 30, 0);
INSERT INTO order_details VALUES ('204fcb58-517a-4c75-a1ea-2e0df26b1e36', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 20, 0);
INSERT INTO order_details VALUES ('dd5995a0-0bd8-4761-8a89-db1a14acf28b', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 3.5999999, 80, 0.0500000007);
INSERT INTO order_details VALUES ('dd5995a0-0bd8-4761-8a89-db1a14acf28b', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 42.4000015, 18, 0);
INSERT INTO order_details VALUES ('2de05c49-311b-4925-8ccb-e2203ecc0628', 'd2394847-8829-4bec-b968-170c8429022f', 2, 12, 0);
INSERT INTO order_details VALUES ('2de05c49-311b-4925-8ccb-e2203ecc0628', '1437bd3c-b711-4327-86e1-e8300e84386d', 17.2000008, 12, 0);
INSERT INTO order_details VALUES ('6baddb23-60bb-467e-92f7-08e9cd1dee8d', '38262c84-2325-4c54-a537-7fd358d8b35e', 18.6000004, 12, 0);
INSERT INTO order_details VALUES ('6baddb23-60bb-467e-92f7-08e9cd1dee8d', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 36.4000015, 18, 0);
INSERT INTO order_details VALUES ('6baddb23-60bb-467e-92f7-08e9cd1dee8d', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 21, 0);
INSERT INTO order_details VALUES ('6baddb23-60bb-467e-92f7-08e9cd1dee8d', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 10, 0);
INSERT INTO order_details VALUES ('dc12ecd8-2d36-4d24-88f1-792c87ccbe8b', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 35, 0.150000006);
INSERT INTO order_details VALUES ('dc12ecd8-2d36-4d24-88f1-792c87ccbe8b', '309dcfa3-7eea-4a14-9795-f8693838c3bd', 13.6000004, 60, 0.150000006);
INSERT INTO order_details VALUES ('dc12ecd8-2d36-4d24-88f1-792c87ccbe8b', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 14.3999996, 42, 0.150000006);
INSERT INTO order_details VALUES ('4a7715bc-b104-4237-9cfc-f58dc1816970', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 2, 0.0500000007);
INSERT INTO order_details VALUES ('4a7715bc-b104-4237-9cfc-f58dc1816970', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 12, 0);
INSERT INTO order_details VALUES ('9ebf9bd5-e441-44d4-aa2f-c7a11564695a', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 14.3999996, 15, 0);
INSERT INTO order_details VALUES ('9ebf9bd5-e441-44d4-aa2f-c7a11564695a', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 21, 0.25);
INSERT INTO order_details VALUES ('9ebf9bd5-e441-44d4-aa2f-c7a11564695a', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 14.3999996, 20, 0.25);
INSERT INTO order_details VALUES ('1eb08da9-5cae-428f-ad0d-6d9816c9493a', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 24.7999992, 20, 0.0500000007);
INSERT INTO order_details VALUES ('f0429157-f54b-4dad-a641-544b2089fc27', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 210.800003, 30, 0);
INSERT INTO order_details VALUES ('f0429157-f54b-4dad-a641-544b2089fc27', '92009acc-e997-414f-a982-9f2fb872c9a6', 26.2000008, 28, 0);
INSERT INTO order_details VALUES ('f0429157-f54b-4dad-a641-544b2089fc27', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 60, 0);
INSERT INTO order_details VALUES ('f0429157-f54b-4dad-a641-544b2089fc27', 'a5924475-b665-46aa-97ee-b268fda8740e', 26.6000004, 30, 0);
INSERT INTO order_details VALUES ('4dc9fd79-ade2-48d4-b638-d5e5ff8c84f8', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 7.5999999, 30, 0);
INSERT INTO order_details VALUES ('4dc9fd79-ade2-48d4-b638-d5e5ff8c84f8', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 12, 0);
INSERT INTO order_details VALUES ('34844818-efef-484a-bfad-0663823f2576', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 16, 24, 0);
INSERT INTO order_details VALUES ('34844818-efef-484a-bfad-0663823f2576', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 27.2000008, 40, 0);
INSERT INTO order_details VALUES ('8cc52457-d2e1-4e61-ac32-ff6307fe093f', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 10, 0);
INSERT INTO order_details VALUES ('14cd07c7-9812-4193-99c8-78c3af28c8a7', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 11.1999998, 35, 0.0500000007);
INSERT INTO order_details VALUES ('14cd07c7-9812-4193-99c8-78c3af28c8a7', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 30, 0.0500000007);
INSERT INTO order_details VALUES ('a6d0ed0c-a148-447c-8af0-87e6a389c91c', '22b15424-92eb-4ac1-b839-141041a32d95', 8, 14, 0);
INSERT INTO order_details VALUES ('a6d0ed0c-a148-447c-8af0-87e6a389c91c', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 14.6999998, 10, 0);
INSERT INTO order_details VALUES ('a6d0ed0c-a148-447c-8af0-87e6a389c91c', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 42.4000015, 3, 0);
INSERT INTO order_details VALUES ('d7c9c099-944b-4522-84d5-f50707b9aa5f', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 15.1999998, 20, 0.100000001);
INSERT INTO order_details VALUES ('d7c9c099-944b-4522-84d5-f50707b9aa5f', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 8, 20, 0.100000001);
INSERT INTO order_details VALUES ('d7c9c099-944b-4522-84d5-f50707b9aa5f', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 19.2000008, 30, 0.100000001);
INSERT INTO order_details VALUES ('d7c9c099-944b-4522-84d5-f50707b9aa5f', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 12, 60, 0.100000001);
INSERT INTO order_details VALUES ('ed59a6ef-782d-46aa-be9b-627be3c8734e', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 5, 0);
INSERT INTO order_details VALUES ('ed59a6ef-782d-46aa-be9b-627be3c8734e', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 42.4000015, 25, 0);
INSERT INTO order_details VALUES ('ed59a6ef-782d-46aa-be9b-627be3c8734e', '35757ead-53a9-44f2-a023-f8950dd9eeac', 8, 16, 0);
INSERT INTO order_details VALUES ('ae7f601b-389b-47bb-b9b1-f40e3d050715', '23e32477-99f5-4e2d-9797-345c0c1374cf', 7.30000019, 5, 0);
INSERT INTO order_details VALUES ('ae7f601b-389b-47bb-b9b1-f40e3d050715', '9a149867-007f-41b6-8e33-2484a53383ad', 24.8999996, 30, 0);
INSERT INTO order_details VALUES ('ae7f601b-389b-47bb-b9b1-f40e3d050715', 'e299b717-99b4-4452-8214-f603abc3c12c', 5.9000001, 24, 0.25);
INSERT INTO order_details VALUES ('f2fbc312-1b3d-4104-834e-fcaf7fcbcf14', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 30, 0);
INSERT INTO order_details VALUES ('f2fbc312-1b3d-4104-834e-fcaf7fcbcf14', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 12, 20, 0.200000003);
INSERT INTO order_details VALUES ('3ce51690-ad62-4371-8047-8bf25c509e12', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 16.7999992, 15, 0.25);
INSERT INTO order_details VALUES ('3ce51690-ad62-4371-8047-8bf25c509e12', 'c5aed807-369f-422e-933d-8651810373ab', 13.8999996, 18, 0);
INSERT INTO order_details VALUES ('26bb31e2-8371-40f8-8b7c-a801b0479b2d', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 44, 60, 0);
INSERT INTO order_details VALUES ('26bb31e2-8371-40f8-8b7c-a801b0479b2d', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 10, 30, 0);
INSERT INTO order_details VALUES ('26bb31e2-8371-40f8-8b7c-a801b0479b2d', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 6.19999981, 36, 0);
INSERT INTO order_details VALUES ('3bb544ce-23d3-442e-a0dc-c1d2bd4b6fe8', '493f4894-c1cd-4285-9a14-219180421e20', 15.5, 15, 0.150000006);
INSERT INTO order_details VALUES ('3bb544ce-23d3-442e-a0dc-c1d2bd4b6fe8', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 7, 0.150000006);
INSERT INTO order_details VALUES ('57eaf0ee-d214-4e9a-accd-7900c56da7d9', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 11.1999998, 60, 0.0500000007);
INSERT INTO order_details VALUES ('57eaf0ee-d214-4e9a-accd-7900c56da7d9', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 11.1999998, 20, 0.0500000007);
INSERT INTO order_details VALUES ('0f8a9af2-9960-44e8-a1ed-31675cc3aaaa', '0b2e3170-f274-4be0-af86-babaae306d97', 16.7999992, 15, 0.100000001);
INSERT INTO order_details VALUES ('0f8a9af2-9960-44e8-a1ed-31675cc3aaaa', '309dcfa3-7eea-4a14-9795-f8693838c3bd', 13.6000004, 10, 0.100000001);
INSERT INTO order_details VALUES ('0f8a9af2-9960-44e8-a1ed-31675cc3aaaa', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 28.7999992, 10, 0.100000001);
INSERT INTO order_details VALUES ('18b33bb6-b3e0-4a5f-aeb5-e0ccc7d2e712', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 30, 0);
INSERT INTO order_details VALUES ('b65e9f48-d5f7-4991-9539-c525a0ddd906', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 7.19999981, 10, 0);
INSERT INTO order_details VALUES ('b65e9f48-d5f7-4991-9539-c525a0ddd906', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 7.69999981, 20, 0);
INSERT INTO order_details VALUES ('b65e9f48-d5f7-4991-9539-c525a0ddd906', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 5, 0);
INSERT INTO order_details VALUES ('9baf0e3b-66d5-40f4-ad56-4e8a4c2a4a50', '23360db3-5576-443b-bd45-5c5e04ef26a2', 10, 20, 0.0500000007);
INSERT INTO order_details VALUES ('2e0e5268-038f-403e-a512-f9f8fa18229b', '59126ec1-07d2-4eb8-a286-9982783e117b', 30.3999996, 14, 0);
INSERT INTO order_details VALUES ('2e0e5268-038f-403e-a512-f9f8fa18229b', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 27.7999992, 25, 0);
INSERT INTO order_details VALUES ('2e0e5268-038f-403e-a512-f9f8fa18229b', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 10.3999996, 25, 0);
INSERT INTO order_details VALUES ('276b7a04-a975-4704-8f4d-c16ce0c7207c', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 14, 0);
INSERT INTO order_details VALUES ('276b7a04-a975-4704-8f4d-c16ce0c7207c', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 5, 0);
INSERT INTO order_details VALUES ('276b7a04-a975-4704-8f4d-c16ce0c7207c', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 30, 0);
INSERT INTO order_details VALUES ('f2b3b226-b1a5-4394-8196-e7cd3ec2d2f2', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 20, 0);
INSERT INTO order_details VALUES ('f2b3b226-b1a5-4394-8196-e7cd3ec2d2f2', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 25, 0);
INSERT INTO order_details VALUES ('ae611f6d-e070-4b4a-82b4-326d41276594', '0684ad85-cbf4-4340-b11e-e3c9caf11ee1', 15.5, 12, 0.0500000007);
INSERT INTO order_details VALUES ('ae611f6d-e070-4b4a-82b4-326d41276594', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 8, 0.0500000007);
INSERT INTO order_details VALUES ('156383ba-f212-45ae-963a-93e8eec5b7bd', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 20, 0);
INSERT INTO order_details VALUES ('a1fcde02-51b6-4fdb-9ade-037a45f656e4', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 21, 0);
INSERT INTO order_details VALUES ('a1fcde02-51b6-4fdb-9ade-037a45f656e4', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 6, 0);
INSERT INTO order_details VALUES ('a1fcde02-51b6-4fdb-9ade-037a45f656e4', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 14, 30, 0);
INSERT INTO order_details VALUES ('15a5e4fc-7a90-4d4b-9df2-cc9a8a3d8659', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 70, 0);
INSERT INTO order_details VALUES ('15a5e4fc-7a90-4d4b-9df2-cc9a8a3d8659', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 20, 0);
INSERT INTO order_details VALUES ('8806978f-7d3a-484c-a711-e3e1345c5635', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 12, 0);
INSERT INTO order_details VALUES ('8806978f-7d3a-484c-a711-e3e1345c5635', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 12, 0);
INSERT INTO order_details VALUES ('8806978f-7d3a-484c-a711-e3e1345c5635', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 10, 0);
INSERT INTO order_details VALUES ('8806978f-7d3a-484c-a711-e3e1345c5635', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 25, 0);
INSERT INTO order_details VALUES ('2bb6e532-f2ee-430d-8b87-d357d8eb82fd', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 3, 0);
INSERT INTO order_details VALUES ('ac83f515-d40a-4413-b9c9-b013d7f80d2e', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 18, 0.100000001);
INSERT INTO order_details VALUES ('ac83f515-d40a-4413-b9c9-b013d7f80d2e', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 14, 0.100000001);
INSERT INTO order_details VALUES ('b13ae47f-abd2-4f0e-aaf6-aed7b4251bab', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 15, 0.150000006);
INSERT INTO order_details VALUES ('b13ae47f-abd2-4f0e-aaf6-aed7b4251bab', 'd81d4aa0-e0af-41eb-9ba1-42e8ee9559ef', 12.75, 15, 0.150000006);
INSERT INTO order_details VALUES ('c25c5441-f323-409d-a265-84cf0bdeca30', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 10, 0);
INSERT INTO order_details VALUES ('c25c5441-f323-409d-a265-84cf0bdeca30', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 10, 0);
INSERT INTO order_details VALUES ('e1079084-7a83-492f-a528-19bde4b52e12', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 3, 0);
INSERT INTO order_details VALUES ('4d7bb73f-0dda-4ee9-b2b7-4891284d3041', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 36, 0);
INSERT INTO order_details VALUES ('4d7bb73f-0dda-4ee9-b2b7-4891284d3041', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 36, 0.100000001);
INSERT INTO order_details VALUES ('42152ad0-121d-4b23-a110-8cff8cb4c35c', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 50, 0.150000006);
INSERT INTO order_details VALUES ('42152ad0-121d-4b23-a110-8cff8cb4c35c', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 50, 0.150000006);
INSERT INTO order_details VALUES ('42152ad0-121d-4b23-a110-8cff8cb4c35c', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 10, 0.150000006);
INSERT INTO order_details VALUES ('3aed2697-2c6c-4a91-b97a-3432c5e6cc01', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 10, 0.150000006);
INSERT INTO order_details VALUES ('3aed2697-2c6c-4a91-b97a-3432c5e6cc01', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 9, 0.150000006);
INSERT INTO order_details VALUES ('3aed2697-2c6c-4a91-b97a-3432c5e6cc01', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 6, 0.150000006);
INSERT INTO order_details VALUES ('3aed2697-2c6c-4a91-b97a-3432c5e6cc01', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 12, 0.150000006);
INSERT INTO order_details VALUES ('37e579b6-7211-48ba-9100-70adff750d93', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 40, 0.200000003);
INSERT INTO order_details VALUES ('37e579b6-7211-48ba-9100-70adff750d93', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 50, 0.200000003);
INSERT INTO order_details VALUES ('37e579b6-7211-48ba-9100-70adff750d93', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 15, 0.200000003);
INSERT INTO order_details VALUES ('1942ffb4-08c6-4926-b7c5-c314dde3426c', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 39, 0);
INSERT INTO order_details VALUES ('1942ffb4-08c6-4926-b7c5-c314dde3426c', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 35, 0);
INSERT INTO order_details VALUES ('1942ffb4-08c6-4926-b7c5-c314dde3426c', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 70, 0);
INSERT INTO order_details VALUES ('1942ffb4-08c6-4926-b7c5-c314dde3426c', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 39, 0);
INSERT INTO order_details VALUES ('1942ffb4-08c6-4926-b7c5-c314dde3426c', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 50, 0);
INSERT INTO order_details VALUES ('9bc9027a-dd7f-42d5-85c6-9ea01e69b2eb', 'af59c8a6-47cb-48a5-888b-b4f1f195656e', 97, 16, 0.150000006);
INSERT INTO order_details VALUES ('9bc9027a-dd7f-42d5-85c6-9ea01e69b2eb', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 50, 0);
INSERT INTO order_details VALUES ('9bc9027a-dd7f-42d5-85c6-9ea01e69b2eb', '53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 43.9000015, 120, 0);
INSERT INTO order_details VALUES ('9bc9027a-dd7f-42d5-85c6-9ea01e69b2eb', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 16, 0.150000006);
INSERT INTO order_details VALUES ('9bc9027a-dd7f-42d5-85c6-9ea01e69b2eb', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 84, 0.150000006);
INSERT INTO order_details VALUES ('88e49637-1c69-43f8-bfba-3b67c2cb17f8', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 25, 0.100000001);
INSERT INTO order_details VALUES ('88e49637-1c69-43f8-bfba-3b67c2cb17f8', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 80, 0.100000001);
INSERT INTO order_details VALUES ('88e49637-1c69-43f8-bfba-3b67c2cb17f8', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 20, 0);
INSERT INTO order_details VALUES ('66c908d0-6ab0-40ca-8567-ab250f9b88bb', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 6, 0);
INSERT INTO order_details VALUES ('66c908d0-6ab0-40ca-8567-ab250f9b88bb', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 4, 0);
INSERT INTO order_details VALUES ('66c908d0-6ab0-40ca-8567-ab250f9b88bb', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 6, 0);
INSERT INTO order_details VALUES ('d57d66ca-d239-4b07-8951-14ac5a4c0bb7', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 5, 0);
INSERT INTO order_details VALUES ('d57d66ca-d239-4b07-8951-14ac5a4c0bb7', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 15, 0);
INSERT INTO order_details VALUES ('d57d66ca-d239-4b07-8951-14ac5a4c0bb7', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 9, 0);
INSERT INTO order_details VALUES ('a85fb290-8b30-463b-a043-68a9b16e1e41', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 16, 0.0500000007);
INSERT INTO order_details VALUES ('a85fb290-8b30-463b-a043-68a9b16e1e41', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 40, 0);
INSERT INTO order_details VALUES ('a85fb290-8b30-463b-a043-68a9b16e1e41', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 10, 0.0500000007);
INSERT INTO order_details VALUES ('cd7e2bf6-1ff1-46f4-b314-3f9571b64cf4', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 8, 0);
INSERT INTO order_details VALUES ('cd7e2bf6-1ff1-46f4-b314-3f9571b64cf4', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 5, 0);
INSERT INTO order_details VALUES ('8a17e346-20c7-474f-bc7e-aa36e93b0272', '61f41763-1ece-4378-810f-0a866a077be5', 18, 3, 0);
INSERT INTO order_details VALUES ('8a17e346-20c7-474f-bc7e-aa36e93b0272', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 10, 0);
INSERT INTO order_details VALUES ('8a17e346-20c7-474f-bc7e-aa36e93b0272', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 6, 0);
INSERT INTO order_details VALUES ('38270f94-e61d-4c77-b4a5-b256064eb07e', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 40, 0.200000003);
INSERT INTO order_details VALUES ('38270f94-e61d-4c77-b4a5-b256064eb07e', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 24, 0);
INSERT INTO order_details VALUES ('38270f94-e61d-4c77-b4a5-b256064eb07e', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 20, 0.200000003);
INSERT INTO order_details VALUES ('38270f94-e61d-4c77-b4a5-b256064eb07e', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 25, 0.200000003);
INSERT INTO order_details VALUES ('1df2f0e8-bd11-420e-b2e9-d24ac867af6a', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 25, 0.100000001);
INSERT INTO order_details VALUES ('1df2f0e8-bd11-420e-b2e9-d24ac867af6a', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 15, 0.100000001);
INSERT INTO order_details VALUES ('1df2f0e8-bd11-420e-b2e9-d24ac867af6a', '8ad0f836-43df-42d9-a992-e1fee45d28d8', 26, 18, 0.100000001);
INSERT INTO order_details VALUES ('1df2f0e8-bd11-420e-b2e9-d24ac867af6a', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 6, 0.100000001);
INSERT INTO order_details VALUES ('ad0ceb18-93bc-468c-a4db-7c0bf7d48f47', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 2, 0);
INSERT INTO order_details VALUES ('ad0ceb18-93bc-468c-a4db-7c0bf7d48f47', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 10, 0);
INSERT INTO order_details VALUES ('ad0ceb18-93bc-468c-a4db-7c0bf7d48f47', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 60, 0);
INSERT INTO order_details VALUES ('ad0ceb18-93bc-468c-a4db-7c0bf7d48f47', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 15, 0);
INSERT INTO order_details VALUES ('0c283b77-160c-4a6f-87fa-d9bd494b358e', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 30, 0);
INSERT INTO order_details VALUES ('0c283b77-160c-4a6f-87fa-d9bd494b358e', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 15, 0.100000001);
INSERT INTO order_details VALUES ('73fdf0e7-1ccb-4143-98c0-40bd408b7bab', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 8, 0.150000006);
INSERT INTO order_details VALUES ('73fdf0e7-1ccb-4143-98c0-40bd408b7bab', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 10, 0);
INSERT INTO order_details VALUES ('73fdf0e7-1ccb-4143-98c0-40bd408b7bab', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 30, 0.150000006);
INSERT INTO order_details VALUES ('470a20ff-2c0a-4403-b7ad-6621cd55110b', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 50, 0.100000001);
INSERT INTO order_details VALUES ('470a20ff-2c0a-4403-b7ad-6621cd55110b', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 30, 0.100000001);
INSERT INTO order_details VALUES ('e6199921-15f5-46a1-b2b4-fcef72f0cf21', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 3, 0);
INSERT INTO order_details VALUES ('e6199921-15f5-46a1-b2b4-fcef72f0cf21', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 8, 0.200000003);
INSERT INTO order_details VALUES ('e6199921-15f5-46a1-b2b4-fcef72f0cf21', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 9, 0);
INSERT INTO order_details VALUES ('4c85a257-a8dd-4977-a9a6-b0dc8ddcacca', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 14, 0);
INSERT INTO order_details VALUES ('4c85a257-a8dd-4977-a9a6-b0dc8ddcacca', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 20, 0);
INSERT INTO order_details VALUES ('4c85a257-a8dd-4977-a9a6-b0dc8ddcacca', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 10, 0);
INSERT INTO order_details VALUES ('a8d98fde-30b5-48aa-b2e3-c371f916a0c2', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 40, 0);
INSERT INTO order_details VALUES ('a8d98fde-30b5-48aa-b2e3-c371f916a0c2', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 25, 0);
INSERT INTO order_details VALUES ('a8d98fde-30b5-48aa-b2e3-c371f916a0c2', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 20, 0);
INSERT INTO order_details VALUES ('a8d98fde-30b5-48aa-b2e3-c371f916a0c2', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 50, 0);
INSERT INTO order_details VALUES ('af68dd9a-01de-4c9d-8484-7f5122d3aef0', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 2, 0);
INSERT INTO order_details VALUES ('2abc0766-7993-48a2-aa81-111a6dfdac8a', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 15, 0);
INSERT INTO order_details VALUES ('2abc0766-7993-48a2-aa81-111a6dfdac8a', '309dcfa3-7eea-4a14-9795-f8693838c3bd', 17, 24, 0);
INSERT INTO order_details VALUES ('967cc3d8-d56d-472f-9370-e52e46fdf638', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 50, 0.0500000007);
INSERT INTO order_details VALUES ('967cc3d8-d56d-472f-9370-e52e46fdf638', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 24, 0);
INSERT INTO order_details VALUES ('967cc3d8-d56d-472f-9370-e52e46fdf638', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 24, 0.0500000007);
INSERT INTO order_details VALUES ('d9796b2c-dec4-4d1f-95d2-e64aadd2794f', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 10, 0);
INSERT INTO order_details VALUES ('d9796b2c-dec4-4d1f-95d2-e64aadd2794f', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 10, 0.200000003);
INSERT INTO order_details VALUES ('d9796b2c-dec4-4d1f-95d2-e64aadd2794f', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 10, 0.200000003);
INSERT INTO order_details VALUES ('a8620bab-4867-4f30-ba30-a3bc3a317c5c', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 50, 0.100000001);
INSERT INTO order_details VALUES ('a8620bab-4867-4f30-ba30-a3bc3a317c5c', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 10, 0.100000001);
INSERT INTO order_details VALUES ('a8620bab-4867-4f30-ba30-a3bc3a317c5c', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 5, 0.100000001);
INSERT INTO order_details VALUES ('a8620bab-4867-4f30-ba30-a3bc3a317c5c', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 15, 0.100000001);
INSERT INTO order_details VALUES ('9d278f16-3771-42e1-977a-cc2f3d25ce12', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 15, 0.25);
INSERT INTO order_details VALUES ('9d278f16-3771-42e1-977a-cc2f3d25ce12', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 20, 0);
INSERT INTO order_details VALUES ('9d278f16-3771-42e1-977a-cc2f3d25ce12', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 30, 0);
INSERT INTO order_details VALUES ('9d278f16-3771-42e1-977a-cc2f3d25ce12', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 35, 0.25);
INSERT INTO order_details VALUES ('128bb5fd-d508-4f99-bfad-72a1da5f7321', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 30, 0);
INSERT INTO order_details VALUES ('128bb5fd-d508-4f99-bfad-72a1da5f7321', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 6, 0);
INSERT INTO order_details VALUES ('128bb5fd-d508-4f99-bfad-72a1da5f7321', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 20, 0);
INSERT INTO order_details VALUES ('128bb5fd-d508-4f99-bfad-72a1da5f7321', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 21, 0);
INSERT INTO order_details VALUES ('128bb5fd-d508-4f99-bfad-72a1da5f7321', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 9, 0);
INSERT INTO order_details VALUES ('2f392c65-f42b-4a5a-a8a2-5f20e4280a73', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 7, 0);
INSERT INTO order_details VALUES ('2f392c65-f42b-4a5a-a8a2-5f20e4280a73', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 1, 0);
INSERT INTO order_details VALUES ('43e970e0-f6de-4d15-9c69-6e4b9694fea7', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 8, 0);
INSERT INTO order_details VALUES ('43e970e0-f6de-4d15-9c69-6e4b9694fea7', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 15, 0);
INSERT INTO order_details VALUES ('43e970e0-f6de-4d15-9c69-6e4b9694fea7', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 15, 0);
INSERT INTO order_details VALUES ('43e970e0-f6de-4d15-9c69-6e4b9694fea7', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 6, 0);
INSERT INTO order_details VALUES ('f79bce2e-cd18-478b-a56d-f8b11d1dbf24', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 10, 60, 0);
INSERT INTO order_details VALUES ('f79bce2e-cd18-478b-a56d-f8b11d1dbf24', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 40, 0);
INSERT INTO order_details VALUES ('f79bce2e-cd18-478b-a56d-f8b11d1dbf24', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 30, 0);
INSERT INTO order_details VALUES ('f79bce2e-cd18-478b-a56d-f8b11d1dbf24', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 35, 0);
INSERT INTO order_details VALUES ('177fd68f-48d9-41db-8656-44967bd9fd13', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 35, 0.100000001);
INSERT INTO order_details VALUES ('177fd68f-48d9-41db-8656-44967bd9fd13', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 4, 0.100000001);
INSERT INTO order_details VALUES ('177fd68f-48d9-41db-8656-44967bd9fd13', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 36, 0.100000001);
INSERT INTO order_details VALUES ('177fd68f-48d9-41db-8656-44967bd9fd13', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 9, 0.100000001);
INSERT INTO order_details VALUES ('a0d77b29-b4da-4502-899a-93e0e1a6d9a5', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 15, 0.0500000007);
INSERT INTO order_details VALUES ('a0d77b29-b4da-4502-899a-93e0e1a6d9a5', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 24, 0.0500000007);
INSERT INTO order_details VALUES ('af253df8-dca6-45a8-892c-0560d5512433', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 30, 0.150000006);
INSERT INTO order_details VALUES ('af253df8-dca6-45a8-892c-0560d5512433', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 70, 0.150000006);
INSERT INTO order_details VALUES ('ec68c5f1-9ed6-433b-a1b1-1aa5839df3bd', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 7, 0);
INSERT INTO order_details VALUES ('ec68c5f1-9ed6-433b-a1b1-1aa5839df3bd', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 14, 7, 0);
INSERT INTO order_details VALUES ('d8c2cc27-13fe-4ae4-a2bd-1904110535de', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 10, 0);
INSERT INTO order_details VALUES ('fe4802b1-89ba-4385-9919-beee9bbf80ee', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 10, 0);
INSERT INTO order_details VALUES ('fe4802b1-89ba-4385-9919-beee9bbf80ee', '61f41763-1ece-4378-810f-0a866a077be5', 18, 30, 0);
INSERT INTO order_details VALUES ('fe4802b1-89ba-4385-9919-beee9bbf80ee', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 40, 0);
INSERT INTO order_details VALUES ('8068af5f-c1fd-4454-a34a-6f995394b60c', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 24, 0.150000006);
INSERT INTO order_details VALUES ('8068af5f-c1fd-4454-a34a-6f995394b60c', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 60, 0);
INSERT INTO order_details VALUES ('0831404d-5863-4290-82d4-1611971cc0bd', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 10, 0.25);
INSERT INTO order_details VALUES ('0831404d-5863-4290-82d4-1611971cc0bd', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 14, 0);
INSERT INTO order_details VALUES ('59b259f5-1436-4fae-9e66-addabb07adba', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 55, 0.150000006);
INSERT INTO order_details VALUES ('59b259f5-1436-4fae-9e66-addabb07adba', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 100, 0.150000006);
INSERT INTO order_details VALUES ('59b259f5-1436-4fae-9e66-addabb07adba', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 48, 0.150000006);
INSERT INTO order_details VALUES ('fd236be8-b4f3-4dd6-8fb2-56d4032020d0', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 8, 0.100000001);
INSERT INTO order_details VALUES ('fd236be8-b4f3-4dd6-8fb2-56d4032020d0', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 10, 0);
INSERT INTO order_details VALUES ('fd236be8-b4f3-4dd6-8fb2-56d4032020d0', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 6, 0.100000001);
INSERT INTO order_details VALUES ('fd236be8-b4f3-4dd6-8fb2-56d4032020d0', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 10, 0.100000001);
INSERT INTO order_details VALUES ('aac71447-ff91-4aaf-a953-c16c9c131d16', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 40, 0.150000006);
INSERT INTO order_details VALUES ('aac71447-ff91-4aaf-a953-c16c9c131d16', '61f41763-1ece-4378-810f-0a866a077be5', 18, 20, 0.150000006);
INSERT INTO order_details VALUES ('aac71447-ff91-4aaf-a953-c16c9c131d16', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 40, 0);
INSERT INTO order_details VALUES ('d34b36c7-4d52-4cba-9afc-90be79aeec55', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 18, 0);
INSERT INTO order_details VALUES ('d34b36c7-4d52-4cba-9afc-90be79aeec55', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 30, 0);
INSERT INTO order_details VALUES ('7b456c48-9ea3-4161-a946-bbf7347f7371', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 15, 0);
INSERT INTO order_details VALUES ('7b456c48-9ea3-4161-a946-bbf7347f7371', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 14, 0);
INSERT INTO order_details VALUES ('7b456c48-9ea3-4161-a946-bbf7347f7371', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 24, 0);
INSERT INTO order_details VALUES ('7b456c48-9ea3-4161-a946-bbf7347f7371', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 30, 0);
INSERT INTO order_details VALUES ('7b456c48-9ea3-4161-a946-bbf7347f7371', '61f41763-1ece-4378-810f-0a866a077be5', 18, 6, 0);
INSERT INTO order_details VALUES ('308505a8-fab7-461e-bb8b-83ccbcb8716e', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 30, 0.0500000007);
INSERT INTO order_details VALUES ('308505a8-fab7-461e-bb8b-83ccbcb8716e', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 20, 0.0500000007);
INSERT INTO order_details VALUES ('308505a8-fab7-461e-bb8b-83ccbcb8716e', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 20, 0.0500000007);
INSERT INTO order_details VALUES ('308505a8-fab7-461e-bb8b-83ccbcb8716e', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 10, 0.0500000007);
INSERT INTO order_details VALUES ('31d561ae-e012-4d83-989b-beda68f95656', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 30, 0.200000003);
INSERT INTO order_details VALUES ('31d561ae-e012-4d83-989b-beda68f95656', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 35, 0.200000003);
INSERT INTO order_details VALUES ('31d561ae-e012-4d83-989b-beda68f95656', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 18, 0.200000003);
INSERT INTO order_details VALUES ('31d561ae-e012-4d83-989b-beda68f95656', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 20, 0.200000003);
INSERT INTO order_details VALUES ('31d561ae-e012-4d83-989b-beda68f95656', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 40, 0.200000003);
INSERT INTO order_details VALUES ('eb34e8b4-7017-4158-9c1e-c3ed660539f5', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 24, 0);
INSERT INTO order_details VALUES ('d9572a1d-dbe5-4341-811f-3fe30e06c26f', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 30, 0);
INSERT INTO order_details VALUES ('d9572a1d-dbe5-4341-811f-3fe30e06c26f', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 20, 0);
INSERT INTO order_details VALUES ('3e8e7621-b056-4ab2-bc50-ddcf34b08622', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 25, 0);
INSERT INTO order_details VALUES ('3e8e7621-b056-4ab2-bc50-ddcf34b08622', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 20, 0);
INSERT INTO order_details VALUES ('3e8e7621-b056-4ab2-bc50-ddcf34b08622', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 30, 0);
INSERT INTO order_details VALUES ('3e8e7621-b056-4ab2-bc50-ddcf34b08622', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 18, 0);
INSERT INTO order_details VALUES ('3e8e7621-b056-4ab2-bc50-ddcf34b08622', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 3, 0);
INSERT INTO order_details VALUES ('b9861dda-1001-4c94-8ad0-3a6d246458e7', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 12, 0.0500000007);
INSERT INTO order_details VALUES ('b9861dda-1001-4c94-8ad0-3a6d246458e7', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 18, 0.0500000007);
INSERT INTO order_details VALUES ('31af289e-d67c-4524-8820-2cb6f7cc1410', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 20, 0);
INSERT INTO order_details VALUES ('31af289e-d67c-4524-8820-2cb6f7cc1410', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 15, 0.25);
INSERT INTO order_details VALUES ('08cd824b-51d1-4aad-837c-5e80fde7ad2c', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 10, 0);
INSERT INTO order_details VALUES ('08cd824b-51d1-4aad-837c-5e80fde7ad2c', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 50, 0);
INSERT INTO order_details VALUES ('dc79a939-51d1-428f-a71d-f249faba6938', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 20, 0.100000001);
INSERT INTO order_details VALUES ('dc79a939-51d1-428f-a71d-f249faba6938', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 10, 0.100000001);
INSERT INTO order_details VALUES ('2c3a96a2-3f5a-49fd-a9ea-b0f015e96fed', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 25, 0);
INSERT INTO order_details VALUES ('2c3a96a2-3f5a-49fd-a9ea-b0f015e96fed', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 70, 0);
INSERT INTO order_details VALUES ('63e2f858-37c7-46a2-b56e-ba1db1747887', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 16, 0.0500000007);
INSERT INTO order_details VALUES ('63e2f858-37c7-46a2-b56e-ba1db1747887', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 6, 0.0500000007);
INSERT INTO order_details VALUES ('63e2f858-37c7-46a2-b56e-ba1db1747887', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 25, 0.0500000007);
INSERT INTO order_details VALUES ('91f040eb-c107-4cf0-8fb6-02fa180dc929', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 25, 0.100000001);
INSERT INTO order_details VALUES ('91f040eb-c107-4cf0-8fb6-02fa180dc929', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 18, 0.100000001);
INSERT INTO order_details VALUES ('828ff826-8334-4ef1-bffb-984dbd35a983', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 35, 0.150000006);
INSERT INTO order_details VALUES ('828ff826-8334-4ef1-bffb-984dbd35a983', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 18, 0.150000006);
INSERT INTO order_details VALUES ('828ff826-8334-4ef1-bffb-984dbd35a983', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 10, 0);
INSERT INTO order_details VALUES ('85784905-2b17-454f-8c17-ea6a26ff601e', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 60, 0.200000003);
INSERT INTO order_details VALUES ('85784905-2b17-454f-8c17-ea6a26ff601e', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 3, 0);
INSERT INTO order_details VALUES ('85784905-2b17-454f-8c17-ea6a26ff601e', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 40, 0.200000003);
INSERT INTO order_details VALUES ('c8320389-4ef1-43cb-ad5b-f73c9997e7ff', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 5, 0);
INSERT INTO order_details VALUES ('b18f3620-37f7-41ae-b232-d22f5d6d06a4', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 35, 0.200000003);
INSERT INTO order_details VALUES ('b18f3620-37f7-41ae-b232-d22f5d6d06a4', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 30, 0);
INSERT INTO order_details VALUES ('d855fdb9-07a3-497d-a7ce-e0e059609020', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 15, 0.0500000007);
INSERT INTO order_details VALUES ('d855fdb9-07a3-497d-a7ce-e0e059609020', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 60, 0.0500000007);
INSERT INTO order_details VALUES ('6e25f8d7-b0d9-4ca7-975f-5f1863248c48', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 11, 0.150000006);
INSERT INTO order_details VALUES ('6e25f8d7-b0d9-4ca7-975f-5f1863248c48', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 28, 0.150000006);
INSERT INTO order_details VALUES ('1c0d14f9-1493-4557-a8c9-1a0d7ebc0787', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 12, 0.100000001);
INSERT INTO order_details VALUES ('1c0d14f9-1493-4557-a8c9-1a0d7ebc0787', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 10, 0.100000001);
INSERT INTO order_details VALUES ('1c0d14f9-1493-4557-a8c9-1a0d7ebc0787', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 50, 0);
INSERT INTO order_details VALUES ('1c0d14f9-1493-4557-a8c9-1a0d7ebc0787', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 15, 0.100000001);
INSERT INTO order_details VALUES ('8a4df845-de14-4402-800f-11247471056b', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 18, 0);
INSERT INTO order_details VALUES ('8a4df845-de14-4402-800f-11247471056b', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 40, 0);
INSERT INTO order_details VALUES ('8a4df845-de14-4402-800f-11247471056b', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 25, 0);
INSERT INTO order_details VALUES ('584be20a-d89c-4f19-bf2b-e11f97861917', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 14, 0);
INSERT INTO order_details VALUES ('584be20a-d89c-4f19-bf2b-e11f97861917', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 2, 0);
INSERT INTO order_details VALUES ('584be20a-d89c-4f19-bf2b-e11f97861917', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 10, 0);
INSERT INTO order_details VALUES ('584be20a-d89c-4f19-bf2b-e11f97861917', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 6, 0);
INSERT INTO order_details VALUES ('e6abd166-aa4b-4d88-abaf-d0dc13b9171f', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 12, 0);
INSERT INTO order_details VALUES ('e6abd166-aa4b-4d88-abaf-d0dc13b9171f', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 6, 0);
INSERT INTO order_details VALUES ('e6abd166-aa4b-4d88-abaf-d0dc13b9171f', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 30, 0);
INSERT INTO order_details VALUES ('e6abd166-aa4b-4d88-abaf-d0dc13b9171f', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 10, 0);
INSERT INTO order_details VALUES ('e650dd0b-12e6-42a3-ab80-a13397f4d559', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 10, 0);
INSERT INTO order_details VALUES ('e650dd0b-12e6-42a3-ab80-a13397f4d559', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 20, 0);
INSERT INTO order_details VALUES ('e650dd0b-12e6-42a3-ab80-a13397f4d559', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 21, 0);
INSERT INTO order_details VALUES ('a7b64d14-d4b8-47c5-973a-449ae30d114c', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 10, 0);
INSERT INTO order_details VALUES ('a7b64d14-d4b8-47c5-973a-449ae30d114c', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 20, 0);
INSERT INTO order_details VALUES ('a7b64d14-d4b8-47c5-973a-449ae30d114c', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 18, 0);
INSERT INTO order_details VALUES ('92ac8fa8-66a7-498b-a9fe-0f81fcd43833', '61f41763-1ece-4378-810f-0a866a077be5', 18, 20, 0);
INSERT INTO order_details VALUES ('92ac8fa8-66a7-498b-a9fe-0f81fcd43833', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 6, 0);
INSERT INTO order_details VALUES ('83656ad5-d398-4aaf-9238-b1aaba4f03d2', '0684ad85-cbf4-4340-b11e-e3c9caf11ee1', 15.5, 10, 0);
INSERT INTO order_details VALUES ('83656ad5-d398-4aaf-9238-b1aaba4f03d2', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 21, 0);
INSERT INTO order_details VALUES ('87bb7966-533f-4799-9c29-943ffba782a9', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 15, 0.0500000007);
INSERT INTO order_details VALUES ('87bb7966-533f-4799-9c29-943ffba782a9', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 9, 0.0500000007);
INSERT INTO order_details VALUES ('87bb7966-533f-4799-9c29-943ffba782a9', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 30, 0.0500000007);
INSERT INTO order_details VALUES ('76263615-543c-4c51-9022-ec97ad54b362', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 50, 0.200000003);
INSERT INTO order_details VALUES ('324840bf-8c10-4060-b578-cc72be5c1c76', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 4, 0);
INSERT INTO order_details VALUES ('324840bf-8c10-4060-b578-cc72be5c1c76', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 14, 0);
INSERT INTO order_details VALUES ('bd5aa245-7db9-40fc-a00e-1ed80aeab821', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 10, 0);
INSERT INTO order_details VALUES ('bd5aa245-7db9-40fc-a00e-1ed80aeab821', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 24, 0.150000006);
INSERT INTO order_details VALUES ('bd5aa245-7db9-40fc-a00e-1ed80aeab821', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 10, 0.150000006);
INSERT INTO order_details VALUES ('ad33c4d1-7e4d-42d5-b7da-7b349d6cc18d', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 50, 0.0500000007);
INSERT INTO order_details VALUES ('ea66473f-5962-4c7a-bbcf-86256717eb10', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 15, 0);
INSERT INTO order_details VALUES ('3e28f8cb-6c54-41fa-a731-e0daf247ec51', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 4, 0.150000006);
INSERT INTO order_details VALUES ('5f0e4412-7430-48c1-b726-ad812e690be3', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 6, 0);
INSERT INTO order_details VALUES ('5f0e4412-7430-48c1-b726-ad812e690be3', '61f41763-1ece-4378-810f-0a866a077be5', 18, 20, 0);
INSERT INTO order_details VALUES ('5f0e4412-7430-48c1-b726-ad812e690be3', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 20, 0);
INSERT INTO order_details VALUES ('b951d52f-db3a-4cd4-8777-50cc9f664177', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 40, 0.200000003);
INSERT INTO order_details VALUES ('b951d52f-db3a-4cd4-8777-50cc9f664177', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 100, 0.200000003);
INSERT INTO order_details VALUES ('de8c672e-786e-4dc3-b7cb-4fb2c33ee7c3', '61f41763-1ece-4378-810f-0a866a077be5', 18, 4, 0);
INSERT INTO order_details VALUES ('6fd21927-4149-4582-a436-0938b079ef19', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 20, 0);
INSERT INTO order_details VALUES ('6fd21927-4149-4582-a436-0938b079ef19', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 60, 0.0500000007);
INSERT INTO order_details VALUES ('f99216ea-b34a-4b01-9b2d-f591a68184a6', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 10, 14, 0);
INSERT INTO order_details VALUES ('f99216ea-b34a-4b01-9b2d-f591a68184a6', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 10, 0);
INSERT INTO order_details VALUES ('f99216ea-b34a-4b01-9b2d-f591a68184a6', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 50, 0);
INSERT INTO order_details VALUES ('860ac2f8-a4ef-4e56-b323-ba75564de9d7', '0684ad85-cbf4-4340-b11e-e3c9caf11ee1', 15.5, 25, 0.0500000007);
INSERT INTO order_details VALUES ('860ac2f8-a4ef-4e56-b323-ba75564de9d7', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 5, 0.0500000007);
INSERT INTO order_details VALUES ('6c275f6d-808e-4918-a692-63b7f6c75a5d', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 21, 0.200000003);
INSERT INTO order_details VALUES ('6c275f6d-808e-4918-a692-63b7f6c75a5d', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 20, 0.200000003);
INSERT INTO order_details VALUES ('6c275f6d-808e-4918-a692-63b7f6c75a5d', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 4, 0.200000003);
INSERT INTO order_details VALUES ('f478be96-6ad5-4ba3-a3b4-0621bd668e6a', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 24, 0);
INSERT INTO order_details VALUES ('f478be96-6ad5-4ba3-a3b4-0621bd668e6a', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 30, 0);
INSERT INTO order_details VALUES ('3dba3d93-d5d2-410f-800e-28adc35b2c99', '61f41763-1ece-4378-810f-0a866a077be5', 18, 30, 0.25);
INSERT INTO order_details VALUES ('3dba3d93-d5d2-410f-800e-28adc35b2c99', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 120, 0.25);
INSERT INTO order_details VALUES ('3dba3d93-d5d2-410f-800e-28adc35b2c99', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 65, 0.25);
INSERT INTO order_details VALUES ('b1a973b6-7832-488d-9167-f0087af01c79', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 5, 0.200000003);
INSERT INTO order_details VALUES ('b1a973b6-7832-488d-9167-f0087af01c79', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 24, 0.200000003);
INSERT INTO order_details VALUES ('b1a973b6-7832-488d-9167-f0087af01c79', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 30, 0.200000003);
INSERT INTO order_details VALUES ('f8855cfb-42ae-4e95-9b84-2d9c773b3ef4', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 35, 0.200000003);
INSERT INTO order_details VALUES ('f8855cfb-42ae-4e95-9b84-2d9c773b3ef4', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 20, 0);
INSERT INTO order_details VALUES ('f8855cfb-42ae-4e95-9b84-2d9c773b3ef4', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 12, 0.200000003);
INSERT INTO order_details VALUES ('99df4f1f-515a-4ea9-92b8-7b21d923be32', '53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 43.9000015, 50, 0);
INSERT INTO order_details VALUES ('99df4f1f-515a-4ea9-92b8-7b21d923be32', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 9, 0);
INSERT INTO order_details VALUES ('563ba2d1-617a-4eed-88ee-bf30e2892737', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 10, 0);
INSERT INTO order_details VALUES ('4603d4c3-7b71-4a1d-8567-b2e8001bcd88', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 4, 0);
INSERT INTO order_details VALUES ('4603d4c3-7b71-4a1d-8567-b2e8001bcd88', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 30, 0);
INSERT INTO order_details VALUES ('edaa92d2-8f07-4637-9ed3-3168ca2584f3', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 60, 0);
INSERT INTO order_details VALUES ('edaa92d2-8f07-4637-9ed3-3168ca2584f3', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 35, 0);
INSERT INTO order_details VALUES ('67efbad1-591b-4988-ab28-89b75263a433', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 5, 0.25);
INSERT INTO order_details VALUES ('27ba5c56-5716-4e9a-b446-f82f4272d215', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 48, 0);
INSERT INTO order_details VALUES ('27ba5c56-5716-4e9a-b446-f82f4272d215', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 25, 0.0500000007);
INSERT INTO order_details VALUES ('fa5fdec2-1fe8-4e98-a5a3-38414de23ba3', 'd81d4aa0-e0af-41eb-9ba1-42e8ee9559ef', 12.75, 6, 0.100000001);
INSERT INTO order_details VALUES ('fa5fdec2-1fe8-4e98-a5a3-38414de23ba3', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 10, 0.100000001);
INSERT INTO order_details VALUES ('d09ef434-ef5d-4c67-a6b4-4df5369a26db', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 30, 0.0500000007);
INSERT INTO order_details VALUES ('d09ef434-ef5d-4c67-a6b4-4df5369a26db', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 20, 0.0500000007);
INSERT INTO order_details VALUES ('d09ef434-ef5d-4c67-a6b4-4df5369a26db', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 70, 0.0500000007);
INSERT INTO order_details VALUES ('d09ef434-ef5d-4c67-a6b4-4df5369a26db', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 15, 0.0500000007);
INSERT INTO order_details VALUES ('de15dd54-f7ef-4f9b-b93a-610549fcb76a', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 20, 0.200000003);
INSERT INTO order_details VALUES ('de15dd54-f7ef-4f9b-b93a-610549fcb76a', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 20, 0.200000003);
INSERT INTO order_details VALUES ('de15dd54-f7ef-4f9b-b93a-610549fcb76a', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 10, 0.200000003);
INSERT INTO order_details VALUES ('2515492a-6c4c-4486-94ce-a8a96f60dc0a', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 45, 0);
INSERT INTO order_details VALUES ('2515492a-6c4c-4486-94ce-a8a96f60dc0a', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 100, 0);
INSERT INTO order_details VALUES ('2515492a-6c4c-4486-94ce-a8a96f60dc0a', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 14, 0);
INSERT INTO order_details VALUES ('2515492a-6c4c-4486-94ce-a8a96f60dc0a', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 42, 0);
INSERT INTO order_details VALUES ('2515492a-6c4c-4486-94ce-a8a96f60dc0a', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 12, 0);
INSERT INTO order_details VALUES ('b072f792-d2d7-428f-ba98-c20a362e6520', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 28, 0);
INSERT INTO order_details VALUES ('f9bc5fd1-2546-458f-a939-10efed0daf89', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 3, 0);
INSERT INTO order_details VALUES ('f9bc5fd1-2546-458f-a939-10efed0daf89', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 10, 0);
INSERT INTO order_details VALUES ('f9bc5fd1-2546-458f-a939-10efed0daf89', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 6, 0);
INSERT INTO order_details VALUES ('4fa09d91-d7c0-470d-9060-44a7d349cf3e', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 21, 0.25);
INSERT INTO order_details VALUES ('35fb810b-e426-4b93-86f3-bc71cc8ff98c', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 6, 0);
INSERT INTO order_details VALUES ('35fb810b-e426-4b93-86f3-bc71cc8ff98c', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 10, 0);
INSERT INTO order_details VALUES ('35fb810b-e426-4b93-86f3-bc71cc8ff98c', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 15, 0);
INSERT INTO order_details VALUES ('acbdca6b-7e3b-460c-aa98-199230ba24b7', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 70, 0);
INSERT INTO order_details VALUES ('acbdca6b-7e3b-460c-aa98-199230ba24b7', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 55, 0);
INSERT INTO order_details VALUES ('acbdca6b-7e3b-460c-aa98-199230ba24b7', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 18, 0);
INSERT INTO order_details VALUES ('acbdca6b-7e3b-460c-aa98-199230ba24b7', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 40, 0);
INSERT INTO order_details VALUES ('acbdca6b-7e3b-460c-aa98-199230ba24b7', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 80, 0);
INSERT INTO order_details VALUES ('892a89bb-5504-40b2-997d-d306fc8c5eff', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 8, 0.100000001);
INSERT INTO order_details VALUES ('892a89bb-5504-40b2-997d-d306fc8c5eff', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 40, 0);
INSERT INTO order_details VALUES ('b05213d6-28d4-4a49-bf6b-2727082a1400', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 14, 0);
INSERT INTO order_details VALUES ('b05213d6-28d4-4a49-bf6b-2727082a1400', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 8, 0);
INSERT INTO order_details VALUES ('b05213d6-28d4-4a49-bf6b-2727082a1400', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 5, 0);
INSERT INTO order_details VALUES ('8c8862ee-add6-4f06-94be-889243d43745', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 5, 0);
INSERT INTO order_details VALUES ('79c5bab5-bbb1-4ff2-8a1e-808e849e012f', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 15, 0.0500000007);
INSERT INTO order_details VALUES ('79c5bab5-bbb1-4ff2-8a1e-808e849e012f', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 14, 0);
INSERT INTO order_details VALUES ('79c5bab5-bbb1-4ff2-8a1e-808e849e012f', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 15, 0.0500000007);
INSERT INTO order_details VALUES ('79c5bab5-bbb1-4ff2-8a1e-808e849e012f', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 15, 0.0500000007);
INSERT INTO order_details VALUES ('0d42ddb9-c50b-4fd4-b654-d3ff5cc584a5', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 30, 0.150000006);
INSERT INTO order_details VALUES ('5601daea-74d1-4bcf-a51b-f44ebf1ee516', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 70, 0);
INSERT INTO order_details VALUES ('5601daea-74d1-4bcf-a51b-f44ebf1ee516', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 20, 0);
INSERT INTO order_details VALUES ('5601daea-74d1-4bcf-a51b-f44ebf1ee516', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 15, 0);
INSERT INTO order_details VALUES ('de2887ea-bfdc-4b91-8938-b3140d348da8', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 42, 0);
INSERT INTO order_details VALUES ('de2887ea-bfdc-4b91-8938-b3140d348da8', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 40, 0);
INSERT INTO order_details VALUES ('1b6441ce-d018-4d80-90c5-f585a102fb97', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 5, 0);
INSERT INTO order_details VALUES ('1b6441ce-d018-4d80-90c5-f585a102fb97', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 5, 0);
INSERT INTO order_details VALUES ('315b5685-0f7c-45f0-85da-db7495a3c689', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 5, 0);
INSERT INTO order_details VALUES ('315b5685-0f7c-45f0-85da-db7495a3c689', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 10, 0);
INSERT INTO order_details VALUES ('315b5685-0f7c-45f0-85da-db7495a3c689', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 20, 0);
INSERT INTO order_details VALUES ('315b5685-0f7c-45f0-85da-db7495a3c689', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 15, 0);
INSERT INTO order_details VALUES ('590e20d8-2e7b-423e-8422-6b76161fff26', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 20, 0);
INSERT INTO order_details VALUES ('590e20d8-2e7b-423e-8422-6b76161fff26', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 18, 0.200000003);
INSERT INTO order_details VALUES ('6f23c8c2-e6a2-446b-abe3-5e8ac72f880a', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 21, 0);
INSERT INTO order_details VALUES ('6f23c8c2-e6a2-446b-abe3-5e8ac72f880a', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 15, 0.100000001);
INSERT INTO order_details VALUES ('6f23c8c2-e6a2-446b-abe3-5e8ac72f880a', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 25, 0.100000001);
INSERT INTO order_details VALUES ('6f23c8c2-e6a2-446b-abe3-5e8ac72f880a', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 3, 0);
INSERT INTO order_details VALUES ('6f23c8c2-e6a2-446b-abe3-5e8ac72f880a', '61f41763-1ece-4378-810f-0a866a077be5', 18, 30, 0.100000001);
INSERT INTO order_details VALUES ('cc6528dc-f8e4-4376-a0d7-1dcd57adc829', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 10, 0);
INSERT INTO order_details VALUES ('cc6528dc-f8e4-4376-a0d7-1dcd57adc829', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 6, 0);
INSERT INTO order_details VALUES ('cc6528dc-f8e4-4376-a0d7-1dcd57adc829', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 10, 0);
INSERT INTO order_details VALUES ('287ada86-617f-4a93-98e8-ea42f700802d', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 3, 0);
INSERT INTO order_details VALUES ('287ada86-617f-4a93-98e8-ea42f700802d', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 5, 0);
INSERT INTO order_details VALUES ('287ada86-617f-4a93-98e8-ea42f700802d', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 10, 0);
INSERT INTO order_details VALUES ('692d7f53-21d5-4183-be92-c896b1f04b08', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 12, 0);
INSERT INTO order_details VALUES ('692d7f53-21d5-4183-be92-c896b1f04b08', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 20, 0);
INSERT INTO order_details VALUES ('692d7f53-21d5-4183-be92-c896b1f04b08', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 20, 0);
INSERT INTO order_details VALUES ('4e74c510-55c5-47d0-b53a-3b80c9d25f9f', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 15, 0);
INSERT INTO order_details VALUES ('4e74c510-55c5-47d0-b53a-3b80c9d25f9f', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 35, 0.150000006);
INSERT INTO order_details VALUES ('0f308589-2354-440d-8c3e-7e9500e0467e', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 25, 0);
INSERT INTO order_details VALUES ('25ec11e6-62ff-4252-a2a6-6c099ddf416c', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 20, 0);
INSERT INTO order_details VALUES ('25ec11e6-62ff-4252-a2a6-6c099ddf416c', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 9, 0);
INSERT INTO order_details VALUES ('5321a601-ab4c-4f52-abc7-4073d94dae56', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 12, 0.0500000007);
INSERT INTO order_details VALUES ('5321a601-ab4c-4f52-abc7-4073d94dae56', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 35, 0);
INSERT INTO order_details VALUES ('12416610-ec6d-4f0c-b7b1-94f238f6773e', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 8, 0.100000001);
INSERT INTO order_details VALUES ('879b8029-2907-483d-be73-5ea6927b4e9c', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 30, 0.0500000007);
INSERT INTO order_details VALUES ('879b8029-2907-483d-be73-5ea6927b4e9c', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 20, 0.0500000007);
INSERT INTO order_details VALUES ('04ccb0b2-221c-4e50-b09c-e5314ee6eb1c', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 36, 0.150000006);
INSERT INTO order_details VALUES ('04ccb0b2-221c-4e50-b09c-e5314ee6eb1c', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 13, 0.150000006);
INSERT INTO order_details VALUES ('04ccb0b2-221c-4e50-b09c-e5314ee6eb1c', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 35, 0.150000006);
INSERT INTO order_details VALUES ('04ccb0b2-221c-4e50-b09c-e5314ee6eb1c', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 80, 0.150000006);
INSERT INTO order_details VALUES ('3e10c4bb-dabd-4e41-9d06-56e6d5f14b88', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 35, 0);
INSERT INTO order_details VALUES ('3e10c4bb-dabd-4e41-9d06-56e6d5f14b88', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 50, 0);
INSERT INTO order_details VALUES ('3e10c4bb-dabd-4e41-9d06-56e6d5f14b88', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 15, 0);
INSERT INTO order_details VALUES ('3e10c4bb-dabd-4e41-9d06-56e6d5f14b88', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 2, 0);
INSERT INTO order_details VALUES ('b21c2cd8-4ccb-4dab-94bf-4f6f9b4c8144', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 10, 0.100000001);
INSERT INTO order_details VALUES ('b21c2cd8-4ccb-4dab-94bf-4f6f9b4c8144', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 21.3500004, 15, 0.100000001);
INSERT INTO order_details VALUES ('b21c2cd8-4ccb-4dab-94bf-4f6f9b4c8144', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 40, 0);
INSERT INTO order_details VALUES ('c2c074d2-31b3-47cb-9798-f23f8873f110', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 25, 0);
INSERT INTO order_details VALUES ('c2c074d2-31b3-47cb-9798-f23f8873f110', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 6, 0);
INSERT INTO order_details VALUES ('c971457f-7614-46df-8c64-226cb71e292e', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 10, 0);
INSERT INTO order_details VALUES ('c971457f-7614-46df-8c64-226cb71e292e', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 16.25, 25, 0.0500000007);
INSERT INTO order_details VALUES ('c971457f-7614-46df-8c64-226cb71e292e', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 60, 0.0500000007);
INSERT INTO order_details VALUES ('a2953c58-3e9e-49d7-ad47-799eeeecc644', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 20, 0);
INSERT INTO order_details VALUES ('a2953c58-3e9e-49d7-ad47-799eeeecc644', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 21, 0);
INSERT INTO order_details VALUES ('a2953c58-3e9e-49d7-ad47-799eeeecc644', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 60, 0);
INSERT INTO order_details VALUES ('a6ac0c93-bce4-4949-b580-7afd2a1697ae', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 8, 0);
INSERT INTO order_details VALUES ('f731d201-db34-4eb8-a464-22f7bfaedefb', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 20, 0.25);
INSERT INTO order_details VALUES ('f731d201-db34-4eb8-a464-22f7bfaedefb', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 15, 0.25);
INSERT INTO order_details VALUES ('76fb5b47-47fe-43c7-925f-9b421e41557f', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 50, 0);
INSERT INTO order_details VALUES ('76fb5b47-47fe-43c7-925f-9b421e41557f', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 60, 0);
INSERT INTO order_details VALUES ('fb209b21-0afc-41c3-8e2b-a1bc3655bec6', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 30, 0.200000003);
INSERT INTO order_details VALUES ('fb209b21-0afc-41c3-8e2b-a1bc3655bec6', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 20, 0.200000003);
INSERT INTO order_details VALUES ('5db39820-bbbb-4218-9d20-09e5d01b1e5c', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 15, 0.25);
INSERT INTO order_details VALUES ('5db39820-bbbb-4218-9d20-09e5d01b1e5c', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 21, 0.25);
INSERT INTO order_details VALUES ('5db39820-bbbb-4218-9d20-09e5d01b1e5c', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 2, 0.25);
INSERT INTO order_details VALUES ('f4d8477c-7a21-4dbf-956c-6d896924469d', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 4, 0.100000001);
INSERT INTO order_details VALUES ('f4d8477c-7a21-4dbf-956c-6d896924469d', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 20, 0);
INSERT INTO order_details VALUES ('f4d8477c-7a21-4dbf-956c-6d896924469d', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 21, 0.100000001);
INSERT INTO order_details VALUES ('06cb2bf9-f0df-4fe2-be54-6c4872762982', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 20, 0);
INSERT INTO order_details VALUES ('06cb2bf9-f0df-4fe2-be54-6c4872762982', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 15, 0);
INSERT INTO order_details VALUES ('0169747b-1a8b-4515-8cfc-689bb3b92a2f', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 15, 0.25);
INSERT INTO order_details VALUES ('0169747b-1a8b-4515-8cfc-689bb3b92a2f', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 18, 0.25);
INSERT INTO order_details VALUES ('0169747b-1a8b-4515-8cfc-689bb3b92a2f', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 30, 0.25);
INSERT INTO order_details VALUES ('0169747b-1a8b-4515-8cfc-689bb3b92a2f', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 35, 0.25);
INSERT INTO order_details VALUES ('4a38de18-4156-4b4a-8325-425810826157', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 30, 0);
INSERT INTO order_details VALUES ('4a38de18-4156-4b4a-8325-425810826157', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 20, 0);
INSERT INTO order_details VALUES ('97343cdd-050a-4d29-83d5-e5d4fa89e298', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 15, 0);
INSERT INTO order_details VALUES ('97343cdd-050a-4d29-83d5-e5d4fa89e298', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 15, 0.150000006);
INSERT INTO order_details VALUES ('975cae32-44ef-4960-a065-2ceea1d08bec', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 20, 0);
INSERT INTO order_details VALUES ('975cae32-44ef-4960-a065-2ceea1d08bec', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 15, 0);
INSERT INTO order_details VALUES ('8d6cfbf7-d3a0-48d0-9a06-6ac7a1a47e73', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 30, 0);
INSERT INTO order_details VALUES ('8d6cfbf7-d3a0-48d0-9a06-6ac7a1a47e73', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 25, 0.0500000007);
INSERT INTO order_details VALUES ('8d6cfbf7-d3a0-48d0-9a06-6ac7a1a47e73', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 30, 0);
INSERT INTO order_details VALUES ('d4df15aa-6911-4aef-91c3-45014e9809c0', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 12, 0.25);
INSERT INTO order_details VALUES ('d4df15aa-6911-4aef-91c3-45014e9809c0', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 20, 0.25);
INSERT INTO order_details VALUES ('0318df23-60d3-474a-a2d9-0aae96f1ece5', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 2, 0.25);
INSERT INTO order_details VALUES ('0318df23-60d3-474a-a2d9-0aae96f1ece5', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 20, 0);
INSERT INTO order_details VALUES ('d0376bbd-11a0-44d2-8012-5c1ed84b9847', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 30, 0.100000001);
INSERT INTO order_details VALUES ('d0376bbd-11a0-44d2-8012-5c1ed84b9847', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 20, 0.100000001);
INSERT INTO order_details VALUES ('129b8db3-7866-4374-beec-188cb9f305ae', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 12, 0.100000001);
INSERT INTO order_details VALUES ('129b8db3-7866-4374-beec-188cb9f305ae', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 20, 0.100000001);
INSERT INTO order_details VALUES ('129b8db3-7866-4374-beec-188cb9f305ae', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 6, 0.100000001);
INSERT INTO order_details VALUES ('582b3c9d-12c7-476e-9eb6-7af14209395a', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 20, 0.200000003);
INSERT INTO order_details VALUES ('3dd27072-d1b9-45a5-8bc8-337e831be320', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 3, 0.100000001);
INSERT INTO order_details VALUES ('3dd27072-d1b9-45a5-8bc8-337e831be320', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 28, 0.100000001);
INSERT INTO order_details VALUES ('3dd27072-d1b9-45a5-8bc8-337e831be320', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 6, 0.100000001);
INSERT INTO order_details VALUES ('20504e35-fd3c-4ff1-ac33-97323f8efb27', '0684ad85-cbf4-4340-b11e-e3c9caf11ee1', 15.5, 50, 0);
INSERT INTO order_details VALUES ('20504e35-fd3c-4ff1-ac33-97323f8efb27', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 24, 0);
INSERT INTO order_details VALUES ('20504e35-fd3c-4ff1-ac33-97323f8efb27', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 45, 0);
INSERT INTO order_details VALUES ('20504e35-fd3c-4ff1-ac33-97323f8efb27', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 10, 0);
INSERT INTO order_details VALUES ('20504e35-fd3c-4ff1-ac33-97323f8efb27', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 45, 0);
INSERT INTO order_details VALUES ('20504e35-fd3c-4ff1-ac33-97323f8efb27', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 30, 0);
INSERT INTO order_details VALUES ('14be7e92-8e8e-4c31-b26c-a83a393176b1', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 60, 0);
INSERT INTO order_details VALUES ('14be7e92-8e8e-4c31-b26c-a83a393176b1', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 70, 0.0500000007);
INSERT INTO order_details VALUES ('14be7e92-8e8e-4c31-b26c-a83a393176b1', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 55, 0.0500000007);
INSERT INTO order_details VALUES ('14be7e92-8e8e-4c31-b26c-a83a393176b1', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 70, 0.0500000007);
INSERT INTO order_details VALUES ('96599ece-8499-44b3-b089-5e952c14c51c', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 20, 0.0500000007);
INSERT INTO order_details VALUES ('96599ece-8499-44b3-b089-5e952c14c51c', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 24, 0.0500000007);
INSERT INTO order_details VALUES ('96599ece-8499-44b3-b089-5e952c14c51c', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 40, 0.0500000007);
INSERT INTO order_details VALUES ('b8f30914-99af-4aa1-b496-1be18c3a50b9', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 21, 0);
INSERT INTO order_details VALUES ('7fe34de1-f8c9-4c29-ad5c-8652e966b647', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 3, 0.200000003);
INSERT INTO order_details VALUES ('7fe34de1-f8c9-4c29-ad5c-8652e966b647', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 49, 0.200000003);
INSERT INTO order_details VALUES ('8cc8f08e-5f61-45d7-8c19-5de147236d43', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 10, 0);
INSERT INTO order_details VALUES ('d93f9299-33b6-48d8-8c6f-e806f0fbe421', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 30, 0.0500000007);
INSERT INTO order_details VALUES ('d93f9299-33b6-48d8-8c6f-e806f0fbe421', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 30, 0.0500000007);
INSERT INTO order_details VALUES ('d93f9299-33b6-48d8-8c6f-e806f0fbe421', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 20, 0.0500000007);
INSERT INTO order_details VALUES ('db72fbba-eac5-4f4f-9832-35e83070deec', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 24, 0.150000006);
INSERT INTO order_details VALUES ('db72fbba-eac5-4f4f-9832-35e83070deec', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 12, 0.150000006);
INSERT INTO order_details VALUES ('db72fbba-eac5-4f4f-9832-35e83070deec', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 15, 0.150000006);
INSERT INTO order_details VALUES ('168aa178-dc99-4873-9a26-ce1af0e0a7ad', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 20, 0);
INSERT INTO order_details VALUES ('168aa178-dc99-4873-9a26-ce1af0e0a7ad', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 1, 0);
INSERT INTO order_details VALUES ('168aa178-dc99-4873-9a26-ce1af0e0a7ad', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 10, 0);
INSERT INTO order_details VALUES ('ce52433d-2f11-4d14-936c-356b281d7cf1', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 36, 0);
INSERT INTO order_details VALUES ('ce52433d-2f11-4d14-936c-356b281d7cf1', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 10, 0);
INSERT INTO order_details VALUES ('2a26ea38-a308-413a-943d-f5ec74a5fa34', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 45, 0.200000003);
INSERT INTO order_details VALUES ('2a26ea38-a308-413a-943d-f5ec74a5fa34', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 14, 0.200000003);
INSERT INTO order_details VALUES ('b9f88265-164b-4d28-a1dd-45a652d55216', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 8, 0.100000001);
INSERT INTO order_details VALUES ('b9f88265-164b-4d28-a1dd-45a652d55216', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 4, 0.100000001);
INSERT INTO order_details VALUES ('b9f88265-164b-4d28-a1dd-45a652d55216', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 15, 0.100000001);
INSERT INTO order_details VALUES ('9c354d20-789f-4056-a8be-2b1d02df20fb', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 30, 0);
INSERT INTO order_details VALUES ('899651be-73bb-440a-aead-c2bbcc78feff', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 32, 0);
INSERT INTO order_details VALUES ('899651be-73bb-440a-aead-c2bbcc78feff', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 60, 0);
INSERT INTO order_details VALUES ('899651be-73bb-440a-aead-c2bbcc78feff', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 14, 25, 0);
INSERT INTO order_details VALUES ('899651be-73bb-440a-aead-c2bbcc78feff', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 50, 0);
INSERT INTO order_details VALUES ('899651be-73bb-440a-aead-c2bbcc78feff', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 25, 0);
INSERT INTO order_details VALUES ('ea5a626a-32a8-4d9d-84bd-c9e1c3eeb608', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 10, 0);
INSERT INTO order_details VALUES ('ea5a626a-32a8-4d9d-84bd-c9e1c3eeb608', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 10, 0);
INSERT INTO order_details VALUES ('ea5a626a-32a8-4d9d-84bd-c9e1c3eeb608', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 12, 0);
INSERT INTO order_details VALUES ('4fc0303b-7dd4-44fc-9dd9-d2aeecdd6ecf', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 15, 0.100000001);
INSERT INTO order_details VALUES ('4fc0303b-7dd4-44fc-9dd9-d2aeecdd6ecf', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 12, 0);
INSERT INTO order_details VALUES ('323bfe25-0963-4d3a-83f3-05c7d7d9db24', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 3, 0);
INSERT INTO order_details VALUES ('323bfe25-0963-4d3a-83f3-05c7d7d9db24', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 6, 0);
INSERT INTO order_details VALUES ('323bfe25-0963-4d3a-83f3-05c7d7d9db24', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 6, 0);
INSERT INTO order_details VALUES ('01a6f1d9-655d-4c44-ba40-4002782664aa', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 5, 0);
INSERT INTO order_details VALUES ('695029fb-2a8e-479d-8b1b-49da0ebea66d', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 30, 0);
INSERT INTO order_details VALUES ('695029fb-2a8e-479d-8b1b-49da0ebea66d', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 10, 0);
INSERT INTO order_details VALUES ('695029fb-2a8e-479d-8b1b-49da0ebea66d', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 30, 0);
INSERT INTO order_details VALUES ('dc83137e-f079-458f-a911-42782d35e879', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 2, 0);
INSERT INTO order_details VALUES ('dc83137e-f079-458f-a911-42782d35e879', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 7, 0);
INSERT INTO order_details VALUES ('dc83137e-f079-458f-a911-42782d35e879', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 21, 0);
INSERT INTO order_details VALUES ('df16522f-84b9-4935-9ed2-a76467df0092', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 30, 0.150000006);
INSERT INTO order_details VALUES ('df16522f-84b9-4935-9ed2-a76467df0092', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 8, 0.150000006);
INSERT INTO order_details VALUES ('82418300-53ce-4573-ae43-d6f4ecf4162c', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 100, 0);
INSERT INTO order_details VALUES ('82418300-53ce-4573-ae43-d6f4ecf4162c', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 30, 0);
INSERT INTO order_details VALUES ('82418300-53ce-4573-ae43-d6f4ecf4162c', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 120, 0);
INSERT INTO order_details VALUES ('82418300-53ce-4573-ae43-d6f4ecf4162c', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 30, 0);
INSERT INTO order_details VALUES ('5dcd7d94-25c8-4582-be20-dfeb70c08a5e', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 12, 0);
INSERT INTO order_details VALUES ('6d376016-3535-4284-80c8-7414782b5f68', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 50, 0.25);
INSERT INTO order_details VALUES ('6d376016-3535-4284-80c8-7414782b5f68', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 20, 0.25);
INSERT INTO order_details VALUES ('6d376016-3535-4284-80c8-7414782b5f68', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 40, 0.25);
INSERT INTO order_details VALUES ('e0f34993-2fa3-4845-a0c5-6848f5de64b1', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 30, 0.100000001);
INSERT INTO order_details VALUES ('e0f34993-2fa3-4845-a0c5-6848f5de64b1', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 12, 0.100000001);
INSERT INTO order_details VALUES ('e0f34993-2fa3-4845-a0c5-6848f5de64b1', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 28, 0);
INSERT INTO order_details VALUES ('61366f25-739d-4f0e-80d3-f9782a7bd766', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 30, 0);
INSERT INTO order_details VALUES ('61366f25-739d-4f0e-80d3-f9782a7bd766', '309dcfa3-7eea-4a14-9795-f8693838c3bd', 17, 4, 0);
INSERT INTO order_details VALUES ('61366f25-739d-4f0e-80d3-f9782a7bd766', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 30, 0);
INSERT INTO order_details VALUES ('1acb2bd5-93c3-4bcb-9b01-b24a2bdfeb7f', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 9, 0);
INSERT INTO order_details VALUES ('e25697db-0201-4758-90b1-fdf2bc15c5cb', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 20, 0);
INSERT INTO order_details VALUES ('e25697db-0201-4758-90b1-fdf2bc15c5cb', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 40, 0);
INSERT INTO order_details VALUES ('e25697db-0201-4758-90b1-fdf2bc15c5cb', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 30, 0);
INSERT INTO order_details VALUES ('e42c957a-98e5-40eb-bfeb-cbd0ac237418', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 20, 0);
INSERT INTO order_details VALUES ('e42c957a-98e5-40eb-bfeb-cbd0ac237418', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 4, 0);
INSERT INTO order_details VALUES ('e42c957a-98e5-40eb-bfeb-cbd0ac237418', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 15, 0);
INSERT INTO order_details VALUES ('b8d7318c-57f9-4958-a14f-bb9888fdaf43', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 30, 0.200000003);
INSERT INTO order_details VALUES ('b8d7318c-57f9-4958-a14f-bb9888fdaf43', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 15, 0);
INSERT INTO order_details VALUES ('6cff6179-d429-4652-be88-31000693f0fd', 'af59c8a6-47cb-48a5-888b-b4f1f195656e', 97, 50, 0.25);
INSERT INTO order_details VALUES ('6cff6179-d429-4652-be88-31000693f0fd', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 10, 0);
INSERT INTO order_details VALUES ('6cff6179-d429-4652-be88-31000693f0fd', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 6, 0.25);
INSERT INTO order_details VALUES ('0bf15cbd-03cc-48ba-b2fa-28e69c7eb684', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 18, 0.100000001);
INSERT INTO order_details VALUES ('0bf15cbd-03cc-48ba-b2fa-28e69c7eb684', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 60, 0.100000001);
INSERT INTO order_details VALUES ('0bf15cbd-03cc-48ba-b2fa-28e69c7eb684', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 14, 0);
INSERT INTO order_details VALUES ('05859d57-2438-4aae-aec5-4a813047a165', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 35, 0.25);
INSERT INTO order_details VALUES ('4ba51ebc-367d-4c33-9499-fbfbf22d752a', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 20, 0.25);
INSERT INTO order_details VALUES ('4ba51ebc-367d-4c33-9499-fbfbf22d752a', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 30, 0.25);
INSERT INTO order_details VALUES ('c5087783-771a-422d-bd07-9fe285339f5c', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 30, 0);
INSERT INTO order_details VALUES ('c5087783-771a-422d-bd07-9fe285339f5c', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 40, 0);
INSERT INTO order_details VALUES ('c5087783-771a-422d-bd07-9fe285339f5c', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 40, 0);
INSERT INTO order_details VALUES ('c5087783-771a-422d-bd07-9fe285339f5c', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 24, 0);
INSERT INTO order_details VALUES ('c5087783-771a-422d-bd07-9fe285339f5c', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 48, 0);
INSERT INTO order_details VALUES ('c6b07756-de3c-43ba-8002-2151a4e9a700', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 20, 0);
INSERT INTO order_details VALUES ('1dd0194a-e8a2-4523-b0b0-77e464df5ac8', 'af59c8a6-47cb-48a5-888b-b4f1f195656e', 97, 6, 0);
INSERT INTO order_details VALUES ('1dd0194a-e8a2-4523-b0b0-77e464df5ac8', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 60, 0.150000006);
INSERT INTO order_details VALUES ('1dd0194a-e8a2-4523-b0b0-77e464df5ac8', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 30, 0.150000006);
INSERT INTO order_details VALUES ('1dd0194a-e8a2-4523-b0b0-77e464df5ac8', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 15, 0.150000006);
INSERT INTO order_details VALUES ('9d763568-30c2-49f5-b7da-1869bfee5a43', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 90, 0);
INSERT INTO order_details VALUES ('9d763568-30c2-49f5-b7da-1869bfee5a43', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 25, 0);
INSERT INTO order_details VALUES ('9d763568-30c2-49f5-b7da-1869bfee5a43', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 50, 0);
INSERT INTO order_details VALUES ('ae4cbe7d-ea8e-44ee-bdc6-351662fd3610', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 10, 0);
INSERT INTO order_details VALUES ('ae4cbe7d-ea8e-44ee-bdc6-351662fd3610', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 4, 0);
INSERT INTO order_details VALUES ('ae4cbe7d-ea8e-44ee-bdc6-351662fd3610', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 20, 0);
INSERT INTO order_details VALUES ('5b6fcc95-ae45-49cc-a446-b4ef75bc0d64', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 20, 0);
INSERT INTO order_details VALUES ('5b6fcc95-ae45-49cc-a446-b4ef75bc0d64', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 18, 0);
INSERT INTO order_details VALUES ('225b00f5-76f0-4c80-8cd4-3aa7ca926aee', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 7, 0.25);
INSERT INTO order_details VALUES ('225b00f5-76f0-4c80-8cd4-3aa7ca926aee', '61f41763-1ece-4378-810f-0a866a077be5', 18, 9, 0.25);
INSERT INTO order_details VALUES ('225b00f5-76f0-4c80-8cd4-3aa7ca926aee', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 30, 0.25);
INSERT INTO order_details VALUES ('225b00f5-76f0-4c80-8cd4-3aa7ca926aee', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 30, 0.25);
INSERT INTO order_details VALUES ('b75cad16-6be5-4c3e-8976-333cc9801103', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 15, 0);
INSERT INTO order_details VALUES ('b75cad16-6be5-4c3e-8976-333cc9801103', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 8, 0.0500000007);
INSERT INTO order_details VALUES ('b75cad16-6be5-4c3e-8976-333cc9801103', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 12, 0.0500000007);
INSERT INTO order_details VALUES ('b75cad16-6be5-4c3e-8976-333cc9801103', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 65, 0.0500000007);
INSERT INTO order_details VALUES ('b75cad16-6be5-4c3e-8976-333cc9801103', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 8, 0.0500000007);
INSERT INTO order_details VALUES ('1fdb500d-51e7-4ac1-9c8c-c7ebb474e7d2', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 12, 0);
INSERT INTO order_details VALUES ('c2f9f077-fc03-4355-84a7-fa358843c081', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 5, 0.200000003);
INSERT INTO order_details VALUES ('c2f9f077-fc03-4355-84a7-fa358843c081', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 12, 0.200000003);
INSERT INTO order_details VALUES ('c2f9f077-fc03-4355-84a7-fa358843c081', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 40, 0.200000003);
INSERT INTO order_details VALUES ('c2f9f077-fc03-4355-84a7-fa358843c081', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 60, 0.200000003);
INSERT INTO order_details VALUES ('647dae80-6324-41d5-aa93-dfe2efffcb2e', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 42, 0.150000006);
INSERT INTO order_details VALUES ('647dae80-6324-41d5-aa93-dfe2efffcb2e', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 20, 0.150000006);
INSERT INTO order_details VALUES ('647dae80-6324-41d5-aa93-dfe2efffcb2e', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 35, 0.150000006);
INSERT INTO order_details VALUES ('92368d2a-dea3-4bab-a3ca-9d0c5450a53e', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 10, 6, 0);
INSERT INTO order_details VALUES ('92368d2a-dea3-4bab-a3ca-9d0c5450a53e', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 15, 0);
INSERT INTO order_details VALUES ('84247e3c-33e0-42aa-a4b3-ceb281df2f01', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 5, 0);
INSERT INTO order_details VALUES ('84247e3c-33e0-42aa-a4b3-ceb281df2f01', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 35, 0);
INSERT INTO order_details VALUES ('84247e3c-33e0-42aa-a4b3-ceb281df2f01', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 35, 0);
INSERT INTO order_details VALUES ('5d37f19d-8efc-439d-9369-877b4c28bfad', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 6, 0);
INSERT INTO order_details VALUES ('5d37f19d-8efc-439d-9369-877b4c28bfad', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 35, 0);
INSERT INTO order_details VALUES ('5d37f19d-8efc-439d-9369-877b4c28bfad', 'd81d4aa0-e0af-41eb-9ba1-42e8ee9559ef', 12.75, 24, 0);
INSERT INTO order_details VALUES ('2cfd2c34-9b96-4621-8c3d-d1b10b3c3346', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 20, 0);
INSERT INTO order_details VALUES ('2cfd2c34-9b96-4621-8c3d-d1b10b3c3346', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 4, 0);
INSERT INTO order_details VALUES ('d2f9a7fb-47e9-4252-8f59-65c71e41b6b1', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 20, 0);
INSERT INTO order_details VALUES ('d2f9a7fb-47e9-4252-8f59-65c71e41b6b1', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 24, 0);
INSERT INTO order_details VALUES ('d2f9a7fb-47e9-4252-8f59-65c71e41b6b1', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 8, 0);
INSERT INTO order_details VALUES ('773b6bc2-1682-42ac-96a4-2b92e8a6aaf2', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 21, 0);
INSERT INTO order_details VALUES ('773b6bc2-1682-42ac-96a4-2b92e8a6aaf2', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 40, 0);
INSERT INTO order_details VALUES ('773b6bc2-1682-42ac-96a4-2b92e8a6aaf2', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 28, 0.150000006);
INSERT INTO order_details VALUES ('6a818e7b-781e-4147-8d6a-4bca580c2430', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 21.3500004, 4, 0);
INSERT INTO order_details VALUES ('6a818e7b-781e-4147-8d6a-4bca580c2430', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 5, 0);
INSERT INTO order_details VALUES ('b0417de0-8c66-43c3-aaff-d1288788f9b2', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 40, 0);
INSERT INTO order_details VALUES ('b0417de0-8c66-43c3-aaff-d1288788f9b2', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 28, 0);
INSERT INTO order_details VALUES ('b0417de0-8c66-43c3-aaff-d1288788f9b2', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 10, 0);
INSERT INTO order_details VALUES ('98456107-89d4-414d-9bff-dc05374da8d3', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 5, 0);
INSERT INTO order_details VALUES ('98456107-89d4-414d-9bff-dc05374da8d3', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 5, 0);
INSERT INTO order_details VALUES ('b83a09f0-6688-4dd2-9b97-50cdc218cf10', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 12, 0);
INSERT INTO order_details VALUES ('b83a09f0-6688-4dd2-9b97-50cdc218cf10', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 42, 0);
INSERT INTO order_details VALUES ('b83a09f0-6688-4dd2-9b97-50cdc218cf10', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 120, 0);
INSERT INTO order_details VALUES ('7ac618ff-fae8-4f06-a50b-e5912642edee', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 3, 0.0500000007);
INSERT INTO order_details VALUES ('7ac618ff-fae8-4f06-a50b-e5912642edee', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 30, 0);
INSERT INTO order_details VALUES ('22707408-32e9-414c-894f-92bf8716738c', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 18, 0);
INSERT INTO order_details VALUES ('22707408-32e9-414c-894f-92bf8716738c', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 30, 0);
INSERT INTO order_details VALUES ('22707408-32e9-414c-894f-92bf8716738c', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 110, 0);
INSERT INTO order_details VALUES ('22707408-32e9-414c-894f-92bf8716738c', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 24, 0);
INSERT INTO order_details VALUES ('8a44ab1c-31b1-4442-a3fb-bc1e71c438ce', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 30, 0.25);
INSERT INTO order_details VALUES ('8a44ab1c-31b1-4442-a3fb-bc1e71c438ce', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 27, 0.25);
INSERT INTO order_details VALUES ('8a44ab1c-31b1-4442-a3fb-bc1e71c438ce', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 50, 0.25);
INSERT INTO order_details VALUES ('8a44ab1c-31b1-4442-a3fb-bc1e71c438ce', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 18, 0.25);
INSERT INTO order_details VALUES ('8a44ab1c-31b1-4442-a3fb-bc1e71c438ce', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 12, 0.25);
INSERT INTO order_details VALUES ('23006a0b-1394-4776-a71f-5f4618b78d98', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 21, 0);
INSERT INTO order_details VALUES ('23006a0b-1394-4776-a71f-5f4618b78d98', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 30, 0);
INSERT INTO order_details VALUES ('c504f25b-c477-48ea-8846-c4abe91c5131', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 5, 0);
INSERT INTO order_details VALUES ('c504f25b-c477-48ea-8846-c4abe91c5131', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 7, 0);
INSERT INTO order_details VALUES ('c504f25b-c477-48ea-8846-c4abe91c5131', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 10, 0);
INSERT INTO order_details VALUES ('d7180e9b-369e-4512-87ac-73b1d2a4901a', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 32, 0.0500000007);
INSERT INTO order_details VALUES ('d7180e9b-369e-4512-87ac-73b1d2a4901a', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 15, 0);
INSERT INTO order_details VALUES ('d7180e9b-369e-4512-87ac-73b1d2a4901a', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 25, 0.0500000007);
INSERT INTO order_details VALUES ('066b47c8-6f72-4ab8-97b9-8b06de8f8b45', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 36, 0);
INSERT INTO order_details VALUES ('066b47c8-6f72-4ab8-97b9-8b06de8f8b45', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 20, 0);
INSERT INTO order_details VALUES ('066b47c8-6f72-4ab8-97b9-8b06de8f8b45', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 40, 0);
INSERT INTO order_details VALUES ('066b47c8-6f72-4ab8-97b9-8b06de8f8b45', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 20, 0);
INSERT INTO order_details VALUES ('f86bead3-4586-425a-80f0-a4402e964df4', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 12, 0.25);
INSERT INTO order_details VALUES ('f86bead3-4586-425a-80f0-a4402e964df4', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 3, 0.25);
INSERT INTO order_details VALUES ('f86bead3-4586-425a-80f0-a4402e964df4', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 40, 0.25);
INSERT INTO order_details VALUES ('6b2562d4-674f-4db2-8893-5899c1d673d3', '61f41763-1ece-4378-810f-0a866a077be5', 18, 21, 0);
INSERT INTO order_details VALUES ('6b2562d4-674f-4db2-8893-5899c1d673d3', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 8, 0);
INSERT INTO order_details VALUES ('1187e0d6-34ab-4e0c-bd8b-4c6ee32f0fc7', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 50, 0.0500000007);
INSERT INTO order_details VALUES ('29a22535-5cf1-4341-93fe-91cdb16d19eb', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 3, 0);
INSERT INTO order_details VALUES ('29a22535-5cf1-4341-93fe-91cdb16d19eb', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 50, 0);
INSERT INTO order_details VALUES ('29a22535-5cf1-4341-93fe-91cdb16d19eb', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 45, 0);
INSERT INTO order_details VALUES ('29a22535-5cf1-4341-93fe-91cdb16d19eb', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 42, 0);
INSERT INTO order_details VALUES ('e32b83d2-d3e7-40fb-87af-d19a15d0db15', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 15, 0);
INSERT INTO order_details VALUES ('82cd4132-c21d-43f9-be2d-1c6b48ecc1be', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 16, 0);
INSERT INTO order_details VALUES ('82cd4132-c21d-43f9-be2d-1c6b48ecc1be', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 5, 0);
INSERT INTO order_details VALUES ('af42e93d-507f-4f80-893a-9f597cc98d32', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 12, 0);
INSERT INTO order_details VALUES ('af42e93d-507f-4f80-893a-9f597cc98d32', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 4, 0);
INSERT INTO order_details VALUES ('af42e93d-507f-4f80-893a-9f597cc98d32', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 6, 0);
INSERT INTO order_details VALUES ('4483d2b4-7d73-471b-9bf8-96260720227a', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 25, 0);
INSERT INTO order_details VALUES ('4483d2b4-7d73-471b-9bf8-96260720227a', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 5, 0);
INSERT INTO order_details VALUES ('ce30f56e-fad5-4bd3-ad88-8a0f2b3cf59a', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 20, 0.0500000007);
INSERT INTO order_details VALUES ('ce30f56e-fad5-4bd3-ad88-8a0f2b3cf59a', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 10, 0.0500000007);
INSERT INTO order_details VALUES ('ce30f56e-fad5-4bd3-ad88-8a0f2b3cf59a', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 10, 0.0500000007);
INSERT INTO order_details VALUES ('9a124884-8661-4adb-87f0-bc57fbf465fe', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 15, 0);
INSERT INTO order_details VALUES ('9a124884-8661-4adb-87f0-bc57fbf465fe', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 6, 0);
INSERT INTO order_details VALUES ('9a124884-8661-4adb-87f0-bc57fbf465fe', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 12, 0);
INSERT INTO order_details VALUES ('9a124884-8661-4adb-87f0-bc57fbf465fe', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 15, 0);
INSERT INTO order_details VALUES ('58e107e1-7d76-4074-8c24-2d537e0b2e49', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 50, 0);
INSERT INTO order_details VALUES ('58e107e1-7d76-4074-8c24-2d537e0b2e49', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 30, 0);
INSERT INTO order_details VALUES ('58e107e1-7d76-4074-8c24-2d537e0b2e49', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 16.25, 40, 0);
INSERT INTO order_details VALUES ('f648123f-b859-47b3-9fed-51b902bc30ea', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 15, 0.0500000007);
INSERT INTO order_details VALUES ('f648123f-b859-47b3-9fed-51b902bc30ea', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 3, 0.0500000007);
INSERT INTO order_details VALUES ('f648123f-b859-47b3-9fed-51b902bc30ea', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 10, 0.0500000007);
INSERT INTO order_details VALUES ('5b08f572-3b4c-4bb9-a933-86cf347787e0', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 40, 0.0500000007);
INSERT INTO order_details VALUES ('5b08f572-3b4c-4bb9-a933-86cf347787e0', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 30, 0.0500000007);
INSERT INTO order_details VALUES ('f0e34599-970f-4e59-843c-7eecaebfb395', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 20, 0);
INSERT INTO order_details VALUES ('27a23153-cbdc-4416-87c2-2346356270c4', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 16, 0);
INSERT INTO order_details VALUES ('27a23153-cbdc-4416-87c2-2346356270c4', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 20, 0);
INSERT INTO order_details VALUES ('27a23153-cbdc-4416-87c2-2346356270c4', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 25, 0);
INSERT INTO order_details VALUES ('5ae66006-749b-4e7a-a978-6be8c472d9fa', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 30, 0);
INSERT INTO order_details VALUES ('5ae66006-749b-4e7a-a978-6be8c472d9fa', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 15, 0);
INSERT INTO order_details VALUES ('5ae66006-749b-4e7a-a978-6be8c472d9fa', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 20, 0);
INSERT INTO order_details VALUES ('1a6d453f-bcc3-4494-a34a-d063cbb2b90e', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 20, 0.100000001);
INSERT INTO order_details VALUES ('1a6d453f-bcc3-4494-a34a-d063cbb2b90e', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 2, 0.100000001);
INSERT INTO order_details VALUES ('2dd62301-c3a0-486c-bcce-382a96cd381b', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 40, 0);
INSERT INTO order_details VALUES ('2dd62301-c3a0-486c-bcce-382a96cd381b', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 20, 0);
INSERT INTO order_details VALUES ('c8060e9a-7cc6-4f2e-bb98-65b6793f96ae', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 4, 0);
INSERT INTO order_details VALUES ('c8060e9a-7cc6-4f2e-bb98-65b6793f96ae', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 12, 0);
INSERT INTO order_details VALUES ('53ce8058-22a7-4a3e-bcd4-d3dca0ee5347', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 3, 0);
INSERT INTO order_details VALUES ('d2a6a69b-e6b5-4c94-9a70-a8f59a916c22', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 6, 0);
INSERT INTO order_details VALUES ('d2a6a69b-e6b5-4c94-9a70-a8f59a916c22', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 18, 0);
INSERT INTO order_details VALUES ('d39d44b4-b160-4883-a50d-7dd7d94ac8b4', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 5, 0.200000003);
INSERT INTO order_details VALUES ('d39d44b4-b160-4883-a50d-7dd7d94ac8b4', '61f41763-1ece-4378-810f-0a866a077be5', 18, 35, 0.200000003);
INSERT INTO order_details VALUES ('d39d44b4-b160-4883-a50d-7dd7d94ac8b4', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 40, 0.200000003);
INSERT INTO order_details VALUES ('d39d44b4-b160-4883-a50d-7dd7d94ac8b4', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 14, 0.200000003);
INSERT INTO order_details VALUES ('6d5eee79-58fc-4727-a59f-b335583c0775', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 15, 0.200000003);
INSERT INTO order_details VALUES ('8c12784c-622d-47c5-8100-8ba15c2cf96c', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 10, 20, 0);
INSERT INTO order_details VALUES ('8c12784c-622d-47c5-8100-8ba15c2cf96c', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 50, 0);
INSERT INTO order_details VALUES ('8c12784c-622d-47c5-8100-8ba15c2cf96c', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 35, 0);
INSERT INTO order_details VALUES ('c2706361-a3db-4c83-b449-686b6aee561d', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 28, 0.0500000007);
INSERT INTO order_details VALUES ('38e4737e-1b91-4561-b162-c007255b775d', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 50, 0.200000003);
INSERT INTO order_details VALUES ('ebc812c6-9be4-42c7-a9d1-c2cf506479a8', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 24, 0);
INSERT INTO order_details VALUES ('ebc812c6-9be4-42c7-a9d1-c2cf506479a8', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 16, 0);
INSERT INTO order_details VALUES ('ebc812c6-9be4-42c7-a9d1-c2cf506479a8', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 45, 0);
INSERT INTO order_details VALUES ('ebc812c6-9be4-42c7-a9d1-c2cf506479a8', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 7, 0);
INSERT INTO order_details VALUES ('e38f8937-529d-4531-9e1d-af86f9acc8b6', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 6, 0);
INSERT INTO order_details VALUES ('e38f8937-529d-4531-9e1d-af86f9acc8b6', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 28, 0);
INSERT INTO order_details VALUES ('e38f8937-529d-4531-9e1d-af86f9acc8b6', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 9, 0);
INSERT INTO order_details VALUES ('e38f8937-529d-4531-9e1d-af86f9acc8b6', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 40, 0);
INSERT INTO order_details VALUES ('1c7c6184-057c-4a3c-a3e2-e79cf02c9181', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 8, 0);
INSERT INTO order_details VALUES ('1c7c6184-057c-4a3c-a3e2-e79cf02c9181', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 35, 0);
INSERT INTO order_details VALUES ('1c7c6184-057c-4a3c-a3e2-e79cf02c9181', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 9, 0);
INSERT INTO order_details VALUES ('1c7c6184-057c-4a3c-a3e2-e79cf02c9181', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 30, 0);
INSERT INTO order_details VALUES ('0824a07c-0e80-4a94-8f33-aecda177ba73', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 44, 0);
INSERT INTO order_details VALUES ('0824a07c-0e80-4a94-8f33-aecda177ba73', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 40, 0);
INSERT INTO order_details VALUES ('0824a07c-0e80-4a94-8f33-aecda177ba73', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 28, 0);
INSERT INTO order_details VALUES ('dceab1df-e42e-4c8a-892f-f012f00c7073', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 15, 0);
INSERT INTO order_details VALUES ('dceab1df-e42e-4c8a-892f-f012f00c7073', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 6, 0);
INSERT INTO order_details VALUES ('dceab1df-e42e-4c8a-892f-f012f00c7073', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 10, 0);
INSERT INTO order_details VALUES ('0f7faff1-9198-421e-a0ae-a68137ef3e8d', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 5, 0.150000006);
INSERT INTO order_details VALUES ('0f7faff1-9198-421e-a0ae-a68137ef3e8d', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 40, 0.150000006);
INSERT INTO order_details VALUES ('0f7faff1-9198-421e-a0ae-a68137ef3e8d', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 25, 0.150000006);
INSERT INTO order_details VALUES ('f9a6b6e3-a7ab-4a35-8a77-72cc966eccc7', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 12, 0.100000001);
INSERT INTO order_details VALUES ('f9a6b6e3-a7ab-4a35-8a77-72cc966eccc7', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 30, 0);
INSERT INTO order_details VALUES ('f9a6b6e3-a7ab-4a35-8a77-72cc966eccc7', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 16.25, 20, 0.100000001);
INSERT INTO order_details VALUES ('f9a6b6e3-a7ab-4a35-8a77-72cc966eccc7', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 15, 0);
INSERT INTO order_details VALUES ('02decfdb-8ac8-419d-84be-1ffef429dc4a', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 8, 0);
INSERT INTO order_details VALUES ('02decfdb-8ac8-419d-84be-1ffef429dc4a', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 3, 0);
INSERT INTO order_details VALUES ('e00b9465-c1e7-480a-8184-c1d7e27df19a', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 4, 0);
INSERT INTO order_details VALUES ('e00b9465-c1e7-480a-8184-c1d7e27df19a', '35757ead-53a9-44f2-a023-f8950dd9eeac', 10, 5, 0);
INSERT INTO order_details VALUES ('ce5ecd99-df86-4878-8aa2-7c27cd984247', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 3, 0);
INSERT INTO order_details VALUES ('0d67759a-557c-45e2-b7ed-921634329cb2', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 30, 0.25);
INSERT INTO order_details VALUES ('0d67759a-557c-45e2-b7ed-921634329cb2', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 30, 0.25);
INSERT INTO order_details VALUES ('0d67759a-557c-45e2-b7ed-921634329cb2', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 14, 0.25);
INSERT INTO order_details VALUES ('0d67759a-557c-45e2-b7ed-921634329cb2', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 25, 0.25);
INSERT INTO order_details VALUES ('69156381-e3ff-4399-ac73-fa75ce4d4daf', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 21, 0.200000003);
INSERT INTO order_details VALUES ('69156381-e3ff-4399-ac73-fa75ce4d4daf', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 20, 0.200000003);
INSERT INTO order_details VALUES ('69156381-e3ff-4399-ac73-fa75ce4d4daf', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 6, 0.200000003);
INSERT INTO order_details VALUES ('69156381-e3ff-4399-ac73-fa75ce4d4daf', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 20, 0.200000003);
INSERT INTO order_details VALUES ('6577e23e-83e5-429c-a86d-cf0c484c9a69', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 30, 0);
INSERT INTO order_details VALUES ('6577e23e-83e5-429c-a86d-cf0c484c9a69', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 7, 0);
INSERT INTO order_details VALUES ('6577e23e-83e5-429c-a86d-cf0c484c9a69', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 30, 0);
INSERT INTO order_details VALUES ('6577e23e-83e5-429c-a86d-cf0c484c9a69', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 24, 0);
INSERT INTO order_details VALUES ('2bc6d425-2a2c-4732-9152-9fe211e62881', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 20, 0);
INSERT INTO order_details VALUES ('2bc6d425-2a2c-4732-9152-9fe211e62881', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 60, 0);
INSERT INTO order_details VALUES ('2bc6d425-2a2c-4732-9152-9fe211e62881', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 40, 0);
INSERT INTO order_details VALUES ('36d0f251-1480-40b1-9bc1-67e0d5b6582a', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 10, 0);
INSERT INTO order_details VALUES ('f586be55-062c-4ce9-b99e-2b0a304c2ee7', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 12, 0.25);
INSERT INTO order_details VALUES ('f586be55-062c-4ce9-b99e-2b0a304c2ee7', '53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 43.9000015, 40, 0);
INSERT INTO order_details VALUES ('f586be55-062c-4ce9-b99e-2b0a304c2ee7', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 30, 0.25);
INSERT INTO order_details VALUES ('5ee234e2-bce8-4973-84f2-c5a9d7bb03cd', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 35, 0.25);
INSERT INTO order_details VALUES ('5ee234e2-bce8-4973-84f2-c5a9d7bb03cd', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 18, 0);
INSERT INTO order_details VALUES ('a37545b9-c1eb-4470-b359-5c4c97cd6448', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 16, 0);
INSERT INTO order_details VALUES ('a37545b9-c1eb-4470-b359-5c4c97cd6448', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 30, 0);
INSERT INTO order_details VALUES ('a37545b9-c1eb-4470-b359-5c4c97cd6448', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 28, 0);
INSERT INTO order_details VALUES ('a37545b9-c1eb-4470-b359-5c4c97cd6448', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 60, 0);
INSERT INTO order_details VALUES ('b8431de1-b8f4-4ca2-8b75-4a72d73b694d', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 40, 0);
INSERT INTO order_details VALUES ('b8431de1-b8f4-4ca2-8b75-4a72d73b694d', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 6, 0);
INSERT INTO order_details VALUES ('b8431de1-b8f4-4ca2-8b75-4a72d73b694d', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 20, 0);
INSERT INTO order_details VALUES ('2c8a595d-9109-4db8-ae4c-20edf5103b7e', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 10, 20, 0.100000001);
INSERT INTO order_details VALUES ('2c8a595d-9109-4db8-ae4c-20edf5103b7e', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 130, 0.100000001);
INSERT INTO order_details VALUES ('34ab4c14-0ae2-448f-8dd7-2a4ac28125b4', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 80, 0.100000001);
INSERT INTO order_details VALUES ('f0ddd740-0cb2-404d-80a6-9476f08bf2c6', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 40, 0);
INSERT INTO order_details VALUES ('f0ddd740-0cb2-404d-80a6-9476f08bf2c6', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 35, 0);
INSERT INTO order_details VALUES ('f0ddd740-0cb2-404d-80a6-9476f08bf2c6', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 40, 0);
INSERT INTO order_details VALUES ('eb8c0f7a-5bc2-45a3-abb2-85fd9bfa44b7', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 2, 0);
INSERT INTO order_details VALUES ('46d560df-6e07-4863-9a14-5caa7b412468', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 4, 0);
INSERT INTO order_details VALUES ('46d560df-6e07-4863-9a14-5caa7b412468', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 50, 0);
INSERT INTO order_details VALUES ('46d560df-6e07-4863-9a14-5caa7b412468', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 15, 0);
INSERT INTO order_details VALUES ('46d560df-6e07-4863-9a14-5caa7b412468', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 12, 0);
INSERT INTO order_details VALUES ('97ecc69b-306f-47b2-a34f-32a0464c1805', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 30, 0.0500000007);
INSERT INTO order_details VALUES ('97ecc69b-306f-47b2-a34f-32a0464c1805', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 15, 0.0500000007);
INSERT INTO order_details VALUES ('97ecc69b-306f-47b2-a34f-32a0464c1805', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 20, 0);
INSERT INTO order_details VALUES ('97ecc69b-306f-47b2-a34f-32a0464c1805', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 15, 0);
INSERT INTO order_details VALUES ('37c93e74-0e46-4e44-b835-d186d537c75e', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 15, 0.25);
INSERT INTO order_details VALUES ('31e88019-e0e6-4344-be82-007d8b462eca', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 16, 0);
INSERT INTO order_details VALUES ('79391bfb-7a28-47cf-b507-0383d0bdbaea', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 18, 0);
INSERT INTO order_details VALUES ('79391bfb-7a28-47cf-b507-0383d0bdbaea', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 25, 0);
INSERT INTO order_details VALUES ('14dc33dd-48f9-4349-981f-432f82cbd807', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 33, 0);
INSERT INTO order_details VALUES ('14dc33dd-48f9-4349-981f-432f82cbd807', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 70, 0.200000003);
INSERT INTO order_details VALUES ('14dc33dd-48f9-4349-981f-432f82cbd807', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 7, 0.200000003);
INSERT INTO order_details VALUES ('a8a61c3e-1ac6-42dc-bad4-cc79bb66a766', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 2, 0.25);
INSERT INTO order_details VALUES ('a8a61c3e-1ac6-42dc-bad4-cc79bb66a766', '309dcfa3-7eea-4a14-9795-f8693838c3bd', 17, 50, 0);
INSERT INTO order_details VALUES ('f18809e4-1fa4-4439-adcb-890bd98a7d26', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 6, 0);
INSERT INTO order_details VALUES ('f18809e4-1fa4-4439-adcb-890bd98a7d26', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 14, 3, 0);
INSERT INTO order_details VALUES ('d10aa8e2-e8da-4a7a-8ef6-9bb74a777d81', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 16, 0.0500000007);
INSERT INTO order_details VALUES ('d10aa8e2-e8da-4a7a-8ef6-9bb74a777d81', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 12, 0.0500000007);
INSERT INTO order_details VALUES ('d10aa8e2-e8da-4a7a-8ef6-9bb74a777d81', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 27, 0.0500000007);
INSERT INTO order_details VALUES ('d10aa8e2-e8da-4a7a-8ef6-9bb74a777d81', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 120, 0.0500000007);
INSERT INTO order_details VALUES ('a39b548a-195a-46a2-aa46-0a02a5087b08', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 20, 0.200000003);
INSERT INTO order_details VALUES ('e3d13793-bb79-4448-a276-739610d4d9b2', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 10, 0);
INSERT INTO order_details VALUES ('be7afd26-5dd9-4130-b62d-2b728fa7294a', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 20, 0);
INSERT INTO order_details VALUES ('be7afd26-5dd9-4130-b62d-2b728fa7294a', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 20, 0);
INSERT INTO order_details VALUES ('198f8b11-7fc8-4036-8caa-56b896c5dfff', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 35, 0);
INSERT INTO order_details VALUES ('198f8b11-7fc8-4036-8caa-56b896c5dfff', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 15, 0);
INSERT INTO order_details VALUES ('515d5a53-c07d-466b-8a0a-09cb0e2d4c18', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 3, 0.200000003);
INSERT INTO order_details VALUES ('515d5a53-c07d-466b-8a0a-09cb0e2d4c18', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 20, 0.200000003);
INSERT INTO order_details VALUES ('515d5a53-c07d-466b-8a0a-09cb0e2d4c18', '35757ead-53a9-44f2-a023-f8950dd9eeac', 10, 35, 0);
INSERT INTO order_details VALUES ('f9df90af-ad59-4115-8c3f-3cfe44d7f017', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 1, 0);
INSERT INTO order_details VALUES ('1568a0aa-5095-4ec0-a21c-ca0aa1e2d0b0', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 10, 0);
INSERT INTO order_details VALUES ('1568a0aa-5095-4ec0-a21c-ca0aa1e2d0b0', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 5, 0);
INSERT INTO order_details VALUES ('d95c9ff7-ac48-442f-837a-d31db3ed8e46', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 30, 0);
INSERT INTO order_details VALUES ('d95c9ff7-ac48-442f-837a-d31db3ed8e46', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 2, 0.150000006);
INSERT INTO order_details VALUES ('d95c9ff7-ac48-442f-837a-d31db3ed8e46', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 30, 0.150000006);
INSERT INTO order_details VALUES ('29a017c3-2216-4113-acf4-1df300cae2b6', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 10, 0);
INSERT INTO order_details VALUES ('29a017c3-2216-4113-acf4-1df300cae2b6', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 10, 0);
INSERT INTO order_details VALUES ('71b171c6-8713-424b-95de-e99215d6f51b', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 30, 0.200000003);
INSERT INTO order_details VALUES ('71b171c6-8713-424b-95de-e99215d6f51b', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 15, 0.200000003);
INSERT INTO order_details VALUES ('71b171c6-8713-424b-95de-e99215d6f51b', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 42, 0.200000003);
INSERT INTO order_details VALUES ('86709060-d8ff-42ee-8c5c-380ffef25c04', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 15, 0.0500000007);
INSERT INTO order_details VALUES ('86709060-d8ff-42ee-8c5c-380ffef25c04', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 20, 0.0500000007);
INSERT INTO order_details VALUES ('3bccd56f-07cb-4c53-99eb-fd48faa096b8', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 50, 0.0500000007);
INSERT INTO order_details VALUES ('3bccd56f-07cb-4c53-99eb-fd48faa096b8', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 40, 0.0500000007);
INSERT INTO order_details VALUES ('2e3fceae-a85e-468e-82e6-3b8edd909f45', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 30, 0);
INSERT INTO order_details VALUES ('2e3fceae-a85e-468e-82e6-3b8edd909f45', '61f41763-1ece-4378-810f-0a866a077be5', 18, 15, 0);
INSERT INTO order_details VALUES ('2e3fceae-a85e-468e-82e6-3b8edd909f45', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 30, 0);
INSERT INTO order_details VALUES ('2e3fceae-a85e-468e-82e6-3b8edd909f45', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 18, 0);
INSERT INTO order_details VALUES ('6a63bd0c-86fe-4f29-a9b5-f5940726f462', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 3, 0.150000006);
INSERT INTO order_details VALUES ('6a63bd0c-86fe-4f29-a9b5-f5940726f462', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 20, 0.150000006);
INSERT INTO order_details VALUES ('7d44c8ca-5eb5-4bf8-bc40-6a7631940601', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 14, 0.0500000007);
INSERT INTO order_details VALUES ('7d44c8ca-5eb5-4bf8-bc40-6a7631940601', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 20, 0.0500000007);
INSERT INTO order_details VALUES ('624fb927-a272-4485-ada0-a1d166d486f9', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 10, 0);
INSERT INTO order_details VALUES ('624fb927-a272-4485-ada0-a1d166d486f9', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 3, 0);
INSERT INTO order_details VALUES ('624fb927-a272-4485-ada0-a1d166d486f9', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 15, 0);
INSERT INTO order_details VALUES ('a386f5ab-2198-4631-ae50-b9963b211ef9', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 14, 0);
INSERT INTO order_details VALUES ('a386f5ab-2198-4631-ae50-b9963b211ef9', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 8, 0);
INSERT INTO order_details VALUES ('c9756948-6159-427d-b818-f943a6138bbd', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 15, 0.200000003);
INSERT INTO order_details VALUES ('c9756948-6159-427d-b818-f943a6138bbd', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 6, 0.200000003);
INSERT INTO order_details VALUES ('0557ea9b-d473-4572-ba16-4c66bcc8e12c', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 65, 0);
INSERT INTO order_details VALUES ('0557ea9b-d473-4572-ba16-4c66bcc8e12c', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 35, 0.25);
INSERT INTO order_details VALUES ('dd176bb4-a96f-43c8-9185-9c7f736742da', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 21, 0.200000003);
INSERT INTO order_details VALUES ('dd176bb4-a96f-43c8-9185-9c7f736742da', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 10, 0);
INSERT INTO order_details VALUES ('dd176bb4-a96f-43c8-9185-9c7f736742da', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 35, 0.200000003);
INSERT INTO order_details VALUES ('dd176bb4-a96f-43c8-9185-9c7f736742da', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 24, 0.200000003);
INSERT INTO order_details VALUES ('3dd33108-f42b-46b2-82cc-289143379619', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 20, 0);
INSERT INTO order_details VALUES ('d6b92657-2628-4a46-ada4-d0b042bfd7a8', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 2, 0);
INSERT INTO order_details VALUES ('d6b92657-2628-4a46-ada4-d0b042bfd7a8', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 10, 0);
INSERT INTO order_details VALUES ('c7963cd8-fa69-4fb7-820f-c4fd3594840b', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 20, 0.150000006);
INSERT INTO order_details VALUES ('c7963cd8-fa69-4fb7-820f-c4fd3594840b', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 20, 0.150000006);
INSERT INTO order_details VALUES ('c7963cd8-fa69-4fb7-820f-c4fd3594840b', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 25, 0);
INSERT INTO order_details VALUES ('e8994e58-3810-4e64-8929-ca5e7ebf90b2', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 50, 0.100000001);
INSERT INTO order_details VALUES ('e8994e58-3810-4e64-8929-ca5e7ebf90b2', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 10, 0.100000001);
INSERT INTO order_details VALUES ('e8994e58-3810-4e64-8929-ca5e7ebf90b2', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 7, 0.100000001);
INSERT INTO order_details VALUES ('722e4ef9-6f72-422a-b8f7-0aaa6275b538', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 40, 0.25);
INSERT INTO order_details VALUES ('722e4ef9-6f72-422a-b8f7-0aaa6275b538', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 20, 0.25);
INSERT INTO order_details VALUES ('a4dc9fe0-5461-4183-b8a7-09b79a1ac8a4', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 25, 0.25);
INSERT INTO order_details VALUES ('a4dc9fe0-5461-4183-b8a7-09b79a1ac8a4', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 30, 0.25);
INSERT INTO order_details VALUES ('a4dc9fe0-5461-4183-b8a7-09b79a1ac8a4', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 60, 0.25);
INSERT INTO order_details VALUES ('a4dc9fe0-5461-4183-b8a7-09b79a1ac8a4', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 5, 0.25);
INSERT INTO order_details VALUES ('e634a111-cb39-42d6-8923-b22c948b02cf', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 24, 0.0500000007);
INSERT INTO order_details VALUES ('e634a111-cb39-42d6-8923-b22c948b02cf', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 15, 0.0500000007);
INSERT INTO order_details VALUES ('e634a111-cb39-42d6-8923-b22c948b02cf', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 15, 0.0500000007);
INSERT INTO order_details VALUES ('a1c241df-9eb0-405b-a925-0286a5fd3191', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 36, 0);
INSERT INTO order_details VALUES ('a1c241df-9eb0-405b-a925-0286a5fd3191', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 24, 0);
INSERT INTO order_details VALUES ('a1c241df-9eb0-405b-a925-0286a5fd3191', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 4, 0.150000006);
INSERT INTO order_details VALUES ('d03062e0-1642-447b-81b0-38c102405385', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 10, 0);
INSERT INTO order_details VALUES ('d03062e0-1642-447b-81b0-38c102405385', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 10, 0);
INSERT INTO order_details VALUES ('17eb0902-2e2c-497a-9aa2-252514f9c014', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 20, 0.25);
INSERT INTO order_details VALUES ('17eb0902-2e2c-497a-9aa2-252514f9c014', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 2, 0);
INSERT INTO order_details VALUES ('17eb0902-2e2c-497a-9aa2-252514f9c014', '35757ead-53a9-44f2-a023-f8950dd9eeac', 10, 15, 0.25);
INSERT INTO order_details VALUES ('c834341c-b29a-4411-ba71-f6dd6096ce09', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 1, 0);
INSERT INTO order_details VALUES ('fb7387df-2417-4f19-abf0-0784ee25309f', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 20, 0.150000006);
INSERT INTO order_details VALUES ('fb7387df-2417-4f19-abf0-0784ee25309f', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 50, 0.150000006);
INSERT INTO order_details VALUES ('ed04387c-26f1-43f3-bd5d-30450377242e', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 20, 0);
INSERT INTO order_details VALUES ('a3c6075a-34c7-48b9-ba30-04b666216183', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 7, 0);
INSERT INTO order_details VALUES ('a3c6075a-34c7-48b9-ba30-04b666216183', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 5, 0);
INSERT INTO order_details VALUES ('a3c6075a-34c7-48b9-ba30-04b666216183', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 5, 0);
INSERT INTO order_details VALUES ('eca2819f-96b2-4c5d-b1bf-47c6e014eaae', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 15, 0);
INSERT INTO order_details VALUES ('eca2819f-96b2-4c5d-b1bf-47c6e014eaae', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 18, 0);
INSERT INTO order_details VALUES ('eca2819f-96b2-4c5d-b1bf-47c6e014eaae', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 30, 0);
INSERT INTO order_details VALUES ('caaaf155-9f9c-4c26-a626-bd24c3356ae8', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 16, 0.100000001);
INSERT INTO order_details VALUES ('caaaf155-9f9c-4c26-a626-bd24c3356ae8', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 40, 0.100000001);
INSERT INTO order_details VALUES ('caaaf155-9f9c-4c26-a626-bd24c3356ae8', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 20, 0);
INSERT INTO order_details VALUES ('35aa565b-a083-452c-bd2a-fac5adcf88cb', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 12, 0.200000003);
INSERT INTO order_details VALUES ('35aa565b-a083-452c-bd2a-fac5adcf88cb', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 35, 0);
INSERT INTO order_details VALUES ('9295c0d9-9a6f-4e4a-985d-aaed58a2302f', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 20, 0);
INSERT INTO order_details VALUES ('9295c0d9-9a6f-4e4a-985d-aaed58a2302f', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 20, 0.150000006);
INSERT INTO order_details VALUES ('9295c0d9-9a6f-4e4a-985d-aaed58a2302f', 'd81d4aa0-e0af-41eb-9ba1-42e8ee9559ef', 12.75, 8, 0.150000006);
INSERT INTO order_details VALUES ('9295c0d9-9a6f-4e4a-985d-aaed58a2302f', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 30, 0.150000006);
INSERT INTO order_details VALUES ('097bb17c-6f94-49d9-b4fb-82770580d239', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 16, 0);
INSERT INTO order_details VALUES ('6a7b253a-6ef6-49f6-9c8f-6a499591609f', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 30, 0.0500000007);
INSERT INTO order_details VALUES ('6a7b253a-6ef6-49f6-9c8f-6a499591609f', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 20, 0.0500000007);
INSERT INTO order_details VALUES ('33a3a19d-7810-4a9b-a012-cf421c42aee3', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 40, 0.150000006);
INSERT INTO order_details VALUES ('33a3a19d-7810-4a9b-a012-cf421c42aee3', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 30, 0);
INSERT INTO order_details VALUES ('33a3a19d-7810-4a9b-a012-cf421c42aee3', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 60, 0.150000006);
INSERT INTO order_details VALUES ('33a3a19d-7810-4a9b-a012-cf421c42aee3', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 25, 0.150000006);
INSERT INTO order_details VALUES ('2142373d-16d2-4b1c-b8e1-de7540c650ba', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 20, 0);
INSERT INTO order_details VALUES ('2142373d-16d2-4b1c-b8e1-de7540c650ba', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 20, 0);
INSERT INTO order_details VALUES ('a9665abc-542b-4df1-a208-bd29ec4b2601', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 7, 0);
INSERT INTO order_details VALUES ('a9665abc-542b-4df1-a208-bd29ec4b2601', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 20, 0);
INSERT INTO order_details VALUES ('0cbf1607-3344-4af8-9c16-cc2ccb2f4cff', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 30, 0);
INSERT INTO order_details VALUES ('8a17abb7-4df5-4d94-a9b6-96d66b231b78', '61f41763-1ece-4378-810f-0a866a077be5', 18, 20, 0);
INSERT INTO order_details VALUES ('8a17abb7-4df5-4d94-a9b6-96d66b231b78', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 6, 0);
INSERT INTO order_details VALUES ('765bbd7a-20ca-4a32-af0b-b819df3892af', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 3, 0);
INSERT INTO order_details VALUES ('765bbd7a-20ca-4a32-af0b-b819df3892af', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 6, 0);
INSERT INTO order_details VALUES ('430d7036-5907-4f42-92b1-872cd2c466ef', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 20, 0.100000001);
INSERT INTO order_details VALUES ('430d7036-5907-4f42-92b1-872cd2c466ef', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 15, 0);
INSERT INTO order_details VALUES ('430d7036-5907-4f42-92b1-872cd2c466ef', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 40, 0.100000001);
INSERT INTO order_details VALUES ('430d7036-5907-4f42-92b1-872cd2c466ef', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 15, 0.100000001);
INSERT INTO order_details VALUES ('bf5e936d-75d7-40d5-a6df-cb3e68d3a4f3', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 12, 0);
INSERT INTO order_details VALUES ('bf5e936d-75d7-40d5-a6df-cb3e68d3a4f3', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 9, 0);
INSERT INTO order_details VALUES ('e64721e0-4432-441c-89d9-c81e7a8053f9', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 12, 0);
INSERT INTO order_details VALUES ('e64721e0-4432-441c-89d9-c81e7a8053f9', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 20, 0);
INSERT INTO order_details VALUES ('bb741d9b-3434-414f-97d1-e1e1447d7296', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 35, 0);
INSERT INTO order_details VALUES ('bb741d9b-3434-414f-97d1-e1e1447d7296', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 15, 0);
INSERT INTO order_details VALUES ('0f9fc20b-5316-4631-ae90-ff629871519a', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 15, 0);
INSERT INTO order_details VALUES ('0f9fc20b-5316-4631-ae90-ff629871519a', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 21, 0);
INSERT INTO order_details VALUES ('5137d5fb-11d3-4bf4-99d8-769f95553b78', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 5, 0);
INSERT INTO order_details VALUES ('5137d5fb-11d3-4bf4-99d8-769f95553b78', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 2, 0);
INSERT INTO order_details VALUES ('8528a6e3-d599-4c94-a683-c8ffaeb5e10c', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 10, 0);
INSERT INTO order_details VALUES ('8528a6e3-d599-4c94-a683-c8ffaeb5e10c', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 20, 0);
INSERT INTO order_details VALUES ('8528a6e3-d599-4c94-a683-c8ffaeb5e10c', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 10, 0);
INSERT INTO order_details VALUES ('8528a6e3-d599-4c94-a683-c8ffaeb5e10c', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 21, 0);
INSERT INTO order_details VALUES ('007b3123-0a13-4ea9-ac4d-befc0e91fdf8', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 6, 0);
INSERT INTO order_details VALUES ('007b3123-0a13-4ea9-ac4d-befc0e91fdf8', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 28, 0);
INSERT INTO order_details VALUES ('007b3123-0a13-4ea9-ac4d-befc0e91fdf8', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 30, 0);
INSERT INTO order_details VALUES ('007b3123-0a13-4ea9-ac4d-befc0e91fdf8', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 24, 0);
INSERT INTO order_details VALUES ('1bff3c4f-b584-42aa-b9b8-86786b86e895', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 2, 0);
INSERT INTO order_details VALUES ('1bff3c4f-b584-42aa-b9b8-86786b86e895', '61f41763-1ece-4378-810f-0a866a077be5', 18, 8, 0);
INSERT INTO order_details VALUES ('1bff3c4f-b584-42aa-b9b8-86786b86e895', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 8, 0);
INSERT INTO order_details VALUES ('1bff3c4f-b584-42aa-b9b8-86786b86e895', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 9, 0);
INSERT INTO order_details VALUES ('47e385ce-4ff8-4d93-9fdc-b0577438d3b3', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 3, 0.200000003);
INSERT INTO order_details VALUES ('47e385ce-4ff8-4d93-9fdc-b0577438d3b3', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 10, 0.200000003);
INSERT INTO order_details VALUES ('47e385ce-4ff8-4d93-9fdc-b0577438d3b3', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 16, 0.200000003);
INSERT INTO order_details VALUES ('47e385ce-4ff8-4d93-9fdc-b0577438d3b3', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 3, 0);
INSERT INTO order_details VALUES ('89f2c1dd-a93a-4c77-ad5a-bd4198e7c1c1', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 20, 0.100000001);
INSERT INTO order_details VALUES ('89f2c1dd-a93a-4c77-ad5a-bd4198e7c1c1', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 9, 0.100000001);
INSERT INTO order_details VALUES ('89f2c1dd-a93a-4c77-ad5a-bd4198e7c1c1', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 9, 0.100000001);
INSERT INTO order_details VALUES ('774d1368-edf3-4d36-86a8-64c06a1caf5b', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 8, 0.0500000007);
INSERT INTO order_details VALUES ('774d1368-edf3-4d36-86a8-64c06a1caf5b', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 20, 0.0500000007);
INSERT INTO order_details VALUES ('484c6a5e-28bc-4316-a7ee-e58d820902e8', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 15, 0);
INSERT INTO order_details VALUES ('484c6a5e-28bc-4316-a7ee-e58d820902e8', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 2, 0.200000003);
INSERT INTO order_details VALUES ('2ea59e2e-8146-4bba-a290-46248849ed17', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 52, 0);
INSERT INTO order_details VALUES ('2ea59e2e-8146-4bba-a290-46248849ed17', '61f41763-1ece-4378-810f-0a866a077be5', 18, 6, 0);
INSERT INTO order_details VALUES ('2ea59e2e-8146-4bba-a290-46248849ed17', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 24, 0);
INSERT INTO order_details VALUES ('2ea59e2e-8146-4bba-a290-46248849ed17', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 60, 0);
INSERT INTO order_details VALUES ('2ea59e2e-8146-4bba-a290-46248849ed17', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 30, 0);
INSERT INTO order_details VALUES ('0d0dc247-5fd7-4c37-9fed-f5eb30d6fb88', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 6, 0);
INSERT INTO order_details VALUES ('0d0dc247-5fd7-4c37-9fed-f5eb30d6fb88', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 25, 0);
INSERT INTO order_details VALUES ('0d0dc247-5fd7-4c37-9fed-f5eb30d6fb88', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 40, 0.25);
INSERT INTO order_details VALUES ('0d0dc247-5fd7-4c37-9fed-f5eb30d6fb88', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 21, 0.25);
INSERT INTO order_details VALUES ('0dc9dc3c-6b4a-422f-8820-a5cf7e166065', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 4, 0.25);
INSERT INTO order_details VALUES ('0dc9dc3c-6b4a-422f-8820-a5cf7e166065', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 25, 0.25);
INSERT INTO order_details VALUES ('0dc9dc3c-6b4a-422f-8820-a5cf7e166065', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 50, 0.25);
INSERT INTO order_details VALUES ('3c6d5552-82ce-4548-9e52-cbb45e890d21', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 30, 0.100000001);
INSERT INTO order_details VALUES ('3c6d5552-82ce-4548-9e52-cbb45e890d21', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 15, 0.100000001);
INSERT INTO order_details VALUES ('b73030f2-2b9c-4381-a965-57eecb71aa6d', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 6, 0.200000003);
INSERT INTO order_details VALUES ('b73030f2-2b9c-4381-a965-57eecb71aa6d', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 10, 0.200000003);
INSERT INTO order_details VALUES ('90eeddca-29aa-4cbf-9b43-b424f801b32f', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 16, 0);
INSERT INTO order_details VALUES ('90eeddca-29aa-4cbf-9b43-b424f801b32f', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 30, 0);
INSERT INTO order_details VALUES ('90eeddca-29aa-4cbf-9b43-b424f801b32f', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 50, 0);
INSERT INTO order_details VALUES ('90eeddca-29aa-4cbf-9b43-b424f801b32f', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 15, 0);
INSERT INTO order_details VALUES ('eb0332d0-7266-41d6-8f07-97237dce5c77', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 15, 0);
INSERT INTO order_details VALUES ('eb0332d0-7266-41d6-8f07-97237dce5c77', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 5, 0);
INSERT INTO order_details VALUES ('eb0332d0-7266-41d6-8f07-97237dce5c77', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 20, 0);
INSERT INTO order_details VALUES ('eb0332d0-7266-41d6-8f07-97237dce5c77', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 12, 0);
INSERT INTO order_details VALUES ('8350d94f-8bb4-41af-98fa-332b5d376a3b', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 4, 0.25);
INSERT INTO order_details VALUES ('d22d3a10-26f4-4878-9211-e00248490f29', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 35, 0);
INSERT INTO order_details VALUES ('b80ab9db-33a5-4ef3-9fe4-8a2f5e484cf5', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 70, 0.100000001);
INSERT INTO order_details VALUES ('b80ab9db-33a5-4ef3-9fe4-8a2f5e484cf5', '61f41763-1ece-4378-810f-0a866a077be5', 18, 25, 0.100000001);
INSERT INTO order_details VALUES ('b80ab9db-33a5-4ef3-9fe4-8a2f5e484cf5', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 42, 0.100000001);
INSERT INTO order_details VALUES ('b80ab9db-33a5-4ef3-9fe4-8a2f5e484cf5', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 60, 0.100000001);
INSERT INTO order_details VALUES ('b80ab9db-33a5-4ef3-9fe4-8a2f5e484cf5', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 48, 0);
INSERT INTO order_details VALUES ('7fd63df0-27c3-43de-89b5-08dc697b5bb6', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 21, 0);
INSERT INTO order_details VALUES ('7fd63df0-27c3-43de-89b5-08dc697b5bb6', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 30, 0);
INSERT INTO order_details VALUES ('7fd63df0-27c3-43de-89b5-08dc697b5bb6', '35757ead-53a9-44f2-a023-f8950dd9eeac', 10, 20, 0);
INSERT INTO order_details VALUES ('afba7131-d40c-465b-99d1-c84af55110c2', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 80, 0.200000003);
INSERT INTO order_details VALUES ('afba7131-d40c-465b-99d1-c84af55110c2', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 12, 0.200000003);
INSERT INTO order_details VALUES ('afba7131-d40c-465b-99d1-c84af55110c2', '8ad0f836-43df-42d9-a992-e1fee45d28d8', 26, 60, 0.200000003);
INSERT INTO order_details VALUES ('afba7131-d40c-465b-99d1-c84af55110c2', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 36, 0.200000003);
INSERT INTO order_details VALUES ('afba7131-d40c-465b-99d1-c84af55110c2', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 45, 0.200000003);
INSERT INTO order_details VALUES ('afba7131-d40c-465b-99d1-c84af55110c2', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 55, 0.200000003);
INSERT INTO order_details VALUES ('fa098240-525c-408c-b533-5fb0937faffb', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 21.3500004, 30, 0);
INSERT INTO order_details VALUES ('fa098240-525c-408c-b533-5fb0937faffb', 'af59c8a6-47cb-48a5-888b-b4f1f195656e', 97, 3, 0);
INSERT INTO order_details VALUES ('068a3a0b-bcaf-44b7-88f0-e31631fa2a90', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 10, 49, 0);
INSERT INTO order_details VALUES ('068a3a0b-bcaf-44b7-88f0-e31631fa2a90', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 18, 0.150000006);
INSERT INTO order_details VALUES ('5207440f-406c-4335-9b4e-5deb69f5458b', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 20, 0.150000006);
INSERT INTO order_details VALUES ('5207440f-406c-4335-9b4e-5deb69f5458b', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 4, 0.150000006);
INSERT INTO order_details VALUES ('5207440f-406c-4335-9b4e-5deb69f5458b', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 30, 0.150000006);
INSERT INTO order_details VALUES ('8ea6435a-4dfd-40b7-87c8-940f31c7f4b4', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 5, 0.0500000007);
INSERT INTO order_details VALUES ('8ea6435a-4dfd-40b7-87c8-940f31c7f4b4', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 10, 0.0500000007);
INSERT INTO order_details VALUES ('8ea6435a-4dfd-40b7-87c8-940f31c7f4b4', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 10, 0.0500000007);
INSERT INTO order_details VALUES ('8ea6435a-4dfd-40b7-87c8-940f31c7f4b4', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 42, 0.0500000007);
INSERT INTO order_details VALUES ('c55d40fc-5636-4788-b138-6024161e58ba', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 15, 0);
INSERT INTO order_details VALUES ('c55d40fc-5636-4788-b138-6024161e58ba', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 6, 0);
INSERT INTO order_details VALUES ('c55d40fc-5636-4788-b138-6024161e58ba', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 50, 0);
INSERT INTO order_details VALUES ('b3f09d80-c91e-4f4c-869a-94bd53fa1258', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 10, 0);
INSERT INTO order_details VALUES ('5690c08a-3ddf-4c67-9b06-3b07b9c5447a', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 100, 0.150000006);
INSERT INTO order_details VALUES ('5690c08a-3ddf-4c67-9b06-3b07b9c5447a', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 65, 0.150000006);
INSERT INTO order_details VALUES ('3374c2a2-1a7e-474f-bf11-9670b9995c91', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 50, 0);
INSERT INTO order_details VALUES ('3374c2a2-1a7e-474f-bf11-9670b9995c91', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 14, 0);
INSERT INTO order_details VALUES ('3374c2a2-1a7e-474f-bf11-9670b9995c91', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 24, 0);
INSERT INTO order_details VALUES ('3374c2a2-1a7e-474f-bf11-9670b9995c91', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 15, 0.150000006);
INSERT INTO order_details VALUES ('e5fe1c9a-5fbe-4062-81de-8d4def6b63a0', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 20, 0);
INSERT INTO order_details VALUES ('e5fe1c9a-5fbe-4062-81de-8d4def6b63a0', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 20, 0);
INSERT INTO order_details VALUES ('5dd100cd-fbef-4fca-bc25-5131aea917b9', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 10, 30, 0);
INSERT INTO order_details VALUES ('5dd100cd-fbef-4fca-bc25-5131aea917b9', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 35, 0.25);
INSERT INTO order_details VALUES ('5dd100cd-fbef-4fca-bc25-5131aea917b9', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 10, 0.25);
INSERT INTO order_details VALUES ('aea8fae3-73ba-4636-8576-9efc4146e6f7', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 5, 0);
INSERT INTO order_details VALUES ('aea8fae3-73ba-4636-8576-9efc4146e6f7', '53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 43.9000015, 10, 0);
INSERT INTO order_details VALUES ('aea8fae3-73ba-4636-8576-9efc4146e6f7', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 4, 0);
INSERT INTO order_details VALUES ('88b7ce15-c6e6-4a90-b41f-208c46ca50a2', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 40, 0.25);
INSERT INTO order_details VALUES ('88b7ce15-c6e6-4a90-b41f-208c46ca50a2', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 35, 0.25);
INSERT INTO order_details VALUES ('88b7ce15-c6e6-4a90-b41f-208c46ca50a2', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 30, 0.25);
INSERT INTO order_details VALUES ('02a7d49b-2819-4e8f-bc1c-800a398203f5', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 3, 0);
INSERT INTO order_details VALUES ('02a7d49b-2819-4e8f-bc1c-800a398203f5', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 20, 0);
INSERT INTO order_details VALUES ('90ac4d8a-9982-49e9-ab4c-4d80eef2db87', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 42, 0);
INSERT INTO order_details VALUES ('90ac4d8a-9982-49e9-ab4c-4d80eef2db87', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 20, 0);
INSERT INTO order_details VALUES ('90ac4d8a-9982-49e9-ab4c-4d80eef2db87', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 40, 0);
INSERT INTO order_details VALUES ('90ac4d8a-9982-49e9-ab4c-4d80eef2db87', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 35, 0);
INSERT INTO order_details VALUES ('90ac4d8a-9982-49e9-ab4c-4d80eef2db87', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 3, 0);
INSERT INTO order_details VALUES ('e784d99a-e614-40ea-a08e-1a7774802df9', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 25, 0);
INSERT INTO order_details VALUES ('e784d99a-e614-40ea-a08e-1a7774802df9', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 8, 0);
INSERT INTO order_details VALUES ('f174d9ba-402f-4bcf-bfc3-0236424ec6ad', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 20, 0.150000006);
INSERT INTO order_details VALUES ('f174d9ba-402f-4bcf-bfc3-0236424ec6ad', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 12, 0.150000006);
INSERT INTO order_details VALUES ('d9b3bdc0-7ba8-4f30-a1ee-66618564c830', '61f41763-1ece-4378-810f-0a866a077be5', 18, 4, 0);
INSERT INTO order_details VALUES ('d9b3bdc0-7ba8-4f30-a1ee-66618564c830', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 14, 15, 0);
INSERT INTO order_details VALUES ('538bba86-01f4-4197-896d-ed093984615b', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 60, 0.0500000007);
INSERT INTO order_details VALUES ('538bba86-01f4-4197-896d-ed093984615b', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 80, 0.0500000007);
INSERT INTO order_details VALUES ('30805c35-be47-4a08-8b17-3947d289b91f', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 21, 0.25);
INSERT INTO order_details VALUES ('30805c35-be47-4a08-8b17-3947d289b91f', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 6, 0.25);
INSERT INTO order_details VALUES ('30805c35-be47-4a08-8b17-3947d289b91f', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 40, 0.25);
INSERT INTO order_details VALUES ('76517fbd-b30e-4bdd-a236-db571480d941', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 3, 0);
INSERT INTO order_details VALUES ('bf60fe95-2b27-49c4-b506-b546cd795c4f', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 20, 0);
INSERT INTO order_details VALUES ('bf60fe95-2b27-49c4-b506-b546cd795c4f', '61f41763-1ece-4378-810f-0a866a077be5', 18, 30, 0);
INSERT INTO order_details VALUES ('bf60fe95-2b27-49c4-b506-b546cd795c4f', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 42, 0.100000001);
INSERT INTO order_details VALUES ('e8cd14ae-b5a3-4967-a7bd-d7508a84a906', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 40, 0);
INSERT INTO order_details VALUES ('e8cd14ae-b5a3-4967-a7bd-d7508a84a906', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 10, 0);
INSERT INTO order_details VALUES ('e8cd14ae-b5a3-4967-a7bd-d7508a84a906', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 50, 0);
INSERT INTO order_details VALUES ('e8cd14ae-b5a3-4967-a7bd-d7508a84a906', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 20, 0);
INSERT INTO order_details VALUES ('d6d98a84-1f00-4339-8682-86b984308b2f', '61f41763-1ece-4378-810f-0a866a077be5', 18, 3, 0);
INSERT INTO order_details VALUES ('d6d98a84-1f00-4339-8682-86b984308b2f', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 2, 0);
INSERT INTO order_details VALUES ('75295ae0-6793-4620-9224-563ffe63600c', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 50, 0.0500000007);
INSERT INTO order_details VALUES ('75295ae0-6793-4620-9224-563ffe63600c', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 12, 0.0500000007);
INSERT INTO order_details VALUES ('75295ae0-6793-4620-9224-563ffe63600c', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 16, 0.0500000007);
INSERT INTO order_details VALUES ('f1d79f4c-81b6-4fcf-8937-9b439eaaee6a', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 10, 0.0500000007);
INSERT INTO order_details VALUES ('f1d79f4c-81b6-4fcf-8937-9b439eaaee6a', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 20, 0.0500000007);
INSERT INTO order_details VALUES ('f1d79f4c-81b6-4fcf-8937-9b439eaaee6a', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 15, 0.0500000007);
INSERT INTO order_details VALUES ('f1d79f4c-81b6-4fcf-8937-9b439eaaee6a', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 21, 0.0500000007);
INSERT INTO order_details VALUES ('d9723f6f-82d3-4486-bae5-5f9e32d393dc', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 20, 0);
INSERT INTO order_details VALUES ('d9723f6f-82d3-4486-bae5-5f9e32d393dc', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 3, 0);
INSERT INTO order_details VALUES ('d2447efc-50b5-4b4e-a199-e9d8c9404327', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 10, 0);
INSERT INTO order_details VALUES ('86871c8c-9cff-43df-85fc-114f0efd9785', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 25, 0);
INSERT INTO order_details VALUES ('86871c8c-9cff-43df-85fc-114f0efd9785', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 21, 0.100000001);
INSERT INTO order_details VALUES ('86871c8c-9cff-43df-85fc-114f0efd9785', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 15, 0);
INSERT INTO order_details VALUES ('8c26f7f8-f3e9-4764-addc-b21a77b87a26', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 21, 0);
INSERT INTO order_details VALUES ('8c26f7f8-f3e9-4764-addc-b21a77b87a26', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 20, 0);
INSERT INTO order_details VALUES ('51ca79e2-10f2-4f8e-81f0-82b1cca2e0f0', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 30, 0.25);
INSERT INTO order_details VALUES ('51ca79e2-10f2-4f8e-81f0-82b1cca2e0f0', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 25, 0);
INSERT INTO order_details VALUES ('ff1667df-029e-4a77-b4ed-a6bfefdf4122', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 20, 0.0500000007);
INSERT INTO order_details VALUES ('0e5bdb8c-375e-40a1-9a56-198fa9f8b07e', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 12, 0);
INSERT INTO order_details VALUES ('0e5bdb8c-375e-40a1-9a56-198fa9f8b07e', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 10, 0);
INSERT INTO order_details VALUES ('0e5bdb8c-375e-40a1-9a56-198fa9f8b07e', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 10, 0);
INSERT INTO order_details VALUES ('c552d249-e671-4eb2-8476-4e1139a23bed', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 30, 0.200000003);
INSERT INTO order_details VALUES ('c552d249-e671-4eb2-8476-4e1139a23bed', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 30, 0.200000003);
INSERT INTO order_details VALUES ('c552d249-e671-4eb2-8476-4e1139a23bed', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 50, 0.200000003);
INSERT INTO order_details VALUES ('dd45dbbc-9ee1-4daf-bbd3-74a5621e257b', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 10, 0);
INSERT INTO order_details VALUES ('5828fcb1-9d7c-4567-8180-34253d89c29c', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 25, 0);
INSERT INTO order_details VALUES ('5828fcb1-9d7c-4567-8180-34253d89c29c', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 20, 0.150000006);
INSERT INTO order_details VALUES ('5828fcb1-9d7c-4567-8180-34253d89c29c', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 32, 0.150000006);
INSERT INTO order_details VALUES ('ce7086ff-1acc-4e7c-8787-39d441a110fb', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 8, 0);
INSERT INTO order_details VALUES ('e46df30a-8098-4cf2-b15f-f4e3e58f9121', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 40, 0.0500000007);
INSERT INTO order_details VALUES ('e46df30a-8098-4cf2-b15f-f4e3e58f9121', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 21, 0.0500000007);
INSERT INTO order_details VALUES ('e46df30a-8098-4cf2-b15f-f4e3e58f9121', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 12, 0.0500000007);
INSERT INTO order_details VALUES ('8be79674-6e6d-41c3-933d-41486f1cd2f5', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 20, 0);
INSERT INTO order_details VALUES ('8be79674-6e6d-41c3-933d-41486f1cd2f5', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 12, 0);
INSERT INTO order_details VALUES ('8be79674-6e6d-41c3-933d-41486f1cd2f5', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 30, 0);
INSERT INTO order_details VALUES ('8be79674-6e6d-41c3-933d-41486f1cd2f5', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 25, 0);
INSERT INTO order_details VALUES ('82840cdb-27b9-4e4b-85bf-fb92cd532a1f', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 70, 0);
INSERT INTO order_details VALUES ('82840cdb-27b9-4e4b-85bf-fb92cd532a1f', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 35, 0);
INSERT INTO order_details VALUES ('82840cdb-27b9-4e4b-85bf-fb92cd532a1f', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 40, 0);
INSERT INTO order_details VALUES ('c897a3c8-6431-420f-8b42-e2d3789d94a0', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 5, 0);
INSERT INTO order_details VALUES ('563f6dca-dffb-4180-9d13-b697eaf99e14', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 20, 0);
INSERT INTO order_details VALUES ('563f6dca-dffb-4180-9d13-b697eaf99e14', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 18, 0);
INSERT INTO order_details VALUES ('81ffc4cf-7f8b-4336-b232-bb68d7471f4f', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 40, 0);
INSERT INTO order_details VALUES ('81ffc4cf-7f8b-4336-b232-bb68d7471f4f', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 40, 0);
INSERT INTO order_details VALUES ('d50f45a4-84d8-47b6-a03b-43a8b983d115', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 15, 0);
INSERT INTO order_details VALUES ('d50f45a4-84d8-47b6-a03b-43a8b983d115', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 10, 0);
INSERT INTO order_details VALUES ('d50f45a4-84d8-47b6-a03b-43a8b983d115', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 14, 0);
INSERT INTO order_details VALUES ('77eb7698-fc10-48d5-950a-215cc327b407', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 15, 0.0500000007);
INSERT INTO order_details VALUES ('1a6637d3-7396-4f29-b222-551b7ae55144', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 40, 0.0500000007);
INSERT INTO order_details VALUES ('072a86e6-4833-4de7-9dbb-77797157ba0c', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 30, 0);
INSERT INTO order_details VALUES ('072a86e6-4833-4de7-9dbb-77797157ba0c', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 10, 0);
INSERT INTO order_details VALUES ('072a86e6-4833-4de7-9dbb-77797157ba0c', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 24, 0);
INSERT INTO order_details VALUES ('072a86e6-4833-4de7-9dbb-77797157ba0c', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 35, 0);
INSERT INTO order_details VALUES ('072a86e6-4833-4de7-9dbb-77797157ba0c', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 20, 0);
INSERT INTO order_details VALUES ('96aa4e3d-3581-4fdd-b7ba-0fc075e12301', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 28, 0.0500000007);
INSERT INTO order_details VALUES ('96aa4e3d-3581-4fdd-b7ba-0fc075e12301', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 50, 0.0500000007);
INSERT INTO order_details VALUES ('96aa4e3d-3581-4fdd-b7ba-0fc075e12301', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 120, 0.0500000007);
INSERT INTO order_details VALUES ('81c27e3e-5418-47ea-a507-05bbaeea3b78', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 110, 0);
INSERT INTO order_details VALUES ('81c27e3e-5418-47ea-a507-05bbaeea3b78', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 45, 0);
INSERT INTO order_details VALUES ('81c27e3e-5418-47ea-a507-05bbaeea3b78', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 91, 0);
INSERT INTO order_details VALUES ('81c27e3e-5418-47ea-a507-05bbaeea3b78', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 100, 0);
INSERT INTO order_details VALUES ('54d14c74-97f8-46cb-831a-c6fd939a5ba9', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 15, 0);
INSERT INTO order_details VALUES ('54d14c74-97f8-46cb-831a-c6fd939a5ba9', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 16, 0);
INSERT INTO order_details VALUES ('f5639171-b645-4bb9-99b0-6a165376722b', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 80, 0);
INSERT INTO order_details VALUES ('f5639171-b645-4bb9-99b0-6a165376722b', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 36, 0);
INSERT INTO order_details VALUES ('1b622dcc-ff07-4ec7-a4b0-e8b45bd507c4', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 5, 0);
INSERT INTO order_details VALUES ('e2805cc5-a3a7-43c6-a370-7b1081004147', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 8, 0.150000006);
INSERT INTO order_details VALUES ('720e1b66-b879-479b-8de3-d3fff89c948c', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 3, 0.25);
INSERT INTO order_details VALUES ('8a033b35-234a-43e1-a451-6cdec5849bbc', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 30, 0);
INSERT INTO order_details VALUES ('8a033b35-234a-43e1-a451-6cdec5849bbc', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 30, 0);
INSERT INTO order_details VALUES ('97e04f8a-dcd8-40c7-9ebb-26907d8979b5', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 30, 0.150000006);
INSERT INTO order_details VALUES ('97e04f8a-dcd8-40c7-9ebb-26907d8979b5', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 6, 0.150000006);
INSERT INTO order_details VALUES ('076d0aca-4cfe-48da-99ab-008932b4dbac', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 40, 0);
INSERT INTO order_details VALUES ('076d0aca-4cfe-48da-99ab-008932b4dbac', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 21, 0);
INSERT INTO order_details VALUES ('076d0aca-4cfe-48da-99ab-008932b4dbac', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 20, 0);
INSERT INTO order_details VALUES ('91c20b9c-889a-44d0-aa38-c0dcff931073', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 15, 0);
INSERT INTO order_details VALUES ('91c20b9c-889a-44d0-aa38-c0dcff931073', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 35, 0);
INSERT INTO order_details VALUES ('ecc1d718-8943-4ec2-9afc-aa71e65e9ba5', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 20, 0.0500000007);
INSERT INTO order_details VALUES ('19b581f2-2ad9-4d4d-81c6-13cb929c8226', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 15, 0);
INSERT INTO order_details VALUES ('d04cc93b-d98f-4f3f-b77b-5c25956d7b4d', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 14, 0);
INSERT INTO order_details VALUES ('0177bc6e-8ef7-4de5-9ccd-9ee949085281', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 20, 0.0500000007);
INSERT INTO order_details VALUES ('0177bc6e-8ef7-4de5-9ccd-9ee949085281', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 14, 0.0500000007);
INSERT INTO order_details VALUES ('59b38930-2302-489d-ae2e-7f1796f90019', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 12, 0);
INSERT INTO order_details VALUES ('59b38930-2302-489d-ae2e-7f1796f90019', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 15, 0);
INSERT INTO order_details VALUES ('59b38930-2302-489d-ae2e-7f1796f90019', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 5, 0);
INSERT INTO order_details VALUES ('3ae2bca6-ce74-4bed-8e65-261ae6803f2f', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 12, 0);
INSERT INTO order_details VALUES ('3ae2bca6-ce74-4bed-8e65-261ae6803f2f', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 10, 0);
INSERT INTO order_details VALUES ('3ae2bca6-ce74-4bed-8e65-261ae6803f2f', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 5, 0);
INSERT INTO order_details VALUES ('4a944548-da0e-4403-991c-51f08ec84c80', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 10, 0);
INSERT INTO order_details VALUES ('4a944548-da0e-4403-991c-51f08ec84c80', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 12, 0);
INSERT INTO order_details VALUES ('4a944548-da0e-4403-991c-51f08ec84c80', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 14, 15, 0);
INSERT INTO order_details VALUES ('d41c5f04-7c79-4405-99db-3162c9f071af', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 40, 0.25);
INSERT INTO order_details VALUES ('d41c5f04-7c79-4405-99db-3162c9f071af', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 60, 0.25);
INSERT INTO order_details VALUES ('8302ae44-c35b-42cf-a59a-4872d97d7478', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 30, 0.25);
INSERT INTO order_details VALUES ('8302ae44-c35b-42cf-a59a-4872d97d7478', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 40, 0.25);
INSERT INTO order_details VALUES ('8302ae44-c35b-42cf-a59a-4872d97d7478', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 15, 0);
INSERT INTO order_details VALUES ('e9585766-812d-439e-9a95-e4bb1035b6f9', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 25, 0);
INSERT INTO order_details VALUES ('c91e1d68-f36a-4074-8a97-f7b3f4c09a6b', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 10, 0);
INSERT INTO order_details VALUES ('c91e1d68-f36a-4074-8a97-f7b3f4c09a6b', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 30, 0);
INSERT INTO order_details VALUES ('c91e1d68-f36a-4074-8a97-f7b3f4c09a6b', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 10, 0);
INSERT INTO order_details VALUES ('4f55aab8-7a3e-49d8-8cc2-9b7e2d7f98e9', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 6, 0);
INSERT INTO order_details VALUES ('4f55aab8-7a3e-49d8-8cc2-9b7e2d7f98e9', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 6, 0);
INSERT INTO order_details VALUES ('4f55aab8-7a3e-49d8-8cc2-9b7e2d7f98e9', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 20, 0);
INSERT INTO order_details VALUES ('ac29f94d-b378-4884-ad26-6be093910bde', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 1, 0);
INSERT INTO order_details VALUES ('ac29f94d-b378-4884-ad26-6be093910bde', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 10, 0);
INSERT INTO order_details VALUES ('49332e64-68f9-4db3-a0ee-0f85835298dc', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 60, 0.25);
INSERT INTO order_details VALUES ('49332e64-68f9-4db3-a0ee-0f85835298dc', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 25, 0.25);
INSERT INTO order_details VALUES ('c282cc10-221f-48cf-ba89-12d6637c8726', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 24, 0);
INSERT INTO order_details VALUES ('c282cc10-221f-48cf-ba89-12d6637c8726', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 24, 0);
INSERT INTO order_details VALUES ('c282cc10-221f-48cf-ba89-12d6637c8726', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 20, 0);
INSERT INTO order_details VALUES ('8c4e0478-54a0-4461-88c1-c8a48b685e7c', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 16.25, 24, 0);
INSERT INTO order_details VALUES ('a07e1f37-0c60-4b53-b09f-a3e6d712bc5a', '61f41763-1ece-4378-810f-0a866a077be5', 18, 10, 0);
INSERT INTO order_details VALUES ('a07e1f37-0c60-4b53-b09f-a3e6d712bc5a', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 40, 0);
INSERT INTO order_details VALUES ('68f29764-4f55-482d-ad62-712ba7c7f70d', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 15, 0);
INSERT INTO order_details VALUES ('68f29764-4f55-482d-ad62-712ba7c7f70d', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 35, 0);
INSERT INTO order_details VALUES ('4e39eded-1e93-4af9-8a59-4dcf3679cdbf', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 10, 0.200000003);
INSERT INTO order_details VALUES ('4e39eded-1e93-4af9-8a59-4dcf3679cdbf', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 10, 0.200000003);
INSERT INTO order_details VALUES ('4e39eded-1e93-4af9-8a59-4dcf3679cdbf', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 14, 24, 0.200000003);
INSERT INTO order_details VALUES ('c5baa91c-2db9-48cb-81e4-b3a2fbde62fc', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 20, 0.100000001);
INSERT INTO order_details VALUES ('c5baa91c-2db9-48cb-81e4-b3a2fbde62fc', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 30, 0.100000001);
INSERT INTO order_details VALUES ('c5baa91c-2db9-48cb-81e4-b3a2fbde62fc', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 6, 0);
INSERT INTO order_details VALUES ('44998283-adeb-459f-ad02-c68c3f209838', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 25, 0.150000006);
INSERT INTO order_details VALUES ('44998283-adeb-459f-ad02-c68c3f209838', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 12, 0.150000006);
INSERT INTO order_details VALUES ('6a89e00b-2b62-495c-9785-222e4311b888', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 2, 0);
INSERT INTO order_details VALUES ('6a89e00b-2b62-495c-9785-222e4311b888', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 10, 0);
INSERT INTO order_details VALUES ('6a89e00b-2b62-495c-9785-222e4311b888', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 7, 0);
INSERT INTO order_details VALUES ('6a89e00b-2b62-495c-9785-222e4311b888', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 10, 0);
INSERT INTO order_details VALUES ('6c0027dc-22d6-419e-9143-ce1a4b2e5d9d', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 5, 0);
INSERT INTO order_details VALUES ('6c0027dc-22d6-419e-9143-ce1a4b2e5d9d', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 5, 0);
INSERT INTO order_details VALUES ('6c0027dc-22d6-419e-9143-ce1a4b2e5d9d', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 20, 0);
INSERT INTO order_details VALUES ('0002ac81-f37c-4889-9509-c3514e1a0704', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 5, 0);
INSERT INTO order_details VALUES ('0002ac81-f37c-4889-9509-c3514e1a0704', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 5, 0);
INSERT INTO order_details VALUES ('e245cb67-7b6d-4309-ab60-a4e64e35bcd9', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 60, 0);
INSERT INTO order_details VALUES ('e245cb67-7b6d-4309-ab60-a4e64e35bcd9', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 49, 0);
INSERT INTO order_details VALUES ('e245cb67-7b6d-4309-ab60-a4e64e35bcd9', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 15, 0);
INSERT INTO order_details VALUES ('61d21626-1398-426b-ab68-86a85ec6dfa7', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 36, 0);
INSERT INTO order_details VALUES ('61d21626-1398-426b-ab68-86a85ec6dfa7', '53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 43.9000015, 25, 0);
INSERT INTO order_details VALUES ('61d21626-1398-426b-ab68-86a85ec6dfa7', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 25, 0.200000003);
INSERT INTO order_details VALUES ('61d21626-1398-426b-ab68-86a85ec6dfa7', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 30, 0.200000003);
INSERT INTO order_details VALUES ('bc81121d-263e-41c9-969a-bcd731035b4e', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 42, 0.150000006);
INSERT INTO order_details VALUES ('bc81121d-263e-41c9-969a-bcd731035b4e', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 30, 0);
INSERT INTO order_details VALUES ('5d644bac-da02-4568-8d2f-8ec92935e072', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 30, 0.100000001);
INSERT INTO order_details VALUES ('5d644bac-da02-4568-8d2f-8ec92935e072', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 14, 0.100000001);
INSERT INTO order_details VALUES ('5d644bac-da02-4568-8d2f-8ec92935e072', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 16, 0);
INSERT INTO order_details VALUES ('5d644bac-da02-4568-8d2f-8ec92935e072', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 20, 0.100000001);
INSERT INTO order_details VALUES ('3243f36e-5b73-45f1-baac-1df2f8613c08', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 2, 0);
INSERT INTO order_details VALUES ('3243f36e-5b73-45f1-baac-1df2f8613c08', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 30, 0);
INSERT INTO order_details VALUES ('bf57b2d2-8d85-4894-be1c-2f8f7d99f795', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 20, 0);
INSERT INTO order_details VALUES ('51200191-d8b9-43a2-b361-d7420d490aa8', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 21, 0);
INSERT INTO order_details VALUES ('51200191-d8b9-43a2-b361-d7420d490aa8', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 4, 0.25);
INSERT INTO order_details VALUES ('51200191-d8b9-43a2-b361-d7420d490aa8', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 8, 0.25);
INSERT INTO order_details VALUES ('2c825fab-721e-46ed-a976-6463081e1e24', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 30, 0.200000003);
INSERT INTO order_details VALUES ('62ce2086-3eb1-47fe-9401-862b76c9eb28', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 8, 0);
INSERT INTO order_details VALUES ('62ce2086-3eb1-47fe-9401-862b76c9eb28', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 20, 0);
INSERT INTO order_details VALUES ('1dbb9678-2e43-4433-9856-3ce007a5f086', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 20, 0.25);
INSERT INTO order_details VALUES ('1dbb9678-2e43-4433-9856-3ce007a5f086', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 24, 0.25);
INSERT INTO order_details VALUES ('1dbb9678-2e43-4433-9856-3ce007a5f086', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 49, 0.25);
INSERT INTO order_details VALUES ('1dbb9678-2e43-4433-9856-3ce007a5f086', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 35, 0.25);
INSERT INTO order_details VALUES ('97b8dfd9-133f-4610-b422-d16279b8dd89', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 10, 0.150000006);
INSERT INTO order_details VALUES ('97b8dfd9-133f-4610-b422-d16279b8dd89', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 14, 40, 0.150000006);
INSERT INTO order_details VALUES ('35440e32-123f-4db6-9973-2da151e8f9cf', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 8, 0);
INSERT INTO order_details VALUES ('35440e32-123f-4db6-9973-2da151e8f9cf', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 20, 0);
INSERT INTO order_details VALUES ('416b281e-0c55-4d9e-8118-929605d9f10f', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 44, 0.25);
INSERT INTO order_details VALUES ('416b281e-0c55-4d9e-8118-929605d9f10f', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 30, 0.25);
INSERT INTO order_details VALUES ('416b281e-0c55-4d9e-8118-929605d9f10f', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 80, 0.25);
INSERT INTO order_details VALUES ('416b281e-0c55-4d9e-8118-929605d9f10f', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 50, 0);
INSERT INTO order_details VALUES ('00b65946-6ff8-4c28-8ef5-7b56422da763', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 28, 0);
INSERT INTO order_details VALUES ('61e55515-f2f0-48d1-a382-ef477d5319e3', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 15, 0);
INSERT INTO order_details VALUES ('61e55515-f2f0-48d1-a382-ef477d5319e3', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 21, 0);
INSERT INTO order_details VALUES ('61e55515-f2f0-48d1-a382-ef477d5319e3', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 15, 0);
INSERT INTO order_details VALUES ('6765ffad-e8c9-400e-add5-bbc3118468cc', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 5, 0.25);
INSERT INTO order_details VALUES ('6765ffad-e8c9-400e-add5-bbc3118468cc', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 18, 0.25);
INSERT INTO order_details VALUES ('6765ffad-e8c9-400e-add5-bbc3118468cc', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 18, 0);
INSERT INTO order_details VALUES ('db8293fb-ab1d-40b1-8164-d6619c816949', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 20, 0);
INSERT INTO order_details VALUES ('db8293fb-ab1d-40b1-8164-d6619c816949', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 10, 0);
INSERT INTO order_details VALUES ('1b5073fd-c07e-4b09-b63a-2f27d6ea3112', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 25, 0);
INSERT INTO order_details VALUES ('1b5073fd-c07e-4b09-b63a-2f27d6ea3112', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 25, 0);
INSERT INTO order_details VALUES ('1b5073fd-c07e-4b09-b63a-2f27d6ea3112', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 40, 0);
INSERT INTO order_details VALUES ('e5154ebd-9b07-45f7-83df-6b63241f0427', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 4, 0);
INSERT INTO order_details VALUES ('7ef9a09a-9265-4d1c-8706-f8d7faf687a8', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 16.25, 9, 0);
INSERT INTO order_details VALUES ('7ef9a09a-9265-4d1c-8706-f8d7faf687a8', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 40, 0);
INSERT INTO order_details VALUES ('7ef9a09a-9265-4d1c-8706-f8d7faf687a8', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 4, 0);
INSERT INTO order_details VALUES ('595995ac-5403-4411-8a7b-3c0d23703786', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 12, 0);
INSERT INTO order_details VALUES ('595995ac-5403-4411-8a7b-3c0d23703786', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 30, 0);
INSERT INTO order_details VALUES ('595995ac-5403-4411-8a7b-3c0d23703786', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 6, 0);
INSERT INTO order_details VALUES ('595995ac-5403-4411-8a7b-3c0d23703786', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 60, 0);
INSERT INTO order_details VALUES ('a19b00cb-4a4f-4bbf-8a8c-703b4f85ea9e', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 5, 0);
INSERT INTO order_details VALUES ('c74f26f2-ad20-4443-bc8b-2c8ce2dd61d6', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 15, 0.0500000007);
INSERT INTO order_details VALUES ('c74f26f2-ad20-4443-bc8b-2c8ce2dd61d6', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 6, 0.0500000007);
INSERT INTO order_details VALUES ('c74f26f2-ad20-4443-bc8b-2c8ce2dd61d6', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 50, 0.0500000007);
INSERT INTO order_details VALUES ('d157f6ad-878c-4efd-85cd-3180cc48285f', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 16, 0.0500000007);
INSERT INTO order_details VALUES ('d157f6ad-878c-4efd-85cd-3180cc48285f', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 2, 0);
INSERT INTO order_details VALUES ('22f536b0-ac75-4c02-b8e6-e2853f3934ea', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 50, 0.0500000007);
INSERT INTO order_details VALUES ('22f536b0-ac75-4c02-b8e6-e2853f3934ea', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 50, 0.0500000007);
INSERT INTO order_details VALUES ('874a80ad-253a-44e7-91ba-2e04d309e982', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 28, 0.150000006);
INSERT INTO order_details VALUES ('874a80ad-253a-44e7-91ba-2e04d309e982', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 25, 0.150000006);
INSERT INTO order_details VALUES ('874a80ad-253a-44e7-91ba-2e04d309e982', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 30, 0);
INSERT INTO order_details VALUES ('874a80ad-253a-44e7-91ba-2e04d309e982', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 24, 0.150000006);
INSERT INTO order_details VALUES ('b095b23f-0779-4a8a-aa15-578da0efee60', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 12, 0.200000003);
INSERT INTO order_details VALUES ('80bb4193-5d37-4f97-8495-4f5a693aba70', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 12, 0);
INSERT INTO order_details VALUES ('80bb4193-5d37-4f97-8495-4f5a693aba70', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 14, 0);
INSERT INTO order_details VALUES ('80bb4193-5d37-4f97-8495-4f5a693aba70', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 8, 0);
INSERT INTO order_details VALUES ('cb26e351-f241-41af-b52c-dd52493e93fc', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 30, 0);
INSERT INTO order_details VALUES ('cb26e351-f241-41af-b52c-dd52493e93fc', '61f41763-1ece-4378-810f-0a866a077be5', 18, 40, 0);
INSERT INTO order_details VALUES ('cb26e351-f241-41af-b52c-dd52493e93fc', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 8, 0);
INSERT INTO order_details VALUES ('db39fcc6-e569-4575-8a86-f3e9559ffa65', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 21.3500004, 20, 0);
INSERT INTO order_details VALUES ('db39fcc6-e569-4575-8a86-f3e9559ffa65', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 6, 0);
INSERT INTO order_details VALUES ('db39fcc6-e569-4575-8a86-f3e9559ffa65', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 5, 0);
INSERT INTO order_details VALUES ('b725e4fd-e64c-482b-aab2-8f5192806f31', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 20, 0.150000006);
INSERT INTO order_details VALUES ('8769d153-19cb-458d-8ee5-34cdcc97ea4d', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 10, 0.25);
INSERT INTO order_details VALUES ('8769d153-19cb-458d-8ee5-34cdcc97ea4d', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 24, 0);
INSERT INTO order_details VALUES ('b8dc2008-6af5-43b4-97f5-281f351b86ad', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 6, 0.0500000007);
INSERT INTO order_details VALUES ('b8dc2008-6af5-43b4-97f5-281f351b86ad', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 60, 0);
INSERT INTO order_details VALUES ('d82bf748-5b47-43d0-b79b-fc0e09801a4a', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 45, 0);
INSERT INTO order_details VALUES ('d82bf748-5b47-43d0-b79b-fc0e09801a4a', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 77, 0);
INSERT INTO order_details VALUES ('d82bf748-5b47-43d0-b79b-fc0e09801a4a', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 20, 0);
INSERT INTO order_details VALUES ('d82bf748-5b47-43d0-b79b-fc0e09801a4a', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 9, 0);
INSERT INTO order_details VALUES ('d82bf748-5b47-43d0-b79b-fc0e09801a4a', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 44, 0);
INSERT INTO order_details VALUES ('bb4f3fb0-cf02-43f5-830b-415450238a34', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 2, 0.150000006);
INSERT INTO order_details VALUES ('977b3d2d-a45f-4e3d-84ef-192e90552adc', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 6, 0);
INSERT INTO order_details VALUES ('977b3d2d-a45f-4e3d-84ef-192e90552adc', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 5, 0);
INSERT INTO order_details VALUES ('977b3d2d-a45f-4e3d-84ef-192e90552adc', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 10, 0);
INSERT INTO order_details VALUES ('498ea36e-4bc1-4437-8fcb-3d198f8fdf15', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 16, 0);
INSERT INTO order_details VALUES ('24865360-0d6e-47fc-a3d1-690d394b5ce6', '8ad0f836-43df-42d9-a992-e1fee45d28d8', 26, 8, 0);
INSERT INTO order_details VALUES ('24865360-0d6e-47fc-a3d1-690d394b5ce6', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 12, 0.150000006);
INSERT INTO order_details VALUES ('24865360-0d6e-47fc-a3d1-690d394b5ce6', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 12, 0.150000006);
INSERT INTO order_details VALUES ('a20fe9ce-048d-44ea-bf97-f7419cdeb14e', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 12, 0);
INSERT INTO order_details VALUES ('a20fe9ce-048d-44ea-bf97-f7419cdeb14e', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 40, 0);
INSERT INTO order_details VALUES ('b7b8b6d8-de5e-48ba-be15-53ea5d83103e', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 30, 0);
INSERT INTO order_details VALUES ('b7b8b6d8-de5e-48ba-be15-53ea5d83103e', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 30, 0);
INSERT INTO order_details VALUES ('b7b8b6d8-de5e-48ba-be15-53ea5d83103e', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 4, 0);
INSERT INTO order_details VALUES ('2e944c35-aecc-44b8-9642-81555f59580c', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 9, 0);
INSERT INTO order_details VALUES ('c9ad400e-2018-4816-be63-40e47534ff35', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 40, 0.200000003);
INSERT INTO order_details VALUES ('f5060b6f-5f87-42ab-a573-800272a0ff9a', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 14, 0);
INSERT INTO order_details VALUES ('70f7ba8f-f954-492b-a3c7-130505c6a91e', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 6, 0);
INSERT INTO order_details VALUES ('70f7ba8f-f954-492b-a3c7-130505c6a91e', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 7, 0);
INSERT INTO order_details VALUES ('3cd2bd14-d89e-4bab-90a1-7d28b27c966e', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 5, 0);
INSERT INTO order_details VALUES ('3cd2bd14-d89e-4bab-90a1-7d28b27c966e', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 6, 0);
INSERT INTO order_details VALUES ('3cd2bd14-d89e-4bab-90a1-7d28b27c966e', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 10, 0);
INSERT INTO order_details VALUES ('c5f0dbb1-70dc-4dd8-9b98-a653e6d9b156', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 10, 0);
INSERT INTO order_details VALUES ('bf197616-14d2-4d84-9dcb-6e09eda16446', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 16, 0);
INSERT INTO order_details VALUES ('bf197616-14d2-4d84-9dcb-6e09eda16446', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 10, 0);
INSERT INTO order_details VALUES ('601aab97-e9d4-4134-86c0-4870bd3724e3', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 20, 0);
INSERT INTO order_details VALUES ('84b45687-1873-4a6b-acde-267735114e07', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 30, 0);
INSERT INTO order_details VALUES ('84b45687-1873-4a6b-acde-267735114e07', 'a97e25cd-008d-43c9-9442-9b64d29bf354', 9.5, 30, 0);
INSERT INTO order_details VALUES ('84b45687-1873-4a6b-acde-267735114e07', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 10, 0);
INSERT INTO order_details VALUES ('84b45687-1873-4a6b-acde-267735114e07', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 20, 0);
INSERT INTO order_details VALUES ('bc5b5268-c4aa-41f4-9207-c3b22a8372f9', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 20, 0.150000006);
INSERT INTO order_details VALUES ('bc5b5268-c4aa-41f4-9207-c3b22a8372f9', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 40, 0.150000006);
INSERT INTO order_details VALUES ('bc5b5268-c4aa-41f4-9207-c3b22a8372f9', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 10, 0);
INSERT INTO order_details VALUES ('bc5b5268-c4aa-41f4-9207-c3b22a8372f9', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 6, 0.150000006);
INSERT INTO order_details VALUES ('c5e783ca-fa83-474c-964f-b6ac6615148c', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 18, 0);
INSERT INTO order_details VALUES ('c5e783ca-fa83-474c-964f-b6ac6615148c', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 20, 0);
INSERT INTO order_details VALUES ('c5e783ca-fa83-474c-964f-b6ac6615148c', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 80, 0);
INSERT INTO order_details VALUES ('c5e783ca-fa83-474c-964f-b6ac6615148c', '53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 43.9000015, 30, 0);
INSERT INTO order_details VALUES ('c5e783ca-fa83-474c-964f-b6ac6615148c', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 24, 0);
INSERT INTO order_details VALUES ('c5e783ca-fa83-474c-964f-b6ac6615148c', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 35, 0);
INSERT INTO order_details VALUES ('b8391efe-8381-4f30-86d9-6464d6e9aad2', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 40, 0.200000003);
INSERT INTO order_details VALUES ('4541b707-ddae-4a34-b7c8-88f43597e5dd', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 60, 0);
INSERT INTO order_details VALUES ('1d50ee52-bebf-4c33-9a73-eda60dee4886', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 20, 0);
INSERT INTO order_details VALUES ('1d50ee52-bebf-4c33-9a73-eda60dee4886', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 9, 0);
INSERT INTO order_details VALUES ('2a063f65-a2b3-4b20-853f-41e7151b5d40', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 84, 0.150000006);
INSERT INTO order_details VALUES ('2a063f65-a2b3-4b20-853f-41e7151b5d40', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 15, 0);
INSERT INTO order_details VALUES ('8fa3eecb-9ec5-48fd-9651-a1acf293f339', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 55, 0);
INSERT INTO order_details VALUES ('8fa3eecb-9ec5-48fd-9651-a1acf293f339', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 20, 0);
INSERT INTO order_details VALUES ('8fa3eecb-9ec5-48fd-9651-a1acf293f339', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 40, 0);
INSERT INTO order_details VALUES ('2918dceb-215f-4bdd-9de5-0f17d65a1356', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 36, 0.100000001);
INSERT INTO order_details VALUES ('2918dceb-215f-4bdd-9de5-0f17d65a1356', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 8, 0.100000001);
INSERT INTO order_details VALUES ('2918dceb-215f-4bdd-9de5-0f17d65a1356', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 35, 0.100000001);
INSERT INTO order_details VALUES ('15af3089-56c2-46c3-bf34-433ad6500ca7', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 30, 0);
INSERT INTO order_details VALUES ('15af3089-56c2-46c3-bf34-433ad6500ca7', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 15, 0);
INSERT INTO order_details VALUES ('15af3089-56c2-46c3-bf34-433ad6500ca7', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 10, 0);
INSERT INTO order_details VALUES ('15af3089-56c2-46c3-bf34-433ad6500ca7', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 15, 0);
INSERT INTO order_details VALUES ('420dea45-4a75-48e6-9f06-1a17bc925c30', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 60, 0);
INSERT INTO order_details VALUES ('420dea45-4a75-48e6-9f06-1a17bc925c30', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 6, 0);
INSERT INTO order_details VALUES ('420dea45-4a75-48e6-9f06-1a17bc925c30', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 20, 0);
INSERT INTO order_details VALUES ('6d7fc950-01a7-4a76-885b-bc0fdf928c6f', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 60, 0);
INSERT INTO order_details VALUES ('6d7fc950-01a7-4a76-885b-bc0fdf928c6f', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 40, 0.100000001);
INSERT INTO order_details VALUES ('43a5d040-20fa-4985-aa07-3febf28059d2', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 40, 0);
INSERT INTO order_details VALUES ('43a5d040-20fa-4985-aa07-3febf28059d2', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 15, 0);
INSERT INTO order_details VALUES ('43a5d040-20fa-4985-aa07-3febf28059d2', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 4, 0);
INSERT INTO order_details VALUES ('06706287-ab98-40b1-bacc-700ca04d8440', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 65, 0);
INSERT INTO order_details VALUES ('06706287-ab98-40b1-bacc-700ca04d8440', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 60, 0.150000006);
INSERT INTO order_details VALUES ('06706287-ab98-40b1-bacc-700ca04d8440', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 65, 0.150000006);
INSERT INTO order_details VALUES ('06706287-ab98-40b1-bacc-700ca04d8440', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 66, 0.150000006);
INSERT INTO order_details VALUES ('351afb0d-9898-44df-a371-b642294563b1', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 50, 0.200000003);
INSERT INTO order_details VALUES ('351afb0d-9898-44df-a371-b642294563b1', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 20, 0.200000003);
INSERT INTO order_details VALUES ('351afb0d-9898-44df-a371-b642294563b1', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 90, 0.200000003);
INSERT INTO order_details VALUES ('8f9096aa-3299-4197-a1ab-c9e2f20fbcfa', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 2, 0);
INSERT INTO order_details VALUES ('0857896b-411f-4715-a11b-d69af36bb9e5', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 50, 0.25);
INSERT INTO order_details VALUES ('0857896b-411f-4715-a11b-d69af36bb9e5', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 35, 0.25);
INSERT INTO order_details VALUES ('52d4a078-b224-4d08-98c8-39b9215d0124', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 18, 0.0500000007);
INSERT INTO order_details VALUES ('e4957fad-a2e7-4513-8135-f317a103d44b', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 20, 0);
INSERT INTO order_details VALUES ('e4957fad-a2e7-4513-8135-f317a103d44b', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 4, 0);
INSERT INTO order_details VALUES ('0c7c251b-38a4-4b36-a2b9-5756051dbf0c', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 40, 0);
INSERT INTO order_details VALUES ('1f459425-59b3-44ba-809f-9dbb51d93ee9', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 50, 0);
INSERT INTO order_details VALUES ('1f459425-59b3-44ba-809f-9dbb51d93ee9', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 20, 0.25);
INSERT INTO order_details VALUES ('1f459425-59b3-44ba-809f-9dbb51d93ee9', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 20, 0.25);
INSERT INTO order_details VALUES ('c0a4041a-817d-4786-8e77-be4cc62541eb', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 12, 0);
INSERT INTO order_details VALUES ('c0a4041a-817d-4786-8e77-be4cc62541eb', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 7, 0);
INSERT INTO order_details VALUES ('c0a4041a-817d-4786-8e77-be4cc62541eb', '35757ead-53a9-44f2-a023-f8950dd9eeac', 10, 20, 0);
INSERT INTO order_details VALUES ('c0a4041a-817d-4786-8e77-be4cc62541eb', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 30, 0);
INSERT INTO order_details VALUES ('aceb8b18-510c-4156-a372-c86e3a90056a', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 20, 0.0500000007);
INSERT INTO order_details VALUES ('aceb8b18-510c-4156-a372-c86e3a90056a', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 15, 0.0500000007);
INSERT INTO order_details VALUES ('aceb8b18-510c-4156-a372-c86e3a90056a', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 21, 0.0500000007);
INSERT INTO order_details VALUES ('dcc6627b-f490-4db7-820d-b408adc13305', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 25, 0.25);
INSERT INTO order_details VALUES ('dcc6627b-f490-4db7-820d-b408adc13305', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 30, 0.25);
INSERT INTO order_details VALUES ('dcc6627b-f490-4db7-820d-b408adc13305', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 30, 0);
INSERT INTO order_details VALUES ('953ab6ec-00cb-4879-898b-58b5ab26a8b9', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 60, 0);
INSERT INTO order_details VALUES ('953ab6ec-00cb-4879-898b-58b5ab26a8b9', '053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 21, 25, 0);
INSERT INTO order_details VALUES ('953ab6ec-00cb-4879-898b-58b5ab26a8b9', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 25, 0);
INSERT INTO order_details VALUES ('953ab6ec-00cb-4879-898b-58b5ab26a8b9', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 6, 0);
INSERT INTO order_details VALUES ('176afffb-4ebe-457d-8117-5054b71a1bc2', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 56, 0);
INSERT INTO order_details VALUES ('176afffb-4ebe-457d-8117-5054b71a1bc2', '61f41763-1ece-4378-810f-0a866a077be5', 18, 15, 0.150000006);
INSERT INTO order_details VALUES ('176afffb-4ebe-457d-8117-5054b71a1bc2', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 24, 0.150000006);
INSERT INTO order_details VALUES ('176afffb-4ebe-457d-8117-5054b71a1bc2', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 40, 0);
INSERT INTO order_details VALUES ('cde296f6-eec8-449f-965d-8e2ce1789133', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 4, 0);
INSERT INTO order_details VALUES ('cde296f6-eec8-449f-965d-8e2ce1789133', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 10, 0);
INSERT INTO order_details VALUES ('cde296f6-eec8-449f-965d-8e2ce1789133', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 10, 0);
INSERT INTO order_details VALUES ('abd27f3d-9857-484c-a14a-356d44a9f06a', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 6, 0);
INSERT INTO order_details VALUES ('abd27f3d-9857-484c-a14a-356d44a9f06a', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 6, 0);
INSERT INTO order_details VALUES ('023cba26-4bee-42cf-b0b2-54c2c7066d84', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 2, 0);
INSERT INTO order_details VALUES ('023cba26-4bee-42cf-b0b2-54c2c7066d84', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 10, 0);
INSERT INTO order_details VALUES ('cb7d75d1-0600-4bce-a18a-81f5b8ff5c24', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 8, 0);
INSERT INTO order_details VALUES ('cb7d75d1-0600-4bce-a18a-81f5b8ff5c24', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 2, 0.25);
INSERT INTO order_details VALUES ('f938d20a-c896-4229-8afc-bd6e1ea70451', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 30, 0);
INSERT INTO order_details VALUES ('f938d20a-c896-4229-8afc-bd6e1ea70451', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 10, 0);
INSERT INTO order_details VALUES ('f938d20a-c896-4229-8afc-bd6e1ea70451', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 14, 0);
INSERT INTO order_details VALUES ('fc6125a8-d51b-4386-8dd4-33ebf47d57dc', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 70, 0.0500000007);
INSERT INTO order_details VALUES ('fc6125a8-d51b-4386-8dd4-33ebf47d57dc', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 90, 0.0500000007);
INSERT INTO order_details VALUES ('fc6125a8-d51b-4386-8dd4-33ebf47d57dc', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 21, 0);
INSERT INTO order_details VALUES ('196840fb-ceaa-49e4-9076-e2733dd2e239', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 12, 0);
INSERT INTO order_details VALUES ('196840fb-ceaa-49e4-9076-e2733dd2e239', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 18, 0.25);
INSERT INTO order_details VALUES ('196840fb-ceaa-49e4-9076-e2733dd2e239', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 9, 0);
INSERT INTO order_details VALUES ('d72cc9f6-d96c-43a3-8b5f-2438a1bd3804', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 20, 0);
INSERT INTO order_details VALUES ('d72cc9f6-d96c-43a3-8b5f-2438a1bd3804', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 10, 0);
INSERT INTO order_details VALUES ('04faf2a6-2eb4-450d-8bd6-e52817206999', '5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 13.25, 40, 0.0500000007);
INSERT INTO order_details VALUES ('04faf2a6-2eb4-450d-8bd6-e52817206999', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 20, 0);
INSERT INTO order_details VALUES ('0d01cb93-6c14-4a1c-9602-499123dfc47b', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 50, 0.0500000007);
INSERT INTO order_details VALUES ('0d01cb93-6c14-4a1c-9602-499123dfc47b', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 36, 0.0500000007);
INSERT INTO order_details VALUES ('0d01cb93-6c14-4a1c-9602-499123dfc47b', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 60, 0.0500000007);
INSERT INTO order_details VALUES ('59d366d2-b9a5-424e-b764-1be28da346f1', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 10, 0);
INSERT INTO order_details VALUES ('59d366d2-b9a5-424e-b764-1be28da346f1', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 4, 0);
INSERT INTO order_details VALUES ('59d366d2-b9a5-424e-b764-1be28da346f1', 'f816c3fe-56be-43be-8167-8f42cb5f368b', 9.5, 20, 0);
INSERT INTO order_details VALUES ('59d366d2-b9a5-424e-b764-1be28da346f1', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 2, 0);
INSERT INTO order_details VALUES ('29724206-95af-42cd-bc4d-3d9ee0a1768f', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 28, 0.100000001);
INSERT INTO order_details VALUES ('79b9ad7d-e160-4cdf-886d-14e831e2cb65', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 15, 0);
INSERT INTO order_details VALUES ('79b9ad7d-e160-4cdf-886d-14e831e2cb65', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 18, 0);
INSERT INTO order_details VALUES ('4dfa60c2-14df-4c26-9f24-0c3034b2a328', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 15, 0);
INSERT INTO order_details VALUES ('4dfa60c2-14df-4c26-9f24-0c3034b2a328', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 16, 0);
INSERT INTO order_details VALUES ('0c602094-606f-43f6-9427-4d215346c415', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 10, 25, 0);
INSERT INTO order_details VALUES ('0c602094-606f-43f6-9427-4d215346c415', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 110, 0);
INSERT INTO order_details VALUES ('0c602094-606f-43f6-9427-4d215346c415', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 30, 0);
INSERT INTO order_details VALUES ('a58cfde9-208d-4b7b-8658-a1e8bdf20343', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 20, 0);
INSERT INTO order_details VALUES ('a58cfde9-208d-4b7b-8658-a1e8bdf20343', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 10, 0);
INSERT INTO order_details VALUES ('a58cfde9-208d-4b7b-8658-a1e8bdf20343', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 5, 0);
INSERT INTO order_details VALUES ('3fd589e7-0842-465e-853c-ed9f036390fc', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 3, 0);
INSERT INTO order_details VALUES ('3fd589e7-0842-465e-853c-ed9f036390fc', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 2, 0);
INSERT INTO order_details VALUES ('c9111896-af4e-4699-b4aa-5d9497cdc877', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 24, 0.150000006);
INSERT INTO order_details VALUES ('953d3b0b-2946-486a-b78d-3c4f370b903f', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 11, 0.25);
INSERT INTO order_details VALUES ('953d3b0b-2946-486a-b78d-3c4f370b903f', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 15, 0);
INSERT INTO order_details VALUES ('953d3b0b-2946-486a-b78d-3c4f370b903f', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 63, 0);
INSERT INTO order_details VALUES ('953d3b0b-2946-486a-b78d-3c4f370b903f', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 44, 0.25);
INSERT INTO order_details VALUES ('953d3b0b-2946-486a-b78d-3c4f370b903f', 'fd427235-b9ec-47b4-a1f8-0da5245e261f', 34.7999992, 35, 0);
INSERT INTO order_details VALUES ('b90b16b2-a371-4dc3-87aa-f718fd4f7794', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 35, 0);
INSERT INTO order_details VALUES ('b90b16b2-a371-4dc3-87aa-f718fd4f7794', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 30, 0);
INSERT INTO order_details VALUES ('460550cf-be4e-4d30-a3df-8ba147d5dbe0', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 4, 0);
INSERT INTO order_details VALUES ('460550cf-be4e-4d30-a3df-8ba147d5dbe0', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 30, 0);
INSERT INTO order_details VALUES ('cca64685-b37c-43db-bd74-4ec31e4d1184', '9a149867-007f-41b6-8e33-2484a53383ad', 31.2299995, 12, 0);
INSERT INTO order_details VALUES ('cca64685-b37c-43db-bd74-4ec31e4d1184', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 30, 0);
INSERT INTO order_details VALUES ('cca64685-b37c-43db-bd74-4ec31e4d1184', '0b2e3170-f274-4be0-af86-babaae306d97', 21.0499992, 21, 0);
INSERT INTO order_details VALUES ('cca64685-b37c-43db-bd74-4ec31e4d1184', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 50, 0);
INSERT INTO order_details VALUES ('13612767-8c86-4343-8317-c0b9c2c254f5', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 10, 0.100000001);
INSERT INTO order_details VALUES ('13612767-8c86-4343-8317-c0b9c2c254f5', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 20, 0.100000001);
INSERT INTO order_details VALUES ('1a2d5800-bfaf-43b9-8c51-ab50704e74b2', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 8, 0);
INSERT INTO order_details VALUES ('1a2d5800-bfaf-43b9-8c51-ab50704e74b2', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 10, 0);
INSERT INTO order_details VALUES ('147c51eb-29b7-4f60-af97-38cb1fa0219b', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 30, 0.25);
INSERT INTO order_details VALUES ('147c51eb-29b7-4f60-af97-38cb1fa0219b', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 21, 0.25);
INSERT INTO order_details VALUES ('4ef68285-9fc8-4028-aea5-c6acfa480275', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 35, 0);
INSERT INTO order_details VALUES ('4ef68285-9fc8-4028-aea5-c6acfa480275', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 24, 0);
INSERT INTO order_details VALUES ('3f4632d0-89f1-44c5-9448-0d6c8a06cdb7', '59126ec1-07d2-4eb8-a286-9982783e117b', 38, 20, 0);
INSERT INTO order_details VALUES ('3f4632d0-89f1-44c5-9448-0d6c8a06cdb7', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 12, 0);
INSERT INTO order_details VALUES ('048a1c81-e603-4445-991a-ccd5db4711d6', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 100, 0.25);
INSERT INTO order_details VALUES ('048a1c81-e603-4445-991a-ccd5db4711d6', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 21.3500004, 70, 0);
INSERT INTO order_details VALUES ('048a1c81-e603-4445-991a-ccd5db4711d6', '982f3425-a1a3-4dec-89d7-7787f4f82feb', 123.790001, 60, 0.25);
INSERT INTO order_details VALUES ('048a1c81-e603-4445-991a-ccd5db4711d6', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 100, 0.25);
INSERT INTO order_details VALUES ('7d4bb709-8034-47ea-9787-c19f1f467534', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 45, 0);
INSERT INTO order_details VALUES ('7d4bb709-8034-47ea-9787-c19f1f467534', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 80, 0);
INSERT INTO order_details VALUES ('7d4bb709-8034-47ea-9787-c19f1f467534', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 21, 0);
INSERT INTO order_details VALUES ('7d4bb709-8034-47ea-9787-c19f1f467534', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 20, 0);
INSERT INTO order_details VALUES ('7d4bb709-8034-47ea-9787-c19f1f467534', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 16, 0);
INSERT INTO order_details VALUES ('45ad2446-4f5f-446e-a71e-0ed4d12bf0f0', '4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 19, 35, 0);
INSERT INTO order_details VALUES ('45ad2446-4f5f-446e-a71e-0ed4d12bf0f0', '8dd33d50-ced4-41d9-aa09-85e0671d4528', 263.5, 25, 0);
INSERT INTO order_details VALUES ('45ad2446-4f5f-446e-a71e-0ed4d12bf0f0', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 30, 0);
INSERT INTO order_details VALUES ('3b8e5fc2-0520-4401-aa4a-92dd58c19d4b', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 70, 0.100000001);
INSERT INTO order_details VALUES ('3b8e5fc2-0520-4401-aa4a-92dd58c19d4b', 'd0f608d2-28bb-4c14-8864-d8f686547a5f', 36, 36, 0.100000001);
INSERT INTO order_details VALUES ('2c9ccbdc-36b2-4367-ab35-d8f37e39df88', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 15, 0.100000001);
INSERT INTO order_details VALUES ('2c9ccbdc-36b2-4367-ab35-d8f37e39df88', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 12, 0);
INSERT INTO order_details VALUES ('2c9ccbdc-36b2-4367-ab35-d8f37e39df88', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 6, 0);
INSERT INTO order_details VALUES ('a355fa43-c85f-4d73-8eed-de0108f01881', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 10, 0);
INSERT INTO order_details VALUES ('a355fa43-c85f-4d73-8eed-de0108f01881', '61f41763-1ece-4378-810f-0a866a077be5', 18, 60, 0);
INSERT INTO order_details VALUES ('a355fa43-c85f-4d73-8eed-de0108f01881', 'fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 14, 30, 0);
INSERT INTO order_details VALUES ('a355fa43-c85f-4d73-8eed-de0108f01881', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 10, 0);
INSERT INTO order_details VALUES ('dd01d5a6-932b-411a-9ceb-08ae2c94805e', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 7, 0);
INSERT INTO order_details VALUES ('dd01d5a6-932b-411a-9ceb-08ae2c94805e', '8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 55, 30, 0);
INSERT INTO order_details VALUES ('c9770984-62d2-48bf-b431-5d587ddcc163', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 4, 0);
INSERT INTO order_details VALUES ('26e5a0df-148b-4066-8e73-444c8aa05fe8', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 5, 0.200000003);
INSERT INTO order_details VALUES ('26e5a0df-148b-4066-8e73-444c8aa05fe8', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 2, 0);
INSERT INTO order_details VALUES ('26e5a0df-148b-4066-8e73-444c8aa05fe8', '1437bd3c-b711-4327-86e1-e8300e84386d', 21.5, 30, 0);
INSERT INTO order_details VALUES ('376c73ec-2c73-4f4f-8b2a-af1bf7748fa7', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 20, 0);
INSERT INTO order_details VALUES ('376c73ec-2c73-4f4f-8b2a-af1bf7748fa7', '61f41763-1ece-4378-810f-0a866a077be5', 18, 24, 0);
INSERT INTO order_details VALUES ('376c73ec-2c73-4f4f-8b2a-af1bf7748fa7', 'ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 20, 60, 0);
INSERT INTO order_details VALUES ('376c73ec-2c73-4f4f-8b2a-af1bf7748fa7', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 28, 0);
INSERT INTO order_details VALUES ('2aaaddc9-b2cc-4ecf-b5a2-0bbcad9c373a', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 20, 0);
INSERT INTO order_details VALUES ('06b37a47-e8dc-40b6-81c2-af74607124cd', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 30, 0.200000003);
INSERT INTO order_details VALUES ('06b37a47-e8dc-40b6-81c2-af74607124cd', '6b840857-464e-4c75-b887-ee21d918ee05', 43.9000015, 30, 0);
INSERT INTO order_details VALUES ('aa41f76e-3382-4ebb-be54-2908d685f7f4', '493f4894-c1cd-4285-9a14-219180421e20', 19.4500008, 15, 0);
INSERT INTO order_details VALUES ('aa41f76e-3382-4ebb-be54-2908d685f7f4', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 4, 0);
INSERT INTO order_details VALUES ('5319044b-5991-4b0f-811d-0cb5bb8e7588', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 10, 0);
INSERT INTO order_details VALUES ('e8054b77-0bc8-4ae9-b292-a0e8a2aeba01', 'b290b474-1fe1-43db-b4c5-9cbb871989e2', 49.2999992, 12, 0);
INSERT INTO order_details VALUES ('cefdc9fe-4328-4a77-868d-db433f908628', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 15, 0);
INSERT INTO order_details VALUES ('cefdc9fe-4328-4a77-868d-db433f908628', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 24, 0);
INSERT INTO order_details VALUES ('ff4b1d5f-a87d-41b6-b122-0c65be7d13b8', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 20, 0.0500000007);
INSERT INTO order_details VALUES ('ff4b1d5f-a87d-41b6-b122-0c65be7d13b8', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 15, 0.0500000007);
INSERT INTO order_details VALUES ('ff4b1d5f-a87d-41b6-b122-0c65be7d13b8', '61f41763-1ece-4378-810f-0a866a077be5', 18, 18, 0.0500000007);
INSERT INTO order_details VALUES ('cb07d712-4f3d-453e-a48e-75f1fe6801bb', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 25, 0.25);
INSERT INTO order_details VALUES ('cb07d712-4f3d-453e-a48e-75f1fe6801bb', '6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 21.3500004, 30, 0.25);
INSERT INTO order_details VALUES ('0962d8df-5769-479a-a666-683104d9af77', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 42, 0);
INSERT INTO order_details VALUES ('9187aa4e-c774-4623-a842-ad475d1e138d', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 10, 0.200000003);
INSERT INTO order_details VALUES ('9187aa4e-c774-4623-a842-ad475d1e138d', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 4, 0.200000003);
INSERT INTO order_details VALUES ('757ebada-92b9-4f48-a962-ede7ebc2ea74', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 50, 0.100000001);
INSERT INTO order_details VALUES ('221b74b7-7bd5-48ed-9f08-e112b6c3c7dd', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 10, 0.200000003);
INSERT INTO order_details VALUES ('c46b6453-27aa-4306-a146-3b63120cdb4b', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 30, 0.200000003);
INSERT INTO order_details VALUES ('c46b6453-27aa-4306-a146-3b63120cdb4b', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 10, 0.200000003);
INSERT INTO order_details VALUES ('42b0c590-17ee-44fe-b877-317584dcd5ed', 'c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 62.5, 35, 0.200000003);
INSERT INTO order_details VALUES ('42b0c590-17ee-44fe-b877-317584dcd5ed', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 20, 0);
INSERT INTO order_details VALUES ('42b0c590-17ee-44fe-b877-317584dcd5ed', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 25, 0.200000003);
INSERT INTO order_details VALUES ('c33a3805-1396-4889-9d19-2280eb3792c0', 'd2394847-8829-4bec-b968-170c8429022f', 2.5, 10, 0);
INSERT INTO order_details VALUES ('c33a3805-1396-4889-9d19-2280eb3792c0', '74fcbd5d-f86e-4359-91d6-5310cf01e96a', 14, 20, 0);
INSERT INTO order_details VALUES ('58b1b400-cc2c-4848-b38b-5ecb662ff4cc', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 15, 0);
INSERT INTO order_details VALUES ('58b1b400-cc2c-4848-b38b-5ecb662ff4cc', '93efb435-8f64-4a72-92a3-a3e38bdb7c39', 14, 15, 0);
INSERT INTO order_details VALUES ('58b1b400-cc2c-4848-b38b-5ecb662ff4cc', '6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 53, 20, 0);
INSERT INTO order_details VALUES ('58b1b400-cc2c-4848-b38b-5ecb662ff4cc', 'e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 19.5, 20, 0);
INSERT INTO order_details VALUES ('6deb8e7a-b87d-4412-97db-9583b325b208', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 40, 0);
INSERT INTO order_details VALUES ('6deb8e7a-b87d-4412-97db-9583b325b208', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 35, 0);
INSERT INTO order_details VALUES ('6deb8e7a-b87d-4412-97db-9583b325b208', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 50, 0);
INSERT INTO order_details VALUES ('54ea6745-510b-469b-be88-23e6ee7ef3a7', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 3, 0);
INSERT INTO order_details VALUES ('ba743115-b7ba-4cec-9d0d-27d44a65aa5f', '22b15424-92eb-4ac1-b839-141041a32d95', 10, 3, 0);
INSERT INTO order_details VALUES ('ba743115-b7ba-4cec-9d0d-27d44a65aa5f', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 21, 0);
INSERT INTO order_details VALUES ('ba743115-b7ba-4cec-9d0d-27d44a65aa5f', 'fb45c8e6-03d3-472d-970a-8b3b65560742', 28.5, 4, 0);
INSERT INTO order_details VALUES ('983c4f21-0e38-4cec-8588-ced56b83dccc', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 30, 0);
INSERT INTO order_details VALUES ('983c4f21-0e38-4cec-8588-ced56b83dccc', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 12, 0);
INSERT INTO order_details VALUES ('983c4f21-0e38-4cec-8588-ced56b83dccc', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 35, 0);
INSERT INTO order_details VALUES ('10a23bfe-4cf4-4cc6-a97f-11581a69e984', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 4, 0);
INSERT INTO order_details VALUES ('10a23bfe-4cf4-4cc6-a97f-11581a69e984', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 10, 0);
INSERT INTO order_details VALUES ('b921a2df-a5b8-49e4-8b0b-37483c44f0b7', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 15, 0);
INSERT INTO order_details VALUES ('4323968c-81f6-412e-b26a-76dde3622866', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 10, 0.200000003);
INSERT INTO order_details VALUES ('4323968c-81f6-412e-b26a-76dde3622866', '358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 15, 12, 0.200000003);
INSERT INTO order_details VALUES ('036ce6a5-cb40-4a7e-a9da-aabde1be7b6c', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 30, 0);
INSERT INTO order_details VALUES ('036ce6a5-cb40-4a7e-a9da-aabde1be7b6c', 'c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 18.3999996, 40, 0.100000001);
INSERT INTO order_details VALUES ('036ce6a5-cb40-4a7e-a9da-aabde1be7b6c', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 30, 0.100000001);
INSERT INTO order_details VALUES ('932b4a38-07d5-4c83-83e5-305ab89a2ac7', 'cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 39, 77, 0.100000001);
INSERT INTO order_details VALUES ('932b4a38-07d5-4c83-83e5-305ab89a2ac7', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 12, 0);
INSERT INTO order_details VALUES ('932b4a38-07d5-4c83-83e5-305ab89a2ac7', '92009acc-e997-414f-a982-9f2fb872c9a6', 32.7999992, 25, 0.100000001);
INSERT INTO order_details VALUES ('932b4a38-07d5-4c83-83e5-305ab89a2ac7', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 4, 0.100000001);
INSERT INTO order_details VALUES ('932b4a38-07d5-4c83-83e5-305ab89a2ac7', 'dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 12.5, 55, 0);
INSERT INTO order_details VALUES ('0d2654f5-abd2-4359-a3ff-956fa62a310d', '6cb25a55-c162-4d91-859b-6c7f5f966462', 25.8899994, 4, 0.25);
INSERT INTO order_details VALUES ('0d2654f5-abd2-4359-a3ff-956fa62a310d', 'e299b717-99b4-4452-8214-f603abc3c12c', 7.44999981, 20, 0.25);
INSERT INTO order_details VALUES ('46db0fad-61cc-409c-9e0b-836c8f583912', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 3, 0);
INSERT INTO order_details VALUES ('46db0fad-61cc-409c-9e0b-836c8f583912', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 42, 0);
INSERT INTO order_details VALUES ('46db0fad-61cc-409c-9e0b-836c8f583912', '7cb88561-c27a-4d7b-a741-9f7115dbef98', 14, 35, 0);
INSERT INTO order_details VALUES ('da415553-0d9d-431b-95fb-3757b734295b', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 9, 0);
INSERT INTO order_details VALUES ('8f664124-0390-471c-b6c3-6888e1e9ff24', '6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 45.5999985, 8, 0.150000006);
INSERT INTO order_details VALUES ('8f664124-0390-471c-b6c3-6888e1e9ff24', '1fd3d013-ea69-40a6-b0d7-4dd071239719', 46, 36, 0.150000006);
INSERT INTO order_details VALUES ('8f664124-0390-471c-b6c3-6888e1e9ff24', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 28, 0.150000006);
INSERT INTO order_details VALUES ('6b24be75-bc6b-4500-88bf-0caeb14c343c', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 20, 0);
INSERT INTO order_details VALUES ('2f794433-00bc-4a98-9d89-f3f39f893eec', '959c44be-226b-4e4e-ae3d-b05bfedbb901', 18, 40, 0.150000006);
INSERT INTO order_details VALUES ('2f794433-00bc-4a98-9d89-f3f39f893eec', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 20, 0.150000006);
INSERT INTO order_details VALUES ('2f794433-00bc-4a98-9d89-f3f39f893eec', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 30, 0.150000006);
INSERT INTO order_details VALUES ('2f794433-00bc-4a98-9d89-f3f39f893eec', '23360db3-5576-443b-bd45-5c5e04ef26a2', 12.5, 20, 0);
INSERT INTO order_details VALUES ('649936d1-b37a-4c63-a548-2debe1204e90', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 15, 0.0500000007);
INSERT INTO order_details VALUES ('649936d1-b37a-4c63-a548-2debe1204e90', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 10, 0.0500000007);
INSERT INTO order_details VALUES ('3f731380-d0a8-434e-bdd1-af71c74acc48', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 8, 0);
INSERT INTO order_details VALUES ('3f731380-d0a8-434e-bdd1-af71c74acc48', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 40, 0);
INSERT INTO order_details VALUES ('3f731380-d0a8-434e-bdd1-af71c74acc48', 'ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 16.25, 22, 0);
INSERT INTO order_details VALUES ('3f731380-d0a8-434e-bdd1-af71c74acc48', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 130, 0);
INSERT INTO order_details VALUES ('abcdc083-37fa-485d-9d9c-3d8b2682908c', 'd78cfbef-a552-4f9f-94c0-dcff795d259c', 21, 10, 0);
INSERT INTO order_details VALUES ('abcdc083-37fa-485d-9d9c-3d8b2682908c', 'f89701dd-38a8-41b6-9a6f-d568d82888b4', 4.5, 20, 0);
INSERT INTO order_details VALUES ('2a6185c3-a19e-4857-9c0a-d42b5e467595', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 14, 0.0500000007);
INSERT INTO order_details VALUES ('3d8a4af9-9951-490b-92cd-1f0fefa72968', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 10, 0.150000006);
INSERT INTO order_details VALUES ('3d8a4af9-9951-490b-92cd-1f0fefa72968', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 30, 0.150000006);
INSERT INTO order_details VALUES ('3d8a4af9-9951-490b-92cd-1f0fefa72968', '882e7e68-088a-4004-ac67-4eb7e5c5d860', 18, 2, 0.150000006);
INSERT INTO order_details VALUES ('e758cac0-9fb2-493a-bd0d-5c245bea2111', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 20, 0.25);
INSERT INTO order_details VALUES ('e758cac0-9fb2-493a-bd0d-5c245bea2111', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 20, 0.25);
INSERT INTO order_details VALUES ('e758cac0-9fb2-493a-bd0d-5c245bea2111', '23e32477-99f5-4e2d-9797-345c0c1374cf', 9.19999981, 10, 0.25);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 19, 24, 0.200000003);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '928452a2-e16c-4abb-8cc0-de744f8a0baf', 10, 4, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 22, 1, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 25, 1, 0.0199999996);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 30, 1, 0.0500000007);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '77d07414-e1ec-4ad5-b196-3634c84ab2fb', 40, 2, 0.100000001);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 31, 1, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'faa17edb-402d-402a-a859-af6b8321f8da', 38, 2, 0.0500000007);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '1b513001-91dd-4c4b-a64d-4e84520ee747', 6, 4, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '38262c84-2325-4c54-a537-7fd358d8b35e', 23.25, 1, 0.0299999993);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'c5aed807-369f-422e-933d-8651810373ab', 17.4500008, 2, 0.0299999993);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '0e00f32f-a7e7-4c83-aaed-11698cbe995e', 81, 1, 0.0399999991);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 9, 2, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '557b229c-18fe-43e9-a440-ff4260ee4d86', 32, 1, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 18, 2, 0.0500000007);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'e0591e8d-41e4-4649-8af3-56871fadedcf', 9.64999962, 3, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '94612826-6a21-49d7-9ec3-c9d7f6cfab69', 12, 3, 0.0199999996);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '45638c62-8eea-4e9f-b4ac-ff20f44afac2', 7, 2, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 24, 2, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '9caf4420-97b1-4e71-baa3-f7cb9040bae3', 34, 2, 0.0599999987);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'a5924475-b665-46aa-97ee-b268fda8740e', 33.25, 2, 0.0299999993);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '309dcfa3-7eea-4a14-9795-f8693838c3bd', 17, 1, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'acc0ebee-1777-4f60-a1c6-86f96070698e', 15, 2, 0.00999999978);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'f017f084-17f7-4c97-bf8a-d9e0d2fba577', 7.75, 4, 0);
INSERT INTO order_details VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', 'c8ce1699-c162-4649-aa00-4ab58ac21822', 13, 2, 0);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO orders VALUES ('82c06d86-0d6a-4454-9919-3d739d636ce4', '0f950417-4cef-4220-9648-bf424a6da513', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-04-07', '2024-05-05', '2024-04-19', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 32.3800011, 'Yellowstone Supply Co', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France');
INSERT INTO orders VALUES ('f86a570a-6b98-4fd0-b959-e30a6392a2f9', '7379764d-d1e9-4e61-9016-7d804b30c2eb', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-04-08', '2024-05-20', '2024-04-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 11.6099997, 'Kestrel Supply Group', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany');
INSERT INTO orders VALUES ('ad387250-f71c-42ba-8645-f1c53a76bc32', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-04-11', '2024-05-09', '2024-04-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 65.8300018, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('f93cf4c1-ad7a-4daa-abbb-d56e2d67b124', '0668ebca-a25a-4c6a-b84c-7943bf00171e', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-04-11', '2024-05-09', '2024-04-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 41.3400002, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('83f2abd6-53de-45cc-a659-bf1f4ffcd00b', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-04-12', '2024-05-10', '2024-04-14', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 51.2999992, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('a84a490a-5f89-437c-82d7-adcb7a5bcb6d', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-04-13', '2024-04-27', '2024-04-19', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 58.1699982, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('ba030db5-8b56-4727-9844-69cd3de9ba12', '346cfbc3-e2c8-4c26-92ec-df34bad2e944', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-04-14', '2024-05-12', '2024-04-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 22.9799995, 'Glacier Commerce Ltd', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland');
INSERT INTO orders VALUES ('973006d2-24f6-44b9-a9d1-d079e92fb88d', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', 'bd734f3c-b888-489c-a098-4395f9565d97', '2024-04-15', '2024-05-13', '2024-04-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 148.330002, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('7b4bc9de-2de5-4871-a282-497ea319beb1', '5506f7ee-50bd-4a1e-a15d-b6f223d32c67', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-04-18', '2024-05-16', '2024-04-20', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 13.9700003, 'Horizon Merchants', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO orders VALUES ('d13abecc-daf1-49ef-af49-8646262b5788', '0ef4332c-6383-486b-a577-0156519db661', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-04-19', '2024-05-17', '2024-04-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 81.9100037, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('0153dd62-f5d9-424a-be26-ac73e9a31c38', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-04-20', '2024-05-18', '2024-04-26', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 140.509995, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('42bf8757-021d-4913-81b4-8101acce2671', 'fcbb08d1-ce02-4951-a597-066be861a06d', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-04-21', '2024-05-19', '2024-04-28', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 3.25, 'Quince Commerce Solutions', 'Sierras de Granada 9993', 'México D.F.', NULL, '05022', 'Mexico');
INSERT INTO orders VALUES ('68cde686-6552-4bac-ae6a-a947347f345e', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-04-22', '2024-05-20', '2024-05-02', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 55.0900002, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('50263d76-fa99-4808-8586-b3acccf54ed4', 'b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-04-22', '2024-05-20', '2024-05-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.04999995, 'Crown Retail Solutions', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO orders VALUES ('cfd98252-e96f-41ef-a3cb-590de2310d40', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-04-25', '2024-05-23', '2024-04-28', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 48.2900009, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('4d60f80b-b6ed-44a1-81c6-1533a78d979d', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'bd734f3c-b888-489c-a098-4395f9565d97', '2024-04-26', '2024-05-24', '2024-05-04', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 146.059998, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('3759e4e7-3808-439f-a572-bb6bd22ea0be', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-04-27', '2024-05-25', '2024-05-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 3.67000008, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('903711d1-0913-4ad0-9a4c-cada906e1ac3', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-04-28', '2024-05-26', '2024-05-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 55.2799988, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('469b8281-8db3-4792-8c42-7c4b466fff47', 'af354600-23a9-4298-9157-75ff7c92a119', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-04-29', '2024-06-10', '2024-05-04', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 25.7299995, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('7b6b1938-d775-412a-afeb-c0af7c8dc726', '93eee301-36bd-466c-af34-ac22fd4afdb7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-05-02', '2024-05-30', '2024-05-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 208.580002, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('af14173b-e5c5-4f7d-bbf0-f65530765766', '4778376a-e73d-4c29-9124-abc9f9265689', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-05-03', '2024-05-31', '2024-05-06', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 66.2900009, 'Umbra Retail Partners', '5ª Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela');
INSERT INTO orders VALUES ('4ab90db1-b3b0-4cf5-95af-baee82fac1df', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-05-04', '2024-05-18', '2024-05-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 4.55999994, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('1bfac9e6-25ce-4433-abb1-f743dd51d6e4', 'af354600-23a9-4298-9157-75ff7c92a119', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-05-05', '2024-06-02', '2024-05-06', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 136.539993, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('7d13b90a-7e30-4285-8292-408e8056e2cd', '39a6fd07-d871-4d12-889a-1bfd8d79dea2', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-05-05', '2024-06-02', '2024-06-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.53999996, 'Quartz Retail Group', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA');
INSERT INTO orders VALUES ('517ad1a2-20df-430f-88cf-86e5b100ae04', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-05-06', '2024-06-03', '2024-05-10', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 98.0299988, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('b99f800e-420f-4c86-b1f9-f48f1a165fa6', '748b439f-112d-44fa-91a4-670ef32d1621', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-05-09', '2024-06-06', '2024-05-16', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 76.0699997, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('23f99487-8364-4da1-97f3-b4bea62b94bf', '0f950417-4cef-4220-9648-bf424a6da513', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-05-10', '2024-06-07', '2024-05-20', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 6.01000023, 'Yellowstone Supply Co', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France');
INSERT INTO orders VALUES ('d5d0e012-83f1-4148-a81d-0daf95147d6a', '53e16308-5b76-4e70-b284-fe5958e79a0e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-05-11', '2024-06-08', '2024-05-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 26.9300003, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('88041a74-4153-4573-882f-f69d35b0d925', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-05-12', '2024-05-26', '2024-05-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 13.8400002, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('6354b418-a0bc-484d-b22f-9c70917edab0', '404621e7-d665-4801-bfce-aa17d22b435f', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-05-13', '2024-06-10', '2024-05-17', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 125.769997, 'Neptune Commerce Ltd', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany');
INSERT INTO orders VALUES ('7f06a4dd-06f2-4e98-b94d-ad46aebd65eb', '216c4816-2434-466a-98ee-252ad3d9d933', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-05-16', '2024-06-13', '2024-05-20', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 92.6900024, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('b3947aa8-a583-4c10-bdd3-b6c00d38b531', '79222616-f296-416f-a386-57a31c0d15d7', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-05-17', '2024-06-14', '2024-05-20', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 25.8299999, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('3b142c25-f586-4530-b513-e832c6f4c48e', '216c4816-2434-466a-98ee-252ad3d9d933', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-05-18', '2024-06-15', '2024-06-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 8.97999954, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('5a9d3203-de0a-4311-a29c-f2099a893530', '689c7f09-ae86-48b0-838d-dc4c046c757d', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-05-18', '2024-06-01', '2024-05-25', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 2.94000006, 'Diamond Retail Solutions', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain');
INSERT INTO orders VALUES ('13a02c62-d15d-45bd-a9b4-29edcb24d6ed', '689c7f09-ae86-48b0-838d-dc4c046c757d', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-05-19', '2024-06-16', '2024-05-25', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 12.6899996, 'Diamond Retail Solutions', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain');
INSERT INTO orders VALUES ('08ba8173-6e53-43b4-9ec8-0585ffd17c14', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-05-20', '2024-06-17', '2024-05-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 84.8099976, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('f6c55541-77c9-4530-969a-1b23e1a2fe20', '79222616-f296-416f-a386-57a31c0d15d7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-05-23', '2024-06-20', '2024-05-31', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 76.5599976, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('7ad09a00-f69b-4c4f-b19e-4e0548aad1dc', '748b439f-112d-44fa-91a4-670ef32d1621', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-05-24', '2024-06-21', '2024-05-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 76.8300018, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('e453ac16-6022-4ec3-a24e-eb44fd85783f', '748b439f-112d-44fa-91a4-670ef32d1621', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-05-25', '2024-06-22', '2024-06-03', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 229.240005, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('e90b4678-0c6b-4183-908e-b3f33b45ac31', '08593d96-6aac-44cc-9aff-b5c963fc26db', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-05-26', '2024-06-23', '2024-06-01', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 12.7600002, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('4ad00383-76e1-4535-bbd2-ca7b97af3620', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-05-27', '2024-06-24', '2024-06-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 7.44999981, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('dc8c8954-a6b8-41fc-a028-d3605068ebc0', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-05-30', '2024-06-27', '2024-06-01', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 22.7700005, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('69e0f682-ac30-42e5-bff4-9743d894ce6a', '1d3de59b-fd0b-4277-8192-b02fda2e41db', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-05-31', '2024-06-28', '2024-06-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 79.6999969, 'Oak Retail Systems', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil');
INSERT INTO orders VALUES ('76afbd62-e5b1-4c1d-ad60-fa5ab1fe9acd', 'b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-05-31', '2024-06-28', '2024-06-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 6.4000001, 'Crown Retail Solutions', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO orders VALUES ('75d7c5cb-0558-4127-a708-90ddb4faef48', 'ce6bfe1b-34e1-4750-a003-271ce4dc6912', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-06-01', '2024-06-29', '2024-06-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.35000002, 'Keystone Supply Chain', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil');
INSERT INTO orders VALUES ('e1487d2e-79ed-4988-bdff-0eeaf7b606ed', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-06-02', '2024-06-30', '2024-06-15', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 21.1800003, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('66b6a018-f0b7-4236-aeae-faeebe53c8ff', '2569e109-6d44-4f1a-8919-db63efb4ca9e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-06-03', '2024-07-01', '2024-06-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 147.259995, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('8259e17a-a4d7-4d7d-8bb1-133b49ce7fda', '0f950417-4cef-4220-9648-bf424a6da513', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-06-06', '2024-07-04', '2024-06-14', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.14999998, 'Yellowstone Supply Co', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France');
INSERT INTO orders VALUES ('c9e74798-ae1c-4d6b-9d4f-49fb18d348bc', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-06-07', '2024-07-05', '2024-06-15', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.119999997, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('464792f5-a704-4090-a9a2-8687fe12ab36', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-06-08', '2024-07-20', '2024-06-14', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 5.73999977, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('ede4432f-d5e5-4dc3-a9e0-4017c5d815a2', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-06-09', '2024-07-07', '2024-06-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 168.220001, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('7ccecfa5-62ed-4d0a-8729-e3850d016619', '08593d96-6aac-44cc-9aff-b5c963fc26db', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-06-10', '2024-07-08', '2024-06-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 29.7600002, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('8bfd82e5-0dd2-4865-b3f4-b63700389cb4', '53e16308-5b76-4e70-b284-fe5958e79a0e', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-06-13', '2024-07-11', '2024-06-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 17.6800003, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('91ece67a-94f9-4939-94d8-44bd019a4a59', 'c628d310-118f-4d17-83c4-1cfcc82954a9', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-06-13', '2024-07-11', '2024-06-21', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 45.0800018, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('4b744b50-bfe7-4aca-9446-fb8dfede226d', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-06-14', '2024-07-12', '2024-07-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 6.26999998, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('88381dbd-4311-4497-a111-dc562948ab44', '74661752-05c4-445c-9b23-573d5c0d6e19', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-06-15', '2024-07-13', '2024-06-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 107.830002, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('cf1fc47a-53be-4883-88ca-bef9f131c2eb', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-06-16', '2024-07-14', '2024-06-21', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 63.7900009, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('28fb28b5-b1a4-4cd7-8805-6896d7faecf5', '7353f783-745c-41a9-8fe0-367246437f6d', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-06-17', '2024-07-15', '2024-07-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 257.619995, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('c4e5d8e4-81c1-4ba3-baa6-d9ddf370a550', '689c7f09-ae86-48b0-838d-dc4c046c757d', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-06-20', '2024-07-18', '2024-06-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 7.55999994, 'Diamond Retail Solutions', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain');
INSERT INTO orders VALUES ('12899056-0c26-4ff0-be55-b0421cdeff38', 'e56705d0-d0c1-463d-a72a-43b95b4e4c45', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-06-21', '2024-07-19', '2024-06-29', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 0.560000002, 'Pine Supply Group', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA');
INSERT INTO orders VALUES ('3bf11ac5-f275-4591-a6ee-72f0662f7d62', 'ccee083f-d880-4792-b08c-4059192a96a7', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-06-22', '2024-07-20', '2024-06-28', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.61000001, 'Kingston Supply Group', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico');
INSERT INTO orders VALUES ('1087f41f-e728-4220-8fef-e958cf1e3ebe', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-06-23', '2024-07-21', '2024-07-27', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 47.2999992, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('3500e39e-014d-49a1-bfc1-2029049649af', '4df2df85-b445-43b3-a8a6-f5b65d0cc8c8', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-06-24', '2024-07-22', '2024-07-01', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 17.5200005, 'Zenith Commerce Group', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA');
INSERT INTO orders VALUES ('bdd94223-6b8a-43c0-a28f-ce6fdeb26c74', 'c81e7c16-d8f1-43a8-a1c4-27847709ce21', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-06-24', '2024-07-08', '2024-06-30', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 24.6900005, 'Elm Commerce Group', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France');
INSERT INTO orders VALUES ('14b54ea5-2e11-49ea-9fd0-8fbb688e4047', 'c628d310-118f-4d17-83c4-1cfcc82954a9', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-06-27', '2024-07-25', '2024-07-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 40.2599983, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('f4f17687-ff43-4d12-ac7c-4f936d5a51ba', '748b439f-112d-44fa-91a4-670ef32d1621', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-06-28', '2024-07-26', '2024-07-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.96000004, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('e8c586bc-51df-498b-ad00-1d8b73fe143f', '2569e109-6d44-4f1a-8919-db63efb4ca9e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-06-29', '2024-07-27', '2024-07-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 74.1600037, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('9b978ddd-7373-49be-833f-e3e1a488771c', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-06-30', '2024-07-28', '2024-07-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 41.7599983, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('5095fdc8-4299-41be-8668-92fe626ca5d6', '2569e109-6d44-4f1a-8919-db63efb4ca9e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-07-01', '2024-07-29', '2024-07-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 150.149994, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('e35bc919-4cff-4778-8de2-0f4de97e3563', 'e56705d0-d0c1-463d-a72a-43b95b4e4c45', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-07-04', '2024-08-01', '2024-07-14', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 12.6899996, 'Pine Supply Group', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA');
INSERT INTO orders VALUES ('d62f1556-d144-4e76-a84a-b4faf7bc87fb', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-07-05', '2024-08-02', '2024-07-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.73000002, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('ad586c96-5f57-4d17-b25c-086f1a67cacb', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-07-06', '2024-08-03', '2024-07-15', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 64.5, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('107a378c-c3bf-4fa0-9240-82bfd71847cd', 'af354600-23a9-4298-9157-75ff7c92a119', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-07-07', '2024-07-21', '2024-07-22', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 34.5699997, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('4b4f4620-d580-4023-bcf0-37ea510cd5bb', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-07-07', '2024-08-04', '2024-07-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.43000007, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('82d07ae4-4e72-42b8-b462-be09210f8c47', '078abbfd-fbac-4432-9528-c7a98ea5351c', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-07-08', '2024-08-05', '2024-07-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 0.400000006, 'Vector Trading House', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('665fb271-4dae-43e6-af04-d29feb9589e1', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-07-11', '2024-08-08', '2024-07-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 4.88000011, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('57e3dde3-7be5-46c3-aae2-3720d8785d01', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'bd734f3c-b888-489c-a098-4395f9565d97', '2024-07-12', '2024-08-09', '2024-07-14', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 214.270004, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('64c0df99-fb77-4439-ad63-14aa7f73fb75', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-07-13', '2024-07-27', '2024-07-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 64.8600006, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('51f25678-c558-4034-ac1b-6c77d7f6e8d6', '9f303dd7-f723-44ca-83ab-1076b4d8c364', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-07-14', '2024-08-11', '2024-07-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 77.9199982, 'Mercury Wholesale Group', 'C/ Araquil, 67', 'Madrid', NULL, '28023', 'Spain');
INSERT INTO orders VALUES ('b9b802ff-1421-487f-b637-f69db23f435e', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-07-15', '2024-08-12', '2024-07-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 63.3600006, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('75765a20-3cea-4531-b563-87d60f5b3afc', '73ac725b-10e5-410f-bddd-d9c60fd0ec46', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-07-18', '2024-08-15', '2024-07-21', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 87.0299988, 'Acorn Trading House', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal');
INSERT INTO orders VALUES ('3e111971-389d-4b32-bbf8-c83523c0c4d4', '39a6fd07-d871-4d12-889a-1bfd8d79dea2', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-07-19', '2024-08-30', '2024-07-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 191.669998, 'Quartz Retail Group', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA');
INSERT INTO orders VALUES ('e990a789-4b40-4541-b651-9bf29bafd6c0', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-07-20', '2024-08-17', '2024-08-01', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 12.75, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('329109b0-0c42-4857-9f55-a91dcbb4124e', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'bd734f3c-b888-489c-a098-4395f9565d97', '2024-07-20', '2024-08-31', '2024-07-25', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 10.1899996, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('0437498b-ecaf-4916-8c85-e0f29069e169', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-07-21', '2024-09-01', '2024-07-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 52.8400002, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('8cb5dfe3-ac5e-4de8-ba4f-65833e3beec3', 'af354600-23a9-4298-9157-75ff7c92a119', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-07-22', '2024-08-19', '2024-07-29', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 0.589999974, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('473ff3eb-ab48-443e-8901-354f1ca46953', '0668ebca-a25a-4c6a-b84c-7943bf00171e', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-07-25', '2024-08-22', '2024-08-01', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 8.56000042, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('05e9245c-1788-4dc3-9ea9-c28cf2726357', 'a21a6b01-37f1-4462-95f2-595326e090f6', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-07-26', '2024-08-23', '2024-07-28', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 42.1100006, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('3081f4bf-0353-41e5-8a2e-3f6053a5810d', '82e1941f-8f2c-4015-bcec-36ec4ab51900', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-07-27', '2024-08-24', '2024-07-29', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 15.5100002, 'Quantum Retail Solutions', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal');
INSERT INTO orders VALUES ('c3e3b53b-379c-4b72-ba14-efdc3e29691b', '93eee301-36bd-466c-af34-ac22fd4afdb7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-07-28', '2024-08-25', '2024-08-02', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 108.260002, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('7c013a08-a00f-4534-97da-a023f152a945', '7353f783-745c-41a9-8fe0-367246437f6d', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-07-29', '2024-08-26', '2024-08-02', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 84.2099991, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('e5a2ae85-aff8-440a-946b-54deade8a779', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-08-01', '2024-08-29', '2024-08-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 15.6599998, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('45b09b2d-5b05-4609-94f3-4d4b0b046285', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-08-02', '2024-08-30', '2024-08-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 166.309998, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('29677352-a658-49ec-b942-984e05d47920', 'f0d1b9c9-9e00-4a54-8276-07cced1288be', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-08-02', '2024-08-30', '2024-08-09', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 26.7800007, 'Maple Commerce Solutions', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark');
INSERT INTO orders VALUES ('168087aa-a0e9-494b-8fba-f11d19411031', '93eee301-36bd-466c-af34-ac22fd4afdb7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-08-03', '2024-08-17', '2024-08-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 54.8300018, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('fc90f235-e654-4d26-8d7f-3e67d03a8dc5', '79222616-f296-416f-a386-57a31c0d15d7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-08-04', '2024-09-01', '2024-08-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 110.370003, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('700a2a51-c68c-4ce2-91e6-280d2712ffe5', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-08-05', '2024-09-02', '2024-08-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 23.2900009, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('349d5229-a3e5-426d-82df-27af267c7192', '748b439f-112d-44fa-91a4-670ef32d1621', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-08-08', '2024-09-05', '2024-08-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 249.059998, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('489603ab-94e5-4f90-8647-f4d5bd144b78', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-08-09', '2024-09-20', '2024-08-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 142.080002, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('d0cca777-1d8e-4be9-985e-8b0679a64406', '1d42c341-838e-44f6-9a56-d831af2dfcff', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-08-10', '2024-09-07', '2024-08-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 3.0999999, 'Jetty Trading Solutions', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil');
INSERT INTO orders VALUES ('96b194d5-ee5d-4949-bb55-5aa663077268', 'c628d310-118f-4d17-83c4-1cfcc82954a9', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-08-11', '2024-09-08', '2024-08-19', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 0.779999971, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('0f60b51e-3d80-454f-af12-fca02bff10a7', '39a6fd07-d871-4d12-889a-1bfd8d79dea2', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-08-12', '2024-09-09', '2024-08-19', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 8.63000011, 'Quartz Retail Group', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA');
INSERT INTO orders VALUES ('d1222e23-ea22-4673-aa30-8228e24fd15c', '3130b75e-08d7-4937-bfde-1974a03c950a', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-08-15', '2024-09-12', '2024-09-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 64.1900024, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('d348eb64-9a51-44c0-9b2b-60620909185a', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-08-15', '2024-09-12', '2024-08-24', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 162.330002, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('ac2e52fe-1141-4846-9128-e0b583f47c13', '73ac725b-10e5-410f-bddd-d9c60fd0ec46', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-08-16', '2024-08-30', '2024-08-22', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.29999995, 'Acorn Trading House', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal');
INSERT INTO orders VALUES ('e8ed9778-df0b-4e1c-a90e-2fa6127e03a3', '95ddaae9-9c82-4259-b319-1a46588a652a', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-08-17', '2024-09-14', '2024-08-29', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 360.630005, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('0b0eb553-3299-4e40-a077-dcb2f1b4691d', '078abbfd-fbac-4432-9528-c7a98ea5351c', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-08-18', '2024-09-15', '2024-08-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 53.7999992, 'Vector Trading House', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('783a8826-cbc3-4f6b-895b-7c745d7b8a45', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-08-19', '2024-09-16', '2024-08-24', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 41.9500008, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('aec74b64-be80-41ea-9fc4-8f08596e10cd', 'c628d310-118f-4d17-83c4-1cfcc82954a9', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-08-22', '2024-09-19', '2024-08-31', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 36.7099991, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('42d67757-88fd-4610-bbab-edeeff1c5535', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-08-23', '2024-09-20', '2024-09-05', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 34.8800011, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('e0f10858-09b1-4c3f-9ff0-c08d4f501b1d', '3130b75e-08d7-4937-bfde-1974a03c950a', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-08-24', '2024-09-21', '2024-08-31', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 19.6399994, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('0ee48f5a-d7e4-415f-968f-43b5474e5d80', '21c8bb0f-dfb4-460c-9136-0ca192e08207', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-08-25', '2024-09-22', '2024-08-30', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 288.429993, 'Jupiter Retail Systems', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');
INSERT INTO orders VALUES ('69d88805-775e-476d-83b5-eef75d4d8b38', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-08-26', '2024-09-23', '2024-09-05', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 131.699997, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('f36fe825-330a-44c5-a1cf-5d78522275a8', '748b439f-112d-44fa-91a4-670ef32d1621', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-08-26', '2024-09-23', '2024-09-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 183.169998, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('3627e278-3e34-4b30-8158-8465408d4ac6', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-08-29', '2024-09-26', '2024-09-01', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 96.0400009, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('d937a9a1-d038-46ef-b1a0-887503049ac3', '2a76dd54-c4c4-410f-bc6c-4d9f8a992e4d', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-08-30', '2024-09-27', '2024-09-07', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 30.5400009, 'Arbor Distribution Co', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany');
INSERT INTO orders VALUES ('fda4610f-bd4e-44f7-8d96-e6ec0779f82f', '00c51812-32fe-4ea7-93cd-6ac81afcce12', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-08-30', '2024-10-11', '2024-09-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 71.9700012, 'Phoenix Trading Inc', '35 King George', 'London', NULL, 'WX3 6FW', 'UK');
INSERT INTO orders VALUES ('5659ee93-fb08-449a-8e2e-e1ef619d0261', 'a3cd2482-6d56-4140-b063-ec86ab178603', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-08-31', '2024-09-28', '2024-09-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 22, 'Xenon Retail Corp', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico');
INSERT INTO orders VALUES ('dae8f2d1-4175-4192-8a98-90b1e016a31e', 'd3cbab71-5f3b-4754-9ccb-19e009469e7b', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-09-01', '2024-10-13', '2024-10-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 10.1400003, 'Summit Trade Group', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain');
INSERT INTO orders VALUES ('7deef82d-60b1-41f9-97e2-5d3b31a4e450', '350fda94-3e7d-4a1f-8408-fe06024eca1e', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-09-01', '2024-09-29', '2024-09-05', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 13.5500002, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('b8315d45-7a97-4d4e-b39f-53a77916491b', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-09-02', '2024-09-30', '2024-09-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 101.949997, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('02a3c1e0-cbad-4cd3-ae18-63a7ef933226', '39a6fd07-d871-4d12-889a-1bfd8d79dea2', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-09-05', '2024-10-03', '2024-09-12', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 195.679993, 'Quartz Retail Group', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA');
INSERT INTO orders VALUES ('c0ab77b1-48e8-439e-8174-09373d01b026', '346cfbc3-e2c8-4c26-92ec-df34bad2e944', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-09-06', '2024-10-04', '2024-09-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.16999996, 'Glacier Commerce Ltd', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland');
INSERT INTO orders VALUES ('a59c0bc7-5a6d-4bb6-b986-ff7e46fb4fe4', '3130b75e-08d7-4937-bfde-1974a03c950a', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-09-06', '2024-10-04', '2024-09-27', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.449999988, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('fbca218a-6267-42d3-a0d4-474f1475a7b8', 'd052d4e1-5069-4431-ba2f-4965bf158b31', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-09-07', '2024-10-05', '2024-09-12', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 890.780029, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('4ad125b6-e2d3-42c3-a87d-e7d868732b1f', 'a21a6b01-37f1-4462-95f2-595326e090f6', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-09-08', '2024-10-06', '2024-09-14', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 124.120003, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('f0374539-42f2-4c25-9b7b-9be511f28ee7', 'b4dc01c6-29d9-4799-b914-9424e6e210d9', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-09-08', '2024-10-06', '2024-09-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 3.94000006, 'Trident Trading Solutions', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland');
INSERT INTO orders VALUES ('f5bc86c4-540c-4529-b543-b7109a1b9528', 'e90985b6-e765-4c89-895f-fa2337e72a16', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-09-09', '2024-10-07', '2024-09-12', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 20.1200008, 'Gateway Trading House', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA');
INSERT INTO orders VALUES ('4c822e5d-a194-4040-98dd-e68bf90acb10', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-09-12', '2024-10-10', '2024-09-16', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 20.3899994, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('694291f0-1ee7-40d2-8802-9dcc89c7caf3', '21c8bb0f-dfb4-460c-9136-0ca192e08207', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-09-12', '2024-10-10', '2024-09-16', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 22.2099991, 'Jupiter Retail Systems', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');
INSERT INTO orders VALUES ('9981c9b7-813d-4e9b-bcea-993af63d3509', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-09-13', '2024-10-11', '2024-09-22', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 5.44000006, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('6dde5cd8-15c4-4ba0-8521-fc4d6c5fbea6', 'b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-09-14', '2024-10-12', '2024-09-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 45.0299988, 'Crown Retail Solutions', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO orders VALUES ('4f169ffd-44e5-4dce-9a89-60be90561f09', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-09-15', '2024-10-13', '2024-10-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 35.0299988, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('e843b9d7-5133-4dc6-852f-64b51732e027', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-09-15', '2024-10-13', '2024-09-16', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 7.98999977, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('9875f5ce-7318-4b0e-8d7b-c9de6348705d', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-09-16', '2024-10-14', '2024-09-19', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 94.7699966, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('ed6796a4-7d83-48d3-b9e4-8cbe930c5505', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-09-19', '2024-10-17', '2024-09-21', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 34.2400017, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('d77f05d7-85ff-4150-bc24-7324661e6e26', '216c4816-2434-466a-98ee-252ad3d9d933', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-09-19', '2024-10-17', '2024-09-23', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 168.639999, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('e22aa677-c328-4b23-829a-d16c08cb794b', '39a6fd07-d871-4d12-889a-1bfd8d79dea2', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-09-20', '2024-10-18', '2024-09-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 30.9599991, 'Quartz Retail Group', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA');
INSERT INTO orders VALUES ('6aac1019-d358-441a-8b28-56193ddde612', '1d42c341-838e-44f6-9a56-d831af2dfcff', 'bd734f3c-b888-489c-a098-4395f9565d97', '2024-09-21', '2024-10-05', '2024-09-28', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 13.9899998, 'Jetty Trading Solutions', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil');
INSERT INTO orders VALUES ('8631b4cf-4656-4f36-8bfd-40bc0e72b504', '070ee85e-07e7-4886-bf50-ba55c77160d9', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-09-21', '2024-10-19', '2024-09-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 93.6299973, 'Juniper Trading House', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway');
INSERT INTO orders VALUES ('321deeeb-9e3a-4776-ad15-71a7a9a775a3', '21c8bb0f-dfb4-460c-9136-0ca192e08207', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-09-22', '2024-10-20', '2024-09-23', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 34.8600006, 'Jupiter Retail Systems', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');
INSERT INTO orders VALUES ('d73f5254-a658-46ce-a5ff-79c3ca91308f', 'b331de10-47a7-468f-98db-ad5c2d1a041f', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-09-23', '2024-10-21', '2024-09-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 47.4199982, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('14f787ba-1445-458f-ae22-6fc49e0c90d0', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-09-26', '2024-10-24', '2024-09-29', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 126.379997, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('e14d681d-d9c0-4f2f-b9bf-4956a0e37543', '2a76dd54-c4c4-410f-bc6c-4d9f8a992e4d', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-09-26', '2024-10-24', '2024-10-04', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 5.44999981, 'Arbor Distribution Co', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany');
INSERT INTO orders VALUES ('0038d1e9-42fc-4c4c-a9de-2b27fb7c1042', '95ddaae9-9c82-4259-b319-1a46588a652a', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-09-27', '2024-10-25', '2024-10-05', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 122.459999, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('338d5c10-c260-4b11-a831-2486e69d0487', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-09-28', '2024-10-26', '2024-10-07', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 126.559998, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('ac32d227-90db-4073-86f6-78921493a1bf', 'e90985b6-e765-4c89-895f-fa2337e72a16', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-09-28', '2024-10-26', '2024-10-07', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 30.3400002, 'Gateway Trading House', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA');
INSERT INTO orders VALUES ('2fb9d4b3-e84d-4e4e-a9dc-67b91e6f68df', '0ef4332c-6383-486b-a577-0156519db661', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-09-29', '2024-10-27', '2024-10-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 184.410004, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('ffe78d78-6acc-426a-8b5d-257bb25b7217', '93eee301-36bd-466c-af34-ac22fd4afdb7', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-09-30', '2024-10-14', '2024-10-10', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 135.350006, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('7a1bae58-bffe-4adc-aaeb-efea92b11558', '82e1941f-8f2c-4015-bcec-36ec4ab51900', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-09-30', '2024-10-28', '2024-10-06', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 60.2599983, 'Quantum Retail Solutions', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal');
INSERT INTO orders VALUES ('963ecfa0-7547-4bfe-b0b2-da0d610a515a', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-10-03', '2024-10-31', '2024-10-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 89.1600037, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('22d3a6e3-c7dc-4921-8053-a33305655cab', '350fda94-3e7d-4a1f-8408-fe06024eca1e', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-10-04', '2024-10-18', '2024-10-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 27.3600006, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('71dd06dc-ef76-4ca4-bc7c-67571e83f6bc', '00c51812-32fe-4ea7-93cd-6ac81afcce12', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-10-05', '2024-11-02', '2024-10-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 83.9300003, 'Phoenix Trading Inc', '35 King George', 'London', NULL, 'WX3 6FW', 'UK');
INSERT INTO orders VALUES ('5efdbc16-7f0c-4ced-9afa-b8ed915b0d89', '2569e109-6d44-4f1a-8919-db63efb4ca9e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-10-05', '2024-11-02', '2024-10-14', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 12.5100002, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('3ca8d08b-aa3c-49e3-9f31-74d52b431e62', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-10-06', '2024-11-17', '2024-10-14', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 67.8799973, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('ff8c1665-29c7-4606-98fb-156afb72ee6e', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-10-07', '2024-11-04', '2024-10-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 73.7900009, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('791effc7-83e6-400e-8d6b-43cfd7f7e07b', '53e16308-5b76-4e70-b284-fe5958e79a0e', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-10-07', '2024-11-04', '2024-10-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 155.970001, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('b22fce26-40a8-4b59-977a-8cc82e4db6c3', 'e03bf9cd-810e-46fd-b925-48e73c12756a', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-10-10', '2024-11-07', '2024-10-26', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 34.8199997, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('7fb39fe3-37a4-4fa6-acac-af8cb8f56d07', 'd052d4e1-5069-4431-ba2f-4965bf158b31', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-10-11', '2024-11-22', '2024-10-17', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 108.040001, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('3d5e1ea2-97ea-4ad0-ad37-f5afb86774f8', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-10-11', '2024-11-08', '2024-11-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 91.4800034, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('52b0a8e8-99e6-46b2-9187-28687492f13a', 'c215d346-d4e2-43cc-911e-2e4fd17a370d', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-10-12', '2024-11-09', '2024-10-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 11.2600002, 'Grove Wholesale Ltd', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France');
INSERT INTO orders VALUES ('69512693-18ac-4dd9-8c63-111ced64fddc', 'ee578022-9abf-46ca-ad0e-76be2b19007c', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-10-13', '2024-11-10', '2024-10-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 29.8299999, 'Bloom Trading Partners', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('a529d48b-e5c3-4be6-be04-a24a56c1f38a', 'b331de10-47a7-468f-98db-ad5c2d1a041f', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-10-14', '2024-11-11', '2024-10-19', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 2.4000001, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('e916eddd-c929-4214-9872-26a956af348f', 'b331de10-47a7-468f-98db-ad5c2d1a041f', 'bd734f3c-b888-489c-a098-4395f9565d97', '2024-10-14', '2024-11-11', '2024-10-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 23.6499996, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('b17bd726-b5b9-4cdb-95b4-9223da29dd1d', 'af354600-23a9-4298-9157-75ff7c92a119', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-10-17', '2024-11-14', '2024-10-19', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.76999998, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('156c58dd-60c6-42b9-a350-1eb9fd2f6fe2', '3130b75e-08d7-4937-bfde-1974a03c950a', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-10-18', '2024-11-15', '2024-10-20', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 95.6600037, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('7c9d1b33-c5d5-45d1-bd17-e8c15c31257d', '1d42c341-838e-44f6-9a56-d831af2dfcff', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-10-18', '2024-11-15', '2024-10-21', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 21.4799995, 'Jetty Trading Solutions', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil');
INSERT INTO orders VALUES ('890fe993-54a5-4eb8-9bca-61e04f220a3e', 'e90985b6-e765-4c89-895f-fa2337e72a16', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-10-19', '2024-11-16', '2024-10-28', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.200000003, 'Gateway Trading House', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA');
INSERT INTO orders VALUES ('83a7b260-1175-4590-b35d-a6fd37ad5826', 'af354600-23a9-4298-9157-75ff7c92a119', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-10-20', '2024-11-17', '2024-10-31', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 22.7199993, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('1e0f2776-1ce3-47d9-aad0-a69bdd9c326a', 'f0d1b9c9-9e00-4a54-8276-07cced1288be', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-10-20', '2024-11-17', '2024-11-01', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 70.2900009, 'Maple Commerce Solutions', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark');
INSERT INTO orders VALUES ('a7e92be2-d778-40bf-87a0-e8849465bd9b', '748b439f-112d-44fa-91a4-670ef32d1621', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-10-21', '2024-11-18', '2024-10-28', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 17.5499992, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('0e144a17-9f6c-4ed7-9fd2-a2f56673fb8e', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-10-24', '2024-11-21', '2024-11-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 137.350006, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('76caa919-1346-4780-9ebd-537891fabd18', '5506f7ee-50bd-4a1e-a15d-b6f223d32c67', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-10-25', '2024-11-22', '2024-10-31', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 44.1199989, 'Horizon Merchants', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO orders VALUES ('a4725a41-9d5b-48fb-a387-2f4f606782b7', 'b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-10-25', '2024-12-06', '2024-10-31', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 99.2300034, 'Crown Retail Solutions', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO orders VALUES ('af53087d-25e3-41aa-acaf-c50802f4d434', '05464425-fc77-4a44-9a69-5f6f6ec147b9', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-10-26', '2024-11-23', '2024-11-04', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 3.01999998, 'Crimson Distribution Co', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy');
INSERT INTO orders VALUES ('76fbf3b0-961e-4ae2-aac3-d5eeb1245c2b', 'f7f06986-6907-4481-92af-bfc5511a56e7', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-10-27', '2024-11-10', '2024-11-28', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 24.5, 'Ultra Retail Systems', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO orders VALUES ('c6c0e72c-6c6c-458f-b569-666b245194d0', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-10-27', '2024-11-24', '2024-10-31', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 370.609985, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('a9eb360c-be27-49b9-aba9-150f47df869a', '3130b75e-08d7-4937-bfde-1974a03c950a', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-10-28', '2024-11-25', '2024-11-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 7.92999983, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('5b412191-7680-4897-87a1-1c2fce5e458b', 'd3cbab71-5f3b-4754-9ccb-19e009469e7b', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-10-31', '2024-11-28', '2024-11-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 18.6900005, 'Summit Trade Group', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain');
INSERT INTO orders VALUES ('2a72c5a7-5625-4ef9-9c13-9e179e189ba9', '95ddaae9-9c82-4259-b319-1a46588a652a', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-10-31', '2024-11-28', '2024-12-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 31.2900009, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('fa5436eb-f8a2-4785-954e-0f1097b58fb6', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-11-01', '2024-11-29', '2024-11-08', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 11.0900002, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('615e57f6-b219-4671-9594-0009fb6b4d12', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-02', '2024-12-14', '2024-11-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 56.6300011, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('53831dfa-7463-4597-b026-3db2250d38e5', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-11-03', '2024-11-17', '2024-11-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 458.779999, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('ab0770de-8e8a-4ea9-b7da-af2237a520a9', 'b331de10-47a7-468f-98db-ad5c2d1a041f', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-11-03', '2024-11-17', '2024-11-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 44.1699982, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('48290a08-2617-4ad2-8320-71a394ef7c17', '39a6fd07-d871-4d12-889a-1bfd8d79dea2', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-04', '2024-11-18', '2024-11-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.34000015, 'Quartz Retail Group', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA');
INSERT INTO orders VALUES ('9e9a82dd-cb1f-4650-8510-a31cae4a6d0f', '82e1941f-8f2c-4015-bcec-36ec4ab51900', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-07', '2024-12-05', '2024-12-06', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 73.8300018, 'Quantum Retail Solutions', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal');
INSERT INTO orders VALUES ('65a60a0c-ffb7-465b-b10d-50f14434bb27', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-07', '2024-12-05', '2024-11-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 17.9200001, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('9800c582-05a2-4c3d-96bc-037057106ebb', 'b272f285-be56-42e4-9a3b-b1ca1e35c44c', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-11-08', '2024-12-20', '2024-11-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 9.21000004, 'Magnolia Distribution Co', 'Berkeley Gardens 12  Brewery', 'London', NULL, 'WX1 6LT', 'UK');
INSERT INTO orders VALUES ('ac518e11-401d-4712-a060-320814a3f88a', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-09', '2024-12-07', '2024-11-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 156.660004, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('ed4b47db-7675-4972-944b-8d27a248cbfb', 'af354600-23a9-4298-9157-75ff7c92a119', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-11-09', '2024-12-07', '2024-11-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 19.9699993, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('358fb589-764e-43c8-b095-b7e4324da98b', '7379764d-d1e9-4e61-9016-7d804b30c2eb', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-10', '2024-12-08', '2024-11-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 8.23999977, 'Kestrel Supply Group', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany');
INSERT INTO orders VALUES ('56065909-525d-455a-865a-c01af709f980', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-11-11', '2024-12-09', '2024-11-14', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.07000017, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('88ca9a13-a927-428a-a012-7ce0ed971aab', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-11-14', '2024-12-12', '2024-12-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 86.5299988, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('ea344696-a00c-49e8-9dc6-a80c35c166d3', '7353f783-745c-41a9-8fe0-367246437f6d', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-14', '2024-12-26', '2024-12-16', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 73.0199966, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('631605ce-cb2a-4987-8d38-7e797a28d6d6', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-15', '2024-12-13', '2024-11-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 47.9399986, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('ba055ac4-dff7-49c8-8310-07fbe3e93724', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-11-16', '2024-12-14', '2024-11-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 13.9499998, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('c8016d0d-0100-4b92-a646-c20154c6b4d1', '216c4816-2434-466a-98ee-252ad3d9d933', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-16', '2024-12-14', '2024-11-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 3.5, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('96ddc922-1480-4dbb-8492-bd47d54d717d', '216c4816-2434-466a-98ee-252ad3d9d933', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-17', '2024-12-15', '2024-11-24', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 9.30000019, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('fba14cae-c850-4f94-8258-a058f765b2ce', '7379764d-d1e9-4e61-9016-7d804b30c2eb', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-11-18', '2024-12-16', '2024-11-23', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 14.6800003, 'Kestrel Supply Group', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany');
INSERT INTO orders VALUES ('2a272b6c-df13-42e2-8925-f9f33215a3aa', '08593d96-6aac-44cc-9aff-b5c963fc26db', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-11-18', '2024-12-16', '2024-12-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 68.6600037, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('2de3ba01-2a5a-4f07-94d9-b995288182bb', 'c409b555-9e62-4606-b2ff-63dacb2c17dc', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-11-21', '2024-12-19', '2024-11-28', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 38.8199997, 'Liberty Trading Partners', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('a3713045-4330-4011-af01-611ff7a1a867', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-11-22', '2024-12-20', '2024-12-01', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 53.2999992, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('1611192f-4abc-4a91-9fb3-937e53eac7c1', '0668ebca-a25a-4c6a-b84c-7943bf00171e', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-11-23', '2024-12-21', '2024-12-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 7.23000002, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('a42adc23-cf54-41ae-9e06-03b4e7dbb09a', '748b439f-112d-44fa-91a4-670ef32d1621', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-11-23', '2024-12-07', '2024-12-14', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 189.089996, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('b462bacb-6603-4be0-bd66-cb483d01f568', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-11-24', '2024-12-22', '2024-11-30', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 140.259995, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('3ed8d7ad-745a-416f-938f-5374fff9e27b', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-11-25', '2024-12-23', '2024-11-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 25.3600006, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('ec683815-0bf7-495f-8dc5-1cfb6a0000ca', '3130b75e-08d7-4937-bfde-1974a03c950a', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-11-25', '2024-12-23', '2024-11-29', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 2.74000001, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('da2d6c6f-db56-4238-93f1-3f249fd533f7', 'af354600-23a9-4298-9157-75ff7c92a119', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-11-28', '2025-01-09', '2024-12-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 180.449997, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('4a381afe-70fa-42c3-8b78-b91a5ffac1b4', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-11-29', '2025-01-10', '2024-12-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 8.11999989, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('ebe03178-8c50-4e1e-87f0-2e7ca5c18c71', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-11-29', '2024-12-27', '2024-12-05', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 11.5699997, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('2c54f6a6-742b-44a1-be8f-8f3878d10080', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-11-30', '2024-12-28', '2024-12-06', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 147.059998, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('ba3d61f0-f4ee-4511-80b4-50415d86de78', '0668ebca-a25a-4c6a-b84c-7943bf00171e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-12-01', '2024-12-29', '2024-12-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 25.0900002, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('3f3e83d7-af16-46d9-b0a9-489a435a511c', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-12-02', '2024-12-30', '2024-12-05', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 16.2700005, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('1f7a33b9-5d00-4abf-b7b4-13bb8d885bed', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-12-02', '2024-12-30', '2024-12-07', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 148.610001, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('c682a85b-f60d-4cf6-bf6e-a5e5b99bb0c5', 'b272f285-be56-42e4-9a3b-b1ca1e35c44c', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-12-05', '2025-01-02', '2024-12-20', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 6.17000008, 'Magnolia Distribution Co', 'Berkeley Gardens 12  Brewery', 'London', NULL, 'WX1 6LT', 'UK');
INSERT INTO orders VALUES ('0a28bbf3-38bb-4334-b058-938f34af0560', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-12-06', '2025-01-03', '2024-12-08', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 14.7799997, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('2e8ecf9f-e2ce-478e-b828-6111c8bdaace', '73ac725b-10e5-410f-bddd-d9c60fd0ec46', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-12-06', '2025-01-03', '2024-12-16', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 89, 'Acorn Trading House', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal');
INSERT INTO orders VALUES ('ed2fcf6f-4b85-496d-a9b8-46f564002127', '350fda94-3e7d-4a1f-8408-fe06024eca1e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-12-07', '2025-01-04', '2024-12-16', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 145.039993, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('af60e792-2aef-4a2b-b20d-d8797443f570', '1d3de59b-fd0b-4277-8192-b02fda2e41db', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-12-08', '2025-01-05', '2024-12-15', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 11.9300003, 'Oak Retail Systems', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil');
INSERT INTO orders VALUES ('4e6e5f4c-af33-4ddc-b5ac-fb38fe982244', '53e16308-5b76-4e70-b284-fe5958e79a0e', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-12-08', '2025-01-05', '2024-12-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.92999983, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('dad7a7cc-c14f-44d8-8088-5ce6ba7837b7', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-12-09', '2025-01-06', '2024-12-14', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 44.1199989, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('0671413f-bbb5-4874-b7bc-ddd6bec1b99b', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-12-12', '2025-01-09', '2024-12-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 60.1800003, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('ec6287b4-e4a0-4ac4-a256-698b051fac2e', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-12-13', '2025-01-10', '2024-12-16', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 64.5599976, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('204fcb58-517a-4c75-a1ea-2e0df26b1e36', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-12-13', '2025-01-10', '2024-12-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 45.5900002, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('dd5995a0-0bd8-4761-8a89-db1a14acf28b', '21c8bb0f-dfb4-460c-9136-0ca192e08207', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-12-14', '2025-01-11', '2024-12-21', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 4.19999981, 'Jupiter Retail Systems', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');
INSERT INTO orders VALUES ('2de05c49-311b-4925-8ccb-e2203ecc0628', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-12-15', '2024-12-29', '2024-12-23', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 16.3700008, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('6baddb23-60bb-467e-92f7-08e9cd1dee8d', '078abbfd-fbac-4432-9528-c7a98ea5351c', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-12-15', '2025-01-12', '2024-12-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 83.4899979, 'Vector Trading House', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('dc12ecd8-2d36-4d24-88f1-792c87ccbe8b', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', 'bd734f3c-b888-489c-a098-4395f9565d97', '2024-12-16', '2025-01-13', '2025-01-06', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 68.5199966, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('4a7715bc-b104-4237-9cfc-f58dc1816970', '0ef4332c-6383-486b-a577-0156519db661', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-12-19', '2025-01-16', '2024-12-26', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.40999985, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('9ebf9bd5-e441-44d4-aa2f-c7a11564695a', '82e1941f-8f2c-4015-bcec-36ec4ab51900', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2024-12-19', '2025-01-16', '2024-12-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 13.0200005, 'Quantum Retail Solutions', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal');
INSERT INTO orders VALUES ('1eb08da9-5cae-428f-ad0d-6d9816c9493a', '0668ebca-a25a-4c6a-b84c-7943bf00171e', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-12-20', '2025-01-03', '2024-12-28', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.80999994, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('f0429157-f54b-4dad-a641-544b2089fc27', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-12-21', '2025-01-18', '2024-12-23', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 708.950012, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('4dc9fd79-ade2-48d4-b638-d5e5ff8c84f8', 'c215d346-d4e2-43cc-911e-2e4fd17a370d', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-12-22', '2025-01-19', '2024-12-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.35000002, 'Grove Wholesale Ltd', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France');
INSERT INTO orders VALUES ('34844818-efef-484a-bfad-0663823f2576', '08593d96-6aac-44cc-9aff-b5c963fc26db', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-12-22', '2025-01-19', '2024-12-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 64.3300018, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('8cc52457-d2e1-4e61-ac32-ff6307fe093f', 'c4ff5bd7-09c1-4721-b196-e259f82a77d3', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-12-23', '2025-01-20', '2025-01-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 7.48000002, 'Yarrow Commerce Ltd', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA');
INSERT INTO orders VALUES ('14cd07c7-9812-4193-99c8-78c3af28c8a7', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2024-12-26', '2025-01-23', '2025-01-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 15.2799997, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('a6d0ed0c-a148-447c-8af0-87e6a389c91c', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2024-12-26', '2025-01-23', '2025-01-03', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 6.88000011, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('d7c9c099-944b-4522-84d5-f50707b9aa5f', 'e03bf9cd-810e-46fd-b925-48e73c12756a', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2024-12-27', '2025-01-10', '2025-01-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 64.4499969, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('ed59a6ef-782d-46aa-be9b-627be3c8734e', '0ef4332c-6383-486b-a577-0156519db661', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2024-12-28', '2025-01-25', '2025-01-04', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 30.5300007, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('ae7f601b-389b-47bb-b9b1-f40e3d050715', 'd052d4e1-5069-4431-ba2f-4965bf158b31', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2024-12-28', '2025-01-25', '2024-12-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 71.0699997, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('f2fbc312-1b3d-4104-834e-fcaf7fcbcf14', '93eee301-36bd-466c-af34-ac22fd4afdb7', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2024-12-29', '2025-01-26', '2025-01-04', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.92999983, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('3ce51690-ad62-4371-8047-8bf25c509e12', '95ddaae9-9c82-4259-b319-1a46588a652a', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2024-12-30', '2025-01-27', '2025-01-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 5.28999996, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('26bb31e2-8371-40f8-8b7c-a801b0479b2d', '0ef4332c-6383-486b-a577-0156519db661', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-01-02', '2025-01-30', '2025-01-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 210.190002, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('3bb544ce-23d3-442e-a0dc-c1d2bd4b6fe8', '73ac725b-10e5-410f-bddd-d9c60fd0ec46', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-01-02', '2025-01-30', '2025-01-10', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 16.9599991, 'Acorn Trading House', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal');
INSERT INTO orders VALUES ('57eaf0ee-d214-4e9a-accd-7900c56da7d9', 'b331de10-47a7-468f-98db-ad5c2d1a041f', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-01-03', '2025-01-31', '2025-01-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 62.8899994, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('0f8a9af2-9960-44e8-a1ed-31675cc3aaaa', '3130b75e-08d7-4937-bfde-1974a03c950a', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-01-04', '2025-02-01', '2025-01-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 10.6400003, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('18b33bb6-b3e0-4a5f-aeb5-e0ccc7d2e712', '1d3de59b-fd0b-4277-8192-b02fda2e41db', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-01-04', '2025-02-01', '2025-01-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 65.9899979, 'Oak Retail Systems', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil');
INSERT INTO orders VALUES ('b65e9f48-d5f7-4991-9539-c525a0ddd906', '1ea1f996-0e67-4874-b697-9817333eeb70', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-01-05', '2025-02-02', '2025-01-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.6500001, 'Eden Commerce Group', '2319 Elm St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada');
INSERT INTO orders VALUES ('9baf0e3b-66d5-40f4-ad56-4e8a4c2a4a50', 'ce6bfe1b-34e1-4750-a003-271ce4dc6912', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-01-06', '2025-02-03', '2025-01-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 46.7700005, 'Keystone Supply Chain', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil');
INSERT INTO orders VALUES ('2e0e5268-038f-403e-a512-f9f8fa18229b', '79222616-f296-416f-a386-57a31c0d15d7', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-01-06', '2025-02-03', '2025-01-09', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 36.2099991, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('276b7a04-a975-4704-8f4d-c16ce0c7207c', '0ef4332c-6383-486b-a577-0156519db661', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-01-09', '2025-02-06', '2025-01-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 29.75, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('f2b3b226-b1a5-4394-8196-e7cd3ec2d2f2', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-01-10', '2025-02-07', '2025-01-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 102.019997, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('ae611f6d-e070-4b4a-82b4-326d41276594', '3130b75e-08d7-4937-bfde-1974a03c950a', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-01-11', '2025-02-08', '2025-01-19', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 42.6800003, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('156383ba-f212-45ae-963a-93e8eec5b7bd', 'aaa1023c-07bb-4f15-8278-1f9c43d16275', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-01-11', '2025-02-08', '2025-01-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 8.85000038, 'Atlas Trading Partners', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany');
INSERT INTO orders VALUES ('a1fcde02-51b6-4fdb-9ade-037a45f656e4', '078abbfd-fbac-4432-9528-c7a98ea5351c', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-01-12', '2025-02-09', '2025-01-31', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 69.3199997, 'Vector Trading House', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('15a5e4fc-7a90-4d4b-9df2-cc9a8a3d8659', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-01-13', '2025-02-10', '2025-01-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 16.7399998, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('8806978f-7d3a-484c-a711-e3e1345c5635', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-01-13', '2025-02-10', '2025-01-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 59.1300011, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('2bb6e532-f2ee-430d-8b87-d357d8eb82fd', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-01-16', '2025-02-13', '2025-01-23', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 7.13000011, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('ac83f515-d40a-4413-b9c9-b013d7f80d2e', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-01-17', '2025-02-14', '2025-02-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 21.1900005, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('b13ae47f-abd2-4f0e-aaf6-aed7b4251bab', 'a3cd2482-6d56-4140-b063-ec86ab178603', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-01-17', '2025-02-14', '2025-01-24', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 47.4500008, 'Xenon Retail Corp', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico');
INSERT INTO orders VALUES ('c25c5441-f323-409d-a265-84cf0bdeca30', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-01-18', '2025-02-15', '2025-02-14', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.98999977, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('e1079084-7a83-492f-a528-19bde4b52e12', 'aaa1023c-07bb-4f15-8278-1f9c43d16275', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-01-19', '2025-02-16', '2025-01-31', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.150000006, 'Atlas Trading Partners', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany');
INSERT INTO orders VALUES ('4d7bb73f-0dda-4ee9-b2b7-4891284d3041', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-01-20', '2025-02-17', '2025-01-30', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 367.630005, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('42152ad0-121d-4b23-a110-8cff8cb4c35c', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-01-20', '2025-02-17', '2025-01-23', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 350.640015, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('3aed2697-2c6c-4a91-b97a-3432c5e6cc01', '1d42c341-838e-44f6-9a56-d831af2dfcff', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-01-23', '2025-02-20', '2025-01-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.52999997, 'Jetty Trading Solutions', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil');
INSERT INTO orders VALUES ('37e579b6-7211-48ba-9100-70adff750d93', 'c628d310-118f-4d17-83c4-1cfcc82954a9', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-01-24', '2025-03-07', '2025-01-30', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 105.650002, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('1942ffb4-08c6-4926-b7c5-c314dde3426c', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-01-24', '2025-02-21', '2025-02-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 789.950012, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('9bc9027a-dd7f-42d5-85c6-9ea01e69b2eb', '748b439f-112d-44fa-91a4-670ef32d1621', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-01-25', '2025-02-08', '2025-02-24', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 204.470001, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('88e49637-1c69-43f8-bfba-3b67c2cb17f8', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-01-26', '2025-02-23', '2025-02-02', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 62.7799988, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('66c908d0-6ab0-40ca-8567-ab250f9b88bb', '1e6dd3f8-3c44-4fac-9b97-016270116762', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-01-26', '2025-02-23', '2025-01-31', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 32.0699997, 'Frost Supply Partners', 'South House 300 Queensbridge', 'London', NULL, 'SW7 1RZ', 'UK');
INSERT INTO orders VALUES ('d57d66ca-d239-4b07-8951-14ac5a4c0bb7', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-01-27', '2025-02-10', '2025-02-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 218.149994, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('a85fb290-8b30-463b-a043-68a9b16e1e41', '346cfbc3-e2c8-4c26-92ec-df34bad2e944', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-01-30', '2025-02-27', '2025-02-02', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 91.7600021, 'Glacier Commerce Ltd', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland');
INSERT INTO orders VALUES ('cd7e2bf6-1ff1-46f4-b314-3f9571b64cf4', '070ee85e-07e7-4886-bf50-ba55c77160d9', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-01-31', '2025-02-28', '2025-02-02', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 13.3699999, 'Juniper Trading House', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway');
INSERT INTO orders VALUES ('8a17e346-20c7-474f-bc7e-aa36e93b0272', '26240386-a6ca-4a18-910d-904cde61d93b', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-01-31', '2025-02-28', '2025-02-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 17.2199993, 'Dawn Supply Ltd', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('38270f94-e61d-4c77-b4a5-b256064eb07e', '79222616-f296-416f-a386-57a31c0d15d7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-02-01', '2025-03-01', '2025-02-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 45.3300018, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('1df2f0e8-bd11-420e-b2e9-d24ac867af6a', '21c8bb0f-dfb4-460c-9136-0ca192e08207', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-02-02', '2025-03-02', '2025-03-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 77.6299973, 'Jupiter Retail Systems', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');
INSERT INTO orders VALUES ('ad0ceb18-93bc-468c-a4db-7c0bf7d48f47', '216c4816-2434-466a-98ee-252ad3d9d933', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-02-02', '2025-03-02', '2025-02-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 244.789993, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('0c283b77-160c-4a6f-87fa-d9bd494b358e', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-02-03', '2025-03-03', '2025-02-24', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 11.0600004, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('73fdf0e7-1ccb-4143-98c0-40bd408b7bab', 'af354600-23a9-4298-9157-75ff7c92a119', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-02-06', '2025-03-06', '2025-02-16', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 58.5900002, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('470a20ff-2c0a-4403-b7ad-6621cd55110b', '748b439f-112d-44fa-91a4-670ef32d1621', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-02-06', '2025-03-06', '2025-02-08', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 41.9000015, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('e6199921-15f5-46a1-b2b4-fcef72f0cf21', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-02-07', '2025-02-21', '2025-02-10', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.3499999, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('4c85a257-a8dd-4977-a9a6-b0dc8ddcacca', 'eb488881-56d2-4219-a3b5-26ff37fb74be', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-02-08', '2025-03-08', '2025-02-10', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 66.6900024, 'Cobalt Commerce Group', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium');
INSERT INTO orders VALUES ('a8d98fde-30b5-48aa-b2e3-c371f916a0c2', '95ddaae9-9c82-4259-b319-1a46588a652a', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-02-09', '2025-03-09', '2025-02-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 339.220001, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('af68dd9a-01de-4c9d-8484-7f5122d3aef0', 'ee578022-9abf-46ca-ad0e-76be2b19007c', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-02-09', '2025-03-09', '2025-02-20', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 8.11999989, 'Bloom Trading Partners', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('2abc0766-7993-48a2-aa81-111a6dfdac8a', '00c51812-32fe-4ea7-93cd-6ac81afcce12', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-02-10', '2025-03-10', '2025-02-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 74.4599991, 'Phoenix Trading Inc', '35 King George', 'London', NULL, 'WX3 6FW', 'UK');
INSERT INTO orders VALUES ('967cc3d8-d56d-472f-9370-e52e46fdf638', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-02-13', '2025-03-13', '2025-02-23', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 188.039993, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('d9796b2c-dec4-4d1f-95d2-e64aadd2794f', '79222616-f296-416f-a386-57a31c0d15d7', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-02-13', '2025-03-13', '2025-02-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 27.9400005, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('a8620bab-4867-4f30-ba30-a3bc3a317c5c', 'a3cd2482-6d56-4140-b063-ec86ab178603', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-02-14', '2025-03-14', '2025-02-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 15.6400003, 'Xenon Retail Corp', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico');
INSERT INTO orders VALUES ('9d278f16-3771-42e1-977a-cc2f3d25ce12', '79222616-f296-416f-a386-57a31c0d15d7', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-02-15', '2025-03-15', '2025-03-10', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 58.8800011, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('128bb5fd-d508-4f99-bfad-72a1da5f7321', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-02-15', '2025-03-01', '2025-02-20', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 78.8499985, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('2f392c65-f42b-4a5a-a8a2-5f20e4280a73', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-02-16', '2025-03-16', '2025-02-17', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.86999989, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('43e970e0-f6de-4d15-9c69-6e4b9694fea7', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-02-17', '2025-03-17', '2025-02-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 12.3599997, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('f79bce2e-cd18-478b-a56d-f8b11d1dbf24', '748b439f-112d-44fa-91a4-670ef32d1621', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-02-20', '2025-03-20', '2025-03-17', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1007.64001, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('177fd68f-48d9-41db-8656-44967bd9fd13', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-02-20', '2025-03-20', '2025-03-02', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 68.6500015, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('a0d77b29-b4da-4502-899a-93e0e1a6d9a5', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-02-21', '2025-03-21', '2025-02-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 10.9499998, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('af253df8-dca6-45a8-892c-0560d5512433', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-02-22', '2025-03-22', '2025-02-24', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 48.1699982, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('ec68c5f1-9ed6-433b-a1b1-1aa5839df3bd', 'e56705d0-d0c1-463d-a72a-43b95b4e4c45', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-02-22', '2025-03-22', '2025-03-03', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 24.9099998, 'Pine Supply Group', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA');
INSERT INTO orders VALUES ('d8c2cc27-13fe-4ae4-a2bd-1904110535de', 'c4ff5bd7-09c1-4721-b196-e259f82a77d3', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-02-23', '2025-03-23', '2025-03-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 11.9200001, 'Yarrow Commerce Ltd', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA');
INSERT INTO orders VALUES ('fe4802b1-89ba-4385-9919-beee9bbf80ee', '0668ebca-a25a-4c6a-b84c-7943bf00171e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-02-24', '2025-03-24', '2025-02-28', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 194.720001, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('8068af5f-c1fd-4454-a34a-6f995394b60c', '21c8bb0f-dfb4-460c-9136-0ca192e08207', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-02-24', '2025-03-24', '2025-03-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 178.429993, 'Jupiter Retail Systems', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');
INSERT INTO orders VALUES ('0831404d-5863-4290-82d4-1611971cc0bd', '7379764d-d1e9-4e61-9016-7d804b30c2eb', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-02-27', '2025-03-27', '2025-03-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.42999995, 'Kestrel Supply Group', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany');
INSERT INTO orders VALUES ('59b259f5-1436-4fae-9e66-addabb07adba', '748b439f-112d-44fa-91a4-670ef32d1621', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-02-28', '2025-03-14', '2025-03-03', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 171.240005, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('fd236be8-b4f3-4dd6-8fb2-56d4032020d0', '74661752-05c4-445c-9b23-573d5c0d6e19', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-03-01', '2025-03-29', '2025-03-10', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.32000017, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('aac71447-ff91-4aaf-a953-c16c9c131d16', '73ac725b-10e5-410f-bddd-d9c60fd0ec46', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-03-01', '2025-04-12', '2025-03-10', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 72.9499969, 'Acorn Trading House', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal');
INSERT INTO orders VALUES ('d34b36c7-4d52-4cba-9afc-90be79aeec55', '0ef4332c-6383-486b-a577-0156519db661', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-03-02', '2025-03-30', '2025-03-09', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 83.2200012, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('7b456c48-9ea3-4161-a946-bbf7347f7371', 'af354600-23a9-4298-9157-75ff7c92a119', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-03-03', '2025-03-31', '2025-03-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 149.490005, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('308505a8-fab7-461e-bb8b-83ccbcb8716e', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-03-03', '2025-03-31', '2025-03-09', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 120.970001, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('31d561ae-e012-4d83-989b-beda68f95656', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-03-06', '2025-04-03', '2025-03-08', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 252.490005, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('eb34e8b4-7017-4158-9c1e-c3ed660539f5', 'f0d1b9c9-9e00-4a54-8276-07cced1288be', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-03-07', '2025-04-18', '2025-03-17', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 9.80000019, 'Maple Commerce Solutions', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark');
INSERT INTO orders VALUES ('d9572a1d-dbe5-4341-811f-3fe30e06c26f', '79222616-f296-416f-a386-57a31c0d15d7', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-03-07', '2025-03-21', '2025-03-10', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 96.7200012, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('3e8e7621-b056-4ab2-bc50-ddcf34b08622', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-03-08', '2025-04-05', '2025-03-14', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 72.9700012, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('b9861dda-1001-4c94-8ad0-3a6d246458e7', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-03-09', '2025-04-06', '2025-03-17', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 8.05000019, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('31af289e-d67c-4524-8820-2cb6f7cc1410', '93eee301-36bd-466c-af34-ac22fd4afdb7', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-03-10', '2025-04-07', '2025-03-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 36.6500015, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('08cd824b-51d1-4aad-837c-5e80fde7ad2c', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-03-10', '2025-04-07', '2025-03-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 242.210007, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('dc79a939-51d1-428f-a71d-f249faba6938', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-03-13', '2025-04-10', '2025-03-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 22.9500008, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('2c3a96a2-3f5a-49fd-a9ea-b0f015e96fed', '08593d96-6aac-44cc-9aff-b5c963fc26db', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-03-14', '2025-04-25', '2025-03-28', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 60.4300003, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('63e2f858-37c7-46a2-b56e-ba1db1747887', '2569e109-6d44-4f1a-8919-db63efb4ca9e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-03-14', '2025-04-11', '2025-03-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 13.75, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('91f040eb-c107-4cf0-8fb6-02fa180dc929', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-03-15', '2025-04-12', '2025-03-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 7.1500001, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('828ff826-8334-4ef1-bffb-984dbd35a983', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-03-16', '2025-04-13', '2025-03-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 88.4000015, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('85784905-2b17-454f-8c17-ea6a26ff601e', 'a21a6b01-37f1-4462-95f2-595326e090f6', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-03-16', '2025-04-13', '2025-03-21', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 33.9700012, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('c8320389-4ef1-43cb-ad5b-f73c9997e7ff', 'd3cbab71-5f3b-4754-9ccb-19e009469e7b', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-03-17', '2025-04-14', '2025-04-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 6.53999996, 'Summit Trade Group', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain');
INSERT INTO orders VALUES ('b18f3620-37f7-41ae-b232-d22f5d6d06a4', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-03-20', '2025-04-17', '2025-04-14', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 58.9799995, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('d855fdb9-07a3-497d-a7ce-e0e059609020', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-03-21', '2025-04-18', '2025-03-23', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 188.990005, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('6e25f8d7-b0d9-4ca7-975f-5f1863248c48', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-03-21', '2025-05-02', '2025-04-07', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 26.0599995, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('1c0d14f9-1493-4557-a8c9-1a0d7ebc0787', '216c4816-2434-466a-98ee-252ad3d9d933', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-03-22', '2025-04-19', '2025-03-29', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 116.43, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('8a4df845-de14-4402-800f-11247471056b', 'a3cd2482-6d56-4140-b063-ec86ab178603', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-03-23', '2025-04-20', '2025-03-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 84.8399963, 'Xenon Retail Corp', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico');
INSERT INTO orders VALUES ('584be20a-d89c-4f19-bf2b-e11f97861917', '91e82c3d-bf19-4224-9571-a65057c5916e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-03-23', '2025-04-20', '2025-04-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 37.5999985, 'Crestview Distribution Ltd', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA');
INSERT INTO orders VALUES ('e6abd166-aa4b-4d88-abaf-d0dc13b9171f', '404621e7-d665-4801-bfce-aa17d22b435f', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-03-24', '2025-04-07', '2025-04-03', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 127.339996, 'Neptune Commerce Ltd', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany');
INSERT INTO orders VALUES ('e650dd0b-12e6-42a3-ab80-a13397f4d559', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-03-27', '2025-04-10', '2025-04-03', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 18.5599995, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('a7b64d14-d4b8-47c5-973a-449ae30d114c', '91e82c3d-bf19-4224-9571-a65057c5916e', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-03-27', '2025-05-08', '2025-04-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 25.4099998, 'Crestview Distribution Ltd', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA');
INSERT INTO orders VALUES ('92ac8fa8-66a7-498b-a9fe-0f81fcd43833', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-03-28', '2025-04-25', '2025-04-28', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 29.6000004, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('83656ad5-d398-4aaf-9238-b1aaba4f03d2', 'c71720d2-cb57-45c6-8b31-7a7b96f72646', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-03-29', '2025-04-26', '2025-04-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 13.7299995, 'Olympus Distribution Co', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA');
INSERT INTO orders VALUES ('87bb7966-533f-4799-9c29-943ffba782a9', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-03-30', '2025-04-27', '2025-04-04', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 75.8899994, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('76263615-543c-4c51-9022-ec97ad54b362', '1d42c341-838e-44f6-9a56-d831af2dfcff', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-03-30', '2025-04-27', '2025-04-05', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 3.00999999, 'Jetty Trading Solutions', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil');
INSERT INTO orders VALUES ('324840bf-8c10-4060-b578-cc72be5c1c76', 'aaa1023c-07bb-4f15-8278-1f9c43d16275', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-03-31', '2025-04-28', '2025-04-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 27.7099991, 'Atlas Trading Partners', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany');
INSERT INTO orders VALUES ('bd5aa245-7db9-40fc-a00e-1ed80aeab821', 'af354600-23a9-4298-9157-75ff7c92a119', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-04-03', '2025-05-01', '2025-04-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 7.28000021, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('ad33c4d1-7e4d-42d5-b7da-7b349d6cc18d', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-04-03', '2025-05-01', '2025-04-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 59.1399994, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('ea66473f-5962-4c7a-bbcf-86256717eb10', '5506f7ee-50bd-4a1e-a15d-b6f223d32c67', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-04-04', '2025-05-02', '2025-04-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 13.4099998, 'Horizon Merchants', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO orders VALUES ('3e28f8cb-6c54-41fa-a731-e0daf247ec51', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-04-05', '2025-05-03', '2025-04-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.479999989, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('5f0e4412-7430-48c1-b726-ad812e690be3', 'b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-04-05', '2025-05-03', '2025-04-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 62.5200005, 'Crown Retail Solutions', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO orders VALUES ('b951d52f-db3a-4cd4-8777-50cc9f664177', '748b439f-112d-44fa-91a4-670ef32d1621', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-04-06', '2025-05-04', '2025-04-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 194.669998, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('de8c672e-786e-4dc3-b7cb-4fb2c33ee7c3', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-04-07', '2025-05-05', '2025-04-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.42000008, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('6fd21927-4149-4582-a436-0938b079ef19', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-04-10', '2025-05-08', '2025-04-17', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 44.7700005, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('f99216ea-b34a-4b01-9b2d-f591a68184a6', '350fda94-3e7d-4a1f-8408-fe06024eca1e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-04-10', '2025-04-24', '2025-04-19', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 55.9199982, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('860ac2f8-a4ef-4e56-b323-ba75564de9d7', '79222616-f296-416f-a386-57a31c0d15d7', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-04-11', '2025-05-09', '2025-04-19', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 32.0999985, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('6c275f6d-808e-4918-a692-63b7f6c75a5d', '79222616-f296-416f-a386-57a31c0d15d7', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-04-12', '2025-05-10', '2025-05-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 174.199997, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('f478be96-6ad5-4ba3-a3b4-0621bd668e6a', '7353f783-745c-41a9-8fe0-367246437f6d', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-04-12', '2025-05-10', '2025-04-19', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 5.23999977, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('3dba3d93-d5d2-410f-800e-28adc35b2c99', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-04-13', '2025-05-11', '2025-04-17', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 96.7799988, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('b1a973b6-7832-488d-9167-f0087af01c79', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-04-14', '2025-05-12', '2025-05-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 16.3400002, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('f8855cfb-42ae-4e95-9b84-2d9c773b3ef4', '95ddaae9-9c82-4259-b319-1a46588a652a', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-04-14', '2025-05-12', '2025-04-21', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 35.1199989, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('99df4f1f-515a-4ea9-92b8-7b21d923be32', '2569e109-6d44-4f1a-8919-db63efb4ca9e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-04-17', '2025-05-15', '2025-04-21', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 44.4199982, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('563ba2d1-617a-4eed-88ee-bf30e2892737', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-04-18', '2025-05-30', '2025-04-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 29.9799995, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('4603d4c3-7b71-4a1d-8567-b2e8001bcd88', 'e90985b6-e765-4c89-895f-fa2337e72a16', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-04-19', '2025-05-17', '2025-04-24', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 45.1300011, 'Gateway Trading House', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA');
INSERT INTO orders VALUES ('edaa92d2-8f07-4637-9ed3-3168ca2584f3', '0ef4332c-6383-486b-a577-0156519db661', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-04-19', '2025-05-31', '2025-04-25', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 58.2999992, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('67efbad1-591b-4988-ab28-89b75263a433', '350fda94-3e7d-4a1f-8408-fe06024eca1e', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-04-20', '2025-05-18', '2025-04-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 2.92000008, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('27ba5c56-5716-4e9a-b446-f82f4272d215', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-04-21', '2025-05-19', '2025-05-12', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 48.7700005, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('fa5fdec2-1fe8-4e98-a5a3-38414de23ba3', '73ac725b-10e5-410f-bddd-d9c60fd0ec46', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-04-21', '2025-05-19', '2025-05-02', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 7.46000004, 'Acorn Trading House', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal');
INSERT INTO orders VALUES ('d09ef434-ef5d-4c67-a6b4-4df5369a26db', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-04-24', '2025-05-22', '2025-05-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 379.130005, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('de15dd54-f7ef-4f9b-b93a-610549fcb76a', 'ce6bfe1b-34e1-4750-a003-271ce4dc6912', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-04-25', '2025-05-23', '2025-05-04', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 79.4000015, 'Keystone Supply Chain', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil');
INSERT INTO orders VALUES ('2515492a-6c4c-4486-94ce-a8a96f60dc0a', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-04-25', '2025-05-23', '2025-04-28', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 200.240005, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('b072f792-d2d7-428f-ba98-c20a362e6520', '7379764d-d1e9-4e61-9016-7d804b30c2eb', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-04-26', '2025-05-24', '2025-05-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 27.7900009, 'Kestrel Supply Group', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany');
INSERT INTO orders VALUES ('f9bc5fd1-2546-458f-a939-10efed0daf89', 'c81e7c16-d8f1-43a8-a1c4-27847709ce21', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-04-27', '2025-05-25', '2025-05-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.85000002, 'Elm Commerce Group', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France');
INSERT INTO orders VALUES ('4fa09d91-d7c0-470d-9060-44a7d349cf3e', '3130b75e-08d7-4937-bfde-1974a03c950a', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-04-28', '2025-05-26', '2025-05-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 26.7800007, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('35fb810b-e426-4b93-86f3-bc71cc8ff98c', 'b4dc01c6-29d9-4799-b914-9424e6e210d9', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-04-28', '2025-05-26', '2025-05-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 80.6500015, 'Trident Trading Solutions', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland');
INSERT INTO orders VALUES ('acbdca6b-7e3b-460c-aa98-199230ba24b7', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-05-01', '2025-05-29', '2025-05-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 544.080017, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('892a89bb-5504-40b2-997d-d306fc8c5eff', '0ef4332c-6383-486b-a577-0156519db661', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-02', '2025-05-30', '2025-05-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 8.10999966, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('b05213d6-28d4-4a49-bf6b-2727082a1400', 'aaa1023c-07bb-4f15-8278-1f9c43d16275', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-05-02', '2025-05-30', '2025-05-05', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.92999995, 'Atlas Trading Partners', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany');
INSERT INTO orders VALUES ('8c8862ee-add6-4f06-94be-889243d43745', '01a81542-e365-4854-a3ae-fb1d7e0a4fa2', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-05-03', '2025-05-31', '2025-05-10', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 0.75, 'Harbor Wholesale Co', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland');
INSERT INTO orders VALUES ('79c5bab5-bbb1-4ff2-8a1e-808e849e012f', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-05-04', '2025-06-01', '2025-05-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 116.529999, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('0d42ddb9-c50b-4fd4-b654-d3ff5cc584a5', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-04', '2025-06-01', '2025-05-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 18.5300007, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('5601daea-74d1-4bcf-a51b-f44ebf1ee516', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-05-05', '2025-06-16', '2025-05-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 154.679993, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('de2887ea-bfdc-4b91-8938-b3140d348da8', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-05-08', '2025-06-05', '2025-05-11', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 91.0500031, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('1b6441ce-d018-4d80-90c5-f585a102fb97', '1ea1f996-0e67-4874-b697-9817333eeb70', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-05-09', '2025-06-06', '2025-05-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 0.939999998, 'Eden Commerce Group', '2319 Elm St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada');
INSERT INTO orders VALUES ('315b5685-0f7c-45f0-85da-db7495a3c689', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-09', '2025-06-06', '2025-05-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 23.7299995, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('590e20d8-2e7b-423e-8422-6b76161fff26', '08593d96-6aac-44cc-9aff-b5c963fc26db', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-10', '2025-06-07', '2025-05-15', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 50.9700012, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('6f23c8c2-e6a2-446b-abe3-5e8ac72f880a', '93eee301-36bd-466c-af34-ac22fd4afdb7', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-05-11', '2025-06-08', '2025-05-16', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 97.1800003, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('cc6528dc-f8e4-4376-a0d7-1dcd57adc829', '56184b85-2929-4ae4-8933-685e484b9933', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-11', '2025-06-08', '2025-05-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 94.8000031, 'Sterling Trade Partners', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA');
INSERT INTO orders VALUES ('287ada86-617f-4a93-98e8-ea42f700802d', 'ccee083f-d880-4792-b08c-4059192a96a7', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-05-12', '2025-06-09', '2025-05-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 43.9000015, 'Kingston Supply Group', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico');
INSERT INTO orders VALUES ('692d7f53-21d5-4183-be92-c896b1f04b08', '216c4816-2434-466a-98ee-252ad3d9d933', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-05-15', '2025-06-12', '2025-05-24', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 138.690002, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('4e74c510-55c5-47d0-b53a-3b80c9d25f9f', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-05-15', '2025-06-26', '2025-05-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 107.459999, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('0f308589-2354-440d-8c3e-7e9500e0467e', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-16', '2025-06-13', '2025-05-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 30.3600006, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('25ec11e6-62ff-4252-a2a6-6c099ddf416c', '74661752-05c4-445c-9b23-573d5c0d6e19', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-16', '2025-06-13', '2025-05-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 85.4599991, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('5321a601-ab4c-4f52-abc7-4073d94dae56', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-05-17', '2025-06-14', '2025-05-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 32.3499985, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('12416610-ec6d-4f0c-b7b1-94f238f6773e', '3130b75e-08d7-4937-bfde-1974a03c950a', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-05-18', '2025-06-15', '2025-05-19', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.870000005, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('879b8029-2907-483d-be73-5ea6927b4e9c', 'c628d310-118f-4d17-83c4-1cfcc82954a9', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-05-18', '2025-06-15', '2025-05-23', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 41.3800011, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('04ccb0b2-221c-4e50-b09c-e5314ee6eb1c', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-05-19', '2025-06-16', '2025-05-22', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 477.899994, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('3e10c4bb-dabd-4e41-9d06-56e6d5f14b88', 'c215d346-d4e2-43cc-911e-2e4fd17a370d', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-19', '2025-06-16', '2025-05-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 487.380005, 'Grove Wholesale Ltd', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France');
INSERT INTO orders VALUES ('b21c2cd8-4ccb-4dab-94bf-4f6f9b4c8144', '53e16308-5b76-4e70-b284-fe5958e79a0e', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-05-22', '2025-06-19', '2025-05-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 47.4599991, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('c2c074d2-31b3-47cb-9798-f23f8873f110', 'af354600-23a9-4298-9157-75ff7c92a119', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-23', '2025-06-20', '2025-05-30', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 1.14999998, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('c971457f-7614-46df-8c64-226cb71e292e', 'd052d4e1-5069-4431-ba2f-4965bf158b31', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-05-23', '2025-06-20', '2025-05-30', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 201.289993, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('a2953c58-3e9e-49d7-ad47-799eeeecc644', 'e03bf9cd-810e-46fd-b925-48e73c12756a', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-05-24', '2025-06-21', '2025-06-05', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 158.440002, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('a6ac0c93-bce4-4949-b580-7afd2a1697ae', '070ee85e-07e7-4886-bf50-ba55c77160d9', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-05-24', '2025-06-21', '2025-05-31', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 38.6399994, 'Juniper Trading House', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway');
INSERT INTO orders VALUES ('f731d201-db34-4eb8-a464-22f7bfaedefb', 'c628d310-118f-4d17-83c4-1cfcc82954a9', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-25', '2025-06-22', '2025-06-01', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 23.5499992, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('76fb5b47-47fe-43c7-925f-9b421e41557f', '0ef4332c-6383-486b-a577-0156519db661', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-26', '2025-06-23', '2025-05-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 179.610001, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('fb209b21-0afc-41c3-8e2b-a1bc3655bec6', 'f0d1b9c9-9e00-4a54-8276-07cced1288be', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-05-26', '2025-06-23', '2025-06-09', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 41.8899994, 'Maple Commerce Solutions', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark');
INSERT INTO orders VALUES ('5db39820-bbbb-4218-9d20-09e5d01b1e5c', '817f71c0-4a9e-4196-b6be-2be0c2a53d85', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-05-29', '2025-06-26', '2025-06-06', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 29.4599991, 'Ember Trading House', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany');
INSERT INTO orders VALUES ('f4d8477c-7a21-4dbf-956c-6d896924469d', '5506f7ee-50bd-4a1e-a15d-b6f223d32c67', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-05-29', '2025-06-26', '2025-06-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 0.140000001, 'Horizon Merchants', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO orders VALUES ('06cb2bf9-f0df-4fe2-be54-6c4872762982', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-30', '2025-06-27', '2025-06-06', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 12.4099998, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('0169747b-1a8b-4515-8cfc-689bb3b92a2f', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-05-31', '2025-07-12', '2025-06-07', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 142.330002, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('4a38de18-4156-4b4a-8325-425810826157', 'b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-05-31', '2025-06-14', '2025-06-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 45.5400009, 'Crown Retail Solutions', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO orders VALUES ('97343cdd-050a-4d29-83d5-e5d4fa89e298', '08593d96-6aac-44cc-9aff-b5c963fc26db', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-06-01', '2025-07-13', '2025-06-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 14.25, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('975cae32-44ef-4960-a065-2ceea1d08bec', 'eb488881-56d2-4219-a3b5-26ff37fb74be', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-06-01', '2025-06-29', '2025-06-02', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 6.19999981, 'Cobalt Commerce Group', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium');
INSERT INTO orders VALUES ('8d6cfbf7-d3a0-48d0-9a06-6ac7a1a47e73', '1d42c341-838e-44f6-9a56-d831af2dfcff', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-06-02', '2025-06-30', '2025-06-07', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 176.809998, 'Jetty Trading Solutions', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil');
INSERT INTO orders VALUES ('d4df15aa-6911-4aef-91c3-45014e9809c0', 'c628d310-118f-4d17-83c4-1cfcc82954a9', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-06-05', '2025-07-03', '2025-06-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 20.6000004, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('0318df23-60d3-474a-a2d9-0aae96f1ece5', 'f7f06986-6907-4481-92af-bfc5511a56e7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-06-05', '2025-07-03', '2025-06-12', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 7.13999987, 'Ultra Retail Systems', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO orders VALUES ('d0376bbd-11a0-44d2-8012-5c1ed84b9847', '93eee301-36bd-466c-af34-ac22fd4afdb7', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-06-06', '2025-07-04', '2025-06-23', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 93.25, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('129b8db3-7866-4374-beec-188cb9f305ae', '216c4816-2434-466a-98ee-252ad3d9d933', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-06-06', '2025-07-04', '2025-06-15', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 55.2599983, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('582b3c9d-12c7-476e-9eb6-7af14209395a', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-06-07', '2025-07-05', '2025-06-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.40999985, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('3dd27072-d1b9-45a5-8bc8-337e831be320', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-06-08', '2025-07-06', '2025-06-14', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 57.1500015, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('20504e35-fd3c-4ff1-ac33-97323f8efb27', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-06-08', '2025-07-06', '2025-06-19', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 352.690002, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('14be7e92-8e8e-4c31-b26c-a83a393176b1', '748b439f-112d-44fa-91a4-670ef32d1621', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-06-09', '2025-07-07', '2025-06-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 364.149994, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('96599ece-8499-44b3-b089-5e952c14c51c', 'd052d4e1-5069-4431-ba2f-4965bf158b31', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-06-09', '2025-07-07', '2025-06-14', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 105.809998, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('b8f30914-99af-4aa1-b496-1be18c3a50b9', 'e90985b6-e765-4c89-895f-fa2337e72a16', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-06-12', '2025-07-10', '2025-07-19', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 111.290001, 'Gateway Trading House', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA');
INSERT INTO orders VALUES ('7fe34de1-f8c9-4c29-ad5c-8652e966b647', 'a21a6b01-37f1-4462-95f2-595326e090f6', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-06-13', '2025-07-11', '2025-06-19', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 17.5499992, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('8cc8f08e-5f61-45d7-8c19-5de147236d43', 'e56705d0-d0c1-463d-a72a-43b95b4e4c45', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-06-13', '2025-07-11', '2025-06-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.27999997, 'Pine Supply Group', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA');
INSERT INTO orders VALUES ('d93f9299-33b6-48d8-8c6f-e806f0fbe421', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-06-14', '2025-06-28', '2025-07-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 113.150002, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('db72fbba-eac5-4f4f-9832-35e83070deec', '73ac725b-10e5-410f-bddd-d9c60fd0ec46', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-06-14', '2025-07-12', '2025-06-23', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.26999998, 'Acorn Trading House', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal');
INSERT INTO orders VALUES ('168aa178-dc99-4873-9a26-ce1af0e0a7ad', 'e56705d0-d0c1-463d-a72a-43b95b4e4c45', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-06-15', '2025-07-13', '2025-06-21', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 26.3099995, 'Pine Supply Group', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA');
INSERT INTO orders VALUES ('ce52433d-2f11-4d14-936c-356b281d7cf1', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-06-16', '2025-07-14', '2025-06-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 232.419998, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('2a26ea38-a308-413a-943d-f5ec74a5fa34', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-06-16', '2025-07-14', '2025-06-23', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 78.0899963, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('b9f88265-164b-4d28-a1dd-45a652d55216', 'c628d310-118f-4d17-83c4-1cfcc82954a9', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-06-19', '2025-07-17', '2025-06-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 47.2200012, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('9c354d20-789f-4056-a8be-2b1d02df20fb', 'f0d1b9c9-9e00-4a54-8276-07cced1288be', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-06-19', '2025-07-17', '2025-06-26', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 24.3899994, 'Maple Commerce Solutions', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark');
INSERT INTO orders VALUES ('899651be-73bb-440a-aead-c2bbcc78feff', '93eee301-36bd-466c-af34-ac22fd4afdb7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-06-20', '2025-07-18', '2025-06-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 203.479996, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('ea5a626a-32a8-4d9d-84bd-c9e1c3eeb608', '77ffa2f5-8e8d-41b5-9af1-52327fcfb0c7', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-06-21', '2025-07-19', '2025-06-28', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 30.3400002, 'Frontier Goods International', '54, rue Royale', 'Nantes', NULL, '44000', 'France');
INSERT INTO orders VALUES ('4fc0303b-7dd4-44fc-9dd9-d2aeecdd6ecf', '216c4816-2434-466a-98ee-252ad3d9d933', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-06-21', '2025-07-05', '2025-06-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 95.75, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('323bfe25-0963-4d3a-83f3-05c7d7d9db24', '01a81542-e365-4854-a3ae-fb1d7e0a4fa2', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-06-22', '2025-07-20', '2025-06-23', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 22.7600002, 'Harbor Wholesale Co', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland');
INSERT INTO orders VALUES ('01a6f1d9-655d-4c44-ba40-4002782664aa', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-06-22', '2025-07-20', '2025-07-04', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 0.899999976, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('695029fb-2a8e-479d-8b1b-49da0ebea66d', '93eee301-36bd-466c-af34-ac22fd4afdb7', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-06-23', '2025-07-21', '2025-06-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 31.8500004, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('dc83137e-f079-458f-a911-42782d35e879', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-06-26', '2025-07-24', '2025-07-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 2.00999999, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('df16522f-84b9-4935-9ed2-a76467df0092', 'a3cd2482-6d56-4140-b063-ec86ab178603', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-06-26', '2025-07-24', '2025-06-30', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.03000021, 'Xenon Retail Corp', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico');
INSERT INTO orders VALUES ('82418300-53ce-4573-ae43-d6f4ecf4162c', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-06-27', '2025-07-25', '2025-07-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 388.980011, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('5dcd7d94-25c8-4582-be20-dfeb70c08a5e', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-06-27', '2025-07-25', '2025-07-04', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 27.9400005, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('6d376016-3535-4284-80c8-7414782b5f68', '7353f783-745c-41a9-8fe0-367246437f6d', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-06-28', '2025-07-26', '2025-06-30', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 26.6100006, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('e0f34993-2fa3-4845-a0c5-6848f5de64b1', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-06-29', '2025-07-27', '2025-07-04', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 76.1299973, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('61366f25-739d-4f0e-80d3-f9782a7bd766', 'a3cd2482-6d56-4140-b063-ec86ab178603', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-06-29', '2025-07-27', '2025-07-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 36.1300011, 'Xenon Retail Corp', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico');
INSERT INTO orders VALUES ('1acb2bd5-93c3-4bcb-9b01-b24a2bdfeb7f', 'c81e7c16-d8f1-43a8-a1c4-27847709ce21', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-06-30', '2025-07-28', '2025-07-05', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 4.4000001, 'Elm Commerce Group', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France');
INSERT INTO orders VALUES ('e25697db-0201-4758-90b1-fdf2bc15c5cb', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-06-30', '2025-07-28', '2025-07-04', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 145.630005, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('e42c957a-98e5-40eb-bfeb-cbd0ac237418', 'f7f06986-6907-4481-92af-bfc5511a56e7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-07-03', '2025-07-17', '2025-07-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 33.75, 'Ultra Retail Systems', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO orders VALUES ('b8d7318c-57f9-4958-a14f-bb9888fdaf43', '95ddaae9-9c82-4259-b319-1a46588a652a', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-07-04', '2025-08-01', '2025-07-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 96.5, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('6cff6179-d429-4652-be88-31000693f0fd', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-07-04', '2025-08-01', '2025-08-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 296.429993, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('0bf15cbd-03cc-48ba-b2fa-28e69c7eb684', '350fda94-3e7d-4a1f-8408-fe06024eca1e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-07-05', '2025-07-19', '2025-07-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 299.089996, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('05859d57-2438-4aae-aec5-4a813047a165', '216c4816-2434-466a-98ee-252ad3d9d933', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-07-05', '2025-08-02', '2025-07-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 13.4200001, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('4ba51ebc-367d-4c33-9499-fbfbf22d752a', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-07-06', '2025-08-03', '2025-07-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 15.8000002, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('c5087783-771a-422d-bd07-9fe285339f5c', '748b439f-112d-44fa-91a4-670ef32d1621', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-07-07', '2025-08-18', '2025-07-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 810.049988, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('c6b07756-de3c-43ba-8002-2151a4e9a700', '817f71c0-4a9e-4196-b6be-2be0c2a53d85', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-07-07', '2025-08-04', '2025-07-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 61.0200005, 'Ember Trading House', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany');
INSERT INTO orders VALUES ('1dd0194a-e8a2-4523-b0b0-77e464df5ac8', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-07-10', '2025-07-24', '2025-07-14', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 139.339996, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('9d763568-30c2-49f5-b7da-1869bfee5a43', '748b439f-112d-44fa-91a4-670ef32d1621', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-07-10', '2025-08-07', '2025-07-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 398.359985, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('ae4cbe7d-ea8e-44ee-bdc6-351662fd3610', '01a81542-e365-4854-a3ae-fb1d7e0a4fa2', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-07-11', '2025-08-22', '2025-07-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 16.7199993, 'Harbor Wholesale Co', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland');
INSERT INTO orders VALUES ('5b6fcc95-ae45-49cc-a446-b4ef75bc0d64', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-07-12', '2025-08-23', '2025-07-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 102.550003, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('225b00f5-76f0-4c80-8cd4-3aa7ca926aee', 'e03bf9cd-810e-46fd-b925-48e73c12756a', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-07-12', '2025-08-09', '2025-07-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 45.5200005, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('b75cad16-6be5-4c3e-8976-333cc9801103', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-07-13', '2025-08-10', '2025-07-21', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 272.470001, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('1fdb500d-51e7-4ac1-9c8c-c7ebb474e7d2', '404621e7-d665-4801-bfce-aa17d22b435f', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-07-13', '2025-08-10', '2025-07-17', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 0.579999983, 'Neptune Commerce Ltd', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany');
INSERT INTO orders VALUES ('c2f9f077-fc03-4355-84a7-fa358843c081', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-07-14', '2025-08-11', '2025-07-20', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 65.0999985, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('647dae80-6324-41d5-aa93-dfe2efffcb2e', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-07-17', '2025-07-31', '2025-07-19', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 220.309998, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('92368d2a-dea3-4bab-a3ca-9d0c5450a53e', '817f71c0-4a9e-4196-b6be-2be0c2a53d85', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-07-17', '2025-08-28', '2025-07-25', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 23.9400005, 'Ember Trading House', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany');
INSERT INTO orders VALUES ('84247e3c-33e0-42aa-a4b3-ceb281df2f01', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-07-18', '2025-08-15', '2025-07-24', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 152.300003, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('5d37f19d-8efc-439d-9369-877b4c28bfad', 'd052d4e1-5069-4431-ba2f-4965bf158b31', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-07-18', '2025-08-15', '2025-08-11', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 4.78000021, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('2cfd2c34-9b96-4621-8c3d-d1b10b3c3346', '0ef4332c-6383-486b-a577-0156519db661', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-07-19', '2025-08-16', '2025-08-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.51999998, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('d2f9a7fb-47e9-4252-8f59-65c71e41b6b1', '7353f783-745c-41a9-8fe0-367246437f6d', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-07-20', '2025-08-17', '2025-07-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 135.630005, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('773b6bc2-1682-42ac-96a4-2b92e8a6aaf2', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-07-20', '2025-08-03', '2025-07-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 21.7399998, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('6a818e7b-781e-4147-8d6a-4bca580c2430', '4df2df85-b445-43b3-a8a6-f5b65d0cc8c8', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-07-21', '2025-09-01', '2025-08-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 2.96000004, 'Zenith Commerce Group', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA');
INSERT INTO orders VALUES ('b0417de0-8c66-43c3-aaff-d1288788f9b2', 'f7f06986-6907-4481-92af-bfc5511a56e7', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-07-21', '2025-08-18', '2025-08-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 210.800003, 'Ultra Retail Systems', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO orders VALUES ('98456107-89d4-414d-9bff-dc05374da8d3', '05464425-fc77-4a44-9a69-5f6f6ec147b9', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-07-24', '2025-08-21', '2025-07-27', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 4.98000002, 'Crimson Distribution Co', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy');
INSERT INTO orders VALUES ('b83a09f0-6688-4dd2-9b97-50cdc218cf10', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-07-25', '2025-09-05', '2025-08-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 52.4099998, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('7ac618ff-fae8-4f06-a50b-e5912642edee', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-07-25', '2025-08-22', '2025-08-04', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 89.9300003, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('22707408-32e9-414c-894f-92bf8716738c', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-07-26', '2025-08-23', '2025-07-28', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 167.050003, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('8a44ab1c-31b1-4442-a3fb-bc1e71c438ce', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-07-26', '2025-08-23', '2025-07-31', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 24.4899998, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('23006a0b-1394-4776-a71f-5f4618b78d98', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-07-27', '2025-08-10', '2025-08-02', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 63.2000008, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('c504f25b-c477-48ea-8846-c4abe91c5131', 'c409b555-9e62-4606-b2ff-63dacb2c17dc', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-07-28', '2025-08-25', '2025-07-31', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 22.5699997, 'Liberty Trading Partners', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('d7180e9b-369e-4512-87ac-73b1d2a4901a', '93eee301-36bd-466c-af34-ac22fd4afdb7', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-07-28', '2025-08-25', '2025-08-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 59.25, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('066b47c8-6f72-4ab8-97b9-8b06de8f8b45', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-07-31', '2025-08-28', '2025-08-02', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 170.880005, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('f86bead3-4586-425a-80f0-a4402e964df4', 'c71720d2-cb57-45c6-8b31-7a7b96f72646', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-07-31', '2025-08-28', '2025-08-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 51.4399986, 'Olympus Distribution Co', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA');
INSERT INTO orders VALUES ('6b2562d4-674f-4db2-8893-5899c1d673d3', 'b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-08-01', '2025-08-15', '2025-08-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 9.52999973, 'Crown Retail Solutions', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO orders VALUES ('1187e0d6-34ab-4e0c-bd8b-4c6ee32f0fc7', '748b439f-112d-44fa-91a4-670ef32d1621', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-08-02', '2025-08-30', '2025-08-04', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 48.9199982, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('29a22535-5cf1-4341-93fe-91cdb16d19eb', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-08-02', '2025-09-13', '2025-08-08', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 74.5800018, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('e32b83d2-d3e7-40fb-87af-d19a15d0db15', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-08-03', '2025-08-31', '2025-08-29', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 21.7199993, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('82cd4132-c21d-43f9-be2d-1c6b48ecc1be', '5e611e14-4b9b-4b14-89b9-5ee3ea1dc989', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-08-03', '2025-09-14', '2025-08-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 57.75, 'Nordic Wholesale Ltd', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO orders VALUES ('af42e93d-507f-4f80-893a-9f597cc98d32', '1d42c341-838e-44f6-9a56-d831af2dfcff', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-08-04', '2025-09-01', '2025-08-09', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 10.8299999, 'Jetty Trading Solutions', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil');
INSERT INTO orders VALUES ('4483d2b4-7d73-471b-9bf8-96260720227a', '00c51812-32fe-4ea7-93cd-6ac81afcce12', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-08-07', '2025-08-21', '2025-09-08', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 16.5599995, 'Phoenix Trading Inc', '35 King George', 'London', NULL, 'WX3 6FW', 'UK');
INSERT INTO orders VALUES ('ce30f56e-fad5-4bd3-ad88-8a0f2b3cf59a', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-08-07', '2025-09-04', '2025-09-08', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 89.9000015, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('9a124884-8661-4adb-87f0-bc57fbf465fe', 'd052d4e1-5069-4431-ba2f-4965bf158b31', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-08-08', '2025-09-05', '2025-08-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 58.3300018, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('58e107e1-7d76-4074-8c24-2d537e0b2e49', 'e03bf9cd-810e-46fd-b925-48e73c12756a', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-08-08', '2025-09-19', '2025-08-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 141.059998, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('f648123f-b859-47b3-9fed-51b902bc30ea', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-08-09', '2025-09-06', '2025-08-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 20.1200008, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('5b08f572-3b4c-4bb9-a933-86cf347787e0', '346cfbc3-e2c8-4c26-92ec-df34bad2e944', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-08-10', '2025-09-07', '2025-08-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 96.6500015, 'Glacier Commerce Ltd', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland');
INSERT INTO orders VALUES ('f0e34599-970f-4e59-843c-7eecaebfb395', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-08-10', '2025-09-07', '2025-08-11', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 16.9699993, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('27a23153-cbdc-4416-87c2-2346356270c4', '216c4816-2434-466a-98ee-252ad3d9d933', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-08-11', '2025-09-08', '2025-08-14', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 110.110001, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('5ae66006-749b-4e7a-a978-6be8c472d9fa', 'f7f06986-6907-4481-92af-bfc5511a56e7', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-08-11', '2025-09-08', '2025-08-16', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.63, 'Ultra Retail Systems', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO orders VALUES ('1a6d453f-bcc3-4494-a34a-d063cbb2b90e', 'c71720d2-cb57-45c6-8b31-7a7b96f72646', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-08-14', '2025-09-11', '2025-08-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 45.9700012, 'Olympus Distribution Co', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA');
INSERT INTO orders VALUES ('2dd62301-c3a0-486c-bcce-382a96cd381b', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-08-15', '2025-09-12', '2025-08-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 44.0999985, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('c8060e9a-7cc6-4f2e-bb98-65b6793f96ae', '0f950417-4cef-4220-9648-bf424a6da513', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-08-15', '2025-09-12', '2025-08-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 7.78999996, 'Yellowstone Supply Co', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France');
INSERT INTO orders VALUES ('53ce8058-22a7-4a3e-bcd4-d3dca0ee5347', 'e6914765-3d71-472f-9efd-119e184b3c0a', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-08-16', '2025-09-13', '2025-08-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 2.91000009, 'Windsor Supply Group', '25, rue Lauriston', 'Paris', NULL, '75016', 'France');
INSERT INTO orders VALUES ('d2a6a69b-e6b5-4c94-9a70-a8f59a916c22', '0f950417-4cef-4220-9648-bf424a6da513', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-08-16', '2025-09-13', '2025-08-21', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 11.0799999, 'Yellowstone Supply Co', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France');
INSERT INTO orders VALUES ('d39d44b4-b160-4883-a50d-7dd7d94ac8b4', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-08-17', '2025-09-14', '2025-08-29', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 81.8799973, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('6d5eee79-58fc-4727-a59f-b335583c0775', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-08-18', '2025-09-01', '2025-08-22', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 10.96, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('8c12784c-622d-47c5-8100-8ba15c2cf96c', 'b331de10-47a7-468f-98db-ad5c2d1a041f', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-08-18', '2025-09-15', '2025-08-22', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 243.729996, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('c2706361-a3db-4c83-b449-686b6aee561d', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-08-21', '2025-09-18', '2025-08-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 23.7199993, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('38e4737e-1b91-4561-b162-c007255b775d', '350fda94-3e7d-4a1f-8408-fe06024eca1e', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-08-21', '2025-09-18', '2025-08-28', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 69.1900024, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('ebc812c6-9be4-42c7-a9d1-c2cf506479a8', '748b439f-112d-44fa-91a4-670ef32d1621', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-08-22', '2025-09-19', '2025-08-31', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 3.51999998, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('e38f8937-529d-4531-9e1d-af86f9acc8b6', '346cfbc3-e2c8-4c26-92ec-df34bad2e944', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-08-23', '2025-09-20', '2025-08-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 31.4300003, 'Glacier Commerce Ltd', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland');
INSERT INTO orders VALUES ('1c7c6184-057c-4a3c-a3e2-e79cf02c9181', '95ddaae9-9c82-4259-b319-1a46588a652a', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-08-23', '2025-09-20', '2025-08-30', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 117.330002, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('0824a07c-0e80-4a94-8f33-aecda177ba73', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-08-24', '2025-09-21', '2025-09-01', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 232.550003, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('dceab1df-e42e-4c8a-892f-f012f00c7073', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-08-24', '2025-09-21', '2025-09-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 61.5299988, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('0f7faff1-9198-421e-a0ae-a68137ef3e8d', 'af354600-23a9-4298-9157-75ff7c92a119', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-08-25', '2025-09-22', '2025-08-28', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 79.3000031, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('f9a6b6e3-a7ab-4a35-8a77-72cc966eccc7', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-08-28', '2025-09-25', '2025-09-06', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 130.789993, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('02decfdb-8ac8-419d-84be-1ffef429dc4a', '1e6dd3f8-3c44-4fac-9b97-016270116762', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-08-28', '2025-09-25', '2025-09-01', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.38999999, 'Frost Supply Partners', 'South House 300 Queensbridge', 'London', NULL, 'SW7 1RZ', 'UK');
INSERT INTO orders VALUES ('e00b9465-c1e7-480a-8184-c1d7e27df19a', '05464425-fc77-4a44-9a69-5f6f6ec147b9', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-08-29', '2025-09-26', '2025-08-31', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 7.69999981, 'Crimson Distribution Co', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy');
INSERT INTO orders VALUES ('ce5ecd99-df86-4878-8aa2-7c27cd984247', '53e16308-5b76-4e70-b284-fe5958e79a0e', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-08-29', '2025-09-26', '2025-08-31', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 2.38000011, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('0d67759a-557c-45e2-b7ed-921634329cb2', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-08-30', '2025-09-27', '2025-09-01', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 16.7099991, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('69156381-e3ff-4399-ac73-fa75ce4d4daf', '39a6fd07-d871-4d12-889a-1bfd8d79dea2', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-08-31', '2025-09-28', '2025-09-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 73.2099991, 'Quartz Retail Group', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA');
INSERT INTO orders VALUES ('6577e23e-83e5-429c-a86d-cf0c484c9a69', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-08-31', '2025-09-28', '2025-09-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 8.18999958, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('2bc6d425-2a2c-4732-9152-9fe211e62881', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-01', '2025-09-29', '2025-09-07', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 138.169998, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('36d0f251-1480-40b1-9bc1-67e0d5b6582a', 'ccee083f-d880-4792-b08c-4059192a96a7', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-01', '2025-09-29', '2025-09-15', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 11.9899998, 'Kingston Supply Group', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico');
INSERT INTO orders VALUES ('f586be55-062c-4ce9-b99e-2b0a304c2ee7', 'eb488881-56d2-4219-a3b5-26ff37fb74be', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-09-04', '2025-10-02', '2025-09-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 155.639999, 'Cobalt Commerce Group', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium');
INSERT INTO orders VALUES ('5ee234e2-bce8-4973-84f2-c5a9d7bb03cd', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-09-05', '2025-10-03', '2025-09-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 18.6599998, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('a37545b9-c1eb-4470-b359-5c4c97cd6448', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-05', '2025-10-03', '2025-09-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 328.73999, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('b8431de1-b8f4-4ca2-8b75-4a72d73b694d', 'c215d346-d4e2-43cc-911e-2e4fd17a370d', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-06', '2025-10-04', '2025-09-11', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 37.3499985, 'Grove Wholesale Ltd', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France');
INSERT INTO orders VALUES ('2c8a595d-9109-4db8-ae4c-20edf5103b7e', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-09-06', '2025-10-04', '2025-09-11', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 145.449997, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('34ab4c14-0ae2-448f-8dd7-2a4ac28125b4', '748b439f-112d-44fa-91a4-670ef32d1621', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-07', '2025-10-05', '2025-09-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 42.7400017, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('f0ddd740-0cb2-404d-80a6-9476f08bf2c6', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-09-08', '2025-10-06', '2025-09-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 157.550003, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('eb8c0f7a-5bc2-45a3-abb2-85fd9bfa44b7', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-09-08', '2025-10-06', '2025-09-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.59000003, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('46d560df-6e07-4863-9a14-5caa7b412468', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-11', '2025-10-09', '2025-09-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 146.320007, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('97ecc69b-306f-47b2-a34f-32a0464c1805', '350fda94-3e7d-4a1f-8408-fe06024eca1e', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-11', '2025-10-09', '2025-09-15', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 65.0599976, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('37c93e74-0e46-4e44-b835-d186d537c75e', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-09-12', '2025-10-10', '2025-09-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 5.32000017, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('31e88019-e0e6-4344-be82-007d8b462eca', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-09-13', '2025-10-11', '2025-10-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 11.1899996, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('79391bfb-7a28-47cf-b507-0383d0bdbaea', '79222616-f296-416f-a386-57a31c0d15d7', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-13', '2025-10-11', '2025-09-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 91.2799988, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('14dc33dd-48f9-4349-981f-432f82cbd807', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-09-14', '2025-10-12', '2025-09-19', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 96.4300003, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('a8a61c3e-1ac6-42dc-bad4-cc79bb66a766', '42a480f6-9c97-44c5-b327-9198e5e274e4', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-09-14', '2025-09-28', '2025-09-15', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 48.2000008, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('f18809e4-1fa4-4439-adcb-890bd98a7d26', '56184b85-2929-4ae4-8933-685e484b9933', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-09-15', '2025-10-13', '2025-09-29', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 20.25, 'Sterling Trade Partners', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA');
INSERT INTO orders VALUES ('d10aa8e2-e8da-4a7a-8ef6-9bb74a777d81', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-09-18', '2025-10-16', '2025-09-21', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 351.529999, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('a39b548a-195a-46a2-aa46-0a02a5087b08', 'f7f06986-6907-4481-92af-bfc5511a56e7', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-09-18', '2025-10-02', '2025-10-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.00999999, 'Ultra Retail Systems', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO orders VALUES ('e3d13793-bb79-4448-a276-739610d4d9b2', '216c4816-2434-466a-98ee-252ad3d9d933', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-19', '2025-10-17', '2025-09-27', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 6.78999996, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('be7afd26-5dd9-4130-b62d-2b728fa7294a', '404621e7-d665-4801-bfce-aa17d22b435f', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-19', '2025-10-17', '2025-10-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 58.1300011, 'Neptune Commerce Ltd', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany');
INSERT INTO orders VALUES ('198f8b11-7fc8-4036-8caa-56b896c5dfff', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-09-19', '2025-10-03', '2025-09-28', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 42.1300011, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('515d5a53-c07d-466b-8a0a-09cb0e2d4c18', 'af354600-23a9-4298-9157-75ff7c92a119', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-09-20', '2025-10-18', '2025-09-22', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 73.1600037, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('f9df90af-ad59-4115-8c3f-3cfe44d7f017', '26240386-a6ca-4a18-910d-904cde61d93b', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-09-20', '2025-10-18', '2025-09-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.10000002, 'Dawn Supply Ltd', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('1568a0aa-5095-4ec0-a21c-ca0aa1e2d0b0', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-09-21', '2025-10-19', '2025-09-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 124.980003, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('d95c9ff7-ac48-442f-837a-d31db3ed8e46', '53e16308-5b76-4e70-b284-fe5958e79a0e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-09-21', '2025-10-19', '2025-09-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 70.0899963, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('29a017c3-2216-4113-acf4-1df300cae2b6', '4778376a-e73d-4c29-9124-abc9f9265689', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-09-21', '2025-10-19', '2025-09-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.50999999, 'Umbra Retail Partners', '5ª Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela');
INSERT INTO orders VALUES ('71b171c6-8713-424b-95de-e99215d6f51b', 'd052d4e1-5069-4431-ba2f-4965bf158b31', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-09-22', '2025-10-20', '2025-09-26', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 110.870003, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('86709060-d8ff-42ee-8c5c-380ffef25c04', '3130b75e-08d7-4937-bfde-1974a03c950a', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-09-22', '2025-10-06', '2025-09-29', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 249.929993, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('3bccd56f-07cb-4c53-99eb-fd48faa096b8', '748b439f-112d-44fa-91a4-670ef32d1621', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-09-25', '2025-10-23', '2025-10-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 42.7000008, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('2e3fceae-a85e-468e-82e6-3b8edd909f45', 'c215d346-d4e2-43cc-911e-2e4fd17a370d', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-09-25', '2025-10-23', '2025-10-04', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 100.599998, 'Grove Wholesale Ltd', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France');
INSERT INTO orders VALUES ('6a63bd0c-86fe-4f29-a9b5-f5940726f462', 'f7f06986-6907-4481-92af-bfc5511a56e7', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-09-25', '2025-10-23', '2025-09-29', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 28.2299995, 'Ultra Retail Systems', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO orders VALUES ('7d44c8ca-5eb5-4bf8-bc40-6a7631940601', '93eee301-36bd-466c-af34-ac22fd4afdb7', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-09-26', '2025-10-24', '2025-10-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 16.8500004, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('624fb927-a272-4485-ada0-a1d166d486f9', 'b4dc01c6-29d9-4799-b914-9424e6e210d9', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-09-26', '2025-10-24', '2025-10-04', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 23.7900009, 'Trident Trading Solutions', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland');
INSERT INTO orders VALUES ('a386f5ab-2198-4631-ae50-b9963b211ef9', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-27', '2025-10-25', '2025-10-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.51999998, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('c9756948-6159-427d-b818-f943a6138bbd', 'b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-09-27', '2025-10-25', '2025-10-06', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 21.4899998, 'Crown Retail Solutions', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO orders VALUES ('0557ea9b-d473-4572-ba16-4c66bcc8e12c', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-09-27', '2025-10-25', '2025-10-24', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 126.660004, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('dd176bb4-a96f-43c8-9185-9c7f736742da', '0ef4332c-6383-486b-a577-0156519db661', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-09-28', '2025-10-26', '2025-10-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 26.5200005, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('3dd33108-f42b-46b2-82cc-289143379619', '2a76dd54-c4c4-410f-bc6c-4d9f8a992e4d', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-09-28', '2025-10-26', '2025-10-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 33.3499985, 'Arbor Distribution Co', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany');
INSERT INTO orders VALUES ('d6b92657-2628-4a46-ada4-d0b042bfd7a8', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-09-29', '2025-10-27', '2025-10-09', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 2.32999992, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('c7963cd8-fa69-4fb7-820f-c4fd3594840b', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-09-29', '2025-11-10', '2025-10-09', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 30.7600002, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('e8994e58-3810-4e64-8929-ca5e7ebf90b2', '21c8bb0f-dfb4-460c-9136-0ca192e08207', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-09-29', '2025-10-27', '2025-10-09', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 137.440002, 'Jupiter Retail Systems', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');
INSERT INTO orders VALUES ('722e4ef9-6f72-422a-b8f7-0aaa6275b538', '9f303dd7-f723-44ca-83ab-1076b4d8c364', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-10-02', '2025-10-30', '2025-10-04', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 97.0899963, 'Mercury Wholesale Group', 'C/ Araquil, 67', 'Madrid', NULL, '28023', 'Spain');
INSERT INTO orders VALUES ('a4dc9fe0-5461-4183-b8a7-09b79a1ac8a4', 'f0d1b9c9-9e00-4a54-8276-07cced1288be', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-10-02', '2025-10-30', '2025-10-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 257.26001, 'Maple Commerce Solutions', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark');
INSERT INTO orders VALUES ('e634a111-cb39-42d6-8923-b22c948b02cf', '5506f7ee-50bd-4a1e-a15d-b6f223d32c67', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-10-03', '2025-10-31', '2025-10-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 55.2299995, 'Horizon Merchants', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO orders VALUES ('a1c241df-9eb0-405b-a925-0286a5fd3191', '21c8bb0f-dfb4-460c-9136-0ca192e08207', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-10-03', '2025-10-31', '2025-10-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 27.3299999, 'Jupiter Retail Systems', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');
INSERT INTO orders VALUES ('d03062e0-1642-447b-81b0-38c102405385', '4df2df85-b445-43b3-a8a6-f5b65d0cc8c8', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-10-03', '2025-10-31', '2025-10-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 237.339996, 'Zenith Commerce Group', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA');
INSERT INTO orders VALUES ('17eb0902-2e2c-497a-9aa2-252514f9c014', '0668ebca-a25a-4c6a-b84c-7943bf00171e', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-10-04', '2025-11-01', '2025-10-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 22.1100006, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('c834341c-b29a-4411-ba71-f6dd6096ce09', '05464425-fc77-4a44-9a69-5f6f6ec147b9', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-10-04', '2025-11-01', '2025-11-03', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 1.36000001, 'Crimson Distribution Co', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy');
INSERT INTO orders VALUES ('fb7387df-2417-4f19-abf0-0784ee25309f', '7353f783-745c-41a9-8fe0-367246437f6d', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-10-05', '2025-11-02', '2025-10-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 45.5299988, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('ed04387c-26f1-43f3-bd5d-30450377242e', '5506f7ee-50bd-4a1e-a15d-b6f223d32c67', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-10-05', '2025-11-02', '2025-10-11', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 4.86999989, 'Horizon Merchants', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO orders VALUES ('a3c6075a-34c7-48b9-ba30-04b666216183', '1ea1f996-0e67-4874-b697-9817333eeb70', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-10-05', '2025-11-02', '2025-10-11', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.32999992, 'Eden Commerce Group', '2319 Elm St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada');
INSERT INTO orders VALUES ('eca2819f-96b2-4c5d-b1bf-47c6e014eaae', 'e03bf9cd-810e-46fd-b925-48e73c12756a', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-10-06', '2025-11-03', '2025-10-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 31.2199993, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('caaaf155-9f9c-4c26-a626-bd24c3356ae8', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-10-06', '2025-11-03', '2025-10-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 59.7799988, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('35aa565b-a083-452c-bd2a-fac5adcf88cb', '08593d96-6aac-44cc-9aff-b5c963fc26db', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-10-09', '2025-11-06', '2025-10-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 47.3800011, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('9295c0d9-9a6f-4e4a-985d-aaed58a2302f', '0668ebca-a25a-4c6a-b84c-7943bf00171e', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-10-09', '2025-11-06', '2025-10-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 130.940002, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('097bb17c-6f94-49d9-b4fb-82770580d239', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-10-09', '2025-11-06', '2025-10-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 14.6199999, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('6a7b253a-6ef6-49f6-9c8f-6a499591609f', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-10-10', '2025-11-07', '2025-11-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 719.780029, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('33a3a19d-7810-4a9b-a012-cf421c42aee3', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-10-10', '2025-10-24', '2025-10-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 306.070007, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('2142373d-16d2-4b1c-b8e1-de7540c650ba', '53e16308-5b76-4e70-b284-fe5958e79a0e', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-10-11', '2025-11-08', '2025-10-16', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 65.4800034, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('a9665abc-542b-4df1-a208-bd29ec4b2601', '26240386-a6ca-4a18-910d-904cde61d93b', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-10-11', '2025-11-08', '2025-10-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 19.7600002, 'Dawn Supply Ltd', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('0cbf1607-3344-4af8-9c16-cc2ccb2f4cff', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-10-11', '2025-11-08', '2025-10-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 37.5200005, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('8a17abb7-4df5-4d94-a9b6-96d66b231b78', '39a6fd07-d871-4d12-889a-1bfd8d79dea2', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-10-12', '2025-11-09', '2025-10-19', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 36.6800003, 'Quartz Retail Group', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA');
INSERT INTO orders VALUES ('765bbd7a-20ca-4a32-af0b-b819df3892af', '91e82c3d-bf19-4224-9571-a65057c5916e', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-10-12', '2025-11-09', '2025-10-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 7, 'Crestview Distribution Ltd', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA');
INSERT INTO orders VALUES ('430d7036-5907-4f42-92b1-872cd2c466ef', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-10-13', '2025-11-10', '2025-10-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 163.970001, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('bf5e936d-75d7-40d5-a6df-cb3e68d3a4f3', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-10-13', '2025-11-10', '2025-11-03', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 1.23000002, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('e64721e0-4432-441c-89d9-c81e7a8053f9', '2a76dd54-c4c4-410f-bc6c-4d9f8a992e4d', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-10-13', '2025-11-10', '2025-10-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 79.25, 'Arbor Distribution Co', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany');
INSERT INTO orders VALUES ('bb741d9b-3434-414f-97d1-e1e1447d7296', 'd00b541e-ef93-4148-9fe8-e36d3d9ce734', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-10-16', '2025-11-13', '2025-11-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 7.09000015, 'Ironwood Retail Partners', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France');
INSERT INTO orders VALUES ('0f9fc20b-5316-4631-ae90-ff629871519a', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-10-16', '2025-10-30', '2025-11-10', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 63.5400009, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('5137d5fb-11d3-4bf4-99d8-769f95553b78', 'c409b555-9e62-4606-b2ff-63dacb2c17dc', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-10-17', '2025-10-31', '2025-11-08', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 90.8499985, 'Liberty Trading Partners', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('8528a6e3-d599-4c94-a683-c8ffaeb5e10c', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-10-17', '2025-11-14', '2025-10-27', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 154.720001, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('007b3123-0a13-4ea9-ac4d-befc0e91fdf8', 'ce6bfe1b-34e1-4750-a003-271ce4dc6912', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-10-17', '2025-11-28', '2025-10-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 81.8300018, 'Keystone Supply Chain', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil');
INSERT INTO orders VALUES ('1bff3c4f-b584-42aa-b9b8-86786b86e895', '070ee85e-07e7-4886-bf50-ba55c77160d9', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-10-18', '2025-11-15', '2025-10-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 72.1900024, 'Juniper Trading House', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway');
INSERT INTO orders VALUES ('47e385ce-4ff8-4d93-9fdc-b0577438d3b3', '3130b75e-08d7-4937-bfde-1974a03c950a', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-10-18', '2025-11-15', '2025-10-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 43.2599983, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('89f2c1dd-a93a-4c77-ad5a-bd4198e7c1c1', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-10-19', '2025-11-16', '2025-10-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 71.4899979, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('774d1368-edf3-4d36-86a8-64c06a1caf5b', 'ce6bfe1b-34e1-4750-a003-271ce4dc6912', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-10-19', '2025-11-16', '2025-10-23', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 29.7800007, 'Keystone Supply Chain', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil');
INSERT INTO orders VALUES ('484c6a5e-28bc-4316-a7ee-e58d820902e8', '817f71c0-4a9e-4196-b6be-2be0c2a53d85', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-10-19', '2025-11-16', '2025-10-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 69.5299988, 'Ember Trading House', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany');
INSERT INTO orders VALUES ('2ea59e2e-8146-4bba-a290-46248849ed17', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-10-20', '2025-11-17', '2025-10-25', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 411.880005, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('0d0dc247-5fd7-4c37-9fed-f5eb30d6fb88', '216c4816-2434-466a-98ee-252ad3d9d933', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-10-20', '2025-11-17', '2025-10-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 13.3199997, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('0dc9dc3c-6b4a-422f-8820-a5cf7e166065', 'e03bf9cd-810e-46fd-b925-48e73c12756a', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-10-23', '2025-11-20', '2025-10-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 59.2799988, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('3c6d5552-82ce-4548-9e52-cbb45e890d21', 'ce6bfe1b-34e1-4750-a003-271ce4dc6912', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-10-23', '2025-11-20', '2025-10-26', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 35.4300003, 'Keystone Supply Chain', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil');
INSERT INTO orders VALUES ('b73030f2-2b9c-4381-a965-57eecb71aa6d', 'e03bf9cd-810e-46fd-b925-48e73c12756a', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-10-23', '2025-12-04', '2025-11-20', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 2.71000004, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('90eeddca-29aa-4cbf-9b43-b424f801b32f', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-10-24', '2025-11-21', '2025-11-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 424.299988, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('eb0332d0-7266-41d6-8f07-97237dce5c77', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-10-24', '2025-11-21', '2025-11-02', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 54.4199982, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('8350d94f-8bb4-41af-98fa-332b5d376a3b', '0668ebca-a25a-4c6a-b84c-7943bf00171e', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-10-25', '2025-11-22', '2025-10-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 9.26000023, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('d22d3a10-26f4-4878-9211-e00248490f29', '95ddaae9-9c82-4259-b319-1a46588a652a', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-10-25', '2025-11-22', '2025-10-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 25.2199993, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('b80ab9db-33a5-4ef3-9fe4-8a2f5e484cf5', '748b439f-112d-44fa-91a4-670ef32d1621', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-10-25', '2025-11-08', '2025-11-03', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 212.979996, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('7fd63df0-27c3-43de-89b5-08dc697b5bb6', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-10-26', '2025-12-07', '2025-10-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 56.4599991, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('afba7131-d40c-465b-99d1-c84af55110c2', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-10-26', '2025-11-09', '2025-11-14', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 487.570007, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('fa098240-525c-408c-b533-5fb0937faffb', 'b272f285-be56-42e4-9a3b-b1ca1e35c44c', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-10-27', '2025-11-24', '2025-11-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 38.2400017, 'Magnolia Distribution Co', 'Berkeley Gardens 12  Brewery', 'London', NULL, 'WX1 6LT', 'UK');
INSERT INTO orders VALUES ('068a3a0b-bcaf-44b7-88f0-e31631fa2a90', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-10-27', '2025-11-24', '2025-11-03', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 0.560000002, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('5207440f-406c-4335-9b4e-5deb69f5458b', '0668ebca-a25a-4c6a-b84c-7943bf00171e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-10-27', '2025-12-08', '2025-11-03', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 49.1899986, 'Redwood Supply Partners', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France');
INSERT INTO orders VALUES ('8ea6435a-4dfd-40b7-87c8-940f31c7f4b4', '08593d96-6aac-44cc-9aff-b5c963fc26db', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-10-30', '2025-11-27', '2025-11-06', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 160.550003, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('c55d40fc-5636-4788-b138-6024161e58ba', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-10-30', '2025-11-13', '2025-11-03', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 174.050003, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('b3f09d80-c91e-4f4c-869a-94bd53fa1258', 'aaa1023c-07bb-4f15-8278-1f9c43d16275', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-10-31', '2025-11-28', '2025-11-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 53.8300018, 'Atlas Trading Partners', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany');
INSERT INTO orders VALUES ('5690c08a-3ddf-4c67-9b06-3b07b9c5447a', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-10-31', '2025-11-28', '2025-11-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 100.220001, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('3374c2a2-1a7e-474f-bf11-9670b9995c91', '7353f783-745c-41a9-8fe0-367246437f6d', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-10-31', '2025-11-28', '2025-11-08', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 170.970001, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('e5fe1c9a-5fbe-4062-81de-8d4def6b63a0', 'a3cd2482-6d56-4140-b063-ec86ab178603', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-11-01', '2025-11-29', '2025-11-14', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 58.4300003, 'Xenon Retail Corp', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico');
INSERT INTO orders VALUES ('5dd100cd-fbef-4fca-bc25-5131aea917b9', '216c4816-2434-466a-98ee-252ad3d9d933', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-11-01', '2025-11-29', '2025-11-10', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 188.850006, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('aea8fae3-73ba-4636-8576-9efc4146e6f7', '18ac5db2-45c7-43e3-8672-977d5befdb5a', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-11-02', '2025-11-30', '2025-11-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 52.5099983, 'Driftwood Supply Co', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France');
INSERT INTO orders VALUES ('88b7ce15-c6e6-4a90-b41f-208c46ca50a2', '93eee301-36bd-466c-af34-ac22fd4afdb7', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-11-02', '2025-11-30', '2025-11-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 76.0999985, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('02a7d49b-2819-4e8f-bc1c-800a398203f5', '77ffa2f5-8e8d-41b5-9af1-52327fcfb0c7', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-11-02', '2025-11-30', '2025-11-08', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 19.2600002, 'Frontier Goods International', '54, rue Royale', 'Nantes', NULL, '44000', 'France');
INSERT INTO orders VALUES ('90ac4d8a-9982-49e9-ab4c-4d80eef2db87', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-03', '2025-12-01', '2025-11-21', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 14.9300003, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('e784d99a-e614-40ea-a08e-1a7774802df9', '79222616-f296-416f-a386-57a31c0d15d7', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-11-03', '2025-12-15', '2025-11-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 53.2299995, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('f174d9ba-402f-4bcf-bfc3-0236424ec6ad', '0ef4332c-6383-486b-a577-0156519db661', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-06', '2025-12-04', '2025-11-21', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 30.2600002, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('d9b3bdc0-7ba8-4f30-a1ee-66618564c830', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-06', '2025-12-04', '2025-11-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.03999996, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('538bba86-01f4-4197-896d-ed093984615b', '748b439f-112d-44fa-91a4-670ef32d1621', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-11-06', '2025-11-20', '2025-11-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 348.140015, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('30805c35-be47-4a08-8b17-3947d289b91f', '216c4816-2434-466a-98ee-252ad3d9d933', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-11-07', '2025-12-05', '2025-11-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 109.110001, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('76517fbd-b30e-4bdd-a236-db571480d941', 'e56705d0-d0c1-463d-a72a-43b95b4e4c45', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-11-07', '2025-12-19', '2025-11-15', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 1.92999995, 'Pine Supply Group', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA');
INSERT INTO orders VALUES ('bf60fe95-2b27-49c4-b506-b546cd795c4f', 'd052d4e1-5069-4431-ba2f-4965bf158b31', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-11-08', '2025-12-06', '2025-11-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 191.270004, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('e8cd14ae-b5a3-4967-a7bd-d7508a84a906', '21c8bb0f-dfb4-460c-9136-0ca192e08207', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-11-08', '2025-12-06', '2025-11-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 143.279999, 'Jupiter Retail Systems', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK');
INSERT INTO orders VALUES ('d6d98a84-1f00-4339-8682-86b984308b2f', 'b4dc01c6-29d9-4799-b914-9424e6e210d9', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-11-08', '2025-12-06', '2025-11-17', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 12.04, 'Trident Trading Solutions', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland');
INSERT INTO orders VALUES ('75295ae0-6793-4620-9224-563ffe63600c', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-11-09', '2025-12-07', '2025-11-14', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 112.269997, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('f1d79f4c-81b6-4fcf-8937-9b439eaaee6a', '74661752-05c4-445c-9b23-573d5c0d6e19', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-11-09', '2025-12-07', '2025-11-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 175.320007, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('d9723f6f-82d3-4486-bae5-5f9e32d393dc', '01a81542-e365-4854-a3ae-fb1d7e0a4fa2', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-10', '2025-12-08', '2025-11-13', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.819999993, 'Harbor Wholesale Co', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland');
INSERT INTO orders VALUES ('d2447efc-50b5-4b4e-a199-e9d8c9404327', '74661752-05c4-445c-9b23-573d5c0d6e19', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-11-10', '2025-12-08', '2025-11-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 19.5799999, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('86871c8c-9cff-43df-85fc-114f0efd9785', '216c4816-2434-466a-98ee-252ad3d9d933', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-10', '2025-12-08', '2025-12-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 32.3699989, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('8c26f7f8-f3e9-4764-addc-b21a77b87a26', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-11-13', '2025-12-11', '2025-11-16', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 60.4199982, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('51ca79e2-10f2-4f8e-81f0-82b1cca2e0f0', '08593d96-6aac-44cc-9aff-b5c963fc26db', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-11-13', '2025-12-11', '2025-11-23', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 38.0600014, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('ff1667df-029e-4a77-b4ed-a6bfefdf4122', '748b439f-112d-44fa-91a4-670ef32d1621', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-14', '2025-12-12', '2025-11-16', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 46.6899986, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('0e5bdb8c-375e-40a1-9a56-198fa9f8b07e', '01a81542-e365-4854-a3ae-fb1d7e0a4fa2', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-11-14', '2025-12-12', '2025-11-16', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 8.5, 'Harbor Wholesale Co', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland');
INSERT INTO orders VALUES ('c552d249-e671-4eb2-8476-4e1139a23bed', '42a480f6-9c97-44c5-b327-9198e5e274e4', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-11-14', '2025-12-26', '2025-11-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 88.0100021, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('dd45dbbc-9ee1-4daf-bbd3-74a5621e257b', '26240386-a6ca-4a18-910d-904cde61d93b', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-15', '2025-12-13', '2025-11-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 2.83999991, 'Dawn Supply Ltd', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('5828fcb1-9d7c-4567-8180-34253d89c29c', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-15', '2025-12-13', '2025-11-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 23.1000004, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('ce7086ff-1acc-4e7c-8787-39d441a110fb', 'e56705d0-d0c1-463d-a72a-43b95b4e4c45', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-11-16', '2025-12-14', '2025-11-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 0.529999971, 'Pine Supply Group', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA');
INSERT INTO orders VALUES ('e46df30a-8098-4cf2-b15f-f4e3e58f9121', 'c71720d2-cb57-45c6-8b31-7a7b96f72646', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-16', '2025-12-14', '2025-11-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 90.9700012, 'Olympus Distribution Co', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA');
INSERT INTO orders VALUES ('8be79674-6e6d-41c3-933d-41486f1cd2f5', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-11-16', '2025-12-14', '2025-11-22', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 5.63999987, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('82840cdb-27b9-4e4b-85bf-fb92cd532a1f', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-11-17', '2025-12-15', '2025-12-04', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 4.98999977, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('c897a3c8-6431-420f-8b42-e2d3789d94a0', 'd3cbab71-5f3b-4754-9ccb-19e009469e7b', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-11-17', '2025-12-15', '2025-11-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.25, 'Summit Trade Group', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain');
INSERT INTO orders VALUES ('563f6dca-dffb-4180-9d13-b697eaf99e14', '74661752-05c4-445c-9b23-573d5c0d6e19', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-11-20', '2025-12-18', '2025-11-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 51.8699989, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('81ffc4cf-7f8b-4336-b232-bb68d7471f4f', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-11-20', '2025-12-18', '2025-11-27', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 280.609985, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('d50f45a4-84d8-47b6-a03b-43a8b983d115', 'c81e7c16-d8f1-43a8-a1c4-27847709ce21', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-11-20', '2025-12-18', '2025-11-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 32.7599983, 'Elm Commerce Group', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France');
INSERT INTO orders VALUES ('77eb7698-fc10-48d5-950a-215cc327b407', '79222616-f296-416f-a386-57a31c0d15d7', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-11-21', '2025-12-19', '2025-11-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 20.3700008, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('1a6637d3-7396-4f29-b222-551b7ae55144', 'eb488881-56d2-4219-a3b5-26ff37fb74be', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-21', '2025-12-19', '2025-11-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 120.269997, 'Cobalt Commerce Group', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium');
INSERT INTO orders VALUES ('072a86e6-4833-4de7-9dbb-77797157ba0c', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-11-22', '2025-12-20', '2025-11-24', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 77.7799988, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('96aa4e3d-3581-4fdd-b7ba-0fc075e12301', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-11-22', '2025-12-20', '2025-11-24', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 116.129997, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('81c27e3e-5418-47ea-a507-05bbaeea3b78', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-11-22', '2025-12-20', '2025-11-27', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 162.75, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('54d14c74-97f8-46cb-831a-c6fd939a5ba9', 'eb488881-56d2-4219-a3b5-26ff37fb74be', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-11-23', '2025-12-21', '2025-12-01', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 32.4500008, 'Cobalt Commerce Group', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium');
INSERT INTO orders VALUES ('f5639171-b645-4bb9-99b0-6a165376722b', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-11-23', '2025-12-21', '2025-11-29', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 603.539978, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('1b622dcc-ff07-4ec7-a4b0-e8b45bd507c4', 'ee578022-9abf-46ca-ad0e-76be2b19007c', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-24', '2025-12-22', '2025-12-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.26999998, 'Bloom Trading Partners', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('e2805cc5-a3a7-43c6-a370-7b1081004147', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-11-24', '2025-12-22', '2025-11-30', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 1.21000004, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('720e1b66-b879-479b-8de3-d3fff89c948c', '5506f7ee-50bd-4a1e-a15d-b6f223d32c67', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-11-24', '2025-12-22', '2025-12-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.65999997, 'Horizon Merchants', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO orders VALUES ('8a033b35-234a-43e1-a451-6cdec5849bbc', '0ef4332c-6383-486b-a577-0156519db661', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-27', '2025-12-25', '2025-11-30', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 62.0900002, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('97e04f8a-dcd8-40c7-9ebb-26907d8979b5', '42a480f6-9c97-44c5-b327-9198e5e274e4', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-11-27', '2025-12-25', '2025-12-05', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 44.1500015, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('076d0aca-4cfe-48da-99ab-008932b4dbac', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-11-28', '2025-12-26', '2025-12-06', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 36.7099991, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('91c20b9c-889a-44d0-aa38-c0dcff931073', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-11-28', '2025-12-26', '2025-12-01', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 162.949997, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('ecc1d718-8943-4ec2-9afc-aa71e65e9ba5', '5506f7ee-50bd-4a1e-a15d-b6f223d32c67', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-11-28', '2025-12-26', '2025-12-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 13.7200003, 'Horizon Merchants', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO orders VALUES ('19b581f2-2ad9-4d4d-81c6-13cb929c8226', 'b4dc01c6-29d9-4799-b914-9424e6e210d9', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-29', '2025-12-13', '2025-12-05', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 26.2900009, 'Trident Trading Solutions', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland');
INSERT INTO orders VALUES ('d04cc93b-d98f-4f3f-b77b-5c25956d7b4d', 'e6914765-3d71-472f-9efd-119e184b3c0a', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-11-29', '2025-12-27', '2025-12-01', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 9.18999958, 'Windsor Supply Group', '25, rue Lauriston', 'Paris', NULL, '75016', 'France');
INSERT INTO orders VALUES ('0177bc6e-8ef7-4de5-9ccd-9ee949085281', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-30', '2025-12-28', '2025-12-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 32.9599991, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('59b38930-2302-489d-ae2e-7f1796f90019', '070ee85e-07e7-4886-bf50-ba55c77160d9', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-11-30', '2025-12-28', '2025-12-12', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 53.0499992, 'Juniper Trading House', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway');
INSERT INTO orders VALUES ('3ae2bca6-ce74-4bed-8e65-261ae6803f2f', '01a81542-e365-4854-a3ae-fb1d7e0a4fa2', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-11-30', '2025-12-28', '2025-12-06', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 38.1100006, 'Harbor Wholesale Co', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland');
INSERT INTO orders VALUES ('4a944548-da0e-4403-991c-51f08ec84c80', '74661752-05c4-445c-9b23-573d5c0d6e19', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-11-30', '2025-12-28', '2025-12-07', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 38.1899986, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('d41c5f04-7c79-4405-99db-3162c9f071af', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-11-30', '2025-12-28', '2025-12-20', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 580.909973, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('8302ae44-c35b-42cf-a59a-4872d97d7478', 'd052d4e1-5069-4431-ba2f-4965bf158b31', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-11-30', '2025-12-28', '2025-12-06', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 33.0499992, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('e9585766-812d-439e-9a95-e4bb1035b6f9', 'd052d4e1-5069-4431-ba2f-4965bf158b31', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-12-01', '2025-12-29', '2025-12-04', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 21.1900005, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('c91e1d68-f36a-4074-8a97-f7b3f4c09a6b', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-12-01', '2025-12-29', '2025-12-04', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.50999999, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('4f55aab8-7a3e-49d8-8cc2-9b7e2d7f98e9', 'c409b555-9e62-4606-b2ff-63dacb2c17dc', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-01', '2025-12-29', '2025-12-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 63.7700005, 'Liberty Trading Partners', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('ac29f94d-b378-4884-ad26-6be093910bde', '689c7f09-ae86-48b0-838d-dc4c046c757d', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-04', '2026-01-01', '2025-12-13', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 8.28999996, 'Diamond Retail Solutions', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain');
INSERT INTO orders VALUES ('49332e64-68f9-4db3-a0ee-0f85835298dc', 'b331de10-47a7-468f-98db-ad5c2d1a041f', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-04', '2026-01-01', '2025-12-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 48.8300018, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('c282cc10-221f-48cf-ba89-12d6637c8726', 'e03bf9cd-810e-46fd-b925-48e73c12756a', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-12-04', '2026-01-01', '2025-12-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 19.7999992, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('8c4e0478-54a0-4461-88c1-c8a48b685e7c', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-05', '2026-01-02', '2025-12-11', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 29.6100006, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('a07e1f37-0c60-4b53-b09f-a3e6d712bc5a', '350fda94-3e7d-4a1f-8408-fe06024eca1e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-05', '2026-01-16', '2025-12-11', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 176.479996, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('68f29764-4f55-482d-ad62-712ba7c7f70d', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-12-05', '2026-01-02', '2025-12-07', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 62.7400017, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('4e39eded-1e93-4af9-8a59-4dcf3679cdbf', '3130b75e-08d7-4937-bfde-1974a03c950a', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-12-05', '2026-01-16', '2025-12-15', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 68.2600021, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('c5baa91c-2db9-48cb-81e4-b3a2fbde62fc', '216c4816-2434-466a-98ee-252ad3d9d933', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-06', '2026-01-03', '2026-01-10', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 151.520004, 'Alpine Trading Solutions', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden');
INSERT INTO orders VALUES ('44998283-adeb-459f-ad02-c68c3f209838', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-06', '2026-01-03', '2025-12-15', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 2.26999998, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('6a89e00b-2b62-495c-9785-222e4311b888', 'ccee083f-d880-4792-b08c-4059192a96a7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-06', '2026-01-03', '2025-12-13', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 39.9199982, 'Kingston Supply Group', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico');
INSERT INTO orders VALUES ('6c0027dc-22d6-419e-9143-ce1a4b2e5d9d', '18ac5db2-45c7-43e3-8672-977d5befdb5a', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-07', '2026-01-04', '2026-01-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 19.7900009, 'Driftwood Supply Co', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France');
INSERT INTO orders VALUES ('0002ac81-f37c-4889-9509-c3514e1a0704', 'd3cbab71-5f3b-4754-9ccb-19e009469e7b', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-07', '2026-01-04', '2025-12-20', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 1.36000001, 'Summit Trade Group', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain');
INSERT INTO orders VALUES ('e245cb67-7b6d-4309-ab60-a4e64e35bcd9', '93eee301-36bd-466c-af34-ac22fd4afdb7', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-12-07', '2026-01-04', '2025-12-14', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 33.9300003, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('61d21626-1398-426b-ab68-86a85ec6dfa7', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-08', '2026-01-19', '2025-12-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 15.5500002, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('bc81121d-263e-41c9-969a-bcd731035b4e', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-08', '2025-12-22', '2025-12-21', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 13.6000004, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('5d644bac-da02-4568-8d2f-8ec92935e072', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-12-08', '2026-01-05', '2025-12-26', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 134.639999, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('3243f36e-5b73-45f1-baac-1df2f8613c08', '76b913eb-25b1-4e3a-9fa9-ee6179e5489e', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-12-08', '2026-01-05', '2025-12-18', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 54.1500015, 'Highland Trading House', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK');
INSERT INTO orders VALUES ('bf57b2d2-8d85-4894-be1c-2f8f7d99f795', '79222616-f296-416f-a386-57a31c0d15d7', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-11', '2026-01-08', '2025-12-14', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 32.0099983, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('51200191-d8b9-43a2-b361-d7420d490aa8', '5506f7ee-50bd-4a1e-a15d-b6f223d32c67', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-11', '2026-01-08', '2025-12-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 47.5900002, 'Horizon Merchants', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO orders VALUES ('2c825fab-721e-46ed-a976-6463081e1e24', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-11', '2026-01-08', '2025-12-20', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 33.6800003, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('62ce2086-3eb1-47fe-9401-862b76c9eb28', '26240386-a6ca-4a18-910d-904cde61d93b', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-12-12', '2025-12-26', '2025-12-15', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 31.5100002, 'Dawn Supply Ltd', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('1dbb9678-2e43-4433-9856-3ce007a5f086', '748b439f-112d-44fa-91a4-670ef32d1621', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-12', '2026-01-09', '2025-12-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 31.8899994, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('97b8dfd9-133f-4610-b422-d16279b8dd89', '53e16308-5b76-4e70-b284-fe5958e79a0e', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-12-12', '2026-01-09', '2025-12-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 76.3300018, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('35440e32-123f-4db6-9973-2da151e8f9cf', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-12-13', '2026-01-10', '2025-12-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 19.7700005, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('416b281e-0c55-4d9e-8118-929605d9f10f', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-12-13', '2026-01-10', '2025-12-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 400.809998, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('00b65946-6ff8-4c28-8ef5-7b56422da763', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-12-13', '2026-01-10', '2025-12-20', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 17.9500008, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('61e55515-f2f0-48d1-a382-ef477d5319e3', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-13', '2026-01-10', '2025-12-21', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 2.17000008, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('6765ffad-e8c9-400e-add5-bbc3118468cc', 'b331de10-47a7-468f-98db-ad5c2d1a041f', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-12-14', '2025-12-28', '2025-12-15', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 52.9199982, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('db8293fb-ab1d-40b1-8164-d6619c816949', '404621e7-d665-4801-bfce-aa17d22b435f', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-14', '2026-01-11', '2025-12-20', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 10.2200003, 'Neptune Commerce Ltd', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany');
INSERT INTO orders VALUES ('1b5073fd-c07e-4b09-b63a-2f27d6ea3112', '350fda94-3e7d-4a1f-8408-fe06024eca1e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-14', '2026-01-11', '2025-12-21', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 27.2000008, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('e5154ebd-9b07-45f7-83df-6b63241f0427', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-15', '2026-01-12', '2025-12-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.25999999, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('7ef9a09a-9265-4d1c-8706-f8d7faf687a8', '74661752-05c4-445c-9b23-573d5c0d6e19', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-15', '2026-01-12', '2025-12-21', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 23.3899994, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('595995ac-5403-4411-8a7b-3c0d23703786', 'b331de10-47a7-468f-98db-ad5c2d1a041f', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-12-15', '2026-01-12', '2025-12-19', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 74.4400024, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('a19b00cb-4a4f-4bbf-8a8c-703b4f85ea9e', '53e16308-5b76-4e70-b284-fe5958e79a0e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-18', '2026-01-15', '2025-12-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 2.5, 'Jade Distribution Co', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy');
INSERT INTO orders VALUES ('c74f26f2-ad20-4443-bc8b-2c8ce2dd61d6', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-12-18', '2026-01-29', '2026-01-09', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 30.8500004, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('d157f6ad-878c-4efd-85cd-3180cc48285f', '817f71c0-4a9e-4196-b6be-2be0c2a53d85', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-18', '2026-01-29', '2025-12-26', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 40.4199982, 'Ember Trading House', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany');
INSERT INTO orders VALUES ('22f536b0-ac75-4c02-b8e6-e2853f3934ea', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-12-18', '2026-01-01', '2025-12-27', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 23.7199993, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('874a80ad-253a-44e7-91ba-2e04d309e982', 'e03bf9cd-810e-46fd-b925-48e73c12756a', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2025-12-19', '2026-01-30', '2025-12-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 27.9099998, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('b095b23f-0779-4a8a-aa15-578da0efee60', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-12-19', '2026-01-16', '2025-12-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 3.25999999, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('80bb4193-5d37-4f97-8495-4f5a693aba70', 'aaa1023c-07bb-4f15-8278-1f9c43d16275', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-12-19', '2026-01-30', '2025-12-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 44.6500015, 'Atlas Trading Partners', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany');
INSERT INTO orders VALUES ('cb26e351-f241-41af-b52c-dd52493e93fc', '0ef4332c-6383-486b-a577-0156519db661', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-12-20', '2026-01-17', '2025-12-29', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 105.360001, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('db39fcc6-e569-4575-8a86-f3e9559ffa65', 'ee578022-9abf-46ca-ad0e-76be2b19007c', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2025-12-20', '2026-01-17', '2025-12-29', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 49.5600014, 'Bloom Trading Partners', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('b725e4fd-e64c-482b-aab2-8f5192806f31', 'f7f06986-6907-4481-92af-bfc5511a56e7', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-12-20', '2026-01-31', '2025-12-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.98000002, 'Ultra Retail Systems', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO orders VALUES ('8769d153-19cb-458d-8ee5-34cdcc97ea4d', '0ef4332c-6383-486b-a577-0156519db661', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-21', '2026-01-04', '2026-01-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 2.07999992, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('b8dc2008-6af5-43b4-97f5-281f351b86ad', 'd052d4e1-5069-4431-ba2f-4965bf158b31', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-12-21', '2026-01-18', '2026-01-01', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 104.470001, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('d82bf748-5b47-43d0-b79b-fc0e09801a4a', '748b439f-112d-44fa-91a4-670ef32d1621', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-12-21', '2026-01-18', '2025-12-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 275.790009, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('bb4f3fb0-cf02-43f5-830b-415450238a34', '73ac725b-10e5-410f-bddd-d9c60fd0ec46', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-12-21', '2026-01-18', '2025-12-28', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 2.70000005, 'Acorn Trading House', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal');
INSERT INTO orders VALUES ('977b3d2d-a45f-4e3d-84ef-192e90552adc', 'e6914765-3d71-472f-9efd-119e184b3c0a', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-22', '2026-01-19', '2025-12-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 87.3799973, 'Windsor Supply Group', '25, rue Lauriston', 'Paris', NULL, '75016', 'France');
INSERT INTO orders VALUES ('498ea36e-4bc1-4437-8fcb-3d198f8fdf15', '7353f783-745c-41a9-8fe0-367246437f6d', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-12-22', '2026-01-19', '2026-01-01', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 144.380005, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('24865360-0d6e-47fc-a3d1-690d394b5ce6', '346cfbc3-e2c8-4c26-92ec-df34bad2e944', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-22', '2026-01-19', '2026-01-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 27.1900005, 'Glacier Commerce Ltd', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland');
INSERT INTO orders VALUES ('a20fe9ce-048d-44ea-bf97-f7419cdeb14e', '7379764d-d1e9-4e61-9016-7d804b30c2eb', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-12-25', '2026-01-22', '2026-01-04', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 62.2200012, 'Kestrel Supply Group', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany');
INSERT INTO orders VALUES ('b7b8b6d8-de5e-48ba-be15-53ea5d83103e', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-25', '2026-01-22', '2026-01-03', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 74.5999985, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('2e944c35-aecc-44b8-9642-81555f59580c', '1d3de59b-fd0b-4277-8192-b02fda2e41db', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-25', '2026-01-22', '2026-01-01', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 0.209999993, 'Oak Retail Systems', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil');
INSERT INTO orders VALUES ('c9ad400e-2018-4816-be63-40e47534ff35', '9f303dd7-f723-44ca-83ab-1076b4d8c364', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-12-26', '2026-01-09', '2026-01-26', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 16.1599998, 'Mercury Wholesale Group', 'C/ Araquil, 67', 'Madrid', NULL, '28023', 'Spain');
INSERT INTO orders VALUES ('f5060b6f-5f87-42ab-a573-800272a0ff9a', '77ffa2f5-8e8d-41b5-9af1-52327fcfb0c7', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-12-26', '2026-01-23', '2026-01-04', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 121.82, 'Frontier Goods International', '54, rue Royale', 'Nantes', NULL, '44000', 'France');
INSERT INTO orders VALUES ('70f7ba8f-f954-492b-a3c7-130505c6a91e', '18ac5db2-45c7-43e3-8672-977d5befdb5a', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-26', '2026-01-23', '2025-12-28', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 0.0199999996, 'Driftwood Supply Co', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France');
INSERT INTO orders VALUES ('3cd2bd14-d89e-4bab-90a1-7d28b27c966e', '18ac5db2-45c7-43e3-8672-977d5befdb5a', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2025-12-26', '2026-01-23', '2025-12-29', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 15.1700001, 'Driftwood Supply Co', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France');
INSERT INTO orders VALUES ('c5f0dbb1-70dc-4dd8-9b98-a653e6d9b156', '39a6fd07-d871-4d12-889a-1bfd8d79dea2', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2025-12-27', '2026-01-10', '2026-01-05', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 12.96, 'Quartz Retail Group', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA');
INSERT INTO orders VALUES ('bf197616-14d2-4d84-9dcb-6e09eda16446', 'b331de10-47a7-468f-98db-ad5c2d1a041f', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-27', '2026-01-24', '2025-12-29', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 32.2700005, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('601aab97-e9d4-4134-86c0-4870bd3724e3', '0ef4332c-6383-486b-a577-0156519db661', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-27', '2026-02-07', '2026-01-05', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 37.9700012, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('84b45687-1873-4a6b-acde-267735114e07', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-12-28', '2026-01-25', '2026-01-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 208.5, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('bc5b5268-c4aa-41f4-9207-c3b22a8372f9', 'eb488881-56d2-4219-a3b5-26ff37fb74be', 'bd734f3c-b888-489c-a098-4395f9565d97', '2025-12-28', '2026-01-25', '2026-01-25', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 32.8199997, 'Cobalt Commerce Group', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium');
INSERT INTO orders VALUES ('c5e783ca-fa83-474c-964f-b6ac6615148c', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2025-12-28', '2026-01-25', '2026-01-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 353.070007, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('b8391efe-8381-4f30-86d9-6464d6e9aad2', '42a480f6-9c97-44c5-b327-9198e5e274e4', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2025-12-29', '2026-02-09', '2026-01-19', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 1.25999999, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('4541b707-ddae-4a34-b7c8-88f43597e5dd', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2025-12-29', '2026-01-26', '2026-01-04', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 193.369995, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('1d50ee52-bebf-4c33-9a73-eda60dee4886', 'b331de10-47a7-468f-98db-ad5c2d1a041f', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-12-29', '2026-01-26', '2026-01-10', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 14.0100002, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('2a063f65-a2b3-4b20-853f-41e7151b5d40', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2025-12-29', '2026-01-26', '2026-01-08', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 657.539978, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('8fa3eecb-9ec5-48fd-9651-a1acf293f339', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-01-01', '2026-01-29', '2026-01-05', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 211.220001, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('2918dceb-215f-4bdd-9de5-0f17d65a1356', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-01', '2026-01-29', '2026-01-04', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 91.5100021, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('15af3089-56c2-46c3-bf34-433ad6500ca7', 'ee578022-9abf-46ca-ad0e-76be2b19007c', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-01', '2026-01-29', '2026-01-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 217.860001, 'Bloom Trading Partners', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('420dea45-4a75-48e6-9f06-1a17bc925c30', '00c51812-32fe-4ea7-93cd-6ac81afcce12', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-02', '2026-01-30', '2026-01-08', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 185.479996, 'Phoenix Trading Inc', '35 King George', 'London', NULL, 'WX3 6FW', 'UK');
INSERT INTO orders VALUES ('6d7fc950-01a7-4a76-885b-bc0fdf928c6f', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-02', '2026-01-30', '2026-01-12', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 61.1399994, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('43a5d040-20fa-4985-aa07-3febf28059d2', 'b8b9cec5-a2ae-4b5d-beb1-593106c6afe5', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-02', '2026-01-30', '2026-01-04', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 34.7599983, 'Crown Retail Solutions', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO orders VALUES ('06706287-ab98-40b1-bacc-700ca04d8440', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-03', '2026-02-14', '2026-01-09', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 117.610001, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('351afb0d-9898-44df-a371-b642294563b1', '748b439f-112d-44fa-91a4-670ef32d1621', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-01-03', '2026-01-31', '2026-01-09', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 38.5099983, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('8f9096aa-3299-4197-a1ab-c9e2f20fbcfa', '4df2df85-b445-43b3-a8a6-f5b65d0cc8c8', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-01-03', '2026-01-31', '2026-01-05', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.26999998, 'Zenith Commerce Group', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA');
INSERT INTO orders VALUES ('0857896b-411f-4715-a11b-d69af36bb9e5', '42a480f6-9c97-44c5-b327-9198e5e274e4', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-01-03', '2026-01-31', '2026-01-12', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 8.81000042, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('52d4a078-b224-4d08-98c8-39b9215d0124', '350fda94-3e7d-4a1f-8408-fe06024eca1e', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-04', '2026-01-18', '2026-01-11', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 65.5299988, 'Ivory Retail Systems', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark');
INSERT INTO orders VALUES ('e4957fad-a2e7-4513-8135-f317a103d44b', '078abbfd-fbac-4432-9528-c7a98ea5351c', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-01-04', '2026-02-01', '2026-01-08', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 46, 'Vector Trading House', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('0c7c251b-38a4-4b36-a2b9-5756051dbf0c', '748b439f-112d-44fa-91a4-670ef32d1621', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-01-04', '2026-02-01', '2026-01-12', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 1.12, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('1f459425-59b3-44ba-809f-9dbb51d93ee9', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-05', '2026-02-16', '2026-01-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 73.9100037, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('c0a4041a-817d-4786-8e77-be4cc62541eb', 'b4dc01c6-29d9-4799-b914-9424e6e210d9', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-05', '2026-01-19', '2026-01-19', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 20.3099995, 'Trident Trading Solutions', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland');
INSERT INTO orders VALUES ('aceb8b18-510c-4156-a372-c86e3a90056a', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2026-01-05', '2026-02-02', '2026-01-12', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 96.3499985, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('dcc6627b-f490-4db7-820d-b408adc13305', '2569e109-6d44-4f1a-8919-db63efb4ca9e', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-08', '2026-02-05', '2026-01-16', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 55.1199989, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO orders VALUES ('953ab6ec-00cb-4879-898b-58b5ab26a8b9', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-08', '2026-02-05', '2026-01-16', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 197.300003, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('176afffb-4ebe-457d-8117-5054b71a1bc2', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-01-08', '2026-02-05', '2026-01-18', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 141.160004, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('cde296f6-eec8-449f-965d-8e2ce1789133', '56184b85-2929-4ae4-8933-685e484b9933', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-08', '2026-02-05', '2026-01-10', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 14.9099998, 'Sterling Trade Partners', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA');
INSERT INTO orders VALUES ('abd27f3d-9857-484c-a14a-356d44a9f06a', 'eb488881-56d2-4219-a3b5-26ff37fb74be', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-09', '2026-02-06', '2026-01-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 44.8400002, 'Cobalt Commerce Group', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium');
INSERT INTO orders VALUES ('023cba26-4bee-42cf-b0b2-54c2c7066d84', '01a81542-e365-4854-a3ae-fb1d7e0a4fa2', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-09', '2026-02-06', '2026-01-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.75, 'Harbor Wholesale Co', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland');
INSERT INTO orders VALUES ('cb7d75d1-0600-4bce-a18a-81f5b8ff5c24', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-09', '2026-02-06', '2026-01-17', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 25.1900005, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('f938d20a-c896-4229-8afc-bd6e1ea70451', '82e1941f-8f2c-4015-bcec-36ec4ab51900', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-10', '2026-02-07', '2026-01-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 202.240005, 'Quantum Retail Solutions', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal');
INSERT INTO orders VALUES ('fc6125a8-d51b-4386-8dd4-33ebf47d57dc', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-01-10', '2026-02-07', NULL, '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 79.4599991, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('196840fb-ceaa-49e4-9076-e2733dd2e239', '74661752-05c4-445c-9b23-573d5c0d6e19', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-10', '2026-02-07', '2026-01-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 59.1100006, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('d72cc9f6-d96c-43a3-8b5f-2438a1bd3804', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-11', '2026-02-08', '2026-01-23', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 28.7099991, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('04faf2a6-2eb4-450d-8bd6-e52817206999', '817f71c0-4a9e-4196-b6be-2be0c2a53d85', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-11', '2026-02-08', '2026-01-15', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 1.21000004, 'Ember Trading House', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany');
INSERT INTO orders VALUES ('0d01cb93-6c14-4a1c-9602-499123dfc47b', '93eee301-36bd-466c-af34-ac22fd4afdb7', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-01-11', '2026-01-25', '2026-01-19', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 242.949997, 'Cedar Distribution Partners', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany');
INSERT INTO orders VALUES ('59d366d2-b9a5-424e-b764-1be28da346f1', '689c7f09-ae86-48b0-838d-dc4c046c757d', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-11', '2026-02-08', '2026-01-12', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 32.9900017, 'Diamond Retail Solutions', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain');
INSERT INTO orders VALUES ('29724206-95af-42cd-bc4d-3d9ee0a1768f', 'e03bf9cd-810e-46fd-b925-48e73c12756a', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-12', '2026-02-09', '2026-01-17', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 23.6000004, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('79b9ad7d-e160-4cdf-886d-14e831e2cb65', '070ee85e-07e7-4886-bf50-ba55c77160d9', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-12', '2026-01-26', '2026-01-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 4.61999989, 'Juniper Trading House', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway');
INSERT INTO orders VALUES ('4dfa60c2-14df-4c26-9f24-0c3034b2a328', '0d8202b4-6a2c-42ce-8e57-8626b3dc1364', 'bd734f3c-b888-489c-a098-4395f9565d97', '2026-01-12', '2026-02-09', '2026-01-15', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 33.7999992, 'Delta Commerce Partners', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO orders VALUES ('0c602094-606f-43f6-9427-4d215346c415', '1b7d3237-76cf-49fc-89a7-2e7668507cde', 'bd734f3c-b888-489c-a098-4395f9565d97', '2026-01-15', '2026-02-12', '2026-01-22', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 754.26001, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('a58cfde9-208d-4b7b-8658-a1e8bdf20343', 'e56705d0-d0c1-463d-a72a-43b95b4e4c45', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-01-15', '2026-02-12', '2026-01-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 11.6499996, 'Pine Supply Group', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA');
INSERT INTO orders VALUES ('3fd589e7-0842-465e-853c-ed9f036390fc', 'c409b555-9e62-4606-b2ff-63dacb2c17dc', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2026-01-15', '2026-02-12', NULL, '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 3.17000008, 'Liberty Trading Partners', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('c9111896-af4e-4699-b4aa-5d9497cdc877', 'cb2bf788-805e-4ed2-b25d-ddce939f06b1', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-16', '2026-02-13', '2026-01-18', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 43.2999992, 'Pinnacle Retail Co', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany');
INSERT INTO orders VALUES ('953d3b0b-2946-486a-b78d-3c4f370b903f', '748b439f-112d-44fa-91a4-670ef32d1621', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-16', '2026-02-13', '2026-01-23', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 297.179993, 'Bronson Wholesale Ltd', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany');
INSERT INTO orders VALUES ('b90b16b2-a371-4dc3-87aa-f718fd4f7794', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', 'bd734f3c-b888-489c-a098-4395f9565d97', '2026-01-16', '2026-02-13', '2026-02-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 6.26999998, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('460550cf-be4e-4d30-a3df-8ba147d5dbe0', 'cd654708-1a85-4fcf-a5a4-777b0c069ba5', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-01-16', '2026-01-30', '2026-01-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 123.830002, 'Unity Distribution Ltd', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK');
INSERT INTO orders VALUES ('cca64685-b37c-43db-bd74-4ec31e4d1184', '00c51812-32fe-4ea7-93cd-6ac81afcce12', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-01-17', '2026-02-14', '2026-01-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 74.3600006, 'Phoenix Trading Inc', '35 King George', 'London', NULL, 'WX3 6FW', 'UK');
INSERT INTO orders VALUES ('13612767-8c86-4343-8317-c0b9c2c254f5', 'af354600-23a9-4298-9157-75ff7c92a119', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2026-01-17', '2026-02-14', '2026-01-26', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 29.1700001, 'Riverside Supply Co', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland');
INSERT INTO orders VALUES ('1a2d5800-bfaf-43b9-8c51-ab50704e74b2', '05464425-fc77-4a44-9a69-5f6f6ec147b9', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-01-17', '2026-02-14', '2026-01-30', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 47.0900002, 'Crimson Distribution Co', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy');
INSERT INTO orders VALUES ('147c51eb-29b7-4f60-af97-38cb1fa0219b', 'b331de10-47a7-468f-98db-ad5c2d1a041f', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-01-18', '2026-02-15', '2026-01-22', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 52.5200005, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('4ef68285-9fc8-4028-aea5-c6acfa480275', 'bf9c8246-f18b-45ec-8733-a1728259b5a6', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-18', '2026-02-15', '2026-01-24', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 29.5900002, 'Fir Trading Systems', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany');
INSERT INTO orders VALUES ('3f4632d0-89f1-44c5-9448-0d6c8a06cdb7', '346cfbc3-e2c8-4c26-92ec-df34bad2e944', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-01-18', '2026-02-15', '2026-01-29', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 47.8400002, 'Glacier Commerce Ltd', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland');
INSERT INTO orders VALUES ('048a1c81-e603-4445-991a-ccd5db4711d6', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-01-19', '2026-02-16', '2026-01-29', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 830.75, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('7d4bb709-8034-47ea-9787-c19f1f467534', '20f34a05-8fca-4a71-be1b-c9188bad6df0', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2026-01-19', '2026-02-16', '2026-01-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 227.220001, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('45ad2446-4f5f-446e-a71e-0ed4d12bf0f0', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-19', '2026-02-16', '2026-01-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 606.190002, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('3b8e5fc2-0520-4401-aa4a-92dd58c19d4b', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-01-19', '2026-02-16', '2026-01-25', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 84.7399979, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('2c9ccbdc-36b2-4367-ab35-d8f37e39df88', '7353f783-745c-41a9-8fe0-367246437f6d', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-22', '2026-03-05', '2026-01-29', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 40.3199997, 'Glade Distribution Systems', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA');
INSERT INTO orders VALUES ('a355fa43-c85f-4d73-8eed-de0108f01881', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-22', '2026-02-19', '2026-01-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 0.170000002, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('dd01d5a6-932b-411a-9ceb-08ae2c94805e', '2a76dd54-c4c4-410f-bc6c-4d9f8a992e4d', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-22', '2026-02-19', '2026-01-24', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 149.470001, 'Arbor Distribution Co', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany');
INSERT INTO orders VALUES ('c9770984-62d2-48bf-b431-5d587ddcc163', '74661752-05c4-445c-9b23-573d5c0d6e19', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-01-23', '2026-02-20', '2026-01-29', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 3.20000005, 'Kapok Supply Solutions', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain');
INSERT INTO orders VALUES ('26e5a0df-148b-4066-8e73-444c8aa05fe8', 'cac0dfc7-9686-4f1b-9cba-4ca27683da64', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-01-23', '2026-02-20', '2026-02-01', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 29.5900002, 'Titan Commerce Partners', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium');
INSERT INTO orders VALUES ('376c73ec-2c73-4f4f-8b2a-af1bf7748fa7', 'e03bf9cd-810e-46fd-b925-48e73c12756a', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-01-23', '2026-02-20', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 65, 'Inlet Retail Partners', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO orders VALUES ('2aaaddc9-b2cc-4ecf-b5a2-0bbcad9c373a', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-01-24', '2026-02-21', NULL, '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 18.8400002, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('06b37a47-e8dc-40b6-81c2-af74607124cd', '346cfbc3-e2c8-4c26-92ec-df34bad2e944', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-24', '2026-02-21', '2026-01-30', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 48.2200012, 'Glacier Commerce Ltd', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland');
INSERT INTO orders VALUES ('aa41f76e-3382-4ebb-be54-2908d685f7f4', '1d3de59b-fd0b-4277-8192-b02fda2e41db', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-24', '2026-02-07', '2026-02-02', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 29.9899998, 'Oak Retail Systems', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil');
INSERT INTO orders VALUES ('5319044b-5991-4b0f-811d-0cb5bb8e7588', 'e6914765-3d71-472f-9efd-119e184b3c0a', 'db5e3cae-2e6e-4d67-8b38-df1833f9d75f', '2026-01-24', '2026-02-21', '2026-01-31', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 8.80000019, 'Windsor Supply Group', '25, rue Lauriston', 'Paris', NULL, '75016', 'France');
INSERT INTO orders VALUES ('e8054b77-0bc8-4ae9-b292-a0e8a2aeba01', 'b4dc01c6-29d9-4799-b914-9424e6e210d9', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-01-25', '2026-02-22', '2026-02-02', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 8.72000027, 'Trident Trading Solutions', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland');
INSERT INTO orders VALUES ('cefdc9fe-4328-4a77-868d-db433f908628', 'b331de10-47a7-468f-98db-ad5c2d1a041f', 'c6872c35-2819-4dc3-9c98-95f7489fac25', '2026-01-25', '2026-02-22', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 70.5800018, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('ff4b1d5f-a87d-41b6-b122-0c65be7d13b8', 'c628d310-118f-4d17-83c4-1cfcc82954a9', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-25', '2026-02-22', '2026-01-26', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 71.6399994, 'Vine Trading Solutions', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany');
INSERT INTO orders VALUES ('cb07d712-4f3d-453e-a48e-75f1fe6801bb', '00c51812-32fe-4ea7-93cd-6ac81afcce12', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-01-26', '2026-02-23', '2026-02-02', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 46.6199989, 'Phoenix Trading Inc', '35 King George', 'London', NULL, 'WX3 6FW', 'UK');
INSERT INTO orders VALUES ('0962d8df-5769-479a-a666-683104d9af77', 'b331de10-47a7-468f-98db-ad5c2d1a041f', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-01-26', '2026-02-23', '2026-02-01', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 24.1200008, 'Teak Wholesale Co', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO orders VALUES ('9187aa4e-c774-4623-a842-ad475d1e138d', 'f7f06986-6907-4481-92af-bfc5511a56e7', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-26', '2026-02-23', '2026-02-05', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 8.34000015, 'Ultra Retail Systems', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO orders VALUES ('757ebada-92b9-4f48-a962-ede7ebc2ea74', '42a480f6-9c97-44c5-b327-9198e5e274e4', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-29', '2026-02-26', '2026-02-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 59.4099998, 'Nutmeg Trading Partners', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden');
INSERT INTO orders VALUES ('221b74b7-7bd5-48ed-9f08-e112b6c3c7dd', '3130b75e-08d7-4937-bfde-1974a03c950a', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-01-29', '2026-02-26', NULL, '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 2.78999996, 'Spruce Distribution Ltd', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France');
INSERT INTO orders VALUES ('c46b6453-27aa-4306-a146-3b63120cdb4b', 'ba92c59d-6f2e-44ce-87eb-e5506a1ca65c', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-29', '2026-02-26', '2026-02-02', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 67.2600021, 'Emerald Trading Group', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil');
INSERT INTO orders VALUES ('42b0c590-17ee-44fe-b877-317584dcd5ed', '95ddaae9-9c82-4259-b319-1a46588a652a', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-29', '2026-02-26', '2026-01-31', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 53.0499992, 'Pacific Trading House', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria');
INSERT INTO orders VALUES ('c33a3805-1396-4889-9d19-2280eb3792c0', '26240386-a6ca-4a18-910d-904cde61d93b', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-30', '2026-02-27', NULL, 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.330000013, 'Dawn Supply Ltd', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina');
INSERT INTO orders VALUES ('58b1b400-cc2c-4848-b38b-5ecb662ff4cc', '0ef4332c-6383-486b-a577-0156519db661', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-01-30', '2026-02-27', '2026-02-06', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 120.919998, 'Beacon Supply Co', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO orders VALUES ('6deb8e7a-b87d-4412-97db-9583b325b208', '00c51812-32fe-4ea7-93cd-6ac81afcce12', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-01-30', '2026-02-13', '2026-02-02', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 278.959991, 'Phoenix Trading Inc', '35 King George', 'London', NULL, 'WX3 6FW', 'UK');
INSERT INTO orders VALUES ('54ea6745-510b-469b-be88-23e6ee7ef3a7', '1e6dd3f8-3c44-4fac-9b97-016270116762', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-01-31', '2026-02-28', '2026-02-02', '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 4.13000011, 'Frost Supply Partners', 'South House 300 Queensbridge', 'London', NULL, 'SW7 1RZ', 'UK');
INSERT INTO orders VALUES ('ba743115-b7ba-4cec-9d0d-27d44a65aa5f', 'aaa1023c-07bb-4f15-8278-1f9c43d16275', 'bd734f3c-b888-489c-a098-4395f9565d97', '2026-01-31', '2026-02-28', NULL, '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 31.1399994, 'Atlas Trading Partners', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany');
INSERT INTO orders VALUES ('983c4f21-0e38-4cec-8588-ced56b83dccc', '08593d96-6aac-44cc-9aff-b5c963fc26db', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-01-31', '2026-03-14', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 85.8000031, 'Orion Distribution Partners', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO orders VALUES ('10a23bfe-4cf4-4cc6-a97f-11581a69e984', '05464425-fc77-4a44-9a69-5f6f6ec147b9', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-02-01', '2026-03-01', '2026-02-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 10.9799995, 'Crimson Distribution Co', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy');
INSERT INTO orders VALUES ('b921a2df-a5b8-49e4-8b0b-37483c44f0b7', 'db47b86c-f70d-48c0-8d2b-e1d98894bc00', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-02-01', '2026-03-15', NULL, '43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 14.0100002, 'Xavier Trading Partners', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA');
INSERT INTO orders VALUES ('4323968c-81f6-412e-b26a-76dde3622866', '19bdc17d-a448-4d35-9c8a-dd2b6ed83dc7', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-02-01', '2026-03-01', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 29.9300003, 'Imperial Foods Corp', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy');
INSERT INTO orders VALUES ('036ce6a5-cb40-4a7e-a9da-aabde1be7b6c', 'a21a6b01-37f1-4462-95f2-595326e090f6', 'c026b6c4-2083-4b52-bf06-c51e91346627', '2026-02-01', '2026-03-01', '2026-02-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 81.7300034, 'Yew Commerce Systems', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland');
INSERT INTO orders VALUES ('932b4a38-07d5-4c83-83e5-305ab89a2ac7', '20f34a05-8fca-4a71-be1b-c9188bad6df0', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-02-02', '2026-03-02', '2026-02-05', 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 30.0900002, 'Flora Trading House', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA');
INSERT INTO orders VALUES ('0d2654f5-abd2-4359-a3ff-956fa62a310d', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-02-02', '2026-03-02', NULL, 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 12.9099998, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('46db0fad-61cc-409c-9e0b-836c8f583912', '2d40745d-4d8c-4eb5-8dc3-5abdc2aebec4', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-02-02', '2026-03-02', '2026-02-05', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 44.7200012, 'Silver Commerce Ltd', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA');
INSERT INTO orders VALUES ('da415553-0d9d-431b-95fb-3757b734295b', '2a76dd54-c4c4-410f-bc6c-4d9f8a992e4d', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-02-05', '2026-02-19', '2026-02-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 7.98000002, 'Arbor Distribution Co', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany');
INSERT INTO orders VALUES ('8f664124-0390-471c-b6c3-6888e1e9ff24', 'd052d4e1-5069-4431-ba2f-4965bf158b31', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-02-05', '2026-03-05', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 81.75, 'Mosaic Supply Solutions', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO orders VALUES ('6b24be75-bc6b-4500-88bf-0caeb14c343c', 'af2ae79f-291f-425a-ad9a-81f7064ca7e5', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-02-05', '2026-03-05', '2026-02-07', '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 15.6700001, 'Lagoon Commerce Ltd', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('2f794433-00bc-4a98-9d89-f3f39f893eec', '79222616-f296-416f-a386-57a31c0d15d7', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-02-06', '2026-03-06', NULL, 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 136, 'Valor Distribution Co', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany');
INSERT INTO orders VALUES ('649936d1-b37a-4c63-a548-2debe1204e90', 'dee5c028-aa79-4d8c-b27c-043afa72bce1', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-02-06', '2026-03-06', NULL, 'd5fff7cf-7835-4e05-a264-85d24bc278ba', 0.930000007, 'Westwind Merchants', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO orders VALUES ('3f731380-d0a8-434e-bdd1-af71c74acc48', '1b7d3237-76cf-49fc-89a7-2e7668507cde', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-02-06', '2026-03-06', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 258.640015, 'Hawthorn Distribution Co', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria');
INSERT INTO orders VALUES ('abcdc083-37fa-485d-9d9c-3d8b2682908c', '078abbfd-fbac-4432-9528-c7a98ea5351c', 'b9f5fb6a-b20a-4759-8023-f59236f928df', '2026-02-06', '2026-03-06', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 24.9500008, 'Vector Trading House', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico');
INSERT INTO orders VALUES ('2a6185c3-a19e-4857-9c0a-d42b5e467595', 'f0d1b9c9-9e00-4a54-8276-07cced1288be', '8a6a251b-9821-4f4e-b8ab-abfd7d46b514', '2026-02-07', '2026-03-07', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 18.4400005, 'Maple Commerce Solutions', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark');
INSERT INTO orders VALUES ('3d8a4af9-9951-490b-92cd-1f0fefa72968', '2fc6d112-e8e0-40a2-851d-b21b5b07972f', 'a8eaa9a6-24c0-47b2-84e3-0c701ff76480', '2026-02-07', '2026-03-07', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 6.19000006, 'Rowan Trading House', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland');
INSERT INTO orders VALUES ('e758cac0-9fb2-493a-bd0d-5c245bea2111', '023f7e7e-1d2d-4fc2-a694-03c15fcda3dd', '24f6fcba-8f96-403a-b31d-1835b5ca16dc', '2026-02-07', '2026-03-07', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 38.2799988, 'Willow Supply Group', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France');
INSERT INTO orders VALUES ('195997e4-aef1-4025-8e8e-1f3307f8bed2', '2569e109-6d44-4f1a-8919-db63efb4ca9e', '825cc0d3-bb19-4f15-ac61-dcbcfe584c76', '2026-02-07', '2026-03-07', NULL, '2e4d27a0-a62f-4696-9b8d-6759b66bd459', 8.52999973, 'Echo Distribution Ltd', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO products VALUES ('959c44be-226b-4e4e-ae3d-b05bfedbb901', 'Mountain Granola', 'dc373a85-8a59-47be-9f5a-82532d492fcf', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '32 - 500 g boxes', 18, 39, 0, 10, true);
INSERT INTO products VALUES ('ca55b8fb-451f-406a-9f8f-0fb0bdc23def', 'Coastal Seafood Sausage', 'dff83f7a-8d83-4680-ba69-32045c8c9f71', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '20 - 1 kg tins', 19, 17, 40, 25, true);
INSERT INTO products VALUES ('928452a2-e16c-4abb-8cc0-de744f8a0baf', 'Coastal Herb Mix', 'dff83f7a-8d83-4680-ba69-32045c8c9f71', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '48 - 6 oz jars', 10, 13, 70, 25, false);
INSERT INTO products VALUES ('0c8aba5d-249a-4534-aef6-c7ef8a16d0ee', 'Valley Fruit Preserves', '96b8c0ad-3d82-48dc-ab80-cf45552123c1', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '12 - 8 oz jars', 22, 53, 0, 0, false);
INSERT INTO products VALUES ('6a1bbbce-8d7a-4070-b210-9a0e933bbbe0', 'Riverside Red Wine', '96b8c0ad-3d82-48dc-ab80-cf45552123c1', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '750 cc per bottle', 21.3500004, 0, 0, 0, true);
INSERT INTO products VALUES ('993e2043-6253-4bbb-b7a2-ccd2097d1ef1', 'Valley Fresh Butter', '74a4fcc5-6307-4bb7-8417-057ba9d08f03', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '10 - 500 g pkgs.', 25, 120, 0, 25, false);
INSERT INTO products VALUES ('b385eeb5-d3f1-44c2-9a20-cd9b247a8817', 'Coastal Gouda Wheel', '74a4fcc5-6307-4bb7-8417-057ba9d08f03', '308b9b98-9ff2-4fff-975e-e61770d75533', '15 - 300 g rounds', 30, 15, 0, 10, false);
INSERT INTO products VALUES ('77d07414-e1ec-4ad5-b196-3634c84ab2fb', 'Prairie Maple Syrup', '74a4fcc5-6307-4bb7-8417-057ba9d08f03', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '24 - 500 ml bottles', 40, 6, 0, 0, false);
INSERT INTO products VALUES ('af59c8a6-47cb-48a5-888b-b4f1f195656e', 'Pacific Coast Clams', 'b8bb9f57-5b9f-4966-9b69-dd9fac5b976e', '573a2320-b924-477b-8c65-55825aeaf906', '12 - 12 oz cans', 97, 29, 0, 0, true);
INSERT INTO products VALUES ('899d25a6-e84d-4abe-be8f-b00cbc3c1cb6', 'Valley Springs Mineral Water', 'b8bb9f57-5b9f-4966-9b69-dd9fac5b976e', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '12 - 75 cl bottles', 31, 31, 0, 0, false);
INSERT INTO products VALUES ('d78cfbef-a552-4f9f-94c0-dcff795d259c', 'Canyon Dried Fruits', '9cf2177c-4d95-4e4a-bcd6-dcd84a2c36b4', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '50 - 300 g pkgs.', 21, 22, 30, 30, false);
INSERT INTO products VALUES ('faa17edb-402d-402a-a859-af6b8321f8da', 'Highland Chocolate Bar', '9cf2177c-4d95-4e4a-bcd6-dcd84a2c36b4', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '12 - 100 g bars', 38, 86, 0, 0, false);
INSERT INTO products VALUES ('1b513001-91dd-4c4b-a64d-4e84520ee747', 'Valley Garden Tomatoes', '729d46c6-00c2-4791-9e0d-c07f2a2f88fa', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '50 - 300 g pkgs.', 6, 24, 0, 5, false);
INSERT INTO products VALUES ('38262c84-2325-4c54-a537-7fd358d8b35e', 'Harbor Toffee Bites', '729d46c6-00c2-4791-9e0d-c07f2a2f88fa', '308b9b98-9ff2-4fff-975e-e61770d75533', '100 - 250 g bags', 23.25, 35, 0, 0, false);
INSERT INTO products VALUES ('0684ad85-cbf4-4340-b11e-e3c9caf11ee1', 'Seaside Lobster Tail', '729d46c6-00c2-4791-9e0d-c07f2a2f88fa', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '24 pieces', 13, 39, 0, 5, false);
INSERT INTO products VALUES ('c5aed807-369f-422e-933d-8651810373ab', 'Sweet Valley Cookies', '4252d63c-acbb-4025-8d78-b85c19f3e10f', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '24 pkgs. x 4 pieces', 17.4500008, 29, 0, 10, false);
INSERT INTO products VALUES ('cbba97e4-d766-4c2d-87b4-9be5fb1b2a8e', 'Crystal Cottage Cheese', '4252d63c-acbb-4025-8d78-b85c19f3e10f', '573a2320-b924-477b-8c65-55825aeaf906', '500 g', 39, 0, 0, 0, true);
INSERT INTO products VALUES ('c10cb10f-732f-4e16-ad86-5c3903c7e1dc', 'Highland Lamb Chops', '4252d63c-acbb-4025-8d78-b85c19f3e10f', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '20 - 1 kg tins', 62.5, 42, 0, 0, false);
INSERT INTO products VALUES ('23e32477-99f5-4e2d-9797-345c0c1374cf', 'Glacier Yogurt', 'dc373a85-8a59-47be-9f5a-82532d492fcf', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '10 - 500 g pkgs.', 9.19999981, 25, 0, 5, false);
INSERT INTO products VALUES ('0e00f32f-a7e7-4c83-aaed-11698cbe995e', 'Prairie Oats Cereal', 'dc373a85-8a59-47be-9f5a-82532d492fcf', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '32 - 500 g boxes', 81, 40, 0, 0, false);
INSERT INTO products VALUES ('22b15424-92eb-4ac1-b839-141041a32d95', 'Coastal Rye Bread', 'dc373a85-8a59-47be-9f5a-82532d492fcf', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '12 - 250 g pkgs.', 10, 3, 40, 5, false);
INSERT INTO products VALUES ('053c43b4-24ed-4ab6-b8ce-2cd160d7deca', 'Harvest Moon Relish', 'f56c5244-2cbd-4a2f-a1fa-c260ae1e9472', '611cbaf4-b389-4bd1-ac3f-70377675588c', '12 - 12 oz jars', 21, 104, 0, 25, false);
INSERT INTO products VALUES ('24ee2d4f-e4fa-46d5-9ade-c9006901bba7', 'Harbor Seaside Prawns', 'f56c5244-2cbd-4a2f-a1fa-c260ae1e9472', '611cbaf4-b389-4bd1-ac3f-70377675588c', '18 - 500 g pkgs.', 9, 61, 0, 25, false);
INSERT INTO products VALUES ('f89701dd-38a8-41b6-9a6f-d568d82888b4', 'Horizon Berry Blend', '4ae3e54e-b6f6-4d35-b74f-c699cba44d72', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '24 - 12 oz bottles', 4.5, 20, 0, 0, true);
INSERT INTO products VALUES ('93efb435-8f64-4a72-92a3-a3e38bdb7c39', 'Prairie Mozzarella', '2e5d3a31-e2e2-4989-b775-4c05b0fad803', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '1 kg pkg.', 14, 76, 0, 30, false);
INSERT INTO products VALUES ('9a149867-007f-41b6-8e33-2484a53383ad', 'Woodland Feta Cheese', '2e5d3a31-e2e2-4989-b775-4c05b0fad803', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '12 - 100 g pkgs', 31.2299995, 15, 0, 0, false);
INSERT INTO products VALUES ('53ec8a33-13ea-40c2-8c40-8fd0fab772c3', 'Golden Grain Rice', '2e5d3a31-e2e2-4989-b775-4c05b0fad803', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '32 - 1 kg pkgs.', 43.9000015, 49, 0, 30, false);
INSERT INTO products VALUES ('6b78c3f4-b2cd-48fe-bc39-8cc54a1b4827', 'Golden Grain Biscuits', '152a2b8f-c4bf-42bf-b065-16b38d97ec53', '308b9b98-9ff2-4fff-975e-e61770d75533', '24 pkgs. x 4 pieces', 45.5999985, 26, 0, 0, true);
INSERT INTO products VALUES ('982f3425-a1a3-4dec-89d7-7787f4f82feb', 'Canyon Ridge Beer', '152a2b8f-c4bf-42bf-b065-16b38d97ec53', '573a2320-b924-477b-8c65-55825aeaf906', '24 - 0.5 l bottles', 123.790001, 0, 0, 0, true);
INSERT INTO products VALUES ('6cb25a55-c162-4d91-859b-6c7f5f966462', 'Prairie Dawn Wine', '03c0d8d4-6c4b-450f-897a-e74972a87908', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '750 cc per bottle', 25.8899994, 10, 0, 15, false);
INSERT INTO products VALUES ('23360db3-5576-443b-bd45-5c5e04ef26a2', 'Mountain Leafy Greens', 'c81d79d9-f075-4065-98ed-f4db8fdd539b', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '40 - 100 g pkgs.', 12.5, 0, 70, 20, false);
INSERT INTO products VALUES ('557b229c-18fe-43e9-a440-ff4260ee4d86', 'Garden Valley Ketchup', 'c81d79d9-f075-4065-98ed-f4db8fdd539b', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '24 - 250 ml bottles', 32, 9, 40, 25, false);
INSERT INTO products VALUES ('d2394847-8829-4bec-b968-170c8429022f', 'Sunset Orange Juice', 'a2745b54-7f5a-410e-b112-e7fb0c9f2b4d', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '24 - 12 oz bottles', 2.5, 112, 0, 20, false);
INSERT INTO products VALUES ('7cb88561-c27a-4d7b-a741-9f7115dbef98', 'Highland Potatoes', '951c5e9d-1b55-45a3-ad71-5e7e712e14bb', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '50 - 300 g pkgs.', 14, 111, 0, 15, false);
INSERT INTO products VALUES ('61f41763-1ece-4378-810f-0a866a077be5', 'Canyon Ranch Bacon', '951c5e9d-1b55-45a3-ad71-5e7e712e14bb', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '50 bags x 30 sausgs.', 18, 20, 0, 15, false);
INSERT INTO products VALUES ('4c94f7a9-b6ab-4a7e-ba74-78fa66346637', 'Crystal Creek Lemonade', 'ad568bc2-a56e-4ea3-8c77-aeb73303f192', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '24 - 12 oz bottles', 19, 112, 0, 20, false);
INSERT INTO products VALUES ('8ad0f836-43df-42d9-a992-e1fee45d28d8', 'Summit Peak Berries', 'ad568bc2-a56e-4ea3-8c77-aeb73303f192', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '12 - 1 lb pkgs.', 26, 11, 50, 25, false);
INSERT INTO products VALUES ('8dd33d50-ced4-41d9-aa09-85e0671d4528', 'Glacier Bay Shrimp', '78a91bcf-b34e-4e2e-8baf-11b8b96fd004', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '24 - 4 oz tins', 263.5, 17, 0, 15, false);
INSERT INTO products VALUES ('2e2b9b8f-0ba1-48a9-b0d2-eb77ffa87bdf', 'Meadow Grain Crackers', '78a91bcf-b34e-4e2e-8baf-11b8b96fd004', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '12 - 250 g pkgs.', 18, 69, 0, 5, false);
INSERT INTO products VALUES ('c0d0cb3e-100e-4aab-86a4-83c9e2c6646d', 'Alpine Spring Water', '2a540074-07f3-429c-a530-95a2514c1bd9', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '24 - 0.5 l bottles', 18.3999996, 123, 0, 30, false);
INSERT INTO products VALUES ('e0591e8d-41e4-4649-8af3-56871fadedcf', 'Prairie Premium Beef', '2a540074-07f3-429c-a530-95a2514c1bd9', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '16 kg pkg.', 9.64999962, 85, 0, 10, false);
INSERT INTO products VALUES ('fd2cc1b6-21b6-4426-9958-c5d3ee2430fd', 'Crystal Clear Cucumbers', '975c2d0b-4a44-46d3-a5b6-4f0b26512812', '611cbaf4-b389-4bd1-ac3f-70377675588c', '40 - 100 g pkgs.', 14, 26, 0, 0, true);
INSERT INTO products VALUES ('1fd3d013-ea69-40a6-b0d7-4dd071239719', 'Deep Sea Oysters', '975c2d0b-4a44-46d3-a5b6-4f0b26512812', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '24 - 4 oz tins', 46, 17, 10, 25, false);
INSERT INTO products VALUES ('493f4894-c1cd-4285-9a14-219180421e20', 'Summit Swiss Cheese', '975c2d0b-4a44-46d3-a5b6-4f0b26512812', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '10 - 500 g pkgs.', 19.4500008, 27, 0, 15, false);
INSERT INTO products VALUES ('f816c3fe-56be-43be-8167-8f42cb5f368b', 'Coastal Catch Tuna', 'cbbc150e-a957-4ad1-8ffc-27dbd1dd9bf8', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '16 kg pkg.', 9.5, 5, 70, 15, false);
INSERT INTO products VALUES ('94612826-6a21-49d7-9ec3-c9d7f6cfab69', 'Sunrise Mustard', 'cbbc150e-a957-4ad1-8ffc-27dbd1dd9bf8', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '48 - 6 oz jars', 12, 95, 0, 0, false);
INSERT INTO products VALUES ('a97e25cd-008d-43c9-9442-9b64d29bf354', 'Highland Barley Flakes', '5d515cae-704d-4485-b062-804cf7d45501', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '36 boxes', 9.5, 36, 0, 0, false);
INSERT INTO products VALUES ('d81d4aa0-e0af-41eb-9ba1-42e8ee9559ef', 'Valley Herb Seasoning', '5d515cae-704d-4485-b062-804cf7d45501', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '36 boxes', 12.75, 15, 70, 25, false);
INSERT INTO products VALUES ('ff7eb458-3fc9-4ab4-a845-f8a4214b22ae', 'Mountain Range Pork', 'c7115f2f-0eac-4203-a954-ac11ff0a9fae', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '20 - 1 kg tins', 20, 10, 60, 15, false);
INSERT INTO products VALUES ('ebf47b27-c8f8-4f9e-bfb2-2e99c1fcf105', 'Riverside Deli Meat', 'c7115f2f-0eac-4203-a954-ac11ff0a9fae', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '18 - 500 g pkgs.', 16.25, 65, 0, 30, false);
INSERT INTO products VALUES ('6c7dddbc-95e8-4435-b2b2-7a49fed3b32e', 'Riverside Corn Flour', '2ff6bf74-05bd-4d22-b4e5-fde8ae112e20', '308b9b98-9ff2-4fff-975e-e61770d75533', '20 - 2 kg bags', 53, 20, 0, 10, false);
INSERT INTO products VALUES ('45638c62-8eea-4e9f-b4ac-ff20f44afac2', 'Sunset Caramel Treats', '2ff6bf74-05bd-4d22-b4e5-fde8ae112e20', '611cbaf4-b389-4bd1-ac3f-70377675588c', '10 - 4 oz boxes', 7, 38, 0, 25, false);
INSERT INTO products VALUES ('92009acc-e997-414f-a982-9f2fb872c9a6', 'Summit Peak Energy Drink', '2ff6bf74-05bd-4d22-b4e5-fde8ae112e20', '573a2320-b924-477b-8c65-55825aeaf906', '24 - 12 oz bottles', 32.7999992, 0, 0, 0, true);
INSERT INTO products VALUES ('e299b717-99b4-4452-8214-f603abc3c12c', 'Harbor Bay Cola', '0833fed6-306c-49f2-a9e2-bbd9100c3a5c', '573a2320-b924-477b-8c65-55825aeaf906', '12 - 355 ml cans', 7.44999981, 21, 0, 10, false);
INSERT INTO products VALUES ('a0e770f7-abac-4161-a3b2-f5cb0bad14cf', 'Glacier Bay Ham', '0833fed6-306c-49f2-a9e2-bbd9100c3a5c', '573a2320-b924-477b-8c65-55825aeaf906', '18 - 500 g pkgs.', 24, 115, 0, 20, false);
INSERT INTO products VALUES ('59126ec1-07d2-4eb8-a286-9982783e117b', 'Meadow Honey Candy', 'ba96d739-92ae-411e-8347-c6d16e4ba17c', '611cbaf4-b389-4bd1-ac3f-70377675588c', '100 - 250 g bags', 38, 21, 10, 30, false);
INSERT INTO products VALUES ('e7816c33-bb0c-4afe-8bee-5ed2c0ecf879', 'Skyline White Wine', 'ba96d739-92ae-411e-8347-c6d16e4ba17c', '611cbaf4-b389-4bd1-ac3f-70377675588c', '12 - 75 cl bottles', 19.5, 36, 0, 20, false);
INSERT INTO products VALUES ('5e39ffd5-b5f5-46a8-b663-e3ff1fac65f9', 'Riverside Sour Cream', 'd14d39dc-6f4c-4a2b-8be7-d277d1333351', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '24 - 200 g pkgs.', 13.25, 62, 0, 20, false);
INSERT INTO products VALUES ('8b1a1857-e9d7-482f-bba1-b5a4ee24d5ef', 'Highland Cream Cheese', 'bcce726f-9bee-46c9-b38c-80fb79a6551f', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '5 kg pkg.', 55, 79, 0, 0, false);
INSERT INTO products VALUES ('9caf4420-97b1-4e71-baa3-f7cb9040bae3', 'Crystal Waters Caviar', 'bcce726f-9bee-46c9-b38c-80fb79a6551f', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '12 - 200 ml jars', 34, 19, 0, 0, false);
INSERT INTO products VALUES ('fb45c8e6-03d3-472d-970a-8b3b65560742', 'Mountain Mist Tea', '36b474d6-c3ab-4614-a220-17ded9a47605', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '10 boxes x 30 bags', 28.5, 113, 0, 25, false);
INSERT INTO products VALUES ('b290b474-1fe1-43db-b4c5-9cbb871989e2', 'Ocean Mist Marinade', '36b474d6-c3ab-4614-a220-17ded9a47605', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '12 - 550 ml bottles', 49.2999992, 17, 0, 0, false);
INSERT INTO products VALUES ('6b840857-464e-4c75-b887-ee21d918ee05', 'Valley Whole Grain Bread', '4252d63c-acbb-4025-8d78-b85c19f3e10f', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '24 - 500 g pkgs.', 43.9000015, 24, 0, 5, false);
INSERT INTO products VALUES ('a5924475-b665-46aa-97ee-b268fda8740e', 'Coastal Breeze Soda', '152a2b8f-c4bf-42bf-b065-16b38d97ec53', '611cbaf4-b389-4bd1-ac3f-70377675588c', '24 - 355 ml bottles', 33.25, 22, 80, 30, false);
INSERT INTO products VALUES ('0b2e3170-f274-4be0-af86-babaae306d97', 'Woodland Garlic Paste', '96b8c0ad-3d82-48dc-ab80-cf45552123c1', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '12 - 550 ml bottles', 21.0499992, 76, 0, 0, false);
INSERT INTO products VALUES ('309dcfa3-7eea-4a14-9795-f8693838c3bd', 'Meadow Organic Carrots', '96b8c0ad-3d82-48dc-ab80-cf45552123c1', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '40 - 100 g pkgs.', 17, 4, 100, 20, false);
INSERT INTO products VALUES ('74fcbd5d-f86e-4359-91d6-5310cf01e96a', 'Mountain Spice Blend', '951c5e9d-1b55-45a3-ad71-5e7e712e14bb', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '20 - 2 kg bags', 14, 52, 0, 10, false);
INSERT INTO products VALUES ('dae61ec1-ae1c-42f7-b55a-fe28b6af066a', 'Ocean Harvest Salmon', 'dc373a85-8a59-47be-9f5a-82532d492fcf', '27c8a25b-ab1b-47a4-afd3-f2158e424ad9', '12 - 200 ml jars', 12.5, 6, 10, 15, false);
INSERT INTO products VALUES ('d0f608d2-28bb-4c14-8864-d8f686547a5f', 'Summit Turkey Breast', 'a2745b54-7f5a-410e-b112-e7fb0c9f2b4d', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '18 - 500 g pkgs.', 36, 26, 0, 15, false);
INSERT INTO products VALUES ('358bbcbf-d1d7-4f5f-87f7-8f8e91bbda37', 'Bay Breeze Anchovies', '4252d63c-acbb-4025-8d78-b85c19f3e10f', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '4 - 450 g glasses', 15, 15, 10, 30, false);
INSERT INTO products VALUES ('1437bd3c-b711-4327-86e1-e8300e84386d', 'Canyon Trail Mix', 'a2745b54-7f5a-410e-b112-e7fb0c9f2b4d', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '20 - 2 kg bags', 21.5, 26, 0, 0, false);
INSERT INTO products VALUES ('fd427235-b9ec-47b4-a1f8-0da5245e261f', 'Meadow Blue Cheese', 'c81d79d9-f075-4065-98ed-f4db8fdd539b', 'd4abd129-8b40-4595-a8ff-3fa4b04d566c', '1 kg pkg.', 34.7999992, 14, 0, 0, false);
INSERT INTO products VALUES ('acc0ebee-1777-4f60-a1c6-86f96070698e', 'Coastal Citrus Fruits', 'ad568bc2-a56e-4ea3-8c77-aeb73303f192', 'dabe8426-04f2-4b8c-85d4-e6289ee880e6', '50 - 300 g pkgs.', 15, 101, 0, 5, false);
INSERT INTO products VALUES ('35757ead-53a9-44f2-a023-f8950dd9eeac', 'Meadow Fresh Milk', 'b8bb9f57-5b9f-4966-9b69-dd9fac5b976e', '308b9b98-9ff2-4fff-975e-e61770d75533', '24 - 12 oz bottles', 10, 4, 20, 5, false);
INSERT INTO products VALUES ('f017f084-17f7-4c97-bf8a-d9e0d2fba577', 'Summit Sea Scallops', '152a2b8f-c4bf-42bf-b065-16b38d97ec53', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '24 - 4 oz tins', 7.75, 125, 0, 25, false);
INSERT INTO products VALUES ('882e7e68-088a-4004-ac67-4eb7e5c5d860', 'Prairie Pepper Sauce', 'c7115f2f-0eac-4203-a954-ac11ff0a9fae', '6f0b1f26-053e-4ee7-a402-3e6bdbd09a15', '24 - 8 oz jars', 18, 57, 0, 20, false);
INSERT INTO products VALUES ('c8ce1699-c162-4649-aa00-4ab58ac21822', 'Harbor Bay Crab', '152a2b8f-c4bf-42bf-b065-16b38d97ec53', '35a9d0ed-3417-4b37-948f-43df3219c5c8', '24 - 4 oz tins', 13, 32, 0, 15, false);


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO region VALUES ('2915dee2-e88e-483e-8f7a-68f82abaccd4', 'Eastern');
INSERT INTO region VALUES ('0f7959ce-65ca-46dc-b55b-a9ed3337ed7d', 'Western');
INSERT INTO region VALUES ('0b84f680-e420-4618-82b4-65a5cfc008d9', 'Northern');
INSERT INTO region VALUES ('201d76b7-f675-4ed1-8b1a-67a27e3d151a', 'Southern');


--
-- Data for Name: shippers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO shippers VALUES ('d5fff7cf-7835-4e05-a264-85d24bc278ba', 'Speedy Express', '(503) 555-9831');
INSERT INTO shippers VALUES ('2e4d27a0-a62f-4696-9b8d-6759b66bd459', 'United Package', '(503) 555-3199');
INSERT INTO shippers VALUES ('43a5ca0f-228e-4b21-bfe1-5ac6b8188a7e', 'Federal Shipping', '(503) 555-9931');
INSERT INTO shippers VALUES ('3939fbf5-8dbf-4664-82cb-6c34dbce1055', 'Alliance Shippers', '1-800-222-0451');
INSERT INTO shippers VALUES ('2ad7efe7-86e9-4259-a8ae-2522932fca51', 'UPS', '1-800-782-7892');
INSERT INTO shippers VALUES ('05a6810f-943a-4615-ae65-ac3083516c86', 'DHL', '1-800-225-5345');



--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO suppliers VALUES ('dff83f7a-8d83-4680-ba69-32045c8c9f71', 'Exotic Liquids', 'Charlotte Cooper', 'Purchasing Manager', '49 Gilbert St.', 'London', NULL, 'EC1 4SD', 'UK', '(171) 555-2222', NULL, NULL);
INSERT INTO suppliers VALUES ('96b8c0ad-3d82-48dc-ab80-cf45552123c1', 'New Orleans Cajun Delights', 'Shelley Burke', 'Order Administrator', 'P.O. Box 78934', 'New Orleans', 'LA', '70117', 'USA', '(100) 555-4822', NULL, '#CAJUN.HTM#');
INSERT INTO suppliers VALUES ('74a4fcc5-6307-4bb7-8417-057ba9d08f03', 'Grandma Kelly''s Homestead', 'Regina Murphy', 'Sales Representative', '707 Oxford Rd.', 'Ann Arbor', 'MI', '48104', 'USA', '(313) 555-5735', '(313) 555-3349', NULL);
INSERT INTO suppliers VALUES ('b8bb9f57-5b9f-4966-9b69-dd9fac5b976e', 'Tokyo Traders', 'Yoshi Nagase', 'Marketing Manager', '9-8 Sekimai Musashino-shi', 'Tokyo', NULL, '100', 'Japan', '(03) 3555-5011', NULL, NULL);
INSERT INTO suppliers VALUES ('9cf2177c-4d95-4e4a-bcd6-dcd84a2c36b4', 'Cooperativa de Quesos ''Las Cabras''', 'Antonio del Valle Saavedra', 'Export Administrator', 'Calle del Rosal 4', 'Oviedo', 'Asturias', '33007', 'Spain', '(98) 598 76 54', NULL, NULL);
INSERT INTO suppliers VALUES ('729d46c6-00c2-4791-9e0d-c07f2a2f88fa', 'Mayumi''s', 'Mayumi Ohno', 'Marketing Representative', '92 Setsuko Chuo-ku', 'Osaka', NULL, '545', 'Japan', '(06) 431-7877', NULL, 'Mayumi''s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#');
INSERT INTO suppliers VALUES ('4252d63c-acbb-4025-8d78-b85c19f3e10f', 'Pavlova, Ltd.', 'Ian Devling', 'Marketing Manager', '74 Rose St. Moonie Ponds', 'Melbourne', 'Victoria', '3058', 'Australia', '(03) 444-2343', '(03) 444-6588', NULL);
INSERT INTO suppliers VALUES ('dc373a85-8a59-47be-9f5a-82532d492fcf', 'Specialty Biscuits, Ltd.', 'Peter Wilson', 'Sales Representative', '29 King''s Way', 'Manchester', NULL, 'M14 GSD', 'UK', '(161) 555-4448', NULL, NULL);
INSERT INTO suppliers VALUES ('f56c5244-2cbd-4a2f-a1fa-c260ae1e9472', 'PB Knäckebröd AB', 'Lars Peterson', 'Sales Agent', 'Kaloadagatan 13', 'Göteborg', NULL, 'S-345 67', 'Sweden', '031-987 65 43', '031-987 65 91', NULL);
INSERT INTO suppliers VALUES ('4ae3e54e-b6f6-4d35-b74f-c699cba44d72', 'Refrescos Americanas LTDA', 'Carlos Diaz', 'Marketing Manager', 'Av. das Americanas 12.890', 'Sao Paulo', NULL, '5442', 'Brazil', '(11) 555 4640', NULL, NULL);
INSERT INTO suppliers VALUES ('2e5d3a31-e2e2-4989-b775-4c05b0fad803', 'Heli Süßwaren GmbH & Co. KG', 'Petra Winkler', 'Sales Manager', 'Tiergartenstraße 5', 'Berlin', NULL, '10785', 'Germany', '(010) 9984510', NULL, NULL);
INSERT INTO suppliers VALUES ('152a2b8f-c4bf-42bf-b065-16b38d97ec53', 'Plutzer Lebensmittelgroßmärkte AG', 'Martin Bein', 'International Marketing Mgr.', 'Bogenallee 51', 'Frankfurt', NULL, '60439', 'Germany', '(069) 992755', NULL, 'Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#');
INSERT INTO suppliers VALUES ('03c0d8d4-6c4b-450f-897a-e74972a87908', 'Nord-Ost-Fisch Handelsgesellschaft mbH', 'Sven Petersen', 'Coordinator Foreign Markets', 'Frahmredder 112a', 'Cuxhaven', NULL, '27478', 'Germany', '(04721) 8713', '(04721) 8714', NULL);
INSERT INTO suppliers VALUES ('c81d79d9-f075-4065-98ed-f4db8fdd539b', 'Formaggi Fortini s.r.l.', 'Elio Rossi', 'Sales Representative', 'Viale Dante, 75', 'Ravenna', NULL, '48100', 'Italy', '(0544) 60323', '(0544) 60603', '#FORMAGGI.HTM#');
INSERT INTO suppliers VALUES ('a2745b54-7f5a-410e-b112-e7fb0c9f2b4d', 'Norske Meierier', 'Beate Vileid', 'Marketing Manager', 'Hatlevegen 5', 'Sandvika', NULL, '1320', 'Norway', '(0)2-953010', NULL, NULL);
INSERT INTO suppliers VALUES ('951c5e9d-1b55-45a3-ad71-5e7e712e14bb', 'Bigfoot Breweries', 'Cheryl Saylor', 'Regional Account Rep.', '3400 - 8th Avenue Suite 210', 'Bend', 'OR', '97101', 'USA', '(503) 555-9931', NULL, NULL);
INSERT INTO suppliers VALUES ('ad568bc2-a56e-4ea3-8c77-aeb73303f192', 'Svensk Sjöföda AB', 'Michael Björn', 'Sales Representative', 'Brovallavägen 231', 'Stockholm', NULL, 'S-123 45', 'Sweden', '08-123 45 67', NULL, NULL);
INSERT INTO suppliers VALUES ('78a91bcf-b34e-4e2e-8baf-11b8b96fd004', 'Aux joyeux ecclésiastiques', 'Guylène Nodier', 'Sales Manager', '203, Rue des Francs-Bourgeois', 'Paris', NULL, '75004', 'France', '(1) 03.83.00.68', '(1) 03.83.00.62', NULL);
INSERT INTO suppliers VALUES ('2a540074-07f3-429c-a530-95a2514c1bd9', 'New England Seafood Cannery', 'Robb Merchant', 'Wholesale Account Agent', 'Order Processing Dept. 2100 Paul Revere Blvd.', 'Boston', 'MA', '02134', 'USA', '(617) 555-3267', '(617) 555-3389', NULL);
INSERT INTO suppliers VALUES ('975c2d0b-4a44-46d3-a5b6-4f0b26512812', 'Leka Trading', 'Chandra Leka', 'Owner', '471 Serangoon Loop, Suite #402', 'Singapore', NULL, '0512', 'Singapore', '555-8787', NULL, NULL);
INSERT INTO suppliers VALUES ('cbbc150e-a957-4ad1-8ffc-27dbd1dd9bf8', 'Lyngbysild', 'Niels Petersen', 'Sales Manager', 'Lyngbysild Fiskebakken 10', 'Lyngby', NULL, '2800', 'Denmark', '43844108', '43844115', NULL);
INSERT INTO suppliers VALUES ('5d515cae-704d-4485-b062-804cf7d45501', 'Zaanse Snoepfabriek', 'Dirk Luchte', 'Accounting Manager', 'Verkoop Rijnweg 22', 'Zaandam', NULL, '9999 ZZ', 'Netherlands', '(12345) 1212', '(12345) 1210', NULL);
INSERT INTO suppliers VALUES ('c7115f2f-0eac-4203-a954-ac11ff0a9fae', 'Karkki Oy', 'Anne Heikkonen', 'Product Manager', 'Valtakatu 12', 'Lappeenranta', NULL, '53120', 'Finland', '(953) 10956', NULL, NULL);
INSERT INTO suppliers VALUES ('2ff6bf74-05bd-4d22-b4e5-fde8ae112e20', 'G''day, Mate', 'Wendy Mackenzie', 'Sales Representative', '170 Prince Edward Parade Hunter''s Hill', 'Sydney', 'NSW', '2042', 'Australia', '(02) 555-5914', '(02) 555-4873', 'G''day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#');
INSERT INTO suppliers VALUES ('0833fed6-306c-49f2-a9e2-bbd9100c3a5c', 'Ma Maison', 'Jean-Guy Lauzon', 'Marketing Manager', '2960 Rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada', '(514) 555-9022', NULL, NULL);
INSERT INTO suppliers VALUES ('ba96d739-92ae-411e-8347-c6d16e4ba17c', 'Pasta Buttini s.r.l.', 'Giovanni Giudici', 'Order Administrator', 'Via dei Gelsomini, 153', 'Salerno', NULL, '84100', 'Italy', '(089) 6547665', '(089) 6547667', NULL);
INSERT INTO suppliers VALUES ('d14d39dc-6f4c-4a2b-8be7-d277d1333351', 'Escargots Nouveaux', 'Marie Delamare', 'Sales Manager', '22, rue H. Voiron', 'Montceau', NULL, '71300', 'France', '85.57.00.07', NULL, NULL);
INSERT INTO suppliers VALUES ('bcce726f-9bee-46c9-b38c-80fb79a6551f', 'Gai pâturage', 'Eliane Noz', 'Sales Representative', 'Bat. B 3, rue des Alpes', 'Annecy', NULL, '74000', 'France', '38.76.98.06', '38.76.98.58', NULL);
INSERT INTO suppliers VALUES ('36b474d6-c3ab-4614-a220-17ded9a47605', 'Forêts d''érables', 'Chantal Goulet', 'Accounting Manager', '148 rue Chasseur', 'Ste-Hyacinthe', 'Québec', 'J2S 7S8', 'Canada', '(514) 555-2955', '(514) 555-2921', NULL);


--
-- Data for Name: territories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO territories VALUES ('1814d03a-afa9-4529-9eef-887ea9439233', 'Westboro', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('69041f5f-6f18-460f-8f8b-d390bca2606d', 'Bedford', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('3f4e2289-0b80-4281-bf91-346750bffd31', 'Georgetow', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('0bd1b02a-2203-4ade-83f8-6d13208cf145', 'Boston', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('c00d5757-90e3-4543-a216-4d06463a6a2c', 'Cambridge', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('53451b36-7fd1-45eb-a449-3d39501b9e19', 'Braintree', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('865db6b0-c58b-40b7-afe3-f908fc0de5ea', 'Providence', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('389a9a10-5f51-4255-b5cb-e0ed03b80356', 'Hollis', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('19436eac-b83a-4c50-90a1-1d87cfa0de22', 'Portsmouth', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('bbd4abea-6e83-4b55-a6d5-a66c172530dc', 'Wilton', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('cbebd163-da08-4159-bee0-435c3995b95d', 'Morristown', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('3cb6cf7c-d7d0-49e0-a75a-810e17a47650', 'Edison', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('6e2d65af-302b-4b55-8fe9-1d7d3695e36b', 'New York', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('10579c0a-6e5f-49ee-aa27-eb3fb465dccd', 'New York', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('61e1d7e7-6c5c-495f-ba05-e8ae8c115efd', 'Mellvile', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('98ffe550-91e5-4a50-a829-b22e03a0a71c', 'Fairport', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('d54adbce-e295-4bbc-9a48-ac9650e4df3a', 'Philadelphia', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('9283f0d9-ab2e-4c15-81c1-3d6a9a554a6c', 'Neward', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('e8ea23e4-be6e-4fdd-9920-50180caa87c8', 'Rockville', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('9a7ffaaa-04e3-485e-9748-1209a8814e68', 'Greensboro', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('59343735-23f9-476f-b4ae-7d33cd96ac48', 'Cary', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('e0be9089-f0a3-464d-8fe3-0816b1d95de3', 'Columbia', '201d76b7-f675-4ed1-8b1a-67a27e3d151a');
INSERT INTO territories VALUES ('11c2b222-5a4a-441b-ac0a-975eb288fb04', 'Atlanta', '201d76b7-f675-4ed1-8b1a-67a27e3d151a');
INSERT INTO territories VALUES ('b42ebb0d-5413-47e5-bf21-d334c51ff111', 'Savannah', '201d76b7-f675-4ed1-8b1a-67a27e3d151a');
INSERT INTO territories VALUES ('bfb34165-e4c9-485e-ac64-16f2c1fb5cca', 'Orlando', '201d76b7-f675-4ed1-8b1a-67a27e3d151a');
INSERT INTO territories VALUES ('ee317c38-b9f5-41f9-9b0f-d91370c61900', 'Tampa', '201d76b7-f675-4ed1-8b1a-67a27e3d151a');
INSERT INTO territories VALUES ('e2898cd2-dd18-4d96-8b10-fdd0788aa66d', 'Louisville', '2915dee2-e88e-483e-8f7a-68f82abaccd4');
INSERT INTO territories VALUES ('ac780f30-c0e3-409c-8874-6b9e6da13d8d', 'Beachwood', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('82dfffbd-34ed-4e9a-830d-bdd4ceacfff6', 'Findlay', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('df4e761b-b908-4343-8542-b531ac6d74fa', 'Southfield', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('6936328e-3e95-4c65-8575-1c71875123bf', 'Troy', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('c5bb490d-a894-4169-b277-1c5c75861e7e', 'Bloomfield Hills', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('d854d549-1423-4d76-9aa7-60f9c2b6d675', 'Racine', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('e334b581-c942-44ce-b2e6-56408e57a21c', 'Roseville', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('6167fb2e-c146-4b42-a69d-7a2d449c1672', 'Minneapolis', '0b84f680-e420-4618-82b4-65a5cfc008d9');
INSERT INTO territories VALUES ('bc6942b8-1f18-4f04-8a69-0520ccda0095', 'Hoffman Estates', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('1395c8fa-39d7-49dd-9d40-28e2e087dbb7', 'Chicago', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('a0c6f36f-ab0f-4320-8039-e4a4b1b4a8e1', 'Bentonville', '201d76b7-f675-4ed1-8b1a-67a27e3d151a');
INSERT INTO territories VALUES ('9ec15d55-bdfc-47f5-ba99-269cb45859fa', 'Dallas', '201d76b7-f675-4ed1-8b1a-67a27e3d151a');
INSERT INTO territories VALUES ('ffebdc38-e565-4e9a-a41b-9712f60cfa38', 'Austin', '201d76b7-f675-4ed1-8b1a-67a27e3d151a');
INSERT INTO territories VALUES ('39ff0377-40ae-4a83-a06b-a1ca0f96575e', 'Denver', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('ef3be036-77db-47e9-bd48-16cae9a06d44', 'Colorado Springs', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('aad179cf-1f85-4223-9c42-b36951615999', 'Phoenix', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('6cf833b6-02d5-4015-8a6a-4d3125da802b', 'Scottsdale', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('93aeba80-903d-489a-abe3-174242c4e1f5', 'Santa Monica', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('479c3d42-e4e5-49e5-ae22-9ccc67c5b31d', 'Menlo Park', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('633b3fbe-793c-4a52-b53a-8944fa38a17d', 'San Francisco', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('1eaee084-741b-461d-86d1-2744df3d7c5c', 'Campbell', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('b4d54544-d024-4a75-852d-5b09f1e5d402', 'Santa Clara', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('2eebcd57-b7c8-469a-bb2c-7a43d3d29190', 'Santa Cruz', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('9a0b5e91-0467-419e-814d-ca3300aab25d', 'Bellevue', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('e4315f01-225a-45b1-bb0f-4b6cced1888e', 'Redmond', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');
INSERT INTO territories VALUES ('cea22556-9e86-4dd5-b86c-6ea9dca45bfc', 'Seattle', '0f7959ce-65ca-46dc-b55b-a9ed3337ed7d');


--
-- Name: pk_categories; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT pk_categories PRIMARY KEY (category_id);


--
-- Name: pk_customers; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);


--
-- Name: pk_employees; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT pk_employees PRIMARY KEY (employee_id);


--
-- Name: pk_employee_territories; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY employee_territories
    ADD CONSTRAINT pk_employee_territories PRIMARY KEY (employee_id, territory_id);


--
-- Name: pk_order_details; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY order_details
    ADD CONSTRAINT pk_order_details PRIMARY KEY (order_id, product_id);


--
-- Name: pk_orders; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);


--
-- Name: pk_products; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT pk_products PRIMARY KEY (product_id);


--
-- Name: pk_region; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT pk_region PRIMARY KEY (region_id);


--
-- Name: pk_shippers; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY shippers
    ADD CONSTRAINT pk_shippers PRIMARY KEY (shipper_id);


--
-- Name: pk_suppliers; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY suppliers
    ADD CONSTRAINT pk_suppliers PRIMARY KEY (supplier_id);


--
-- Name: pk_territories; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY territories
    ADD CONSTRAINT pk_territories PRIMARY KEY (territory_id);



--
-- Name: fk_orders_customers; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers;


--
-- Name: fk_orders_employees; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_orders_employees FOREIGN KEY (employee_id) REFERENCES employees;


--
-- Name: fk_orders_shippers; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_orders_shippers FOREIGN KEY (ship_via) REFERENCES shippers;


--
-- Name: fk_order_details_products; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY order_details
    ADD CONSTRAINT fk_order_details_products FOREIGN KEY (product_id) REFERENCES products;


--
-- Name: fk_order_details_orders; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY order_details
    ADD CONSTRAINT fk_order_details_orders FOREIGN KEY (order_id) REFERENCES orders;


--
-- Name: fk_products_categories; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY products
    ADD CONSTRAINT fk_products_categories FOREIGN KEY (category_id) REFERENCES categories;


--
-- Name: fk_products_suppliers; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY products
    ADD CONSTRAINT fk_products_suppliers FOREIGN KEY (supplier_id) REFERENCES suppliers;


--
-- Name: fk_territories_region; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY territories
    ADD CONSTRAINT fk_territories_region FOREIGN KEY (region_id) REFERENCES region;


--
-- Name: fk_employee_territories_territories; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY employee_territories
    ADD CONSTRAINT fk_employee_territories_territories FOREIGN KEY (territory_id) REFERENCES territories;


--
-- Name: fk_employee_territories_employees; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY employee_territories
    ADD CONSTRAINT fk_employee_territories_employees FOREIGN KEY (employee_id) REFERENCES employees;


--
-- Name: fk_employees_employees; Type: Constraint; Schema: -; Owner: -
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT fk_employees_employees FOREIGN KEY (reports_to) REFERENCES employees;

    
--
-- PostgreSQL database dump complete
--