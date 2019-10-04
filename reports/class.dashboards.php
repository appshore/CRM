<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.dashboards.php');

class reports_dashboards extends lib_dashboards 
{

    function __construct()
    {
    	$this->appTable 		= 'reports';
    	$this->appRecordId		= 'report_id';    	
    	$this->appRecordName	= 'report_name';   
    	$this->appOrderBy		= 'report_name';    	
    	$this->appAscDesc		= 'asc';    	    	 	
    	$this->appName 			= 'reports';
    	$this->appNameSingular	= 'report';    	
    	$this->appLabel 		= 'Reports';
    	$this->appLabelSingular = 'Report';    
   		$this->appXSL 			= 'reports.base';
    	$this->appRole 			= 'reports';
    }    
  
}
