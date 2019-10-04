<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class campaigns_records_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'campaigns_records_view';
    	$this->appRecordId		= 'list_record_id';    	
    	$this->appRecordName	= 'record_name';    	
    	$this->appOrderBy		= 'record_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'campaigns_records';
    	$this->appNameSingular	= 'campaigns_record';    	
    	$this->appLabel 		= 'List Records';
    	$this->appLabelSingular = 'List Record';    
    	$this->appXSL	 		= 'campaigns.records_base';
    	$this->appRole 			= 'campaigns';

 		parent::__construct();

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');
    }

    function menus()
    {
    	execMethod( 'campaigns.base.menus');
    }
    
		// to reduce the scope of search and avoid slow union on views
    function buildSQL( $args=null, $search_fields=null, $result_fields=null, $session_popup = '')
    {
    	$result = parent::buildSQL(  $args, $search_fields, $result_fields, $session_popup);
    	
    	if( $_SESSION[$session_popup.$this->appName]['switchAppTable'] )
    	{
			$_SESSION[$session_popup.$this->appName]['sql']['from'] = ' FROM '.$_SESSION[$session_popup.$this->appName]['switchAppTable'].' t0 ';

			// SQl request is completed, it is saved in session for further need
			$request = $_SESSION[$session_popup.$this->appName]['sql']['select']
				.$_SESSION[$session_popup.$this->appName]['sql']['from']
				.$_SESSION[$session_popup.$this->appName]['sql']['join']
				.$_SESSION[$session_popup.$this->appName]['sql']['where']
				.$_SESSION[$session_popup.$this->appName]['sql']['groupby']
				.$_SESSION[$session_popup.$this->appName]['sql']['orderby'];

			$request = str_replace( '  ', ' ', $request);
			$request = str_replace( '1=1 AND', '', $request);
			$request = str_replace( 'WHERE 1=1', '', $request);

			$_SESSION[$session_popup.$this->appName]['sql']['request'] = $request;
		}		

		return $_SESSION[$session_popup.$this->appName]['sql']['request'];
    }    
    
	function search( $args = null)
    {
     	switch( $args['key'] )
		{
			case 'Remove':
				$this->bulk_remove($args);
				break;	
			case 'Search':
		    	$args['list_id'] = $args['list_id']?$args['list_id']:NULL;
				break;	
			case NULL:
		    	$args['list_id'] = $args['_list_id']?$args['_list_id']:NULL;
				break;	
		}

		// to reduce the scope of search and avoid slow union on views, see buildSQl above
		if( in_array($args['key'], array('Search', 'Clear')) )
		{
			switch( $args['record_type_id'] )
			{
				case 'accounts' :
				case 'contacts' :
				case 'leads' :
					$_SESSION[$session_popup.$this->appName]['switchAppTable'] = 'campaigns_records_'.$args['record_type_id'].'_view';
					break;
				default :
					unset($_SESSION[$session_popup.$this->appName]['switchAppTable']);
					break;
			}
		}
    	
		$result = parent::search( $args);

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');
		
		return $result;
	}     
	
    function view( $args = null)
    {
		list( $list_id, $record_id) = explode( '_', $args[$this->appRecordId]);					
      	$table_name = getOneColOneRow( 'select table_name from campaigns_records where list_id = "'.$list_id.'" and record_id = "'.$record_id.'"');
    	   	
    	switch( $table_name )
    	{
    		case 'accounts' :
    			$args['account_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'accounts.base.view';
    			break;
    		case 'contacts' :
    			$args['contact_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'contacts.base.view';
     			break;
    		case 'customers' :
    			$args['company_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'backoffice.customers_base.view';
     			break;
    		case 'leads' :
    			$args['lead_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'leads.base.view';
    			break;
    		default :
    			unset($args);
    			$GLOBALS['appshore_data']['api']['op'] = $this->appName.'.base.search';
    			break;
		}
		
		return execMethod( $GLOBALS['appshore_data']['api']['op'], $args);
	}     
	
    
    function edit(  $args = null)
    {
		list( $list_id, $record_id) = explode( '_', $args[$this->appRecordId]);					
      	$table_name = getOneColOneRow( 'select table_name from campaigns_records where list_id = "'.$list_id.'" and record_id = "'.$record_id.'"');
    	
    	switch( $table_name )
    	{
    		case 'accounts' :
    			$args['account_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'accounts.base.edit';
    			break;
    		case 'contacts' :
    			$args['contact_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'contacts.base.edit';
     			break;
    		case 'customers' :
    			$args['company_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'backoffice.customers_base.edit';
     			break;
    		case 'leads' :
    			$args['lead_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'leads.base.edit';
    			break;
    		default :
    			unset($args);
    			$GLOBALS['appshore_data']['api']['op'] = $this->appName.'.base.search';
    			break;
		}
		
		return execMethod( $GLOBALS['appshore_data']['api']['op'], $args);
	}     
	
	// replace the default bulk delete
    function bulk_delete( $args)
    {
    	// a trick to know the number of deleted records
    	$verbose = $_SESSION[$this->appName]['countMax'];

		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = explode( ',', $args['selected']);				  
				foreach( $selected as $key => $val)
				{
					list( $list_id, $record_id) = explode( '_', $val);					
      				$related = getOneAssocArray( 'select app_name, table_name, field_name from db_applications where app_name = 
      					(select table_name from campaigns_records where list_id = "'.$list_id.'" and record_id = "'.$record_id.'")');
					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $GLOBALS['appshore_data']['current_user']['user_id']) == true &&
						$GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $related['table_name'], $related['field_name'], $val ) == true )
					{
						if( execMethod( $related['app_name'].'.base.deleteRecord', $record_id) == true )
							$_SESSION[$this->appName]['countMax']--;
					}
				}	
				break;	

			case 'All':	
				$db = $GLOBALS['appshore']->db->execute($_SESSION[$this->appName]['sql']['request']);

				while( !$db->EOF )
				{      
					list( $list_id, $record_id) = explode( '_', $db->fields($this->appRecordId));					
      				$related = getOneAssocArray( 'select app_name, table_name, field_name from db_applications where app_name = 
      					(select table_name from campaigns_records where list_id = "'.$list_id.'" and record_id = "'.$record_id.'")');
   					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $GLOBALS['appshore_data']['current_user']['user_id']) == true &&
					$GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $related['table_name'], $related['field_name'], $db->fields($this->appRecordId) ) == true )
					{
						if( execMethod( $related['app_name'].'.base.deleteRecord', $db->fields('record_id')) == true )
							$_SESSION[$this->appName]['countMax']--;
					}
		        		
		            $db->MoveNext();
				}				
				break;			 
		}
					
		if( $verbose != $_SESSION[$this->appName]['countMax'] )	
			messagebox( lang('%s records deleted', (int)($verbose-$_SESSION[$this->appName]['countMax'])), NOTICE);
    }
    
	
	// Remove from list
    function bulk_remove( $args)
    {
    	// a trick to know the number of deleted records
    	$verbose = $_SESSION[$this->appName]['countMax'];

		if( $GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $GLOBALS['appshore_data']['current_user']['user_id']) == false )
			unset($args['bulk_id']);

		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = explode( ',', $args['selected']);				  
				foreach( $selected as $key => $val)
				{
					list( $list_id, $record_id) = explode( '_', $val);
					if( deleteRowWhere( 'campaigns_records', 'where list_id = "'.$list_id.'" and record_id = "'.$record_id.'"', false) == true )
						$_SESSION[$this->appName]['countMax']--;
				}	
				break;	

			case 'All':	
				$db = executeSQL($_SESSION[$this->appName]['sql']['request']);
				while( !$db->EOF )
				{            
					if( deleteRowWhere( 'campaigns_records', 'where list_id = "'.$db->fields('list_id').
						'" and record_id = "'.$db->fields('record_id').'"', false) == true )
						$_SESSION[$this->appName]['countMax']--;
		        		
		            $db->MoveNext();
				}				
				break;			 
		}	
				
		if( $verbose != $_SESSION[$this->appName]['countMax'] )	
			messagebox( lang('%s records removed', (int)($verbose-$_SESSION[$this->appName]['countMax'])), NOTICE);
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
				if( strpos( $key, 'bulk_') !== false && $val && $key != 'bulk_id' ) 
					$record[substr($key,5)] = $val;
			}
		}	
		$records_count=0;	
		
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = explode( ',', $args['selected']);				  
				foreach( $selected as $key => $val)
				{
					list( $list_id, $record_id) = explode( '_', $val);					
      				$related = getOneAssocArray( 'select app_name, table_name, field_name from db_applications where app_name = 
      					(select table_name from campaigns_records where list_id = "'.$list_id.'" and record_id = "'.$record_id.'")');
					if( $GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $related['table_name'], $related['field_name'], $val ) == true )
					{
						$record[$related['field_name']] = $record_id;
						updateRow( $related['table_name'], $related['field_name'], $record, false);
	
						// only field we can update on this table so it must be selected
						if( $record['status_id'] )
		 					updateRowWhere( 'campaigns_records', 'where list_id = "'.$list_id.'" and record_id = "'.$record_id.'"', $record, false);
	
						$records_count++;							
					}
				}	
				break;

			case 'All':	
				$db = executeSQL($_SESSION[$this->appName]['sql']['request']);
				while( !$db->EOF )
				{            
					list( $list_id, $record_id) = explode( '_', $db->fields($this->appRecordId));					
      				$related = getOneAssocArray( 'select app_name, table_name, field_name from db_applications where app_name = 
      					(select table_name from campaigns_records where list_id = "'.$list_id.'" and record_id = "'.$record_id.'")');
					if( $GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $related['table_name'], $related['field_name'], $db->fields($this->appRecordId) ) == true )
					{
						$record[$related['field_name']] = $db->fields('record_id');
						updateRow( $related['table_name'], $related['field_name'], $record, false);
						
						// only field we can update on this table so it must be selected
						if( $record['status_id'] )
							updateRowWhere( 'campaigns_records', 'where list_id = "'.$db->fields('list_id').
								'" and record_id = "'.$db->fields('record_id').'"', $record, false);

						$records_count++;							
					}
		        		
		            $db->MoveNext();
				}				
				break;			 
		}			
		/*
		// New assignment so we send an email to the designated new owner of this or these leads
		if( $args['bulk_user_id'] && $records_count && $args['bulk_user_id'] != $GLOBALS['appshore_data']['current_user']['user_id'])
			$this->sendMessageNewAssignment( $args['bulk_user_id'], $records_count);		
		*/
		if ( $records_count )
			messagebox( lang('%s records updated', $records_count), NOTICE);
    }    	
    		    	
}
