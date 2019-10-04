<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

chdir('..');
defined('SEP') or define('SEP', '/');
$GLOBALS['distrib_dir'] = getcwd();
$GLOBALS['config_dir'] = $GLOBALS['distrib_dir'].SEP.'config';

$subdomain = '';
list( $subdomain, $domain, $tld) = explode( '.', $_SERVER['SERVER_NAME'] );

if(isset($subdomain) && isset($domain) && file_exists($GLOBALS['config_dir'].SEP.$subdomain.'.'.$domain.'.'.$tld.'.cfg.php') )
{
	$GLOBALS['config_file'] = $GLOBALS['config_dir'].SEP.$subdomain.'.'.$domain.'.'.$tld.'.cfg.php';	
}
else if(isset($subdomain) && isset($domain) && file_exists($GLOBALS['config_dir'].SEP.$domain.'.'.$tld.'.cfg.php') )
{
	$GLOBALS['config_file'] = $GLOBALS['config_dir'].SEP.$domain.'.'.$tld.'.cfg.php';	
}

include_once($GLOBALS['config_file']);		

if( ($fp = @fopen( ($name = APPSHORE_STORAGE.SEP.'logo.gif'), 'rb')) )
	header("Content-Type: image/gif");
elseif( ($fp = @fopen( ($name = APPSHORE_STORAGE.SEP.'logo.png'), 'rb')) )
	header("Content-Type: image/png");
elseif( ($fp = @fopen( ($name = APPSHORE_STORAGE.SEP.'logo.jpg'), 'rb')) )
	header("Content-Type: image/jpeg");
elseif( ($fp = @fopen( ($name = APPSHORE_STORAGE.SEP.'logo.jpeg'), 'rb')) )
	header("Content-Type: image/jpeg");
else
{
	$fp = @fopen( ($name = APPSHORE_API.SEP.'images'.SEP.LOGO), 'rb');
	list( $ignore, $type) = explode( '.', LOGO);
	if( $type == 'jpg ')
		$type = 'jpeg';
	header("Content-Type: image/".$type);
}
header("Content-Length: " . filesize($name));
fpassthru($fp);
