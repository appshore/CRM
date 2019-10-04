<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.popup.php');

class backoffice_customers_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'customers';
    	$this->appRecordId		= 'company_id';    	
    	$this->appRecordName	= 'company_alias';    	
    	$this->appOrderBy		= 'created';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'backoffice_customers';
    	$this->appNameSingular	= 'backoffice_customer';    	
    	$this->appLabel 		= 'Customers';
    	$this->appLabelSingular = 'Customer';    
    	//$this->appXSL 			= 'backoffice.customers';
    	$this->appRole 			= 'backoffice';   	

        parent::__construct();    	
    }
}
