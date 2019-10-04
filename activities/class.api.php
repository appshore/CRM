<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.api.php');

class activities_api extends lib_api 
{

    function __construct()
    {
    	$this->appTable 		= 'activities';
    	$this->appRecordId		= 'activity_id';    	
    	$this->appRecordName	= 'subject';    	
    	$this->appOrderBy		= 'activity_start';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'activities';
    	$this->appNameSingular	= 'activity';    	
    	$this->appLabel 		= 'Activities';
    	$this->appLabelSingular = 'Activity';    
    	$this->appXSL 			= 'activities.base';
    	$this->appRole 			= 'activities';

		parent::__construct();
    }
  
}
