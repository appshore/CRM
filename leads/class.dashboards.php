<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.dashboards.php');

class leads_dashboards extends lib_dashboards 
{

    function __construct()
    {
    	$this->appTable 		= 'leads';
    	$this->appRecordId		= 'lead_id';    	
    	$this->appRecordName	= 'account_name';   
    	$this->appOrderBy		= 'account_name';    	
    	$this->appAscDesc		= 'asc';    	    	 	
    	$this->appName 			= 'leads';
    	$this->appNameSingular	= 'lead';    	
    	$this->appLabel 		= 'Leads';
    	$this->appLabelSingular = 'Lead';    
   		$this->appXSL 			= 'leads.base';
    	$this->appRole 			= 'leads';    	

        parent::__construct();    	
    }    
}
