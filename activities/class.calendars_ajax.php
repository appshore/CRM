<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once ( 'class.calendars.php');

class activities_calendars_ajax extends activities_calendars
{

    function updateActivity()
    {
		$args = new safe_args();
		$args->set('activity_id', 	NOTSET, 'sqlsafe');
		$args->set('period', 		1, 'sqlsafe');
		$args->set('first', 		NOTSET, 'sqlsafe');
		$args->set('last', 			NOTSET, 'sqlsafe');
		$args->set('start', 		NOTSET, 'sqlsafe');
		$args->set('end', 			NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());  
		
		$activity['activity_id'] = $args['activity_id'];
		$activity['activity_start'] = $GLOBALS['appshore']->local->datetimeToLocal((date( 'Y-m-d H:i:s', $args['start'])));
		$activity['activity_end'] = $GLOBALS['appshore']->local->datetimeToLocal((date( 'Y-m-d H:i:s', $args['end'])));

		if(	updateRow( 'activities', 'activity_id', $activity, false) )
		{
			if( $args['first'] && $args['last'] )
			{
				$activity = getOneAssocArray( 'select * from activities where activity_id = "'.$args['activity_id'].'"');
				$this->daysPerPeriod =  $args['period'];
				$result['activity'] = $this->computeGridActivity($activity, $args['first']);
			}
			$result['return'] = 'success';
		}
		else
			$result['return'] = 'failure';

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }  
    
}
