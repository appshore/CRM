--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `product_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `product_code` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `product_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `category_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `unit_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `tax_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `buy_price` int(11) NOT NULL DEFAULT '0',
  `sell_price` int(11) NOT NULL DEFAULT '0',
  `supplier_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `supplier_code` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `supplier_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `supplier_description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `updated` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

--
-- Dumping data for table `products`
--


-- --------------------------------------------------------

--
-- Table structure for table `products_categories`
--

CREATE TABLE IF NOT EXISTS `products_categories` (
  `category_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `category_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `category_top_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

--
-- Dumping data for table `products_categories`
--


-- --------------------------------------------------------

--
-- Table structure for table `products_statuses`
--

CREATE TABLE IF NOT EXISTS `products_statuses` (
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `status_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

--
-- Dumping data for table `products_statuses`
--

INSERT INTO `products_statuses` (`status_id`, `status_name`) VALUES
('status1', 'Status 1'),
('status2', 'status 2');

-- --------------------------------------------------------

--
-- Table structure for table `products_types`
--

CREATE TABLE IF NOT EXISTS `products_types` (
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

--
-- Dumping data for table `products_types`
--

INSERT INTO `products_types` (`type_id`, `type_name`) VALUES
('type1', 'type 1'),
('type2', 'type 2'),
('type3', 'type 3'),
('type4', 'type 4');

-- --------------------------------------------------------

--
-- Table structure for table `products_units`
--

CREATE TABLE IF NOT EXISTS `products_units` (
  `unit_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `unit_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

--
-- Dumping data for table `products_units`
--

INSERT INTO `products_units` (`unit_id`, `unit_name`) VALUES
('day', 'Day'),
('hour', 'Hour'),
('month', 'Month'),
('server', 'Server'),
('user', 'User'),
('year', 'Year'),
('box', 'Box');

CREATE TABLE IF NOT EXISTS `taxes` (
  `tax_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `tax_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `tax_value` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`tax_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`tax_id`, `tax_name`, `tax_value`) VALUES
('CA', 'CA - 7.25%', '7.25'),
('GST', 'GST - 13.33%', '13.33'),
('OR', 'OR - 6.75%', '6.75');


INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('products', 'Products', 13, 'A', 'products', 'product_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('products_categories', 'Products - Categories', 19, 'S', 'products_categories', 'category_id', 'Y', 'Y', 'N', 'Y', 'N', 'N', '');


INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('products', 'bulk', '12ytv3vlqt51z444kss400o00', 'Bulk', 'N', 2, 2),
('products', 'edit', '1x2j4ltcqau8cw84gkgsokc48', 'Body', 'N', 2, 3),
('products', 'edit', 'dcm4my3abxsswscckcg8ocgs', 'Supplier''s information', 'Y', 2, 6),
('products', 'edit', 'dl8r93y0y7sws8kkw8s8cc88', 'Header', 'N', 1, 1),
('products', 'edit', 'j6obcaemddkw8kgw0gogo8o0', 'Description', 'N', 1, 4),
('products', 'edit', 'kdt39wib5s000c080kgg4ks0', 'Note', 'N', 1, 7),
('products', 'popup_edit', '19r2nns7pkckgogo8c88ks04s', 'Body', 'N', 2, 3),
('products', 'popup_edit', '1awea3a9pcasckc8cckgcoc04', 'Header', 'N', 1, 1),
('products', 'popup_view', 'ey3grmfrk1kw8csosocogo88', 'Header', 'N', 1, 1),
('products', 'popup_view', 'z79lw8mhzhckowsg4480ckks', 'Body', 'N', 2, 3),
('products', 'view', '10p553snm4wgc44o8o4gg0c88', 'Note', 'N', 1, 7),
('products', 'view', '1i9j25fzexxcww0gg4ks8sc8o', 'Supplier''s information', 'Y', 2, 6),
('products', 'view', '2twjbh8ee7swgcsooog4sgso', 'Body', 'N', 2, 3),
('products', 'view', 'bv9htvxt4a8swk0008c0wwso', 'Footer', 'N', 2, 9),
('products', 'view', 'fe6a5b47lw088cg4o4co8wo0', 'Header', 'N', 1, 1),
('products', 'view', 'h8koeeozq9csc448g80swsg8', 'Description', 'N', 1, 4),
('products_categories', 'bulk', '1dzxdi77k7noowww0cko8w4o0', 'Bulk', 'N', 2, 2),
('products_categories', 'edit', '10u0gh4zw7k0woswws4kowcss', 'Body', 'N', 1, 3),
('products_categories', 'edit', '1wwqktwjc0u8ww0c4kg0wo4c0', 'Header', 'N', 2, 2),
('products_categories', 'edit', '7baqwh9bchog804kkwkw0kc', 'Note', 'N', 1, 4),
('products_categories', 'popup_edit', '1w8hfcs83mboo8okskos0swkg', 'Body', 'N', 1, 3),
('products_categories', 'popup_edit', '34v28k34kq4gc4kckggk4kg8', 'Header', 'N', 2, 2),
('products_categories', 'popup_view', 'b22av6espr4k4c0kwsg04w4w', 'Body', 'N', 1, 3),
('products_categories', 'popup_view', 'cubd3ih1h2osc848skscs44o', 'Header', 'N', 2, 2),
('products_categories', 'view', '1dbksfqp3v1ck0c8w480g8cwg', 'Footer', 'N', 2, 7),
('products_categories', 'view', '2b4a1gs9wk2sso8w448s80kg', 'Header', 'N', 2, 2),
('products_categories', 'view', '7ea83h815pwc80ocwo8kc84k', 'Body', 'N', 1, 4),
('products_categories', 'view', 'jn780h9v4dss40koc40k8ow8', 'Note', 'N', 1, 5);


INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('products', 'products', 'buy_price', 'N', 'N', 'NU', 'Buy price', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_right', 0, 'L', '', 4, 'L', '2twjbh8ee7swgcsooog4sgso', 4, 'L', '1x2j4ltcqau8cw84gkgsokc48', 0, 4, 5, 'L', 'z79lw8mhzhckowsg4480ckks', 2, 'R', '19r2nns7pkckgogo8c88ks04s', 5),
('products', 'products', 'category_id', 'N', 'N', 'RR', 'Category', 1, '', 'products_categories', 'category_id', 'category_name', '', 'N', 'N', 'N', 'N', 'Y', 2, 3, 'grid_left', 1, 'L', '12ytv3vlqt51z444kss400o00', 1, 'L', '2twjbh8ee7swgcsooog4sgso', 2, 'L', '1x2j4ltcqau8cw84gkgsokc48', 2, 3, 3, 'L', 'z79lw8mhzhckowsg4480ckks', 3, 'L', '19r2nns7pkckgogo8c88ks04s', 4),
('products', 'products', 'created', 'N', 'N', 'TE', 'Created', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('products', 'products', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', 'bv9htvxt4a8swk0008c0wwso', 0, 'L', '17i3gs504jgg8w4k8swwscg0g', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('products', 'products', 'description', 'N', 'N', 'ML', 'Description', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'h8koeeozq9csc448g80swsg8', 1, 'L', 'j6obcaemddkw8kgw0gogo8o0', 0, 0, 1, 'R', 'z79lw8mhzhckowsg4480ckks', 6, 'L', '19r2nns7pkckgogo8c88ks04s', 0),
('products', 'products', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '10p553snm4wgc44o8o4gg0c88', 1, 'L', 'kdt39wib5s000c080kgg4ks0', 0, 0, 0, 'L', 'i62dvimdjsgss4wsc00s840w', 0, 'L', '1382xwphsfqoo8c8ccs0w8c4k', 0),
('products', 'products', 'product_code', 'N', 'N', 'TE', 'Product code', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '2twjbh8ee7swgcsooog4sgso', 1, 'L', '1x2j4ltcqau8cw84gkgsokc48', 0, 0, 1, 'L', 'z79lw8mhzhckowsg4480ckks', 1, 'L', '19r2nns7pkckgogo8c88ks04s', 2),
('products', 'products', 'product_id', 'N', 'N', 'RK', 'Product', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('products', 'products', 'product_name', 'N', 'N', 'TE', 'Product name', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', 'fe6a5b47lw088cg4o4co8wo0', 1, 'L', 'dl8r93y0y7sws8kkw8s8cc88', 1, 1, 1, 'L', 'ey3grmfrk1kw8csosocogo88', 1, 'L', '1awea3a9pcasckc8cckgcoc04', 1),
('products', 'products', 'sell_price', 'N', 'N', 'NU', 'Sell price', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_right', 0, 'L', '', 3, 'L', '2twjbh8ee7swgcsooog4sgso', 3, 'L', '1x2j4ltcqau8cw84gkgsokc48', 0, 5, 4, 'L', 'z79lw8mhzhckowsg4480ckks', 3, 'R', '19r2nns7pkckgogo8c88ks04s', 6),
('products', 'products', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'products_statuses', 'status_id', 'status_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 7, 'grid_left', 1, 'R', '12ytv3vlqt51z444kss400o00', 1, 'R', '2twjbh8ee7swgcsooog4sgso', 1, 'R', '1x2j4ltcqau8cw84gkgsokc48', 4, 6, 2, 'L', 'z79lw8mhzhckowsg4480ckks', 2, 'L', '19r2nns7pkckgogo8c88ks04s', 7),
('products', 'products', 'supplier_code', 'N', 'N', 'TE', 'Supplier code', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', '1i9j25fzexxcww0gg4ks8sc8o', 2, 'L', 'dcm4my3abxsswscckcg8ocgs', 0, 0, 0, 'R', 'z79lw8mhzhckowsg4480ckks', 5, 'R', '19r2nns7pkckgogo8c88ks04s', 0),
('products', 'products', 'supplier_description', 'N', 'N', 'ML', 'Supplier description', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', '1i9j25fzexxcww0gg4ks8sc8o', 1, 'R', 'dcm4my3abxsswscckcg8ocgs', 0, 0, 0, 'R', 'z79lw8mhzhckowsg4480ckks', 6, 'R', '19r2nns7pkckgogo8c88ks04s', 0),
('products', 'products', 'supplier_id', 'N', 'N', 'RR', 'Supplier', 1, '', 'accounts', 'account_id', 'account_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 2, 'grid_right', 2, 'L', '12ytv3vlqt51z444kss400o00', 3, 'L', '1i9j25fzexxcww0gg4ks8sc8o', 3, 'L', 'dcm4my3abxsswscckcg8ocgs', 3, 2, 0, 'R', 'z79lw8mhzhckowsg4480ckks', 4, 'R', '19r2nns7pkckgogo8c88ks04s', 3),
('products', 'products', 'supplier_name', 'N', 'N', 'TE', 'Supplier name', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '1i9j25fzexxcww0gg4ks8sc8o', 1, 'L', 'dcm4my3abxsswscckcg8ocgs', 0, 0, 0, 'L', 'ey3grmfrk1kw8csosocogo88', 2, 'L', '1awea3a9pcasckc8cckgcoc04', 0),
('products', 'products', 'tax_id', 'N', 'N', 'DD', 'Tax', 1, '', 'taxes', 'tax_id', 'tax_name', '', 'N', 'N', 'N', 'N', 'Y', 6, 6, 'grid_left', 3, 'L', '12ytv3vlqt51z444kss400o00', 3, 'R', '2twjbh8ee7swgcsooog4sgso', 4, 'R', '1x2j4ltcqau8cw84gkgsokc48', 0, 0, 0, 'L', 'z79lw8mhzhckowsg4480ckks', 5, 'L', '19r2nns7pkckgogo8c88ks04s', 0),
('products', 'products', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'products_types', 'type_id', 'type_name', '', 'N', 'N', 'N', 'N', 'Y', 5, 8, 'grid_left', 2, 'R', '12ytv3vlqt51z444kss400o00', 2, 'R', '2twjbh8ee7swgcsooog4sgso', 2, 'R', '1x2j4ltcqau8cw84gkgsokc48', 0, 0, 0, 'R', 'z79lw8mhzhckowsg4480ckks', 1, 'R', '19r2nns7pkckgogo8c88ks04s', 0),
('products', 'products', 'unit_id', 'N', 'N', 'DD', 'Unit', 1, '0', 'products_units', 'unit_id', 'unit_name', '', 'N', 'N', 'N', 'N', 'Y', 7, 9, 'grid_left', 3, 'R', '12ytv3vlqt51z444kss400o00', 4, 'R', '2twjbh8ee7swgcsooog4sgso', 3, 'R', '1x2j4ltcqau8cw84gkgsokc48', 0, 0, 0, 'L', 'z79lw8mhzhckowsg4480ckks', 4, 'L', '19r2nns7pkckgogo8c88ks04s', 0),
('products', 'products', 'updated', 'N', 'N', 'TE', 'Updated', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('products', 'products', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', 'bv9htvxt4a8swk0008c0wwso', 0, 'R', '17i3gs504jgg8w4k8swwscg0g', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('products_categories', 'products_categories', 'category_id', 'N', 'N', 'RK', 'Category', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('products_categories', 'products_categories', 'category_name', 'N', 'N', 'TE', 'Category name', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '2b4a1gs9wk2sso8w448s80kg', 1, 'L', '1wwqktwjc0u8ww0c4kg0wo4c0', 1, 1, 1, 'L', 'cubd3ih1h2osc848skscs44o', 1, 'L', '34v28k34kq4gc4kckggk4kg8', 1),
('products_categories', 'products_categories', 'category_top_id', 'N', 'N', 'RR', 'Top category', 1, '', 'products_categories', 'category_id', 'category_name', '', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 1, 'L', '1dzxdi77k7noowww0cko8w4o0', 1, 'R', '2b4a1gs9wk2sso8w448s80kg', 1, 'R', '1wwqktwjc0u8ww0c4kg0wo4c0', 2, 2, 1, 'R', 'cubd3ih1h2osc848skscs44o', 1, 'R', '34v28k34kq4gc4kckggk4kg8', 2),
('products_categories', 'products_categories', 'created', 'N', 'N', 'DT', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 5, 0, 'L', '', 0, 'L', '', 5),
('products_categories', 'products_categories', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '1dbksfqp3v1ck0c8w480g8cwg', 0, 'L', '', 0, 0, 0, '', '', 0, 'R', '19i35720npfocos8w04o8cog0', 0),
('products_categories', 'products_categories', 'description', 'N', 'N', 'ML', 'Description', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 3, 'grid_left', 0, 'L', '', 1, 'L', '7ea83h815pwc80ocwo8kc84k', 1, 'L', '10u0gh4zw7k0woswws4kowcss', 0, 3, 1, 'L', 'b22av6espr4k4c0kwsg04w4w', 1, 'L', '1w8hfcs83mboo8okskos0swkg', 3),
('products_categories', 'products_categories', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', 'jn780h9v4dss40koc40k8ow8', 1, 'L', '7baqwh9bchog804kkwkw0kc', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('products_categories', 'products_categories', 'updated', 'N', 'N', 'DT', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 4, 0, 'L', '', 0, 'L', '', 4),
('products_categories', 'products_categories', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '1dbksfqp3v1ck0c8w480g8cwg', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '19i35720npfocos8w04o8cog0', 0);


INSERT INTO `db_linked` (`app_name`, `table_name`, `linked_app_name`, `linked_table_name`, `linked_record_name`, `linked_type`, `linked_app_label`, `sequence`) VALUES
('products', 'products', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 1),
('products', 'products', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 3),
('products', 'products', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 2),
('products', 'products', 'documents', 'documents', 'document_id', 'NN', 'Documents', 6),
('products', 'products', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 5),
('products', 'products', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 4),
('products', 'products', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 7);

INSERT INTO `db_linked` (`app_name`, `table_name`, `linked_app_name`, `linked_table_name`, `linked_record_name`, `linked_type`, `linked_app_label`, `sequence`) VALUES
('accounts', 'accounts', 'products', 'products', 'product_id', 'NN', 'Products', 5),
('activities', 'activities', 'products', 'products', 'product_id', 'NN', 'Products', 5),
('contacts', 'contacts', 'products', 'products', 'product_id', 'NN', 'Products', 3),
('leads', 'leads', 'products', 'products', 'product_id', 'NN', 'Products', 3),
('opportunities', 'opportunities', 'products', 'products', 'product_id', 'NN', 'Products', 4),
('webmail', 'webmail', 'products', 'products', 'product_id', 'NN', 'Products', 5),
('documents', 'documents', 'products', 'products', 'product_id', 'NN', 'Products', 3),
('documents_folders', 'documents', 'products', 'products', 'product_id', 'NN', 'Products', 3);

INSERT INTO `db_lookups` (`table_name`, `table_label`, `app_name`, `class_name`, `is_custom`, `is_customizable`, `lookup_id`, `lookup_name`, `lookup_value`, `lookup_comment`) VALUES
('products_categories', 'Products - Categories', 'products', 'products.categories', 'N', 'N', 'category_id', 'category_name', '', ''),
('products_statuses', 'Statuses - Products', '', '', 'N', 'Y', 'status_id', 'status_name', '', 'Identifiers are unique values associated with Labels'),
('products_types', 'Types - Products', '', '', 'N', 'Y', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('products_units', 'Units - Products', '', '', 'N', 'Y', 'unit_id', 'unit_name', '', 'Identifiers are unique values associated with Labels'),
('taxes', 'Taxes', '', '', 'N', 'Y', 'tax_id', 'tax_name', 'tax_value', 'The Value field represents the percentage of the tax. It must be a numeric value');

INSERT INTO `permissions` VALUES('admin', 'products', 127, '1', '1');

