<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class lib_base
{
	var	$appTable;				// Main table name
	var	$appRecordId;			// name of record column identifier
	var	$appRecordName;			// main record column
	var	$appWhereFilter;		// filter of the table
	var	$appOrderBy;			// set default order by
	var	$appAscDesc;			// set default direction for orderby
	var	$appName;
	var	$appNameSingular;
	var	$appLabel;
	var	$appLabelSingular;
	var	$appXSL;				// define specific XSL filename
	var	$appRole;				// define the application name which define the permissions/roles

	var $currentVal;
	var $countMax;
	var $first;

	var $initialSearch;


    function __construct()
    {
		if (!isset($_SESSION[$this->appName]))
		{
			$this->defaultSessionApp();
			$this->defaultInit();
			$this->initialSearch = true;
		}

#		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
#			$GLOBALS['appshore']->addNode( $this->appRole, 'export');
	}


    // to initialize the context
    function defaultInit()
    {
		$_SESSION[$this->appName][$this->appRecordName] = '';
		$_SESSION[$this->appName]['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
		$_SESSION[$this->appName]['first'] 		= 0;
		$_SESSION[$this->appName]['currentVal'] = 0;
		$_SESSION[$this->appName]['countMax'] 	= 0;
    }

    function defaultSessionApp($appName=null)
    {
    	if( $appName == null )
    		$appName = $this->appName;
    	$_SESSION[$appName]['appTable'] 		= $this->appTable;
    	$_SESSION[$appName]['appRecordId']		= $this->appRecordId;
    	$_SESSION[$appName]['appRecordName'] 	= $this->appRecordName;
    	$_SESSION[$appName]['appWhereFilter'] 	= $this->appWhereFilter;
    	$_SESSION[$appName]['appOrderBy'] 		= $this->appOrderBy;
    	$_SESSION[$appName]['appAscDesc'] 		= $this->appAscDesc;
    	$_SESSION[$appName]['appName'] 			= $this->appName;
    	$_SESSION[$appName]['appNameSingular'] 	= $this->appNameSingular;
    	$_SESSION[$appName]['appLabel'] 		= $this->appLabel;
    	$_SESSION[$appName]['appLabelSingular'] = $this->appLabelSingular;
    	$_SESSION[$appName]['appXSL'] 			= $this->appXSL;
    	$_SESSION[$appName]['appRole'] 			= $this->appRole;

    	return $_SESSION[$appName];
    }


    function menus()
    {
    	// these are the generic menus, can be overloaded or completed by specific application
		$GLOBALS['appshore']->add_appmenu($this->appName, 'Search '.strtolower($this->appLabel), $this->appName.'.base.search');
		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_USER_WRITE ) )
			$GLOBALS['appshore']->add_appmenu($this->appName, 'New '.strtolower($this->appLabelSingular), $this->appName.'.base.edit');
		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'import') )
			$GLOBALS['appshore']->add_appmenu($this->appName, 'Import '.strtolower($this->appLabel), $this->appName.'.import.start');
    }


    function start()
    {
    	return $this->search();
    }

    function defaultSearch()
	{
		$this->initialSearch = false;

		$uri = '';

		$search_filter = getOneColOneRow( 'select search_filter from searches where is_default = "Y"
			and app_name = "'.$this->appName.'" and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');

		if( $search_filter )
		{
			$search = json_decode( $search_filter, true);

			foreach( $search as $key => $val)
			{
				if( is_array($val) )
				{
					foreach( $val as $val2)
						if( $val2 != "" )
							$uri .= "&".$key."=".$val2;
				}
				else if( $val != "" && !in_array( $key, array('op','Search','Clear')) )
				{
					$uri.= "&".$key."=".$val;
				}
			}

			header('location:'.$GLOBALS['appshore_data']['server']['baseurl']."/?&op=".$this->appName.".base.search&key=LoadSearch".$uri);
		}

	}

	// search and list records
    function search()
    {
		$args = new safe_args();
		$args->set('key', 			NOTSET, 'any');
		$args->set('orderby', 		$_SESSION[$this->appName]['appOrderBy'], 'any');
		$args->set('ascdesc', 		$_SESSION[$this->appName]['appAscDesc'], 'any');
		$args->set('nbrecords', 	NOTSET, 'any');
		$args->set('groupby', 		NOTSET, 'any'); // group by sentence

		// search fields
		if(	$this->initialSearch == true )
			$this->defaultSearch();

		if( $_REQUEST['key'] == 'LoadSearch' )
			$default = NOTSET;

		if( $search_fields = $this->getFields($this->appName, $this->appTable, 'search') )
			foreach( $search_fields as $fieldkey => $fieldvalue)
			{
   				if( $_REQUEST['key'] == 'LoadSearch' )
					unset($_SESSION[$this->appName][$fieldvalue['field_name']]);

				if( !isset($_REQUEST[$fieldvalue['field_name']]) && in_array($_REQUEST['key'], array('Search','Clear')) )
					unset($_SESSION[$this->appName][$fieldvalue['field_name']]);

        		if( in_array( $fieldvalue['field_type'], array('RR')) && $fieldvalue['related_table'] && $fieldvalue['related_id'] && $fieldvalue['related_name'] )
					$args->set('related_'.$fieldvalue['field_name'], $default?$default:$_SESSION[$this->appName]['related_'.$fieldvalue['field_name']], 'any');
        		else if( in_array( $fieldvalue['field_type'], array('DD','MV')) )
        		{
      				if( ($_REQUEST['key'] != 'Search') || isset($_REQUEST[$fieldvalue['field_name']]) )
						$args->set( $fieldvalue['field_name'], $default?$default:$_SESSION[$this->appName][$fieldvalue['field_name']], 'array');
					else
						$args->set( $fieldvalue['field_name'], NOTSET, 'array');
				}
				else
					$args->set( $fieldvalue['field_name'], $default?$default:$_SESSION[$this->appName][$fieldvalue['field_name']], 'any');
			}


		// bulk operation
		$args->set('bulk_id', 		NOTSET, 'any');
		$args->set('is_blank', 		'N', 	'any');
		$args->set('is_notify', 	'N', 	'any');
		$args->set('list_id', 		NOTSET, 'any');
		$args->set('selected', 		NOTSET, 'any');

		// define bulk fields and set related fields
		if( $bulk_fields = $this->getFields($this->appName, $this->appTable, 'bulk') )
			foreach( $bulk_fields as $fieldkey => $fieldvalue)
			{
				// cast field name as bulk_xxxx
				$bulk_fields[$fieldkey]['field_name'] = 'bulk_'.$fieldvalue['field_name'];
        		if( in_array($fieldvalue['field_type'], array('RR')) && $fieldvalue['related_table'] && $fieldvalue['related_id'] && $fieldvalue['related_name'] )
	        	{
					$bulk_fields[$fieldkey]['related_name'] = 'bulk_'.$fieldvalue['related_name'];
					$bulk_fields[$fieldkey]['related_id'] = 'bulk_'.$fieldvalue['related_id'];
					$args->set('bulk_'.$fieldvalue['related_id'], $_SESSION[$this->appName]['bulk_'.$fieldvalue['related_id']], 'any');
					$args->set('bulk_'.$fieldvalue['related_name'], $_SESSION[$this->appName]['bulk_'.$fieldvalue['related_name']], 'any');
					$args->set('bulk_'.$fieldvalue['field_name'], $_SESSION[$this->appName]['bulk_'.$fieldvalue['field_name']], 'any');
				}
				else if( in_array($fieldvalue['field_type'], array('MV')) )
				{
					$args->set('bulk_'.$fieldvalue['field_name'], $_SESSION[$this->appName]['bulk_'.$fieldvalue['field_name']], 'array');
				}
				else
					$args->set('bulk_'.$fieldvalue['field_name'], $_SESSION[$this->appName]['bulk_'.$fieldvalue['field_name']], 'any');
			}

		// retrieve all passed parameters
		$args = $args->get(func_get_args());

		//save the passed arguments in session
		$_SESSION[$this->appName] = array_merge( (array)$_SESSION[$this->appName], (array)$args);

		// we need to keep the current order display of the records
#		$_SESSION[$this->appName]['appOrderBy'] = $args['orderby'] = $args['orderby'] ? $args['orderby'] : ( $_SESSION[$this->appName]['appOrderBy'] ? $_SESSION[$this->appName]['appOrderBy'] : $this->appRecordName);
#		$_SESSION[$this->appName]['appAscDesc'] = $args['ascdesc'] = $args['ascdesc'] ? $args['ascdesc'] : ( $_SESSION[$this->appName]['appAscDesc'] ? $_SESSION[$this->appName]['appAscDesc'] : ($this->appAscDesc?$this->appAscDesc:'ASC'));

		$_SESSION[$this->appName]['appOrderBy'] = $args['orderby'] ;
		$_SESSION[$this->appName]['appAscDesc'] = $args['ascdesc'] ;

		// act according returned Key
 		switch($args['key'])
		{
			case 'NbRecords':
				$GLOBALS['appshore_data']['current_user']['nbrecords'] = $args['nbrecords'];
				execMethod('preferences.lookandfeel_base.setNbRecords', null, true);
				setPosition( $_SESSION[$this->appName]['currentVal'], $_SESSION[$this->appName]['countMax'], $_SESSION[$this->appName]['first'], $args['key']);
				break;

			case 'Delete':
				$this->bulk_delete( $args);
				setPosition( $_SESSION[$this->appName]['currentVal'], $_SESSION[$this->appName]['countMax'], $_SESSION[$this->appName]['first'], $args['key']);
				break;

			case 'Save':
				if( $bulk_fields )
					foreach( $bulk_fields as $fieldkey => $fieldvalue)
					{
						if( isset($args[$fieldvalue['field_name']]) && in_array( $fieldvalue['field_type'], array('MV')) )
						{
							$args[$fieldvalue['field_name']] = implode('::',$args[$fieldvalue['field_name']]);
						}

					}
				$this->bulk_save( $args);
				setPosition( $_SESSION[$this->appName]['currentVal'], $_SESSION[$this->appName]['countMax'], $_SESSION[$this->appName]['first'], $args['key']);
				break;

			case 'Default':
				$argkey = true;
			case 'Clear':
				unset($args);
				// we still want to keep the order by because it is usefull
				$args['orderby'] = $_SESSION[$this->appName]['appOrderBy'];
				$args['ascdesc'] = $_SESSION[$this->appName]['appAscDesc'];
				$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
				unset($_SESSION[$this->appName]);
				$this->defaultSessionApp();
				$this->defaultInit();
				if( $argkey )
					$this->defaultSearch();
				return $this->search($args);
				break;

			case 'LoadSearch':
				$_SESSION[$this->appName]['first'] 		= 0;
				$_SESSION[$this->appName]['currentVal'] = 0;
				$_SESSION[$this->appName]['countMax'] 	= 0;
				header('location:'.$GLOBALS['appshore_data']['server']['baseurl'].'/?&op='.$GLOBALS['appshore_data']['api']['op']);
				break;

			case 'Search':
				unset($args[$this->appRecordId]);
				// No Break
			case 'Next':
			case 'Previous':
			case 'Last':
			case 'First':
			default:
				setPosition( $_SESSION[$this->appName]['currentVal'], $_SESSION[$this->appName]['countMax'], $_SESSION[$this->appName]['first'], $args['key']);
				break;
		}

		// retrieve fields to display results
		$result['result_fields'] = $this->getFields($this->appName, $this->appTable, 'result');

		// build the SQL request
		$sql = $this->buildSQL( $args, $search_fields, $result['result_fields']);

		// fetch Results and format them
		$result[$this->appName] = $this->getSearchResults( $this->appName, $GLOBALS['appshore_data']['current_user']['nbrecords'], $sql, $result['result_fields']);

		// Save context in cookie SESSION_SID
		$_SESSION[$this->appName]['bulk_id'] = $args['bulk_id'];

		// Put context in XML to be processed by XSL
		//$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];

		// set the global scope according user's rights of this application
		$result['scope'] = ''.( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_USER_WRITE ) )?1:0 ;

		// scan search form fields to handle some specific cases (related, drop down)
		$result['search_fields'] = $search_fields;
		if( $result['search_fields'] )
			foreach( $result['search_fields'] as $fieldkey => $fieldvalue)
			{
				switch( $fieldvalue['field_type'] )
				{
        			case 'DD':
        			case 'MV':
						if( !$fieldvalue['related_table'] || !$fieldvalue['related_id'] || !$fieldvalue['related_name'] )
							break;
	       				if ( $fieldvalue['related_table'] == 'users' )
							$result['search_fields'][$fieldkey]['field_options'] = getManyAssocArrays(
								'select distinct '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
								$fieldvalue['related_table'].buildClauseWhere($this->appRole,'R').' '.$fieldvalue['related_filter']);
        				else
							$result['search_fields'][$fieldkey]['field_options'] = getManyAssocArrays(
								'select distinct '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
								$fieldvalue['related_table'].' '.$fieldvalue['related_filter']);
						$result['search_fields'][$fieldkey]['field_current_value'] = $args[$fieldvalue['field_name']];
						break;

        			case 'DF':
						$result['search_fields'][$fieldkey]['field_current_value'] = stripslashes($args[$fieldvalue['field_name']]);
						require_once( APPSHORE_LIB.SEP.'lib.folders.php');
						$result['search_fields'][$fieldkey]['folders'] = getFolders('0');
						break;

					case 'RD' :
					case 'RM' :
						$result['search_fields'][$fieldkey]['field_current_value'] = stripslashes($args[$fieldvalue['field_name']]);
						$result = $this->setNotificationOptions( $result, $fieldvalue['field_type']);
						list($remnbr,$period) = explode('.',$result['search_fields'][$fieldkey]['field_current_value']);
						if( $remnbr != '' && $period != '')
						{
							$result['search_fields'][$fieldkey]['field_current_value'] = $result['search_fields'][$fieldkey]['field_current_value'];
							$result['search_fields'][$fieldkey]['field_current_value_nbr'] = $remnbr;
							$result['search_fields'][$fieldkey]['field_current_value_period'] = $period;
						}
						break;

         			case 'RR':
						if( $fieldvalue['related_name'] )
							$result['search_fields'][$fieldkey]['field_current_value'] = $args['related_'.$fieldvalue['field_name']];
						else
							$result['search_fields'][$fieldkey]['field_current_value'] = stripslashes($args[$fieldvalue['field_name']]);
						break;

					default:
						$result['search_fields'][$fieldkey]['field_current_value'] = stripslashes($args[$fieldvalue['field_name']]);
						break;

				}
			}

		// scan bulk form fields to handle some specifc cases (related, drop down)
		$result['bulk_fields'] = $bulk_fields;
		if( $result['bulk_fields'] )
		{
			foreach( $result['bulk_fields'] as $fieldkey => $fieldvalue)
			{
				if( $fieldvalue['field_type'] == 'MV' )
					$result['bulk_fields'][$fieldkey]['field_current_value'] = $args[$fieldvalue['field_name']];
				else
					$result['bulk_fields'][$fieldkey]['field_current_value'] = stripslashes($args[$fieldvalue['field_name']]);

				// no computed fields should appear in the SQL request
				if(  $fieldvalue['is_computed'] == 'Y' )
					continue;

				switch( $fieldvalue['field_type'] )
				{
        			case 'DD':
						if( !$fieldvalue['related_table'] || !$fieldvalue['related_id'] || !$fieldvalue['related_name'] )
							break;

        				if ( $fieldvalue['related_table'] == 'users' )
        					$result['bulk_fields'][$fieldkey]['field_options'] = getManyAssocArrays(
        						'select distinct '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
        						$fieldvalue['related_table'].buildClauseWhere($this->appRole,'W').' '.$fieldvalue['related_filter'] );
        				else
							$result['bulk_fields'][$fieldkey]['field_options'] = getManyAssocArrays(
								'select distinct '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
								$fieldvalue['related_table'].' '.$fieldvalue['related_filter']);
						break;

        			case 'MV':
						if( !$fieldvalue['related_table'] || !$fieldvalue['related_id'] || !$fieldvalue['related_name'] )
							break;

        				if ( $fieldvalue['related_table'] == 'users' )
        					$result['bulk_fields'][$fieldkey]['field_options'] = getManyAssocArrays(
        						'select distinct '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
        						$fieldvalue['related_table'].buildClauseWhere($this->appRole,'W').' '.$fieldvalue['related_filter'] );
        				else
							$result['bulk_fields'][$fieldkey]['field_options'] = getManyAssocArrays(
								'select distinct '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
								$fieldvalue['related_table'].' '.$fieldvalue['related_filter']);

						if( !is_array($result['bulk_fields'][$fieldkey]['field_current_value']) )
						{
							unset($res);
							foreach( explode('::',$result['bulk_fields'][$fieldkey]['field_current_value']) as $val)
							{
								$res[] = $val;
							}
							$result['bulk_fields'][$fieldkey]['field_current_value'] = $res;
						}

						break;


					case 'RD' :
					case 'RM' :
						$result = $this->setNotificationOptions( $result, $fieldvalue['field_type']);
						list($remnbr,$period) = explode('.',$result['bulk_fields'][$fieldkey]['field_current_value']);
						if( $remnbr != '' && $period != '')
						{
							$result['bulk_fields'][$fieldkey]['field_current_value'] = $result['bulk_fields'][$fieldkey]['field_current_value'];
							$result['bulk_fields'][$fieldkey]['field_current_value_nbr'] = $remnbr;
							$result['bulk_fields'][$fieldkey]['field_current_value_period'] = $period;
						}
						break;

        			case 'RR':
						if( $fieldvalue['related_name'] )
							$result['bulk_fields'][$fieldkey]['field_current_value'] = $args[$fieldvalue['related_name']];
						break;
				}
			}
			// we retrieve the blocks that format the bulk form
			$result['bulk_blocks'] = getManyAssocArrays('select * from db_blocks where app_name = "'.$this->appName.'" and form_name = "bulk" order by block_sequence');
		}

		// get these fields for search criterias form
		for( $i = 1 ; $i < 11 ; $i++)
			$result['nbrecords'][] = array('nbrecords'=>($i*5));
		$result['bulk']= array(
			array('bulk_id' => 'Selected', 'bulk_name'=>lang('Selected lines')),
			array('bulk_id' => 'Page', 'bulk_name'=>lang('Current page')),
			array('bulk_id' => 'All', 'bulk_name'=>lang('All results'))
			);

		// set the needed XSL files for presentation
        $GLOBALS['appshore']->add_xsl($this->appXSL);
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl('lib.custom');
        $GLOBALS['appshore']->add_xsl('lib.actions');
        $GLOBALS['appshore']->add_xsl('lib.search');
        $GLOBALS['appshore']->add_xsl('lib.grid');
        $GLOBALS['appshore']->add_xsl('lib.gridfields');
        $GLOBALS['appshore']->add_xsl('lib.bulk');

        // build the menus
        $this->menus();

		// define next action
		$result['action'][$this->appName] = 'search';

		// we return the whole created array
        return $result;
    }


    // we build the SQL request based on search, result fields and filter criterias
	function buildSQL( $args=null, $search_fields=null, $result_fields=null, $session_popup = '')
	{
		// Result fields list
		unset($_SESSION[$session_popup.$this->appName]['sql']);
		$_SESSION[$session_popup.$this->appName]['sql']['select'] = 'SELECT SQL_CALC_FOUND_ROWS ';

		if( $result_fields == null )
			$result_fields = $this->getFields($this->appName, $this->appTable, 'result');

		if( $search_fields == null )
			$search_fields = $this->getFields($this->appName, $this->appTable, 'search');

		$checkRBAC = false; //in case the table own the field user_id we must check the ownership

		if( isset($result_fields['user_id']) || isset($search_fields['user_id']))
		{
			//$_SESSION[$session_popup.$this->appName]['sql']['join'] = 'LEFT OUTER JOIN users ON t0.user_id = users.user_id ';
			$checkRBAC = true;
		}
		else if( describeColumns( $this->appTable, 'user_id'))
		{
			//$_SESSION[$session_popup.$this->appName]['sql']['join'] = 'LEFT OUTER JOIN users ON t0.user_id = users.user_id ';
			$checkRBAC = true;
		}

#		$_SESSION[$session_popup.$this->appName]['sql']['join'] = '';

		unset($alias);
		unset($t1);
		$tinc = 2;
		if( $result_fields )
		{
           // distinct has been added to avoid multiple display of same record
 			$select = '';
 			$distinct = '';
			$joinTable = null;

	    	foreach( $result_fields as $fieldkey => $fieldvalue)
	    	{
				$select .= ', t0.'.$fieldvalue['field_name'];

	        	if( in_array( $fieldvalue['field_type'], array('DD', 'DF', 'RR')) && $fieldvalue['related_table'] && $fieldvalue['related_id'] && $fieldvalue['related_name'] )
	        	{
	        		if( $fieldvalue['related_name'] != $fieldvalue['related_id'] )
	        		{
						// array used to match alias in case of related table
			    		if( $fieldvalue['related_table'] == 'users' && isset($t1) == false )
							$t1 = $alias['related_'.$fieldvalue['field_name']] = 't1';
			    		else if( isset($alias['related_'.$fieldvalue['field_name']]) == false )
							$alias['related_'.$fieldvalue['field_name']] = 't'.$tinc++;

						$select .= ', '.$alias['related_'.$fieldvalue['field_name']].'.'.$fieldvalue['related_name'].' as related_'.$fieldvalue['field_name'];

						if( strpos( $_SESSION[$session_popup.$this->appName]['sql']['join'], $alias['related_'.$fieldvalue['field_name']].'.') == false )
							$_SESSION[$session_popup.$this->appName]['sql']['join'] .= 'LEFT OUTER JOIN '.$fieldvalue['related_table'].' '.$alias['related_'.$fieldvalue['field_name']].' ON t0.'.$fieldvalue['field_name'].' = '.$alias['related_'.$fieldvalue['field_name']].'.'.$fieldvalue['related_id'].' ';

#						if( $joinTable[$fieldvalue['related_table']] )
#							$distinct = 'distinct';
#						else
#							$joinTable[$fieldvalue['related_table']] = true;
					}
					else
					{
						$select .= ', t0.'.$fieldvalue['field_name'].' as related_'.$fieldvalue['field_name'];
					}
				}
			}

 			$_SESSION[$session_popup.$this->appName]['sql']['select'] .= $distinct.' t0.'.$this->appRecordId.$select;
		}

		// mandatory fields in the SQL request
#		switch( $this->appName )
#		{
#			case 'accounts':
#			case 'campaigns_lists':
#			case 'contacts':
#			case 'departments':
#			case 'documents':
#			case 'leads':
#			case 'reports':
#			case 'roles':
#			case 'tags':
#			case 'users':
#				$mand = array('created','updated');
#				break;
#			case 'activities':
#				$mand = array('activity_start', 'activity_end','created','updated');
#				break;
#			case 'campaigns':
#				$mand = array('scheduled','created','updated');
#				break;
#			case 'cases':
#				$mand = array('due_date','created','updated');
#				break;
#			case 'customers':
#				$mand = array('due_date','license_time_stamp','created','updated');
#				break;
#			case 'opportunities':
#				$mand = array('closing','created','updated');
#				break;
#			case 'webmail':
#				$mand = array('mail_date');
#				break;
#			default:
#				$mand = null;
#				break;
#		}

		$mand = getOneColManyRows('select field_name from db_fields where table_name = "'.$this->appTable.'" and is_result = "Y"');

		if( $mand )
			foreach( $mand as $val )
				if( strpos($_SESSION[$session_popup.$this->appName]['sql']['select'],'t0.'.$val) === false )
					$_SESSION[$session_popup.$this->appName]['sql']['select'] .= ', t0.'.$val;

//messagebox( $this->appTable.'  '.$_SESSION[$session_popup.$this->appName]['sql']['select'], ERROR);

#		$_SESSION[$session_popup.$this->appName]['sql']['where'] = '';
		if( $search_fields && $args )
		{
			foreach( $search_fields as $fieldkey => $fieldvalue )
			{
				// no computed fields should appear in the SQL request
				if(  $fieldvalue['is_computed'] == 'Y' )
					continue;

				switch ( $fieldvalue['field_type'] )
				{
	       			case 'CU':
	        		case 'NU':
	        		case 'PE':
	       			case 'CD':
	        		case 'ND':
	        		case 'PD':
						if( $args[$fieldvalue['field_name']] == '' )
							break;

						if( strpos( $args[$fieldvalue['field_name']],'..') === false )
							$where .= ' AND t0.'.$fieldvalue['field_name'].' = "'.$args[$fieldvalue['field_name']].'" ';
						else
						{
							list( $rangestart, $rangeend) = explode( '..', $args[$fieldvalue['field_name']]);
							if( $rangestart and $rangeend )
							{
								$where .= ' AND (t0.'.$fieldvalue['field_name'].' BETWEEN "'.$rangestart.'" AND "'.$rangeend.'") ';
							}
							else if( $rangestart )
							{
								$where .= ' AND t0.'.$fieldvalue['field_name'].' >= "'.$rangestart.'" ';
							}
							else if( $rangeend )
							{
								$where .= ' AND t0.'.$fieldvalue['field_name'].' <= "'.$rangeend.'" ';
							}
						}


						$_SESSION[$session_popup.$this->appName]['sql']['where'] .= $where;
						$_SESSION[$session_popup.$this->appName][$fieldvalue['field_name']] = $args[$fieldvalue['field_name']];
						break;


					case 'DA':
					case 'DT':
					case 'TS':
						if( $args[$fieldvalue['field_name']] == '' )
							break;

						if( $fieldvalue['field_type'] == 'DA' )
							$gmtDateTime = ' t0.'.$fieldvalue['field_name'];
						else
							$gmtDateTime = 'timestampadd(second,'.$GLOBALS['appshore_data']['current_user']['timezone_offset'].', t0.'.$fieldvalue['field_name'].')';

						$daterange = strtolower(stripslashes(trim($args[$fieldvalue['field_name']])));
						$periods = getManyAssocArrays( 'SELECT period_name FROM periods');
						if( $periods )
						{
							foreach( $periods as $key => $val)
							{
								if( $daterange == strtolower(lang($val['period_name'])) )
								{
									$daterange = $val['period_name'];
									break;
								}
							}
						}
                        // to take in account timezone in date as well
                        $today = $GLOBALS['appshore']->local->gmtToTZDate('today');

                        switch ( strtolower($daterange) )
                        {
                            case 'today':
                                $where .= ' AND date('.$gmtDateTime.') = "'.$today.'" ';
                                break;
							case 'tomorrow':
						    	$where .= ' AND date('.$gmtDateTime.') = date(date_add("'.$today.'", interval +1 day)) ';
						    	break;
							case 'yesterday':
						    	$where .= ' AND date('.$gmtDateTime.') = date(date_add("'.$today.'", interval -1 day))  ';
						    	break;
							case 'this week':
						    	$where .= ' AND week('.$gmtDateTime.') = week("'.$today.'") AND year('.$gmtDateTime.') = year("'.$today.'") ';
						    	break;
							case 'next week':
						    	$where .= ' AND week('.$gmtDateTime.') = week(date_add("'.$today.'", interval 7 day)) AND year('.$gmtDateTime.') = year(date_add("'.$today.'", interval 7 day)) ';
						    	break;
							case 'last week':
						    	$where .= ' AND week('.$gmtDateTime.') = week(date_add("'.$today.'", interval -7 day)) AND year('.$gmtDateTime.') = year(date_add("'.$today.'", interval -7 day)) ';
						    	break;
							case 'this month':
						    	$where .= ' AND month('.$gmtDateTime.') = month("'.$today.'") AND year('.$gmtDateTime.') = year("'.$today.'") ';
						    	break;
							case 'next month':
						    	$where .= ' AND month('.$gmtDateTime.') = month(date_add("'.$today.'", interval 1 month)) AND year('.$gmtDateTime.') = year(date_add("'.$today.'", interval 1 month)) ';
						    	break;
							case 'last month':
						    	$where .= ' AND month('.$gmtDateTime.') = month(date_add("'.$today.'", interval -1 month)) AND year('.$gmtDateTime.') = year(date_add("'.$today.'", interval -1 month)) ';
						    	break;
							case 'this quarter':
						    	$where .= ' AND quarter('.$gmtDateTime.') = quarter("'.$today.'") AND year('.$gmtDateTime.') = year("'.$today.'") ';
						    	break;
							case 'next quarter':
						    	$where .= ' AND quarter('.$gmtDateTime.') = quarter(date_add("'.$today.'", interval 3 month)) AND year('.$gmtDateTime.') = year(date_add("'.$today.'", interval 3 month)) ';
						    	break;
							case 'last quarter':
						    	$where .= ' AND quarter('.$gmtDateTime.') = quarter(date_add("'.$today.'", interval -3 month)) AND year('.$gmtDateTime.') = year(date_add("'.$today.'", interval -3 month)) ';
						    	break;
							case 'this year':
						    	$where .= ' AND year('.$gmtDateTime.') = year("'.$today.'") ';
						    	break;
							case 'next year':
						    	$where .= ' AND year('.$gmtDateTime.') = year("'.$today.'")+1 ';
						    	break;
							case 'last year':
						    	$where .= ' AND year('.$gmtDateTime.') = year("'.$today.'")-1 ';
						    	break;
						    default:
								if( $fieldvalue['field_type'] == 'DA' )
								{
									if( strpos( $args[$fieldvalue['field_name']],'..') === false )
									{
										$where .= ' AND t0.'.$fieldvalue['field_name'].' like "%'.$GLOBALS['appshore']->local->localToDate($args[$fieldvalue['field_name']]).'%" ';
									}
									else
									{
										list( $datestart, $dateend) = explode( '..', $args[$fieldvalue['field_name']]);
										if( $datestart and $dateend )
										{
											$where .= ' AND (t0.'.$fieldvalue['field_name'].' BETWEEN "'.$GLOBALS['appshore']->local->localToDate($datestart).'" AND "'.$GLOBALS['appshore']->local->localToDate($dateend).'") ';
										}
										else if( $datestart )
										{
											$where .= ' AND t0.'.$fieldvalue['field_name'].' >= "'.$GLOBALS['appshore']->local->localToDate($datestart).'" ';
										}
										else if( $dateend )
										{
											$where .= ' AND t0.'.$fieldvalue['field_name'].' <= "'.$GLOBALS['appshore']->local->localToDate($dateend).'" ';
										}
									}
								}
								else
								{
									if( strpos( $args[$fieldvalue['field_name']],'..') === false )
									{
										if( $GLOBALS['appshore']->local->localToDate($args[$fieldvalue['field_name']]) == null && $GLOBALS['appshore']->local->localToTime($args[$fieldvalue['field_name']]) == null)
										{
											$where .= ' AND t0.'.$fieldvalue['field_name'].' like "%'.$args[$fieldvalue['field_name']].'%" ';
										}
										else if( $GLOBALS['appshore']->local->localToTime($args[$fieldvalue['field_name']]) == null)
										{
											$where .= ' AND (t0.'.$fieldvalue['field_name'].' >= "'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDate($args[$fieldvalue['field_name']])).'" ';
											$where .= ' AND t0.'.$fieldvalue['field_name'].' < date_add("'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDatetime($args[$fieldvalue['field_name']])).'", interval +1 day)) ';
										}
										else
										{
											$where .= ' AND t0.'.$fieldvalue['field_name'].' = "'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDatetime($args[$fieldvalue['field_name']])).'%" ';
										}
									}
									else
									{
										list( $datestart, $dateend) = explode( '..', $args[$fieldvalue['field_name']]);
										if( $datestart and $dateend )
										{
											$where .= ' AND (t0.'.$fieldvalue['field_name'].' >= "'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDate($datestart)).'" ';
											$where .= ' AND t0.'.$fieldvalue['field_name'].' < date_add("'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDatetime($dateend)).'", interval +1 day)) ';
										}
										else if( $datestart )
											$where .= ' AND t0.'.$fieldvalue['field_name'].' >= "'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDate($datestart)).'" ';
										else if( $dateend )
											$where .= ' AND t0.'.$fieldvalue['field_name'].' < date_add("'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDatetime($dateend)).'", interval +1 day) ';
									}
								}
						    	break;
						}
						$_SESSION[$session_popup.$this->appName]['sql']['where'] .= $where;
						$_SESSION[$session_popup.$this->appName][$fieldvalue['field_name']] = $args[$fieldvalue['field_name']];
						break;

	       			case 'DD':
						if( $args[$fieldvalue['field_name']] == '' )
							break;

						if( is_array($args[$fieldvalue['field_name']]))
							$_SESSION[$session_popup.$this->appName]['sql']['where'] .= ' AND t0.'.$fieldvalue['field_name'].' in ("'.implode('","',$args[$fieldvalue['field_name']]).'") ';
						else
							$_SESSION[$session_popup.$this->appName]['sql']['where'] .= ' AND t0.'.$fieldvalue['field_name'].' = "'.$args[$fieldvalue['field_name']].'" ';

						$_SESSION[$session_popup.$this->appName][$fieldvalue['field_name']] = $args[$fieldvalue['field_name']];
						break;

	       			case 'MV':
						if( $args[$fieldvalue['field_name']] == '' )
							break;

						if( is_array($args[$fieldvalue['field_name']]))
						{
							foreach( $args[$fieldvalue['field_name']] as $val)
								$_SESSION[$session_popup.$this->appName]['sql']['where'] .= ' AND t0.'.$fieldvalue['field_name'].' like "%'.$val.'%" ';
						}
						else
							$_SESSION[$session_popup.$this->appName]['sql']['where'] .= ' AND t0.'.$fieldvalue['field_name'].' = "'.$args[$fieldvalue['field_name']].'" ';

						$_SESSION[$session_popup.$this->appName][$fieldvalue['field_name']] = $args[$fieldvalue['field_name']];
						break;

	        		case 'RE':
						if( $args[$fieldvalue['field_name']] == '' )
							break;

						$_SESSION[$session_popup.$this->appName]['sql']['where'] .= ' AND t0.'.$fieldvalue['field_name'].' = "'.$args[$fieldvalue['field_name']].'" ';
						$_SESSION[$session_popup.$this->appName][$fieldvalue['field_name']] = $args[$fieldvalue['field_name']];
						break;

	        		case 'LI':
						if( $args[$fieldvalue['field_name']] != '' ){

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

							if( $record_ids ){
								$_SESSION[$session_popup.$this->appName]['sql']['where'] .= ' AND t0.'.$fieldvalue['field_name'].' in ("'.implode('","', $record_ids).'")';
								$_SESSION[$session_popup.$this->appName][$fieldvalue['field_name']] = $args[$fieldvalue['field_name']];
							}
						}
				    	break;

					case 'RR':
						if( $args['related_'.$fieldvalue['field_name']] == '' )
							break;

						// try to match with an already used alias above
						if ( isset($alias['related_'.$fieldvalue['field_name']]) == false )
							$alias['related_'.$fieldvalue['field_name']] = 't'.$tinc++;

						$_SESSION[$session_popup.$this->appName]['sql']['where'] .= ' AND '.$alias['related_'.$fieldvalue['field_name']].'.'.$fieldvalue['related_name'].' like "%'.$args['related_'.$fieldvalue['field_name']].'%" ';
						$_SESSION[$session_popup.$this->appName]['related_'.$fieldvalue['field_name']] = $args['related_'.$fieldvalue['field_name']];

						// to avoid to repeat the JOIN if already defined above
						if( strpos( $_SESSION[$session_popup.$this->appName]['sql']['join'], $alias['related_'.$fieldvalue['field_name']].'.') == false )
							$_SESSION[$session_popup.$this->appName]['sql']['join'] .= 'LEFT OUTER JOIN '.$fieldvalue['related_table'].' '.$alias['related_'.$fieldvalue['field_name']].' ON  t0.'.$fieldvalue['field_name'].' = '.$alias['related_'.$fieldvalue['field_name']].'.'.$fieldvalue['related_id'].' ';
				    	break;

					default:
						if( $args[$fieldvalue['field_name']] == '' )
							break;

						$_SESSION[$session_popup.$this->appName]['sql']['where'] .= ' AND t0.'.$fieldvalue['field_name'].' like "%'.$args[$fieldvalue['field_name']].'%" ';
						$_SESSION[$session_popup.$this->appName][$fieldvalue['field_name']] = $args[$fieldvalue['field_name']];
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

		if ( !isset($where) && $_SESSION[$session_popup.$this->appName]['sql']['where'] )
			$where = ' WHERE'.substr( $_SESSION[$session_popup.$this->appName]['sql']['where'], 4);
		else
			$where .= $_SESSION[$session_popup.$this->appName]['sql']['where'];

		$_SESSION[$session_popup.$this->appName]['sql']['where'] = $where;

		// Group By
#		$_SESSION[$session_popup.$this->appName]['sql']['groupby'] = '';
		if( $args['groupby'] )
		{
			$groupby = $args['groupby'];

			if( strstr( $groupby, 'related_') == false )
				$_SESSION[$session_popup.$this->appName]['sql']['groupby'] = ' GROUP BY t0.'.$groupby;
			else
				$_SESSION[$session_popup.$this->appName]['sql']['groupby'] = ' GROUP BY '.$groupby;
		}

		// Order By
#		$_SESSION[$session_popup.$this->appName]['sql']['orderby'] = '';
		if( $args['orderby'] || $_SESSION[$this->appName]['appOrderBy'] )
		{
			if( $args['orderby'])
				$orderby = $args['orderby'].' '.$args['ascdesc'];
			else
				$orderby = $_SESSION[$this->appName]['appOrderBy'].' '.$_SESSION[$this->appName]['appAscDesc'];

			if( strpos( $orderby, 'related_') === false )
				$_SESSION[$session_popup.$this->appName]['sql']['orderby'] = ' ORDER BY t0.'.$orderby;
			else
				$_SESSION[$session_popup.$this->appName]['sql']['orderby'] = ' ORDER BY '.$orderby;

			if( ($pos = strpos( $orderby, 'related_')) === false )
				$_SESSION[$session_popup.$this->appName]['sql']['orderby'] = ' ORDER BY t0.'.$orderby;
			else
				{
					if ($pos == 0 )
						$_SESSION[$session_popup.$this->appName]['sql']['orderby'] = ' ORDER BY '.str_replace( 'related_', 't0.', $orderby);
					else
						$_SESSION[$session_popup.$this->appName]['sql']['orderby'] = ' ORDER BY '.$orderby;
				}

		}

		$_SESSION[$session_popup.$this->appName]['sql']['from'] = ' FROM '.$this->appTable.' t0 ';

		// SQl request is completed, it is saved in session for further need
		$request = $_SESSION[$session_popup.$this->appName]['sql']['select']
			.$_SESSION[$session_popup.$this->appName]['sql']['from']
			.$_SESSION[$session_popup.$this->appName]['sql']['join']
			.$_SESSION[$session_popup.$this->appName]['sql']['where']
			.$_SESSION[$session_popup.$this->appName]['sql']['groupby']
			.$_SESSION[$session_popup.$this->appName]['sql']['orderby'];

		$request = str_replace('  ', ' ', $request);
		$request = str_replace('1=1 AND', '', $request);
		$request = str_replace('WHERE 1=1', '', $request);

		$_SESSION[$session_popup.$this->appName]['sql']['request'] = $request;

#messagebox( $_SESSION[$session_popup.$this->appName]['sql']['request'], ERROR);

		return $_SESSION[$session_popup.$this->appName]['sql']['request'];
	}


    // get all fields mandatory for each action (search, result, bulk)
    // if the app_name is undefined we force it to the current appRole equals main app_name
	function getFields( $app_name, $table_name, $form)
	{
		$sql = 'select f.*, a.app_name as related_app_name
			from db_fields f
			left outer join db_applications a
				on f.related_table = a.table_name
				and a.is_related = "Y"
			where
				f.app_name = "'.$app_name.'"
				and f.table_name = "'.$table_name.'"
				and f.'.$form.'_sequence > "0" order by f.'.$form.'_sequence';

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
	function getSearchResults( $appName, $range, $sql, $result_fields, $is_popup=false)
	{
		$range = $range?$range:$GLOBALS['appshore_data']['current_user']['nbrecords'];
		$offset = $_SESSION[$appName]['currentVal']?$_SESSION[$appName]['currentVal']:'0';
		$_SESSION[$session_popup.$this->appName]['sql']['limit'] = ' LIMIT '.$range.' OFFSET '.$offset;

		if( ($db = executeSQL($sql.$_SESSION[$session_popup.$this->appName]['sql']['limit'], false)) == NULL )
			return;

		$count = getOneAssocArray('SELECT FOUND_ROWS() as max');
		$_SESSION[$appName]['countMax'] = $count['max'];

		$nbr = 0;
		while( !$db->EOF && $nbr < $range)
		{
            $result[$nbr] = $db->GetRowAssoc(false);

            // no scope on popup
            if( $is_popup == false)
	       		$result[$nbr]['scope'] = ''.$GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $db->fields['user_id']) ;
	       	else
	       		$result[$nbr]['scope'] = '1' ;

	       	$result[$nbr]['offset'] = $_SESSION[$appName]['currentVal']+$nbr ;

        	if( isset($result[$nbr]['created']) &&
	       		(strtotime($result[$nbr]['created']) >= mktime(0, 0, 0, date("m"), date("d")-1, date("Y"))) )
        		$result[$nbr]['record_class'] = 'new';
        	else
        		$result[$nbr]['record_class'] = 'unselectedtext';

        	if( isset($result[$nbr]['due_date']) && ($result[$nbr]['due_date'] != '0000-00-00') &&
        		(strtotime($result[$nbr]['due_date']) < mktime(0, 0, 0, date("m"), date("d"), date("Y"))) )
        		$result[$nbr]['record_class'] = 'expired';
        	else if( isset($result[$nbr]['closing']) && ($result[$nbr]['closing'] != '0000-00-00') &&
        		(strtotime($result[$nbr]['closing']) < mktime(0, 0, 0, date("m"), date("d"), date("Y"))) )
        		$result[$nbr]['record_class'] = 'expired';
        	else if( isset($result[$nbr]['activity_end']) && ($result[$nbr]['activity_end'] != '0000-00-00 00:00:00') &&
        		isset($result[$nbr]['activity_start']) && ($result[$nbr]['activity_start'] != '0000-00-00 00:00:00') &&
      			($result[$nbr]['activity_start'] < gmdate('Y-m-d H:i:s', strtotime('now'))) &&
       			($result[$nbr]['activity_end'] > gmdate('Y-m-d H:i:s', strtotime('now'))) )
        		$result[$nbr]['record_class'] = 'inprogress';
        	else if( isset($result[$nbr]['activity_end']) && ($result[$nbr]['activity_end'] != '0000-00-00 00:00:00') &&
      			($result[$nbr]['activity_end'] < gmdate('Y-m-d H:i:s', strtotime('now'))) )
	      		$result[$nbr]['record_class'] = 'expired';

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

					case 'MV' :
						if( $result[$nbr][$fieldvalue['field_name']] )
						{
							unset($res);
							foreach( explode('::',$result[$nbr][$fieldvalue['field_name']]) as $val)
							{
								if( $res )
									$res .= ', ';
								$res .= getOneColOneRow('select '.$fieldvalue['related_name'].' from '.$fieldvalue['related_table'].
									' where '.$fieldvalue['related_id'].' = "'.$val.'"');

							}
							$result[$nbr][$fieldvalue['field_name']] = $res;
						}
						break;

					case 'RD' :
					case 'RM' :
						list($remnbr,$period) = explode('.',$result[$nbr][$fieldvalue['field_name']]);
						if( $remnbr != '' && $period != '')
							$result[$nbr][$fieldvalue['field_name']] = $remnbr.' '.getOneColOneRow('select period_name from global_notifications_periods where period_id = "'.$period.'"');
						else
							$result[$nbr][$fieldvalue['field_name']] = '';
						break;

					case 'WS' :
						if( strlen($result[$nbr][$fieldvalue['field_name']]) && strpos( $result[$nbr][$fieldvalue['field_name']], '://') === false)
							$result[$nbr][$fieldvalue['field_name']] = 'http://'.$result[$nbr][$fieldvalue['field_name']];
						break;
				}

				if( $is_popup == true )
				{
					// to handle the case of string containing quote or apostrophe while passing char to js
					// see grid.xsl with passBackTuple
					$result[$nbr][$fieldvalue['field_name'].'_slash'] = addslashes($result[$nbr][$fieldvalue['field_name']]);
				}
			}
            $db->MoveNext();
			$nbr++;
		}

		$_SESSION[$appName]['first'] = $_SESSION[$appName]['currentVal'] + $nbr ;

//		$count = getOneAssocArray('SELECT FOUND_ROWS() as max');
//		$_SESSION[$appName]['countMax'] = $count['max'];

		return $result;
	}


    function deleteRecord( $record_id, $verbose=false)
    {
		$record[$this->appRecordId] = $record_id;

		// delete record record_id
    	$truefalse = deleteRow( $this->appTable, $this->appRecordId, $record, $verbose);

 		// delete all files related to this record
    	foreach (glob(APPSHORE_IMAGES.'/'.$this->appName.'_'.$record_id.'_*') as $filename)
    	{
   			unlink($filename);
		}

    	// delete links related to record_id
		try
		{
			executeSQL('delete from links where (from_table = "'.$this->appTable.'" and from_id = "'.$record_id.'")
			 or (to_table = "'.$this->appTable.'" and to_id = "'.$record_id.'")');
		}
		catch (Exception $e)
		{
    		messagebox( $e->getMessage(), ERROR);
    		return;
		}

		if( $verbose == true )
			messagebox( MSG_DELETE, NOTICE);

		$GLOBALS['appshore']->history->removeFromHistory( $this->appRecordId.'='.$record_id );

		return $truefalse;
    }


   	// view one record
    function view()
    {
		$args = new safe_args();
		$args->set($this->appRecordId, 	NOTSET,'any');
		$args->set('key',				NOTSET,'any');
		$args->set('offset', 			NOTSET,'any');
		$args = $args->get(func_get_args());

        $GLOBALS['appshore']->add_xsl($this->appXSL);
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl('lib.custom');
        $GLOBALS['appshore']->add_xsl('lib.actions');
        $GLOBALS['appshore']->add_xsl('lib.view');
	    $GLOBALS['appshore']->add_xsl('lib.linked');
	    $GLOBALS['appshore']->add_xsl('lib.gridfields');
        $this->menus();

		if( !isset($args[$this->appRecordId]))
			$args['key'] = 'Error';

		switch($args['key'])
		{
			case 'Next':
			case 'Previous':
			case 'Last':
			case 'First':
				if( isset($_SESSION[$session_popup.$this->appName]['sql']['request']) == false)
					$db = executeSQL($this->buildSQL());
				else
					$db = executeSQL($_SESSION[$session_popup.$this->appName]['sql']['request']);
				$nbrecords = $GLOBALS['appshore_data']['current_user']['nbrecords'];
				$GLOBALS['appshore_data']['current_user']['nbrecords'] = 1;
				setPosition( $_SESSION[$this->appName]['currentVal'], $_SESSION[$this->appName]['countMax'], $_SESSION[$this->appName]['first'], $args['key'], 1);
				$GLOBALS['appshore_data']['current_user']['nbrecords'] = $nbrecords ;
				$_SESSION[$this->appName]['countMax'] = $db->RowCount();
				$db->Move( $_SESSION[$this->appName]['currentVal']);
				$args['offset'] = $_SESSION[$this->appName]['currentVal'];
	            $args[$this->appRecordId] = $db->fields[$this->appRecordId];
				unset($args['key']);
				$result = $this->view( $args);
				break;

			case 'Print':
				unset( $args['key']);
				$result = $this->view( $args);
        		$GLOBALS['appshore']->add_xsl('lib.print');
				$GLOBALS['appshore_data']['layout'] = 'popup';
				$result['action'][$this->appName] = 'print';
				break;

			case 'Error':
				$result = $this->search( $args);
				break;

			case 'Delete':
				if( $this->deleteRecord( $args[$this->appRecordId], true) == false )
				{
					unset( $args['key']);
					$args['offset'] = $_SESSION[$this->appName]['currentVal'];
					return $this->view( $args);
				}

				// delete if exists notification and/or schedule on this record
   				$this->deleteNotification( $args);
   				$this->deleteSchedule( $args);

				// back to search form
				$result = $this->search();
               break;

			case 'Edit':
				$args['offset'] = $_SESSION[$this->appName]['currentVal'];
				$result = $this->edit( $args);
				break;

			case 'Duplicate':
				// retrieve all infos from source record to populate target record
				$record = getOneAssocArray('select * from '.$this->appTable.' where '.$this->appRecordId.'= "'.$args[$this->appRecordId].'"');

				$result = $this->edit( $record);

				// to force the user and the database to set a new recordId
				unset ( $result[$this->appNameSingular][$this->appRecordId]);
				break;

			default:
				$result[$this->appNameSingular] = getOneAssocArray('select * from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');

				// we retrieve the record's owner user_name and full_name if they are not already defined'
				if( $result[$this->appNameSingular]['user_id'] && !isset($result[$this->appNameSingular]['user_name']) )
				{
					$user = getOneAssocArray('select user_name, full_name from users where user_id = "'.$result[$this->appNameSingular]['user_id'].'"');
					$result[$this->appNameSingular]['owner_user_name'] = $user['user_name'];
					$result[$this->appNameSingular]['owner_full_name'] = $user['full_name'];
				}

				if( $result[$this->appNameSingular]['address_billing'] )
					$result[$this->appNameSingular]['full_address_billing'] = str_replace( array("\r\n", "\n", "\r"), ' ', $result[$this->appNameSingular]['address_billing'].','.$result[$this->appNameSingular]['city_billing'].','.$result[$this->appNameSingular]['zipcode_billing'].','.$result[$this->appNameSingular]['state_billing'].','.$result[$this->appNameSingular]['country_billing']);
				if( $result[$this->appNameSingular]['address_shipping'] )
					$result[$this->appNameSingular]['full_address_shipping'] = str_replace( array("\r\n", "\n", "\r"), ' ', $result[$this->appNameSingular]['address_shipping'].','.$result[$this->appNameSingular]['city_shipping'].','.$result[$this->appNameSingular]['zipcode_shipping'].','.$result[$this->appNameSingular]['state_shipping'].','.$result[$this->appNameSingular]['country_shipping']);
				if( $result[$this->appNameSingular]['address_1'] )
					$result[$this->appNameSingular]['full_address_1'] = str_replace( array("\r\n", "\n", "\r"), ' ', $result[$this->appNameSingular]['address_1'].','.$result[$this->appNameSingular]['city_1'].','.$result[$this->appNameSingular]['zipcode_1'].','.$result[$this->appNameSingular]['state_1'].','.$result[$this->appNameSingular]['country_1']);
				if( $result[$this->appNameSingular]['address_2'] )
					$result[$this->appNameSingular]['full_address_2'] = str_replace( array("\r\n", "\n", "\r"), ' ', $result[$this->appNameSingular]['address_2'].','.$result[$this->appNameSingular]['city_2'].','.$result[$this->appNameSingular]['zipcode_2'].','.$result[$this->appNameSingular]['state_2'].','.$result[$this->appNameSingular]['country_2']);


				if( $result[$this->appNameSingular] == null )
				{
					$GLOBALS['appshore']->history->removeFromHistory( $this->appRecordId.'='.$args[$this->appRecordId]);
					messagebox( ERROR_RECORD_NOT_FOUND, ERROR);
					$result = $this->search();
					break;
				}

				//if( $result['view_fields'] = getManyAssocArrays('select f.*, t.app_name as related_app_name from db_fields f left outer join db_applications t on t.table_name = f.related_table and t.is_related = "Y" where f.app_name = "'.$this->appName.'" and f.view_sequence > "0"  order by f.view_sequence'))
				//if( $result['view_fields'] = getManyAssocArrays('select f.* from db_fields f where f.app_name = "'.$this->appName.'" and f.view_sequence > "0"  order by f.view_sequence'))
				if( $result['view_fields'] = $this->getFields($this->appName, $this->appTable, 'view') )
				{
					foreach( $result['view_fields'] as $fieldkey => $fieldvalue)
					{
						// no computed fields should appear in the SQL request
						if(  $fieldvalue['is_computed'] == 'Y' )
							continue;

						switch( $fieldvalue['field_type'])
						{
							case 'DA' :
								$result['view_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->dateToLocal($result[$this->appNameSingular][$fieldvalue['field_name']]);
								break;

							case 'DD' :
							case 'DF' :
							case 'RR' :
								$result[$this->appNameSingular]['related_'.$fieldvalue['field_name']] =
									getOneColOneRow('select '.$fieldvalue['related_name'].' from '.$fieldvalue['related_table'].
										' where '.$fieldvalue['related_id'].' = "'.$result[$this->appNameSingular][$fieldvalue['field_name']].'"');
								$result['view_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								break;

							case 'DS' :
								$result['view_fields'][$fieldkey]['field_current_value'] = getfilesize($result[$this->appNameSingular][$fieldvalue['field_name']]);
								break;

							case 'DT' :
								$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
								$result['view_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
								break;

							case 'MV' :
								if( $result[$this->appNameSingular][$fieldvalue['field_name']] )
								{
									foreach( explode('::',$result[$this->appNameSingular][$fieldvalue['field_name']]) as $val)
									{
										$result['view_fields'][$fieldkey]['field_current_value'][] =
											getOneColOneRow('select '.$fieldvalue['related_name'].' from '.$fieldvalue['related_table'].
												' where '.$fieldvalue['related_id'].' = "'.$val.'"');
									}
								}
								break;

							case 'RD' :
							case 'RM' :
								list($remnbr,$period) = explode('.',$result[$this->appNameSingular][$fieldvalue['field_name']]);
								if( $remnbr != '' && $period != '')
								{
									$result['view_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
									$result['view_fields'][$fieldkey]['field_current_value_nbr'] = $remnbr;
									$result['view_fields'][$fieldkey]['field_current_value_period'] = getOneColOneRow('select period_name from global_notifications_periods where period_id = "'.$period.'"');
								}
								break;

							case 'TS' :
								$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
								$result['view_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
								$field = getOneAssocArray('select field_name, related_name, related_id, related_table from db_fields where app_name = "'.$this->appName.'" and field_name = "'.$fieldvalue['field_name'].'_by"');
								if( $field['related_name'] && $field['related_id'] && $field['related_table'] )
								{
									$related = getOneAssocArray('select '.$field['related_name'].' as related_name from '.
										$field['related_table'].' where '.$field['related_id'].' = "'.$result[$this->appNameSingular][$field['field_name']].'"');
									$result[$this->appNameSingular]['related_'.$field['field_name']] = $related['related_name'];
								}
								break;

							case 'WS' :
								$result['view_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								if( strlen($result['view_fields'][$fieldkey]['field_current_value']) && strpos( $result['view_fields'][$fieldkey]['field_current_value'], '://') === false )
									$result['view_fields'][$fieldkey]['field_current_value'] = 'http://'.$result['view_fields'][$fieldkey]['field_current_value'];
								break;

							default:
								$result['view_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								break;
						}
					}
					$result['view_blocks'] = getManyAssocArrays('select * from db_blocks where app_name = "'.$this->appName.'" and form_name = "view" order by block_sequence');
				}
				else	// no custom form here
				{
					// we remove this xsl lib to use the specific one
			        $GLOBALS['appshore']->remove_xsl('lib.custom');
			        $GLOBALS['appshore']->remove_xsl('lib.view');
				}

	        	// record passage in history
	        	if( $this->appRecordName == 'last_name' )
	        	{
					$GLOBALS['appshore']->history->setHistory( $this->appName.'.base.view', $result[$this->appNameSingular]['full_name'], $this->appRecordId.'='.$result[$this->appNameSingular][$this->appRecordId] );
				}
	        	else
	        	{
					$GLOBALS['appshore']->history->setHistory( $this->appName.'.base.view', $result[$this->appNameSingular][$this->appRecordName], $this->appRecordId.'='.$result[$this->appNameSingular][$this->appRecordId] );
				}

				// set parameters for quickAdd int
				$result['quickadd'] = '&linked_appName='.$this->appName.'&linked_recordId='.$this->appRecordId.'&linked_recordIdValue='.$result[$this->appNameSingular][$this->appRecordId];

				// scope is set to 0 or 1 means READ_ONLY or READ_WRITE
				// xsl file will test this value to display or not edit/delete/copy buttons
				$result['scope'] = ''.$GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $result[$this->appNameSingular]['user_id']?$result[$this->appNameSingular]['user_id']:$GLOBALS['appshore_data']['current_user']['user_id']) ;

				// define the next action
                $result['action'][$this->appName] = 'view';

				// retrieve tags related to this record
				if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
				{
					$result['tags'] = execMethod('tags.base.getTagsPerRecord', array('app_name' => $this->appName, 'record_id' => $result[$this->appNameSingular][$this->appRecordId]));
				}

				// retrieve results from linked apps
				$result['linked'] = $this->getLinkedApplicationsResult($result[$this->appNameSingular][$this->appRecordId]);

				// recall the current offset of this record in the search result list
                $_SESSION[$this->appName]['currentVal'] = $args['offset']?$args['offset']:$_SESSION[$this->appName]['currentVal'] ;
				break;
		}

		//$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];

		return $result;
    }

	// edit or create one record
    function edit()
    {
		$args = new safe_args();
		$args->set('key',						NOTSET,'any');
		$args->set('isreload',					'false','any');
		$args->set('offset', 					NOTSET,'any');
		$args->set('assign_all',				NOTSET,'any');
		$args->set('is_notify',				    'N','any');
		$args->set('linked_appName',			NOTSET,'any');
		$args->set('linked_recordId',			NOTSET,'any');
		$args->set('linked_recordIdValue',		NOTSET,'any');
		$args->set('linked_recordNameValue',	NOTSET,'any');

		// edit fields
		$recordKey = $userKey = false;
		if( $edit_fields = $this->getFields($this->appName, $this->appTable, 'edit') )
			foreach( $edit_fields as $fieldkey => $fieldvalue)
			{
//				if( $fieldvalue['field_name'] == $this->appRecordId )
//					$recordKey = true;
				if( $fieldvalue['field_name'] == 'user_id' )
					$userKey = true;
				if( $fieldvalue['is_readonly'] != 'Y' )
				{
		    		if( in_array( $fieldvalue['field_type'], array('MV')) )
		    		{
		  				if( isset($_REQUEST[$fieldvalue['field_name']]) )
							$args->set( $fieldvalue['field_name'], $_SESSION[$this->appName][$fieldvalue['field_name']], 'array');
						else
							$args->set( $fieldvalue['field_name'], NOTSET, 'array');
					}
					else
						$args->set( $fieldvalue['field_name'], $_SESSION[$this->appName][$fieldvalue['field_name']], 'any');
				}
			}


//		if( $recordKey == false)
			$args->set($this->appRecordId, NOTSET,'any');
		if( $userKey == false && $this->appRecordId != 'user_id' )
			$args->set('user_id', NOTSET,'any');

		$args = $args->get(func_get_args());

		if( $edit_fields )
			foreach( $edit_fields as $fieldkey => $fieldvalue)
			{
	    		if( isset($args[$fieldvalue['field_name']]) && in_array( $fieldvalue['field_type'], array('MV')) && $fieldvalue['is_readonly'] != 'Y' )
	    		{
					$args[$fieldvalue['field_name']] = implode('::',$args[$fieldvalue['field_name']]);
				}

			}

        $GLOBALS['appshore']->add_xsl($this->appXSL);
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl('lib.custom');
        $GLOBALS['appshore']->add_xsl('lib.actions');
        $GLOBALS['appshore']->add_xsl('lib.edit');
	    $GLOBALS['appshore']->add_xsl('lib.linked');
        $GLOBALS['appshore']->add_xsl('lib.gridfields');

        $this->menus();

		//if( $this->appRole == $this->appName )
			$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], $this->appRole, $this->appTable, $this->appRecordId, $args[$this->appRecordId]);
		//else
			//$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], $this->appRole);

 		switch($args['key'])
		{
			case 'Next':
			case 'Previous':
			case 'Last':
			case 'First':
				if( isset($_SESSION[$session_popup.$this->appName]['sql']['request']) == false)
					$db = executeSQL($this->buildSQL());
				else
					$db = executeSQL($_SESSION[$session_popup.$this->appName]['sql']['request']);
				$nbrecords = $GLOBALS['appshore_data']['current_user']['nbrecords'];
				$GLOBALS['appshore_data']['current_user']['nbrecords'] = 1;
				setPosition( $_SESSION[$this->appName]['currentVal'], $_SESSION[$this->appName]['countMax'], $_SESSION[$this->appName]['first'], $args['key'], 1);
				$GLOBALS['appshore_data']['current_user']['nbrecords'] = $nbrecords ;
				$_SESSION[$this->appName]['countMax'] = $db->RowCount();
				$db->Move( $_SESSION[$this->appName]['currentVal']);
				$args['offset'] = $_SESSION[$this->appName]['currentVal'];
	            $args[$this->appRecordId] = $db->fields[$this->appRecordId];
				unset($args['key']);
				$result = $this->edit( $args);
				// recall the current offset of this record in the search result list
                $_SESSION[$this->appName]['currentVal'] = $args['offset']?$args['offset']:$_SESSION[$this->appName]['currentVal'] ;
				break;

			case 'Delete':
				if( $this->deleteRecord( $args[$this->appRecordId], true) == false )
				{
					unset( $args['key']);
					$args['offset'] = $_SESSION[$this->appName]['currentVal'];
					return $this->edit( $args);
				}

				// delete if exists notification and/or schedule on this record
   				$this->deleteNotification( $args);
   				$this->deleteSchedule( $args);

				// back to search form
				$result = $this->search();
                break;

			case 'Error':
				messagebox( $error, ERROR);
				//NO break

			case 'Cancel':
                if ( $args[$this->appRecordId] )
                {
					$args['offset'] = $_SESSION[$this->appName]['currentVal'];
                    $result = $this->view($args);
                }
                else
				    return $this->search();
				break;

			case 'View':
				// back to the view form
				$args['offset'] = $_SESSION[$this->appName]['currentVal'];
				$result = $this->view( $args);
				break;

			case 'Duplicate':
				// retrieve all infos from source record to populate target record
				$record = getOneAssocArray('select * from '.$this->appTable.' where '.$this->appRecordId.'= "'.$args[$this->appRecordId].'"');

				$result = $this->edit($record);

				// to force the user and the database to set a new recordId
				unset ( $result[$this->appNameSingular][$this->appRecordId]);

				return $result;
				break;

			case 'Save':
				// the special case of full_name which occurs very frequently
				$args['full_name'] = setFullname($args['first_names'],$args['last_name']);

				if ($args[$this->appRecordId]) 	// UPDATE an existing record
				{

					if(  $args['is_notify'] == 'Y' )
    					$user_id = getOneColOneRow('select user_id from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');

               		if ( $this->checkFields($args, $edit_fields) == false )
					{
						$result[$this->appNameSingular] = $args;
	                    $result['Error'] = true;
	                }
					else if ( updateRow($this->appTable, $this->appRecordId, $args) == null )
					{
						$result[$this->appNameSingular] = $args;
	                    $result['Error'] = true;
	                }
	                else
	                {
	                	messagebox( MSG_UPDATE, NOTICE);
	                	if ( $args['assign_all'] == 'Y')
	                		$this->assignLinked($args[$this->appRecordId], $args['user_id']);

	                    // New assignment so we send an email to the designated new owner of this or these leads
	                    if( $args['is_notify'] == 'Y' && $args['user_id'] && $args['user_id'] != $GLOBALS['appshore_data']['current_user']['user_id'])
	                    {
	                        if( $args['user_id'] == $user_id )
    		                    $this->sendMessageNewAssignment( $args['user_id'], $args[$this->appRecordId], $args[$this->appRecordName], 'UPDATE', 0, 1);
    		                else
    		                    $this->sendMessageNewAssignment( $args['user_id'], $args[$this->appRecordId], $args[$this->appRecordName], 'UPDATE', 1, 0);
		                }

                        // set a notification if available
               			$this->setNotification( $args);

                        // set a schedule if available
               			$this->setSchedule( $args);
 	                }

				}
				else  // New record so we do an INSERT
				{
					$args = (array)$this->newEntry($args);
               		if ( $this->checkFields($args, $edit_fields) == false )
					{
						$result[$this->appNameSingular] = $args;
	                    $result['Error'] = true;
	                }
					else
					{
						$args[$this->appRecordId] = insertRow( $this->appTable, $this->appRecordId, $args);
						if ( $args[$this->appRecordId] == null )
						{
							$result[$this->appNameSingular] = $args;
							$result['Error'] = $GLOBALS['Error'];
							messagebox($result['Error']['msg'].': '.$result['Error']['value'], ERROR, null, false);
						}
						else
						{
							messagebox( MSG_INSERT, NOTICE);

		                    // New assignment so we send an email to the designated new owner of this or these leads
		                    if( $args['is_notify'] == 'Y' && $args['user_id'] && $args['user_id'] != $GLOBALS['appshore_data']['current_user']['user_id'])
			                    $this->sendMessageNewAssignment( $args['user_id'], $args[$this->appRecordId], $args[$this->appRecordName], 'NEW', 1, 0);

		                    // set a notification if available
		           			$this->setNotification( $args);

		                    // set a schedule if available
		           			$this->setSchedule( $args);
                       }
					}
				}


				if (  $result['Error'] == false )
				{
					// we read the record
					$result[$this->appNameSingular] = getOneAssocArray('select * from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');

					// rebuilt links when the field is defined as RR and also is used as a NN link
					foreach( $edit_fields as $fieldkey => $fieldvalue)
					{
						// RR: Related record field
        				if ( in_array( $fieldvalue['field_type'], array('RR')) && $args[$fieldvalue['field_name']])
        				{
							$link = getOneAssocArray('select linked_type from db_linked where table_name = "'.$fieldvalue['related_table'].
								'" and linked_table_name = "'.$this->appTable.'"');
							if ( $link['linked_type'] == 'NN' )
							{
								$insert['from_table'] = $this->appTable;
								$insert['from_id'] = $args[$this->appRecordId];
								$insert['to_table'] = $fieldvalue['related_table'];
								$insert['to_id'] = $args[$fieldvalue['field_name']];
								replaceRow('links', 'to_table', $insert, false);
							}
						}
						// IM: Image field
						else if ( in_array( $fieldvalue['field_type'], array('IM')) )
						{
							// build unique filename for the image
							$filename = $this->appName.'_'.$args[$this->appRecordId].'_'.$fieldvalue['field_name'];

							if (  $_FILES[$fieldvalue['field_name'].'_file']['name'] )
							{
								// insert or update of a record
								execMethod('lib.images.upload', array($fieldvalue['field_name'],$filename));
							}
							else if( strpos( $result[$this->appNameSingular][$fieldvalue['field_name']], $args[$this->appRecordId]) === false )
							{
								if( $result[$this->appNameSingular][$fieldvalue['field_name']] )
								{
									// a record is duplicated, we also duplicate the image
									execMethod('lib.images.duplicate', array( $result[$this->appNameSingular][$fieldvalue['field_name']], $filename));
								}
								else
								{
									// image is removed from the record so we clear the name
									execMethod('lib.images.delete', $filename);
									$filename = '';
								}
							}
							// the name of the image file is updated in the record
							executeSQL('update '.$this->appTable.' set '.$fieldvalue['field_name'].' = "'.$filename.'" where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');
						}
					}
				}

				// NO Break for 'Save' record
			default:
				if ($args[$this->appRecordId])
				{
					$result[$this->appNameSingular] = getOneAssocArray('select * from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');
				}
                else // New record: init of some value
                {
                    $result[$this->appNameSingular] = $this->newEntry( $args);
                }

				// format result according field_type and other parameters
				foreach( $edit_fields as $fieldkey => $fieldvalue)
					if( $fieldvalue['edit_sequence'] > 0 )
						$result['edit_fields'][] = $fieldvalue;

				if( $result['edit_fields'] )
				{
					foreach( $result['edit_fields'] as $fieldkey => $fieldvalue)
					{
						// no computed fields should appear in the SQL request
						if(  $fieldvalue['is_computed'] == 'Y' )
							continue;

						switch( $fieldvalue['field_type'])
						{
							case 'CD' :
							case 'ND' :
							case 'PD' :
								$result['edit_fields'][$fieldkey]['field_current_value'] = trim(trim($result[$this->appNameSingular][$fieldvalue['field_name']], '0'), '.');
								break;

							case 'DA' :
								$result['edit_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->dateToLocal($result[$this->appNameSingular][$fieldvalue['field_name']]);
								break;

							case 'DD' :
								$result['edit_fields'][$fieldkey]['field_options'] = getManyAssocArrays(
									'select '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
									$fieldvalue['related_table'].' '.$fieldvalue['related_filter']);
								$result['edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								break;

							case 'DS' :
								$result['edit_fields'][$fieldkey]['field_current_value'] = getfilesize($result[$this->appNameSingular][$fieldvalue['field_name']]);
								break;

							case 'DT' :
								$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
								$result['edit_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
								break;

							case 'MV' :
								// build the list to display
								$result['edit_fields'][$fieldkey]['field_options'] = getManyAssocArrays(
									'select '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
									$fieldvalue['related_table'].' '.$fieldvalue['related_filter']);

								if( $result[$this->appNameSingular][$fieldvalue['field_name']] )
								{
									foreach( explode('::',$result[$this->appNameSingular][$fieldvalue['field_name']]) as $val)
									{
										$result['edit_fields'][$fieldkey]['field_current_value'][] = $val;
									}
								}
								break;

							case 'RR' :
								$result[$this->appNameSingular]['related_'.$fieldvalue['field_name']] =
									getOneColOneRow('select '.$fieldvalue['related_name'].' from '.$fieldvalue['related_table'].
										' where '.$fieldvalue['related_id'].' = "'.$result[$this->appNameSingular][$fieldvalue['field_name']].'"');
								$result['edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								break;

							case 'RK':
								$result['edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								$result['edit_fields'][$fieldkey]['is_readonly'] = 'Y';
								break;

							case 'RD' :
							case 'RM' :
								$result = $this->setNotificationOptions( $result, $fieldvalue['field_type']);
								list($remnbr,$period) = explode('.',$result[$this->appNameSingular][$fieldvalue['field_name']]);
								if( $remnbr != '' && $period != '')
								{
									$result['edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
									$result['edit_fields'][$fieldkey]['field_current_value_nbr'] = $remnbr;
									$result['edit_fields'][$fieldkey]['field_current_value_period'] = $period;
								}
								break;

							case 'TS' :
								$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
								$result['edit_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
								$field = getOneAssocArray('select field_name, related_name, related_id, related_table from db_fields where app_name = "'.$this->appName.'" and field_name = "'.$fieldvalue['field_name'].'_by"');
								if( $field['related_name'] && $field['related_id'] && $field['related_table'] )
								{
									$related = getOneAssocArray('select '.$field['related_name'].' as related_name from '.
										$field['related_table'].' where '.$field['related_id'].' = "'.$result[$this->appNameSingular][$field['field_name']].'"');
									$result[$this->appNameSingular]['related_'.$field['field_name']] = $related['related_name'];
								}
								break;
							case 'WS' :
								$result['edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								if( strlen($result['edit_fields'][$fieldkey]['field_current_value']) && strpos( $result['edit_fields'][$fieldkey]['field_current_value'], '://') === false )
									$result['edit_fields'][$fieldkey]['field_current_value'] = 'http://'.$result['edit_fields'][$fieldkey]['field_current_value'];
								break;
							default :
								$result['edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								break;
						}
					}
					$result['edit_blocks'] = getManyAssocArrays('select * from db_blocks where app_name = "'.$this->appName.'" and form_name = "edit" order by block_sequence');

				}
				else	// no custom form here
				{
					// we remove this xsl lib to use the specific one
			        $GLOBALS['appshore']->remove_xsl('lib.custom');
			        $GLOBALS['appshore']->remove_xsl('lib.edit');
				}

	        	// record passage in history
	        	if( $this->appRecordName == 'last_name' )
	        	{
					$GLOBALS['appshore']->history->setHistory( $this->appName.'.base.view', $result[$this->appNameSingular]['full_name'], $this->appRecordId.'='.$result[$this->appNameSingular][$this->appRecordId] );
				}
	        	else
	        	{
					$GLOBALS['appshore']->history->setHistory( $this->appName.'.base.view', $result[$this->appNameSingular][$this->appRecordName], $this->appRecordId.'='.$result[$this->appNameSingular][$this->appRecordId] );
				}

				// scope is set to 0 or 1 means READ_ONLY or READ_WRITE
				// xsl file will test this value to display or not edit/delete/copy buttons
				$result['scope'] = ''.$GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $result[$this->appNameSingular]['user_id']?$result[$this->appNameSingular]['user_id']:$GLOBALS['appshore_data']['current_user']['user_id']) ;

				// define the next action
                $result['action'][$this->appName] = 'edit';

				// retrieve tags related to this record
				if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
				{
					$result['tags'] = execMethod('tags.base.getTagsPerRecord', array('app_name' => $this->appName, 'record_id' => $result[$this->appNameSingular][$this->appRecordId]));
				}

				// retrieve results from linked apps
				$result['linked'] = $this->getLinkedApplicationsResult($result[$this->appNameSingular][$this->appRecordId]);

				// get the users list that we can RW to potentialy assign the record to one of them
				$param = $this->getFieldParameters( $result['edit_fields'], 'user_id', 'related_filter');
				if( $param )
					$result['users'] = getManyAssocArrays('select user_id, user_name, full_name from users '.buildClauseWhere($this->appRole,'W',''). ' '.$param );
				else
					$result['users'] = getManyAssocArrays('select user_id, user_name, full_name from users '.buildClauseWhere($this->appRole,'W',''). ' order by full_name');

				// recall the current offset of this record in the search result list
				if( $args['isreload'] != 'true' && $args['key'] != 'Save' )
	                $_SESSION[$this->appName]['currentVal'] = $args['offset']?$args['offset']:$_SESSION[$this->appName]['currentVal'] ;
				break;
		}

		//$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];
        return $result;
    }


    function newEntry( $args = null, $entry = null)
    {
       // $_SESSION[$this->appName]['countMax'] = $_SESSION[$this->appName]['currentVal'] = 0;

	    $entry['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

        if( $args )
        {
			// record with a subject field
			if( $args['linked_recordNameValue'] && !$args['subject'] && !$entry['subject'] )
				$args['subject'] = $args['linked_recordNameValue'].': ';
			// linked records
			if( $args['linked_recordId'] && $args['linked_recordIdValue'] && !$args[$args['linked_recordId']] )
				$args[$args['linked_recordId']] = $args['linked_recordIdValue'];

			if( $entry )
				foreach( $entry as $key => $val )
					if( isset($args[$key]) == false || $args[$key] == '')
						$args[$key] = $val;
         	return $args;
        }
		else
        	return $entry;
    }

   	// called by others apps when embeded
    function getRecord( $recordIdValue = null )
    {
    	if( $recordIdValue)
    	{
			$record['appTable'] = $this->appTable;
			$record['appRecordId'] = $this->appRecordId;
			return $record;
		}

		return null;
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

    // called by others apps when embeded
    function assignLinked( $record_id=null, $user_id=null)
    {
    	if( !$record_id || !$user_id)
    		return null;

		$scope = ''.$GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appName, $GLOBALS['appshore_data']['current_user']['user_id']);

		$inc=0;
		if( $linked = getManyAssocArrays('select * from db_linked where app_name = "'.$this->appName.'" and linked_type <> "11" and sequence > 0 order by sequence') )
			foreach( $linked as $fieldkey => $fieldvalue)
			{
				$linkedScope = ''.$GLOBALS['appshore']->rbac->checkPermissionOnUser( getAppName($fieldvalue['linked_app_name']), $GLOBALS['appshore_data']['current_user']['user_id']);

				if( $GLOBALS['appshore']->rbac->check( getAppName($fieldvalue['linked_app_name'])) )
				{
					if( $fieldvalue['linked_type'] == 'NN' )
					{
		                $argLinked['table_name'] = $fieldvalue['table_name'];
		                $argLinked['related_table'] = $fieldvalue['linked_table_name'];
		                $argLinked['related_name'] = $fieldvalue['linked_record_name'];
		                $argLinked[$fieldvalue['linked_record_name']] = $record_id;
						$result = execMethod($fieldvalue['linked_app_name'].'.base.linked',  $argLinked, true);
					}
					else
					{
						if( $fieldvalue['linked_record_name'] )
						{
			                $argRelated['related_name'] = $fieldvalue['linked_record_name'];
			                $argRelated[$fieldvalue['linked_record_name']] = $record_id;
			            }
						else
						{
			                $argRelated['related_app_name'] = $this->appName;
			                $argRelated['related_record_id'] = $record_id;
						}
						$result = execMethod($fieldvalue['linked_app_name'].'.base.related',  $argRelated, true);
					}

					if( $result['results'] )
						foreach( $result['results'] as $key => $val)
						{
							if( (int)$val['scope'] == 1)
							{
								unset($record);
								$record[$fieldvalue['linked_record_name']] = $record_id;
								$record['user_id'] = $user_id;
								if(	updateRow( $fieldvalue['linked_table_name'], $fieldvalue['linked_record_name'], $record, false) )
									$inc++;
							}
						}

              	}
			}
		if( $inc )
			messagebox( lang('%s related records assigned', $inc));
     }


    // called by others apps when embeded
    function getLinkedApplicationsResult( $record_id)
    {
    	if( !$record_id )
    		return null;

		if( $linked = getManyAssocArrays('select * from db_linked where app_name = "'.$this->appName.'" and linked_type <> "11" and sequence > 0 order by sequence') )
		{
			$scope = ''.$GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appName, $GLOBALS['appshore_data']['current_user']['user_id']);

			foreach( $linked as $fieldkey => $fieldvalue)
			{
				$linkedScope = ''.$GLOBALS['appshore']->rbac->checkPermissionOnUser( getAppName($fieldvalue['linked_app_name']), $GLOBALS['appshore_data']['current_user']['user_id']);

				if( $GLOBALS['appshore']->rbac->check( getAppName($fieldvalue['linked_app_name'])) )
				{
					if( $fieldvalue['linked_type'] == 'NN' )
					{
			            $argLinked['table_name'] = $fieldvalue['table_name'];
			            $argLinked['related_table'] = $fieldvalue['linked_table_name'];
			            $argLinked['related_name'] = $fieldvalue['linked_record_name'];
			            $argLinked[$fieldvalue['linked_record_name']] = $record_id;
						$result['linked'][$fieldvalue['linked_app_name']] = execMethod($fieldvalue['linked_app_name'].'.base.linked',  $argLinked, true);
					}
					else
					{
						if( $fieldvalue['linked_record_name'] )
						{
				            $argRelated['related_name'] = $fieldvalue['linked_record_name'];
				            $argRelated[$fieldvalue['linked_record_name']] = $record_id;
				        }
						else
						{
				            $argRelated['related_app_name'] = $this->appName;
				            $argRelated['related_record_id'] = $record_id;
						}
						$result['linked'][$fieldvalue['linked_app_name']] = execMethod($fieldvalue['linked_app_name'].'.base.related',  $argRelated, true);
					}

		           	$result['linked'][$fieldvalue['linked_app_name']]['app_label'] = $fieldvalue['linked_app_label'];
		           	$result['linked'][$fieldvalue['linked_app_name']]['app_name'] = $fieldvalue['linked_app_name'];
		           	$result['linked'][$fieldvalue['linked_app_name']]['related_name'] = $fieldvalue['linked_record_name'];
		           	$result['linked'][$fieldvalue['linked_app_name']]['scope'] = $scope;
		           	$result['linked'][$fieldvalue['linked_app_name']]['linked_scope'] = $linkedScope;
	           	}
			}

			return $result['linked'];
		}

		return null;
     }

   	// called by others apps when embeded
    function linked( $args)
    {
    	// we define a filter to replace a search form
    	// this field_type is dedicated to linked
		$filter[] = array('table_name' =>  $args['table_name'], 'related_table' => $args['related_table'],
			'field_name' => $args['related_name'],'field_type' => 'LI');
		unset($args['related_name']);

    	// we save then reset current context to avoid any conflict when calling the same app (accounts => subsidiares, contacts +> manager, assistant, ...)
    	$save = $_SESSION[$this->appName]; //$this->defaultSessionApp();
    	unset($_SESSION[$this->appName]);

		$result['linked_fields'] = $this->getFields($this->appName, $this->appTable, 'linked');
       	$result['record_id'] = $this->appRecordId;

		$sql = $this->buildSQL( $args, $filter, $result['linked_fields']);

//messagebox('linked: '.$sql, NOTICE);

		$result['results'] = $this->getSearchResults( $this->appName, 100, $sql, $result['linked_fields']);

		// we restore the saved context
		$_SESSION[$this->appName] = $save;

		return $result;
     }

    // called by others apps when embeded
    function related( $args)
    {
    	// we define a filter to replace a search form
    	// this field_type is dedicated to linked

		$filter[] = array('table_name' =>  $args['table_name'], 'related_table' => $args['related_table'],
			'field_name' => $args['related_name'], 'field_type' => 'RE');
		unset($args['related_name']);

    	// we save then reset current context to avoid any conflict when calling the same app (accounts => subsidiares, contacts +> manager, assistant, ...)

    	$save = $_SESSION[$this->appName];//$this->defaultSessionApp();
    	unset($_SESSION[$this->appName]);

		$result['linked_fields'] = $this->getFields($this->appName, $this->appTable, 'linked');
       	$result['record_id'] = $this->appRecordId;

		$sql = $this->buildSQL( $args, $filter, $result['linked_fields']);

//messagebox('related: '.$sql, NOTICE);

		$result['results'] = $this->getSearchResults( $this->appName, 100, $sql, $result['linked_fields']);

		// we restore the saved context
		$_SESSION[$this->appName] = $save;

		return $result;
     }

    // called by global search
    function quicksearch( $args)
    {
    	// we save then reset current context to avoid any conflict when calling the same app (accounts => subsidiares, contacts +> manager, assistant, ...)
    	$save = $_SESSION[$this->appName];//$this->defaultSessionApp();
    	unset($_SESSION[$this->appName]);

		$result['search_fields'] = $this->getFields($this->appName, $this->appTable, 'search');
		$result['result_fields'] = $this->getFields($this->appName, $this->appTable, 'result');

		$sql = $this->buildSQL( null, $result['search_fields'], $result['result_fields']);

		// $args contains the global search filter so we add it to the SQL sentence
		if( strpos( $sql, ' WHERE ') === false )
			$sql .= ' WHERE '.$args.' order by t0.'.$this->appOrderBy.' '.$this->appAscDesc;
		else
			$sql .= ' AND '.$args.' order by t0.'.$this->appOrderBy.' '.$this->appAscDesc;

//messagebox( $sql, NOTICE);

		$result['results'] = $this->getSearchResults( $this->appName, $_SESSION['temp']['nbrecords'], $sql, $result['result_fields']);

		// we restore the saved context
		$_SESSION[$this->appName] = $save;

		return $result;
     }

	// bulk operations
    function bulk_delete( $args)
    {
    	// a trick to know the number of deleted records
    	$verbose = $_SESSION[$this->appName]['countMax'];

		switch( $args['bulk_id'] )
		{
			case 'Selected':
			case 'Page':
				$selected = explode(',', $args['selected']);
				foreach( $selected as $key => $val)
				{
					$record[$this->appRecordId] = $val;
					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $GLOBALS['appshore_data']['current_user']['user_id']) == true &&
						$GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $this->appTable, $this->appRecordId, $record[$this->appRecordId] ) == true )
					{
						if( $this->deleteRecord( $record[$this->appRecordId]) == true )
						{
							$_SESSION[$this->appName]['countMax']--;

							// delete if exists notification and/or schedule on this record
			   				$this->deleteNotification( $record[$this->appRecordId]);
			   				$this->deleteSchedule( $record[$this->appRecordId]);
                 		}
					}
				}
				break;

			case 'All':
				$db = executeSQL($_SESSION[$this->appName]['sql']['request']);

				while( !$db->EOF )
				{
					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $GLOBALS['appshore_data']['current_user']['user_id']) == true &&
						$GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $this->appTable, $this->appRecordId, $db->fields($this->appRecordId) ) == true )
					{
						if( $this->deleteRecord( $db->fields($this->appRecordId)) == true )
						{
							$_SESSION[$this->appName]['countMax']--;

							// delete if exists notification and/or schedule on this record
			   				$this->deleteNotification( $db->fields($this->appRecordId));
			   				$this->deleteSchedule( $db->fields($this->appRecordId));
                 		}
					}

		            $db->MoveNext();
				}
				break;
		}
		if( $verbose != $_SESSION[$this->appName]['countMax'] )
			messagebox( lang('%s records deleted', (int)($verbose-$_SESSION[$this->appName]['countMax'])), NOTICE);
    }

	// bulk operations
    function bulk_link( $args)
    {
		$records_count=0;

		switch( $args['bulk_id'] )
		{
			case 'Selected':
			case 'Page':
				if( $selected = explode(',', $args['selected']) )
				{
					$link['table_name'] = $args['table_name'];
					$link['record_id'] = $args['record_id'];
					foreach( $selected as $key => $val)
					{
						if( $link['selected_id'] = $val )
						{
							execMethod( $this->appName.'.ajax.linkSelectedRecord', $link);
							$records_count++;
						}
					}
				}
				break;


			case 'All':
				$db = executeSQL($_SESSION[$args['sessionpopup'].$this->appName]['sql']['request']);

				$link['table_name'] = $args['table_name'];
				$link['record_id'] = $args['record_id'];

				while( !$db->EOF )
				{
					if( $link['selected_id'] = $db->fields[$this->appRecordId] )
					{
						execMethod( $this->appName.'.ajax.linkSelectedRecord', $link);
						$records_count++;
					}

		            $db->MoveNext();
				}
				break;
		}
		if ( $records_count )
			messagebox( lang('%s records added', $records_count), NOTICE);
    }


	// bulk operations
    function bulk_save( $args)
    {
    	// we retrieve fields to update
		foreach( $args as $key => $val)
		{
			if( $args['is_blank'] == 'Y' )
			{
				if( strpos( $key, 'bulk_') !== false && isset($val) && $key != 'bulk_id' )
					$record[substr($key,5)] = $val;
			}
			else
			{
				if( strpos( $key, 'bulk_') !== false && $val != '' && $key != 'bulk_id' )
					$record[substr($key,5)] = $val;
			}
		}

		$records_count=0;

		switch( $args['bulk_id'] )
		{
			case 'Selected':
			case 'Page':
				$selected = explode(',', $args['selected']);

				foreach( $selected as $key => $val)
				{
					$record[$this->appRecordId] = $val;

					if( $GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $this->appTable, $this->appRecordId, $record[$this->appRecordId] ) == true )
					{
						updateRow( $this->appTable, $this->appRecordId, $record, false);
						$records_count++;


    					if( $args['is_notify'] == 'Y' )
        					$user_id = getOneColOneRow('select user_id from '.$this->appTable.' where '.$this->appRecordId.' = "'.$val.'"');

						if(  $args['is_notify'] == 'Y' && $user_id && $record['user_id'] != $GLOBALS['appshore_data']['current_user']['user_id'] )
						{
						    if( $record['user_id'] && $user_id != $record['user_id'] )
        						$notification[$record['user_id']]['A']++;
        					else
           						$notification[$user_id]['U']++;
           				}

                        // set a notification if available
               			$this->setNotification( $record);

                        // set a schedule if available
               			$this->setSchedule( $record);
					}
				}
				break;


			case 'All':
				$db = executeSQL($_SESSION[$this->appName]['sql']['request']);

				while( !$db->EOF )
				{
					$record[$this->appRecordId] = $db->fields[$this->appRecordId];
					if( $GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $this->appTable, $this->appRecordId, $record[$this->appRecordId] ) == true )
					{
						updateRow( $this->appTable, $this->appRecordId, $record, false);
						$records_count++;

						if(  $args['is_notify'] == 'Y' && $db->fields['user_id'] && $record['user_id'] != $GLOBALS['appshore_data']['current_user']['user_id'])
						{
						    if( $record['user_id'] && $db->fields['user_id'] != $record['user_id'] )
        						$notification[$record['user_id']]['A']++;
        					else
           						$notification[$db->fields['user_id']]['U']++;
    					}

                        // set a notification if available
               			$this->setNotification( $record);

                        // set a schedule if available
               			$this->setSchedule( $record);
					}

		            $db->MoveNext();
				}
				break;
		}

		if ( $records_count )
			messagebox( lang('%s records updated', $records_count), NOTICE);


		// New assignment so we send an email to the designated new owner of this or these leads
		if( $args['is_notify'] == 'Y' && $notification )
		    foreach( $notification as $key => $val )
		    {
		        $this->sendMessageNewAssignment( $key, null, null, 'BULK', $val['A'], $val['U']);
			}
    }

    function setField( $theseFields, $thisField, $theseAttributes)
    {
    	if( $theseFields )
    	{
			foreach( $theseFields as $keyField => $valField)
			{
				if( $valField['field_name'] == $thisField )
				{
					foreach( $theseAttributes as $keyAttribute => $valAttribute)
					{
						if( $keyAttribute == 'field_current_value' )
							unset( $theseFields[$keyField]['related_id']);
						$theseFields[$keyField][$keyAttribute] = $valAttribute;
					}
					continue;
				}
			}
		}

		return $theseFields;
	}


    function unsetField( $theseFields, $thisField)
    {
    	if( $theseFields )
    	{
			foreach( $theseFields as $keyField => $valField)
			{
				if( $valField['field_name'] == $thisField )
				{
					unset( $theseFields[$keyField]);
					continue;
				}
			}
		}

		return $theseFields;
	}

    function getFieldParameters( $theseFields, $thisField, $thisParameter =  null)
    {
    	if( $theseFields )
    	{
			foreach( $theseFields as $keyField => $valField)
			{
				if( $valField['field_name'] == $thisField )
				{
					if( $thisParameter )
						return $valField[$thisParameter];
					else
						return $valField;
				}
			}
		}

		return false;
	}

// NOTIFICATION

    // delete Notification
    function deleteNotification( $record_id)
    {
    	$notification['app_name'] = $this->appName;
    	$notification['record_id'] = $record_id;
		return execMethod('base.notifications.deleteNotification', $notification);
    }

    // set Notification options
    function setNotificationOptions( $result, $field_type)
    {
		if( $field_type == 'RM' )
		{
			$result['reminder_nbrs'] = array(array('nbr'=>'1'),array('nbr'=>'2'),array('nbr'=>'3'),array('nbr'=>'4'),array('nbr'=>'5'),array('nbr'=>'10'),array('nbr'=>'15'),array('nbr'=>'20'),array('nbr'=>'30'),array('nbr'=>'45'));
			$result['reminder_periods'] = getManyAssocArrays('select * from global_notifications_periods order by period_sequence');
		}
		else
		{
			$result['reminder_nbrs'] = array(array('nbr'=>'0'),array('nbr'=>'1'),array('nbr'=>'2'),array('nbr'=>'3'),array('nbr'=>'4'),array('nbr'=>'5'),array('nbr'=>'6'));
			$result['reminder_periods'] = getManyAssocArrays('select * from global_notifications_periods where is_date = "Y" order by period_sequence');
		}
		return $result;
    }

    // set email and popup notifications
    function setNotification( $args = null)
    {
    	// we test that notifications are activated for the current application
    	if( method_exists($this,'getNotificationStartDate') == false )
    		return;

	    $notification['start_date'] = $this->getNotificationStartDate($args);
	    $notification['start_time'] = $this->getNotificationStartTime($args);

		$notification['app_name'] = $this->appName;
		$notification['record_id'] = $args[$this->appRecordId];
		$notification['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
		$notification['status_id'] = 'A';

		//email
		$notification['interval'] = $args['reminder_email'];
		$notification['type_id'] = 'E'; // email
		execMethod('base.notifications.setNotification', $notification);

		//popup
		$notification['interval'] = $args['reminder_popup'];
		$notification['type_id'] = 'P'; // popup
		execMethod('base.notifications.setNotification', $notification);
    }



// SCHEDULE

    // delete Schedule
    function deleteSchedule( $record_id)
    {
    	$schedule['app_name'] = $this->appName;
    	$schedule['record_id'] = $record_id;
		return execMethod('base.schedules.deleteSchedule', $schedule);
    }

    // set Schedule options
    function setScheduleOptions( $result, $field_type)
    {
		if( $field_type == 'ST' )
		{
			$result['schedule_nbrs'] = array(array('nbr'=>'1'),array('nbr'=>'2'),array('nbr'=>'3'),array('nbr'=>'4'),array('nbr'=>'5'),array('nbr'=>'10'),array('nbr'=>'15'),array('nbr'=>'20'),array('nbr'=>'30'),array('nbr'=>'45'));
			$result['schedule_periods'] = getManyAssocArrays('select * from global_schedule_periods order by period_sequence');
		}
		else
		{
			$result['schedule_nbrs'] = array(array('nbr'=>'0'),array('nbr'=>'1'),array('nbr'=>'2'),array('nbr'=>'3'),array('nbr'=>'4'),array('nbr'=>'5'),array('nbr'=>'6'));
			$result['schedule_periods'] = getManyAssocArrays('select * from global_schedule_periods where is_date = "Y" order by period_sequence');
		}
		return $result;
    }

    // set email and popup notifications
    function setSchedule( $args = null)
    {

    	// we test that notifications are activated for the current application
    	if( method_exists($this,'getScheduleStartDate') == false )
    		return;

	    $schedule['start_date'] = $this->getScheduleStartDate($args);
	    $schedule['start_time'] = $this->getScheduleStartTime($args);

		$schedule['app_name'] = $this->appName;
		$schedule['record_id'] = $args[$this->appRecordId];
		$schedule['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
		$schedule['status_id'] = 'A';

		$schedule['interval'] = $args['reminder_popup'];
		$schedule['type_id'] = 'P'; // popup
		execMethod('base.notifications.setNotification', $schedule);
    }




	function sendMessageNewAssignment( $user_id, $record_id = null, $record_name = null, $type = null, $assigned = 0, $updated = 0, $verbose = true)
	{
		$sep = "<br/>";
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');
		$mail = new emailer();
        $mail->getEmailerInformation();

		$mail->isHTML(true);
      	$mail->From 	= 'support@'.CUSTOMER_DOMAIN;
		$mail->FromName = lang('The %(BRAND)s Team', array('BRAND'=>BRAND));

		$user = getOneAssocArray('SELECT full_name, email FROM users WHERE user_id = "'.$user_id.'"');


        $mail->Subject = BRAND.' - '.$this->appLabel.': ';
 		$mail->Body  = lang('Dear %(full_name)s,', array('full_name'=>$user['full_name'])).$sep.$sep;


 		switch( $type )
 		{
 		    case 'NEW':
            	$mail->Subject .= lang('one new %(appLabelSingular)s created', array('appLabelSingular'=>strtolower($this->appLabelSingular)));
         		$mail->Body .= lang('One new %(appLabel)s has been created and assigned to you by %(full_name)s.', array('appLabel'=>strtolower($this->appLabelSingular),'full_name'=>$GLOBALS['appshore_data']['current_user']['full_name']));
 		        break;

 		    default:
		        if( $assigned == 1 )
		        {
                    $mail->Subject .= lang('one %(appLabelSingular)s assigned', array('appLabelSingular'=>strtolower($this->appLabelSingular)));
             		$mail->Body .= lang('One %(appLabel)s has been assigned to you by %(full_name)s.', array('appLabel'=>strtolower($this->appLabelSingular),'full_name'=>$GLOBALS['appshore_data']['current_user']['full_name']));
             	}
		        else if( $assigned > 1 )
		        {
                    $mail->Subject .= lang('%(count)s %(appLabel)s assigned', array('count'=>$assigned,'appLabel'=>strtolower($this->appLabel)));
             		$mail->Body .= lang('%(count)s %(appLabel)s have been assigned to you by %(full_name)s.', array('count'=>$assigned,'appLabel'=>strtolower($this->appLabel),'full_name'=>$GLOBALS['appshore_data']['current_user']['full_name']));
             	}

		        if( $updated == 1 )
		        {
                    $mail->Subject .= ($assigned?', ':'').lang('one %(appLabelSingular)s updated', array('appLabelSingular'=>strtolower($this->appLabelSingular)));
             		$mail->Body .= lang('One of your %(appLabel)s has been updated by %(full_name)s.', array('appLabel'=>strtolower($this->appLabel),'full_name'=>$GLOBALS['appshore_data']['current_user']['full_name']));
             	}
		        else if( $updated > 1 )
		        {
                    $mail->Subject .= ($assigned?', ':'').lang('%(count)s %(appLabel)s updated', array('count'=>$updated,'appLabel'=>strtolower($this->appLabel)));
             		$mail->Body .= lang('%(count)s of your %(appLabel)s have been updated by %(full_name)s.', array('count'=>$updated,'appLabel'=>strtolower($this->appLabel),'full_name'=>$GLOBALS['appshore_data']['current_user']['full_name']));
             	}
 		        break;
 		}

		if( $record_id && ($assigned == 1 || $updated == 1) )
		{
            $mail->Subject .= ', '.$record_name;
 			$mail->Body .= $sep.$sep."<a href='".$GLOBALS['appshore']->session->basepath.'/?op='.$this->appName.'.base.view&amp;'.$this->appRecordId."=".$record_id."' target='_new' >".$record_name."</a>".$sep.$sep;
    	}

    	$mail->Body .= $sep.$sep.lang('The %(BRAND)s Team', array('BRAND'=>BRAND)).$sep.$sep;

 		$mail->AddAddress( $user['email'], $user['full_name']);
 		if( $GLOBALS['appshore_data']['current_user']['notify_me'] == 'Y' )
 			$mail->AddCC( $GLOBALS['appshore_data']['current_user']['email'], $GLOBALS['appshore_data']['current_user']['full_name']);

		$mail->Send();

		if( $verbose )
		{
		    if( $assigned > 0 )
    			messagebox( lang('Notification sent to new owner'), NOTICE);
		    else
    			messagebox( lang('Notification sent to owner'), NOTICE);
        }

		return true;
	}

}
