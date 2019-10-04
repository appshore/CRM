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

// class product extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.import.php');

class products_import extends lib_import {

    function __construct()
    {
		// we call the parent class
   		parent::__construct();  
   		      
		execMethod( 'products.base.menus', null, false);
        
        $this->appName = 'products';
        $this->appRole = 'products';
                
        $this->importTable = 'products';
        $this->importIndex = 'product_id';  
        
		$this->specific['Products']['created'] = 0 ;      
		$this->specific['Products']['rejected'] = 0 ;         
    }

	function importSpecific( $tmpTable, $record)
	{
		// we test if targeted user_id exists and if current user as some rights on him
		// if not record goes with current user
		if( strlen($record['user_id']) == 0 || $GLOBALS['appshore']->rbac->checkPermissionOnUser($this->appRole, $record['user_id']) == false )
			$record['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
		
		// check if product exist within the same account
		$product = getOneAssocArray( 'select * from products where lower(product_name) like "%'.strtolower($record['product_name']).'%"');
			
		if( !isset($product['product_id']) )
		{			
			// we create a new product
			if( ($product['product_id'] = insertRow( 'products', 'product_id', $record, false)) == NULL )
				$this->specific['Products']['rejected']++;
			else
				$this->specific['Products']['created']++;
		}	
		else
			$this->specific['Products']['rejected']++;
				
	}
  
}
