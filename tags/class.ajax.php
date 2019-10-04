<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class tags_ajax 
{
	
	// create a new tag
    function createList()
    {
		$args = new safe_args();
		$args->set('list_name', NOTSET, 'string');
		$args = $args->get(func_get_args());  
		
		if( getOneAssocArray( 'select tag_name from tags where tag_name = "'.$args['list_name'].
			'" and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"') == null )
		{
			$args['tag_name'] = $args['list_name'];
			$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
			$result['list_id'] = insertRow( 'tags', 'tag_id', $args, false);
			$result['return'] = 'success';
		} 
		else
			$result['return'] = 'failure';

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    } 
    
	// delete the tag
    function deleteTag()
    {
		$args = new safe_args();
		$args->set('tag_id', NOTSET, 'string');
		$args = $args->get(func_get_args());  
		
		if( getOneAssocArray( 'select tag_name from tags where tag_id = "'.$args['tag_id'].
			'" and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"') == null )
			$result['return'] = 'failure';
		else
		{
			executeSQL( 'delete from tags where tag_id = "'.$args['tag_id'].
				'" and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
			executeSQL( 'delete from tags_records where tag_id = "'.$args['tag_id'].'"');
			$result['return'] = 'success';
		} 

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }
    
	// remove tag marker from a list of records
    function removeTag()
    {
		$args = new safe_args();
		$args->set('tag_id', 	NOTSET, 'string');
		$args->set('selected',	NOTSET, 'string');
		$args = $args->get(func_get_args());  
		
		if( getOneAssocArray( 'select tag_name from tags where tag_id = "'.$args['tag_id'].
			'" and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"') == null )
			$result['return'] = 'failure';
		else
		{
			executeSQL('delete from tags_records where tag_id = "'.$args['tag_id'].'" '.
				' and record_id in ( "'. implode( array_unique(explode( ',', $args['selected'])), '","') .'") ');
			$result['return'] = 'success';
		} 

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }    
    
	// rename a tag
    function renameTag()
    {
		$args = new safe_args();
		$args->set('tag_id', 	NOTSET,	'string');
		$args->set('tag_name',	NOTSET, 'string');
		$args = $args->get(func_get_args());  
		
		if( getOneAssocArray( 'select tag_name from tags where tag_id = "'.$args['tag_id'].
			'" and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"') == null )
			$result['return'] = 'failure';
		else
		{
			executeSQL( 'update tags set tag_name = "'.$args['tag_name'].'" where tag_id = "'.$args['tag_id'].
				'" and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
			$result['return'] = 'success';
		} 

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }             
    
    // retrieve list of tags for a specific user
    function getLists()
    {
		$result['lists'] = getManyAssocArrays( 'select tag_id as list_id, tag_name as list_name from tags where user_id = "'.
			$GLOBALS['appshore_data']['current_user']['user_id'].'" order by tag_name');

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }  
    
	// mark records with a tag
    function populateList( $args)
    {
		$args = new safe_args();
		$args->set('app_name',	NOTSET, 'string');
		$args->set('list_id',	NOTSET, 'string');
		$args->set('bulk_id',	'Selected', 'string');
		$args->set('selected',	NOTSET, 'string');
		$args = $args->get(func_get_args());  

		$app = getOneAssocArray('select app_name, table_name, field_name from db_applications where app_name = "'.$args['app_name'].'"');	
	
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$sql = 'SELECT DISTINCT "'.$args['list_id'].'", '.$app['field_name'].', "'.$app['app_name'].'" 
					FROM '.$app['table_name'].'
					WHERE '.$app['field_name'].' IN ( "'. implode( array_unique(explode( ',', $args['selected'])), '","') .'") ';
						
				break;
				
			case 'All':
				// table must be aliased to t0 because this is the prefix of the columns in where clause
				/*
				$sql = 'SELECT DISTINCT "'.$args['list_id'].'", '.$app['field_name'].', "'.$app['app_name'].'"  
					FROM '.$app['table_name'].' t0
					WHERE 1=1 '.$_SESSION[$app['app_name']]['sql']['where'];
				*/
					
				$sql = 'SELECT DISTINCT "'.$args['list_id'].'", t0.'.$app['field_name'].', "'.$app['app_name'].'"'.
					' FROM '.$app['table_name'].' t0 '.$_SESSION[$app['app_name']]['sql']['join'].
					$_SESSION[$app['app_name']]['sql']['where'];
				break;
		}			

		if ( $sql )
		{
			$sql = str_replace( '  ', ' ', $sql);
			$sql = str_replace( '1=1 AND', '', $sql);
			executeSQL( 'REPLACE INTO tags_records( tag_id, record_id, app_name) '.$sql);
			$result['return'] = 'success';
		}
		else
			$result['return'] = 'failure';

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }            
    
}
