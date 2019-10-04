update db_fields set field_type = "PH" where field_name like "%phone%" and field_type = "TE" and is_custom = "N";
update db_fields set field_type = "PH" where field_name like "%mobile%" and field_type = "TE" and is_custom = "N";

