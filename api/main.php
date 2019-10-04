<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2010 Brice Michel                                     *
***************************************************************************/
	
// Load core support functions
include_once(APPSHORE_API.SEP.'core_functions.inc.php');

// Load some DEFINE that need to be translated
include_once(APPSHORE_LIB.SEP.'lib.define.php');

// Initiate Applications lib functions		
include_once(APPSHORE_LIB.SEP.'lib.inc.php');

// setup of time base of config file
date_default_timezone_set($GLOBALS['appshore_data']['server']['timezone_id']);

/* Load main classes */
$GLOBALS['appshore'] = createObject('base_core');

//set up database context
include_once(APPSHORE_INCLUDES.SEP.'adodb'.SEP.'adodb-exceptions.inc.php'); 
include_once(APPSHORE_INCLUDES.SEP.'adodb'.SEP.'adodb.inc.php');

$GLOBALS['appshore']->db = ADONewConnection($GLOBALS['appshore_data']['server']['db_type']);

if ( !$GLOBALS['appshore']->db->Connect($GLOBALS['appshore_data']['server']['db_host'],$GLOBALS['appshore_data']['server']['db_user'],$GLOBALS['appshore_data']['server']['db_pass'],$GLOBALS['appshore_data']['server']['db_name']) )
{
	// can't connect with the customer db
    echo '</br>'.$GLOBALS['appshore_data']['server']['db_name'].' is not a valid name or company alias.</br></br>';
    echo 'Please check it carefully or contact your '.BRAND.' administrator.</br>';
    exit();	
}

// set the ADODB fetch mode
$GLOBALS['appshore']->db->SetFetchMode(ADODB_FETCH_ASSOC);
$ADODB_COUNTRECS = true;

// to enforce default character set
executeSQL( 'SET CHARACTER SET "utf8"');
		
if ( $GLOBALS['appshore_data']['server']['checkUpgrade'] == true )
{
	// auto update procedure of customers databases
	execMethod( 'base.upgrade.start', '', false);		
}

// Set XML container
include_once(APPSHORE_INCLUDES.SEP.'domi'.SEP.'domi.class.php');
$GLOBALS['xml_api'] = new DOMi('API');

// Set interface
$GLOBALS['appshore']->interface = createObject('api_interface_'.$GLOBALS['appshore_interface']);

// Set session handler
$GLOBALS['appshore']->session = createObject('base_sessions');

if ( $GLOBALS['appshore_interface'] != 'html' && isset($_REQUEST['op']) == false )
	$GLOBALS['appshore']->interface->login();
else
{
	$GLOBALS['appshore']->check_op();

	// when the session's user is set anonymous we force the logout
	if( isset($_SESSION['rbac']['api']['users']['anonymous']) )	
	{
		$GLOBALS['appshore']->session->deleteSession();
		unset($GLOBALS['appshore_data']['api']['methodname']);
#		execMethod('base.auth.logout');
#		exit();
	}

    if( isset($GLOBALS['appshore_data']['api']['methodname']) && $GLOBALS['appshore_data']['api']['methodname'] == 'logout' )
    {
        execMethod('base.auth.logout');
        exit();
    }

    if( isset($GLOBALS['appshore_data']['api']['methodname']) && $GLOBALS['appshore_data']['api']['methodname'] == 'login' )
	{
		execMethod( 'base.auth.checkLogin');			
		$GLOBALS['appshore']->load_base_classes(true);	
	}
	else
		$GLOBALS['appshore']->load_base_classes(false);	

	// verify security access before executing
	if ($GLOBALS['appshore']->rbac->check( $GLOBALS['appshore_data']['api']['appname'], RBAC_RUN_APP) )
	{		
		$result = execMethod( $GLOBALS['appshore_data']['api']['op'], $_REQUEST);

		// If the method doesn't exist we go to the default class entry method
		if($result == '##NOMETHOD##')
		{
			if( $GLOBALS['appshore_interface'] == 'xml')
				$result = execMethod( $GLOBALS['appshore_data']['api']['appname'].'.api.invalid', $_REQUEST);
			else
				$result = execMethod( $GLOBALS['appshore_data']['api']['appname'].'.'.$GLOBALS['appshore_data']['api']['classname'].'.start', $_REQUEST);

			// If the method still doesn't exist we go to the default app level
			if ($result == '##NOMETHOD##')
			{
				$result = execMethod( $GLOBALS['appshore_data']['api']['appname'].'.base.start', $_REQUEST);
				
				// last we go to the default app
				if ($result == '##NOMETHOD##')
					$result = execMethod( $GLOBALS['appshore_data']['server']['default_start_op'], $_REQUEST);
			}
		}			
	}
	else
	{		
		$result = execMethod( $GLOBALS['appshore_data']['server']['default_anon_op']);		
	}
}

$GLOBALS['appshore']->interface->handle_result($result);

