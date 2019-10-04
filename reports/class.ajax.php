<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/


// class account extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.ajax.php');

class reports_ajax extends lib_ajax {

    function __construct()
    {
    	$this->appTable 		= 'reports';
    	$this->appRecordId		= 'report_id';    	
    	$this->appRecordName	= 'report_name';   
    	$this->appOrderBy		= 'report_name';    	
    	$this->appAscDesc		= 'asc';    	    	 	
    	$this->appName 			= 'reports';
    	$this->appNameSingular	= 'report';    	
    	$this->appLabel 		= 'Reports';
    	$this->appLabelSingular = 'Report';    
   		$this->appXSL 			= 'reports.base';
    	$this->appRole 			= 'reports';

        parent::__construct();    	
    }
    
    // search a filtered text
    function getLookUp()
    {
		$args = new safe_args();
		$args->set('table_name', 	NOTSET, 'sqlsafe');		
		$args->set('field_name', 	NOTSET, 'any');
		$args->set('field_value', 	NOTSET, 'sqlsafe');		
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore']->add_xsl('lib.ajax');
		$result['action']['ajax'] = 'search';
		$GLOBALS['appshore_data']['server']['xml_render'] = false;

		if( strstr( $args['field_name'], '.') )
		{	// test if the fieldname contains the table_name if true we use this table_name because it can be different
			list( $args['table_name'], $args['field_name']) = explode( '.', $args['field_name']);
		}

		$lookup = getOneAssocArray( 'select field_type, related_table, related_name from db_fields where table_name = "'.$args['table_name'].'" and field_name = "'.$args['field_name'].'"');
		
		if( in_array( $lookup['field_type'], array( 'TE', 'ML', 'VF')) ) // we use the main table as a look up table
		{
			$lookup['related_table'] = $args['table_name'];
			$lookup['related_name'] = $args['field_name'];
		}
		else if( !in_array( $lookup['field_type'], array( 'DD', 'RR') )) // Look up
			return null;
						
		if( $args['field_value'] == ' ' ) 
			$args['field_value'] = '';

		$result['search'] = getManyAssocArrays('SELECT distinct '.$lookup['related_name'].' as result FROM '.$lookup['related_table'].' as t0 '
			.buildClauseWhere( $this->appRole, 'R', $args['table_name'].'.').' AND '
			.$lookup['related_name'].' like "%'.$args['field_value'].'%" limit 10');

 		return $result;
    }	
    
    
    function getFilterOperators()
    {
		$args = new safe_args();
		$args->set('table_name', 	NOTSET, 'sqlsafe');		
		$args->set('field_name', 	NOTSET, 'sqlsafe');		
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore_data']['server']['xml_render'] = true;

		if( strstr( $args['field_name'], '.') )
		{	// test if the fieldname contains the table_name if true we use this table_name because it can be different
			list( $args['table_name'], $args['field_name']) = explode( '.', $args['field_name']);
		}
		
		$lookup = getOneAssocArray( 'select field_type from db_fields where table_name = "'.$args['table_name'].'" and field_name = "'.$args['field_name'].'"');

		$result['operators'] = getManyAssocArrays('select operator_id, operator_label from global_reports_operators where field_type_enable like "%'.
			$lookup['field_type'].'%" order by operator_label');

		foreach( $result['operators'] as $key => $val)
		{
			$result['operators'][$key]['operator_label'] = lang($val['operator_label']);
			$result['operators'][$key]['field_type'] = $lookup['field_type'];
		}

		$result['field_type'] = $lookup['field_type'];

 		return $result;
    }
    
    
    
    function getTableFields()
    {
		$args = new safe_args();
		$args->set('table_name', 	NOTSET, 'sqlsafe');		
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore_data']['server']['xml_render'] = true;

		
		$result['fields'] = getManyAssocArrays( 'select field_name, field_label from db_fields where app_name = "'.$args['table_name'].'" order by field_label');

 		return $result;
    }	               
  
}
