<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

// class note extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.import.php');

class notes_import extends lib_import {

    function __construct()
    {
		// we call the parent class
   		parent::__construct();  
   		      
		execMethod( 'notes.base.menus', null, true);
        
        $this->appName = 'notes';
        $this->appRole = 'notes';
        $this->importTable = 'notes';
        $this->importIndex = 'note_id';  
        
		$this->specific['Notes']['created'] = 0 ;      
		$this->specific['Notes']['rejected'] = 0 ;         
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
		if( $record['account_name'] )
		{			
			$account = getOneAssocArray( 'select * from accounts where lower(account_name) = "'.strtolower($record['account_name']).'" limit 1');
				
			if( !isset($account['account_id']) )
			{	
				// we create a new account
				if( ($account['account_id'] = insertRow( 'accounts', 'account_id', $record, false)) == NULL )				
					$this->specific['Accounts']['rejected']++;
				else			
					$this->specific['Accounts']['created']++;
			}
			
		}
		
		
		// check if contact exist
		if( $record['last_name'] && $record['first_names'])
		{			
			$contact = getOneAssocArray( 'select * from contacts where lower(last_name) like "%'.strtolower($record['last_name']).'%" and '.
			'lower(first_names) like "%'.strtolower($record['first_names']).'%"');
				
			if( !isset($contact['contact_id']) )
			{	
				$record['account_id'] = $account['account_id'];
			
				// we create a new contact
				if( ($contact['contact_id'] = insertRow( 'contacts', 'contact_id', $record, false)) == NULL )				
					$this->specific['Contacts']['rejected']++;
				else			
					$this->specific['Contacts']['created']++;
			}
		}		
						
		// we create a new note
		if( ($note['note_id'] = insertRow( 'notes', 'note_id', $record, false)) == NULL )
		{
			$this->specific['Notes']['rejected']++;
			return ERROR_INSERT;
		}
		
		$this->specific['Notes']['created']++;
		if( $account['account_id'] )
		{
			$link['from_id'] = $note['note_id'];
			$link['from_table'] = 'notes';
			$link['to_id'] = $account['account_id'];
			$link['to_table'] = 'accounts';
			insertRow( 'links', 'from_id', $link, false);
		}
		if( $contact['contact_id'] )
		{
			$link['from_id'] = $note['note_id'];
			$link['from_table'] = 'notes';
			$link['to_id'] = $contact['contact_id'];
			$link['to_table'] = 'contacts';
			insertRow( 'links', 'from_id', $link, false);
		}
			
		return true;
	}
  
}
