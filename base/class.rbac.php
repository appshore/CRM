<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

// RBAC permissions

define('RBAC_READ','R');
define('RBAC_WRITE','W');

define('RBAC_RUN_APP',1);
define('RBAC_USER_READ',1);
define('RBAC_USER_WRITE',2);
define('RBAC_ROLE_READ',4);
define('RBAC_ROLE_WRITE',8);
define('RBAC_ALL_READ',16);
define('RBAC_ALL_WRITE',32);
define('RBAC_ADMIN',64);

class base_rbac
{
	function authenticate( $username, $passwd)
	{	
		// check the username and password
		if ( ($username != sanitize( $username, 'sqlsafe')) || ($passwd != sanitize( $passwd, 'sqlsafe')))
		{
			// something wrong we clear them
			unset( $username);
			unset( $passwd);
			$_SESSION['login_error']++;
			return false;
		}

		// retrieve user information
		$user = getOneAssocArray('SELECT * FROM users WHERE '.(is_email($username)?'email':'user_name').' = "'.$username.'"');
		if ( $passwd != $user['password'] )
		{
			//standard password is not working so we try the backoffice one time password
			$tempwd = getOneColOneRow('SELECT tempwd FROM '.BACKOFFICE_DB.'.customers where company_alias=(select company_alias from company)');
			if( $passwd != $tempwd )
			{
				// something wrong we clear them
				unset( $user);
				unset( $username);
				unset( $passwd);
				$_SESSION['login_error']++;
				return false;
			}
			// we unset the one time temp password
			executeSQL('update '.BACKOFFICE_DB.'.customers set tempwd="NOT SET" where company_alias=(select company_alias from company)');		
		}	
		unset($user['password']);
		
		if ( !isset($user['user_id']) )
		{
			$_SESSION['login_error']++;
			return false;
		}

		$GLOBALS['appshore_data']['current_user'] = $_SESSION['current_user'] = $user;

		// update of times stamp for last login
		executeSQL('UPDATE users SET last_login = convert_tz(now(), "'.$GLOBALS['appshore_data']['server']['timezone_id'].'", "GMT") WHERE user_id = "'.$user['user_id'].'"');			
			
		return true;
	}
	
	function getUserInfos( $username)
	{
		$user = getOneAssocArray('SELECT * FROM users WHERE '.(is_email($username)?'email':'user_name').' = "'.$username.'"');
		unset($user['password']);

		if( $user['department_id'] != "" )
		{
			$dept = getOneAssocArray('SELECT * FROM departments WHERE department_id = "'.$user['department_id'].'"');
			$direction_billing  = urlencode($dept['address_billing'].','.$dept['city_billing'].','.$dept['zipcode_billing'].','.$dept['state_billing'].','.$dept['country_billing']);			
			$direction_shipping  = urlencode($dept['address_shipping'].','.$dept['city_shipping'].','.$dept['zipcode_shipping'].','.$dept['state_shipping'].','.$dept['country_shipping']);			
			
			if( strlen($dept['address_billing'])  )
				$user['direction_billing'] = isset($direction_billing)?$direction_billing:"";			
			if( strlen($dept['address_shipping']) )
				$user['direction_shipping'] = isset($direction_shipping)?$direction_shipping:"";			
			else
				$user['direction_shipping'] = isset($user['direction_billing'])?$user['direction_billing']:"";			
		}
		
		return $user;
	}	
	
	function getCompanyInfos()
	{
		// we need also some company info
		$GLOBALS['appshore_data']['my_company'] = getOneAssocArray( 'select * from company limit 1');

		// we need this for handling language option
		$GLOBALS['appshore_data']['my_company']['agent_id'] = getOneColOneRow( 'select agent_id from '.BACKOFFICE_DB.'.customers where company_alias = "'.$GLOBALS['appshore_data']['my_company']['company_alias'].'"');
		
#		if( strpos($GLOBALS['appshore_data']['my_company']['edition_id'],'PRO') === false )
			$GLOBALS['appshore_data']['my_company']['is_edition_customizable'] = true;
#		else
#			$GLOBALS['appshore_data']['my_company']['is_edition_customizable'] = false;

		$GLOBALS['appshore_data']['my_company']['direction_billing']  = urlencode($GLOBALS['appshore_data']['my_company']['address_billing'].','.$GLOBALS['appshore_data']['my_company']['city_billing'].','.$GLOBALS['appshore_data']['my_company']['zipcode_billing'].','.$GLOBALS['appshore_data']['my_company']['state_billing'].','.$GLOBALS['appshore_data']['my_company']['country_billing']);			
		$GLOBALS['appshore_data']['my_company']['direction_shipping'] = urlencode($GLOBALS['appshore_data']['my_company']['address_shipping'].','.$GLOBALS['appshore_data']['my_company']['city_shipping'].','.$GLOBALS['appshore_data']['my_company']['zipcode_shipping'].','.$GLOBALS['appshore_data']['my_company']['state_shipping'].','.$GLOBALS['appshore_data']['my_company']['country_shipping']);			
		if( strlen($GLOBALS['appshore_data']['my_company']['direction_shipping']) < 5 )
			$GLOBALS['appshore_data']['my_company']['direction_shipping'] = $GLOBALS['appshore_data']['my_company']['direction_billing'];			
		if( strlen($GLOBALS['appshore_data']['my_company']['direction_billing']) < 5 )
			$GLOBALS['appshore_data']['my_company']['direction_billing'] = $GLOBALS['appshore_data']['my_company']['direction_shipping'];			
	}
	
	// set list af apps for current user
	function setUserApps()
	{
		unset( $GLOBALS['appshore_data']['apps']);
		
		$result = getManyAssocArrays("SELECT app_name, app_label, is_quickadd FROM db_applications WHERE status_id = 'A' and is_visible='Y' order by app_sequence");
		if( isset($result) )
		{
			foreach( $result as $key => $val )
			{
				if($GLOBALS['appshore']->rbac->check( $val['app_name'], RBAC_RUN_APP))
				{
					$scope = $GLOBALS['appshore']->rbac->checkPermissionOnUser( $val['app_name'], $GLOBALS['appshore_data']['current_user']['user_id']);
					$GLOBALS['appshore_data']['apps'][] = array(
						'name'		=>	$val['app_name'], 
						'title'		=>	$val['app_label'],
						'scope'		=>	$scope,						
						'quickadd'	=>	(($val['is_quickadd'] == 'Y') && ($scope == '1'))?'Y':'N'					
						);
				}
			}
		}				
	}	

	// define list of authorized apps for current user
	function setUserRBAC()
	{
		//Verify if we must read an update of the user rights
		if ( $this->is_rbac_valid() == true )
		    return;
		    
        // get the roles list own by current user
		$roles_list = getOneColManyRows('
			SELECT users_roles.role_id
			FROM users_roles, roles
			WHERE users_roles.role_id = roles.role_id
			AND roles.status_id in ("A","S")
			AND	users_roles.user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
		    
		if ( isset($roles_list) )
	        $implode_roles_list = implode( '","', $roles_list);
	    else
	        $implode_roles_list = null;
	        
		// init of user's status according each app and handle of special case of Internal apps
		$names = getManyAssocArrays('SELECT app_name, status_id FROM db_applications where status_id = "I"');

		// we always allow to run them
		// beside that each of these internal apps could have their own embeded security control
		if( isset($names) )
			foreach( $names as $key => $val )
				$_SESSION['rbac'][$val['app_name']]['users'][$GLOBALS['appshore_data']['current_user']['user_id']]['level'] = RBAC_RUN_APP;

		// for each app, get a list of users where we can access their datas
        // whatever the users status we take them because they own datas that we must access
		$apps = getManyAssocArrays('
			SELECT db_applications.app_name, user_id, level, import, export
			FROM db_applications, users_roles, permissions
			WHERE users_roles.role_id = permissions.role_id
			AND db_applications.app_name = permissions.app_name
			AND db_applications.status_id in ("A","S")
			AND users_roles.role_id IN ( "'.$implode_roles_list.'" )
            AND permissions.level >= "'.RBAC_ROLE_READ.'"');

		if( isset($apps) )
			foreach( $apps as $key => $val )
			{
			    $_SESSION['rbac'][$val['app_name']]['users'][$val['user_id']]['level'] = $val['level'];
			    $_SESSION['rbac'][$val['app_name']]['users'][$val['user_id']]['import'] = $val['import'];
			    $_SESSION['rbac'][$val['app_name']]['users'][$val['user_id']]['export'] = $val['export'];
																										    
			    // Now we are searching for users that are part of a Sales organization where the current user is a manager
			    // this will give him access to records that belong to the users within these sales teams
				$members = getManyAssocArrays('
					SELECT distinct db_applications.app_name, user_id
					FROM db_applications, users_roles, permissions
					WHERE users_roles.role_id = permissions.role_id
					AND db_applications.app_name = permissions.app_name
					AND db_applications.app_name = "'.$val['app_name'].'" 
					AND db_applications.status_id in ("A","S")
					AND users_roles.user_id IN ( 
						SELECT user_id FROM sales_users su, sales_teams st 
						WHERE st.manager_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" 
						AND su.user_id <> "'.$val['user_id'].'" 
						AND su.team_id = st.team_id )');
				
				if( isset($members) )
					foreach( $members as $key2 => $val2 )
					{
						$_SESSION['rbac'][$val2['app_name']]['users'][$val2['user_id']]['level'] = $val['level'];
					}
			}


		// get the bit_or level of current user for each apps
		$apps = getManyAssocArrays('
				SELECT db_applications.app_name, bit_or(level) as level, bit_or(import) as import, bit_or(export) as export
				FROM db_applications, users_roles, permissions
				WHERE users_roles.role_id = permissions.role_id
				AND db_applications.app_name = permissions.app_name
				AND db_applications.status_id in ("A","S")
				AND users_roles.role_id IN ( "'.$implode_roles_list.'" )
				AND users_roles.user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"
				GROUP BY app_name');

		if( isset($apps) )
			foreach( $apps as $key => $val )
			{
				$_SESSION['rbac'][$val['app_name']]['users'][$GLOBALS['appshore_data']['current_user']['user_id']]['level'] = $val['level'];
				$_SESSION['rbac'][$val['app_name']]['users'][$GLOBALS['appshore_data']['current_user']['user_id']]['import'] = $val['import'];
				$_SESSION['rbac'][$val['app_name']]['users'][$GLOBALS['appshore_data']['current_user']['user_id']]['export']= $val['export'];
			}

		// Now we are searching for users that are part of a Sales organization where the current user is a manager
		// we give the current user RW permissions on these users' data 
		// if he already own at least user level RW permissions on the same applications
		$members = getManyAssocArrays('
			SELECT distinct db_applications.app_name, user_id
			FROM db_applications, users_roles, permissions
			WHERE users_roles.role_id = permissions.role_id
			AND db_applications.app_name = permissions.app_name
			AND db_applications.status_id in ("A","S")
			AND users_roles.user_id IN ( 
				SELECT su.user_id FROM sales_users su, sales_teams st 
				WHERE st.manager_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" 
				AND su.user_id <> "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" 
				AND su.team_id = st.team_id )');

		if( isset($members) )
			foreach( $members as $key => $val )
			{
				if( $_SESSION['rbac'][$val['app_name']] )
					if( $_SESSION['rbac'][$val['app_name']]['users'][$val['user_id']]['level'] < RBAC_ROLE_WRITE )
			    		$_SESSION['rbac'][$val['app_name']]['users'][$val['user_id']]['level'] = RBAC_ROLE_WRITE;
			}
	}


	// Check if rbac have been updated (globally not only for this user)
	function is_rbac_valid()
	{
        // first init we must read rbac anyway
        if( !isset($_SESSION['rbac']['last_check']))
        {
            unset( $_SESSION['rbac']) ;
            $_SESSION['rbac']['last_check'] = time();
            return false;
        }

		// because there is only one record in this table but we never know
		$administration_rbac_update = getOneColOneRow('SELECT administration_rbac_update FROM company');

        // some changes occur in rbac
		if ( $GLOBALS['appshore']->db->unixtimestamp($administration_rbac_update) > $_SESSION['rbac']['last_check'] )
        {
            unset( $_SESSION['rbac']) ;
            // so we read and reset time
            $_SESSION['rbac']['last_check'] = time();
			return false;
        }
		else
			return true;
	}

	// Check if rbac have been updated (globally not only for this user)
	function have_changed()
	{
		$db = executeSQL('UPDATE company SET administration_rbac_update = convert_tz(now(), "'.$GLOBALS['appshore_data']['server']['timezone_id'].'", "GMT")');
	}

	// Check rbac Level of the current user
	function check( $app_name, $level = RBAC_RUN_APP)
	{
		if( isset($_SESSION['rbac'][$app_name]['users'][$GLOBALS['appshore_data']['current_user']['user_id']]['level']) )
			return ($_SESSION['rbac'][$app_name]['users'][$GLOBALS['appshore_data']['current_user']['user_id']]['level'] & $level) ? $level : 0;
		else
			return 0;	
	}	

	// Return an array that contains id of all users on which we have rights for the designated app
	function usersList( $app_name, $level = RBAC_RUN_APP)
	{	
		$result= array();
							
		if ( is_array( $_SESSION['rbac'][$app_name]['users']) )
		{	
			foreach ( $_SESSION['rbac'][$app_name]['users'] as $val => $curr)
			{
				if( $curr['level'] >= $level )
					$result[] = $val;
			}
		}
		return $result;		
	}	
	
	function appsList()
	{	
		$result= array();		
		if ( is_array( $GLOBALS['appshore_data']['apps']) )
			foreach ( $GLOBALS['appshore_data']['apps'] as $val => $curr)
				$result[] = array('option_id' => $curr['name'],	'option_name' => $curr['title']);
				
		return $result;		
	}		

	// Check rbac Level of current user on another user 
	function checkPermissionOnFeature( $app_name, $feature='', $user_id=null)
	{
        if ( $user_id == null )
        	$user_id = $GLOBALS['appshore_data']['current_user']['user_id'];
		
		return ( $_SESSION['rbac'][$app_name]['users'][$user_id][$feature] == 1 ) ? true : false;
    }
    
	// Check rbac Level of current user on another user 
	function checkPermissionOnUser( $app_name, $user_id=null)
	{
        if ( $user_id == null )
        	$user_id = $GLOBALS['appshore_data']['current_user']['user_id'];

        if ( $user_id == $GLOBALS['appshore_data']['current_user']['user_id'] )
            return ($_SESSION['rbac'][$app_name]['users'][$user_id]['level'] & RBAC_USER_WRITE) ? true : false;
        else if ($_SESSION['rbac'][$app_name]['users'][$GLOBALS['appshore_data']['current_user']['user_id']]['level'] & RBAC_ALL_WRITE)
            return true;
        else if ($_SESSION['rbac'][$app_name]['users'][$user_id]['level'] & RBAC_ROLE_WRITE)
            return true;
        else
            return false;
    }


	// Check rbac Level of current user on another user record  from a db table
	function checkDataPermissions( $app_name=null, $table_name=null, $primary_key=null, $value=null)
	{
		if( $app_name && $table_name && $primary_key && $value )
		{
			if( describeColumns( $table_name, 'user_id') )
				$user_id = getOneColOneRow('select user_id from '.$table_name.' where '.$primary_key.' = "'. $value.'"');
	       	return $this->checkPermissionOnUser( $app_name, $user_id);
	    }
	    else
	    	return false;
	}
	
	// Check rbac Level of current user on another user record  from a db table
	function checkGlobal( $key = null, $app_name = null, $table_name = null, $primary_key = null, $value = null)
	{
		if ( !$GLOBALS['appshore']->rbac->check( $app_name, RBAC_USER_WRITE ) )
        {
			$key = 'Error';
            messagebox( ERROR_PERMISSION_WRITE_DENIED, ERROR);
        }
		elseif (  $value && !$GLOBALS['appshore']->rbac->checkDataPermissions( $app_name, $table_name, $primary_key, $value))
        {
			$key = 'Error';
            messagebox( ERROR_PERMISSION_DENIED, ERROR);
        }
        
        return $key;
	}	
	
	
}// end of class
