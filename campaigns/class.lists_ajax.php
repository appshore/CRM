<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class campaigns_lists_ajax 
{

    function createList()
    {
		$args = new safe_args();
		$args->set('list_name', NOTSET, 'string');
		$args = $args->get(func_get_args());  
		
		if( getOneAssocArray( 'select list_name from campaigns_lists where list_name = "'.$args['list_name'].'"') )
			$result['return'] = 'failure';
		else
		{
			$newlist['list_name'] = $args['list_name'];
			$newlist['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
			$result['list_id'] = insertRow( 'campaigns_lists', 'list_id', $newlist, false);
			$result['return'] = 'success';
		} 

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }  
    
    function getLists()
    {
		$result['lists'] = getManyAssocArrays( 'select list_id, list_name from campaigns_lists '.buildClauseWhere('campaigns','W','').' order by list_name');

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    } 
    
	// mark records with a tag
    function populateList( $args)
    {
		$args = new safe_args();
		$args->set('app_name', 	NOTSET, 'string');
		$args->set('list_id', 	NOTSET, 'string');
		$args->set('bulk_id', 	NOTSET, 'string');
		$args->set('selected', 	NOTSET, 'string');
		$args = $args->get(func_get_args());  

		$app = getOneAssocArray('select app_name, table_name, field_name from db_applications where app_name = "'.$args['app_name'].'"');	
	
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$sql = 'SELECT DISTINCT "'.$args['list_id'].'", '.$app['field_name'].', "'.$app['app_name'].'", "UP"
					FROM '.$app['table_name'].'
					WHERE '.$app['field_name'].' IN ( "'. implode( array_unique(explode( ',', $args['selected'])), '","') .'") ';
						
				break;
				
			case 'All':
				// table must be aliased to t0 because this is the prefix of the columns in where clause
				$sql = 'SELECT DISTINCT "'.$args['list_id'].'", t0.'.$app['field_name'].', "'.$app['app_name'].'", "UP"'.
					' FROM '.$app['table_name'].' t0 '.$_SESSION[$app['app_name']]['sql']['join'].
					$_SESSION[$app['app_name']]['sql']['where'];
				break;
		}			

		if ( $sql )
		{
			$sql = str_replace( '  ', ' ', $sql);
			$sql = str_replace( '1=1 AND', '', $sql);
			executeSQL( 'REPLACE INTO campaigns_records( list_id, record_id, table_name, status_id) '.$sql);
			$result['return'] = 'success';
		}
		else
			$result['return'] = 'failure';

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }           
    
}
