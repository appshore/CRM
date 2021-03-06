<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

defined('SEP') or define('SEP', '/');
chdir( '..'.SEP.'..');
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

if( ($fp = @fopen( ($name = $_GET["fname"].'.gif'), 'rb')) )
	header("Content-Type: image/gif");
elseif( ($fp = @fopen( ($name = $_GET["fname"].'.png'), 'rb')) )
	header("Content-Type: image/png");
elseif( ($fp = @fopen( ($name = $_GET["fname"].'.jpg'), 'rb')) )
	header("Content-Type: image/jpeg");

header("Content-Length: " . filesize($name));
fpassthru($fp);
