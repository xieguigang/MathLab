-- MySQL Script generated by MySQL Workbench
-- Sat Sep 26 16:13:06 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pakchoi_pos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pakchoi_pos` ;

-- -----------------------------------------------------
-- Schema pakchoi_pos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pakchoi_pos` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `pakchoi_pos` ;

-- -----------------------------------------------------
-- Table `vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vendor` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `vendor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL COMMENT '供应商公司名称',
  `tel` VARCHAR(32) NULL,
  `url` VARCHAR(255) NULL,
  `address` VARCHAR(255) NULL,
  `add_time` DATETIME NOT NULL,
  `operator` INT NOT NULL,
  `status` INT NULL,
  `note` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '供应商信息';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `vendor` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `admin` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `realname` VARCHAR(16) NOT NULL,
  `email` VARCHAR(64) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `addtime` DATETIME NOT NULL,
  `avatar` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '系统管理员以及收银员';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `admin` (`id` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `realname_UNIQUE` ON `admin` (`realname` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `email_UNIQUE` ON `admin` (`email` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `goods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `goods` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `goods` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL COMMENT '商品名称',
  `add_time` DATETIME NOT NULL COMMENT '添加时间',
  `price` DOUBLE NOT NULL COMMENT '单价',
  `gender` INT NOT NULL COMMENT '男装或者女装',
  `display` LONGTEXT NOT NULL COMMENT '显示图片的datauri base64字符串',
  `item_id` VARCHAR(255) NOT NULL COMMENT '供应商的内部编号',
  `vendor_id` INT NOT NULL,
  `operator` INT NOT NULL,
  `note` MEDIUMTEXT NULL COMMENT '对商品的简要描述信息',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品信息表';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `goods` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `VIP_members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VIP_members` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `VIP_members` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `card_id` VARCHAR(64) NOT NULL,
  `name` VARCHAR(32) NOT NULL,
  `balance` DOUBLE NOT NULL,
  `gender` INT NOT NULL,
  `phone` VARCHAR(32) NULL,
  `address` VARCHAR(64) NULL,
  `join_time` DATETIME NOT NULL,
  `operator` INT NOT NULL,
  `note` MEDIUMTEXT NULL,
  `flag` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '会员信息表';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `VIP_members` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `waterflow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `waterflow` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `waterflow` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `goods` MEDIUMTEXT NOT NULL COMMENT '{goods.id:count} 键值对的json字符串',
  `time` DATETIME NOT NULL,
  `money` DOUBLE NOT NULL COMMENT '交易的总金额',
  `buyer` INT NOT NULL COMMENT '0: anonymous\n-1: me\n> 1: VIP members',
  `operator` INT NOT NULL,
  `count` INT NOT NULL COMMENT '为了方便检索而设置的商品总件数，值为goods字段中的count的总和',
  `discount` DOUBLE NOT NULL DEFAULT 1 COMMENT '折扣率',
  `note` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '商品售卖记录，这个表里面包含了会员以及非会员的销售记录';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `waterflow` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `inventories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inventories` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `inventories` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '与库存流水记录相关联的编号',
  `batch_id` VARCHAR(45) NOT NULL COMMENT '库存批次号(人类可读的文本编码)',
  `inbound_time` DATETIME NOT NULL COMMENT '入库时间',
  `item_id` INT NOT NULL COMMENT '商品号',
  `count` INT NOT NULL COMMENT '入库的数量',
  `remnant` INT NOT NULL COMMENT '库存剩余',
  `note` MEDIUMTEXT NULL,
  `operator` INT NOT NULL,
  PRIMARY KEY (`id`, `batch_id`))
ENGINE = InnoDB
COMMENT = '货物批次库存';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `inventories` (`id` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `batch_id_UNIQUE` ON `inventories` (`batch_id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `role` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `admin` INT NOT NULL,
  `role_id` INT NOT NULL COMMENT '100: 管理员角色\n1： 收银员\n2： 仓储管理员',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '管理员或者收银员角色';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `role` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `trade_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trade_items` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `trade_items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `count` INT NOT NULL,
  `batch_id` INT NOT NULL,
  `waterflow` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '交易详情表';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `trade_items` (`id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `VIP_waterflow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VIP_waterflow` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `VIP_waterflow` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vip` INT NOT NULL,
  `money` DOUBLE NOT NULL,
  `waterflow_id` INT NOT NULL COMMENT '-1表示充值',
  `time` DATETIME NOT NULL,
  `note` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '相当于会员的充值以及消费流水';

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `VIP_waterflow` (`id` ASC);

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
