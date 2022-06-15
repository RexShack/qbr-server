CREATE TABLE IF NOT EXISTS `management_menu` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`job_name` VARCHAR(50) NOT NULL,
`amount`  INT(100) NOT NULL,
`menu_type` ENUM('boss','gang') NOT NULL DEFAULT 'boss',
PRIMARY KEY (`id`),
UNIQUE KEY `job_name` (`job_name`),
KEY `menu_type` (`menu_type`)
);

INSERT INTO `management_menu` (`job_name`, `amount`, `menu_type`) VALUES
('police', 0, 'boss'),
('ambulance', 0, 'boss'),
('realestate', 0, 'boss'),
('taxi', 0, 'boss'),
('cardealer', 0, 'boss'),
('mechanic', 0, 'boss'),
('odriscoll', 0, 'gang'),
('lemoyne', 0, 'gang'),
('murfree', 0, 'gang'),
('skinner', 0, 'gang'),
('laramie', 0, 'gang'),
('dellobo', 0, 'gang'),
('night', 0, 'gang'),
('foreman', 0, 'gang'),
('anderson', 0, 'gang'),
('watson', 0, 'gang');
