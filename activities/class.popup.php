<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.popup.php');

class activities_popup extends lib_popup
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

		if( isset($_SESSION[$this->appName]['preferences']) == false )
			$_SESSION[$this->appName]['preferences'] = getOneAssocArray('select * from cases_preferences where user_id ="'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
    }
    
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {    
		// default duration of a new activity
		$duration = (int)($_SESSION[$this->appName]['preferences']['duration']?$_SESSION[$this->appName]['preferences']['duration']:'3600');

    	// no predefined activity time
        if( is_numeric($args['activity_start']) == true )
        {
			// when a user clicks on the visual calendar
			// the format is number of seconds not string date/time
		 	$entry['activity_start'] = gmdate( 'Y-m-d H:i:s', $args['activity_start']);
	        $entry['activity_end'] = gmdate( 'Y-m-d H:i:s', (int)$args['activity_start']+$duration);
	        unset($args['activity_start']);
	    }
	    else if( isset($args['activity_start']) == false )
	    {
	    	// when a new activity is created as a related record
			$start = round((int)(strtotime('+0 hour')/60),-1)*60;
	        $entry['activity_start'] = gmdate( 'Y-m-d H:i', $start);
	        $entry['activity_end'] = gmdate( 'Y-m-d H:i', $start+$duration);
		}    
		
		$entry['type_id'] = $_SESSION[$this->appName]['preferences']['type_id']?$_SESSION[$this->appName]['preferences']['type_id']:'CA';
		$entry['status_id'] = $_SESSION[$this->appName]['preferences']['status_id']?$_SESSION[$this->appName]['preferences']['status_id']:'SC';
        $entry['priority_id'] = $_SESSION[$this->appName]['preferences']['priority_id']?$_SESSION[$this->appName]['preferences']['priority_id']:'NO';   
        $entry['reminder_email'] = $_SESSION[$this->appName]['preferences']['reminder_email']?$_SESSION[$this->appName]['preferences']['reminder_email']:'';   
        $entry['reminder_popup'] = $_SESSION[$this->appName]['preferences']['reminder_popup']?$_SESSION[$this->appName]['preferences']['reminder_popup']:'';   
		$entry['is_allday'] = 'N';

		return parent::newEntry( $args, $entry);
    }	 
    
    // Check mandatory fields and type of some
    function checkFields( &$args, &$edit_fields = null)
    {
    	if ( $GLOBALS['appshore']->local->localToDatetime($args['activity_end']) < $GLOBALS['appshore']->local->localToDatetime($args['activity_start']) )
    	{
			$args['activity_end'] = $GLOBALS['appshore']->local->datetimeToLocal(date( 'Y-m-d H:i', strtotime($GLOBALS['appshore']->local->localToDatetime($args['activity_start']).' +1 hour')));
    	}
        return true;
    }   
    
    
    // retrieve date for notifications
    function getNotificationStartDate( $args = null)
    {
        list( $date) = explode(' ', $GLOBALS['appshore']->local->localToDatetime($args['activity_start']));
        return $date;
    }
    
    // retrieve time for notifications
    function getNotificationStartTime( $args = null)
    {
        list( $date, $time) = explode(' ', $GLOBALS['appshore']->local->localToDatetime($args['activity_start']));
        return $time;
    }               
    
}
