CREATE TABLE `houses` (
  `citizenid` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `cid` int(11) NOT NULL DEFAULT 0,
  `id` varchar(11) COLLATE utf8_bin NOT NULL,
  `time` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;