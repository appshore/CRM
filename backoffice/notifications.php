<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class backoffice_notifications
{

 	// Open the Customer Database
	function setDatabase()
	{
		include_once(APPSHORE_INCLUDES.SEP.'adodb'.SEP.'adodb-exceptions.inc.php'); 
		include_once(APPSHORE_INCLUDES.SEP.'adodb'.SEP.'adodb.inc.php');
		
		// connect to specific database
		$GLOBALS['appshore']->db = ADONewConnection($GLOBALS['appshore_data']['server']['db_type']);
		if ( !$GLOBALS['appshore']->db->Connect($GLOBALS['appshore_data']['server']['db_host'],$GLOBALS['appshore_data']['server']['db_user'],$GLOBALS['appshore_data']['server']['db_pass'],$GLOBALS['appshore_data']['server']['db_name']) )
		{
			// can not connect with the customer db so we go to the generic one
			// and we'll ask for more info
			echo 'Can\'t access database.<br>';
			echo 'Please contact your System Administrator';
			exit;		
		}
		
		// set the ADODB fetch mode
		$GLOBALS['appshore']->db->SetFetchMode(ADODB_FETCH_ASSOC);
		$ADODB_COUNTRECS = true;

		executeSQL('SET CHARACTER SET "utf8"');		
	}


	// these are notifications set on a date only
    function getDatedNotifications( $args=null)
    { 
		$notification_date = gmdate('Y-m-d');

		// retrieve notifications of the minute
    	$notifications = getManyAssocArrays('select distinct company_id from customers_notifications where notification_date = "'.$notification_date.'" and notification_time is NULL');

		if( $notifications )
		{
#	        $ch = curl_init();        	
#		    curl_setopt($ch, CURLOPT_HEADER, false);
#		    curl_setopt($ch, CURLOPT_NOBODY, true);
#		    curl_setopt($ch, CURLOPT_POST, true);
#	    	foreach( $notifications as $key => $val )
#	    	{
#		        curl_setopt($ch, CURLOPT_URL, 'http://'.$val['company_id'].'.'.INSTANCES_DOMAIN.'/xml.php');
#		        curl_setopt($ch, CURLOPT_POSTFIELDS, 'op=base.notifications.triggerEmailNotifications&notification_date='.$notification_date.'&notification_time=NULL');
#		        curl_exec($ch);   
#    		}
#            curl_close($ch);

			$this->execNotifications( $notification_date, 'NULL', $notifications);

			// delete processed notifications and older ones
	   		executeSQL('delete from customers_notifications where notification_date <= "'.$notification_date.'" and notification_time is null');
 	  	}

    } 

	// these are notifications set on a date and a time
    function getTimedNotifications( $args=null)
    { 
		list($notification_date, $notification_time) = explode(' ', gmdate('Y-m-d H:i:00'));
		// retrieve notifications of the minute
    	$notifications = getManyAssocArrays('select distinct company_id from customers_notifications where notification_date = "'.$notification_date.'" and notification_time = "'.$notification_time.'"');

		if( $notifications )
		{
#	        $ch = curl_init();        	
#		    curl_setopt($ch, CURLOPT_HEADER, false);
#		    curl_setopt($ch, CURLOPT_NOBODY, true);
#		    curl_setopt($ch, CURLOPT_POST, true);
#	    	foreach( $notifications as $key => $val )
#	    	{
#		        curl_setopt($ch, CURLOPT_URL, 'http://'.$val['company_id'].'.'.INSTANCES_DOMAIN.'/xml.php');
#		        curl_setopt($ch, CURLOPT_POSTFIELDS, 'op=base.notifications.triggerEmailNotifications&notification_date='.$notification_date.'&notification_time='.$notification_time);
#		        curl_exec($ch);   
#    		}
#            curl_close($ch);

			$this->execNotifications( $notification_date, $notification_time, $notifications);

	   		executeSQL('delete from customers_notifications where notification_date <= "'.$notification_date.'" and notification_time <= "'.$notification_time.'" and notification_time is not null');
 	  	}

  		
		// purge and optimize the table
   		executeSQL('delete from customers_notifications where notification_date < "'.$notification_date.'"');
		executeSQL('alter table customers_notifications order by notification_date, notification_time');	    		
    } 
    
    
	// these are notifications set on a date and a time
    function execNotifications( $notification_date, $notification_time, $notifications)
    { 
		// open the multi curl handler
		$mh = curl_multi_init();
	
		// init each curl socket and add it to the multi handler
		foreach( $notifications as $key => $val )
		{
			$ch[$key] = curl_init();        	
			curl_setopt($ch[$key], CURLOPT_HEADER, false);
			curl_setopt($ch[$key], CURLOPT_NOBODY, true);
			curl_setopt($ch[$key], CURLOPT_POST, true);
		    curl_setopt($ch[$key], CURLOPT_URL, 'http://'.$val['company_id'].'.'.INSTANCES_DOMAIN.'/xml.php');
		    curl_setopt($ch[$key], CURLOPT_POSTFIELDS, 'op=base.notifications.triggerEmailNotifications&notification_date='.$notification_date.'&notification_time='.$notification_time);
			curl_multi_add_handle($mh, $ch[$key]);
		}
	
		//execute the multi handler
		$running = null;
		do 
		{
			curl_multi_exec($mh, $running);
		} 
		while($running);    		
	
		// remove the handlers
		foreach( $notifications as $key => $val )
		{
			curl_multi_remove_handle($mh, $ch[$key]);
		    curl_close($ch[$key]);
		}
	
		// close the multi handler
		curl_multi_close($mh);
    }      	    
    	
}

// parse arguments
$args = parseArgs($argv);

chdir('..');           
defined('SEP') or define('SEP', '/');
$GLOBALS['distrib_dir'] = getcwd();
$GLOBALS['config_dir'] = $GLOBALS['distrib_dir'].SEP.'config';

$subdomain = '';
list( $subdomain, $domain, $tld) = explode('.', $args['domain']);//$_SERVER['SERVER_NAME'] );
$baseurl = $subdomain.'.'.$domain.'.'.$tld;

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
	echo "Invalid domain name\n";
	echo "Please contact your administrator\n";
	exit();
}

include_once($GLOBALS['config_file']);	
include_once(APPSHORE_API.SEP.'core_functions.inc.php');
include_once(APPSHORE_LIB.SEP.'lib.inc.php');

// set database access
$registration = new backoffice_notifications;
$registration->setDatabase();

// Now we load translation specific to user language pref, current application and common api
#$GLOBALS['appshore']->local = createObject('base_localization');						
#$GLOBALS['appshore']->local->getUserPreferences();	

// Now we load translation specific to user language pref, current application and common api
#$GLOBALS['appshore']->trans = createObject('base_translation');						
#$GLOBALS['appshore']->trans->load();

// these are notifications set on a date only
$registration->getDatedNotifications();

// these are notifications set on a date and a time
$registration->getTimedNotifications();

function parseArgs($argv)
{
    array_shift($argv); $o = array();
    foreach ($argv as $a){
        if (substr($a,0,2) == '--'){ $eq = strpos($a,'=');
            if ($eq !== false){ $o[substr($a,2,$eq-2)] = substr($a,$eq+1); }
            else { $k = substr($a,2); if (!isset($o[$k])){ $o[$k] = true; } } }
        else if (substr($a,0,1) == '-'){
            if (substr($a,2,1) == '='){ $o[substr($a,1,1)] = substr($a,3); }
            else { foreach (str_split(substr($a,1)) as $k){ if (!isset($o[$k])){ $o[$k] = true; } } } }
        else { $o[] = $a; } }
    return $o;
}

