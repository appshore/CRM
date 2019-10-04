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
require_once( APPSHORE_LIB . SEP . 'class.ajax.php');

class products_ajax extends lib_ajax {
   
    function __construct()
    {
    	$this->appTable 		= 'products';
    	$this->appRecordId		= 'product_id';    	
    	$this->appRecordName	= 'product_name';    	
    	$this->appOrderBy		= 'product_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'products';
    	$this->appNameSingular	= 'product';    	
    	$this->appLabel 		= 'Products';
    	$this->appLabelSingular = 'Product';    
    	$this->appXSL 			= 'products.base';
    	$this->appRole 			= 'products';
    }
  
    
    function getProduct()
    {
		$args = new safe_args();
		$args->set('product_id', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore_data']['server']['client_render'] = true;
		$result['products'] = getOneAssocArray('select description, unit_id, sell_price from products where product_id = "'.$args['product_id'].'"');
		
		// mandatory to avoid error in ajax request
		if( $result['products'] )
			foreach( $result['products'] as $key => $value )
				if( $value == null )
					$result['products'][$key] = " ";

 		return $result;
    }	
    
  
}
