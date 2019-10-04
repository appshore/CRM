<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */

$_SERVER['SERVER_NAME'] = 'net.bmfbm.com';

chdir( '..');	// appshore env root

require_once( 'config.php'); // load index to retrieve some global params and constants
require_once( APPSHORE_INCLUDES . SEP . 'adodb' . SEP . 'adodb.inc.php');
include_once( APPSHORE_LIB.SEP.'lib.inc.php');
include_once( 'class.pop3.php');

class api_appshore
{
	var $db; 
};
	
$GLOBALS['appshore'] = new api_appshore();

$GLOBALS['appshore']->db = ADONewConnection( $GLOBALS['appshore_data']['server']['db_type']);
if ( !$GLOBALS['appshore']->db->Connect( $GLOBALS['appshore_data']['server']['db_host'],$GLOBALS['appshore_data']['server']['db_user'],$GLOBALS['appshore_data']['server']['db_pass'],$GLOBALS['appshore_data']['server']['db_name']) )
{
	// can not connect with the customer db so we go to the generic one
	// and we'll ask for more info
	echo 'Can\'t access database.\r\n';
	echo 'Please contact your System Administrator\r\n';
	exit;			
}

$batchmail = new webmail_pop3();

$batchmail->check();

echo "ok\n\r";
?>
	
