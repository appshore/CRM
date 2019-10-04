<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class logs_base {

	function getlogs()
	{	

		$logs = getManyAssocArrays('SELECT * FROM logs WHERE user_id = "'.
			$GLOBALS['appshore_data']['current_user']['user_id'].'" '.'ORDER BY tag_name');
			
		return $logs;				
	}
	
	
	function getlogsPerRecord()
	{	
		$args = new safe_args();
		$args->set('app_name',NOTSET,'any');
		$args->set('record_id',NOTSET,'any');
		$args = $args->get(func_get_args());

		return getManyAssocArrays('SELECT * FROM logs WHERE user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].
			'" and tag_id in ( select distinct tag_id from logs_records where app_name = "'.$args['app_name'].'" and record_id = "'.$args['record_id'].
			'") ORDER BY tag_name');
	}	
	

    function getRecords()
    {
		$args = new safe_args();
		$args->set('tag_id',NOTSET,'any');
		$args = $args->get(func_get_args());

        $GLOBALS['appshore']->add_xsl('lib.base');  
        $GLOBALS['appshore']->add_xsl('lib.custom');  
        $GLOBALS['appshore']->add_xsl('logs.base');  

		// define next action
		$result['action']['logs'] = 'logs';
		       
 		$tag = getOneAssocArray('select * from logs where tag_id = "'.$args['tag_id'].'"');
 		$apps = getManyAssocArrays('select * from db_applications where app_name in (SELECT distinct app_name FROM logs_records WHERE tag_id = "'.$args['tag_id'].'") '.'ORDER BY app_name');
			
    	$result['tag_name'] = $tag['tag_name'];
    	$result['tag_id'] = $tag['tag_id'];
    	$result['scope'] = 1;

		if( $apps )
		{
			// browse available apps
			foreach( $apps as $keyapp => $valapp)
			{
		        $result[$valapp['app_name']] = execMethod($valapp['app_name'].'.base.logs',  $args, true);

		        if ( !$result[$valapp['app_name']]['results']  )
		        	unset( $result[$valapp['app_name']]);
		        else
			        $result['apps'][] = $valapp;
	        }
	    }
	    else
	    	messagebox( 'No record are linked with this tag', ERROR);
	    	
		return $result;
    }

	
	
}
