<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class cases_popup extends lib_popup
{

    function __construct()
    {
    	$this->appTable 		= 'cases';
    	$this->appRecordId		= 'case_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appOrderBy		= 'due_date';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'cases';
    	$this->appNameSingular	= 'case';    	
    	$this->appLabel 		= 'Cases';
    	$this->appLabelSingular = 'Case';    
    	$this->appXSL	 		= 'cases.base';
    	$this->appRole 			= 'cases';

        parent::__construct();    	

		if( isset($_SESSION[$this->appName]['preferences']) == false )
			$_SESSION[$this->appName]['preferences'] = getOneAssocArray('select * from cases_preferences where user_id ="'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
    }
     
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
        $entry['due_date'] = gmdate('Y-m-d');	
        $entry['status_id'] = $_SESSION[$this->appName]['preferences']['status_id']?$_SESSION[$this->appName]['preferences']['status_id']:'IP';
        $entry['priority_id'] = $_SESSION[$this->appName]['preferences']['priority_id']?$_SESSION[$this->appName]['preferences']['priority_id']:'NO';   

        $entry['reminder_email'] = $_SESSION[$this->appName]['preferences']['reminder_email']?$_SESSION[$this->appName]['preferences']['reminder_email']:'';   
        $entry['reminder_popup'] = $_SESSION[$this->appName]['preferences']['reminder_popup']?$_SESSION[$this->appName]['preferences']['reminder_popup']:'';   
               
        return parent::newEntry( $args, $entry);
    }
    
        // retrieve date for notifications
    function getNotificationStartDate( $args = null)
    {
        return $GLOBALS['appshore']->local->localToDate($args['due_date']);
    }
    
    // retrieve time for notifications
    function getNotificationStartTime( $args = null)
    {
        return 'NULL';
    }
       	
}
