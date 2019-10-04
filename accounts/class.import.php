<?php
/**************************************************************************\
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* Brice MICHEL <bmichel@appshore.com>                                      *
* Copyright (C) 2004 - 2009 Brice MICHEL                                   *
\**************************************************************************/

// class account extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.import.php');

class accounts_import extends lib_import 
{

    function __construct()
    {
   		parent::__construct();  
   		      
		execMethod( 'accounts.base.menus', null, true);
        
        $this->appName = 'accounts';
        $this->appRole = 'accounts';
        $this->importTable = 'accounts';
        $this->importIndex = 'account_id';  
		$this->isDuplicate = false;		
		$this->isRelated = false;			
        
        
		$this->specific['Accounts']['created'] = 0 ;      
		$this->specific['Accounts']['rejected'] = 0 ;         
	    
    }

	function importSpecific( $tmpTable, $record)
	{
	
		// we test if targeted user_id exists and if current user as some rights on him
		// if not record goes with current user
		if( strlen($record['user_id']) == 0 || $GLOBALS['appshore']->rbac->checkPermissionOnUser($this->appRole, $record['user_id']) == false )
			$record['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		// check if main account exist
		if( $record['account_top_id'])
		{			
			$account_top = getOneAssocArray( 'select account_id from accounts where account_id = "'.$record['account_top_id'].'" limit 1');
				
			if( !isset($account_top['account_id']) )
				unset($record['account_top_id']); // we do not set main account if it does not exist already
		}		
		
		// if a main account name is defined but no main account id we check if we find a match else we ignore it
		if( $record['account_top_name'] && !isset($record['account_top_id']))
		{			
			$account_top = getOneAssocArray( 'select account_id from accounts where account_name = "'.$record['account_top_name'].'" limit 1');
				
			if( isset($account_top['account_id']) )
				$record['account_top_id'] = $account_top['account_id'];
		}
						
		// check if account exist
		if ( $this->isUnique['account_name'] == 'Y' )
		{
			$account = getOneAssocArray( 'select * from accounts where lower(account_name) = "'.strtolower($record['account_name']).'" limit 1');	
			
			if( isset($account['account_id']) )
			{	
				$this->specific['Accounts']['rejected']++;
				return ERROR_INSERT_DUPLICATED_VALUE;
			}

			$record['account_id'] = $account['account_id'];
		}
	
		// we create a new account
		if( ($account['account_id'] = insertRow( 'accounts', 'account_id', $record, true)) == NULL )
		{
			$this->specific['Accounts']['rejected']++;
			return ERROR_INSERT;
		}

		$this->specific['Accounts']['created']++;
		return true;
	}
  
}
