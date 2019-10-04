<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

$GLOBALS['appshore_interface'] = 'json';

if( !isset( $_SERVER ) )
{
	$result['api']['status'] = ERROR;
	$result['api']['error']['code'] = 'ERROR_INVALID_DOMAIN_NAME';
	$result['api']['error']['message'] = ERROR_INVALID_DOMAIN_NAME;
	echo json_encode($result);
	exit();
}

defined('SEP') or define('SEP', '/');
$GLOBALS['distrib_dir'] = getcwd();
$GLOBALS['config_dir'] = $GLOBALS['distrib_dir'].SEP.'config';

$subdomain = '';
list( $subdomain, $domain, $tld) = explode( '.', $_SERVER['SERVER_NAME'] );

if( !isset($tld) )
	header('Location: http://www.'.$subdomain.'.'.$domain);

if(isset($subdomain) && isset($domain) && file_exists($GLOBALS['config_dir'].SEP.$subdomain.'.'.$domain.'.'.$tld.'.cfg.php') )
{
	$GLOBALS['config_file'] = $GLOBALS['config_dir'].SEP.$subdomain.'.'.$domain.'.'.$tld.'.cfg.php';	
}
else if(isset($subdomain) && isset($domain) && file_exists($GLOBALS['config_dir'].SEP.$domain.'.'.$tld.'.cfg.php') )
{
	$GLOBALS['config_file'] = $GLOBALS['config_dir'].SEP.$domain.'.'.$tld.'.cfg.php';	
}
else
{
	$result['api']['status'] = ERROR;
	$result['api']['error']['code'] = 'ERROR_INVALID_DOMAIN_NAME';
	$result['api']['error']['message'] = ERROR_INVALID_DOMAIN_NAME;
	echo json_encode($result);
	exit();
}

$baseurl = ($_SERVER['SERVER_PORT'] == '443' )?'https://':'http://';
$baseurl .= $subdomain.'.'.$domain.'.'.$tld;


// we want to force the usage of the dedicated api classes so we insert the string "api" in the op variable
// this will protect more or less the standard classes from indelicate usage
$dotCount = substr_count($_REQUEST['op'],'.');
if( $dotCount == 1 )
{
	list( $appname, $methodname) = explode( '.', $_REQUEST['op'] );
	$_REQUEST['op'] = $appname.'.api.'.$methodname;
}
else if( $dotCount == 2 )
{
	list( $appname, $classname, $methodname) = explode( '.', $_REQUEST['op'] );
	$_REQUEST['op'] = $appname.'.'.$classname.'_api.'.$methodname;
}
else if( $dotCount == 3 )
{
	list( $appname, $classname, $subclassname, $methodname) = explode( '.', $_REQUEST['op'] );
	$_REQUEST['op'] = $appname.'.'.$classname.'_'.$subclassname.'_api.'.$methodname;
}
else
{
	$result['api']['status'] = ERROR;
	$result['api']['error']['code'] = 'ERROR_PERMISSION_DENIED';
	$result['api']['error']['message'] = ERROR_PERMISSION_DENIED;
	echo json_encode($result);
	exit();
}	

$_POST['op'] = $_GET['op'] = $_REQUEST['op'] ;		

require_once($GLOBALS['config_file']);	
require_once('api/main.php');	


