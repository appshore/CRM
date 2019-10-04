<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class preferences_lookandfeel_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'users';
    	$this->appRecordId		= 'user_id';    	
    	$this->appRecordName	= 'user_name'; 
    	$this->appOrderBy		= 'user_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'preferences_lookandfeel';
    	$this->appNameSingular	= 'preferences_lookandfeel';    	
    	$this->appLabel 		= 'Presentation';
    	$this->appLabelSingular = 'Presentation';    
    	$this->appXSL	 		= 'preferences.lookandfeel';
    	$this->appRole 			= 'preferences';

		$this->notifications_location = array(
				array('option_id' => 'TL',	'option_name' => 'Top left'),
				array('option_id' => 'TC',	'option_name' => 'Top center'),
				array('option_id' => 'TR',	'option_name' => 'Top right'),
				array('option_id' => 'BL',	'option_name' => 'Bottom left'),
				array('option_id' => 'BC',	'option_name' => 'Bottom center'),
				array('option_id' => 'BR',	'option_name' => 'Bottom right')
				);   	

        parent::__construct();    	
	}

    function menus()
    {
		execMethod('preferences.base.menus');
	}
	
	// view one profile
    function start($args)
    {
    	return $this->view($args);		
    } 	

	// view one profile
    function search($args)
    {
    	return $this->view($args);		
    } 
    
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
		$entry['language_id'] 		=	$GLOBALS['appshore_data']['server']['language_id'];		
		$entry['locale_date_id'] 	=	$GLOBALS['appshore_data']['server']['locale_date_id'];		
		$entry['locale_time_id'] 	=	$GLOBALS['appshore_data']['server']['locale_time_d'];		
		$entry['charset_id'] 		=	$GLOBALS['appshore_data']['server']['charset_id'];		
		$entry['timezone_id'] 		=	$GLOBALS['appshore_data']['server']['timezone_id'];		
		$entry['currency_id'] 		=	$GLOBALS['appshore_data']['server']['currency_id'];
		$entry['theme_id'] 			=	$GLOBALS['appshore_data']['server']['theme_id'];						
		$entry['nbrecords'] 		=	$GLOBALS['appshore_data']['server']['nbrecords'];
		$entry['app_name'] 			=	$GLOBALS['appshore_data']['server']['default_start_op'];		
		$entry['confirm_delete'] 	= 	$GLOBALS['appshore_data']['server']['confirm_delete'];		
               
        return parent::newEntry( $args, $entry);
    }
    
	
	// view one profile
    function view( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		$result = parent::view( $args);	

		$result['view_fields'] = $this->setField( $result['view_fields'], 'notifications_location', array( 
			'field_current_value' => searchArray( $this->notifications_location, 'option_id', $result[$this->appNameSingular]['notifications_location'],'option_name')
			));				

		$result['view_fields'] = $this->setField( $result['view_fields'], 'timezone_id', array( 
			'field_current_value' => $GLOBALS['appshore']->local->timezone($result[$this->appNameSingular]['timezone_id'])
			));

		return $result;	
    } 	

	
	// view one profile
    function edit( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		$result = parent::edit( $args);	
		
		if( $args['key'] == 'Save' )
		{
			$_SESSION['current_user']['language_id'] = $GLOBALS['appshore_data']['current_user']['language_id'] = $result[$this->appNameSingular]['language_id'];
			setcookie( 'language', $GLOBALS['appshore_data']['current_user']['language_id']);
			header('location: '.$GLOBALS['appshore']->session->baseurl.'&op=preferences.lookandfeel_base.edit&msg=1');
		}
			
		if( $args['msg'] == 1 )
			messagebox( MSG_UPDATE);
				
		if( $GLOBALS['appshore_data']['my_company']['agent_id'] != 'jpn' )
			$result['edit_fields'] = $this->setField( $result['edit_fields'], 'language_id', array( 
				'field_options' => getManyAssocArrays('SELECT language_id as option_id, language_name as option_name FROM global_languages WHERE language_id <> "ja" order by language_id')
				));

		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'notifications_location', array( 
			'field_current_value' => $result[$this->appNameSingular]['notifications_location'],
			'field_options' => $this->notifications_location
			));

		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'timezone_id', array( 
			'field_current_value' => $result[$this->appNameSingular]['timezone_id'],
			'field_options' => $GLOBALS['appshore']->local->timezones()
			));

		// don't want to see list of users generated by default
		unset( $result['users']);

		// list of themes 
		$result['themes'] = getManyAssocArrays( 'select theme_id, theme_name from global_themes where is_available = "Y" order by theme_name');			

		$GLOBALS['appshore']->addPlugins( 'EditLines');		

		return $result;	
    } 
        
	// edit or create one lookandfeel
    function setNbRecords()
    {
		$user['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];	
		$user['nbrecords'] = $GLOBALS['appshore_data']['current_user']['nbrecords'] ;					
		updateRow( 'users', 'user_id', $user, false);
    }    
    
}
