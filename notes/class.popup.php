<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class notes_popup extends lib_popup
{

    function __construct()
    {
    	$this->appTable 		= 'notes';
    	$this->appRecordId		= 'note_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appWhereFilter	= '';    	
    	$this->appOrderBy		= 'subject';    	
    	$this->appAscDesc		= 'asc';    	    	   	
    	$this->appName 			= 'notes';
    	$this->appNameSingular	= 'note';    	
    	$this->appLabel 		= 'Notes';
    	$this->appLabelSingular = 'Note';    
    	$this->appXSL	 		= 'lib.stub';		// to replace non existant 'notes.base';
    	$this->appRole 			= 'notes';

        parent::__construct();    	

		if( isset($_SESSION[$this->appName]['preferences']) == false )
			$_SESSION[$this->appName]['preferences'] = getOneAssocArray('select * from notes_preferences where user_id ="'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
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
