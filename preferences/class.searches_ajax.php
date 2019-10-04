<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

// class account extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.ajax.php');

class preferences_searches_ajax extends lib_ajax 
{

    function __construct()
    {
    	$this->appTable 		= 'searches';
    	$this->appRecordId		= 'search_id';    	
    	$this->appRecordName	= 'search_name'; 
    	$this->appOrderBy		= 'app_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'preferences_searches';
    	$this->appNameSingular	= 'preferences_search';    	
    	$this->appLabel 		= 'Search filters';
    	$this->appLabelSingular = 'Search filter';    
    	$this->appXSL	 		= 'preferences.searches';
    	$this->appRole 			= 'preferences';
	}
       
}
