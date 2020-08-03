-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 03, 2020 at 02:03 PM
-- Server version: 5.7.31-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `glidernet_devicesdb`
--
CREATE DATABASE IF NOT EXISTS `glidernet_devicesdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `glidernet_devicesdb`;

-- --------------------------------------------------------

--
-- Table structure for table `aircraftstypes`
--

CREATE TABLE `aircraftstypes` (
  `ac_id` smallint(5) UNSIGNED NOT NULL COMMENT 'Acft ID (autoincremented)',
  `ac_type` varchar(32) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL COMMENT 'Acft type(ASW20, ...)',
  `ac_cat` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Acft category(glider, towplane, ...)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `dev_id` varchar(36) COLLATE utf8_unicode_ci NOT NULL COMMENT 'The hex device ID',
  `dev_passwd` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Device password if requered',
  `dev_type` tinyint(4) NOT NULL DEFAULT '2' COMMENT 'The device type: Flarm, OGNT, etc, ...',
  `dev_flyobj` mediumint(8) UNSIGNED NOT NULL COMMENT 'Plane on which this device is installed',
  `dev_userid` mediumint(8) UNSIGNED NOT NULL COMMENT 'User registering thise device',
  `dev_notrack` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'If device does not want to be tracked',
  `dev_noident` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'If device does not want to be identified',
  `dev_active` tinyint(1) DEFAULT '1' COMMENT 'A flag indicating if active or not in'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='All thr tracking devices in use';

-- --------------------------------------------------------

--
-- Table structure for table `devtypes`
--

CREATE TABLE `devtypes` (
  `dvt_id` tinyint(4) NOT NULL COMMENT 'Device type identifier',
  `dvt_name` varchar(8) NOT NULL COMMENT 'Device name, like Flarm, OGNT, SPOT',
  `dvt_code` varchar(1) NOT NULL COMMENT 'Code for compatibility',
  `dvt_3ltcode` varchar(3) NOT NULL COMMENT '3 Letter code for APRS messages',
  `dvt_idlen` smallint(2) NOT NULL DEFAULT '6' COMMENT 'Length of this type of ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The type of device Flarm, OGNT, SPOT';

-- --------------------------------------------------------

--
-- Table structure for table `tmpusers`
--

CREATE TABLE `tmpusers` (
  `tusr_adress` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tusr_pw` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `tusr_validation` varchar(128) CHARACTER SET utf16 COLLATE utf16_unicode_ci NOT NULL,
  `tusr_time` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trackedobjects`
--

CREATE TABLE `trackedobjects` (
  `air_id` mediumint(8) UNSIGNED NOT NULL COMMENT 'Internal ID',
  `air_actype` smallint(5) UNSIGNED NOT NULL COMMENT 'Link with AIrcraft type table',
  `air_acreg` varchar(7) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Aircraft registration, ex: EC-ACA',
  `air_accn` varchar(3) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Aircraft competition ID',
  `air_userid` mediumint(8) UNSIGNED NOT NULL COMMENT 'Link to user registering this aircraft',
  `air_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'A flag indicating if this plane is active or not',
  `air_SARphone` varchar(16) CHARACTER SET utf16 NOT NULL COMMENT 'Phone in case of SAR needs',
  `air_SARclub` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT 'Name of the club for aircraft',
  `air_Country` varchar(3) CHARACTER SET utf8 NOT NULL COMMENT 'Country of aircraft'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='All the aircraft tracked';

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `usr_id` mediumint(8) UNSIGNED NOT NULL COMMENT 'User ID (autoincremented)',
  `usr_adress` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User email address',
  `usr_pw` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Encrypted password'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aircraftstypes`
--
ALTER TABLE `aircraftstypes`
  ADD PRIMARY KEY (`ac_id`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`dev_id`,`dev_type`) USING BTREE,
  ADD KEY `dev_id` (`dev_id`) USING BTREE,
  ADD KEY `USERID` (`dev_userid`);

--
-- Indexes for table `devtypes`
--
ALTER TABLE `devtypes`
  ADD PRIMARY KEY (`dvt_id`);

--
-- Indexes for table `trackedobjects`
--
ALTER TABLE `trackedobjects`
  ADD PRIMARY KEY (`air_id`) USING BTREE COMMENT 'Primary key',
  ADD KEY `USERID` (`air_userid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`usr_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aircraftstypes`
--
ALTER TABLE `aircraftstypes`
  MODIFY `ac_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Acft ID (autoincremented)';

--
-- AUTO_INCREMENT for table `devtypes`
--
ALTER TABLE `devtypes`
  MODIFY `dvt_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Device type identifier';

--
-- AUTO_INCREMENT for table `trackedobjects`
--
ALTER TABLE `trackedobjects`
  MODIFY `air_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Internal ID';

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `usr_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'User ID (autoincremented)';
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;