<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/
 
class base_auth
{

	function login()
	{
		// if we are already auth (with valid session) no need to auth again
		if ( $GLOBALS['appshore']->session->is_anonymous() == true )
		{
			return $GLOBALS['appshore']->interface->login();
		}
	}
	
	function logout()
	{
		return $GLOBALS['appshore']->interface->logout();
	}
	
	function checkLogin()
	{			
		reg_var('appshore_user', 		'any', 'any');
		reg_var('appshore_pass', 		'any', 'any');
		reg_var('user_name', 			'any', 'any');
		reg_var('user_password', 		'any', 'any');
		reg_var('password_encrypted', 	'any', 'any');
		reg_var('language_id', 			'any', 'any');
		reg_var('login_ref', 			'any', 'any');
		reg_var('nextop', 				'any', 'any');

		// for historical reasons
		if ( isset($GLOBALS['appshore_data']['api']['user_name']) 
			&& ($GLOBALS['appshore_data']['api']['user_name'] != '') 
			&& isset($GLOBALS['appshore_data']['api']['user_password']) 
			&& ($GLOBALS['appshore_data']['api']['user_password'] != '') 
			)
		{
			$user_name = $GLOBALS['appshore_data']['api']['user_name'];	
			if( strtolower($GLOBALS['appshore_data']['api']['password_encrypted']) == 'md5' )
				$user_password = $GLOBALS['appshore_data']['api']['user_password'];
			else
				$user_password = md5($GLOBALS['appshore_data']['api']['user_password']);
			unset($GLOBALS['appshore_data']['api']['user_name']);
			unset($GLOBALS['appshore_data']['api']['user_password']);
		}		
		else if ( isset($GLOBALS['appshore_data']['api']['appshore_user']) 
			&& ($GLOBALS['appshore_data']['api']['appshore_user'] != '') 
			&& isset($GLOBALS['appshore_data']['api']['appshore_pass']) 
			&& ($GLOBALS['appshore_data']['api']['appshore_pass'] != '') 
			)
		{
			$user_name = $GLOBALS['appshore_data']['api']['appshore_user'];	
			if( strtolower($GLOBALS['appshore_data']['api']['password_encrypted']) == 'md5' )
				$user_password = $GLOBALS['appshore_data']['api']['appshore_pass'];
			else
				$user_password = md5($GLOBALS['appshore_data']['api']['appshore_pass']);
			unset($GLOBALS['appshore_data']['api']['appshore_user']);
			unset($GLOBALS['appshore_data']['api']['appshore_pass']);
		}		
		else if ( isset($GLOBALS['appshore_data']['api']['login_ref']) )
		{	// use when login came from another web site to pass securely user password
			list( $user_name, $user_password) = explode(' ', base64_decode($GLOBALS['appshore_data']['api']['login_ref']));
			unset($GLOBALS['appshore_data']['api']['login_ref']);
		}	
		else
			return false;	
				
		$GLOBALS['appshore']->rbac = createObject('base_rbac');

		// retrieve user creds			
		if ($GLOBALS['appshore']->rbac->authenticate($user_name,$user_password) == false )
		{
			$GLOBALS['appshore']->interface->bad_login(ERROR_AUTH_INVALID);
			return false;
		}

		// we need some company info
		$GLOBALS['appshore']->rbac->getCompanyInfos();

		// check the IP white list
		if ( $this->checkIPACL() == false )
		{
			$GLOBALS['appshore']->interface->bad_login(ERROR_AUTH_IPACL);
			return false;
		}
		
		// check the license
		$check = execMethod('base.license.check');

		// check the IP white list
		switch( $GLOBALS['appshore_data']['current_user']['status_id'] )
		{
			case 'D': // deactivated user
				$GLOBALS['appshore']->interface->bad_login(ERROR_AUTH_USER_DEACTIVATED);
				return false;
			case 'L': // locked user
				$GLOBALS['appshore']->interface->bad_login(ERROR_AUTH_USER_LOCKED);
				return false;
			case 'A': // activated user
			default:
				break;
		}
		
		// clean up the history		
		execMethod('base.history.truncateHistory');

		// update the statistics and save them in session var
		$_SESSION['statistics'] = execMethod('administration.statistics.updateCompanyStatistics');
		
		$GLOBALS['appshore']->session->setSession($user_name);
		$GLOBALS['appshore']->interface->good_login();
		return true;
	}
	
	
	function checkIPACL()
	{
		if( $GLOBALS['appshore_data']['my_company']['is_ipacl'] != 'Y' )
			return true;		
		
		$ips = explode( ' ', $GLOBALS['appshore_data']['my_company']['ipacl'].' '.$GLOBALS['appshore_data']['current_user']['ipacl']);

		foreach( $ips as $val)
			if( strlen($val) )
				$ip2[] = $val;

		// no acl defined for this user so free to login
		if( isset($ip2) == false )
			return true;
			
		return in_array( $this->getUserIP(), $ip2);
	}
	
	function getUserIP()
    {
        $ip = $_SERVER['REMOTE_ADDR'];

        if (isset($_SERVER['HTTP_CLIENT_IP']))
        {
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        }
        else if (isset($_SERVER['HTTP_X_FORWARDED_FOR']) AND preg_match_all('\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}#s', $_SERVER['HTTP_X_FORWARDED_FOR'], $matches))
        {
            // make sure we dont pick up an internal IP defined by RFC1918
            foreach ($matches[0] AS $val)
            {
                if (!preg_match("^(10|172\.16|192\.168)\.#", $val))
                {
                    $ip = $val;
                    break;
                }
            }
        }
        else if (isset($_SERVER['HTTP_FROM']))
        {
            $ip = $_SERVER['HTTP_FROM'];
        }

        return $ip;
    }	  		
	
	function recovery()
	{
		$args = new safe_args();
		$args->set('email',	NOTSET,'any');
		$args->set('key',	NOTSET,'string');			
		$args->set('mode',	NOTSET,'string');
		$args = $args->get(func_get_args());

		// deactivated for non human interface
		if( $GLOBALS['appshore_interface'] != 'html' )
		{
			return execMethod('administration.users_password.passwordRecovery', $args);
			//return $this->login();					
		}		
			
			
		switch( $args['key'] )
		{
			case 'Submit':	
				if ( execMethod('administration.users_password.passwordRecovery', $args) != NULL )
				{	
					messagebox('A new password will be sent to your email address', NOTICE);
					return $this->login();				
				}
				
   		        messagebox('Your password can not be recovered, contact your administrator', ERROR); 						
 				// NO break
				
			default:
				$GLOBALS['appshore_data']['layout'] = 'auth';
				$GLOBALS['appshore']->add_xsl('base.auth');
				$result['action']['auth'] = 'recovery';
				return $result;  
		}
	}	

}
