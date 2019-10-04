<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

// class contact extends export so requires it
require_once( APPSHORE_LIB . SEP . 'class.export.php');

class campaigns_export extends lib_export {

    function __construct()
    {
        $this->appName = 'campaigns';  
        $this->appRole = 'campaigns';  
    	$this->appRecordId = 'campaign_id';    	
    }
    
}
