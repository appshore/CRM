<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

defined('SEP') or define('SEP', '/');
define('INSTANCES_DATA', 		'~/Dev/datas'); 	// Directory where instances datas are stored
define('INSTANCES_HTTPD',		$GLOBALS['distrib_dir']);	// directory of the distrib
define('INSTANCES_DOMAIN', 		'appshore.local'); 	// domain name common to all the instance of this distrib

// Private label or AppShore definition
define('PRIVATE_LABEL', 		'');  // must be always '' for AppShore and 'xxxxx_' for others
define('CUSTOMER_NAME', 		'AppShore');		// name of the Private Label owner, default is AppShore
define('CUSTOMER_DOMAIN', 		'appshore.local'); 	// domain name common to all the instance of this distrib
define('BRAND', 				'AppShore');     // Brand name as seen from the instance default is AppShore
define('BRAND_WEBSITE', 		'www.'.CUSTOMER_DOMAIN);  // website of the PL owner
define('LOGO', 					'appshore120x22.jpg');		// logo of the PL
define('LOGO_WEBSITE', 			'www.'.CUSTOMER_DOMAIN);		// website where to point when click on the logo
define('FAVICON', 				PRIVATE_LABEL.'favicon.ico');					// small icon of the PL
define('SUPPORT_WEBSITE', 		'');							// support website of the PL owner, must be '' for AppShore
define('SUPPORT_EMAIL', 		'support@'.CUSTOMER_DOMAIN);	// support email of the PL owner

define('GOOGLE_TRACKER',		'');
define('GOOGLE_DOMAIN',			'.appshore.net');

define('PAYMENT_MENU',			true);
define('PAYMENT_EMAIL',			'');
define('PAYMENT_ID',			'');
define('MERCHANT_ID',			'');		// prod = ''); // test = '364045225044254');

// backoffice website and access
define('BACKOFFICE_SERVER', 	'backoffice.'.INSTANCES_DOMAIN); 	// BO domain name, access only through soap
define('BACKOFFICE_USERNAME', 	''); // web username not DB
define('BACKOFFICE_PASSWORD', 	''); // web password not DB

define('WWW_DB', 'appshore_www');
define('WWW_DOMAIN', 'www.appshore.local');


//Databases
define('LIGHTTPD_DB', 			'appshore_lighttpd');	// db use by lighttpd to store domains docroot, one for all AppShore/private label instance
define('BACKOFFICE_DB', 		(PRIVATE_LABEL == '') ? 'appshore_backoffice' : (PRIVATE_LABEL.'backoffice')); // username,password same as instance DB
define('GLOBAL_DB', 			(PRIVATE_LABEL == '') ? 'appshore_global_v23' : (PRIVATE_LABEL.'global'));	// global db that contains common tables between instances

if( $subdomain == 'backoffice' && PRIVATE_LABEL == '' )
    define('DB_NAME',           BACKOFFICE_DB); // special case
elseif( $subdomain == 'demo' && PRIVATE_LABEL == '' )
    define('DB_NAME',           'appshore_demo');		// special case
else
    define('DB_NAME',           PRIVATE_LABEL.$subdomain); // instance db name, should be PRIVATE_LABEL.$subdomain
define('DB_USERNAME', 			''); // instance db user name, instance db name is PRIVATE_LABEL.$subdomain
define('DB_PASSWORD', 			'');	// to be changed

define('MYSQL_DATA', 			'~/mysql/'.DB_NAME.'/'); 	// Directory where mysql datas are stored

//these params are only use by an AppShore instance
//define('WWW_DB', 				'www');
//define('WWW_USERNAME', 		'');
//define('WWW_PASSWORD', 		'');
//define('REGISTRATION_WEBSITE', 	'www.'.CUSTOMER_DOMAIN); //
//define('REGISTRATION_EMAIL', 	'test_registration@'.CUSTOMER_DOMAIN);

// Directories
define('APPSHORE_HTTPD',		$GLOBALS['distrib_dir']);			// directory of the distrib
define('APPSHORE_API',			APPSHORE_HTTPD.SEP.'api');			// directory of engine (api)
define('APPSHORE_LIB',			APPSHORE_HTTPD.SEP.'lib');			// directory of engine library
define('APPSHORE_INCLUDES',		APPSHORE_HTTPD.SEP.'includes'); 	// directory of includes libs

define('APPSHORE_TMP',			SEP.'tmp'); 						// temporary directory

// instance specific data storage
define('APPSHORE_STORAGE', 		INSTANCES_DATA.SEP.$subdomain);
define('APPSHORE_IMAGES', 		APPSHORE_STORAGE.SEP.'images');
define('APPSHORE_DOCUMENTS', 	APPSHORE_STORAGE.SEP.'documents');
define('APPSHORE_ATTACHMENTS', 	APPSHORE_STORAGE.SEP.'attachments');
define('APPSHORE_REPORTS', 		APPSHORE_STORAGE.SEP.'reports');

// AA uses to define some global runtime parameters
$GLOBALS['appshore_data'] = array(
	'server'	=>	array(

		// database related parameters
		'globaldb'			=>	GLOBAL_DB,	// specific to dev release, should be appshore_globalV1
		'db_host'			=>	'localhost', //'192.168.1.202',
		'db_name'			=>	DB_NAME,
		'db_user'			=>	DB_USERNAME,
		'db_pass'			=>	DB_PASSWORD,
		'db_type'			=>	'mysqli',

		// default values for starting application
		'default_anon_op'	=>	'base.auth.login',
		'default_start_op'	=>	'base.core.start',
		'baseurl'			=>	$baseurl.':8001',

		'fulldomain'		=>  $subdomain.'.'.$domain.'.'.$tld,
		'subdomain'			=>	$subdomain,
		'domain'			=>	$domain,
		'tld'				=>	$tld,

		// default values of some user's parameters
		'language_id'		=>	'en-us',
		'theme_id'			=>	'default',
		'locale_date_id'	=>	'%Y-%m-%d',
		'locale_time_id'	=>	'%H:%M',
		'charset_id'		=>	'UTF-8',
		'currency_id'		=>	'USD',
		'timezone_id'		=>	date_default_timezone_get(),
		'nbrecords'			=>	10,
		'confirm_delete'	=>	'Y',

		// global params for the engine
		'powered_by'		=>	true,	// brand footer visible or not
		'performance'		=>	true,	// perfs activated or not
		'graphs'			=>	true,	// true to display graphic components
		'xml_render'		=>	isset($_GET['xml_render']),	// true to display managed by browser
		'checkUpgrade'		=>	false,	// true for AppShore customers instance
		'checkLicense'		=>	false,	// true for appShore paying customers
		'error_report'		=>	'2039', //(($subdomain == 'v23')?'2039':'0'),// '2039' to display all errors, 0 to none

		// cache mechanism
		'cache_xslt'			=>	false,	// false or 'xcache', 'memcache', 'memcached'
		'cache_translation'		=>	false,	// false or 'xcache', 'memcache', 'memcached'
		'cache_session'			=>	false		// false or 'xcache', 'memcache', 'memcached'
		)
	);
