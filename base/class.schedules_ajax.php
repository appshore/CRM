<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ('class.schedules.php');

class base_schedules_ajax extends base_schedules
{

    // retrieve list of popup schedules
    function getSchedules()
    {
		$args = new safe_args();
		$args->set('user_id',	$GLOBALS['appshore_data']['current_user']['user_id'],'sqlsafe');
		$args->set('type_id', 	'P', 'sqlsafe'); // popup schedules
		$args = $args->get(func_get_args());

		$result = parent::getSchedules($args);

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }  

    // stop a schedule
    function stopSchedule()
    {
		$args = new safe_args();
		$args->set('schedule_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		$result = parent::stopSchedule($args);

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }      

}
