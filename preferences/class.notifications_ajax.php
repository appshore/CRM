<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

// class account extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.ajax.php');

class preferences_notifications_ajax extends lib_ajax 
{

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
	}
       
}
