<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.dashboards.php');

class dailies_dashboards extends lib_dashboards 
{

    function __construct()
    {
    	$this->appTable 		= 'dailies';
    	$this->appRecordId		= 'contact_id';    	
    	$this->appRecordName	= 'full_name'; 
    	$this->appWhereFilter	= '';    	
    	$this->appOrderBy		= 'full_name';    	
    	$this->appAscDesc		= 'asc';    	    	   	
    	$this->appName 			= 'dailies';
    	$this->appNameSingular	= 'daily';    	
    	$this->appLabel 		= 'Dailies';
    	$this->appLabelSingular = 'Daily';    
    	$this->appXSL 			= 'dailies.base';
    	$this->appRole 			= 'dailies';
   }    
  
}
