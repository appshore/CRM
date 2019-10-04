<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class base_searches_ajax 
{   
    // retrieve list of searches
    function getSearches()
    {
		$args = new safe_args();
		$args->set('app_name',	NOTSET, 'string');
		$args = $args->get(func_get_args());  

		$result['searches'] = getManyAssocArrays( 'select search_id, search_name, is_default from searches 
			where app_name = "'.$args['app_name'].'" and ( user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" 
			or is_private = "N") order by is_default, search_name');

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }  
    
    // retrieve a specific search
    function loadSearch()
    {
		$args = new safe_args();
		$args->set('app_name',		NOTSET, 'string');
		$args->set('search_id',		NOTSET, 'string');
		$args = $args->get(func_get_args());  

		$result['search'] = getOneAssocArray( 'select * from searches where search_id = "'.$args['search_id'].'" 
			and app_name = "'.$args['app_name'].'"');

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }      
    
	// mark records with a search
    function saveSearch( $args)
    {
		$args = new safe_args();
		$args->set('app_name',		NOTSET, 'string');
		$args->set('search_id',		NOTSET, 'string');
		$args->set('search_name',	NOTSET, 'string');
		$args->set('search_filter',	NOTSET, 'string');
		$args->set('is_default',	NOTSET, 'string');
		$args = $args->get(func_get_args());  

		if ( $args['search_id'])
		{
			$search['search_id'] = $args['search_id'];
			$search['search_filter'] = $args['search_filter'];
			updateRow( 'searches', 'search_id', $search);
			$result['return'] = 'success';
		}
		else if ( $args['search_name'] )
		{
			$search['search_name'] = $args['search_name'];
			$search['search_filter'] = $args['search_filter'];
			$search['is_default'] = $args['is_default'];
			$search['app_name'] = $args['app_name'];
			$search['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
			$search['search_id'] = insertRow( 'searches', 'search_id', $search);
			$result['return'] = 'success';
		}
		else
			$result['return'] = 'failure';
			
		if( $search['is_default'] == 'Y' && $result['return'] == 'success' )
			executeSQL('update searches set is_default = "N" where app_name = "'.$args['app_name'].'" 
				and search_id <> "'.$search['search_id'].'" 
				and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
			

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }            
    
}
