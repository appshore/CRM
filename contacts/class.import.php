<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * \*************************************************************************
 */

// class contact extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.import.php');

class contacts_import extends lib_import {

    function __construct()
    {
		// we call the parent class
   		parent::__construct();  
   		      
		execMethod( 'contacts.base.menus', null, true);
        
        $this->appName = 'contacts';
        $this->appRole = 'contacts';
        $this->importTable = 'contacts';
        $this->importIndex = 'contact_id';  
        
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

		// check if account exist
		if( $record['account_id'])
		{			
			$account = getOneAssocArray( 'select account_id from accounts where account_id = "'.$record['account_id'].'"');
				
			if( !isset($account['account_id']) )
			{
				// a trick to see if the id is not in fact a name
				$account = getOneAssocArray( 'select account_id from accounts where lower(account_name) like "%'.
					strtolower($record['account_id']).'%"');

				if ( isset($account['account_id']) )
					$record['account_id'] = $account['account_id'];
				else
				{
					$record['account_name'] = $record['account_id'];	
					
					unset($record['account_id']);
					
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
			}
		}

		// check if contact exist within the same account
		$contact = getOneAssocArray( 'select * from contacts where lower(first_names) like "%'.
			strtolower($record['first_names']).'%" and lower(last_name) like "%'.
			strtolower($record['last_name']).'%" and lower(email) like "%'.
			strtolower($record['email']).
			'%" and account_id = "'.$account['account_id'].'"');
			
		if( isset($contact['contact_id']) )
		{	
			$this->specific['Contacts']['rejected']++;
			return ERROR_INSERT_DUPLICATED_VALUE;
		}
	
		$record['account_id'] = $account['account_id'];
	
		// we create a new contact
		$record['full_name'] = setFullname($record['first_names'],$record['last_name']);
		if( ($contact['contact_id'] = insertRow( 'contacts', 'contact_id', $record, false)) == NULL )
		{
			$this->specific['Contacts']['rejected']++;
			return ERROR_INSERT;
		}

		$this->specific['Contacts']['created']++;

		return true;
	}
  
}
