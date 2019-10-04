ALTER TABLE `contacts` CHANGE `email_opt_out` `email_opt_out` ENUM( 'Y', 'N' ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
CHANGE `do_not_call` `do_not_call` ENUM( 'Y', 'N' ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N';

ALTER TABLE `leads` CHANGE `email_opt_out` `email_opt_out` ENUM( 'Y', 'N' ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
CHANGE `do_not_call` `do_not_call` ENUM( 'Y', 'N' ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N';
