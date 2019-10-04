
REPLACE INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('preferences_searches', 'Preferences - Search filters', 5, 'S', 'searches', 'search_id', 'N', 'Y', 'N', 'N', 'N', 'N', '');

REPLACE INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('preferences_searches', 'view', '785ofb87iz8c4s80o4kkw44g', 'Body', 'N', 2, 3),
('preferences_searches', 'view', '15mmys2jk6lcc448k4c4oscw4', 'Header', 'N', 1, 1),
('preferences_searches', 'view', 'ya81xno8534wcc48cwkscwsw', 'Footer', 'N', 2, 5),
('preferences_searches', 'popup_view', '155stu4q1dr4kck004s808ko8', 'Footer', 'N', 2, 5),
('preferences_searches', 'edit', 'dqulv1sqb14cscwko8gco404', 'Header', 'N', 1, 1),
('preferences_searches', 'edit', '1gd2edpui5wgcow8cscwss84k', 'Body', 'N', 2, 3),
('preferences_searches', 'popup_view', 'bpk76wid1r4gscocw840k00', 'Header', 'N', 1, 1),
('preferences_searches', 'popup_view', '109qf1yjq6u8g8w8csc4kck0', 'Body', 'N', 2, 3),
('preferences_searches', 'popup_edit', '1yc2lqbfqav4s80wgwsc40wcs', 'Body', 'N', 2, 3),
('preferences_searches', 'popup_edit', '15pe5y7kwg4gos88s808c8sc8', 'Header', 'N', 1, 1);

REPLACE INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('preferences_searches', 'searches', 'search_id', 'N', 'N', 'RK', 'Search id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_searches', 'searches', 'app_name', 'N', 'N', 'DD', 'Application', 1, '', 'db_applications', 'app_name', 'app_label', ' where is_search = ''Y'' and status_id = ''A''', 'N', 'Y', 'N', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '785ofb87iz8c4s80o4kkw44g', 1, 'L', '1gd2edpui5wgcow8cscwss84k', 0, 0, 1, 'L', '109qf1yjq6u8g8w8csc4kck0', 1, 'L', '1yc2lqbfqav4s80wgwsc40wcs', 1),
('preferences_searches', 'searches', 'user_id', 'N', 'N', 'RR', 'User id', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_searches', 'searches', 'search_name', 'N', 'N', 'VF', 'Search filter', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', '15mmys2jk6lcc448k4c4oscw4', 1, 'L', 'dqulv1sqb14cscwko8gco404', 0, 0, 1, 'L', 'bpk76wid1r4gscocw840k00', 1, 'L', '15pe5y7kwg4gos88s808c8sc8', 2),
('preferences_searches', 'searches', 'is_private', 'N', 'N', 'CH', 'Is private', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '785ofb87iz8c4s80o4kkw44g', 0, 'R', '1gd2edpui5wgcow8cscwss84k', 0, 0, 0, 'R', '109qf1yjq6u8g8w8csc4kck0', 1, 'R', '1yc2lqbfqav4s80wgwsc40wcs', 3),
('preferences_searches', 'searches', 'search_filter', 'N', 'N', 'ML', 'Search filter', 4, '', '', '', '', '', 'Y', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_searches', 'searches', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 3, 'grid_center', 0, 'L', '', 1, 'L', 'ya81xno8534wcc48cwkscwsw', 0, 'L', '', 0, 0, 1, 'L', '155stu4q1dr4kck004s808ko8', 0, 'L', '', 4),
('preferences_searches', 'searches', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '109cfl2ivnr40wss04g844wso', 0, 'L', '', 0, 0, 0, 'L', '13kb64i5tm2o0gg8s80kwg4c0', 0, 'L', '', 0),
('preferences_searches', 'searches', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 4, 'grid_center', 0, 'L', '', 1, 'R', 'ya81xno8534wcc48cwkscwsw', 0, 'L', '', 0, 0, 1, 'R', '155stu4q1dr4kck004s808ko8', 0, 'L', '', 5),
('preferences_searches', 'searches', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '109cfl2ivnr40wss04g844wso', 0, 'L', '', 0, 0, 0, 'R', '13kb64i5tm2o0gg8s80kwg4c0', 0, 'L', '', 0);

CREATE TABLE IF NOT EXISTS `searches` (
  `search_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `app_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `search_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `is_private` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `search_filter` text COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  KEY `app_name` (`app_name`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

