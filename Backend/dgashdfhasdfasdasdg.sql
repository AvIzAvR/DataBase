DROP TABLE IF EXISTS `sparepart` CASCADE;
CREATE TABLE `sparepart` (
    `id` integer,
    `name` character varying,
    `manufacturer` character varying,
    `article_number` character varying,
    `price` numeric,
    `stock_quantity` integer,
    PRIMARY KEY (`id`)
);

INSERT INTO `sparepart` VALUES (1, 'Масло моторное', 'Shell', '123456', 2000.00, 50, );
INSERT INTO `sparepart` VALUES (2, 'Тормозные колодки', 'Brembo', '234567', 3000.00, 30, );
INSERT INTO `sparepart` VALUES (3, 'Аккумулятор', 'Varta', '345678', 5000.00, 20, );
INSERT INTO `sparepart` VALUES (4, 'Шины', 'Michelin', '456789', 8000.00, 40, );
INSERT INTO `sparepart` VALUES (5, 'Фильтр воздушный', 'Mann', '567890', 1000.00, 60, );
INSERT INTO `sparepart` VALUES (6, 'Фильтр масляный', 'Bosch', '678901', 1500.00, 70, );
INSERT INTO `sparepart` VALUES (7, 'Амортизаторы', 'KYB', '789012', 4000.00, 25, );
INSERT INTO `sparepart` VALUES (8, 'Ремень ГРМ', 'Gates', '890123', 2500.00, 35, );
INSERT INTO `sparepart` VALUES (9, 'Свечи зажигания', 'NGK', '901234', 500.00, 100, );
INSERT INTO `sparepart` VALUES (10, 'Топливный насос', 'Delphi', '012345', 4500.00, 15, );
INSERT INTO `sparepart` VALUES (11, 'Глушитель', 'Walker', '123451', 3000.00, 20, );
INSERT INTO `sparepart` VALUES (12, 'Рулевая рейка', 'TRW', '234568', 7000.00, 10, );
INSERT INTO `sparepart` VALUES (13, 'Радиатор', 'Nissens', '345671', 3500.00, 18, );
INSERT INTO `sparepart` VALUES (14, 'Генератор', 'Valeo', '456784', 6000.00, 12, );
INSERT INTO `sparepart` VALUES (15, 'Стартер', 'Bosch', '567891', 5500.00, 14, );
INSERT INTO `sparepart` VALUES (16, 'Топливный фильтр', 'Mann', '678903', 800.00, 50, );
INSERT INTO `sparepart` VALUES (17, 'Салонный фильтр', 'Bosch', '789015', 700.00, 60, );
INSERT INTO `sparepart` VALUES (18, 'Тормозные диски', 'Brembo', '890124', 4000.00, 22, );
INSERT INTO `sparepart` VALUES (19, 'Рулевые наконечники', 'Lemforder', '901232', 1500.00, 30, );
INSERT INTO `sparepart` VALUES (20, 'Подшипники ступиц', 'SKF', '012347', 2500.00, 25, );
INSERT INTO `sparepart` VALUES (21, 'Топливный бак', 'Spectra', '123454', 8000.00, 8, );
INSERT INTO `sparepart` VALUES (22, 'Катализатор', 'Bosal', '234561', 10000.00, 6, );
INSERT INTO `sparepart` VALUES (23, 'Турбина', 'Garrett', '345672', 15000.00, 4, );
INSERT INTO `sparepart` VALUES (24, 'Сцепление', 'Luk', '456783', 9000.00, 10, );
INSERT INTO `sparepart` VALUES (25, 'Лобовое стекло', 'Pilkington', '567894', 12000.00, 5, );
INSERT INTO `sparepart` VALUES (26, 'Краска', 'DuPont', '678905', 5000.00, 15, );
INSERT INTO `sparepart` VALUES (27, 'Фильтр топливный', 'Mann', '789016', 1200.00, 40, );
