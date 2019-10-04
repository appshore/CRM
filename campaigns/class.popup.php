<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/
 
require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class campaigns_popup extends lib_popup {

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
    	$this->appXSL 			= 'campaigns.popup';
    	$this->appRole 			= 'campaigns';
		
        parent::__construct();    	
	}
	
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
        $entry['type_id'] = 'email';        
        $entry['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
        $entry['from_email'] = $GLOBALS['appshore_data']['current_user']['email'];
        $entry['from_name'] = $GLOBALS['appshore_data']['current_user']['full_name'];                return parent::newEntry( $args, $entry);
    }
    
}
