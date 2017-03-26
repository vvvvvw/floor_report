### ###
### 报备系统 数据库
### ###
CREATE DATABASE IF NOT EXISTS floor_report DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE floor_report;

## 报备系统 客户表 ####
CREATE TABLE IF NOT EXISTS `floor_client` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID,自增',
  `name` varchar(255) COMMENT '姓名',
  `address` varchar(2000) NOT NULL COMMENT '客户地址',
  `phoneNumber` varchar(255)  COMMENT '电话号码',
  `email` varchar(255) COMMENT 'email地址',
  `createTime` bigint  DEFAULT '0' COMMENT '创建时间',
  `updateTime` bigint  DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_name_floor_client` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


## 报备系统 设计师表 ####
CREATE TABLE IF NOT EXISTS `floor_designer` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID,自增',
  `name` varchar(255) COMMENT '姓名',
  `address` varchar(2000) COMMENT '设计师地址',
  `phoneNumber` varchar(255)  COMMENT '电话号码',
  `email` varchar(255) COMMENT 'email地址',
  `createTime` bigint  DEFAULT '0' COMMENT '创建时间',
  `updateTime` bigint  DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_name_floor_designer` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

## 报备系统 项目表 ####
CREATE TABLE IF NOT EXISTS `floor_project` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID,自增',
  `employeeId` bigint NOT NULL COMMENT '对应员工表的ID',
  `clientId` bigint NOT NULL COMMENT '对应客户表的ID',
  `designerId` bigint COMMENT '对应设计师表的ID',
  `floorHeating` tinyint COMMENT '是否地暖',
  `progress` varchar(2000) COMMENT '施工进度',
  `floorType` varchar(255) COMMENT '地板类型',
  `communicationProgress` varchar(2000) COMMENT '沟通情况',
  `visitTime` bigint COMMENT '访问时间',
  `createTime` bigint  DEFAULT '0' COMMENT '创建时间',
  `updateTime` bigint  DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  FOREIGN KEY(`employeeId`) REFERENCES `floor_employee`(`employeeId`),
  FOREIGN KEY(`clientId`) REFERENCES `floor_client`(`id`),
  FOREIGN KEY(`designerId`) REFERENCES `floor_designer`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

## 报备系统 员工表 ####
CREATE TABLE IF NOT EXISTS `floor_employee` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID,自增',
  `employeeId` bigint NOT NULL COMMENT '工号',
  `name` varchar(255) NOT NULL COMMENT '姓名',
  `password` varchar(2000) COMMENT '密码（Base64加密）',
  `phoneNumber` varchar(255)  COMMENT '电话号码',
  `email` varchar(255) COMMENT 'email地址',
  `createTime` bigint  DEFAULT '0' COMMENT '创建时间',
  `updateTime` bigint  DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY (`employeeId`),
  INDEX `idx_name_floor_employee` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

## 报备系统 管理员表 ####
CREATE TABLE IF NOT EXISTS `floor_admin` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID,自增',
  `employeeId` bigint NOT NULL COMMENT '工号',
  `name` varchar(255) NOT NULL COMMENT '姓名',
  `password` varchar(2000) NOT NULL COMMENT '密码（Base64加密）',
  `phoneNumber` varchar(255)  COMMENT '电话号码',
  `email` varchar(255) COMMENT 'email地址',
  `createTime` bigint  DEFAULT '0' COMMENT '创建时间',
  `updateTime` bigint  DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_name_floor_admin` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

