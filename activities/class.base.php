<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class activities_base extends lib_base
{
	var $tabs;
	var $tab_id;

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

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

		if( isset($_SESSION[$this->appName]['preferences']) == false )
			$_SESSION[$this->appName]['preferences'] = getOneAssocArray('select * from activities_preferences where user_id ="'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
  	
 	}

 	function setTabs()
 	{
		if ( checkEdition() )
		{
	    	// define the periods list
		    $this->tabs = array(    
		        array ('tab_id' => 'activities', 	'tab_op' => $this->appName.'.activities.search',	'tab_name' => 'Activities'),
		        array ('tab_id' => 'day', 			'tab_op' => $this->appName.'.day.search',			'tab_name' => 'Day'),
		        array ('tab_id' => 'week', 		'tab_op' => $this->appName.'.week.search',			'tab_name' => 'Week'),
		        array ('tab_id' => 'month', 		'tab_op' => $this->appName.'.month.search',			'tab_name' => 'Month')
		        );          
				
	     	if( in_array($GLOBALS['appshore_data']['api']['classname'], array('activities','day','week','month')) )
				$this->tab_id = $_SESSION[$this->appName]['tab_id'] = $GLOBALS['appshore_data']['api']['classname'];			
	     	else if( isset($_SESSION[$this->appName]['tab_id']) )
				$this->tab_id = $_SESSION[$this->appName]['tab_id'];			
	     	else if( isset($_SESSION[$this->appName]['preferences']['tab_id']) )
				$this->tab_id = $_SESSION[$this->appName]['tab_id'] = $_SESSION[$this->appName]['preferences']['tab_id'];			
			else
				$this->tab_id = $_SESSION[$this->appName]['tab_id'] = 'activities';			
				
		}
		else
			// we don't want to keep the tab_id session context
			$this->tab_id = 'activities'; 	
 	}

   
    function menus()
    {
        $GLOBALS['appshore']->add_xsl('activities.base'); 
		parent::menus();   
		if( checkEdition() )
			$GLOBALS['appshore']->add_appmenu($this->appName, 'Preferences', $this->appName.'.preferences_base.start');
    }     
   
    function search($args=null)
    {
		$this->setTabs();
		
     	if( $GLOBALS['appshore_data']['api']['classname'] != $this->tab_id)
     	{
     		$GLOBALS['appshore_data']['api']['classname'] = $this->tab_id ;

			if( $this->tab_id != 'activities' )
     			return execMethod('activities.'.$this->tab_id.'.search', $args);     		
     		else
     		{
		    	$_SESSION[$this->appName]['tab_id'] = $this->tab_id = 'activities';
     			$GLOBALS['appshore']->add_xsl('activities.activities'); 
     		}
     	}
			
		$result = parent::search($args);

		// define next action		
		$result['tabs'] = $this->tabs;	

		// we use a custom menu tab here so we remove the standard one
  		$GLOBALS['appshore']->remove_xsl('lib.custom');

		// Put context in XML to be processed by XSL
		$result['recordset'] = $_SESSION[$this->appName];

		return $result;     
	} 
    	
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
		$start = round((int)(strtotime('+0 hour')/60),-1)*60;
        $entry['activity_start'] = gmdate('Y-m-d H:i', $start);	
		$duration = (int)($_SESSION[$this->appName]['preferences']['duration']?$_SESSION[$this->appName]['preferences']['duration']:'3600');
        $entry['activity_end'] = gmdate('Y-m-d H:i', $start+$duration);

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
			$args['activity_end'] = $GLOBALS['appshore']->local->datetimeToLocal(date('Y-m-d H:i', strtotime($GLOBALS['appshore']->local->localToDatetime($args['activity_start']).' +1 hour')));
    	}
        return true;
    }    	 		   
    
    	
    function defaultSessionApp($appName=null)
    {
    	parent::defaultSessionApp( $appName);
   		$_SESSION[$appName]['currentDateTime']	= $this->currentDateTime;
		$_SESSION[$appName]['tab_id'] 			= $this->tab_id;
	   	return $_SESSION[$appName];   
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
