DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
    `id` bigint,
    `brand` character varying,
    `model` character varying,
    `license_plate` character varying,
    `manufacture_year` integer,
    `configuration` character varying,
    PRIMARY KEY (`id`)
);

INSERT INTO `car` VALUES (1, 'Toyota', 'Corolla', 'A123BC', 2018, 'Sedan', );
INSERT INTO `car` VALUES (2, 'Honda', 'Civic', 'B456DE', 2019, 'Hatchback', );
INSERT INTO `car` VALUES (3, 'Ford', 'Mustang', 'C789FG', 2020, 'Coupe', );
INSERT INTO `car` VALUES (4, 'Chevrolet', 'Camaro', 'D012HI', 2017, 'Convertible', );
INSERT INTO `car` VALUES (5, 'BMW', 'X5', 'E345JK', 2021, 'SUV', );
INSERT INTO `car` VALUES (6, 'Audi', 'A4', 'F678LM', 2016, 'Sedan', );
INSERT INTO `car` VALUES (7, 'Mercedes-Benz', 'C-Class', 'G901NO', 2022, 'Sedan', );
INSERT INTO `car` VALUES (8, 'Volkswagen', 'Golf', 'H234PQ', 2015, 'Hatchback', );
INSERT INTO `car` VALUES (9, 'Tesla', 'Model 3', 'I567RS', 2023, 'Sedan', );
INSERT INTO `car` VALUES (10, 'Nissan', 'Altima', 'J890TU', 2018, 'Sedan', );
INSERT INTO `car` VALUES (11, 'Hyundai', 'Tucson', 'K123VW', 2019, 'SUV', );
INSERT INTO `car` VALUES (12, 'Kia', 'Sportage', 'L456XY', 2020, 'SUV', );
INSERT INTO `car` VALUES (13, 'Subaru', 'Outback', 'M789ZA', 2021, 'Wagon', );
INSERT INTO `car` VALUES (14, 'Mazda', 'CX-5', 'N012BC', 2017, 'SUV', );
INSERT INTO `car` VALUES (15, 'Lexus', 'RX', 'O345DE', 2022, 'SUV', );
INSERT INTO `car` VALUES (16, 'Volvo', 'XC90', 'P678FG', 2016, 'SUV', );
INSERT INTO `car` VALUES (17, 'Porsche', '911', 'Q901HI', 2023, 'Coupe', );
INSERT INTO `car` VALUES (18, 'Jeep', 'Wrangler', 'R234JK', 2018, 'SUV', );
INSERT INTO `car` VALUES (19, 'Land Rover', 'Range Rover', 'S567LM', 2019, 'SUV', );
INSERT INTO `car` VALUES (20, 'Fiat', '500', 'T890NO', 2020, 'Hatchback', );
INSERT INTO `car` VALUES (21, 'Mini', 'Cooper', 'U123PQ', 2021, 'Hatchback', );
INSERT INTO `car` VALUES (22, 'Jaguar', 'F-Pace', 'V456RS', 2017, 'SUV', );
INSERT INTO `car` VALUES (23, 'Alfa Romeo', 'Giulia', 'W789TU', 2022, 'Sedan', );
INSERT INTO `car` VALUES (24, 'Dodge', 'Charger', 'X012VW', 2016, 'Sedan', );
INSERT INTO `car` VALUES (25, 'Chrysler', '300', 'Y345XY', 2023, 'Sedan', );
INSERT INTO `car` VALUES (26, 'Buick', 'Encore', 'Z678ZA', 2018, 'SUV', );
INSERT INTO `car` VALUES (27, 'Cadillac', 'Escalade', 'A901BC', 2019, 'SUV', );
INSERT INTO `car` VALUES (28, 'Audi', 'RS7', '1357HH-7', 2021, 'S-Line', );
INSERT INTO `car` VALUES (29, 'Audi', 'A4', '1421AC-3', 2023, 'Avant', );
INSERT INTO `car` VALUES (30, 'Mazda', '3', '1748BN-5', 2011, 'BL', );
