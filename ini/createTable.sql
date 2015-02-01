-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 19, 2014 at 07:31 PM
-- Server version: 5.5.40-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `UFG`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE IF NOT EXISTS `address` (
  `address_id` int(11) NOT NULL DEFAULT '0',
  `number` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `coach`
--

CREATE TABLE IF NOT EXISTS `coach` (
  `coach_id` int(11) NOT NULL DEFAULT '0',
  `coach_name` varchar(255) DEFAULT NULL,
  `coach_address_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`coach_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `game`
--

CREATE TABLE IF NOT EXISTS `game` (
  `game_id` int(11) NOT NULL DEFAULT '0',
  `game_date` date DEFAULT NULL,
  `game_result` varchar(30) DEFAULT NULL,
  `home_id` int(11) DEFAULT NULL,
  `guest_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hold_at`
--

CREATE TABLE IF NOT EXISTS `hold_at` (
  `game_id` int(11) NOT NULL DEFAULT '0',
  `address_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`game_id`,`address_id`),
  KEY `address_id` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `live_at`
--

CREATE TABLE IF NOT EXISTS `live_at` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `address_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`address_id`),
  KEY `address_id` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `locate`
--

CREATE TABLE IF NOT EXISTS `locate` (
  `university_id` int(11) NOT NULL DEFAULT '0',
  `address_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`university_id`,`address_id`),
  KEY `address_id` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE IF NOT EXISTS `player` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `player_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `play_for`
--

CREATE TABLE IF NOT EXISTS `play_for` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `university_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`university_id`),
  KEY `university_id` (`university_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `university`
--

CREATE TABLE IF NOT EXISTS `university` (
  `university_id` int(11) NOT NULL DEFAULT '0',
  `university_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`university_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `work_for`
--

CREATE TABLE IF NOT EXISTS `work_for` (
  `coach_id` int(11) NOT NULL DEFAULT '0',
  `university_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`coach_id`,`university_id`),
  KEY `university_id` (`university_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `hold_at` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `coach`
--
ALTER TABLE `coach`
  ADD CONSTRAINT `coach_ibfk_1` FOREIGN KEY (`coach_id`) REFERENCES `work_for` (`coach_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `game_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `hold_at` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hold_at`
--
ALTER TABLE `hold_at`
  ADD CONSTRAINT `hold_at_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hold_at_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `live_at`
--
ALTER TABLE `live_at`
  ADD CONSTRAINT `live_at_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `live_at_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `locate`
--
ALTER TABLE `locate`
  ADD CONSTRAINT `locate_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `locate_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `player`
--
ALTER TABLE `player`
  ADD CONSTRAINT `player_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `play_for` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `play_for`
--
ALTER TABLE `play_for`
  ADD CONSTRAINT `play_for_ibfk_2` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `play_for_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `university`
--
ALTER TABLE `university`
  ADD CONSTRAINT `university_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `work_for` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `work_for`
--
ALTER TABLE `work_for`
  ADD CONSTRAINT `work_for_ibfk_2` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `work_for_ibfk_1` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`coach_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
