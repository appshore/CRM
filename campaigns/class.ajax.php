<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.ajax.php');

class campaigns_ajax extends lib_ajax {

    function __construct()
    {
    	$this->appTable 		= 'campaigns';
    	$this->appRecordId		= 'campaign_id';    	
    	$this->appRecordName	= 'subject';    	
    	$this->appOrderBy		= 'campaign_name';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'campaigns';
    	$this->appNameSingular	= 'campaign';    	
    	$this->appLabel 		= 'Campaigns';
    	$this->appLabelSingular = 'Campaign';    
    	$this->appXSL 			= 'campaigns.base';
    	$this->appRole 			= 'campaigns';		

        parent::__construct();    	
	}        
    
}
