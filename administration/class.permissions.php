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

class administration_permissions {

    function administration_permissions()
    {
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl('administration.permissions');
	} 
	
   
    function start()
    {
		// First time that we start this app during the current session so we must init search criterias
		if (!isset($_SESSION['permission']['search'])) 
		{
			$_SESSION['permission']['search']['appOrderBy'] = 'app_name';
			$_SESSION['permission']['search']['appAscDesc'] = 'ASC';    
			$_SESSION['permission']['search']['first'] = 0;   
			$_SESSION['permission']['search']['currentVal'] = 0;   
			$_SESSION['permission']['search']['countMax'] = 0;   
		}
		$result = $this->search();
		return $result;
    } 
	
	// search and list permissions
    function search()
    {
		$args = new safe_args();
		$args->set('key', NOTSET, 'any');
		$args->set('currentVal', 	$_SESSION['permission']['search']['currentVal'], 'any');
		$args->set('countMax', 		$_SESSION['permission']['search']['countMax'], 'any');
		$args->set('first', 		$_SESSION['permission']['search']['first'], 'any');
		$args->set('orderby', 		$_SESSION['permission']['search']['appOrderBy'], 'any');
		$args->set('ascdesc', 		$_SESSION['permission']['search']['appAscDesc'], 'any');
		$args->set('app_name', 		NOTSET, 'any');
		$args->set('role_id', 		NOTSET, 'any');
		$args = $args->get(func_get_args()); 
		
		$currentVal = $args['currentVal'];
		$countMax = $args['countMax'];
		$first = $args['first'];

		
 		switch($args['key'])
		{

			case 'Next':
				$currentVal += $GLOBALS['appshore_data']['current_user']['nbrecords']; 
				if ( $currentVal == $countMax  ) 
					$currentVal = $countMax - $GLOBALS['appshore_data']['current_user']['nbrecords'] ;
				else if ($currentVal > $countMax ) 
				     $currentVal = $countMax - $countMax%$GLOBALS['appshore_data']['current_user']['nbrecords'];    
				break;
			case 'Previous':
				$currentVal -= $GLOBALS['appshore_data']['current_user']['nbrecords']; 
				if ( $currentVal < 0 ) 
					$currentVal = 0 ;
				break;
			case 'Last':
				$currentVal = $countMax - $countMax%$GLOBALS['appshore_data']['current_user']['nbrecords'];
				break;	
			case 'Clear':
				unset($args);
				unset($_SESSION['permission']['search']);
				// No Break
			case 'Search':				
				$args['ascdesc'] ='ASC';				
				$args['orderby'] ='app_name';	
				// No Break
			case 'First':
				$currentVal = $first = $countMax = 0;
				break;	
		} 
		
		if ( $args['role_id']) 
			$where .= ' AND role_id = "'.$args['role_id'].'" ';

			
		$result['permissions'] = $this->searchAndList( $where, $args['orderby'], $args['ascdesc'], $first, $currentVal, $countMax);	
		
		$_SESSION['permission']['search'] = array(
			'countMax' 		=> $countMax, 
			'currentVal' 	=> $currentVal, 
			'first' 		=> $first,
			'appOrderBy' 	=> $args['orderby'],
			'appAscDesc' 	=> $args['ascdesc'],
			'app_name'		=> $args['app_name'],			
			'role_id'		=> $args['role_id']	
			);
			
		$result['recordset'] = $_SESSION['permission']['search'];
		$result['action']['permissions'] = 'view';
		
        return $result;
    } 
	
	// join SQL query to retrieve permissions according search criterias
	function searchAndList( $where, $orderby = 'app_name', $ascdesc = 'ASC', &$first, $currentVal=0, &$countMax )
	{
		$db = $GLOBALS['appshore']->db->execute('
			SELECT 
				*
			FROM
				permissions
			WHERE 1 = 1
			'.$where.' 
			ORDER BY app_name '
			);	
			
		$db->Move($currentVal);    
		$countMax = $db->RowCount();
			
		while( !$db->EOF && $nbr < $GLOBALS['appshore_data']['current_user']['nbrecords'])
		{
			$result['permissions'][] = $db->GetRowAssoc(false);				
				
			$db->MoveNext();
			$nbr++;
		}  	

		$first = $currentVal + $nbr ;
		
		return $result['permissions'];
	}

	
	
}
