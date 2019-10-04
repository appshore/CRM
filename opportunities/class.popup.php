<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class opportunities_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'opportunities';
    	$this->appRecordId		= 'opportunity_id';    	
    	$this->appRecordName	= 'opportunity_name';    	
    	$this->appOrderBy		= 'opportunity_name';    	
    	$this->appAscDesc		= 'asc';    	    	
    	$this->appName 			= 'opportunities';
    	$this->appNameSingular	= 'opportunity';    	
    	$this->appLabel 		= 'Opportunities';
    	$this->appLabelSingular = 'Opportunity';    
    	$this->appXSL	 		= 'opportunities.base';
    	$this->appRole 			= 'opportunities';

        parent::__construct();    	

		if( isset($_SESSION[$this->appName]['preferences']) == false )
			$_SESSION[$this->appName]['preferences'] = getOneAssocArray('select * from opportunities_preferences where user_id ="'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
	} 

    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
        $entry['closing'] = gmdate('Y-m-d');	
        $entry['stage_id'] = $_SESSION[$this->appName]['preferences']['stage_id']?$_SESSION[$this->appName]['preferences']['stage_id']:'';
        $entry['source_id'] = $_SESSION[$this->appName]['preferences']['source_id']?$_SESSION[$this->appName]['preferences']['source_id']:'';   
        $entry['type_id'] = $_SESSION[$this->appName]['preferences']['type_id']?$_SESSION[$this->appName]['preferences']['type_id']:'';   
        $entry['reminder_email'] = $_SESSION[$this->appName]['preferences']['reminder_email']?$_SESSION[$this->appName]['preferences']['reminder_email']:'';   
        $entry['reminder_popup'] = $_SESSION[$this->appName]['preferences']['reminder_popup']?$_SESSION[$this->appName]['preferences']['reminder_popup']:'';   
               
        return parent::newEntry( $args, $entry);
    }    	
    
    
    // retrieve date for notifications
    function getNotificationStartDate( $args = null)
    {
        return $GLOBALS['appshore']->local->localToDate($args['closing']);
    }
    
    // retrieve time for notifications
    function getNotificationStartTime( $args = null)
    {
        return 'NULL';
    }    

	
}
