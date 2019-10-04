<?php
/**************************************************************************\
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* Brice MICHEL <bmichel@appshore.com>                                      *
* Copyright (C) 2004 - 2010 Brice MICHEL                                   *
\**************************************************************************/

define('NBRECORDS', 10); // FIXME, records per action, needs to be personalized for each users
define('IMPORT_MAX_LINES', 50000); // Maximum of lines to be imported

define('OK', 'ok');
define('NOTICE', 'notice');
define('WARNING', 'warning');
define('DEBUG', 'debug');
define('ERROR', 'error');
define('LINK', 'link');

define('MSG_UPDATE', 'Information updated');
define('MSG_INSERT', 'Information created');
define('MSG_DELETE', 'Information deleted');
define('MSG_RESTORE', 'Information restored');

define('ERROR_DELETE', 'Delete error');
define('ERROR_INSERT', 'Insert error');
define('ERROR_UPDATE', 'Update error');

define('ERROR_INSERT_DUPLICATED_VALUE', 'Record not saved, duplicated value');

define('ERROR_RECORD_NOT_FOUND', 'Record not found');

define('ERROR_FILE_NOT_FOUND', 'File not found');
define('ERROR_FILE_TOO_BIG', 'Uploaded file size exceeds limit');
define('ERROR_FILE_EXISTS', 'File name must be unique');

define('ERROR_INVALID_APPLICATION', 'Invalid application');
define('ERROR_INVALID_DATA', 'Invalid or mandatory data');

define('ERROR_SEARCH_FIELD', 'Enter a valid search criteria');
define('ERROR_EMAIL_FIELD', 'Enter a valid email address');
define('ERROR_MANDATORY_FIELD', 'This field is mandatory');
define('ERROR_NUMERIC_FIELD', 'Enter a valid numeric value');
define('ERROR_PHONE_FIELD', 'Enter a valid phone number');
define('ERROR_DATE_FIELD', 'Enter a valid date');
define('ERROR_TIME_FIELD', 'Enter a valid time');
define('ERROR_PASSWORD_FIELD', 'Enter a valid password');
define('ERROR_ALIAS_FIELD', 'Enter a valid alias');
define('ERROR_UNIQUE_FIELD', 'Must be unique');

define('ERROR_USERS_QUOTA', 'Users quota reached, click to upgrade your subscription');
define('ERROR_USERS_ABOVE_QUOTA_LOCKED', 'Users quota reached, users above this quota are locked, click to upgrade your subscription');
define('ERROR_DISK_QUOTA', 'Disk space quota reached, click to upgrade your subscription');
define('ERROR_RECORDS_QUOTA', 'Database records quota reached, click to upgrade your subscription');

define('ERROR_SUBSCRIBERS_ONLY', 'This feature is not available for this edition, click to upgrade your subscription');
define('ERROR_SUBSCRIPTION_ENDED', 'Your subscription has ended, click to subscribe');
define('ERROR_TRIAL_ENDED', 'Your trial period has ended, click to subscribe');
define('WARNING_SUBSCRIPTION_END_TODAY', 'Your subscription will end Today, click to subscribe');
define('WARNING_TRIAL_END_TODAY', 'Your trial period will end Today, click to subscribe');
define('WARNING_SUBSCRIPTION_TO_END', 'Your subscription will end shortly, click to subscribe');
define('WARNING_TRIAL_TO_END', 'Your trial period will end shortly, click to subscribe');

define('ERROR_PERMISSION_DENIED', 'You do not have access right on this application');
define('ERROR_PERMISSION_WRITE_DENIED', 'You do not have update permission on this application');
define('ERROR_AUTH_INVALID', 'Invalid authentication');
define('ERROR_AUTH_IPACL', 'You do not have access authorization from this location');
define('ERROR_AUTH_USER_DEACTIVATED', 'Your user profile is deactivated');
define('ERROR_AUTH_USER_LOCKED', 'Your user profile is locked');
define('ERROR_NO_AUTH', 'Not authentified');

