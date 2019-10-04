<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class notes_preferences_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'notes_preferences';
    	$this->appRecordId		= 'user_id';    	
#    	$this->appRecordName	= 'user_id'; 
#    	$this->appOrderBy		= 'user_id';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'notes_preferences';
    	$this->appNameSingular	= 'notes_preference';    	
    	$this->appLabel 		= 'Preferences';
    	$this->appLabelSingular = 'Preferences';    
    	$this->appXSL	 		= 'lib.preferences';
    	$this->appRole 			= 'notes';

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
		execMethod('notes.base.menus');   
 		$GLOBALS['appshore']->remove_xsl('lib.custom');
    }
    
	
	// view one profile
    function view( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

    	if( getOneAssocArray('select user_id from notes_preferences where user_id ="'.$args['user_id'].'"') == null )
    		insertRow( 'notes_preferences', 'user_id', $args);

		$result = parent::view( $args);	

		return $result;	
    } 	

	
	// view one profile
    function edit( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		$result = parent::edit( $args);	

		if( $args['key'] == 'Save' )
			unset($_SESSION['notes']['preferences']);

		return $result;	
    } 
       
    
}
