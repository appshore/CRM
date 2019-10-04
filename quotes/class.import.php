<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */

// class quote extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.import.php');

class quotes_import extends lib_import {

    function __construct()
    {
		// we call the parent class
   		parent::__construct();  
   		      
		execMethod( 'quotes.base.menus', null, true);
        
        $this->appName = 'quotes';
        $this->appRole = 'quotes';
        $this->importTable = 'quotes';
        $this->importIndex = 'quote_id';  
        
		$this->specific['Quotes']['created'] = 0 ;      
		$this->specific['Quotes']['rejected'] = 0 ;         
    }

	function importSpecific( $tmpTable, $record)
	{
		// we test if targeted user_id exists and if current user as some rights on him
		// if not record goes with current user
		if( strlen($record['user_id']) == 0 || $GLOBALS['appshore']->rbac->checkPermissionOnUser($this->appRole, $record['user_id']) == false )
			$record['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
								
		// check if quote exist within the same account
		$quote = getOneAssocArray( 'select * from quotes where lower(quote_name) like "%'.strtolower($record['quote_name']).'%"');
			
		if( !isset($quote['quote_id']) )
		{		
			// we create a new quote
			if( ($quote['quote_id'] = insertRow( 'quotes', 'quote_id', $record, false)) == NULL )
				$this->specific['Quotes']['rejected']++;
			else
				$this->specific['Quotes']['created']++;
		}	
		else
			$this->specific['Quotes']['rejected']++;
				
	}
  
}
