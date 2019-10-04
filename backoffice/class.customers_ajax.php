<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.ajax.php');

class backoffice_customers_ajax extends lib_ajax {

    function __construct()
    {
    	$this->appTable 		= 'customers';
    	$this->appRecordId		= 'company_id';    	
    	$this->appRecordName	= 'company_alias';    	
    	$this->appOrderBy		= 'created';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'backoffice_customers';
    	$this->appNameSingular	= 'backoffice_customer';    	
    	$this->appLabel 		= 'Customers';
    	$this->appLabelSingular = 'Customer';    
    	$this->appXSL 			= 'backoffice.customers';
    	$this->appRole 			= 'backoffice';  
    }
}
