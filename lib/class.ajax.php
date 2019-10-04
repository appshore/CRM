<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

class lib_ajax 
{
	var	$appTable;				// Main table name
	var	$appRecordId;			// name of record column identifier
	var	$appRecordName;			// main record column 
	var	$appWhereFilter;		// set default order by 
	var	$appOrderBy;			// set default order by 
	var	$appAscDesc;			// set default direction for orderby  
	var	$appName;
	var	$appNameSingular;	
	var	$appLabel;
	var	$appLabelSingular;
	var	$appXSL;				// define specific XSL filename 
	var	$appRole;				// define the application name which define the permissions/roles

	// stub
    function __construct()
    {
	}
    
    function deleteSelectedRecords()
    {
		$args = new safe_args();
		$args->set('selected', 		NOTSET, 'any');
		$args->set('record_name', 	NOTSET, 'sqlsafe');
		$args->set('record_id', 	NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());  
		
		$selected = '"'.implode( '","', explode( ',', $args['selected'])).'"'; 

		// delete the linked records
		deleteRowWhere( $this->appTable, 'where '.$this->appRecordId.' in ('.$selected.')', false); 
		
		// remove all links in the links table
		deleteRowWhere( 'links', 'where from_table = "'.$this->appTable.'" and from_id in ('.$selected.')', false); 
		deleteRowWhere( 'links', 'where to_table = "'.$this->appTable.'" and to_id in ('.$selected.')', false); 

		// we do not blank the RR field in the master record but it won't be visible because the linked record do not exist anymore

		// add a plugin for each application in case we need to do more application specific tasks
		$this->SpecificDeleteSelectedRecords($args);
    }  
    
    // stub
    function specificDeleteSelectedRecords($args)
    {
    }            
    
    function unlinkSelectedRecords()
    {
		$args = new safe_args();
		$args->set('selected', 		NOTSET, 'any');
		$args->set('table_name', 	NOTSET, 'sqlsafe');
		$args->set('record_id', 	NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());  
		
		$selected = '"'.implode( '","', explode( ',', $args['selected'])).'"'; 

		$link = getOneAssocArray( 'select * from db_linked where table_name = "'.$args['table_name'].'" and linked_table_name = "'.$this->appTable.'"');		
		
		if( $link['linked_type'] != 'NN' )
		{
			// blank the potential link to the master record in each linked record
			$update[$link['linked_record_name']] = "";
			updateRowWhere( $this->appTable, 'where '.$this->appRecordId.' in ('.$selected.')', $update, false); 	
		}
		else
		{
			// blank of the RR field in the master record if exists
			$field = getOneAssocArray( 'select field_name from db_fields where table_name = "'.$args['table_name'].'" and field_name like "%'.$link['linked_record_name'].'"');		
			if( $field['field_name'] )
			{
				$table = getOneAssocArray( 'select * from db_applications where table_name = "'.$args['table_name'].'"');		
				$update[$field['field_name']] = "";
				updateRowWhere( $table['table_name'], 'where '.$table['field_name'].' = "'.$args['record_id'].'" and '.
					$field['field_name'].' in ('.$selected.')', $update, false); 	
			}


			// blank of the RR field in the linked record if exists
			$reverse_link = getOneAssocArray( 'select * from db_linked where linked_table_name = "'.$args['table_name'].'" and table_name = "'.$this->appTable.'"');		
			$field = getOneAssocArray( 'select field_name from db_fields where table_name = "'.$this->appTable.'" and field_name like "%'.$reverse_link['linked_record_name'].'"');		
			if( $field['field_name'] )
			{
				$update[$field['field_name']] = "";
				updateRowWhere( $this->appTable, 'where '.$this->appRecordId.' in ('.$selected.')', $update, false); 	
			}
			
			// remove all links in the links table
			deleteRowWhere( 'links', 'where from_table = "'.$this->appTable.'" and from_id in ('.$selected.')
				and to_id = "'.$args['record_id'].'"', false); 		
			deleteRowWhere( 'links', 'where to_table = "'.$this->appTable.'" and to_id in ('.$selected.')
				and from_id = "'.$args['record_id'].'"', false); 
		}					
		
		// add a plugin for each application in case we need to do more application specific tasks
		$this->SpecificUnlinkSelectedRecords($args);
    }  
    
    // stub
    function specificUnlinkSelectedRecords($args)
    {
    }         
    
    
    function linkSelectedRecord()
    {
		$args = new safe_args();
		$args->set('selected_id', 	NOTSET, 'sqlsafe');
		$args->set('table_name', 	NOTSET, 'sqlsafe');
		$args->set('record_id', 	NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());  
		
		$link = getOneAssocArray( 'select * from db_linked where table_name = "'.$args['table_name'].'" and linked_table_name = "'.$this->appTable.'"');		

		if( $link['linked_type'] != 'NN' )
		{
			$update[$link['linked_record_name']] = $args['record_id'];
			updateRowWhere( $this->appTable, 'where '.$this->appRecordId.' = "'.$args['selected_id'].'"', $update, false);
		}
		else
		{
			$insert['from_table'] = $args['table_name'];
			$insert['from_id'] = $args['record_id'];
			$insert['to_table'] = $this->appTable;
			$insert['to_id'] = $args['selected_id'];
			replaceRow( 'links', 'to_table', $insert, false); 
		}
			
		// add a plugin for each application in case we need to do more application specific tasks
		$this->SpecificLinkSelectedRecord($args);
    }  
    
    // stub
    function specificLinkSelectedRecord($args)
    {
    }        
    
    // search a filtered text
    function getRecords()
    {
		$args = new safe_args();
		$args->set('field_name', 	NOTSET, 'sqlsafe');
		$args->set('field_value', 	'', 'sqlsafe');		
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore']->add_xsl('lib.ajax');
		$result['action']['ajax'] = 'search';
		
		$where = buildClauseWhere( $this->appRole, 'R', 't0.');
		if( $this->appWhereFilter )
			$where .= ' AND t0.'.$this->appWhereFilter.' ';
		
		$sql = 'SELECT distinct '.$args['field_name'].' as result FROM '.$this->appTable.' as t0 '
			.$where.' AND t0.'.$args['field_name'].' like "%'.trim($args['field_value']).'%" and t0.'.$args['field_name'].' <> "" order by result limit 10';

		$result['search'] = getManyAssocArrays( $sql);

 		return $result;
    }
    
    
    // search a filtered text
    function getRelatedRecords()
    {
		$args = new safe_args();
		$args->set('field_name', 	NOTSET, 'sqlsafe');
		$args->set('field_value', 	'', 'sqlsafe');		
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore']->add_xsl('lib.ajax');
		$result['action']['ajax'] = 'search';
		
		$related = getOneAssocArray( 'select related_table, related_name from db_fields where app_name = "'.$this->appName
			.'" and table_name = "'.$this->appTable.'" and field_name = "'.$args['field_name'].'"');					
		
		$sql = 'SELECT distinct '.$related['related_name'].' as result FROM '.$related['related_table'].' as t0 '
			.buildClauseWhere( $this->appRole, 'R', 't0.')
//			.' AND t0.'.$related['related_name'].' like "%'.trim($args['field_value']).'%" and t0.'.$args['field_name'].' <> "" order by result limit 10';
			.' AND t0.'.$related['related_name'].' like "%'.trim($args['field_value']).'%" and t0.'.$related['related_name'].' <> "" order by result limit 10';

		$result['search'] = getManyAssocArrays( $sql);

 		return $result;
    }	    	
        
    // retrieve period list
    function getPeriods()
    {
		$args = new safe_args();
		$args->set('field_value', 	'', 'sqlsafe');		
		$args = $args->get(func_get_args());

		$GLOBALS['appshore']->add_xsl('lib.ajax');
		$result['action']['ajax'] = 'search';
		
#		$result['search'] = getManyAssocArrays( 'SELECT period_name FROM periods WHERE lower(period_name) like "%'
#			.strtolower(trim($args['field_value'])).'%" order by period_sequence');
		$periods = getManyAssocArrays( 'SELECT period_name FROM periods order by period_sequence');

		if( $periods )
		{
			if ( $args['field_value'] == null )
				foreach( $periods as $key => $val)
				{
					$result['search'][]['result'] = lang($val['period_name']);
				}
			else 			
				foreach( $periods as $key => $val)
				{
					$trans = lang($val['period_name']);
					if( strstr( strtolower($trans), strtolower(trim($args['field_value']))) ) 
						$result['search'][]['result'] = $trans;
				}
		}

 		return $result;
    }        
}
