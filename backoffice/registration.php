<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class backoffice_registration
{

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


	// edit or create one registration
    function edit( $args)
    {
 		if( $args['key'] != 'Setup' ) 
# 			|| 
# 			(($_SERVER["SERVER_NAME"] != 'www.appshore.co.jp') && 
# 			 ($_SERVER["SERVER_NAME"] != 'www.appshore.com') &&  
# 			 ($_SERVER["SERVER_NAME"] != 'www.bmfbm.org')) )
        {                
			$this->redirect( $args['urlError'], '?msg='.lang('Access denied'));
			exit();
        }

		//lower company alias
		$args['company_id'] = $args['company_alias'] = strtolower( $args['company_alias']);			
			
        if ( $result['error'] = $this->checkFields($args) )
        {                
			// redirect to url error
			$this->redirect( $args['urlError'], '?msg='.json_encode($result['error']));
			exit();
        }

		if( execMethod( 'backoffice.customers.checkInstance', $args) == true )
		{
			// redirect to url error
			$this->redirect( $args['urlError'], '?msg='.lang('Instance already exists'));
			exit();
		}
			
		// specific limits for the trial of Premium edition		
		$args['edition_id'] = 'TRIAL';					// edition	
		$args['users_quota'] = 30;						// users	
		$args['disk_quota'] = 1024*1024*1024;			// Disk space		
		$args['records_quota'] = 100000;				// DB records		
		$args['emails_quota'] = 100;					// emails per day		
		$args['due_date'] = gmdate( 'Y-m-d', strtotime('+1 month')); 	// one month	
		
		if( $args['country_id'] == 'JPN' || $args['language_id'] == 'ja' || $_SERVER['SERVER_NAME'] == 'www.appshore.co.jp' )
		{
			$args['agent_id'] = 'jpn';
			$args['user_id'] = '4'; 
		}
		else if( $_SERVER['SERVER_NAME'] == 'www.appshore.com' )
		{
			$args['agent_id'] = 'inc';
			$args['user_id'] = 'b83v4ay1jxssoksg8s8cwwoo';
		}
	
		list($args['user_name']) = explode( '@', $args['email']); // user connect through email or user_name			
		$args['password'] = $args['userpwd1']; // password is stored crypted in database
		$args['company_status'] = 'REG'; 		
		$args['setupFrom'] = $_SERVER["SERVER_NAME"]; 		
		$args['remote_addr'] = $_SERVER['REMOTE_ADDR']; 					
		$args['domain_name'] = INSTANCES_DOMAIN;		
			
		// insert the company profile	
		if( execMethod( 'backoffice.customers.createCustomer', $args) == false )
		{
			// redirect to url error
			$this->redirect( $args['urlError'], '?msg='.lang('Customer can not be created'));
			exit();
		}	
		
		// create the instance
		if( execMethod( 'backoffice.customers.createInstance', $args) == false )
		{
			// set the password of the main user
			$user['user_name'] = $args['user_name'];
			$user['password'] = $args['userpwd1'];
			$user['country_id'] = $args['country_id'];
			$user['language_id'] = $args['language_id'];
			updateRow( PRIVATE_LABEL.$args['company_alias'].'.users', 'user_name', $user, false);
			// redirect to url error
			$this->redirect( $args['urlError'], '?msg='.lang('Instance can not be created'));
			exit();
		}	

		if( $args['industry_id'] )
		{
			$industry = getOneAssocArray( 'select industry_name from industries where industry_id = "'.$args['industry_id'].'"');
			$args['industry_name'] = $industry['industry_name'];
		}
		
		if( $args['country_id'] )
		{
			$country = getOneAssocArray( 'select country_name from global_countries where country_id = "'.$args['country_id'].'"');
			$args['country_name'] = $country['country_name'];
		}					
		
		// Send email to customer and registration email address
		$this->sendMail( $args, true);	

		// redirect to url success
		$this->redirect( $args['urlSuccess'], '?company_alias='.$args['company_alias']);
    } 
    
	
    function sendMail( $company, $is_success = false)
	{
		$sep = "<br/>";		
		// create mailer class and set up message
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');		
		$mail = new emailer();
        $mail->getEmailerInformation();
        
		$mail->SMTPKeepAlive = true;	
		$mail->isHTML(true);	
		
       	$mail->From 	 = 'registration@'.CUSTOMER_DOMAIN;
		$mail->FromName  = lang('%(BRAND)s - Registration', array('BRAND'=>BRAND));
			
		$mail->Body  = lang('Dear %(full_name)s,', array('full_name'=>$company['first_names'].' '.$company['last_name'])).$sep.$sep;

		if( $is_success == true )
		{
			$mail->Subject 	 = lang('Welcome to %(BRAND)s', array('BRAND'=>BRAND));

			$mail->Body .= lang('Thank you for registering for the free trial of %(BRAND)s.', array('BRAND'=>BRAND)).$sep.$sep;
			$mail->Body .= lang('To access your account, follow the link below and sign in with the email address and password selected during the registration process.').$sep.$sep;		
			$mail->Body .= 'http://'.$company['company_alias'].'.'.$company['domain_name'].$sep.$sep;
		}
		else
		{
			$mail->Subject = lang('Registration failed at %(BRAND)s', array('BRAND'=>BRAND));

			$mail->Body .= lang('The registration process for the free trial of %(BRAND)s has failed.', array('BRAND'=>BRAND)).$sep.$sep;
			$mail->Body .= lang('If you have any difficulty, please contact the %(BRAND)s Technical Support at %(SUPPORT_EMAIL)s', array('BRAND'=>BRAND,'SUPPORT_EMAIL'=>SUPPORT_EMAIL)).$sep.$sep;
		}	

		$mail->Body .= lang('Thank you for your business').$sep.$sep;
		$mail->Body .= lang('The %(BRAND)s Team', array('BRAND'=>BRAND)).$sep.$sep;
	  	         
		$mail->AddAddress( $company['email']);

		$mail->Send(); 
		
		// -----------------------------------send to registration@appshore.com------------------------------------

       	$mail->From 	 = 'registration@'.CUSTOMER_DOMAIN;
		$mail->FromName  = lang('%(BRAND)s - Registration', array('BRAND'=>BRAND));

		if( $is_success == true )
		{
			$mail->Subject = lang('Registration for free trial:').' '.$company['company_name'] ;
		}
		else
		{
			$mail->Subject = lang('Registration failed for free trial:').' '.$company['company_name'] ;
		}

		$mail->Body  = "<table>";			
		$mail->Body .= "<tr><td style='width:10em'></td><td></td></tr>";			
		$mail->Body .= "<tr><td>".lang("Date")."</td><td>: ". date("D M j Y G:i:s T")."</td></tr>";			
		$mail->Body .= "<tr><td>".lang("Company")."</td><td>: ". $company['company_name']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("Alias")."</td><td>: ". $company['company_alias']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("Training")."</td><td>: ". lang(($company['training'] == 1)?'Yes':'No')."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("Industry")."</td><td>: ". $company['industry_name']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("Website")."</td><td>: ". $company['url']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("Employees")."</td><td>: ". $company['employees']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("Salutation")."</td><td>: ". $company['salutation']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("First name")."</td><td>: ". $company['first_names']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Last name")."</td><td>: ". $company['last_name']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Title")."</td><td>: ". $company['title']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Phone")."</td><td>: ". $company['phone']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Email")."</td><td>: ". $company['email']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Address")."</td><td>: ". $company['address']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("City")."</td><td>: ". $company['city']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("State")."</td><td>: ". $company['state']."</td></tr>";		
		$mail->Body .= "<tr><td>".lang("ZipCode")."</td><td>: ". $company['zipcode']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Country")."</td><td>: ". $company['country_name']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Note")."</td><td>: ". $company['note']."</td></tr>";
		$mail->Body .= "<tr><td><br/></td><td></td></tr>";	
		$mail->Body .= "<tr><td>".lang("IP address")."</td><td>: ". $_SERVER['REMOTE_ADDR']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Browser")."</td><td>: ". $_SERVER['HTTP_USER_AGENT']."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Language")."</td><td>: ". $_SERVER["HTTP_ACCEPT_LANGUAGE"]."</td></tr>";
		$mail->Body .= "<tr><td>".lang("Charset")."</td><td>: ". $_SERVER["HTTP_ACCEPT_CHARSET"]."</td></tr>";
		$mail->Body .= "</TABLE>".$sep.$sep;
			
		$mail->ClearAddresses();
		if( $GLOBALS['appshore_data']['current_user']['language_id'] == 'ja' )
			$mail->AddAddress('japan@appshore.com');
		$mail->AddAddress('registration@appshore.com');

		$mail->Send(); 
		$mail->SmtpClose();				
		
		return;
	}	
	
  
	function redirect( $url, $param = '')
	{			
		if( $url )
			header( 'location:'.$url.$param);
		else
			header( 'location:'.$_SERVER['HTTP_REFERER'].$param);		
	}				
 
  
	function cleanup( $value) 
	{
		$search = array(
	     	'/[\x00-\x09\x0b\x0c\x0e-\x1f]/i'    	// all other non-ascii  minus \x7f-\x9f
	   	);
	   	return preg_replace( $search,'',$value);			
	}	
  
   
    
   // Check mandatory fields and type of some
    function checkFields( &$args )
    {
        unset( $result['error'] );

        if ( !isset($args['company_name']) )
            $result['error']['company_name'] = ERROR_MANDATORY_FIELD;

        if ( !is_alias($args['company_alias'] ) || !isset($args['company_alias']) )
            $result['error']['company_alias'] = ERROR_ALIAS_FIELD;

        if ( !isset($args['first_names']) )
            $result['error']['first_names'] = ERROR_MANDATORY_FIELD;

        if ( !isset($args['last_name']) )
            $result['error']['last_name'] = ERROR_MANDATORY_FIELD;
                        
        if ( !isset($args['email']) || !is_email($args['email']))
            $result['error']['email'] = ERROR_EMAIL_FIELD;      
            
        if ( !isset($args['country_id']) )
            $result['error']['country_id'] = ERROR_MANDATORY_FIELD;
                        
        if ( ($args['userpwd1'] != $args['userpwd2'] ) || (strlen($args['userpwd1']) < 6) || (strlen($args['userpwd2']) < 6 ) )
        {
            $result['error']['userpwd1'] = ERROR_PASSWORD_FIELD;
            $result['error']['userpwd2'] = ERROR_PASSWORD_FIELD;
            unset( $args['userpwd1'] ) ;
            unset( $args['userpwd2'] ) ;             
		}

        if ( $args['agreement'] == 'N' )
            $result['error']['agreement'] = ERROR_MANDATORY_FIELD;

        return $result['error'];
    }
	
}


chdir('..');           
defined('SEP') or define('SEP', '/');
$GLOBALS['distrib_dir'] = getcwd();
$GLOBALS['config_dir'] = $GLOBALS['distrib_dir'].SEP.'config';

$subdomain = '';
list( $subdomain, $domain, $tld) = explode( '.', $_SERVER['SERVER_NAME'] );

if( !isset($tld) )
	header('Location: http://www.'.$subdomain.'.'.$domain);

if(isset($subdomain) && isset($domain) && file_exists($GLOBALS['config_dir'].SEP.$subdomain.'.'.$domain.'.'.$tld.'.cfg.php') )
{
	$baseurl = ($_SERVER['SERVER_PORT'] == '443' )?'https://':'http://';
	$baseurl .= $subdomain.'.'.$domain.'.'.$tld;
	$GLOBALS['config_file'] = $GLOBALS['config_dir'].SEP.$subdomain.'.'.$domain.'.'.$tld.'.cfg.php';	
}
else if(isset($subdomain) && isset($domain) && file_exists($GLOBALS['config_dir'].SEP.$domain.'.'.$tld.'.cfg.php') )
{
	$baseurl = ($_SERVER['SERVER_PORT'] == '443' )?'https://':'http://';
	$baseurl .= $subdomain.'.'.$domain.'.'.$tld;
	$GLOBALS['config_file'] = $GLOBALS['config_dir'].SEP.$domain.'.'.$tld.'.cfg.php';	
}
else
{
	echo '<br/><br/>Invalid domain name<br/><br/>';
	echo 'Please contact your administrator';
	exit();
}

include_once($GLOBALS['config_file']);	
include_once(APPSHORE_API.SEP.'core_functions.inc.php');
include_once(APPSHORE_LIB.SEP.'lib.inc.php');

// set database access
$registration = new backoffice_registration;
$registration->setDatabase();

// set localization then set locales, database is needed at this stage
if( $_REQUEST['language_id'] )
	$GLOBALS['appshore_data']['current_user']['language_id'] = $_REQUEST['language_id'];		

// Now we load translation specific to user language pref, current application and common api
$GLOBALS['appshore']->local = createObject('base_localization');						
$GLOBALS['appshore']->local->getUserPreferences();	

// Now we load translation specific to user language pref, current application and common api
$GLOBALS['appshore']->trans = createObject('base_translation');						
$GLOBALS['appshore']->trans->load();

//chdir('backoffice');

$customer = array();

foreach( $fields = describeColumns('customers') as $fieldName => $fieldValue )
	if( isset($_REQUEST[$fieldName]) ) 
		$customer[$fieldName] = $registration->cleanup($_REQUEST[$fieldName]);

$customer['key'] 		= $_REQUEST['key'];
$customer['refid'] 		= $_REQUEST['refid'];
$customer['agreement'] 	= $_REQUEST['agreement'];
$customer['userpwd1'] 	= $_REQUEST['userpwd1'];
$customer['userpwd2'] 	= $_REQUEST['userpwd2'];
$customer['urlError'] 	= $_REQUEST['urlError'];
$customer['urlSuccess'] = $_REQUEST['urlSuccess'];
$customer['language_id'] = $GLOBALS['appshore_data']['current_user']['language_id'];		
$registration->edit($customer);

