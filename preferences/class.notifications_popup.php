<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class preferences_notifications_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'notifications';
    	$this->appRecordId		= 'notification_id';    	
    	$this->appRecordName	= 'notification_date'; 
    	$this->appOrderBy		= 'notification_date';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'preferences_notifications';
    	$this->appNameSingular	= 'preferences_notification';    	
    	$this->appLabel 		= 'Notifications';
    	$this->appLabelSingular = 'Notification';    
    	$this->appXSL	 		= 'preferences.notifications';
    	$this->appRole 			= 'preferences';

        parent::__construct();    	
	}
       
}
