<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class lib_panelets
{
    function __construct()
    {
    }

	function filter()
	{	
		$args = new safe_args();
		$args->set( 'filter', 	NOTSET, 'any');
		$args->set( 'scope', 	'user', 'any');
		$args->set( 'orderby', 	$this->appOrderBy, 'any');
		$args->set( 'ascdesc', 	$this->appAscDesc, 'any');
		$args->set( 'display', 	5, 'any');
		$args = $args->get(func_get_args());

		switch( $args['scope'] )
		{
			case 'public':
				$where = buildClauseWhere( $this->appName, 'R', '');
				break;
			case 'role':
				$where = buildClauseWhere( $this->appName, 'R', '');
				break;
			case 'user':
				// filter on owner
				$where = ' WHERE user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"';
				break;
			default:
				$where = ' WHERE 1 = 1 ';
				break;
		} 

		if( $args['filter'] )
			$where .= ' AND '.$args['filter'];


		if( $args['orderby'] && $args['ascdesc'] )
			$where .= ' order by '.$args['orderby'].' '.$args['ascdesc'];

		return $where.' limit '.$args['display'];
	}
		    
}
