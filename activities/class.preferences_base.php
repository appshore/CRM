<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class activities_preferences_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'activities_preferences';
    	$this->appRecordId		= 'user_id';    	
#    	$this->appRecordName	= 'user_id'; 
#    	$this->appOrderBy		= 'user_id';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'activities_preferences';
    	$this->appNameSingular	= 'activities_preference';    	
    	$this->appLabel 		= 'Preferences';
    	$this->appLabelSingular = 'Preferences';    
    	$this->appXSL	 		= 'lib.preferences';
    	$this->appRole 			= 'activities';

		$this->weekDays = array(
		    	array('option_id' => 1,	'option_name' => 'Monday'),
		    	array('option_id' => 2,	'option_name' => 'Tuesday'),
		    	array('option_id' => 3, 'option_name' => 'Wednesday'),
				array('option_id' => 4, 'option_name' => 'Thursday'),
				array('option_id' => 5,	'option_name' => 'Friday'),
		    	array('option_id' => 6, 'option_name' => 'Saturday'),
		    	array('option_id' => 0,	'option_name' => 'Sunday')
		        );    

		$this->tabs = array(
				array('option_id' => 'activities',	'option_name' => 'Activities'),
				array('option_id' => 'day',			'option_name' => 'Day'),
				array('option_id' => 'week',		'option_name' => 'Week'),
				array('option_id' => 'month',		'option_name' => 'Month')
				);

		$this->incHours = array(
				array('option_id' => 900,	'option_name' => '15 minutes'),
				array('option_id' => 1800,	'option_name' => '30 minutes'),
				array('option_id' => 3600,	'option_name' => '1 hour')
				);

		$this->duration = array(
				array('option_id' => 900,	'option_name' => '15 minutes'),
				array('option_id' => 1800,	'option_name' => '30 minutes'),
				array('option_id' => 2700,	'option_name' => '45 minutes'),
				array('option_id' => 3600,	'option_name' => '1 hour')
				);

		$this->daysPerWeek = array(
				array('option_id' => 5,	'option_name' => '5'),
				array('option_id' => 6,	'option_name' => '6'),
				array('option_id' => 7,	'option_name' => '7')
				);

        parent::__construct();    	
	}


	
	// view one profile
    function start($args)
    {
    	return $this->view($args);		
    } 	

	// view one profile
    function search($args)
    {
    	return $this->start($args);		
    } 
    
    function menus()
    {
    	execmethod('activities.base.menus');
		// we use a custom menu tab here so we remove the standard one
 		$GLOBALS['appshore']->remove_xsl('activities.base');
 		$GLOBALS['appshore']->remove_xsl('lib.custom');
    }
    
	
	// view one profile
    function view( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

    	if( getOneAssocArray('select user_id from activities_preferences where user_id ="'.$args['user_id'].'"') == null )
    		insertRow( 'activities_preferences', 'user_id', $args);

		$result = parent::view( $args);	

		$result['view_fields'] = $this->setField( $result['view_fields'], 'first_day_week', array( 
			'field_current_value' => searchArray( $this->weekDays, 'option_id', $result[$this->appNameSingular]['first_day_week'],'option_name')
			));				

		$result['view_fields'] = $this->setField( $result['view_fields'], 'tab_id', array( 
			'field_current_value' => searchArray( $this->tabs, 'option_id', $result[$this->appNameSingular]['tab_id'],'option_name')
			));				

		$result['view_fields'] = $this->setField( $result['view_fields'], 'inc_hour', array( 
			'field_current_value' => searchArray( $this->incHours, 'option_id', $result[$this->appNameSingular]['inc_hour'],'option_name')
			));				

		$result['view_fields'] = $this->setField( $result['view_fields'], 'duration', array( 
			'field_current_value' => searchArray( $this->duration, 'option_id', $result[$this->appNameSingular]['duration'],'option_name')
			));				

		$result['view_fields'] = $this->setField( $result['view_fields'], 'days_per_week', array( 
			'field_current_value' => searchArray( $this->daysPerWeek, 'option_id', $result[$this->appNameSingular]['days_per_week'],'option_name')
			));				

		return $result;	
    } 	

	
	// view one profile
    function edit( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		$result = parent::edit( $args);	

		// First day of the week
		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'first_day_week', array( 
			'field_current_value' => $result[$this->appNameSingular]['first_day_week'],
			'field_options' => $this->weekDays
			));		

		// default tab view
		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'tab_id', array( 
			'field_current_value' => $result[$this->appNameSingular]['tab_id'],
			'field_options' => $this->tabs
			));

		// Size in seconds of the calendar box
		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'inc_hour', array( 
			'field_current_value' => $result[$this->appNameSingular]['inc_hour'],
			'field_options' => $this->incHours
			));

		// Size in seconds of the default activity
		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'duration', array( 
			'field_current_value' => $result[$this->appNameSingular]['duration'],
			'field_options' => $this->duration
			));

		// Visible days in the week/month views
		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'days_per_week', array( 
			'field_current_value' => $result[$this->appNameSingular]['days_per_week'],
			'field_options' => $this->daysPerWeek
			));	

		if( $args['key'] == 'Save' )
			unset($_SESSION['activities']['preferences']);

		return $result;	
    } 
       
    
}
