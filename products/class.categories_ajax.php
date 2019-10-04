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

class products_categories_ajax extends lib_ajax {
   
    function __construct()
    {
    	$this->appTable 		= 'products_categories';
    	$this->appRecordId		= 'category_id';    	
    	$this->appRecordName	= 'category_name';    	
    	$this->appOrderBy		= 'category_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'products_categories';
    	$this->appNameSingular	= 'products_category';    	
    	$this->appLabel 		= 'Categories';
    	$this->appLabelSingular = 'Category';    
    	$this->appXSL	 		= 'products.categories';
    	$this->appRole 			= 'products';
    }
    
}
