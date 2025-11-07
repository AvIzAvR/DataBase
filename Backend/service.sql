DROP TABLE IF EXISTS `service` CASCADE;
CREATE TABLE `service` (
    `id` integer,
    `name` character varying,
    `cost` numeric,
    `duration` interval,
    `warranty_period` interval,
    `category` character varying,
    `sto_id` integer,
    PRIMARY KEY (`id`)
);

INSERT INTO `service` VALUES (2, 'Замена тормозных колодок', 5000.00, 0 years 0 mons 0 days 2 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Ремонт тормозов', 2, );
INSERT INTO `service` VALUES (3, 'Замена аккумулятора', 3000.00, 0 years 0 mons 0 days 0 hours 30 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Электрика', 3, );
INSERT INTO `service` VALUES (5, 'Диагностика двигателя', 4000.00, 0 years 0 mons 0 days 2 hours 0 mins 0.0 secs, 0 years 1 mons 0 days 0 hours 0 mins 0.0 secs, 'Диагностика', 5, );
INSERT INTO `service` VALUES (7, 'Ремонт подвески', 8000.00, 0 years 0 mons 0 days 3 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Ремонт подвески', 7, );
INSERT INTO `service` VALUES (8, 'Покраска кузова', 15000.00, 0 years 0 mons 0 days 8 hours 0 mins 0.0 secs, 2 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Кузовные работы', 8, );
INSERT INTO `service` VALUES (9, 'Замена стекла', 7000.00, 0 years 0 mons 0 days 2 hours 30 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Кузовные работы', 9, );
INSERT INTO `service` VALUES (10, 'Замена ремня ГРМ', 6000.00, 0 years 0 mons 0 days 3 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Двигатель', 10, );
INSERT INTO `service` VALUES (12, 'Замена топливного насоса', 4500.00, 0 years 0 mons 0 days 2 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Топливная система', 12, );
INSERT INTO `service` VALUES (13, 'Замена глушителя', 3500.00, 0 years 0 mons 0 days 1 hours 30 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Выхлопная система', 13, );
INSERT INTO `service` VALUES (14, 'Замена амортизаторов', 5500.00, 0 years 0 mons 0 days 2 hours 30 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Подвеска', 14, );
INSERT INTO `service` VALUES (15, 'Замена рулевой рейки', 9000.00, 0 years 0 mons 0 days 4 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Рулевое управление', 15, );
INSERT INTO `service` VALUES (16, 'Замена радиатора', 4000.00, 0 years 0 mons 0 days 2 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Система охлаждения', 16, );
INSERT INTO `service` VALUES (17, 'Замена генератора', 5000.00, 0 years 0 mons 0 days 2 hours 30 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Электрика', 17, );
INSERT INTO `service` VALUES (18, 'Замена стартера', 4500.00, 0 years 0 mons 0 days 2 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Электрика', 18, );
INSERT INTO `service` VALUES (21, 'Замена тормозных дисков', 7000.00, 0 years 0 mons 0 days 3 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Ремонт тормозов', 21, );
INSERT INTO `service` VALUES (22, 'Замена рулевых наконечников', 3000.00, 0 years 0 mons 0 days 2 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Рулевое управление', 22, );
INSERT INTO `service` VALUES (23, 'Замена подшипников ступиц', 6000.00, 0 years 0 mons 0 days 3 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Подвеска', 23, );
INSERT INTO `service` VALUES (24, 'Замена топливного бака', 10000.00, 0 years 0 mons 0 days 4 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Топливная система', 24, );
INSERT INTO `service` VALUES (25, 'Замена катализатора', 12000.00, 0 years 0 mons 0 days 3 hours 30 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Выхлопная система', 25, );
INSERT INTO `service` VALUES (26, 'Замена турбины', 20000.00, 0 years 0 mons 0 days 6 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Двигатель', 26, );
INSERT INTO `service` VALUES (27, 'Замена сцепления', 10000.00, 0 years 0 mons 0 days 4 hours 0 mins 0.0 secs, 1 years 0 mons 0 days 0 hours 0 mins 0.0 secs, 'Трансмиссия', 27, );
INSERT INTO `service` VALUES (28, 'Техническая мойка', 1000.00, 0 years 0 mons 0 days 1 hours 0 mins 0.0 secs, 0 years 1 mons 0 days 0 hours 0 mins 0.0 secs, 'Мойка', 1, );
INSERT INTO `service` VALUES (29, 'Чистка салона', 800.00, 0 years 0 mons 0 days 0 hours 30 mins 0.0 secs, 0 years 1 mons 0 days 0 hours 0 mins 0.0 secs, 'Мойка', 3, );
INSERT INTO `service` VALUES (30, 'Нанесение воска', 1500.00, 0 years 0 mons 0 days 0 hours 10 mins 0.0 secs, 0 years 1 mons 0 days 0 hours 0 mins 0.0 secs, 'Мойка', 4, );
INSERT INTO `service` VALUES (1, 'Замена масла', 2000.00, 0 years 0 mons 0 days 1 hours 0 mins 0.0 secs, 0 years 6 mons 0 days 0 hours 0 mins 0.0 secs, 'Техническое обслуживание', 1, );
INSERT INTO `service` VALUES (4, 'Шиномонтаж', 1500.00, 0 years 0 mons 0 days 1 hours 30 mins 0.0 secs, 0 years 6 mons 0 days 0 hours 0 mins 0.0 secs, 'Колеса', 4, );
INSERT INTO `service` VALUES (6, 'Замена фильтров', 2500.00, 0 years 0 mons 0 days 1 hours 0 mins 0.0 secs, 0 years 6 mons 0 days 0 hours 0 mins 0.0 secs, 'Техническое обслуживание', 6, );
INSERT INTO `service` VALUES (11, 'Замена свечей зажигания', 2000.00, 0 years 0 mons 0 days 1 hours 0 mins 0.0 secs, 0 years 6 mons 0 days 0 hours 0 mins 0.0 secs, 'Двигатель', 11, );
INSERT INTO `service` VALUES (19, 'Замена топливного фильтра', 1500.00, 0 years 0 mons 0 days 1 hours 0 mins 0.0 secs, 0 years 6 mons 0 days 0 hours 0 mins 0.0 secs, 'Топливная система', 19, );
INSERT INTO `service` VALUES (20, 'Замена салонного фильтра', 1000.00, 0 years 0 mons 0 days 0 hours 30 mins 0.0 secs, 0 years 6 mons 0 days 0 hours 0 mins 0.0 secs, 'Техническое обслуживание', 20, );
