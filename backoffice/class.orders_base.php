<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class backoffice_orders_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'customers_orders';
    	$this->appRecordId		= 'customers_order_id';    	
    	$this->appRecordName	= 'customers_user_name'; 
    	$this->appOrderBy		= 'customers_user_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'backoffice_orders';
    	$this->appNameSingular	= 'backoffice_order';    	
    	$this->appLabel 		= 'Orders';
    	$this->appLabelSingular = 'Order';    
    	$this->appXSL 			= 'backoffice.orders';
    	$this->appRole 			= 'backoffice';  

        parent::__construct();    	
    }

	function menus()
	{
		execMethod('backoffice.base.menus');
	}

	
}
