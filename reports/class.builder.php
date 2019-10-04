<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * \*************************************************************************
 */


class reports_builder 
{
	var $LINEMAX=5;

	function __construct()
	{
	}
	
	function start()
	{
		return $this->edit();
	} 
		
	function menus()
	{
	    $GLOBALS['appshore']->add_xsl('lib.form');
		$GLOBALS['appshore']->add_xsl('lib.base');
		$GLOBALS['appshore']->add_xsl('reports.builder');
		execMethod( 'reports.base.menus');
	}
	
	/* ***************************************
	 *  edit or create one report
	 * ***************************************/
    function edit()
    {
		$args = new safe_args();
		$args->set('key',			NOTSET,'any');
		$args->set('groupbylines',	NOTSET,'any');
		$args->set('filterlines',	NOTSET,'any');
		$args->set('table_name',	NOTSET,'any');
		$args->set('report_id',		NOTSET,'any');
	 	$args->set('display_id',	NOTSET,'any');

		// Allow to retrieve all the cols from this table
		foreach( $report = describeColumns('reports') as $field_name => $fieldValue )
			$args->set( $field_name, NOTSET, 'any');
		$args = $args->get(func_get_args());

		$this->menus();

		// 2nd level of rights checking (1st level is by not displaying edit icons on some reports)
		$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], 'reports', 'reports', 'report_id', $args['report_id']);
			
		$args['report_user'] = $GLOBALS['appshore_data']['current_user']['user_id'];
	 	
		switch($args['key'])
		{
			case 'Delete':
				deleteRow( 'reports', 'report_id', $args);	
				messagebox( MSG_DELETE, NOTICE);
				return execMethod('reports.base.start');
														
			case 'Error':
				messagebox( $error, ERROR);
				//NO break
			case 'Cancel':
				return execMethod('reports.base.start');

			case 'Duplicate':
				$args['report_name'] = 'Copy of '.$args['report_name'];// retrieve all infos from Source record
				unset ( $args['report_id']);
				// no break;
			
			case 'Save':			
				$args['type_id']='2';
				if ($args['report_id']) 			// UPDATE an existing report
				{
					updateRow( 'reports', 'report_id', $args);
	               	messagebox( MSG_UPDATE, NOTICE);
				}
				else 								// New report so we build an INSERT
				{
					$args['report_id'] = insertRow( 'reports', 'report_id', $args);
	               	messagebox( MSG_INSERT, NOTICE);
				}
									
				$filename = execMethod( 'reports.listing.getUserXmlFileName', $args['report_id']);
				if( file_exists($filename) )
					unlink($filename);
				break;		
		}
			
		if ( $args['report_id'] != '' )
		{
			$result['report'] = $this->buildReportView( $args['report_id']);

			// record passage in history
			$GLOBALS['appshore']->history->setHistory( 'reports.builder.edit', $result['report']['report_name'], 'report_id='.$args['report_id']);			    

			// collect look up datas
			$result['operators'] = getManyAssocArrays('select operator_id, operator_label from global_reports_operators order by operator_label');
			$result['periods'] = getManyAssocArrays('select period_id, period_name from periods order by period_sequence');
			$result['fields_available'] = getManyAssocArrays( 'SELECT field_name, field_label FROM db_fields WHERE app_name = "'.$result['report']['table_name'].'" ORDER BY field_label');				
			
						
		}
		else // New report or Empty report still in build: init of some value
		{
			$result['report']['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
			// collect look up datas for targeted table
			$result['tables'] = getManyAssocArrays( 'select table_name, app_label from db_applications where is_report = "Y" order by app_label');
		}

		// collect users list
		$result['users'] = getManyAssocArrays( 'select user_id, user_name, full_name from users '.buildClauseWhere('reports','W').' order by user_name');	

		$result['report']['scope'] = ( $GLOBALS['appshore_data']['current_user']['user_id'] )?$GLOBALS['appshore']->rbac->checkPermissionOnUser('reports', $GLOBALS['appshore_data']['current_user']['user_id']):1 ;

		$_SESSION['reports']['action'] = $result['action']['reports'] = 'edit';
	
		return $result;
    } 
	
 
    /* ***************************************
	 * 
	 * ***************************************/ 
    function buildReportView( $report_id)
    {
		// retrieve the selected record
		$report = getOneAssocArray( 'select * from reports where report_id = "'.$report_id.'" limit 1');
		
		// get all fields according defined order criteria
		if ( $report['selectedfields']) 
		{
			$selectedfields = explode( '/', $report['selectedfields']);
			
			foreach( $selectedfields as $val )
			$report['fields_selected'][] = getOneAssocArray( 'SELECT field_name, field_label FROM db_fields '.
				'WHERE app_name = "'.$report['table_name'].'" AND field_name = "'.$val.'"');				
		}
				
		// get all groupby fields
		if ( $report['groupbyfields']) 
		{
			$selectedfields = explode( '/', $report['selectedfields']);

			foreach( explode ( '/', $report['groupbyfields']) as $key => $val)
			{
				// get field (separate by :) plus its optional parameters (sum, max, min, average, count) separate by +
				list( $field_name, $groupbyoperators) = explode( ':', $val);
				
				if( !in_array( $field_name, $selectedfields) || !isset($groupbyoperators) )
					continue;
					
				unset($groupby);
				
				foreach( explode( '+', $groupbyoperators) as $key2 => $val2)
					$groupby[$val2] = 'Y';	
					
				$report['groupbys'][] = array_merge( array('field_name' => $field_name), (array)$groupby);
			}
			
			unset($report['groupbyfields']);
		}

		// get all fields according defined filter
		if ( $report['filtercriterias']) 
		{
			foreach( explode ( '/', $report['filtercriterias']) as $key => $val)
			{
				// get fieldname plus filter parameters (operator, values) separate by +
				list( $field_name, $operator_id, $criteria) = explode( ':', $val);
				
				if( !isset( $field_name) || !isset($operator_id) || !isset($criteria))
					continue;
				
				if( strpos( $field_name, '.') !== false )
					list( $table_name, $field_name) = explode( '.', $field_name);
				
				$field = getOneAssocArray('SELECT field_type FROM db_fields WHERE app_name = "'.$report['table_name'].'" AND field_name = "'. $field_name.'"');
							
				$report['filters'][] = Array(
					'field_name' 	=> $field_name,
					'field_type' 	=> $field['field_type'],
					'operators'		=> getManyAssocArrays('select operator_id, operator_label from global_reports_operators where field_type_enable like "%'.$field['field_type'].'%" order by operator_label'),
					'operator_id' 	=> $operator_id,
					( $operator_id != 'period' )?'criteria':'period_id' => $criteria);
			}
			
			unset($report['filtercriterias']);
		}
				
		$report['filterlines'] = $this->LINEMAX;
		$report['groupbylines'] = $this->LINEMAX;

		$table = getOneAssocArray( 'select app_label from db_applications where table_name = "'.$report['table_name'].'"');
		$user = getOneAssocArray( 'select user_name from users where user_id= "'.$report['user_id'].'"');
		$created_by = getOneAssocArray( 'select user_name as created_by from users where user_id= "'.$report['created_by'].'"');
		$updated_by = getOneAssocArray( 'select user_name as updated_by from users where user_id= "'.$report['updated_by'].'"');

		// merge all arrays to build up report branch in XML tree
		return array_merge( (array)$report, (array)$table, (array)$user, (array)$created_by, (array)$updated_by);
    }

}
