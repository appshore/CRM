
update db_blocks set is_title = "N" where app_name = "activities" and block_name = "Note";
update db_blocks set block_sequence = "3" where app_name = "cases" and block_name = "Notifications";
update db_blocks set block_sequence = "4", is_title = "N" where app_name = "cases" and block_name = "Note";
