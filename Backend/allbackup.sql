BEGIN;

-- Удаление существующих таблиц
DROP TABLE IF EXISTS "orderemployee" CASCADE;
DROP TABLE IF EXISTS "employee" CASCADE;
DROP TABLE IF EXISTS "carservice" CASCADE;
DROP TABLE IF EXISTS "service" CASCADE;
DROP TABLE IF EXISTS "sto" CASCADE;
DROP TABLE IF EXISTS "saved_queries" CASCADE;
DROP TABLE IF EXISTS "new_table" CASCADE;
DROP TABLE IF EXISTS "test" CASCADE;
DROP TABLE IF EXISTS "ordersparepart" CASCADE;
DROP TABLE IF EXISTS "sparepart" CASCADE;
DROP TABLE IF EXISTS "ordertable" CASCADE;
DROP TABLE IF EXISTS "client" CASCADE;
DROP TABLE IF EXISTS "car" CASCADE;

-- Создание структуры таблиц
CREATE TABLE "car" (
  "id" BIGSERIAL,
  "brand" character varying NOT NULL,
  "model" character varying NOT NULL,
  "license_plate" character varying NOT NULL,
  "manufacture_year" integer,
  "configuration" character varying,
  PRIMARY KEY ("id")
);

CREATE TABLE "client" (
  "id" SERIAL,
  "first_name" character varying NOT NULL,
  "last_name" character varying NOT NULL,
  "bonus_card_number" character varying,
  "address" text,
  "birth_date" date,
  PRIMARY KEY ("id")
);

CREATE TABLE "ordertable" (
  "id" SERIAL,
  "payment_status" character varying,
  "total_amount" numeric NOT NULL,
  "customer_comment" text,
  "order_datetime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
  "status" character varying,
  "car_id" integer,
  "client_id" integer,
  PRIMARY KEY ("id")
);

CREATE TABLE "sparepart" (
  "id" SERIAL,
  "name" character varying NOT NULL,
  "manufacturer" character varying,
  "article_number" character varying NOT NULL,
  "price" numeric NOT NULL,
  "stock_quantity" integer NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "ordersparepart" (
  "id" integer NOT NULL,
  "order_id" integer,
  "spare_part_id" integer,
  PRIMARY KEY ("id")
);

CREATE TABLE "test" (
  "id" integer NOT NULL,
  "name" character varying,
  PRIMARY KEY ("id")
);

CREATE TABLE "new_table" (
  "id" integer NOT NULL,
  "name" character varying,
  "age" integer,
  PRIMARY KEY ("id")
);

CREATE TABLE "saved_queries" (
  "id" SERIAL,
  "name" character varying NOT NULL,
  "query" text NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "sto" (
  "id" SERIAL,
  "name" character varying NOT NULL,
  "phone" character varying,
  "address" text,
  "email" character varying,
  "working_hours" character varying,
  PRIMARY KEY ("id")
);

CREATE TABLE "service" (
  "id" SERIAL,
  "name" character varying NOT NULL,
  "cost" numeric NOT NULL,
  "duration" interval NOT NULL,
  "warranty_period" interval NOT NULL,
  "category" character varying,
  "sto_id" integer,
  PRIMARY KEY ("id")
);

CREATE TABLE "carservice" (
  "id" SERIAL,
  "car_id" integer,
  "service_id" integer,
  PRIMARY KEY ("id")
);

CREATE TABLE "employee" (
  "id" SERIAL,
  "first_name" character varying NOT NULL,
  "last_name" character varying NOT NULL,
  "position" character varying,
  "phone_number" character varying,
  "salary" numeric,
  "sto_id" integer,
  PRIMARY KEY ("id")
);

CREATE TABLE "orderemployee" (
  "id" SERIAL,
  "order_id" integer,
  "employee_id" integer,
  PRIMARY KEY ("id")
);

-- Вставка данных
-- Данные таблицы: car
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (1, 'Toyota', 'Corolla', 'A123BC', 2018, 'Sedan');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (2, 'Honda', 'Civic', 'B456DE', 2019, 'Hatchback');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (3, 'Ford', 'Mustang', 'C789FG', 2020, 'Coupe');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (4, 'Chevrolet', 'Camaro', 'D012HI', 2017, 'Convertible');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (5, 'BMW', 'X5', 'E345JK', 2021, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (6, 'Audi', 'A4', 'F678LM', 2016, 'Sedan');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (7, 'Mercedes-Benz', 'C-Class', 'G901NO', 2022, 'Sedan');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (8, 'Volkswagen', 'Golf', 'H234PQ', 2015, 'Hatchback');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (9, 'Tesla', 'Model 3', 'I567RS', 2023, 'Sedan');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (10, 'Nissan', 'Altima', 'J890TU', 2018, 'Sedan');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (11, 'Hyundai', 'Tucson', 'K123VW', 2019, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (12, 'Kia', 'Sportage', 'L456XY', 2020, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (13, 'Subaru', 'Outback', 'M789ZA', 2021, 'Wagon');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (14, 'Mazda', 'CX-5', 'N012BC', 2017, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (15, 'Lexus', 'RX', 'O345DE', 2022, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (16, 'Volvo', 'XC90', 'P678FG', 2016, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (17, 'Porsche', '911', 'Q901HI', 2023, 'Coupe');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (18, 'Jeep', 'Wrangler', 'R234JK', 2018, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (19, 'Land Rover', 'Range Rover', 'S567LM', 2019, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (20, 'Fiat', '500', 'T890NO', 2020, 'Hatchback');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (21, 'Mini', 'Cooper', 'U123PQ', 2021, 'Hatchback');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (22, 'Jaguar', 'F-Pace', 'V456RS', 2017, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (23, 'Alfa Romeo', 'Giulia', 'W789TU', 2022, 'Sedan');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (24, 'Dodge', 'Charger', 'X012VW', 2016, 'Sedan');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (25, 'Chrysler', '300', 'Y345XY', 2023, 'Sedan');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (26, 'Buick', 'Encore', 'Z678ZA', 2018, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (27, 'Cadillac', 'Escalade', 'A901BC', 2019, 'SUV');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (28, 'Audi', 'RS7', '1357HH-7', 2021, 'S-Line');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (29, 'Audi', 'A4', '1421AC-3', 2023, 'Avant');
INSERT INTO "car" ("id", "brand", "model", "license_plate", "manufacture_year", "configuration") VALUES (30, 'Mazda', '3', '1748BN-5', 2011, 'BL');

-- Данные таблицы: client
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (1, 'Иван', 'Иванов', '1234567890', 'ул. Ленина, д. 10', '1985-05-15 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (2, 'Петр', 'Петров', '2345678901', 'ул. Пушкина, д. 25', '1990-08-20 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (3, 'Анна', 'Сидорова', '3456789012', 'ул. Гагарина, д. 30', '1988-03-10 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (4, 'Мария', 'Кузнецова', '4567890123', 'ул. Мира, д. 5', '1995-11-25 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (5, 'Сергей', 'Смирнов', '5678901234', 'ул. Садовая, д. 15', '1980-07-12 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (6, 'Ольга', 'Васильева', '6789012345', 'ул. Лесная, д. 20', '1992-09-18 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (7, 'Дмитрий', 'Павлов', '7890123456', 'ул. Центральная, д. 8', '1987-04-30 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (8, 'Елена', 'Семенова', '8901234567', 'ул. Молодежная, д. 12', '1998-02-14 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (9, 'Алексей', 'Голубев', '9012345678', 'ул. Школьная, д. 3', '1983-06-22 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (10, 'Татьяна', 'Воробьева', '0123456789', 'ул. Парковая, д. 7', '1991-12-05 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (11, 'Николай', 'Козлов', '1122334455', 'ул. Речная, д. 9', '1986-10-11 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (12, 'Екатерина', 'Лебедева', '2233445566', 'ул. Солнечная, д. 14', '1994-01-28 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (13, 'Андрей', 'Новиков', '3344556677', 'ул. Зеленая, д. 18', '1989-07-07 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (14, 'Виктория', 'Морозова', '4455667788', 'ул. Луговая, д. 22', '1997-03-19 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (15, 'Артем', 'Петухов', '5566778899', 'ул. Вишневая, д. 11', '1984-09-03 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (16, 'Юлия', 'Волкова', '6677889900', 'ул. Кленовая, д. 6', '1993-05-27 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (17, 'Игорь', 'Соловьев', '7788990011', 'ул. Березовая, д. 4', '1982-12-15 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (18, 'Наталья', 'Романова', '8899001122', 'ул. Дубовая, д. 17', '1996-08-08 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (19, 'Владимир', 'Орлов', '9900112233', 'ул. Сосновая, д. 13', '1981-04-23 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (20, 'Светлана', 'Андреева', '0011223344', 'ул. Ясная, д. 19', '1999-10-31 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (21, 'Павел', 'Макаров', '1020304050', 'ул. Грибная, д. 21', '1980-11-09 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (22, 'Алина', 'Никитина', '2030405060', 'ул. Цветочная, д. 16', '1990-06-14 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (23, 'Константин', 'Захаров', '3040506070', 'ул. Фруктовая, д. 23', '1987-02-17 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (24, 'Людмила', 'Тихонова', '4050607080', 'ул. Ореховая, д. 24', '1992-07-29 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (25, 'Григорий', 'Федоров', '5060708090', 'ул. Садовая, д. 26', '1983-03-12 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (26, 'Валентина', 'Медведева', '6070809010', 'ул. Лесная, д. 28', '1995-09-22 00:00:00.0');
INSERT INTO "client" ("id", "first_name", "last_name", "bonus_card_number", "address", "birth_date") VALUES (27, 'Роман', 'Егоров', '7080901020', 'ул. Полевая, д. 29', '1988-12-01 00:00:00.0');

-- Данные таблицы: ordertable
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (1, 'Оплачено', 2000.00, 'Замена масла', '2025-03-04 01:25:57.434', 'Выполнено', 1, 1);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (2, 'Не оплачено', 5000.00, 'Замена тормозных колодок', '2025-03-04 01:25:57.434', 'В процессе', 2, 2);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (3, 'Оплачено', 3000.00, 'Замена аккумулятора', '2025-03-04 01:25:57.434', 'Выполнено', 3, 3);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (4, 'Не оплачено', 1500.00, 'Шиномонтаж', '2025-03-04 01:25:57.434', 'В процессе', 4, 4);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (5, 'Оплачено', 4000.00, 'Диагностика двигателя', '2025-03-04 01:25:57.434', 'Выполнено', 5, 5);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (6, 'Не оплачено', 2500.00, 'Замена фильтров', '2025-03-04 01:25:57.434', 'В процессе', 6, 6);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (7, 'Оплачено', 8000.00, 'Ремонт подвески', '2025-03-04 01:25:57.434', 'Выполнено', 7, 7);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (8, 'Не оплачено', 15000.00, 'Покраска кузова', '2025-03-04 01:25:57.434', 'В процессе', 8, 8);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (9, 'Оплачено', 7000.00, 'Замена стекла', '2025-03-04 01:25:57.434', 'Выполнено', 9, 9);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (10, 'Не оплачено', 6000.00, 'Замена ремня ГРМ', '2025-03-04 01:25:57.434', 'В процессе', 10, 10);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (11, 'Оплачено', 2000.00, 'Замена свечей зажигания', '2025-03-04 01:25:57.434', 'Выполнено', 11, 11);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (12, 'Не оплачено', 4500.00, 'Замена топливного насоса', '2025-03-04 01:25:57.434', 'В процессе', 12, 12);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (13, 'Оплачено', 3500.00, 'Замена глушителя', '2025-03-04 01:25:57.434', 'Выполнено', 13, 13);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (14, 'Не оплачено', 5500.00, 'Замена амортизаторов', '2025-03-04 01:25:57.434', 'В процессе', 14, 14);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (15, 'Оплачено', 9000.00, 'Замена рулевой рейки', '2025-03-04 01:25:57.434', 'Выполнено', 15, 15);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (16, 'Не оплачено', 4000.00, 'Замена радиатора', '2025-03-04 01:25:57.434', 'В процессе', 16, 16);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (17, 'Оплачено', 5000.00, 'Замена генератора', '2025-03-04 01:25:57.434', 'Выполнено', 17, 17);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (18, 'Не оплачено', 4500.00, 'Замена стартера', '2025-03-04 01:25:57.434', 'В процессе', 18, 18);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (19, 'Оплачено', 1500.00, 'Замена топливного фильтра', '2025-03-04 01:25:57.434', 'Выполнено', 19, 19);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (20, 'Не оплачено', 1000.00, 'Замена салонного фильтра', '2025-03-04 01:25:57.434', 'В процессе', 20, 20);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (21, 'Оплачено', 7000.00, 'Замена тормозных дисков', '2025-03-04 01:25:57.434', 'Выполнено', 21, 21);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (22, 'Не оплачено', 3000.00, 'Замена рулевых наконечников', '2025-03-04 01:25:57.434', 'В процессе', 22, 22);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (23, 'Оплачено', 6000.00, 'Замена подшипников ступиц', '2025-03-04 01:25:57.434', 'Выполнено', 23, 23);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (24, 'Не оплачено', 10000.00, 'Замена топливного бака', '2025-03-04 01:25:57.434', 'В процессе', 24, 24);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (25, 'Оплачено', 12000.00, 'Замена катализатора', '2025-03-04 01:25:57.434', 'Выполнено', 25, 25);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (26, 'Не оплачено', 20000.00, 'Замена турбины', '2025-03-04 01:25:57.434', 'В процессе', 26, 26);
INSERT INTO "ordertable" ("id", "payment_status", "total_amount", "customer_comment", "order_datetime", "status", "car_id", "client_id") VALUES (27, 'Оплачено', 10000.00, 'Замена сцепления', '2025-03-04 01:25:57.434', 'Выполнено', 27, 27);

-- Данные таблицы: sparepart
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (1, 'Масло моторное', 'Shell', '123456', 2000.00, 50);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (2, 'Тормозные колодки', 'Brembo', '234567', 3000.00, 30);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (3, 'Аккумулятор', 'Varta', '345678', 5000.00, 20);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (4, 'Шины', 'Michelin', '456789', 8000.00, 40);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (5, 'Фильтр воздушный', 'Mann', '567890', 1000.00, 60);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (6, 'Фильтр масляный', 'Bosch', '678901', 1500.00, 70);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (7, 'Амортизаторы', 'KYB', '789012', 4000.00, 25);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (8, 'Ремень ГРМ', 'Gates', '890123', 2500.00, 35);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (9, 'Свечи зажигания', 'NGK', '901234', 500.00, 100);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (10, 'Топливный насос', 'Delphi', '012345', 4500.00, 15);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (11, 'Глушитель', 'Walker', '123451', 3000.00, 20);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (12, 'Рулевая рейка', 'TRW', '234568', 7000.00, 10);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (13, 'Радиатор', 'Nissens', '345671', 3500.00, 18);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (14, 'Генератор', 'Valeo', '456784', 6000.00, 12);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (15, 'Стартер', 'Bosch', '567891', 5500.00, 14);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (16, 'Топливный фильтр', 'Mann', '678903', 800.00, 50);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (17, 'Салонный фильтр', 'Bosch', '789015', 700.00, 60);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (18, 'Тормозные диски', 'Brembo', '890124', 4000.00, 22);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (19, 'Рулевые наконечники', 'Lemforder', '901232', 1500.00, 30);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (20, 'Подшипники ступиц', 'SKF', '012347', 2500.00, 25);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (21, 'Топливный бак', 'Spectra', '123454', 8000.00, 8);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (22, 'Катализатор', 'Bosal', '234561', 10000.00, 6);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (23, 'Турбина', 'Garrett', '345672', 15000.00, 4);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (24, 'Сцепление', 'Luk', '456783', 9000.00, 10);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (25, 'Лобовое стекло', 'Pilkington', '567894', 12000.00, 5);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (26, 'Краска', 'DuPont', '678905', 5000.00, 15);
INSERT INTO "sparepart" ("id", "name", "manufacturer", "article_number", "price", "stock_quantity") VALUES (27, 'Фильтр топливный', 'Mann', '789016', 1200.00, 40);

-- Данные таблицы: ordersparepart
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (1, 1, 1);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (2, 2, 2);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (3, 3, 3);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (4, 4, 4);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (5, 5, 5);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (6, 6, 6);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (7, 7, 7);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (8, 8, 8);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (9, 9, 9);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (10, 10, 10);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (11, 11, 11);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (12, 12, 12);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (13, 13, 13);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (14, 14, 14);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (15, 15, 15);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (16, 16, 16);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (17, 17, 17);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (18, 18, 18);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (19, 19, 19);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (20, 20, 20);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (21, 21, 21);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (22, 22, 22);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (23, 23, 23);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (24, 24, 24);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (25, 25, 25);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (26, 26, 26);
INSERT INTO "ordersparepart" ("id", "order_id", "spare_part_id") VALUES (27, 27, 27);

-- Данные таблицы: new_table
INSERT INTO "new_table" ("id", "name", "age") VALUES (1, NULL, NULL);
INSERT INTO "new_table" ("id", "name", "age") VALUES (2, 'test', 5);

-- Данные таблицы: saved_queries
INSERT INTO "saved_queries" ("id", "name", "query") VALUES (1, 'test', 'SELECT * FROM car');
INSERT INTO "saved_queries" ("id", "name", "query") VALUES (2, 'asdasdasd', 'select * from service');
INSERT INTO "saved_queries" ("id", "name", "query") VALUES (3, 'sadasdasd', 'select * from service');

-- Данные таблицы: sto
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (1, 'СТО "Автосервис 1"', '+79161111111', 'ул. Ленина, д. 10', 'sto1@example.com', '08:00-20:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (2, 'СТО "Автосервис 2"', '+79162222222', 'ул. Пушкина, д. 25', 'sto2@example.com', '09:00-21:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (3, 'СТО "Автосервис 3"', '+79163333333', 'ул. Гагарина, д. 30', 'sto3@example.com', '08:30-19:30');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (4, 'СТО "Автосервис 4"', '+79164444444', 'ул. Мира, д. 5', 'sto4@example.com', '10:00-22:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (5, 'СТО "Автосервис 5"', '+79165555555', 'ул. Садовая, д. 15', 'sto5@example.com', '08:00-18:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (6, 'СТО "Автосервис 6"', '+79166666666', 'ул. Лесная, д. 20', 'sto6@example.com', '09:00-20:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (7, 'СТО "Автосервис 7"', '+79167777777', 'ул. Центральная, д. 8', 'sto7@example.com', '08:00-20:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (8, 'СТО "Автосервис 8"', '+79168888888', 'ул. Молодежная, д. 12', 'sto8@example.com', '10:00-22:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (9, 'СТО "Автосервис 9"', '+79169999999', 'ул. Школьная, д. 3', 'sto9@example.com', '08:30-19:30');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (10, 'СТО "Автосервис 10"', '+79161010101', 'ул. Парковая, д. 7', 'sto10@example.com', '09:00-21:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (11, 'СТО "Автосервис 11"', '+79162121212', 'ул. Речная, д. 9', 'sto11@example.com', '08:00-20:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (12, 'СТО "Автосервис 12"', '+79163232323', 'ул. Солнечная, д. 14', 'sto12@example.com', '10:00-22:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (13, 'СТО "Автосервис 13"', '+79164343434', 'ул. Зеленая, д. 18', 'sto13@example.com', '08:30-19:30');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (14, 'СТО "Автосервис 14"', '+79165454545', 'ул. Луговая, д. 22', 'sto14@example.com', '09:00-21:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (15, 'СТО "Автосервис 15"', '+79166565656', 'ул. Вишневая, д. 11', 'sto15@example.com', '08:00-20:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (16, 'СТО "Автосервис 16"', '+79167676767', 'ул. Кленовая, д. 6', 'sto16@example.com', '10:00-22:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (17, 'СТО "Автосервис 17"', '+79168787878', 'ул. Березовая, д. 4', 'sto17@example.com', '08:30-19:30');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (18, 'СТО "Автосервис 18"', '+79169898989', 'ул. Дубовая, д. 17', 'sto18@example.com', '09:00-21:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (19, 'СТО "Автосервис 19"', '+79160909090', 'ул. Сосновая, д. 13', 'sto19@example.com', '08:00-20:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (20, 'СТО "Автосервис 20"', '+79161111222', 'ул. Ясная, д. 19', 'sto20@example.com', '10:00-22:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (21, 'СТО "Автосервис 21"', '+79162222333', 'ул. Грибная, д. 21', 'sto21@example.com', '08:30-19:30');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (22, 'СТО "Автосервис 22"', '+79163333444', 'ул. Цветочная, д. 16', 'sto22@example.com', '09:00-21:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (23, 'СТО "Автосервис 23"', '+79164444555', 'ул. Фруктовая, д. 23', 'sto23@example.com', '08:00-20:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (24, 'СТО "Автосервис 24"', '+79165555666', 'ул. Ореховая, д. 24', 'sto24@example.com', '10:00-22:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (25, 'СТО "Автосервис 25"', '+79166666777', 'ул. Садовая, д. 26', 'sto25@example.com', '08:30-19:30');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (26, 'СТО "Автосервис 26"', '+79167777888', 'ул. Лесная, д. 28', 'sto26@example.com', '09:00-21:00');
INSERT INTO "sto" ("id", "name", "phone", "address", "email", "working_hours") VALUES (27, 'СТО "Автосервис 27"', '+79168888999', 'ул. Полевая, д. 29', 'sto27@example.com', '08:00-20:00');

-- Данные таблицы: service
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (2, 'Замена тормозных колодок', 5000.00, '2 hours'::interval, '1 years'::interval, 'Ремонт тормозов', 2);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (3, 'Замена аккумулятора', 3000.00, '30 minutes'::interval, '1 years'::interval, 'Электрика', 3);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (5, 'Диагностика двигателя', 4000.00, '2 hours'::interval, '1 months'::interval, 'Диагностика', 5);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (7, 'Ремонт подвески', 8000.00, '3 hours'::interval, '1 years'::interval, 'Ремонт подвески', 7);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (8, 'Покраска кузова', 15000.00, '8 hours'::interval, '2 years'::interval, 'Кузовные работы', 8);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (9, 'Замена стекла', 7000.00, '2 hours 30 minutes'::interval, '1 years'::interval, 'Кузовные работы', 9);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (10, 'Замена ремня ГРМ', 6000.00, '3 hours'::interval, '1 years'::interval, 'Двигатель', 10);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (12, 'Замена топливного насоса', 4500.00, '2 hours'::interval, '1 years'::interval, 'Топливная система', 12);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (13, 'Замена глушителя', 3500.00, '1 hours 30 minutes'::interval, '1 years'::interval, 'Выхлопная система', 13);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (14, 'Замена амортизаторов', 5500.00, '2 hours 30 minutes'::interval, '1 years'::interval, 'Подвеска', 14);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (15, 'Замена рулевой рейки', 9000.00, '4 hours'::interval, '1 years'::interval, 'Рулевое управление', 15);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (16, 'Замена радиатора', 4000.00, '2 hours'::interval, '1 years'::interval, 'Система охлаждения', 16);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (17, 'Замена генератора', 5000.00, '2 hours 30 minutes'::interval, '1 years'::interval, 'Электрика', 17);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (18, 'Замена стартера', 4500.00, '2 hours'::interval, '1 years'::interval, 'Электрика', 18);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (21, 'Замена тормозных дисков', 7000.00, '3 hours'::interval, '1 years'::interval, 'Ремонт тормозов', 21);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (22, 'Замена рулевых наконечников', 3000.00, '2 hours'::interval, '1 years'::interval, 'Рулевое управление', 22);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (23, 'Замена подшипников ступиц', 6000.00, '3 hours'::interval, '1 years'::interval, 'Подвеска', 23);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (24, 'Замена топливного бака', 10000.00, '4 hours'::interval, '1 years'::interval, 'Топливная система', 24);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (25, 'Замена катализатора', 12000.00, '3 hours 30 minutes'::interval, '1 years'::interval, 'Выхлопная система', 25);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (26, 'Замена турбины', 20000.00, '6 hours'::interval, '1 years'::interval, 'Двигатель', 26);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (27, 'Замена сцепления', 10000.00, '4 hours'::interval, '1 years'::interval, 'Трансмиссия', 27);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (28, 'Техническая мойка', 1000.00, '1 hours'::interval, '1 months'::interval, 'Мойка', 1);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (29, 'Чистка салона', 800.00, '30 minutes'::interval, '1 months'::interval, 'Мойка', 3);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (30, 'Нанесение воска', 1500.00, '10 minutes'::interval, '1 months'::interval, 'Мойка', 4);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (1, 'Замена масла', 2000.00, '1 hours'::interval, '6 months'::interval, 'Техническое обслуживание', 1);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (4, 'Шиномонтаж', 1500.00, '1 hours 30 minutes'::interval, '6 months'::interval, 'Колеса', 4);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (6, 'Замена фильтров', 2500.00, '1 hours'::interval, '6 months'::interval, 'Техническое обслуживание', 6);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (11, 'Замена свечей зажигания', 2000.00, '1 hours'::interval, '6 months'::interval, 'Двигатель', 11);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (19, 'Замена топливного фильтра', 1500.00, '1 hours'::interval, '6 months'::interval, 'Топливная система', 19);
INSERT INTO "service" ("id", "name", "cost", "duration", "warranty_period", "category", "sto_id") VALUES (20, 'Замена салонного фильтра', 1000.00, '30 minutes'::interval, '6 months'::interval, 'Техническое обслуживание', 20);

-- Данные таблицы: carservice
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (1, 1, 1);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (2, 2, 2);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (3, 3, 3);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (4, 4, 4);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (5, 5, 5);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (6, 6, 6);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (7, 7, 7);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (8, 8, 8);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (9, 9, 9);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (10, 10, 10);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (11, 11, 11);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (12, 12, 12);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (13, 13, 13);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (14, 14, 14);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (15, 15, 15);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (16, 16, 16);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (17, 17, 17);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (18, 18, 18);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (19, 19, 19);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (20, 20, 20);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (21, 21, 21);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (22, 22, 22);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (23, 23, 23);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (24, 24, 24);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (25, 25, 25);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (26, 26, 26);
INSERT INTO "carservice" ("id", "car_id", "service_id") VALUES (27, 27, 27);

-- Данные таблицы: employee
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (1, 'Александр', 'Иванов', 'Механик', '+79161234567', 50000.00, 1);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (2, 'Дмитрий', 'Петров', 'Мастер-приемщик', '+79162345678', 45000.00, 2);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (3, 'Елена', 'Сидорова', 'Администратор', '+79163456789', 40000.00, 3);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (4, 'Сергей', 'Кузнецов', 'Электрик', '+79164567890', 55000.00, 4);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (5, 'Ольга', 'Васильева', 'Бухгалтер', '+79165678901', 48000.00, 5);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (6, 'Андрей', 'Смирнов', 'Менеджер', '+79166789012', 52000.00, 6);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (7, 'Татьяна', 'Попова', 'Кассир', '+79167890123', 42000.00, 7);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (8, 'Игорь', 'Морозов', 'Слесарь', '+79168901234', 47000.00, 8);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (9, 'Наталья', 'Новикова', 'Уборщик', '+79169012345', 35000.00, 9);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (10, 'Виктор', 'Федоров', 'Диагност', '+79160123456', 60000.00, 10);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (11, 'Екатерина', 'Волкова', 'Мойщик', '+79161234567', 38000.00, 11);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (12, 'Павел', 'Алексеев', 'Механик', '+79162345678', 51000.00, 12);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (13, 'Марина', 'Лебедева', 'Мастер-приемщик', '+79163456789', 46000.00, 13);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (14, 'Артем', 'Семенов', 'Электрик', '+79164567890', 54000.00, 14);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (15, 'Юлия', 'Егорова', 'Администратор', '+79165678901', 41000.00, 15);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (16, 'Анна', 'Павлова', 'Бухгалтер', '+79166789012', 49000.00, 16);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (17, 'Григорий', 'Козлов', 'Менеджер', '+79167890123', 53000.00, 17);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (18, 'Людмила', 'Степанова', 'Кассир', '+79168901234', 43000.00, 18);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (19, 'Владимир', 'Николаев', 'Слесарь', '+79169012345', 48000.00, 19);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (20, 'Светлана', 'Орлова', 'Уборщик', '+79160123456', 36000.00, 20);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (21, 'Роман', 'Андреев', 'Диагност', '+79161234567', 61000.00, 21);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (22, 'Алина', 'Макарова', 'Мойщик', '+79162345678', 39000.00, 22);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (23, 'Константин', 'Захаров', 'Механик', '+79163456789', 50000.00, 23);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (24, 'Валентина', 'Тихонова', 'Мастер-приемщик', '+79164567890', 47000.00, 24);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (25, 'Георгий', 'Филиппов', 'Электрик', '+79165678901', 56000.00, 25);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (26, 'Лариса', 'Белова', 'Администратор', '+79166789012', 42000.00, 26);
INSERT INTO "employee" ("id", "first_name", "last_name", "position", "phone_number", "salary", "sto_id") VALUES (27, 'Станислав', 'Григорьев', 'Бухгалтер', '+79167890123', 50000.00, 27);

-- Данные таблицы: orderemployee
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (1, 1, 1);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (2, 2, 2);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (3, 3, 3);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (4, 4, 4);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (5, 5, 5);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (6, 6, 6);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (7, 7, 7);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (8, 8, 8);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (9, 9, 9);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (10, 10, 10);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (11, 11, 11);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (12, 12, 12);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (13, 13, 13);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (14, 14, 14);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (15, 15, 15);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (16, 16, 16);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (17, 17, 17);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (18, 18, 18);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (19, 19, 19);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (20, 20, 20);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (21, 21, 21);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (22, 22, 22);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (23, 23, 23);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (24, 24, 24);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (25, 25, 25);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (26, 26, 26);
INSERT INTO "orderemployee" ("id", "order_id", "employee_id") VALUES (27, 27, 27);

-- Восстановление внешних ключей
ALTER TABLE "ordertable" ADD CONSTRAINT "ordertable_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "car" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE "ordertable" ADD CONSTRAINT "ordertable_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "client" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE "ordersparepart" ADD CONSTRAINT "ordersparepart_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "ordertable" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE "ordersparepart" ADD CONSTRAINT "ordersparepart_spare_part_id_fkey" FOREIGN KEY ("spare_part_id") REFERENCES "sparepart" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE "service" ADD CONSTRAINT "service_sto_id_fkey" FOREIGN KEY ("sto_id") REFERENCES "sto" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE "carservice" ADD CONSTRAINT "carservice_car_id_fkey" FOREIGN KEY ("car_id") REFERENCES "car" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE "carservice" ADD CONSTRAINT "carservice_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "service" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE "employee" ADD CONSTRAINT "employee_sto_id_fkey" FOREIGN KEY ("sto_id") REFERENCES "sto" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE "orderemployee" ADD CONSTRAINT "orderemployee_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employee" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;
ALTER TABLE "orderemployee" ADD CONSTRAINT "orderemployee_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "ordertable" ("id") ON UPDATE NO ACTION ON DELETE CASCADE;

COMMIT;
-- Бэкап успешно завершен
