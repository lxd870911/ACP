use console;
ALTER TABLE tenant_service ADD service_cname varchar(100) DEFAULT "" after service_alias;
ALTER TABLE tenant_service_delete ADD service_cname varchar(100) DEFAULT "" after service_alias;

use region;
alter table tenant_lb_nginx_domain add port int(11) not null default 10080;

CREATE TABLE `tenant_services_port` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` varchar(32) DEFAULT NULL,
  `service_id` varchar(32) NOT NULL,
  `container_port` int(11) NOT NULL,
  `mapping_port` int(11) NOT NULL,
  `protocol` varchar(15) NOT NULL,
  `port_alias` varchar(30) DEFAULT NULL,
  `is_inner_service` tinyint(1) NOT NULL,
  `is_outer_service` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `service_id` (`service_id`,`container_port`),
  KEY `tenant_services_port_b0dc1e29` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `tenant_service_dataset` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` varchar(32) NOT NULL,
  `dataset_id` varchar(36) NOT NULL,
  `primary` varchar(36) NOT NULL,
  `maximum_size` bigint(20) NOT NULL,
  `metadata_name` varchar(32) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;