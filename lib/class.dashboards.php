<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.base.php');

class lib_dashboards extends lib_base
{
    // called by others apps when embeded
    function display()
    {
		$args = new safe_args();
		$args->set( 'filter', 	NOTSET, 'any');
		$args->set( 'scope', 	'user', 'any');
		$args->set( 'orderby', 	$this->appOrderBy, 'any');
		$args->set( 'ascdesc', 	$this->appAscDesc, 'any');
		$args->set( 'display', 	5, 'any');
		$args = $args->get(func_get_args());
		    
    	// we save then reset current context to avoid any conflict when calling the same app (accounts => subsidiares, contacts +> manager, assistant, ...)
    	$save = $this->defaultSessionApp();
    	unset($_SESSION[$this->appName]);
    	
		$result['dashboard_fields'] = $this->getFields($this->appName, $this->appTable, 'linked'); 

		$sql = $this->buildSQL( null, null, $result['dashboard_fields']);	
		
		// we add a filter if not yet done
		if( strpos( $sql, ' WHERE ') == false )
		{
			switch( $args['scope'] )
			{
				case 'public':
					$where = buildClauseWhere( $this->appName, 'R', 't0.');
					break;
				case 'role':
					$where = buildClauseWhere( $this->appName, 'R', 't0.');
					break;
				case 'user':
					// filter on owner
					$where = ' WHERE t0.user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"';
					break;
				default:
					$where = ' WHERE 1 = 1 ';
					break;
			} 
		}

		if( $args['scope'] == 'user' )
		{
			// unset the owner field to improve display
			$result['dashboard_fields'] = $this->unsetField( $result['dashboard_fields'], 'user_id');
		} 
					
		if( $args['filter'] )
			$where .= ' AND t0.'.$args['filter'];

		if( $args['orderby'] && $args['ascdesc'] )
			$where .= ' order by t0.'.$args['orderby'].' '.$args['ascdesc'];

		$sql = $this->buildSQL( null, null, $result['dashboard_fields']).$where;	


		$result['results'] = $this->getSearchResults( $this->appName, $args['display'], $sql, $result['dashboard_fields']);		
       	$result['record_id'] = $this->appRecordId;    					

		// we restore the saved context
		$_SESSION[$this->appName] = $save;
		
		return $result;		
    }     

}
