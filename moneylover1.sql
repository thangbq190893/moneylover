-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 19, 2019 at 02:57 PM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moneylover1`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'DEBT&LOAN', '2019-03-25 02:39:43', '2019-03-25 02:39:43'),
(2, 'EXPENSE', '2019-03-26 23:01:13', '2019-03-26 23:01:13'),
(3, 'INCOME', '2019-03-26 23:01:13', '2019-03-26 23:01:13');

-- --------------------------------------------------------

--
-- Table structure for table `curencies`
--

CREATE TABLE `curencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `curencies`
--

INSERT INTO `curencies` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'VNĐ', '2019-03-25 03:23:19', '2019-03-25 03:23:19'),
(2, 'USD', '2019-03-26 03:18:25', '2019-03-26 03:18:25'),
(3, 'GBP', '2019-03-26 03:18:25', '2019-03-26 03:18:25'),
(4, 'EUR', '2019-03-26 03:18:25', '2019-03-26 03:18:25'),
(5, 'CNY', '2019-03-26 03:18:25', '2019-03-26 03:18:25'),
(6, 'JPY', '2019-03-26 03:18:25', '2019-03-26 03:18:25'),
(7, 'BRL', '2019-03-26 03:18:25', '2019-03-26 03:18:25');

-- --------------------------------------------------------

--
-- Table structure for table `history_wallet`
--

CREATE TABLE `history_wallet` (
  `id` int(10) UNSIGNED NOT NULL,
  `wallet_id` int(10) UNSIGNED NOT NULL,
  `old_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `new_name` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `old_cash` decimal(15,0) NOT NULL,
  `new_cash` decimal(15,0) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `history_wallet`
--

INSERT INTO `history_wallet` (`id`, `wallet_id`, `old_name`, `new_name`, `old_cash`, `new_cash`, `date`) VALUES
(3, 43, 'Vis 3', 'Vis 3', '99999', '99000', '2019-04-16 16:50:09'),
(4, 43, 'Vis 3', 'Vis 3', '99000', '990090', '2019-04-16 16:52:27');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'debt', 1, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(2, 'debt collection', 1, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(3, 'repayment', 1, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(4, 'business', 2, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(5, 'education', 2, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(6, 'family', 2, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(7, 'shopping', 2, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(8, 'other', 2, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(9, 'award', 3, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(10, 'gifts', 3, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(11, 'interest money', 3, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(12, 'other', 3, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(13, 'salary', 3, '2019-03-26 23:07:46', '2019-03-26 23:07:46'),
(14, 'selling', 3, '2019-03-26 23:07:46', '2019-03-26 23:07:46');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2019_03_25_074652_create__wallet_table', 1),
(9, '2019_03_25_080015_create_category_table', 1),
(10, '2019_03_25_080031_create_item_table', 1),
(11, '2019_03_25_084131_create_transactions_table', 1),
(12, '2019_03_25_095558_create_curencies_table', 2),
(13, '2019_03_25_095928_add_curency_into_wallets_table', 3),
(14, '2019_03_25_103139_update_wallets_table', 4),
(15, '2019_03_25_104047_add_cash_into_wallets', 5),
(16, '2019_03_25_114112_delete_cash_wallets_table', 6),
(17, '2019_03_25_114233_add_cash_wallets_table', 7),
(18, '2019_03_25_114831_delete_cash_wallets_table', 8),
(19, '2019_03_25_114854_add_cash_into_wallets', 9),
(20, '2019_03_26_024945_delete_cost_note_transactions_table', 10),
(21, '2019_03_26_025040_update_cost_note_transactions_table', 11),
(22, '2019_03_26_025330_delete_with_people_transactions_table', 12),
(23, '2019_03_26_025424_update_with_people_transactions_table', 13),
(24, '2019_03_27_050305_delete_category_id_transactions_table', 14),
(25, '2019_03_27_050512_delete_category_transactions_table', 15),
(26, '2019_03_27_065301_add_pay_wallets_table', 16),
(27, '2019_03_27_065644_delete_pay_wallets_table', 17),
(28, '2019_04_08_074345_update__users_table', 18),
(29, '2019_04_16_064646_create_history_wallet_table', 18),
(30, '2019_04_16_074632_update_foreignkey_transactions', 18);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('017dcab69cd291e5672a7ee7a2ff51ed9d0bb40dd9e87131d2988879a66c9cdbbd1b9f6e47a5d62e', 1, 1, 'Myapp', '[]', 0, '2019-03-25 02:51:44', '2019-03-25 02:51:44', '2020-03-25 09:51:44'),
('03d0b9459c3814395cf0b068933a9093b3f4036250472a345dd1856f0526be4fe0115ca6115641f7', 1, 1, 'MyApp', '[]', 0, '2019-04-16 09:58:06', '2019-04-16 09:58:06', '2020-04-16 16:58:06'),
('03daac715215b1d850f32f5c6df1e4f425cb942c8ea597961ae854a5f89e19248a01bca7fb01ad2c', 1, 1, 'MyApp', '[]', 0, '2019-04-15 10:14:58', '2019-04-15 10:14:58', '2020-04-15 17:14:58'),
('0acb7ce9963c595ec2f3b6cbbe5ddbf0236049fdbe20e62cf9a5e2ef999f66bb6246f22f1a1896fc', 3, 1, 'Myapp', '[]', 0, '2019-04-11 04:01:58', '2019-04-11 04:01:58', '2020-04-11 11:01:58'),
('0b7f4934dfb9baf596f495b043e42560fa8ff34c8e56b0ccbca6410a03c8938672ae15035134100b', 1, 1, 'MyApp', '[]', 0, '2019-04-10 07:44:09', '2019-04-10 07:44:09', '2020-04-10 14:44:09'),
('0f50b70228a5c5596a0be913a0977ce32ef5e5504d6f819605c76b6789240c16be6aa79893b93b6e', 1, 1, 'MyApp', '[]', 0, '2019-04-18 05:18:52', '2019-04-18 05:18:52', '2020-04-18 12:18:52'),
('10be2dfb50443ca5bd28b6f40624ddefa425e35c0d84a8d3be1d1c904504b6275f4c02b55193e5cc', 1, 1, 'MyApp', '[]', 0, '2019-04-16 09:33:59', '2019-04-16 09:33:59', '2020-04-16 16:33:59'),
('255314b593598983f4c53ff9d87362dc5f6ede115d2243d7e55c11413cc015814a82e31bc85a2728', 1, 1, 'MyApp', '[]', 0, '2019-04-10 07:23:31', '2019-04-10 07:23:31', '2020-04-10 14:23:31'),
('2eb6b1fcc092f4ec07d752804d25d3a3792a4d2d2b5f6d9e5488d8c01796cb2e6e19626b8ac0139a', 1, 1, 'MyApp', '[]', 0, '2019-04-16 08:11:30', '2019-04-16 08:11:30', '2020-04-16 15:11:30'),
('2fcc2756920aab1ee5b3c64eeea6fe5e22a9ae460c57df8212a3c5fccdcc70dbc7a5cfb204b5983e', 1, 1, 'MyApp', '[]', 0, '2019-04-15 11:41:33', '2019-04-15 11:41:33', '2020-04-15 18:41:33'),
('302b1084cfbc505f090a70e2f448810f8be4d01c8c0c11decffddc4a98de159bc426ecdd14f6bc7d', 1, 1, 'MyApp', '[]', 0, '2019-04-16 09:39:57', '2019-04-16 09:39:57', '2020-04-16 16:39:57'),
('5cc7b2739b080c457b099b5e7d240e4853154c616741b79602ddf2b59b472a601a305821c68e116d', 1, 1, 'MyApp', '[]', 0, '2019-04-10 07:30:22', '2019-04-10 07:30:22', '2020-04-10 14:30:22'),
('5d64a2dcf132febcf70da40b40a03e39bc8148dbd4a29af395ee627d0d9bf97767e701093d8fa39a', 1, 1, 'MyApp', '[]', 0, '2019-04-10 07:23:26', '2019-04-10 07:23:26', '2020-04-10 14:23:26'),
('6b5b09b53feb585564b9b92e8c9f91661771c7495dc49260e527db03c44744b82bfedc069e176c74', 1, 1, 'MyApp', '[]', 0, '2019-04-16 09:46:15', '2019-04-16 09:46:15', '2020-04-16 16:46:15'),
('74cec11838af8ecf6e62e21e799e06a2d3640eea857c06c0ffadccee83873a8b60975726149fd72b', 1, 1, 'MyApp', '[]', 0, '2019-04-10 13:17:46', '2019-04-10 13:17:46', '2020-04-10 20:17:46'),
('767696bbda08f4ae33583d5156f361d4ae144d7417a054e983fa272b3a4167dcbb70948ec02802cc', 1, 1, 'MyApp', '[]', 0, '2019-04-10 07:44:49', '2019-04-10 07:44:49', '2020-04-10 14:44:49'),
('8bcd5de006799c578a7286e5f2e17349f7baa960b71b8cb6170f04d13ddf9cf76c89c1a8b9699c8b', 3, 1, 'MyApp', '[]', 0, '2019-04-11 04:02:09', '2019-04-11 04:02:09', '2020-04-11 11:02:09'),
('9717379cc85a16af7afe89f490300b557eb6b7c6cfffe85476958cf33e959011399cbedeb889416f', 1, 1, 'MyApp', '[]', 0, '2019-04-16 08:03:11', '2019-04-16 08:03:11', '2020-04-16 15:03:11'),
('acc057bc0b4b351a680f8131f1c06c72b1cbab7b862c1971ca8bdbeab41a4f7faa77b69f47795e7b', 2, 1, 'Myapp', '[]', 0, '2019-04-11 03:59:40', '2019-04-11 03:59:40', '2020-04-11 10:59:40'),
('b3f9ec6092b0611dfc64c18e22e204604a0da836c22cc4b27cef2cf763d898a367b65ed0a3409c74', 1, 1, 'MyApp', '[]', 0, '2019-03-26 20:44:22', '2019-03-26 20:44:22', '2020-03-27 03:44:22'),
('b650d6f6452426b557aecc48d7866de0e9e48d40142e58a8c33030115711c2948a0d17c7d057501a', 1, 1, 'MyApp', '[]', 0, '2019-04-16 09:52:09', '2019-04-16 09:52:09', '2020-04-16 16:52:09'),
('bae31d319f390d2076437af11b83dc3b809e7ad3bf6c92cf36ed548526d3e66c32cca25037a79bf5', 1, 1, 'MyApp', '[]', 0, '2019-04-06 07:20:08', '2019-04-06 07:20:08', '2020-04-06 14:20:08'),
('c3f8df0261c6a97c2e511de657876c12eb06744970fe028df004655090b698d2a412607d8f131658', 1, 1, 'MyApp', '[]', 0, '2019-04-16 09:28:34', '2019-04-16 09:28:34', '2020-04-16 16:28:34'),
('dc022fdbfd26fa40f450cfdda05c9acb1a3bf16b6f453ed2c3d4fdf0df1b21b2e4dc561e6fc8f1fa', 1, 1, 'MyApp', '[]', 0, '2019-04-16 07:49:22', '2019-04-16 07:49:22', '2020-04-16 14:49:22'),
('e038f4c11ff1060d674b9677d6b29adfc5115c4ea0971e8a6d9b85ab7d31f838a738458a7888c475', 1, 1, 'MyApp', '[]', 0, '2019-04-10 13:15:39', '2019-04-10 13:15:39', '2020-04-10 20:15:39'),
('ea882007b57dfde5555fe2b121ffd0f9bc783802804f37a80ef25105ecbce6b420b00633033f781a', 1, 1, 'MyApp', '[]', 0, '2019-04-15 11:35:38', '2019-04-15 11:35:38', '2020-04-15 18:35:38'),
('efea474f9dea09afa47ad639eb4fe646570979e9f484d9cb09416d3fb335c9e37b162e5f879b00bf', 1, 1, 'MyApp', '[]', 0, '2019-04-06 07:19:55', '2019-04-06 07:19:55', '2020-04-06 14:19:55'),
('f089fc8b821f615e01be714f091491bd75ce1288e76550ab4af77a90e548627b3bfffb512a279c8f', 1, 1, 'MyApp', '[]', 0, '2019-04-11 10:04:30', '2019-04-11 10:04:30', '2020-04-11 17:04:30'),
('f62efb96a101766f08406a05a364c4edaa3d89598c28adb64f3a46dc2a53ca52f44b7d4ea806eae4', 1, 1, 'MyApp', '[]', 0, '2019-04-16 08:15:18', '2019-04-16 08:15:18', '2020-04-16 15:15:18'),
('f785b5dd349e68b1bcbd95c1c06d956378e0e23febb9ef1bea08346beb480a33dd10c84e48b880c7', 1, 1, 'MyApp', '[]', 0, '2019-04-10 07:54:28', '2019-04-10 07:54:28', '2020-04-10 14:54:28'),
('fac7802a2c7b8af6d1790ee9fab2a9a4e3a8db65943fa29c6663b912ed937517dd7061b8a9e89169', 1, 1, 'MyApp', '[]', 0, '2019-04-10 07:23:30', '2019-04-10 07:23:30', '2020-04-10 14:23:30');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'nWJz5HRYl2Bu1zjZvRU7gaD2bPekjNgZvo1H3UT8', 'http://localhost', 1, 0, 0, '2019-03-25 01:44:16', '2019-03-25 01:44:16'),
(2, NULL, 'Laravel Password Grant Client', 'pqjOeA9oOUX5vbZFbrY4bKfB8q53lMW4aAtI5uId', 'http://localhost', 0, 1, 0, '2019-03-25 01:44:16', '2019-03-25 01:44:16');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-03-25 01:44:16', '2019-03-25 01:44:16');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `wallet_id` int(10) UNSIGNED NOT NULL,
  `event` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No events',
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cost` decimal(15,0) NOT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `with_people` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `wallet_id`, `event`, `date`, `created_at`, `updated_at`, `cost`, `note`, `with_people`, `item_id`) VALUES
(5, 1, 'No events', '2019-04-16', '2019-03-26 23:11:20', '2019-04-16 09:40:18', '700000', NULL, NULL, 2),
(6, 1, 'No events', '2019-03-27', '2019-03-26 23:11:20', '2019-03-26 23:11:20', '600000', NULL, NULL, 2),
(10, 1, 'No events', '2019-03-27', '2019-03-27 01:16:58', '2019-03-27 01:16:58', '300000', NULL, NULL, 5),
(11, 1, 'No events kakaa', '2019-04-18', '2019-03-27 01:16:58', '2019-04-18 05:19:29', '500008', NULL, NULL, 11),
(14, 1, 'No events', '2019-04-16', '2019-03-27 01:16:58', '2019-04-16 09:59:40', '2000000', NULL, NULL, 3),
(21, 19, 'nộp học phí', '2019-04-11', '2019-04-11 03:44:24', '2019-04-11 03:44:24', '200000', 'môn tin', 'cô giáo Thảo', 5),
(22, 19, 'đi học', '2019-04-11', '2019-04-11 03:48:38', '2019-04-11 03:48:38', '450000', 'Toán', 'Cô giáo Mai', 5),
(33, 40, '56hty', '2019-04-11', '2019-04-11 04:52:13', '2019-04-11 04:52:13', '454', NULL, NULL, 5),
(38, 43, 'ko', '2019-04-16', '2019-04-16 09:54:45', '2019-04-16 09:54:45', '2000', NULL, NULL, 6),
(39, 43, 'ko', '2019-04-16', '2019-04-16 09:55:00', '2019-04-16 09:56:09', '4600', NULL, NULL, 13);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `bio` mediumtext COLLATE utf8_unicode_ci,
  `photo` varchar(191) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'profile.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `type`, `bio`, `photo`) VALUES
(1, 'member1', 'member1@gmail.com', NULL, '$2y$10$64pmwdhlyS3mVrR6sn8dhenehYjeID9HLwSWtHaO3IEr6bS65110C', 'G0VrHF9HpGu0cCJCTdhywUgWudd5byCG82ONMpp3KN7rZGgOmJGZzI6fhoLg', '2019-03-25 02:51:44', '2019-03-25 02:51:44', 'user', NULL, 'profile.png'),
(2, 'member 2', 'member2@gmail.com', NULL, '$2y$10$RqDV5TKfP8BUNrx9YFZroetub8hQCkhT7JXZLexRWfdcRGi.6ytr2', NULL, '2019-04-11 03:59:40', '2019-04-11 03:59:40', 'user', NULL, 'profile.png'),
(3, 'member 3', 'member3@gmail.com', NULL, '$2y$10$Q2ZfyrbnzLdzcQYNjhmEh.J6Hj8phnTEiGI8NcvC5kf2vjTwyDX.O', NULL, '2019-04-11 04:01:57', '2019-04-11 04:01:57', 'user', NULL, 'profile.png');

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `curency_id` int(10) UNSIGNED NOT NULL,
  `cash` decimal(15,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`id`, `name`, `user_id`, `created_at`, `updated_at`, `curency_id`, `cash`) VALUES
(1, 'Quỹ đen trốn vợ', 1, '2019-03-25 04:58:54', '2019-03-25 04:58:54', 1, '1000000'),
(19, 'Quỹ đen 2', 1, '2019-04-10 10:15:10', '2019-04-10 10:15:10', 7, '20000000'),
(40, 'ví tiền Việt', 3, '2019-04-11 04:33:46', '2019-04-11 04:33:46', 1, '10000'),
(41, 'Vis 1', 1, '2019-04-16 09:49:35', '2019-04-16 09:49:35', 2, '50000'),
(42, 'Vis2', 1, '2019-04-16 09:49:47', '2019-04-16 09:49:47', 4, '50000'),
(43, 'Vis 3', 1, '2019-04-16 09:50:00', '2019-04-16 09:52:27', 6, '990090');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `curencies`
--
ALTER TABLE `curencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `history_wallet`
--
ALTER TABLE `history_wallet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `history_wallet_wallet_id_foreign` (`wallet_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `items_category_id_foreign` (`category_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_wallet_id_foreign` (`wallet_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wallets_name_user_id_unique` (`name`,`user_id`),
  ADD KEY `wallets_user_id_foreign` (`user_id`),
  ADD KEY `wallets_curency_id_foreign` (`curency_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `curencies`
--
ALTER TABLE `curencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `history_wallet`
--
ALTER TABLE `history_wallet`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `history_wallet`
--
ALTER TABLE `history_wallet`
  ADD CONSTRAINT `history_wallet_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_curency_id_foreign` FOREIGN KEY (`curency_id`) REFERENCES `curencies` (`id`),
  ADD CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
