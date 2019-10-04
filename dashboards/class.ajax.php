<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class dashboards_ajax 
{

    function addDashlet()
    {
		$args = new safe_args();
		$args->set('column_nbr', 	NOTSET, 'any');
		$args->set('dashlet_name', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		executeSQL('UPDATE dashboards SET dashlet_sequence=dashlet_sequence+1 '.
			'WHERE user_id="'.$GLOBALS['appshore_data']['current_user']['user_id'].'" '.
			'AND column_nbr="'.$args['column_nbr'].'"');
					
		executeSQL('INSERT INTO dashboards (user_id, column_nbr, dashlet_name, dashlet_sequence) '.
			'VALUES ("'.$GLOBALS['appshore_data']['current_user']['user_id'].'", "'.$args['column_nbr'].'", '.
			'"'.$args['dashlet_name'].'", "1")');
 
		$result['return'] = 'success';
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
	}
    
    function moveDashlet()
    {
		$args = new safe_args();
		$args->set('data', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		$containers = explode(";", $args['data']);
		foreach($containers AS $container)
		{
		    $sequence = 1;
		    list( $column, $boxes) = explode(":", $container);
		    list( $nil, $column) = explode("-", $column);
		    $boxes = explode(",", $boxes);
		    foreach($boxes AS $value)
		    {
		    	if($value == '')
		        	continue;

				executeSQL('UPDATE dashboards SET dashlet_sequence="'.$sequence++.'", column_nbr="'.$column.'" '.
					'WHERE user_id="'.$GLOBALS['appshore_data']['current_user']['user_id'].'" '.
					'AND dashlet_name="'.$value.'"');
		    }
		}

		$result['return'] = 'success';
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
	}
     

         
    function removeDashlet()
    {
		$args = new safe_args();
		$args->set('dashlet_name', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		executeSQL('DELETE FROM dashboards WHERE user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" AND dashlet_name = "'.$args['dashlet_name'].'"');
 
		$result['return'] = 'success';
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
	}

}
