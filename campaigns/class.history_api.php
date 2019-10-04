<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.api.php');

class campaigns_history_api extends lib_api{

    function __construct()
    {
    	$this->appTable 		= 'campaigns_history_view';
    	$this->appRecordId		= 'campaign_id';    	
    	$this->appRecordName	= 'campaign_name';    	
    	$this->appOrderBy		= 'run';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'campaigns_history';
    	$this->appNameSingular	= 'campaigns_history';    	
    	$this->appLabel 		= 'Campaign History';
    	$this->appLabelSingular = 'Campaign History';    
    	$this->appXSL	 		= 'campaigns.history_base';
    	$this->appRole 			= 'campaigns';

        parent::__construct();    	
    }    
}
