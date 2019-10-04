<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */

class opportunities_roles {
	var $currentVal;
	var $countMax;
	var $first;

    function start()
    {
		// First time that we start this app during the current session so we must init search criterias
		if (!isset($_SESSION['role'])) 
		{
			$_SESSION['role']['appOrderBy'] = 'role_id';
			$_SESSION['role']['appAscDesc'] = 'ASC';
		}    
		$_SESSION['role']['first'] = 0;   
		$_SESSION['role']['currentVal'] = 0;   
		$_SESSION['role']['countMax'] = 0;   
		$result = $this->search();
		return $result;
    } 
	
   
	// search and list roles
    function search()
    {
		$args = new safe_args();
		$args->set('key', 			NOTSET, 'any');
		$args->set('selected', 		NOTSET, 'any');
		$args->set('nbrecords', 	NOTSET, 'any');				
		$args->set('bulk_id', 		'Selected', 'any');	
		$args->set('master', 		true, 'any');					
		$args->set('currentVal', 	(isset($_SESSION['roles']['currentVal']))?$_SESSION['roles']['currentVal']:0, 'any');
		$args->set('countMax', 		$_SESSION['roles']['countMax'], 'any');
		$args->set('first', 		$_SESSION['roles']['first'], 'any');
		$args->set('orderby', 		$_SESSION['roles']['appOrderBy'], 'any');
		$args->set('ascdesc', 		$_SESSION['roles']['appAscDesc'], 'any');
		// search fields
		foreach( ($inputs = getOneAssocArray( 'select * from opportunities_roles limit 1')) as $fieldName => $fieldValue )
			$args->set( $fieldName,	$_SESSION['roles'][$fieldName], 'any');	
		//	bulk fields
		//foreach( $inputs as $fieldName => $fieldValue )
			//$args->set( 'bulk_'.$fieldName,	$_SESSION['roles']['bulk_'.$fieldName], 'any');	
		$args = $args->get(func_get_args());		

        $GLOBALS['appshore']->add_xsl('opportunities.base');
        $GLOBALS['appshore']->add_xsl('opportunities.roles');        
        $GLOBALS['appshore']->add_xsl('lib.base');
		execMethod( 'opportunities.base.menus');           

		if( $args['master'] == true ) 
		{
			$listargs['opportunity_id'] = $args['opportunity_id'];
			$listargs['master'] = false;					
			$result = execMethod( 'opportunities.base.view', $listargs, true);
		}     
   	    
		$this->currentVal = $args['currentVal'];
		$this->countMax = $args['countMax'];
		$this->first = $args['first']; 

 		switch($args['key'])
		{
			case 'Clear':
				unset($_SESSION['roles']);	
				return $this->start();
			case 'Search':	
				unset($args['role_id']);						
				$args['ascdesc'] = 'ASC';				
				$args['orderby'] = 'last_name';				
				// No Break		
			case 'Next':
			case 'Previous':
			case 'Last':
			case 'First':
				setPosition( $this->currentVal, $this->countMax, $this->first, $args['key']);
				break;	
			case 'NbRecords':
				$GLOBALS['appshore_data']['current_user']['nbrecords'] = $args['nbrecords'];
				execMethod( 'preferences.lookandfeel_base.setNbRecords', null, true); 
				setPosition( $this->currentVal, $this->countMax, $this->first, $args['key']);
				break;						
			case 'Delete':
			case 'Save':
				$this->bulk( $args);
				setPosition( $this->currentVal, $this->countMax, $this->first, $args['key']);
				break;
		} 	
		
		$where = ' WHERE opportunities_roles.opportunity_id = "'.$args['opportunity_id'].'" ';
		foreach( $inputs as $fieldName => $fieldValue )
		{
			if( $args[$fieldName] )	
			{	
				if( substr( $fieldName, -3) == '_id' )
					$where .= ' AND opportunities_roles.'.$fieldName.' = "'.$args[$fieldName].'" ';				
				else
					$where .= ' AND opportunities_roles.'.$fieldName.' like "%'.$args[$fieldName].'%" ';	
			}	
		}	
		
		$result['roles'] = $this->searchAndList( $where, $args['orderby'], $args['ascdesc']);

		// Save context in cookie SESSION_SID
		$_SESSION['roles']['countMax'] 	= $this->countMax;
		$_SESSION['roles']['currentVal'] = $this->currentVal;
		$_SESSION['roles']['first'] 	= $this->first;
		$_SESSION['roles']['appOrderBy'] = $args['orderby'];		
		$_SESSION['roles']['appAscDesc'] = $args['ascdesc'];			
		$_SESSION['roles']['bulk_id'] 	= $args['bulk_id'];			
		foreach( $inputs as $fieldName => $fieldValue )
			$_SESSION['roles'][$fieldName] = $args[$fieldName];
		//foreach( $inputs as $fieldName => $fieldValue )
			//$_SESSION['roles']['bulk_'.$fieldName] = $args['bulk_'.$fieldName];			
				
		// Put back the search context to the screen
		$result['recordset'] = $_SESSION['roles'];
		
		// retrieve the RBAC status of this user on this application
		$result['scope'] = ( $args['user_id'] )?$GLOBALS['appshore']->rbac->checkPermissionOnUser('opportunities', $args['user_id']):1 ;

		// get these fields for search criterias form
		//$result['users'] = getManyAssocArrays( 'select user_id, user_name from users '.buildClauseWhere('opportunities','R').' order by user_name');
		//$result['bulk_users'] = getManyAssocArrays( 'select user_id, user_name from users '.buildClauseWhere('opportunities','W').' order by user_name');
		$result['nbrecords'] = array(array('nbrecords'=>10),array('nbrecords'=>15),array('nbrecords'=>20),array('nbrecords'=>25),array('nbrecords'=>30),array('nbrecords'=>35),array('nbrecords'=>40),array('nbrecords'=>45),array('nbrecords'=>50));
		//$result['bulk']= array(array('bulk_id' => 'Selected', 'bulk_name'=>lang('Selected lines')),array('bulk_id' => 'Results', 'bulk_name'=>lang('Search results')));

		// define next action
		$result['action']['roles'] = 'search';

        return $result;
    }
    
	// bulk operations
    function bulk( $args)
    {
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = explode( ',', $args['selected']);				  
				switch($args['key'])
				{
					case 'Delete':
						foreach( $selected as $key => $val)
						{
							$role['role_id'] = $val;
							if( deleteRowWhere( 'opportunities_roles', 'where role_id ="'.$role['role_id'].'" and opportunity_id ="'.$args['opportunity_id'].'" ', false))
								$this->countMax--;
						}	
						messagebox( MSG_DELETE, NOTICE);				
						break;
						
					case 'Save':
						foreach( $args as $key => $val)
						{
							if( strpos( $key, 'bulk_') !== false && $val && $key != 'bulk_id' ) 
								$role[substr($key,5)] = $val;
						}	
										
						$roles_count=0;	
						foreach( $selected as $key => $val)
						{
							$role['role_id'] = $val;
							if( $GLOBALS['appshore']->rbac->checkPermissionOnUser('opportunities', $role['user_id']) == true ||
								$GLOBALS['appshore']->rbac->checkDataPermissions('opportunities', 'opportunities_roles', 'role_id', $role['role_id'] ) == true )
							{
								updateRow( 'opportunities_roles', 'role_id', $role, false);
								$roles_count++;							
							}
						}	
						messagebox( MSG_UPDATE, NOTICE);				
						break;
				}
				break;
		}			
    }
    

	// join SQL query to retrieve accounts according search criterias
	function searchAndList( $where, $orderby = 'role_id', $ascdesc = 'ASC')
	{
	
		$db = $GLOBALS['appshore']->db->execute('
			SELECT 
				opportunities_roles.role_id,
				opportunities_roles.opportunity_id,
				opportunities_roles.role,
				opportunities_roles.note,
				contacts.contact_id,				
				contacts.first_names,	
				contacts.last_name,	
				contacts.title,	
				accounts.account_id,
				accounts.account_name
			FROM
				opportunities_roles
				LEFT OUTER JOIN contacts 
					ON opportunities_roles.contact_id = contacts.contact_id
				LEFT OUTER JOIN accounts 					
					ON contacts.account_id = accounts.account_id '.					
				$where.	
			' ORDER BY '.$orderby.' '.$ascdesc
			);	
	
		
		$db->Move($this->currentVal);    
		$this->countMax = $db->RowCount();
			
		while( !$db->EOF && $nbr < $GLOBALS['appshore_data']['current_user']['nbrecords'])
		{
			$scope['scope'] = 1 ;
		
			$result['roles'][] = array_merge( $db->GetRowAssoc(false), $scope);			
				
			$db->MoveNext();
			$nbr++;
		}  	

		$this->first = $this->currentVal + $nbr ;
		
		return $result['roles'];
	}

	
	
}
