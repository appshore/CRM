<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/
 
class lib_api 
{

	// stub
    function __construct()
    {
	}
	
	// if an unknown method is called
    function invalid()
    {
		$result[$this->appName]['error']['code'] = 'ERROR_INVALID_APPLICATION';
		$result[$this->appName]['error']['message'] = ERROR_INVALID_APPLICATION;
		$result[$this->appName]['status'] = ERROR;
 		return $result;
	}

    // return the schema of the main table related to the application
    function schema()
    {
		$args = new safe_args();
		$args->set('field_name', 		NOTSET, 'any');	
		$args->set('field_type', 		NOTSET, 'any');	
		$args->set('is_custom', 		NOTSET, 'any');	
		$args->set('is_mandatory', 		NOTSET, 'any');	
		$args->set('is_readonly', 		NOTSET, 'any');	
		$args->set('is_search', 		NOTSET, 'any');	
		$args->set('is_unique', 		NOTSET, 'any');	
		$args->set('is_record_key', 	NOTSET, 'any');	
		$args = $args->get(func_get_args());	

		// retrieve fields to display results
		if( ($schema = $this->getFields($this->appName, $this->appTable, 'all')) == null )
		{ 
			$result[$this->appName]['error']['code'] = 'ERROR_INVALID_APPLICATION';
			$result[$this->appName]['error']['message'] = ERROR_INVALID_APPLICATION;
			$result[$this->appName]['status'] = ERROR;
			return $result;
		}
		
		foreach( $schema as $key => $value)
		{
		
			// needed to force default value
			$value['is_custom'] = ( $value['is_custom'] == 'Y' ) ? 'Y' : 'N'; 
#			$value['is_computed'] = ( $value['is_computed'] == 'Y' ) ? 'Y' : 'N'; 
			$value['is_mandatory'] = ( $value['is_mandatory'] == 'Y' ) ? 'Y' : 'N'; 
			$value['is_unique'] = ( $value['is_unique'] == 'Y' ) ? 'Y' : 'N'; 
			$value['is_search'] = ( $value['is_search'] == 'Y' ) ? 'Y' : 'N'; 
			$value['is_readonly'] = ( $value['is_readonly'] == 'Y' ) ? 'Y' : 'N'; 
#			$value['is_visible'] = ( $value['is_visible'] == 'Y' ) ? 'Y' : 'N'; 
			$value['is_record_key'] = ( $value['field_name'] == $this->appRecordId ) ? 'Y' : 'N';
		
			if( $args )
			{
				foreach( $args as $argskey => $argsvalue )
					$match = ( $value[$argskey] == $argsvalue ) ? true : false;

				if( $match == false )
					continue;
			}

			$result[$this->appName]['schema'][$key]['field_name'] = $value['field_name']; 
			$result[$this->appName]['schema'][$key]['field_label'] = $value['field_label']; 
			$result[$this->appName]['schema'][$key]['field_type'] = $value['field_type']; 

			if( in_array( $value['field_type'], array('DD','DF','LR','RR')) == true )
			{
          		$is_lookup = getOneAssocArray('select * from db_lookups where table_name ="'.$value['related_table'].'"');
				$result[$this->appName]['schema'][$key]['related_table'] = $value['related_table'];
				$result[$this->appName]['schema'][$key]['related_id'] = $value['related_id'];
				$result[$this->appName]['schema'][$key]['related_name'] = $value['related_name'];
				$result[$this->appName]['schema'][$key]['related_is_lookup'] = $is_lookup ? 'Y' : 'N'; 
				//$result[$this->appName]['schema'][$key]['related_filter'] = $value['related_filter'];
			}
			 
			$result[$this->appName]['schema'][$key]['field_default'] = $value['field_default'];
			$result[$this->appName]['schema'][$key]['is_custom'] = $value['is_custom']; 
#			$result[$this->appName]['schema'][$key]['is_computed'] = $value['is_computed']; 
			$result[$this->appName]['schema'][$key]['is_mandatory'] = $value['is_mandatory']; 
			$result[$this->appName]['schema'][$key]['is_unique'] = $value['is_unique']; 
			$result[$this->appName]['schema'][$key]['is_search'] = $value['is_search']; 
			$result[$this->appName]['schema'][$key]['is_readonly'] = $value['is_readonly']; 
#			$result[$this->appName]['schema'][$key]['is_visible'] = $value['is_visible']; 
			$result[$this->appName]['schema'][$key]['is_record_key'] = $value['is_record_key'];
		}

		$result[$this->appName]['schema']['items_count'] = count($result[$this->appName]['schema']);
		$result[$this->appName]['status'] = OK;
 		return $result;
    }	

    
    // create a record
    function create()
    {
		$args = new safe_args();
		// edit fields
		$recordKey = $userKey = false;
		if( $edit_fields = $this->getFields($this->appName, $this->appTable, 'all') )
			foreach( $edit_fields as $fieldkey => $fieldvalue)
			{
				if( $edit_fields[$fieldkey]['field_name'] == $this->appRecordId )
					$recordKey = true;
				if( $edit_fields[$fieldkey]['field_name'] == 'user_id' )
					$userKey = true;
					
				if( isset($_SESSION[$this->appName][$edit_fields[$fieldkey]['field_name']]) )
					$args->set( $edit_fields[$fieldkey]['field_name'], $_SESSION[$this->appName][$edit_fields[$fieldkey]['field_name']], 'any');
				else
					$args->set( $edit_fields[$fieldkey]['field_name'], NOTSET, 'any');				
			}
			
		if( $recordKey == false)
			$args->set($this->appRecordId, NOTSET,'any');
		if( $userKey == false && $this->appRecordId != 'user_id' )
			$args->set('user_id', NOTSET,'any');
				
		$args = $args->get(func_get_args());
	
		$args = (array)$this->newEntry($args);
    	if ( $this->checkFields($args, $edit_fields) == false )
		{
#			$result[$this->appNameSingular] = $args;
			$result[$this->appName]['status'] = ERROR;
			$result[$this->appName]['error']['code'] = 'ERROR_INVALID_DATA';
			$result[$this->appName]['error']['message'] = ERROR_INVALID_DATA;
	 		return $result;
        }
		else
		{
			$args[$this->appRecordId] = insertRow( $this->appTable, $this->appRecordId, $args, false);
			if ( $args[$this->appRecordId] == NULL )
			{
#				$result[$this->appNameSingular] = $args;
				$result[$this->appName]['status'] = ERROR;
				$result[$this->appName]['error']['code'] = 'ERROR_INSERT_DUPLICATED_VALUE';
				$result[$this->appName]['error']['message'] = ERROR_INSERT_DUPLICATED_VALUE;
		 		return $result;
			}
		}

		// set the status and number of retrieve records
//$result['debug'] = $sql;
		$result[$this->appName][$this->appRecordId] = $args[$this->appRecordId];
		$result[$this->appName]['status'] = OK;
 		return $result;
    }   
    
    // retrieve a filtered text
    function retrieve()
    {
		$args = new safe_args();
		$args->set('nbrecords', NOTSET, 'any');	
		
		// search fields
		if( $search_fields = $this->getFields($this->appName, $this->appTable, 'all') )			
			foreach( $search_fields as $fieldkey => $fieldvalue)
			{
        		if( in_array( $fieldvalue['field_type'], array('RR')) && $fieldvalue['related_table'] && $fieldvalue['related_id'] && $fieldvalue['related_name'] )
					$args->set( 'related_'.$fieldvalue['field_name'], NOTSET, 'sqlsafe');	
				else
					$args->set( $fieldvalue['field_name'], NOTSET, 'sqlsafe');	
			}
		
		// retrieve all passed parameters
		$args = $args->get(func_get_args());	

		// retrieve fields to display results
		$result_fields = $this->getFields($this->appName, $this->appTable, 'all'); 

		// build the SQL request
		$sql = $this->buildSQL( $args, $search_fields, $result_fields);
				
		// fetch Results and format them
		$result[$this->appName] = $this->getSearchResults( $this->appName, $args['nbrecords'], $sql, $result_fields);		

		// set the status and number of retrieve records
		$result[$this->appName]['items_count'] = count($result[$this->appName]);
		$result[$this->appName]['status'] = OK;
 		return $result;
    }
    
    // update a record
    function update()
    {
		$args = new safe_args();

		// edit fields
		$recordKey = $userKey = false;
		if( $edit_fields = $this->getFields($this->appName, $this->appTable, 'all') )
			foreach( $edit_fields as $fieldkey => $fieldvalue)
			{
				if( $edit_fields[$fieldkey]['field_name'] == $this->appRecordId )
					$recordKey = true;
				if( $edit_fields[$fieldkey]['field_name'] == 'user_id' )
					$userKey = true;
				$args->set( $edit_fields[$fieldkey]['field_name'], $_SESSION[$this->appName][$edit_fields[$fieldkey]['field_name']], 'any');
			}
			
		if( $recordKey == false)
			$args->set($this->appRecordId, NOTSET,'any');
		if( $userKey == false && $this->appRecordId != 'user_id' )
			$args->set('user_id', NOTSET,'any');
				
		$args = $args->get(func_get_args());
	
    	if ( $this->checkFields($args, $edit_fields) == false )
		{
#			$result[$this->appNameSingular] = $args;
			$result[$this->appName]['error']['code'] = 'ERROR_INVALID_DATA';
			$result[$this->appName]['error']['message'] = ERROR_INVALID_DATA;
			$result[$this->appName]['status'] = ERROR;
	 		return $result;
        }
		
		// update one and only one existing record
		$record = getOneAssocArray( 'select '.$this->appRecordId.' from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');
		if ( $record == NULL )
		{
			$result[$this->appName]['error']['code'] = 'ERROR_RECORD_NOT_FOUND';
			$result[$this->appName]['error']['message'] = ERROR_RECORD_NOT_FOUND;
			$result[$this->appName]['status'] = ERROR;
	 		return $result;
		}
		
		updateRow( $this->appTable, $this->appRecordId, $args);
				
		// set the status and number of retrieve records
		$result[$this->appName][$this->appRecordId] = $args[$this->appRecordId];
		$result[$this->appName]['status'] = OK;
 		return $result;
    }
    
    // delete a record
    function delete()
    {
		$args = new safe_args();
		$args->set($this->appRecordId, NOTSET,'any');
		$args = $args->get(func_get_args());
	
    	if ( $this->checkFields($args, $edit_fields) == false )
		{
#			$result[$this->appNameSingular] = $args;
			$result[$this->appName]['error']['code'] = 'ERROR_INVALID_DATA';
			$result[$this->appName]['error']['message'] = ERROR_INVALID_DATA;
			$result[$this->appName]['status'] = ERROR;
	 		return $result;
        }
		else
		{
			$record = getOneAssocArray( 'select '.$this->appRecordId.' from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');
			if ( $record == NULL )
			{
				$result[$this->appName]['error']['code'] = 'ERROR_RECORD_NOT_FOUND';
				$result[$this->appName]['error']['message'] = ERROR_RECORD_NOT_FOUND;
				$result[$this->appName]['status'] = ERROR;
		 		return $result;
			}
			deleteRow( $this->appTable, $this->appRecordId, $args);
		}

		// set the status and number of retrieve records
		$result[$this->appName][$this->appRecordId] = $args[$this->appRecordId];
		$result[$this->appName]['status'] = OK;
 		return $result;
    }      
    

    // we build the SQL request based on search, result fields and filter criterias
	function buildSQL( $args=null, $search_fields=null, $result_fields=null, $session_popup = '')
	{
		// Result fields list
		$sql['select'] = 'SELECT SQL_CALC_FOUND_ROWS ';
		$tinc = 2;
					
		if( $result_fields == null )
			$result_fields = $this->getFields($this->appName, $this->appTable, 'result'); 
			
		if( $search_fields == null )
			$search_fields = $this->getFields($this->appName, $this->appTable, 'search'); 

		$checkRBAC = false; //in case the table own the field user_id we must check the ownership

		if( isset($result_fields['user_id']) || isset($search_fields['user_id']))
		{
			//$sql['join'] = 'LEFT OUTER JOIN users ON t0.user_id = users.user_id ';
			$checkRBAC = true;
		}
		else if( describeColumns( $this->appTable, 'user_id'))
		{
			//$sql['join'] = 'LEFT OUTER JOIN users ON t0.user_id = users.user_id ';
			$checkRBAC = true;
		}

		$sql['join'] = '';

		if( $result_fields )
		{
			$sql['select'] .= 't0.*';
					
	    	foreach( $result_fields as $fieldkey => $fieldvalue)
	    	{
	        	if( in_array( $fieldvalue['field_type'], array('DD', 'DF', 'RR')) && $fieldvalue['related_table'] && $fieldvalue['related_id'] && $fieldvalue['related_name'] )
	        	{
					$sql['select'] .= ', t'.$tinc.'.'.$fieldvalue['related_name'].' as related_'.$fieldvalue['field_name'];		
					
					$sql['join'] .= 'LEFT OUTER JOIN '.$fieldvalue['related_table'].' t'.$tinc.' ON t0.'.$fieldvalue['field_name'].' = t'.$tinc.'.'.$fieldvalue['related_id'].' ';
					
					// array used to match alias in case of related table 
					$alias[$fieldvalue['field_name']] = 't'.$tinc++;
				}
			}	
		}

		$sql['where'] = '';
		if( $search_fields && $args )
		{			
			foreach( $search_fields as $fieldkey => $fieldvalue )
			{
				// no computed fields should appear in the SQL request
				if(  $fieldvalue['is_computed'] == 'Y' && $fieldvalue['is_computed'] == 'Y' )
					continue;
					
				switch ( $fieldvalue['field_type'] )
				{
					case 'DA':
					case 'DT':
					case 'TS':
						if( $args[$fieldvalue['field_name']] == '' )
							break;

						if( $fieldvalue['field_type'] == 'DA' )
							$gmtDateTime = ' t0.'.$fieldvalue['field_name'];
						else
							$gmtDateTime = 'timestampadd(second,'.$GLOBALS['appshore_data']['current_user']['timezone_offset'].', t0.'.$fieldvalue['field_name'].')';

						switch ( $args[$fieldvalue['field_name']] )
						{
							case 'Today': 
								$sql['where'] .= ' AND date('.$gmtDateTime.') = current_date() ';
								break;
							case 'Tomorrow': 
						    	$sql['where'] .= ' AND date('.$gmtDateTime.') = date(date_add(current_date(), interval +1 day)) ';				    
						    	break;
							case 'Yesterday': 
						    	$sql['where'] .= ' AND date('.$gmtDateTime.') = date(date_add(current_date(), interval -1 day))  ';				    
						    	break;
							case 'This week': 
						    	$sql['where'] .= ' AND week('.$gmtDateTime.') = week(current_date()) AND year('.$gmtDateTime.') = year(current_date()) ';
						    	break;
							case 'Next week': 
						    	$sql['where'] .= ' AND week('.$gmtDateTime.') = week(date_add(current_date(), interval 7 day)) AND year('.$gmtDateTime.') = year(date_add(current_date(), interval 7 day)) ';
						    	break;
							case 'Last week': 
						    	$sql['where'] .= ' AND week('.$gmtDateTime.') = week(date_add(current_date(), interval -7 day)) AND year('.$gmtDateTime.') = year(date_add(current_date(), interval -7 day)) ';
						    	break;
							case 'This month': 
						    	$sql['where'] .= ' AND month('.$gmtDateTime.') = month(current_date()) AND year('.$gmtDateTime.') = year(current_date()) ';
						    	break;
							case 'Next month': 
						    	$sql['where'] .= ' AND month('.$gmtDateTime.') = month(date_add(current_date(), interval 1 month)) AND year('.$gmtDateTime.') = year(date_add(current_date(), interval 1 month)) ';
						    	break;
							case 'Last month': 
						    	$sql['where'] .= ' AND month('.$gmtDateTime.') = month(date_add(current_date(), interval -1 month)) AND year('.$gmtDateTime.') = year(date_add(current_date(), interval -1 month)) ';
						    	break;
							case 'This quarter': 
						    	$sql['where'] .= ' AND quarter('.$gmtDateTime.') = quarter(current_date()) AND year('.$gmtDateTime.') = year(current_date()) ';
						    	break;
							case 'Next quarter': 
						    	$sql['where'] .= ' AND quarter('.$gmtDateTime.') = quarter(date_add(current_date(), interval 3 month)) AND year('.$gmtDateTime.') = year(date_add(current_date(), interval 3 month)) ';
						    	break;
							case 'Last quarter': 
						    	$sql['where'] .= ' AND quarter('.$gmtDateTime.') = quarter(date_add(current_date(), interval -3 month)) AND year('.$gmtDateTime.') = year(date_add(current_date(), interval -3 month)) ';
						    	break;
							case 'This year': 
						    	$sql['where'] .= ' AND year('.$gmtDateTime.') = year(current_date()) ';
						    	break;
							case 'Next year': 
						    	$sql['where'] .= ' AND year('.$gmtDateTime.') = year(current_date())+1 ';
						    	break;
							case 'Last year': 
						    	$sql['where'] .= ' AND year('.$gmtDateTime.') = year(current_date())-1 ';
						    	break;
						    default:
								if( $fieldvalue['field_type'] == 'DA' )
									$sql['where'] .= ' AND '.$fieldvalue['field_name'].' like "'.$joker.$GLOBALS['appshore']->local->localToDate($args[$fieldvalue['field_name']]).$joker.'" ';				    	
								else if( $GLOBALS['appshore']->local->localTotime($args[$fieldvalue['field_name']]) == '')
									$sql['where'] .= ' AND '.$fieldvalue['field_name'].' like "'.$joker.$args[$fieldvalue['field_name']].$joker.'" ';				    	
								else 
								{
									$sql['where'] .= ' AND ('.$fieldvalue['field_name'].' between "'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDatetime($args[$fieldvalue['field_name']])).'" ';				    	
									$sql['where'] .= ' AND date_add("'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDatetime($args[$fieldvalue['field_name']])).'", interval +1 day)) ';				    	
								}
						    	break;
						}
						break;		
		
	       			case 'DD':
	        		case 'RE':
						if( $args[$fieldvalue['field_name']] == '' )
							break;
					
						$sql['where'] .= ' AND t0.'.$fieldvalue['field_name'].' = "'.$args[$fieldvalue['field_name']].'" ';
						break;

	        		case 'LI':
						if( $args[$fieldvalue['field_name']] == '' )
							break;
								
						$record_ids = getOneColManyRows(
							 'select from_id from links '
							.'  where to_id = "'.$args[$fieldvalue['field_name']].'" ' 
							.'  and to_table = "'.$fieldvalue['table_name'].'" '
							.'  and from_table = "'.$fieldvalue['related_table'].'" '
							.' union '
							.'select to_id from links  '
							.' where from_id = "'.$args[$fieldvalue['field_name']].'" '
							.' and from_table = "'.$fieldvalue['table_name'].'" '
							.' and to_table = "'.$fieldvalue['related_table'].'" '
							);
								
						$sql['where'] .= ' AND t0.'.$fieldvalue['field_name'].' in ("'.implode($record_ids,'","').'")';	

				    	break;

					case 'RR':
						if( $args['related_'.$fieldvalue['field_name']] == '' )
							break;

						// try to match with an already used alias above
						if ( $alias[$fieldvalue['field_name']] == null )
							$alias[$fieldvalue['field_name']] = 't'.$tinc++;
						
						$sql['where'] .= ' AND '.$alias[$fieldvalue['field_name']].'.'.$fieldvalue['related_name'].' like "'.$joker.$args['related_'.$fieldvalue['field_name']].$joker.'" ';
						
						// to avoid to repeat the JOIN if already defined above
						if( strpos( $sql['join'], $fieldvalue['related_table']) == false )
							$sql['join'] .= 'LEFT OUTER JOIN '.$fieldvalue['related_table'].' '.$alias[$fieldvalue['field_name']].' ON  t0.'.$fieldvalue['field_name'].' = '.$alias[$fieldvalue['field_name']].'.'.$fieldvalue['related_id'].' ';
				    	break;

	        		case 'DF':
					default:
						if( $args[$fieldvalue['field_name']] == '' )
							break;
					
						$sql['where'] .= ' AND t0.'.$fieldvalue['field_name'].' like "'.$joker.$args[$fieldvalue['field_name']].$joker.'" ';	
				    	break;
				}
			}
		}	

		// in the next lines we build the where clause of the SQl request
		// first check the RBAC
		// then if a app specific filter has been added (appWhereFilter)
		// then we add all the filter coming from the form filters
		if( $checkRBAC == true )
		{
			$where = buildClauseWhere($this->appRole,'R', 't0.');
			if( $this->appWhereFilter )
				$where .= ' AND t0.'.$this->appWhereFilter;
		}
		else if( $this->appWhereFilter )
			$where = ' WHERE t0.'.$this->appWhereFilter;

		if ( !isset($where) && $sql['where'] )
			$where = ' WHERE'.substr( $sql['where'], 4);
		else
			$where .= $sql['where'];

		$where = str_replace( '  ', ' ', $where);
		$where = str_replace( '1=1 AND', '', $where);
		$sql['where'] = str_replace( 'WHERE 1=1', '', $where);

		// Group By
		$sql['groupby'] = '';
		if( $args['groupby'] )
		{
			$groupby = $args['groupby'];

			if( strstr( $groupby, 'related_') == false )
				$sql['groupby'] = ' GROUP BY t0.'.$groupby;
			else
				$sql['groupby'] = ' GROUP BY '.$groupby;
		}


		// Order By
		$sql['orderby'] = '';
		if( $args['orderby'])
		{
			$orderby = $args['orderby'].' '.$args['ascdesc'];

			if( strstr( $orderby, 'related_') == false )
				$sql['orderby'] = ' ORDER BY t0.'.$orderby;
			else
				$sql['orderby'] = ' ORDER BY '.$orderby;
		}

		$sql['from'] = ' FROM '.$this->appTable.' t0 ';

		// SQl request is completed, it is saved in session for further need
		$sql['request'] = $sql['select'].$sql['from'].$sql['join'].$sql['where'].$sql['groupby'].$sql['orderby'];

		return $sql['request'];
	}
    
    
    // get all fields mandatory for each action (search, result, bulk)
    // if the app_name is undefined we force it to the current appRole equals main app_name
	function getFields( $app_name, $table_name, $form='all')
	{
		$sql = 'select f.*, a.app_name as related_app_name 
			from db_fields f
			left outer join db_applications a
				on f.related_table = a.table_name
				and a.is_related = "Y" 
			where 
				f.app_name = "'.$app_name.'" 
				and f.table_name = "'.$table_name.'"
				and f.is_computed = "N"';
				
		if ( $form != 'all')
			$sql.= ' and f.'.$form.'_sequence > "0" order by f.'.$form.'_sequence';

		$fields = getManyAssocArrays($sql); 

		if( $fields )
		{
			$uniqueFields = array();
	    	foreach( $fields as $fieldkey => $fieldvalue)
	    	{
	    		// a trick to remove non unique fields when many apps are using same table
	    		if( !in_array( $fields[$fieldkey]['field_name'], $uniqueFields) )
	    		{
		    		$uniqueFields[] = $fields[$fieldkey]['field_name'];
	 	        	if( !$fields[$fieldkey]['related_app_name'] )
						$fields[$fieldkey]['related_app_name'] = $app_name;
				}
				else
	    			unset($fields[$fieldkey]);
			}
		}
					
		return $fields;
	}    
    
   	// join SQL query to retrieve records according search criterias
	function getSearchResults( $appName, $range=null, $sql, $result_fields, $is_popup=false)
	{
		$offset = '0';		

		if( isset($range) )
		{
			if( ($db = executeSQL($sql.' LIMIT '.$range.' OFFSET '.$offset, false)) == NULL )
				return null; 
		}
		else
		{ 
			if( ($db = executeSQL($sql, false)) == NULL )
				return null; 
		}
		
		$nbr = 0;
		while( !$db->EOF)
		{            
            $result[$nbr] = $db->GetRowAssoc(false);
            
 			foreach( $result_fields as $fieldkey => $fieldvalue)
			{
				switch( $fieldvalue['field_type'])
				{
					case 'DA' :
						$result[$nbr][$fieldvalue['field_name']] = $GLOBALS['appshore']->local->dateToLocal($result[$nbr][$fieldvalue['field_name']] );
						break;
					case 'DS' :
						$result[$nbr][$fieldvalue['field_name']] = getfilesize($result[$nbr][$fieldvalue['field_name']]);
						break;
        			case 'DT':
        			case 'TS':
						$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$nbr][$fieldvalue['field_name']] );
						$result[$nbr][$fieldvalue['field_name']] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
						break;
					case 'WS' :
						if( strlen($result[$nbr][$fieldvalue['field_name']]) && strpos( $result[$nbr][$fieldvalue['field_name']], '://') === false)
							$result[$nbr][$fieldvalue['field_name']] = 'http://'.$result[$nbr][$fieldvalue['field_name']];
						break;
				}       		
				
			}   
            $db->MoveNext();
			$nbr++;
		}
		return $result;
	}
    
    function newEntry( $args = null, $entry = null)
    {
	    $entry['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

        if( $args )
        {
			if( $entry )
				foreach( $entry as $key => $val )
					if( !isset($args[$key]) )
						$args[$key] = $val;
         	return $args;
        }
		else
        	return $entry;
    }  
    
    // Check mandatory fields and type of some
    function checkFields( &$args, &$edit_fields = null)
    {
    	
    	/*
    
		if( $edit_fields )
			foreach( $edit_fields as $fieldkey => $fieldvalue)
				if( $fieldvalue['is_mandatory'] == 'Y' && !$args[$fieldvalue['field_name']] && $fieldvalue['field_name'] != $this->appRecordId )
					$error_fields .= $fieldvalue['field_label'].' ';
								
		if( $error_fields )
		{
            messagebox( ERROR_INVALID_DATA, ERROR);
   			messagebox( $error_fields, ERROR);
   			return false;
		}
		*/

        return true;
    }      
   
    
 }
