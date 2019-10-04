<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/


require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class products_categories_popup extends lib_popup
{

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
    	$this->appXSL	 		= 'products_categories.base';
    	$this->appRole 			= 'products';

        parent::__construct();    	
    }
   	

}
