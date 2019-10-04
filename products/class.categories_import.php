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

class products_categories_import extends lib_import {

    function __construct()
    {
		// we call the parent class
   		parent::__construct();  
   		      
		execMethod( 'products.categories_base.menus', null, false);
        
        $this->appName = 'products_categories';
        $this->appRole = 'products';

        $this->importTable = 'products_categories';
        $this->importIndex = 'category_id';  
        
		$this->specific['Categories']['created'] = 0 ;      
		$this->specific['Categories']['rejected'] = 0 ;         
    }

	function importSpecific( $tmpTable, $record)
	{
		// check if main category exist
		if( $record['category_top_id'])
		{			
			$category_top = getOneAssocArray( 'select category_id from products_categories where category_id = "'.$record['category_top_id'].'"');
				
			if( !isset($category_top['category_id']) )
			{
				// a trick to see if the id is not in fact a name
				$category_top = getOneAssocArray( 'select category_id from products_categories where lower(category_name) like "%'.
					strtolower($record['category_top_id']).'%"');

				if ( isset($category_top['category_id']) )
					$record['category_top_id'] = $category_top['category_id'];
				else
					unset($record['category_top_id']); // we do not set main category if it does not exist already
			}
		}

		// check if product exist within the same category
		if ( $record['category_top_id'] )
			$sql_category_top_id = ' and category_top_id = "'.$record['category_top_id'].'"';

		$category = getOneAssocArray( 'select * from products_categories where lower(category_name) like "%'.
				strtolower($record['category_name']).'%" '.$sql_category_top_id);
			
		
		if( !isset($category['category_id']) )
		{			
			// we create a new product
			if( ($category['category_id'] = insertRow( 'products_categories', 'category_id', $record, false)) == NULL )
				$this->specific['Categories']['rejected']++;
			else
				$this->specific['Categories']['created']++;
		}	
		else
			$this->specific['Categories']['rejected']++;
				
	}
  
}
