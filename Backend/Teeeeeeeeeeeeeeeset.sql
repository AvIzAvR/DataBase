DROP TABLE IF EXISTS `employee` CASCADE;
CREATE TABLE `employee` (
    `id` integer,
    `first_name` character varying,
    `last_name` character varying,
    `position` character varying,
    `phone_number` character varying,
    `salary` numeric,
    `sto_id` integer,
    PRIMARY KEY (`id`)
);

INSERT INTO `employee` VALUES (1, 'Александр', 'Иванов', 'Механик', '+79161234567', 50000.00, 1, );
INSERT INTO `employee` VALUES (2, 'Дмитрий', 'Петров', 'Мастер-приемщик', '+79162345678', 45000.00, 2, );
INSERT INTO `employee` VALUES (3, 'Елена', 'Сидорова', 'Администратор', '+79163456789', 40000.00, 3, );
INSERT INTO `employee` VALUES (4, 'Сергей', 'Кузнецов', 'Электрик', '+79164567890', 55000.00, 4, );
INSERT INTO `employee` VALUES (5, 'Ольга', 'Васильева', 'Бухгалтер', '+79165678901', 48000.00, 5, );
INSERT INTO `employee` VALUES (6, 'Андрей', 'Смирнов', 'Менеджер', '+79166789012', 52000.00, 6, );
INSERT INTO `employee` VALUES (7, 'Татьяна', 'Попова', 'Кассир', '+79167890123', 42000.00, 7, );
INSERT INTO `employee` VALUES (8, 'Игорь', 'Морозов', 'Слесарь', '+79168901234', 47000.00, 8, );
INSERT INTO `employee` VALUES (9, 'Наталья', 'Новикова', 'Уборщик', '+79169012345', 35000.00, 9, );
INSERT INTO `employee` VALUES (10, 'Виктор', 'Федоров', 'Диагност', '+79160123456', 60000.00, 10, );
INSERT INTO `employee` VALUES (11, 'Екатерина', 'Волкова', 'Мойщик', '+79161234567', 38000.00, 11, );
INSERT INTO `employee` VALUES (12, 'Павел', 'Алексеев', 'Механик', '+79162345678', 51000.00, 12, );
INSERT INTO `employee` VALUES (13, 'Марина', 'Лебедева', 'Мастер-приемщик', '+79163456789', 46000.00, 13, );
INSERT INTO `employee` VALUES (14, 'Артем', 'Семенов', 'Электрик', '+79164567890', 54000.00, 14, );
INSERT INTO `employee` VALUES (15, 'Юлия', 'Егорова', 'Администратор', '+79165678901', 41000.00, 15, );
INSERT INTO `employee` VALUES (16, 'Анна', 'Павлова', 'Бухгалтер', '+79166789012', 49000.00, 16, );
INSERT INTO `employee` VALUES (17, 'Григорий', 'Козлов', 'Менеджер', '+79167890123', 53000.00, 17, );
INSERT INTO `employee` VALUES (18, 'Людмила', 'Степанова', 'Кассир', '+79168901234', 43000.00, 18, );
INSERT INTO `employee` VALUES (19, 'Владимир', 'Николаев', 'Слесарь', '+79169012345', 48000.00, 19, );
INSERT INTO `employee` VALUES (20, 'Светлана', 'Орлова', 'Уборщик', '+79160123456', 36000.00, 20, );
INSERT INTO `employee` VALUES (21, 'Роман', 'Андреев', 'Диагност', '+79161234567', 61000.00, 21, );
INSERT INTO `employee` VALUES (22, 'Алина', 'Макарова', 'Мойщик', '+79162345678', 39000.00, 22, );
INSERT INTO `employee` VALUES (23, 'Константин', 'Захаров', 'Механик', '+79163456789', 50000.00, 23, );
INSERT INTO `employee` VALUES (24, 'Валентина', 'Тихонова', 'Мастер-приемщик', '+79164567890', 47000.00, 24, );
INSERT INTO `employee` VALUES (25, 'Георгий', 'Филиппов', 'Электрик', '+79165678901', 56000.00, 25, );
INSERT INTO `employee` VALUES (26, 'Лариса', 'Белова', 'Администратор', '+79166789012', 42000.00, 26, );
INSERT INTO `employee` VALUES (27, 'Станислав', 'Григорьев', 'Бухгалтер', '+79167890123', 50000.00, 27, );
