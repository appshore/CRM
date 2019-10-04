<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class tags_records_base extends lib_base{

    function __construct()
    {
    	$this->appTable 		= 'tags_records_view';
    	$this->appRecordId		= 'record_id';    	
    	$this->appRecordName	= 'record_name';    	
    	$this->appOrderBy		= 'record_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'tags_records';
    	$this->appNameSingular	= 'tags_record';    	
    	$this->appLabel 		= 'List Records';
    	$this->appLabelSingular = 'List Record';    
    	$this->appXSL	 		= 'tags.records_base';
    	$this->appRole 			= 'tags';

        parent::__construct();    	
    }

    function menus()
    {
    	execMethod( 'tags.base.menus');
		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');
    }
    
	function start()
    {
		unset($_SESSION[$this->appName]);			
		$_SESSION[$this->appName][$this->appRecordName] = '';
		$_SESSION[$this->appName]['appOrderBy'] = $this->appOrderBy?$this->appOrderBy:$this->appRecordName;
		$_SESSION[$this->appName]['appAscDesc'] = $this->appAscDesc?$this->appAscDesc:'ASC';
		return parent::start();
	} 	    

	function search(  $args = null)
    {
    	$args['list_id'] = $args['list_id']?$args['list_id']:$_SESSION[$this->appName]['list_id'];		

    	if( $args['list_id'] == null )
    	{
    		$list = getOneAssocArray('select list_id from tags_lists order by list_name limit 1');
    		if( $list['list_id'] == null )
    		{
    			messagebox( lang('No list, please create a list'), ERROR);
    			return execMethod( 'tags_lists.base.start');
    		}
   			$args['list_id'] = $list['list_id'];
     	}
     	
     	switch( $args['key'] )
		{
			case 'Clear':
				// default clear task
				unset($_SESSION[$this->appName]);			
				$_SESSION[$this->appName][$this->appRecordName] = '';
				$_SESSION[$this->appName]['appOrderBy'] = $this->appOrderBy?$this->appOrderBy:$this->appRecordName;
				$_SESSION[$this->appName]['appAscDesc'] = $this->appAscDesc?$this->appAscDesc:'ASC';
				
				// we need to keep the list_id value unless it is explicitely modified by user
				$_SESSION[$this->appName]['list_id'] = $args['list_id'];
				return $this->search();	
			case 'Remove':
				$this->bulk_remove($args);
				break;	
		}
    	
		$result = parent::search( $args);

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');
		
		return $result;
	} 
	
    function view(  $args = null)
    {
      	$record = getOneAssocArray( 'select record_type_id from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');
    	
    	switch( $record['record_type_id'] )
    	{
    		case 'accounts' :
    			$args['account_id'] = $args['record_id'];
    			$GLOBALS['appshore_data']['api']['op'] = 'accounts.base.view';
    			break;
    		case 'contacts' :
    			$args['contact_id'] = $args['record_id'];
    			$GLOBALS['appshore_data']['api']['op'] = 'contacts.base.view';
     			break;
    		case 'customers' :
    			$args['company_id'] = $args['record_id'];
    			$GLOBALS['appshore_data']['api']['op'] = 'backoffice.customers_base.view';
     			break;
    		case 'leads' :
    			$args['lead_id'] = $args['record_id'];
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
      	$record = getOneAssocArray( 'select record_type_id from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');
    	
    	switch( $record['record_type_id'] )
    	{
    		case 'accounts' :
    			$args['account_id'] = $args['record_id'];
    			$GLOBALS['appshore_data']['api']['op'] = 'accounts.base.edit';
    			break;
    		case 'contacts' :
    			$args['contact_id'] = $args['record_id'];
    			$GLOBALS['appshore_data']['api']['op'] = 'contacts.base.edit';
     			break;
    		case 'customers' :
    			$args['company_id'] = $args['record_id'];
    			$GLOBALS['appshore_data']['api']['op'] = 'backoffice.customers_base.edit';
     			break;
    		case 'leads' :
    			$args['lead_id'] = $args['record_id'];
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
      				$related = getOneAssocArray( 'select app_name, table_name, field_name from db_applications where app_name = 
      					(select table_name from '.$this->appTable.' where '.$this->appRecordId.' = "'.$val.'")');
					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $GLOBALS['appshore_data']['current_user']['user_id']) == true &&
						$GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $related['table_name'], $related['field_name'], $val ) == true )
					{
						if( execMethod( $related['app_name'].'.base.deleteRecord', $val) == true )
							$_SESSION[$this->appName]['countMax']--;
					}
				}	
				break;	

			case 'All':	
				$db = $GLOBALS['appshore']->db->execute($_SESSION[$this->appName]['sql']['request']);

				while( !$db->EOF )
				{      
      				$related = getOneAssocArray( 'select app_name, table_name, field_name from db_applications where app_name = 
      					(select table_name from '.$this->appTable.' where '.$this->appRecordId.' = "'.$db->fields($this->appRecordId).'")');
   					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $GLOBALS['appshore_data']['current_user']['user_id']) == true &&
					$GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $related['table_name'], $related['field_name'], $db->fields($this->appRecordId) ) == true )
					{
						if( execMethod( $related['app_name'].'.base.deleteRecord', $db->fields($this->appRecordId)) == true )
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
 					if( deleteRowWhere( 'tags_records', 'where list_id = "'.$_SESSION[$this->appName]['list_id'].'" and record_id = "'.
						$val.'"', false) == true )
						$_SESSION[$this->appName]['countMax']--;
				}	
				break;	

			case 'All':	
				$db = $GLOBALS['appshore']->db->execute($_SESSION[$this->appName]['sql']['request']);
				while( !$db->EOF )
				{            
					if( deleteRowWhere( 'tags_records', 'where list_id = "'.$_SESSION[$this->appName]['list_id'].'" and record_id = "'.
						$db->fields($this->appRecordId).'"', false) == true )
						$_SESSION[$this->appName]['countMax']--;
		        		
		            $db->MoveNext();
				}				
				break;			 
		}	
				
		if( $verbose != $_SESSION[$this->appName]['countMax'] )	
			messagebox( lang('%s records deleted', (int)($verbose-$_SESSION[$this->appName]['countMax'])), NOTICE);
			
    }
    

	// bulk operations
    function bulk_save( $args)
    {
    	// we retrieve fields to update
		foreach( $args as $key => $val)
		{
			if( strpos( $key, 'bulk_') !== false && $val && $key != 'bulk_id' ) 
				$record[substr($key,5)] = $val;
		}	
		$records_count=0;	
		
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = explode( ',', $args['selected']);				  
				foreach( $selected as $key => $val)
				{
      				$related = getOneAssocArray( 'select app_name, table_name, field_name from db_applications where app_name = 
      					(select table_name from '.$this->appTable.' where '.$this->appRecordId.' = "'.$val.'")');
					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $GLOBALS['appshore_data']['current_user']['user_id']) == true &&
						$GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $related['table_name'], $related['field_name'], $val ) == true )
					{
						$record[$related['field_name']] = $val;
						updateRow( $related['table_name'], $related['field_name'], $record, false);

	 					updateRowWhere( 'tags_records', 'where list_id = "'.$_SESSION[$this->appName]['list_id'].
	 						'" and record_id = "'.$val.'"', $record, false);
	
						$records_count++;							
					}
				}	
				break;

			case 'All':	
				$db = $GLOBALS['appshore']->db->execute($_SESSION[$this->appName]['sql']['request']);
				while( !$db->EOF )
				{            
       				$related = getOneAssocArray( 'select app_name, table_name, field_name from db_applications where app_name = 
      					(select table_name from '.$this->appTable.' where '.$this->appRecordId.' = "'.$db->fields($this->appRecordId).'")');
					if( $GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $GLOBALS['appshore_data']['current_user']['user_id']) == true &&
						$GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $related['table_name'], $related['field_name'], $db->fields($this->appRecordId) ) == true )
					{
						$record[$related['field_name']] = $db->fields($this->appRecordId);
						updateRow( $related['table_name'], $related['field_name'], $record, false);

						updateRowWhere( 'tags_records', 'where list_id = "'.$_SESSION[$this->appName]['list_id'].
							'" and record_id = "'.$db->fields($this->appRecordId).'"', $record, false);

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
