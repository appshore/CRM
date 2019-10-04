UPDATE `db_fields` SET field_name = "is_read" WHERE app_name = "webmail" AND table_name = "webmail" AND field_name="isread";

ALTER TABLE `webmail` CHANGE `isread` `is_read` ENUM('Y','N') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N';

ALTER TABLE `webmail_attachments` ADD `disposition` VARCHAR( 50 ) NOT NULL AFTER `attachment_id`;
ALTER TABLE `webmail_attachments` CHANGE `type` `type` VARCHAR( 50 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;
ALTER TABLE `webmail_attachments` CHANGE `subtype` `subtype` VARCHAR( 50 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;

