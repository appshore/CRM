<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.popup.php');

class administration_orders_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'company_orders';
    	$this->appRecordId		= 'order_id';    	
    	$this->appRecordName	= 'product_name'; 
    	$this->appOrderBy		= 'created';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'administration_orders';
    	$this->appNameSingular	= 'administration_order';    	
    	$this->appLabel 		= 'Orders';
    	$this->appLabelSingular = 'Order';    
    	$this->appXSL	 		= 'administration.orders';
    	$this->appRole 			= 'administration';
    }
             	
}
