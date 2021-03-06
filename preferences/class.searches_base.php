<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class preferences_searches_base extends lib_base{

    function __construct()
    {
    	$this->appTable 		= 'searches';
    	$this->appRecordId		= 'search_id';    	
    	$this->appRecordName	= 'search_name'; 
    	$this->appOrderBy		= 'app_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'preferences_searches';
    	$this->appNameSingular	= 'preferences_search';    	
    	$this->appLabel 		= 'Search filters';
    	$this->appLabelSingular = 'Search filter';    
    	$this->appXSL	 		= 'preferences.searches';
    	$this->appRole 			= 'preferences';

        parent::__construct();    	
	}

    function menus()
    {
		execMethod('preferences.base.menus');
	}
	
	// view one profile
    function start($args)
    {
    	return $this->search($args);		
    } 	

    
	// view one profile
    function search( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		$result = parent::search( $args);	

		return $result;	
    } 	    
    
	// view one profile
    function view( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		$result = parent::view( $args);	

		return $result;	
    } 	

	
	// view one profile
    function edit( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
    	
		$result = parent::edit( $args);	

		if( $result[$this->appNameSingular]['is_default'] == 'Y' )
			executeSQL('update searches set is_default = "N" where app_name = "'.$result[$this->appNameSingular]['app_name'].'" 
				and search_id <> "'.$result[$this->appNameSingular]['search_id'].'" 
				and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
					
		// don't want to see list of users generated by default
		unset( $result['users']);

		return $result;	
    } 
        
}
