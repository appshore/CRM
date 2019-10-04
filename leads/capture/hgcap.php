<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class lead_capture {
  
 	// Open the Customer Database
	function setDatabase()
	{
		require_once(APPSHORE_INCLUDES . SEP . 'adodb' . SEP . 'adodb.inc.php');
		
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
		
		// to enforce default character set
		$GLOBALS['appshore']->db->Execute( 'SET CHARACTER SET "utf8"');		
	}
  
	function redirect( $url)
	{			
		if( $url )
			header( 'location:'.$url);
		else
			header( 'location:'.$_SERVER['HTTP_REFERER']);		
	}
	
	function sqlsafe( $value) 
	{
		return preg_match("/^[\w\s.!@#$%^&*()+=-]+$/", $value);
	}
	
	function cleanup( $value) 
	{
		$search = array(
	     	'/[\x00-\x09\x0b\x0c\x0e-\x1f]/i'    	// all other non-ascii  minus \x7f-\x9f
	   	);
	   	return preg_replace( $search,'',$value);			
	}	
  
}

chdir('../..');
define('SEP', '/');
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
include_once(APPSHORE_API.SEP.'core_functions.inc.php');
include_once(APPSHORE_LIB.SEP.'lib.inc.php');

chdir('leads');
$capture = new lead_capture;
$capture->setDatabase();

$GLOBALS['appshore']->local = createObject('base_localization');					
$GLOBALS['appshore_data']['current_user']['locale_date_id']	= $GLOBALS['appshore_data']['server']['locale_date_id'];
$GLOBALS['appshore_data']['current_user']['locale_time_id']	= $GLOBALS['appshore_data']['server']['locale_time_id'];
$GLOBALS['appshore_data']['current_user']['charset_id']	= $GLOBALS['appshore_data']['server']['charset_id'];
$GLOBALS['appshore_data']['current_user']['timezone_id'] = $GLOBALS['appshore_data']['server']['timezone_id'];

// Now we load translation specific to user language pref, current application and common api
$GLOBALS['appshore']->trans = createObject('base_translation');						
$GLOBALS['appshore']->trans->load();


$lead = array();

foreach( $fields = describeColumns('leads') as $fieldName => $fieldValue )
	if( isset($_REQUEST[$fieldName]) ) // && $capture->sqlsafe($_REQUEST[$fieldName]) )
		$lead[$fieldName] = $capture->cleanup($_REQUEST[$fieldName]);

$user = getOneAssocArray( 'select users.user_id, users.first_names, users.last_name, users.email, company.url from users, company where users.user_id = company.main_user_id');	
$lead['user_id'] = $user['user_id'];


$lead['full_name'] = setFullname($lead['first_names'],$lead['last_name']);
if ( ($lead['lead_id'] = insertRow( 'leads', 'lead_id', $lead)) == NULL )
{
	$capture->redirect( $_REQUEST['urlError']);
}
else
{
	if( $_REQUEST['emailAlert'] == 'yes' )
	{
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');		
		$mail = new emailer();
        $mail->getEmailerInformation();		
 		
        $leadFrom = $capture->cleanup($_REQUEST['leadFrom'] ? $_REQUEST['leadFrom'] : $_SERVER['HTTP_REFERER']);
        
		$mail->SMTPKeepAlive = true;	
		$mail->isHTML(true);	
		
      	$mail->From 	= 'support@'.CUSTOMER_DOMAIN;
		$mail->FromName = BRAND.' '.lang('lead capture');
	
		$mail->Subject 	= lang("New lead from ").$leadFrom.': '.$lead['account_name'].', '.$lead['first_names'].' '.$lead['last_name'];

		// HTML message
		$sep = "<BR/>";		
#		$mail->Body  = lang("Dear")." ".$user['first_names']." ".$user['last_name'].",".$sep.$sep;
#		$mail->Body .= lang("You've got a new lead from ").$leadFrom.".".$sep.$sep;
		$mail->Body = lang("You've got a new lead from ").$leadFrom.".".$sep.$sep;

		$mail->Body .= "<table>";			
		$mail->Body .= "<tr><td style='width:10em'></td><td></td></tr>";			
		$mail->Body .= "<tr><td>".lang("Date")."</td><td>: ". date("D M j Y G:i:s T")."</td></tr>";			
		$mail->Body .= "<tr><td>".lang("Company")."</td><td>: ". $lead['account_name']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("Website")."</td><td>: ". $lead['url']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("First name")."</td><td>: ". $lead['first_names']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Last name")."</td><td>: ". $lead['last_name']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Phone")."</td><td>: ". $lead['phone']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Email")."</td><td>: ". $lead['email']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Address")."</td><td>: ". $lead['address_1']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("City")."</td><td>: ". $lead['city_1']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("State")."</td><td>: ". $lead['state_1']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("ZipCode")."</td><td>: ". $lead['zipcode_1']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Country")."</td><td>: ". $lead['country_1']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Note")."</td><td>: ". $lead['note']."</td></tr>";
		$mail->Body .= "<tr><td><br/></td><td></td></tr>";	
		$mail->Body .= "<tr><td>".lang("Browser")."</td><td>: ". $_SERVER['HTTP_USER_AGENT']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("IP address")."</td><td>: ". $_SERVER['REMOTE_ADDR']."</td></tr>";
		$mail->Body .= "</TABLE>".$sep.$sep;
		
		$mail->Body .= lang("Thank you for your business").$sep.$sep;
		$mail->Body .= "The AppShore Team.".$sep.$sep;	
        
        // modified because of invalid email address
        $emailTo= $capture->cleanup($user['email']); 	//$_REQUEST['emailTo'] ? $_REQUEST['emailTo'] : $user['email']); 	
		$mail->AddAddress( $emailTo);

		$mail->Send(); 		
	}
		
	$capture->redirect( $_REQUEST['urlSuccess']);		
}
