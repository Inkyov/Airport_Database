-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 14, 2015 at 03:24 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mki130`
--

-- --------------------------------------------------------

--
-- Table structure for table `airlines`
--

CREATE TABLE IF NOT EXISTS `airlines` (
  `Airline_ID` char(11) NOT NULL,
  `Airline_Name` varchar(45) NOT NULL,
  `Airline_Origin` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Airline_ID`),
  UNIQUE KEY `Airline_ID` (`Airline_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `airlines`
--

INSERT INTO `airlines` (`Airline_ID`, `Airline_Name`, `Airline_Origin`) VALUES
('AF', 'Air France', 'France'),
('AZ', 'Alitalia', 'Italy'),
('BA', 'Bulgaria Air', 'Bulgaria'),
('IB', 'Iberia', 'Spain'),
('KLM', 'KLM', 'Netherlands'),
('LF', 'Lufthansa', 'Germany');

-- --------------------------------------------------------

--
-- Table structure for table `airline_contracts`
--

CREATE TABLE IF NOT EXISTS `airline_contracts` (
  `Terminal_ID` char(11) NOT NULL,
  `Airline_ID` char(11) NOT NULL,
  `Contract_Start_Date` date DEFAULT NULL,
  `Contract_Expiration_Date` date DEFAULT NULL,
  PRIMARY KEY (`Terminal_ID`,`Airline_ID`),
  KEY `fk_Terminals_has_Airlines_Terminals1_idx` (`Terminal_ID`),
  KEY `fk_Terminals_has_Airlines_Airlines1_idx` (`Airline_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `airline_contracts`
--

INSERT INTO `airline_contracts` (`Terminal_ID`, `Airline_ID`, `Contract_Start_Date`, `Contract_Expiration_Date`) VALUES
('T01', 'AF', '2010-01-01', '2015-12-31'),
('T01', 'BA', '2015-12-01', '2020-12-31'),
('T01', 'KLM', '2005-12-16', '2020-01-01'),
('T02', 'AZ', '2000-01-01', '2025-03-01'),
('T02', 'IB', '2006-05-01', '2026-05-01'),
('T02', 'LF', '2003-04-20', '2030-12-31');

-- --------------------------------------------------------

--
-- Table structure for table `airline_employees`
--

CREATE TABLE IF NOT EXISTS `airline_employees` (
  `Airline_ID` char(11) NOT NULL,
  `Staff_ID` char(11) NOT NULL,
  `Start_Date` date DEFAULT NULL,
  `End_Date` date DEFAULT NULL,
  PRIMARY KEY (`Airline_ID`,`Staff_ID`),
  KEY `fk_Airlines_has_Staff_Staff1_idx` (`Staff_ID`),
  KEY `fk_Airlines_has_Staff_Airlines1_idx` (`Airline_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `airline_employees`
--

INSERT INTO `airline_employees` (`Airline_ID`, `Staff_ID`, `Start_Date`, `End_Date`) VALUES
('BA', '100024067', '2012-01-01', NULL),
('KLM', '100096431', '2015-06-10', NULL),
('LF', '100085647', '1985-01-01', '2016-01-20');

-- --------------------------------------------------------

--
-- Table structure for table `airline_orders`
--

CREATE TABLE IF NOT EXISTS `airline_orders` (
  `Order_ID` char(11) NOT NULL,
  `Airline_ID` char(11) NOT NULL,
  `Item_ID` char(11) NOT NULL,
  `Supplier_ID` char(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`Order_ID`,`Airline_ID`,`Item_ID`,`Supplier_ID`),
  KEY `fk_Airlines_has_Items_Items1_idx` (`Item_ID`),
  KEY `fk_Airlines_has_Items_Airlines1_idx` (`Airline_ID`),
  KEY `Airlines_Supplier_idx` (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `airline_orders`
--

INSERT INTO `airline_orders` (`Order_ID`, `Airline_ID`, `Item_ID`, `Supplier_ID`, `Quantity`) VALUES
('1', 'AF', 'I00001', '111', 100),
('1', 'BA', 'I00001', '111', 150),
('1', 'KLM', 'I00004', '123', 300),
('2', 'AF', 'I00002', '111', 90),
('2', 'BA', 'I00012', '391', 12000),
('2', 'KLM', 'I00003', '111', 50),
('3', 'KLM', 'I00006', '123', 350);

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE IF NOT EXISTS `flights` (
  `Flight_ID` char(11) NOT NULL,
  `Airline_ID` char(11) NOT NULL,
  `Plane_ID` char(6) NOT NULL,
  `Flight_From` varchar(45) DEFAULT NULL,
  `Flight_To` varchar(45) DEFAULT NULL,
  `Flight_DepartureTime` datetime DEFAULT NULL,
  `Flight_ArrivalTime` datetime DEFAULT NULL,
  `Terminal_ID` char(11) NOT NULL,
  `Gate_ID` char(3) NOT NULL,
  PRIMARY KEY (`Flight_ID`,`Airline_ID`,`Plane_ID`,`Terminal_ID`,`Gate_ID`),
  KEY `fk_Flights_Planes1_idx` (`Plane_ID`),
  KEY `fk_Flights_Airlines1_idx` (`Airline_ID`),
  KEY `Terminal_idx` (`Terminal_ID`),
  KEY `fk_Flights_Gates1_idx` (`Gate_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`Flight_ID`, `Airline_ID`, `Plane_ID`, `Flight_From`, `Flight_To`, `Flight_DepartureTime`, `Flight_ArrivalTime`, `Terminal_ID`, `Gate_ID`) VALUES
('AF0001', 'AF', '157351', 'Sofia', 'Paris', '2015-10-01 13:00:00', '2015-10-01 15:30:00', 'T02', 'A2'),
('AZ0001', 'AZ', '157869', 'Sofia', 'Rome', '2015-12-01 15:30:00', '2015-12-01 17:45:00', 'T01', 'A2'),
('IB0001', 'IB', '472102', 'Sofia', 'Madrid', '2015-12-20 13:20:00', '2015-12-20 15:50:00', 'T02', 'A1'),
('KLM0001', 'KLM', '391268', 'Sofia', 'Eindhoven', '2015-12-12 10:00:00', '2015-12-12 12:40:00', 'T02', 'B2'),
('LF0001', 'LF', '472228', 'Sofia', 'Berlin', '2015-12-10 16:23:00', '2015-12-10 19:40:00', 'T01', 'A2');

-- --------------------------------------------------------

--
-- Table structure for table `gates`
--

CREATE TABLE IF NOT EXISTS `gates` (
  `Gate_ID` char(3) NOT NULL,
  `Terminal_ID` char(11) NOT NULL,
  PRIMARY KEY (`Gate_ID`,`Terminal_ID`),
  KEY `fk_Gates_Terminals1` (`Terminal_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gates`
--

INSERT INTO `gates` (`Gate_ID`, `Terminal_ID`) VALUES
('A1', 'T01'),
('A2', 'T01'),
('B1', 'T01'),
('C1', 'T01'),
('A1', 'T02'),
('A2', 'T02'),
('B2', 'T02');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `Item_ID` char(11) NOT NULL,
  `Item_Name` varchar(30) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Item_Price` double DEFAULT NULL,
  `Supplier_ID` char(11) NOT NULL,
  PRIMARY KEY (`Item_ID`,`Supplier_ID`),
  KEY `fk_Items_Company1_idx` (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`Item_ID`, `Item_Name`, `Quantity`, `Item_Price`, `Supplier_ID`) VALUES
('I00001', 'Coca-Cola', 10000, 1, '111'),
('I00002', 'Sprite', 5000, 1.5, '111'),
('I00003', 'Fanta', 3500, 1.5, '111'),
('I00004', 'Frutelli', 4000, 2, '123'),
('I00005', 'Devin Spring small', 6000, 0.5, '123'),
('I00006', 'Devin Spring big', 6000, 0.5, '123'),
('I00007', 'Devin Mineral small', 6000, 0.5, '123'),
('I00008', 'Devin Mineral big', 6000, 0.5, '123'),
('I00009', 'Coffee Mate', 2000, 0.4, '550'),
('I00010', 'Kit-Kat', 1500, 0.9, '550'),
('I00011', 'Nescafe', 7000, 0.6, '550'),
('I00012', 'Kerosene', 100000, 3.5, '391'),
('I00013', 'Salmon', 500, 2, '920');

-- --------------------------------------------------------

--
-- Table structure for table `planes`
--

CREATE TABLE IF NOT EXISTS `planes` (
  `Plane_ID` char(6) NOT NULL,
  `Plane_Model` varchar(20) DEFAULT NULL,
  `Plane_Capacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`Plane_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `planes`
--

INSERT INTO `planes` (`Plane_ID`, `Plane_Model`, `Plane_Capacity`) VALUES
('157351', 'Boeing 747-8', 362),
('157869', 'Boeing 747-400', 512),
('157964', 'Boeing 737-300', 122),
('391268', 'Embraer E-195', 112),
('391429', 'Embraer E-190', 100),
('472102', 'Airbus A330-300', 400),
('472228', 'Airbus A330-600', 306),
('472301', 'Airbus A330-800', 509);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `Project_ID` char(11) NOT NULL,
  `Project_Name` varchar(30) NOT NULL,
  `Start_Date` date DEFAULT NULL,
  `End_Date` date DEFAULT NULL,
  PRIMARY KEY (`Project_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`Project_ID`, `Project_Name`, `Start_Date`, `End_Date`) VALUES
('P01', 'Security Checks', '2015-12-09', '2015-12-11'),
('P02', 'Supplies Check', '2015-12-16', '2015-12-18'),
('P03', 'Flight Checks', '2015-12-03', '2016-01-09'),
('P04', 'Item Check', '2015-12-09', '2015-12-16');

-- --------------------------------------------------------

--
-- Table structure for table `project_employees`
--

CREATE TABLE IF NOT EXISTS `project_employees` (
  `Project_ID` char(11) NOT NULL,
  `Staff_ID` char(11) NOT NULL,
  `Start_Date` date DEFAULT NULL,
  `End_Date` date DEFAULT NULL,
  PRIMARY KEY (`Project_ID`,`Staff_ID`),
  KEY `fk_Projects_has_Staff_Staff1_idx` (`Staff_ID`),
  KEY `fk_Projects_has_Staff_Projects1_idx` (`Project_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_employees`
--

INSERT INTO `project_employees` (`Project_ID`, `Staff_ID`, `Start_Date`, `End_Date`) VALUES
('P01', '100047152', '2015-12-14', '2015-12-15'),
('P02', '100078456', '2015-12-22', '2015-12-24'),
('P02', '100096296', '2015-12-16', '2015-12-18'),
('P03', '100004672', '2015-12-03', '2016-01-09'),
('P03', '100012494', '2015-12-28', '2016-01-09'),
('P04', '100072046', '2015-12-09', '2016-12-16');

-- --------------------------------------------------------

--
-- Table structure for table `project_execution`
--

CREATE TABLE IF NOT EXISTS `project_execution` (
  `Terminal_ID` char(11) NOT NULL,
  `Project_ID` char(11) NOT NULL,
  `Start_Date` date DEFAULT NULL,
  `End_Date` date DEFAULT NULL,
  PRIMARY KEY (`Terminal_ID`,`Project_ID`),
  KEY `fk_Terminals_has_Projects_Projects1_idx` (`Project_ID`),
  KEY `fk_Terminals_has_Projects_Terminals1_idx` (`Terminal_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_execution`
--

INSERT INTO `project_execution` (`Terminal_ID`, `Project_ID`, `Start_Date`, `End_Date`) VALUES
('T01', 'P01', '2015-12-09', '2015-12-14'),
('T01', 'P02', '2015-12-16', '2015-12-20'),
('T02', 'P02', '2015-12-16', '2015-12-18');

-- --------------------------------------------------------

--
-- Table structure for table `restaurants`
--

CREATE TABLE IF NOT EXISTS `restaurants` (
  `Restaurant_ID` char(11) NOT NULL,
  `Restaurant_Name` varchar(45) NOT NULL,
  `Restaurant_Phone` varchar(17) DEFAULT NULL,
  `Terminal_ID` char(11) NOT NULL,
  `Gate_ID` char(3) NOT NULL,
  PRIMARY KEY (`Restaurant_ID`,`Terminal_ID`,`Gate_ID`),
  KEY `fk_Restaurants_Gates1_idx` (`Gate_ID`),
  KEY `Restaurants_Terminal` (`Terminal_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `restaurants`
--

INSERT INTO `restaurants` (`Restaurant_ID`, `Restaurant_Name`, `Restaurant_Phone`, `Terminal_ID`, `Gate_ID`) VALUES
('BKing1093', 'Burger King', '+359 884 56 12 34', 'T01', 'A1'),
('NS142', 'Nordsee', '+359 875 20 71 29', 'T02', 'C1'),
('STB123', 'Starbucks', '+359 887 34 98 10', 'T01', 'A2'),
('SWay40', 'Subway', '+359 885 44 85 64', 'T02', 'A1'),
('TT134', 'Tasty Thai', '+359 884 31 24 56', 'T02', 'A1'),
('WD23', 'Wendy''s', '+359 886 24 57 84', 'T02', 'A2');

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_contracts`
--

CREATE TABLE IF NOT EXISTS `restaurant_contracts` (
  `Terminal_ID` char(11) NOT NULL,
  `Restaurant_ID` char(11) NOT NULL,
  `Contract_Start_Date` date DEFAULT NULL,
  `Contract_End_Date` date DEFAULT NULL,
  PRIMARY KEY (`Terminal_ID`,`Restaurant_ID`),
  KEY `fk_Terminals_has_Restaurants_Restaurants1_idx` (`Restaurant_ID`),
  KEY `fk_Terminals_has_Restaurants_Terminals1_idx` (`Terminal_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `restaurant_contracts`
--

INSERT INTO `restaurant_contracts` (`Terminal_ID`, `Restaurant_ID`, `Contract_Start_Date`, `Contract_End_Date`) VALUES
('T01', 'BKing1093', '2016-01-01', '2017-01-01'),
('T01', 'STB123', '2016-01-01', '2020-01-01');

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_employees`
--

CREATE TABLE IF NOT EXISTS `restaurant_employees` (
  `Restaurant_ID` char(11) NOT NULL,
  `Staff_ID` char(11) NOT NULL,
  `Start_Date` date DEFAULT NULL,
  `End_Date` date DEFAULT NULL,
  PRIMARY KEY (`Restaurant_ID`,`Staff_ID`),
  KEY `fk_Restaurants_has_Staff_Staff1_idx` (`Staff_ID`),
  KEY `fk_Restaurants_has_Staff_Restaurants1_idx` (`Restaurant_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `restaurant_employees`
--

INSERT INTO `restaurant_employees` (`Restaurant_ID`, `Staff_ID`, `Start_Date`, `End_Date`) VALUES
('BKing1093', '100052787', '2015-10-01', NULL),
('BKing1093', '100074145', '2013-05-23', '2014-09-11'),
('STB123', '100094142', '2012-09-15', '2013-10-25'),
('SWay40', '100074568', '2015-12-06', NULL),
('TT134', '100078456', '2015-12-14', NULL),
('WD23', '100085647', '2015-12-22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_orders`
--

CREATE TABLE IF NOT EXISTS `restaurant_orders` (
  `Order_ID` char(11) NOT NULL,
  `Restaurant_ID` char(11) NOT NULL,
  `Item_ID` char(11) NOT NULL,
  `Supplier_ID` char(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`Order_ID`,`Restaurant_ID`,`Item_ID`,`Supplier_ID`),
  KEY `fk_Restaurants_has_Items_Items1_idx` (`Item_ID`),
  KEY `fk_Restaurants_has_Items_Restaurants1_idx` (`Restaurant_ID`),
  KEY `Restaurants_Supplier_idx` (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `restaurant_orders`
--

INSERT INTO `restaurant_orders` (`Order_ID`, `Restaurant_ID`, `Item_ID`, `Supplier_ID`, `Quantity`) VALUES
('1', 'BKing1093', 'I00001', '111', 250),
('1', 'NS142', 'I00013', '920', 222),
('1', 'STB123', 'I00003', '111', 500),
('1', 'SWay40', 'I00011', '550', 1000),
('1', 'TT134', 'I00005', '123', 400),
('2', 'BKing1093', 'I00002', '111', 120),
('2', 'NS142', 'I00001', '111', 160),
('2', 'STB123', 'I00010', '550', 80);

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE IF NOT EXISTS `shops` (
  `Shop_ID` char(8) NOT NULL,
  `Shop_Name` varchar(45) NOT NULL,
  `Shop_Phone` varchar(17) DEFAULT NULL,
  `Terminal_ID` char(11) NOT NULL,
  `Gate_ID` char(3) NOT NULL,
  PRIMARY KEY (`Shop_ID`,`Terminal_ID`,`Gate_ID`),
  KEY `fk_Shops_Gates1_idx` (`Gate_ID`),
  KEY `terminal_idx` (`Terminal_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`Shop_ID`, `Shop_Name`, `Shop_Phone`, `Terminal_ID`, `Gate_ID`) VALUES
('Shop0001', 'Discover France', '+359 883 45 72 68', 'T01', 'A1'),
('Shop0002', 'The Flowers''s Shop', '+359 886 12 31 57', 'T01', 'A1'),
('Shop0003', 'Swarovski', '+359 886 42 59 61', 'T01', 'A1'),
('Shop0004', 'Swarovski', '+359 886 42 59 62', 'T01', 'A2'),
('Shop0005', 'Swarovski', '+359 886 42 59 63', 'T01', 'B1'),
('Shop0006', 'Apple', '+359 889 01 52 70', 'T02', 'A2'),
('Shop0007', 'Louis Vuitton', '+359 878 20 33 75', 'T02', 'A1'),
('Shop0008', 'Lindt', '+359 878 99 68 31', 'T02', 'A1'),
('Shop0009', 'Souvenirs', '+359 895 24 19 80', 'T02', 'A2');

-- --------------------------------------------------------

--
-- Table structure for table `shop_contracts`
--

CREATE TABLE IF NOT EXISTS `shop_contracts` (
  `Terminal_ID` char(11) NOT NULL,
  `Shop_ID` char(8) NOT NULL,
  `Contract_Start_Date` date DEFAULT NULL,
  `Contract_Expiration_Date` date DEFAULT NULL,
  PRIMARY KEY (`Terminal_ID`,`Shop_ID`),
  KEY `fk_Terminals_has_Shops_Shops1_idx` (`Shop_ID`),
  KEY `fk_Terminals_has_Shops_Terminals1_idx` (`Terminal_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shop_contracts`
--

INSERT INTO `shop_contracts` (`Terminal_ID`, `Shop_ID`, `Contract_Start_Date`, `Contract_Expiration_Date`) VALUES
('T01', 'Shop0001', '2015-11-08', NULL),
('T01', 'Shop0002', '2015-11-09', NULL),
('T01', 'Shop0006', '2004-12-01', '2015-12-01'),
('T02', 'Shop0003', '2005-12-31', '2015-12-31'),
('T02', 'Shop0004', '2015-11-08', '2016-10-08'),
('T02', 'Shop0005', '2015-11-11', '2016-11-11');

-- --------------------------------------------------------

--
-- Table structure for table `shop_employees`
--

CREATE TABLE IF NOT EXISTS `shop_employees` (
  `Shop_ID` char(8) NOT NULL,
  `Staff_ID` char(11) NOT NULL,
  `Start_Date` date DEFAULT NULL,
  `End_Date` date DEFAULT NULL,
  PRIMARY KEY (`Shop_ID`,`Staff_ID`),
  KEY `fk_Shops_has_Staff_Staff1_idx` (`Staff_ID`),
  KEY `fk_Shops_has_Staff_Shops1_idx` (`Shop_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shop_employees`
--

INSERT INTO `shop_employees` (`Shop_ID`, `Staff_ID`, `Start_Date`, `End_Date`) VALUES
('Shop0001', '100019840', '2010-11-01', '2015-11-01'),
('Shop0002', '100074145', '2015-11-11', '2016-04-04'),
('Shop0007', '100043912', '2013-04-01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `shop_orders`
--

CREATE TABLE IF NOT EXISTS `shop_orders` (
  `Order_ID` char(11) NOT NULL,
  `Shop_ID` char(8) NOT NULL,
  `Item_ID` char(11) NOT NULL,
  `Supplier_ID` char(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`Order_ID`,`Shop_ID`,`Item_ID`,`Supplier_ID`),
  KEY `fk_Shops_has_Items_Items1_idx` (`Item_ID`),
  KEY `fk_Shops_has_Items_Shops1_idx` (`Shop_ID`),
  KEY `Shops_Supplier_idx` (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shop_orders`
--

INSERT INTO `shop_orders` (`Order_ID`, `Shop_ID`, `Item_ID`, `Supplier_ID`, `Quantity`) VALUES
('1', 'Shop0001', 'I00001', '111', 50),
('1', 'Shop0002', 'I00002', '111', 10),
('1', 'Shop0005', 'I00005', '123', 124),
('2', 'Shop0005', 'I00004', '123', 100);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE IF NOT EXISTS `staff` (
  `Staff_ID` char(11) NOT NULL,
  `Staff_FName` varchar(30) DEFAULT NULL,
  `Staff_LName` varchar(30) NOT NULL,
  `Staff_Phone` varchar(17) DEFAULT NULL,
  `Staff_Address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Staff_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Staff_Phone`, `Staff_Address`) VALUES
('100004672', 'Mario', 'Gonzalez', '+359 874 03 08 15', '54 Mandrake Str.'),
('100012494', 'Philip', 'Simeonov', '+359 884 12 57 63', '94 Egund Str.'),
('100019840', 'Stanislava', 'Stoimenova', '+359 883 17 09 64', '34 Jey Str.'),
('100024067', 'Aleksiya', 'Trifonova', '+359 875 12 30 06', '31 St. Ivan Str.'),
('100043912', 'Gergana', 'Valeva', '+359 884 05 19 75', '43 Brum Str,'),
('100047152', 'Georgi', 'Georgiev', '+359 882 11 11 11', '1 Data Str'),
('100052787', 'Neo', 'Dobev', '+359 892 43 15 82', '21 Lazlo Str.'),
('100072046', 'Greta', 'Nikolova', '+359 881 64 20 08', '77 Patrik Str.'),
('100074145', 'Dimitar', 'Dimitrov', '+359 883 12 23 34', '2 Test Str'),
('100074568', 'Ivan', 'Ivanov', '+359 882 34 45 54', '3 Example Str'),
('100078456', 'Teodor', 'Ivanov', '+359 884 45 97 84', '4 Huff Str'),
('100085647', 'Dobromir', 'Todorov', '+359 885 24 15 67', '23 Strom Str'),
('100094142', 'Aleksandra', 'Hristova', '+359 886 24 78 91', '42 Spec Str'),
('100096296', 'Gergana', 'Sokolova', '+359 889 39 51 24', '14 Proc Str'),
('100096431', 'Petar', 'Stoev', '+359 881 70 24 68', '52 Noemi Str.');

-- --------------------------------------------------------

--
-- Table structure for table `staff_type`
--

CREATE TABLE IF NOT EXISTS `staff_type` (
  `Staff_ID` char(11) NOT NULL,
  `Staff_Type` varchar(45) NOT NULL,
  PRIMARY KEY (`Staff_ID`,`Staff_Type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff_type`
--

INSERT INTO `staff_type` (`Staff_ID`, `Staff_Type`) VALUES
('100004672', 'Consultant'),
('100012494', 'Consultant'),
('100019840', 'Cashier'),
('100024067', 'Air Hostess'),
('100043912', 'Manager'),
('100047152', 'Consultant'),
('100052787', 'Waiter'),
('100072046', 'Consultant'),
('100074145', 'Cashier'),
('100074568', 'Waiter'),
('100078456', 'Consultant'),
('100085647', 'Captain'),
('100094142', 'Cook'),
('100096296', 'Consultant'),
('100096431', 'Air Host');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE IF NOT EXISTS `suppliers` (
  `Supplier_ID` char(11) NOT NULL,
  `Supplier_Name` varchar(45) DEFAULT NULL,
  `Supplier_Phone` varchar(17) DEFAULT NULL,
  `Supplier_Address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`Supplier_ID`, `Supplier_Name`, `Supplier_Phone`, `Supplier_Address`) VALUES
('111', 'Coca-Cola', '+359 887 45 21 68', '22 Somerville Str'),
('123', 'Devin', '+359 888 24 03 71', '32 San Stefanon Str.'),
('345', 'Crumbs', '+359 895 12 35 40', '68 Stat Str.'),
('391', 'AUBG Oils', '+359 884 02 37 13', '65 Traner Str.'),
('550', 'Nestle', '+359 887 695 635', '12 Tsar Boris'),
('920', 'Fishy''s', '+359 878 01 39 61', '13 Trus Str.');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_type`
--

CREATE TABLE IF NOT EXISTS `supplier_type` (
  `Supplier_Type` varchar(45) NOT NULL,
  `Supplier_ID` char(11) NOT NULL,
  PRIMARY KEY (`Supplier_ID`,`Supplier_Type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplier_type`
--

INSERT INTO `supplier_type` (`Supplier_Type`, `Supplier_ID`) VALUES
('Beverages', '111'),
('Beverages', '123'),
('Bread', '345'),
('Fuel', '391'),
('Food and Beverages', '550'),
('Sea food', '920');

-- --------------------------------------------------------

--
-- Table structure for table `terminals`
--

CREATE TABLE IF NOT EXISTS `terminals` (
  `Terminal_ID` char(11) NOT NULL,
  `Terminal_Name` varchar(20) DEFAULT NULL,
  `Terminal_Type` varchar(20) DEFAULT NULL,
  `Terminal_Location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Terminal_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `terminals`
--

INSERT INTO `terminals` (`Terminal_ID`, `Terminal_Name`, `Terminal_Type`, `Terminal_Location`) VALUES
('T01', 'Terminal 1', 'Domestic', 'Sofia'),
('T02', 'Terminal 2', 'International', 'Sofia');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `airline_contracts`
--
ALTER TABLE `airline_contracts`
  ADD CONSTRAINT `fk_Terminals_has_Airlines_Terminals1` FOREIGN KEY (`Terminal_ID`) REFERENCES `terminals` (`Terminal_ID`),
  ADD CONSTRAINT `fk_Terminals_has_Airlines_Airlines1` FOREIGN KEY (`Airline_ID`) REFERENCES `airlines` (`Airline_ID`);

--
-- Constraints for table `airline_employees`
--
ALTER TABLE `airline_employees`
  ADD CONSTRAINT `airline_employees_ibfk_2` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`),
  ADD CONSTRAINT `airline_employees_ibfk_1` FOREIGN KEY (`Airline_ID`) REFERENCES `airlines` (`Airline_ID`);

--
-- Constraints for table `airline_orders`
--
ALTER TABLE `airline_orders`
  ADD CONSTRAINT `airline_orders_ibfk_1` FOREIGN KEY (`Supplier_ID`) REFERENCES `suppliers` (`Supplier_ID`),
  ADD CONSTRAINT `fk_Airlines_has_Items_Airlines1` FOREIGN KEY (`Airline_ID`) REFERENCES `airlines` (`Airline_ID`),
  ADD CONSTRAINT `fk_Airlines_has_Items_Items1` FOREIGN KEY (`Item_ID`) REFERENCES `items` (`Item_ID`);

--
-- Constraints for table `flights`
--
ALTER TABLE `flights`
  ADD CONSTRAINT `fk_Flights_Airlines1` FOREIGN KEY (`Airline_ID`) REFERENCES `airlines` (`Airline_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Flights_Gates1` FOREIGN KEY (`Gate_ID`) REFERENCES `gates` (`Gate_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Flights_Planes1` FOREIGN KEY (`Plane_ID`) REFERENCES `planes` (`Plane_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Flights_Terminal` FOREIGN KEY (`Terminal_ID`) REFERENCES `terminals` (`Terminal_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `gates`
--
ALTER TABLE `gates`
  ADD CONSTRAINT `fk_Gates_Terminals1` FOREIGN KEY (`Terminal_ID`) REFERENCES `terminals` (`Terminal_ID`);

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`Supplier_ID`) REFERENCES `suppliers` (`Supplier_ID`);

--
-- Constraints for table `project_employees`
--
ALTER TABLE `project_employees`
  ADD CONSTRAINT `project_employees_ibfk_1` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`),
  ADD CONSTRAINT `fk_Projects_has_Staff_Projects1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`Project_ID`);

--
-- Constraints for table `project_execution`
--
ALTER TABLE `project_execution`
  ADD CONSTRAINT `fk_Terminals_has_Projects_Terminals1` FOREIGN KEY (`Terminal_ID`) REFERENCES `terminals` (`Terminal_ID`),
  ADD CONSTRAINT `fk_Terminals_has_Projects_Projects1` FOREIGN KEY (`Project_ID`) REFERENCES `projects` (`Project_ID`);

--
-- Constraints for table `restaurants`
--
ALTER TABLE `restaurants`
  ADD CONSTRAINT `fk_Restaurants_Gates1` FOREIGN KEY (`Gate_ID`) REFERENCES `gates` (`Gate_ID`),
  ADD CONSTRAINT `Restaurants_Terminal` FOREIGN KEY (`Terminal_ID`) REFERENCES `terminals` (`Terminal_ID`);

--
-- Constraints for table `restaurant_contracts`
--
ALTER TABLE `restaurant_contracts`
  ADD CONSTRAINT `fk_Terminals_has_Restaurants_Terminals1` FOREIGN KEY (`Terminal_ID`) REFERENCES `terminals` (`Terminal_ID`),
  ADD CONSTRAINT `fk_Terminals_has_Restaurants_Restaurants1` FOREIGN KEY (`Restaurant_ID`) REFERENCES `restaurants` (`Restaurant_ID`);

--
-- Constraints for table `restaurant_employees`
--
ALTER TABLE `restaurant_employees`
  ADD CONSTRAINT `restaurant_employees_ibfk_1` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`),
  ADD CONSTRAINT `fk_Restaurants_has_Staff_Restaurants1` FOREIGN KEY (`Restaurant_ID`) REFERENCES `restaurants` (`Restaurant_ID`);

--
-- Constraints for table `restaurant_orders`
--
ALTER TABLE `restaurant_orders`
  ADD CONSTRAINT `restaurant_orders_ibfk_1` FOREIGN KEY (`Supplier_ID`) REFERENCES `suppliers` (`Supplier_ID`),
  ADD CONSTRAINT `fk_Restaurants_has_Items_Items1` FOREIGN KEY (`Item_ID`) REFERENCES `items` (`Item_ID`),
  ADD CONSTRAINT `fk_Restaurants_has_Items_Restaurants1` FOREIGN KEY (`Restaurant_ID`) REFERENCES `restaurants` (`Restaurant_ID`);

--
-- Constraints for table `shops`
--
ALTER TABLE `shops`
  ADD CONSTRAINT `fk_Shops_Gates1` FOREIGN KEY (`Gate_ID`) REFERENCES `gates` (`Gate_ID`),
  ADD CONSTRAINT `shops_terminal` FOREIGN KEY (`Terminal_ID`) REFERENCES `terminals` (`Terminal_ID`);

--
-- Constraints for table `shop_contracts`
--
ALTER TABLE `shop_contracts`
  ADD CONSTRAINT `fk_Terminals_has_Shops_Terminals1` FOREIGN KEY (`Terminal_ID`) REFERENCES `terminals` (`Terminal_ID`),
  ADD CONSTRAINT `fk_Terminals_has_Shops_Shops1` FOREIGN KEY (`Shop_ID`) REFERENCES `shops` (`Shop_ID`);

--
-- Constraints for table `shop_employees`
--
ALTER TABLE `shop_employees`
  ADD CONSTRAINT `shop_employees_ibfk_1` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`),
  ADD CONSTRAINT `fk_Shops_has_Staff_Shops1` FOREIGN KEY (`Shop_ID`) REFERENCES `shops` (`Shop_ID`);

--
-- Constraints for table `shop_orders`
--
ALTER TABLE `shop_orders`
  ADD CONSTRAINT `fk_Shops_has_Items_Items1` FOREIGN KEY (`Item_ID`) REFERENCES `items` (`Item_ID`),
  ADD CONSTRAINT `fk_Shops_has_Items_Shops1` FOREIGN KEY (`Shop_ID`) REFERENCES `shops` (`Shop_ID`),
  ADD CONSTRAINT `shop_orders_ibfk_1` FOREIGN KEY (`Supplier_ID`) REFERENCES `suppliers` (`Supplier_ID`);

--
-- Constraints for table `staff_type`
--
ALTER TABLE `staff_type`
  ADD CONSTRAINT `staff_type_ibfk_1` FOREIGN KEY (`Staff_ID`) REFERENCES `staff` (`Staff_ID`);

--
-- Constraints for table `supplier_type`
--
ALTER TABLE `supplier_type`
  ADD CONSTRAINT `supplier_type_ibfk_1` FOREIGN KEY (`Supplier_ID`) REFERENCES `suppliers` (`Supplier_ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
