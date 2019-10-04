<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class base_panelets_ajax 
{

    function addPanelet()
    {
		$args = new safe_args();
		$args->set('panelet_name', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		executeSQL('UPDATE panelets SET panelet_sequence=panelet_sequence+1 '.
			'WHERE user_id="'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
					
		executeSQL('INSERT INTO panelets (user_id, panelet_name, panelet_sequence, is_open) '.
			'VALUES ("'.$GLOBALS['appshore_data']['current_user']['user_id'].'", "'.$args['panelet_name'].'", "1", "Y")');
 
		$result['return'] = 'success';
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
	}
    

    function openClosePanelet()
    {
		$args = new safe_args();
		$args->set('panelet_name', 	NOTSET, 'any');
		$args->set('is_open', 		'Y', 'any');
		$args = $args->get(func_get_args());
		
		executeSQL('UPDATE panelets SET is_open="'.$args['is_open'].'" '.
			'WHERE user_id="'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and panelet_name = "'.$args['panelet_name'].'"');
					
		$result['return'] = 'success';
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
	}    
	
    function movePanelet()
    {
		$args = new safe_args();
		$args->set('data', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		if( $panelets = explode(";", $args['data']) )
		{	
			$sequence = 1;
			foreach($panelets AS $value)
			{
				if( $value )
					executeSQL('UPDATE panelets SET panelet_sequence="'.$sequence++.'" '.
						'WHERE user_id="'.$GLOBALS['appshore_data']['current_user']['user_id'].'" '.
						'AND panelet_name="'.$value.'"');
			}
		}
		
		$result['return'] = 'success';
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
	} 
         
    function removePanelet()
    {
		$args = new safe_args();
		$args->set('panelet_name', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		executeSQL('DELETE FROM panelets WHERE user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" AND panelet_name = "'.$args['panelet_name'].'"');
 
		$result['return'] = 'success';
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
	}

}
