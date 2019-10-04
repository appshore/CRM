<?php
/**************************************************************************\
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* Brice MICHEL <bmichel@appshore.com>                                      *
* Copyright (C) 2004 - 2009 Brice MICHEL                                   *
\**************************************************************************/

// class to enforce license control
class base_license
{

	function check()
	{   			
		// check only in certain editions
#		if( !in_array( substr($GLOBALS['appshore_data']['my_company']['edition_id'], 0, 3), array('PRO','PRE')) )
#			return true;
		// subscription expired, we close the account
		if ( ($GLOBALS['appshore_data']['my_company']['company_status'] == 'CLO') || 
			($GLOBALS['appshore_data']['my_company']['due_date'] != '0000-00-00' &&
			$GLOBALS['appshore_data']['my_company']['due_date'] < gmdate( 'Y-m-d', strtotime('today'))) )
		{
			$GLOBALS['appshore_data']['my_company']['company_status'] = 'CLO';
			$this->closeAccount();
			return false;
		}

		executeSQL('UPDATE company SET license_time_stamp=convert_tz(now(), "'.$GLOBALS['appshore_data']['server']['timezone_id'].'", "GMT")');	
		
		// if the subscription is close to end we display and/or send some message
		$this->endOfSubscriptionReminder();
		
		// set the users status according users quota
		$this->usersQuotaAvailable();

		return true;
	}
	
	// deactivate users above quota and return number of users available
	function usersQuotaAvailable()
	{   			
		//find out the current number of users
		$active = getOneColOneRow('select count(*) as active from users where status_id = "A"');

		// then we check against the quota limit
		if( $active > $GLOBALS['appshore_data']['my_company']['users_quota'] )
		{
			// and we lock every user above quota limit, last created users are the first locked
			executeSQL('update users set status_id = "L" where status_id = "A" order by created desc limit '.
				($active-$GLOBALS['appshore_data']['my_company']['users_quota']));

			// we need to reload the user profile company info if current user was deactivated
			$GLOBALS['appshore']->rbac->getUserInfos($GLOBALS['appshore_data']['current_user']['user_name']);
		}
		else if( $active < $GLOBALS['appshore_data']['my_company']['users_quota'] )
		{
			// Always freed every locked users by default in case the users quota has increased
			executeSQL('update users set status_id = "A" where status_id = "L" order by created asc limit '.
				($GLOBALS['appshore_data']['my_company']['users_quota']-$active));		
		}
		
		return ( $GLOBALS['appshore_data']['my_company']['users_quota']-$active ) ;
	}			
	
	function endOfSubscriptionReminder()
	{
		if ( $GLOBALS['appshore_data']['my_company']['due_date'] != '0000-00-00' && 
			$GLOBALS['appshore_data']['my_company']['due_date'] <= gmdate('Y-m-d', strtotime('today + 7 days')))
		{
			$days_left = ceil((strtotime($GLOBALS['appshore_data']['my_company']['due_date']) - strtotime('today'))/(24*3600)) ;
			
			if( $days_left < 0 )
			{
				if( strpos( $GLOBALS['appshore_data']['my_company']['edition_id'], 'TRIAL') )
					messagebox( ERROR_TRIAL_ENDED, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
				else
					messagebox( ERROR_SUBSCRIPTION_ENDED, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
			}
			else if( $days_left == 0 )
			{
				if( strpos( $GLOBALS['appshore_data']['my_company']['edition_id'], 'TRIAL') )
					messagebox( WARNING_TRIAL_END_TODAY, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
				else
					messagebox( WARNING_SUBSCRIPTION_END_TODAY, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
			}
			else
			{		
				if( strpos( $GLOBALS['appshore_data']['my_company']['edition_id'], 'TRIAL') )
					messagebox( WARNING_TRIAL_TO_END, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
				else
					messagebox( WARNING_SUBSCRIPTION_TO_END, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
			}
		}
	
	}
	
	// close the instance
    function closeAccount()
    {									
		execMethod('backoffice.customers.setStatus', array( 
			'sid' 				=> $soap_client->return['sid'], 
			'company_id' 		=> $GLOBALS['appshore_data']['my_company']['company_id'],
			'company_status' 	=> 'CLO'
			));				
			
		executeSQL('UPDATE company SET license_time_stamp = convert_tz(now(), "'.$GLOBALS['appshore_data']['server']['timezone_id'].'", "GMT"), company_status = "CLO"');	
    }  
}
	
