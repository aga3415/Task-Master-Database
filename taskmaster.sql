-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2015 at 06:33 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `taskmaster`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getGroupById`(in group_id int)
begin
    	select * from Groups where id_group = group_id;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getMembersOfGroup`(in group_id int)
begin
    	select * from GroupMembers where id_group = group_id;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTaskById`(in task_id int)
begin
    	select * from Tasks where id_task = task_id;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByEmailAndPassword`(IN `email` VARCHAR(50) CHARSET utf8, IN `password` VARCHAR(50) CHARSET utf8)
    READS SQL DATA
select * from Users where Users.email = email and Users.password = password$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserById`( in user_id int)
begin
    	select * from Users where id_user = user_id;
    end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `selectUserBySessionId`(IN `session_id` INT(11))
    READS SQL DATA
select * from Users where Usesrs.session_id = session_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSessionIdInUsersTable`(IN `new_session_id` INT(11), IN `email` VARCHAR(50), IN `password` VARCHAR(50))
    MODIFIES SQL DATA
Update Users
set session_id = session_id
where Users.email = email and Users.password = password$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `aims`
--

CREATE TABLE IF NOT EXISTS `aims` (
`id_aim` int(11) NOT NULL,
  `id_executor` int(11) NOT NULL,
  `id_principal` int(11) DEFAULT NULL,
  `points_aim` int(11) NOT NULL,
  `points_actual` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `groupmembers`
--

CREATE TABLE IF NOT EXISTS `groupmembers` (
  `id_group` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
`id_group` int(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE IF NOT EXISTS `tasks` (
`id_task` int(11) NOT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `data_insert` date NOT NULL,
  `data_update` date DEFAULT NULL,
  `data_plan_exec` date DEFAULT NULL,
  `data_exec` date DEFAULT NULL,
  `data_archive` date DEFAULT NULL,
  `cycle_time` int(11) DEFAULT NULL,
  `id_group` int(11) DEFAULT NULL,
  `id_executor` int(11) DEFAULT NULL,
  `id_principal` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id_user` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `verify_mail` varchar(50) NOT NULL,
  `session_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aims`
--
ALTER TABLE `aims`
 ADD PRIMARY KEY (`id_aim`), ADD KEY `executor_id` (`id_executor`), ADD KEY `prinicipal_id` (`id_principal`);

--
-- Indexes for table `groupmembers`
--
ALTER TABLE `groupmembers`
 ADD KEY `group_id` (`id_group`), ADD KEY `user_id` (`id_user`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
 ADD PRIMARY KEY (`id_group`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
 ADD PRIMARY KEY (`id_task`), ADD KEY `executor_id` (`id_executor`), ADD KEY `prinicipal_id` (`id_principal`), ADD KEY `group_id` (`id_group`), ADD KEY `parent_id` (`id_parent`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aims`
--
ALTER TABLE `aims`
MODIFY `id_aim` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
MODIFY `id_group` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
MODIFY `id_task` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `aims`
--
ALTER TABLE `aims`
ADD CONSTRAINT `aims_ibfk_1` FOREIGN KEY (`id_executor`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
ADD CONSTRAINT `aims_ibfk_2` FOREIGN KEY (`id_principal`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `groupmembers`
--
ALTER TABLE `groupmembers`
ADD CONSTRAINT `groupmembers_ibfk_1` FOREIGN KEY (`id_group`) REFERENCES `groups` (`id_group`) ON DELETE CASCADE,
ADD CONSTRAINT `groupmembers_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`id_executor`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`id_principal`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
ADD CONSTRAINT `tasks_ibfk_3` FOREIGN KEY (`id_group`) REFERENCES `groups` (`id_group`) ON DELETE CASCADE,
ADD CONSTRAINT `tasks_ibfk_4` FOREIGN KEY (`id_parent`) REFERENCES `tasks` (`id_task`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
