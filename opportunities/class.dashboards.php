<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.dashboards.php');

class opportunities_dashboards extends lib_dashboards 
{

    function __construct()
    {
    	$this->appTable 		= 'opportunities';
    	$this->appRecordId		= 'opportunity_id';    	
    	$this->appRecordName	= 'opportunity_name';    	
    	$this->appOrderBy		= 'opportunity_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'opportunities';
    	$this->appNameSingular	= 'opportunity';    	
    	$this->appLabel 		= 'Opportunities';
    	$this->appLabelSingular = 'Opportunity';    
    	$this->appXSL 			= 'opportunities.base';
    	$this->appRole 			= 'opportunities';
    }    
  
}
