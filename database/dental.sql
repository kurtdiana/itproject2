-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 26, 2019 at 10:13 AM
-- Server version: 5.7.21-log
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dental`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `accountID` int(5) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) NOT NULL,
  `account_password` varchar(255) NOT NULL,
  `registration_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `empID` int(5) NOT NULL,
  PRIMARY KEY (`accountID`),
  UNIQUE KEY `account_name` (`account_name`),
  KEY `empID` (`empID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`accountID`, `account_name`, `account_password`, `registration_date`, `empID`) VALUES
(1, 'dentist1', '123123', '2019-02-26 08:44:30', 1);

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
CREATE TABLE IF NOT EXISTS `appointment` (
  `appointmentID` int(255) NOT NULL,
  `appointmentDate` date NOT NULL,
  `appointment_timeLength` varchar(255) NOT NULL,
  `appointment_status` enum('Pending','Done','Cancelled','Moved') NOT NULL,
  `patientID` int(255) NOT NULL,
  `empID` int(255) NOT NULL,
  `treatmentID` int(255) NOT NULL,
  PRIMARY KEY (`appointmentID`),
  KEY `appointmentfk1` (`patientID`),
  KEY `appointmentfk2` (`empID`),
  KEY `appointmentfk3` (`treatmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointmentID`, `appointmentDate`, `appointment_timeLength`, `appointment_status`, `patientID`, `empID`, `treatmentID`) VALUES
(1, '2019-02-27', '1 hour', 'Pending', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `apptre`
--

DROP TABLE IF EXISTS `apptre`;
CREATE TABLE IF NOT EXISTS `apptre` (
  `appointmentID` int(255) NOT NULL,
  `treatmentID` int(255) NOT NULL,
  `treatCost` double NOT NULL,
  `appointmentTime` time NOT NULL,
  KEY `apptre1` (`appointmentID`),
  KEY `apptre2` (`treatmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `apptre`
--

INSERT INTO `apptre` (`appointmentID`, `treatmentID`, `treatCost`, `appointmentTime`) VALUES
(1, 1, 500, '10:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `balance`
--

DROP TABLE IF EXISTS `balance`;
CREATE TABLE IF NOT EXISTS `balance` (
  `balanceID` int(11) NOT NULL,
  `bal_amnt` double NOT NULL,
  `bal_date` date NOT NULL,
  PRIMARY KEY (`balanceID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `balance`
--

INSERT INTO `balance` (`balanceID`, `bal_amnt`, `bal_date`) VALUES
(1, 1000, '2019-02-13');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `empID` int(5) NOT NULL,
  `emp_name` varchar(255) NOT NULL,
  `emp_address` varchar(255) NOT NULL,
  `accountID` int(5) NOT NULL,
  PRIMARY KEY (`empID`),
  KEY `accountID` (`accountID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`empID`, `emp_name`, `emp_address`, `accountID`) VALUES
(1, 'Kurt Diana', 'Bakakeng Phase 1 Baguio City', 1);

-- --------------------------------------------------------

--
-- Table structure for table `medical record`
--

DROP TABLE IF EXISTS `medical record`;
CREATE TABLE IF NOT EXISTS `medical record` (
  `med_recordID` int(11) NOT NULL,
  `date` date NOT NULL,
  `patientID` int(11) NOT NULL,
  `treatmentID` int(11) NOT NULL,
  PRIMARY KEY (`med_recordID`),
  KEY `medrecfk1` (`patientID`),
  KEY `medrecfk2` (`treatmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medical record`
--

INSERT INTO `medical record` (`med_recordID`, `date`, `patientID`, `treatmentID`) VALUES
(1, '2019-02-27', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `medtre`
--

DROP TABLE IF EXISTS `medtre`;
CREATE TABLE IF NOT EXISTS `medtre` (
  `med_recordID` int(11) NOT NULL,
  `treatmentID` int(11) NOT NULL,
  `treat_description` varchar(255) NOT NULL,
  KEY `medtrefk1` (`med_recordID`),
  KEY `medtrefk2` (`treatmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medtre`
--

INSERT INTO `medtre` (`med_recordID`, `treatmentID`, `treat_description`) VALUES
(1, 1, 'Sample description.');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `patientID` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  `pat_contno` varchar(255) NOT NULL,
  `pat_address` varchar(255) NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  PRIMARY KEY (`patientID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patientID`, `first_name`, `last_name`, `birthday`, `pat_contno`, `pat_address`, `sex`) VALUES
(1, 'Derwin', 'Torres', '1998-02-21', '09774245853', 'Bakakeng Phase 2', 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `payID` int(255) NOT NULL,
  `payDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `payamnt` double NOT NULL,
  `appointmentID` int(255) NOT NULL,
  `balanceID` int(255) NOT NULL,
  PRIMARY KEY (`payID`),
  KEY `payfk1` (`appointmentID`),
  KEY `payfk2` (`balanceID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payID`, `payDate`, `payamnt`, `appointmentID`, `balanceID`) VALUES
(1, '2019-02-26 10:07:54', 500, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
CREATE TABLE IF NOT EXISTS `treatment` (
  `treatmentID` int(11) NOT NULL,
  `treatment_name` varchar(255) NOT NULL,
  `treatMin_cost` double NOT NULL,
  `treat_timeLength` varchar(255) NOT NULL,
  PRIMARY KEY (`treatmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `treatment`
--

INSERT INTO `treatment` (`treatmentID`, `treatment_name`, `treatMin_cost`, `treat_timeLength`) VALUES
(1, 'Root Canal', 1000, '1 hour');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`empID`) REFERENCES `employee` (`empID`);

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointmentfk1` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`),
  ADD CONSTRAINT `appointmentfk2` FOREIGN KEY (`empID`) REFERENCES `employee` (`empID`),
  ADD CONSTRAINT `appointmentfk3` FOREIGN KEY (`treatmentID`) REFERENCES `treatment` (`treatmentID`);

--
-- Constraints for table `apptre`
--
ALTER TABLE `apptre`
  ADD CONSTRAINT `apptre1` FOREIGN KEY (`appointmentID`) REFERENCES `appointment` (`appointmentID`),
  ADD CONSTRAINT `apptre2` FOREIGN KEY (`treatmentID`) REFERENCES `treatment` (`treatmentID`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`accountID`) REFERENCES `account` (`accountID`);

--
-- Constraints for table `medical record`
--
ALTER TABLE `medical record`
  ADD CONSTRAINT `medrecfk1` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`),
  ADD CONSTRAINT `medrecfk2` FOREIGN KEY (`treatmentID`) REFERENCES `treatment` (`treatmentID`);

--
-- Constraints for table `medtre`
--
ALTER TABLE `medtre`
  ADD CONSTRAINT `medtrefk1` FOREIGN KEY (`med_recordID`) REFERENCES `medical record` (`med_recordID`),
  ADD CONSTRAINT `medtrefk2` FOREIGN KEY (`treatmentID`) REFERENCES `treatment` (`treatmentID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payfk1` FOREIGN KEY (`appointmentID`) REFERENCES `appointment` (`appointmentID`),
  ADD CONSTRAINT `payfk2` FOREIGN KEY (`balanceID`) REFERENCES `balance` (`balanceID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
