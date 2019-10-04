<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.base.php');

class lib_tags extends lib_base
{
     
    // called by global search   	
    function search()
    {
		$args = new safe_args();
		$args->set('tag_id', NOTSET, 'string');
		$args = $args->get(func_get_args());

    	// we save then reset current context to avoid any conflict when calling the same app (accounts => subsidiares, contacts +> manager, assistant, ...)
    	$save = $_SESSION[$this->appName]; //$this->defaultSessionApp();
    	unset($_SESSION[$this->appName]);
    	
		$result['result_fields'] = $this->getFields($this->appName, $this->appTable, 'result'); 
		
		// $args contains the global search filter so we add it to the SQL sentence
		$sql = $this->buildSQL( null, null, $result['result_fields']).' where t0.'.$this->appRecordId.
			' in (select record_id from tags_records where tag_id = "'.$args['tag_id'].'" and app_name = "'.$this->appName.
			'" ) order by '.$this->appOrderBy.' '.$this->appAscDesc;	

		$result['results'] = $this->getSearchResults( $this->appName, 100, $sql, $result['result_fields']);		
		
		// we restore the saved context
		$_SESSION[$this->appName] = $save;
		
		return $result;		
     }   
}
