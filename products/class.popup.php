<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2007 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class products_popup extends lib_popup
{

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
          
}
