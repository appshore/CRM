<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class reports_base extends lib_base{

    function __construct()
    {
    	$this->appTable 		= 'reports';
    	$this->appRecordId		= 'report_id';    	
    	$this->appRecordName	= 'report_name';   
    	$this->appWhereFilter	= '';    	
    	$this->appOrderBy		= 'report_name';    	
    	$this->appAscDesc		= 'asc';    	    	 	
    	$this->appName 			= 'reports';
    	$this->appNameSingular	= 'report';    	
    	$this->appLabel 		= 'Reports';
    	$this->appLabelSingular = 'Report';    
   		$this->appXSL 			= 'reports.base';
    	$this->appRole 			= 'reports';
    	
    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

    	if( !isset($_SESSION[$this->appName]) )
    	{
	        // this place needs to be clean when it's called by others apps     
			require_once ( APPSHORE_LIB.SEP.'lib.files.php');
	        checkDirectory( APPSHORE_REPORTS);
		}

        parent::__construct();    	
    }
   
    function menus()
    {
		$GLOBALS['appshore']->add_appmenu($this->appName, 'Search '.strtolower($this->appLabel), $this->appName.'.base.search');
		if ( $GLOBALS['appshore']->rbac->check('reports', RBAC_USER_WRITE ) )
			$GLOBALS['appshore']->add_appmenu($this->appName, 'New '.strtolower($this->appLabelSingular), $this->appName.'.builder.edit');
    }
       

	function search(  $args = null)
    {
		if( $args['key'] == 'Clear')
		{
 			unset($args);			
			unset($_SESSION[$this->appName]);			
			$this->reset();
		}

		$result = parent::search( $args);	

		if( $result['search_fields'] )
			foreach( $result['search_fields'] as $fieldkey => $fieldvalue)
			{
				if( $fieldvalue['field_name'] == 'table_name' )
				{
					if( $fieldvalue['field_options'] )
						foreach( $fieldvalue['field_options'] as $optionkey => $optionvalue )
	 						if( $GLOBALS['appshore']->rbac->check($optionvalue['option_id'], RBAC_RUN_APP ) == false )
							{
								unset( $result['search_fields'][$fieldkey]['field_options'][$optionkey]);
								continue;
							}
				}
			}

    	if( $result[$this->appName])
    	{
			foreach( $result[$this->appName] as $key => $val)
			{
				// reports from deactivated or barred apps are filtered out
				if( ($val['type_id'] == '1' || $val['type_id'] == '2') && $GLOBALS['appshore']->rbac->check($val['table_name'], RBAC_RUN_APP ) == false )
				{
					unset( $result[$this->appName][$key]);
					continue;
				}

				// default scope: no editing
				$result[$this->appName][$key]['scope'] = '0';
				if( $val['type_id'] == '2')
				{
					if( $val['user_id'] == $GLOBALS['appshore_data']['current_user']['user_id'] && $GLOBALS['appshore']->rbac->check('reports', RBAC_USER_WRITE ))
						$result[$this->appName][$key]['scope'] = '1';
					else if( $val['user_id'] != $GLOBALS['appshore_data']['current_user']['user_id'] )
					{
						if( $GLOBALS['appshore']->rbac->check('reports', RBAC_ALL_WRITE ))
							$result[$this->appName][$key]['scope'] = '1';
						else if( $GLOBALS['appshore']->rbac->check('reports', RBAC_ROLE_WRITE ) && $result[$this->appName][$key]['is_private'] == 'N' 
							&& $GLOBALS['appshore']->rbac->checkPermissionOnUser('reports', $val['user_id']))
							$result[$this->appName][$key]['scope'] = '1';
					}
				}
				
				if( strlen($val['quickparameter']) )
				{
					if( strpos( $val['quickparameter'], '.') != false )
					{
						list( $alias, $method) = explode( '.', $val['quickparameter']);
						$result[$this->appName][$key]['quickparameter'] = $alias.'.'.$method;	
					}
					else
						$result[$this->appName][$key]['quickparameter'] = 'parameter_popup.'.$val['quickparameter'];	
				}
			}
		}


		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');
		
		return $result;
	}  
	
	// replace the default bulk delete
    function bulk_delete( $args = null)
    {
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				return parent::bulk_delete($args);
		}
    }  
    
	// bulk save
    function bulk_save( $args = null)
    {
		// special fields send_welcome_email and reset_password
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				return parent::bulk_save($args);
 
		}		
    }    	     	   
        
}
