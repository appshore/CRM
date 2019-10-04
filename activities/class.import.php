<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

// class activity extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.import.php');

class activities_import extends lib_import {

    function __construct()
    {
		// we call the parent class
   		parent::__construct();  
   		      
		execMethod( 'activities.base.menus', null, true);
        
        $this->appName = 'activities';
        $this->appRole = 'activities';
        $this->importTable = 'activities';
        $this->importIndex = 'activity_id';  
        $this->isDuplicate = true;    
        $this->isRelated = true;                  
        
		$this->specific['Activities']['created'] = 0 ;      
		$this->specific['Activities']['rejected'] = 0 ;         
		$this->specific['Contacts']['created'] = 0 ;      
		$this->specific['Contacts']['rejected'] = 0 ;      
		$this->specific['Accounts']['created'] = 0 ;      
		$this->specific['Accounts']['rejected'] = 0 ;  	    
    }

	function importSpecific( $tmpTable, $record)
	{
	
		// we test if targeted user_id exists and if current user as some rights on him
		// if not record goes with current user
		if( strlen($record['user_id']) == 0 || $GLOBALS['appshore']->rbac->checkPermissionOnUser($this->appRole, $record['user_id']) == false )
			$record['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
			
   		if( $_SESSION['import']['related'] == 1 )	// we create related records like accounts or contacts if not exist
   		{
			// check if account exist
			if( $record['account_name'] )
			{			
				$account = getOneAssocArray( 'select * from accounts where lower(account_name) = "'.strtolower($record['account_name']).'" limit 1');
					
				if( !isset($account['account_id']))
				{	
					$user_id = $record['user_id'];
					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser('accounts', $record['user_id']) == false )
						$record['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
				
					// we create a new account
					if( ($account['account_id'] = insertRow( 'accounts', 'account_id', $record, false)) == NULL )				
						$this->specific['Accounts']['rejected']++;
					else			
						$this->specific['Accounts']['created']++;
						
					$record['user_id'] = $user_id;	// to restore the value of user_id in case we change it => needed for next operation
				}
				
				$record['account_id'] = $account['account_id'];			
			}
			
			
			// check if contact exist
			if( $record['last_name'] && $record['first_names'])
			{			
				$contact = getOneAssocArray( 'select * from contacts where lower(last_name) like "%'.strtolower($record['last_name']).'%" and '.
				'lower(first_names) like "%'.strtolower($record['first_names']).'%"');
					
				if( !isset($contact['contact_id']) )
				{	
					$record['account_id'] = $contact['account_id'];
					
					$user_id = $record['user_id'];
					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser('contacts', $record['user_id']) == false )
						$record['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
							
					// we create a new contact
					if( ($contact['contact_id'] = insertRow( 'contacts', 'contact_id', $record, false)) == NULL )				
						$this->specific['Contacts']['rejected']++;
					else			
						$this->specific['Contacts']['created']++;
						
					$record['user_id'] = $user_id;	// to restore the value of user_id in case we change it => needed for next operation
				}
		
				$record['contact_id'] = $contact['contact_id'];			
			}	
		}
			
   		if( $_SESSION['import']['duplicate'] == 0 )	// we do not allow duplicate
   		{
			$activity = getOneAssocArray( 'select * from activities where subject = "'.$record['subject'].
				'" and activity_start = "'.$record['activity_start'].'"  and user_id = "'.$record['user_id'].'"');
				
			// check if activity exist
			if( isset($activity['activity_id']) )
			{
				$this->specific['Activities']['rejected']++;
				return ERROR_INSERT_DUPLICATED_VALUE;
			}
		}

		// we create a new activity
		if( ($activity['activity_id'] = insertRow( 'activities', 'activity_id', $record, false)) == NULL )
		{
			$this->specific['Activities']['rejected']++;
			return ERROR_INSERT;
		}

		$this->specific['Activities']['created']++;				
		return true;
	}
  
}
