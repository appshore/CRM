<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

// class contact extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.import.php');

class leads_import extends lib_import {

    function __construct()
    {
		execMethod( 'leads.base.menus', null, true);
        
        $this->appName = 'leads';
        $this->appRole = 'leads';
        $this->importTable = 'leads';
        $this->importIndex = 'lead_id';  
        
		$this->specific['Leads']['created'] = 0 ;      
		$this->specific['Leads']['rejected'] = 0 ;      	    
    }

	function importSpecific( $tmpTable, $record)
	{	
   		// we test if targeted user_id exists and if current user as some rights on him
		// if not record goes with current user
		if( strlen($record['user_id']) == 0 || $GLOBALS['appshore']->rbac->checkPermissionOnUser($this->appRole, $record['user_id']) == false )
			$record['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
						
		// we create a new lead
		$record['full_name'] = setFullname($record['first_names'],$record['last_name']);

		if( ($lead['lead_id'] = insertRow( 'leads', 'lead_id', $record, false)) == NULL )
		{
			$this->specific['Leads']['rejected']++;
			return ERROR_INSERT;
		}

		$this->specific['Leads']['created']++;		
		return true;		
	}
  
}
