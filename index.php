<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

$GLOBALS['appshore_interface'] = 'html';

// return server context
if ( isset( $_GET['phpenv']) )
{
	if( $_GET['phpenv'] == 'appshore')
		phpinfo();
	exit();
}

if( !isset( $_SERVER ) )
{
	echo '<br/><br/>Invalid domain name.<br/><br/>';
	echo 'Please contact your administrator';
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
	echo '<br/><br/>Invalid domain name<br/><br/>';
	echo 'Please contact your administrator';
	exit();
}

$baseurl = ($_SERVER['SERVER_PORT'] == '443' )?'https://':'http://';
$baseurl .= $subdomain.'.'.$domain.'.'.$tld;

// maintenance stop
$maintenance = false;
if( $maintenance == true )
{
   echo '
       <div align="center" style="height:300px">
       <p style="font-size:16px">
       <br/><br/>
       <img class="image" src="http://www.appshore.com/api/images/appshore.png" style="border:0"/>
       <br/><br/>
       <text style="font-weight:bold">'.$baseurl.'</text> is currently under a scheduled maintenance.<br/>
       Expected downtime: Sunday December 2, 2012 from 06:00 UTC to 08:00 UTC<br/><br/>
       Contact support@appshore.com for any technical related request.<br/>
       Contact sales@appshore.com for any sale related enquiry.<br/><br/>
       Thank you for your understanding<br/>
       The AppShore Team
       </p>
       </div>
       ';
exit();
}

$useragent = $_SERVER['HTTP_USER_AGENT'];
if (preg_match('|MSIE ([0-9].[0-9]{1,2})|',$useragent,$matched))
{
    if( $matched[1] < 7 )
    {
    	echo '<H3>Your current browser is not able to fully support the features of this website.<br/>';
    	echo 'Please update it to a newer version.<br/>';
   		echo 'We do recommend the following standard compliant browsers (alphabetic order):';
    	echo '<ul><a href="http://www.google.com/chrome/">Chrome</a><br/>';
    	echo '<a href="http://www.firefox.com">Firefox</a><br/>';
    	echo '<a href="http://www.opera.com">Opera</a><br/>';
    	echo '<a href="http://www.apple.com/safari/">Safari</a></ul>';
    	echo 'The '.BRAND.' Team</H3>';
    	exit();
    }
}

require_once($GLOBALS['config_file']);	

// Start the page benchmark
if( $GLOBALS['appshore_data']['server']['performance'] == true )
	$GLOBALS['startBenchmark'] = microtime();    

if (@isset($GLOBALS['appshore_data']['server']['error_report']))
	error_reporting ((int)$GLOBALS['appshore_data']['server']['error_report']);

require_once('api/main.php');
