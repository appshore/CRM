<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class campaigns_lists_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'campaigns_lists';
    	$this->appRecordId		= 'list_id';    	
    	$this->appRecordName	= 'list_name';    	
    	$this->appOrderBy		= 'list_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'campaigns_lists';
    	$this->appNameSingular	= 'campaigns_list';    	
    	$this->appLabel 		= 'Lists';
    	$this->appLabelSingular = 'List';    
    	$this->appXSL	 		= 'campaigns.lists_base';
    	$this->appRole 			= 'campaigns';


    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

#    	// to allow tag management from this app
#		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
#			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');


		parent::__construct();
    }

    function menus()
    {
    	execMethod( 'campaigns.base.menus');
    }
    
	function search( $args = null)
    {
    	// update the records count for each list
        executeSQL( 'update campaigns_lists cl set records_count = ( select count(record_id) from campaigns_records cr where cl.list_id = cr.list_id)');

		$result = parent::search( $args);	

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');
		
		return $result;
	} 
	
    
    function edit( $args = null)
    {
		if( $args['key'] == 'Duplicate' )
			$_SESSION[$this->appName]['duplicatedListId'] = $args[$this->appRecordId];

   		$result = parent::edit( $args); 

		if( $args['key'] == 'Save' && $_SESSION[$this->appName]['duplicatedListId'] )
		{
			$this->duplicateRecords($_SESSION[$this->appName]['duplicatedListId'], $result[$this->appNameSingular][$this->appRecordId]);
			unset($_SESSION[$this->appName]['duplicatedListId']);
		}


        return $result;
    }
    
	function duplicateRecords( $source, $target)
    {
        executeSQL( 'insert into campaigns_records (
        	select "'.$target.'" as list_id, record_id, table_name, status_id from campaigns_records where list_id = "'.$source.'")');
	}       		
	
	
	// bulk operations
    function bulk_list( $args)
    {
    	// we retrieve fields to update
		foreach( $args as $key => $val)
		{
			if( strpos( $key, 'bulk_') !== false && $val && $key != 'bulk_id' ) 
				$record[substr($key,5)] = $val;
		}	
		
		$records_count = 0;	
	
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$sql = 'SELECT DISTINCT "'.$args['list_id'].'", record_id, type_id as table_name, "UP" 
					FROM campaigns_lists
					WHERE record_id IN ( "'. implode( array_unique(explode( ',', $args['selected'])), '","') .'") ';
						
				break;
				
			case 'All':
				$sql = 'SELECT DISTINCT "'.$args['list_id'].'", t0.record_id, type_id as table_name, "UP"'.
					' FROM campaigns_lists t0 '.$_SESSION[$this->appName]['sql']['join'].
					' WHERE 1=1 '.$_SESSION[$this->appName]['sql']['where'];
				break;
		}			

		if ( $sql )
		{
			$sql = str_replace( '  ', ' ', $sql);
			$sql = str_replace( '1=1 AND', '', $sql);
			$db = executeSQL( 'REPLACE INTO campaigns_records( list_id, record_id, table_name, status_id ) '.$sql);
			messagebox( lang('List updated'), NOTICE);
		}
    }
    
    
    // a bulk delete operation must be added to delete also the campaigns_records associated with the lists    	
	    	
}
