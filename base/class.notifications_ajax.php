<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ('class.notifications.php');

class base_notifications_ajax extends base_notifications
{

    // retrieve list of popup notifications
    function getNotifications()
    {
		$args = new safe_args();
		$args->set('user_id',	$GLOBALS['appshore_data']['current_user']['user_id'],'sqlsafe');
		$args->set('type_id', 	'P', 'sqlsafe'); // popup notifications
		$args = $args->get(func_get_args());

		$result = parent::getNotifications($args);

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }  

    // retrieve list of notifications
    function stopNotification()
    {
		$args = new safe_args();
		$args->set('notification_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		$result = parent::stopNotification($args);

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }      

}
