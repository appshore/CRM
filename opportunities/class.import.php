<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

// class opportunity extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.import.php');

class opportunities_import extends lib_import {

    function __construct()
    {
		// we call the parent class
   		parent::__construct();  
   		      
       	$GLOBALS['appshore']->add_appmenu('opportunities menu', 'Search', 'opportunities.base.search');
        if ( $GLOBALS['appshore']->rbac->check('opportunities', RBAC_USER_WRITE ) )
        {
        	$GLOBALS['appshore']->add_appmenu('opportunities menu', 'New opportunity', 'opportunities.base.edit');
        	$GLOBALS['appshore']->add_appmenu('opportunities menu', 'Import opportunities', 'opportunities.import.start');
        }
        
        $this->appName = 'opportunities';
        $this->appRole = 'opportunities';
        $this->importTable = 'opportunities';
        $this->importIndex = 'opportunity_id';  
        
		$this->specific['Opportunities']['created'] = 0 ;      
		$this->specific['Opportunities']['rejected'] = 0 ; 
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
						
		$record['account_id'] = $account['account_id'];
		
		// we create a new opportunity
		if( ($opportunity['opportunity_id'] = insertRow( 'opportunities', 'opportunity_id', $record, false)) == NULL )
		{
			$this->specific['Opportunities']['rejected']++;
			return ERROR_INSERT;
		}

		$this->specific['Opportunities']['created']++;			
		return true;
	}
  
}
