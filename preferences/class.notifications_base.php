<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class preferences_notifications_base extends lib_base
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
 
        parent::__construct();    	
	}

    function menus()
    {
		execMethod('preferences.base.menus');
	}

  	
   	
	// search
    function search( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		$result = parent::search( $args);	
		
  	   	if( $result[$this->appName])
			foreach( $result[$this->appName] as $key => $val)
				$result[$this->appName][$key]['record_id'] = $this->getRecordName( $val['related_app_name'],  $val['record_id']);
		
		return $result;	
    } 	

   	
	// view one profile
    function view( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		$result = parent::view( $args);	

		$result['view_fields'] = $this->setField( $result['view_fields'], 'record_id', array( 
			'field_current_value' => $this->getRecordName( $result[$this->appNameSingular]['related_app_name'], $result[$this->appNameSingular]['record_id'])
			));				
		
		return $result;	
    } 	
	
	// view one profile
    function edit( $args = null)
    {	
		return $this->view($args);
    } 
    
    
    function getRecordName($appName, $recordId)
    {
		switch( $appName )
		{
			case 'Activities' :
				$recordName = getOneColOneRow('select subject as record_name from activities where activity_id="'.$recordId.'"');
				break;
			case 'Cases' :
				$recordName = getOneColOneRow('select subject as record_name from cases where case_id="'.$recordId.'"');
	 			break;
			case 'Opportunities' :
				$recordName = getOneColOneRow('select opportunity_name as record_name from opportunities where opportunity_id="'.$recordId.'"');
	 			break;
		}
    
		return $recordName;    
    }
        
}
