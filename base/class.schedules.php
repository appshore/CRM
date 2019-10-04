<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/
 
class base_schedules
{

    // delete Schedule according the related application and record_id 
    function deleteSchedule( $args = null)
    {
		$args = new safe_args();
		$args->set('company_id',	$GLOBALS['appshore_data']['my_company']['company_id'],'sqlsafe');
		$args->set('app_name',		NOTSET,'sqlsafe');
		$args->set('record_id',		NOTSET,'sqlsafe');
		$args = $args->get(func_get_args());

		$schedules = getManyAssocArrays('select schedule_id, type_id from schedules '.
			' where app_name = "'.$args['app_name'].'" and record_id = "'.$args['record_id'].'"');

		if( $schedules )
		foreach( $schedules as $key => $val )
		{
			executeSQL('delete from schedules where schedule_id = "'.$val['schedule_id'].'"');
			if( $val['type_id'] == 'E')
    			executeSQL('delete from '.BACKOFFICE_DB.'.customers_schedules '.
	    			'where company_id = "'.$args['company_id'].'" and schedule_id = "'.$val['schedule_id'].'"');
		} 
    }
    
    // set (create or update) a Schedule
    function setSchedule( $args = null)
    {
		$args = new safe_args();
		$args->set('company_id',	$GLOBALS['appshore_data']['my_company']['company_id'],'sqlsafe');
		$args->set('user_id',		$GLOBALS['appshore_data']['current_user']['user_id'],'sqlsafe');
		$args->set('app_name',		NOTSET,'sqlsafe');
		$args->set('record_id',		NOTSET,'sqlsafe');
		$args->set('type_id',		NOTSET,'sqlsafe');
		$args->set('status_id',		NOTSET,'sqlsafe');
		$args->set('start_date',	NOTSET,'sqlsafe');
		$args->set('start_time',	NOTSET,'sqlsafe');
		$args->set('interval',		NOTSET,'sqlsafe');
		$args = $args->get(func_get_args());


		// retrieve the schedule
		$schedule_id = getOneColOneRow('select schedule_id from schedules '.
			' where app_name = "'.$args['app_name'].'" and type_id = "'.$args['type_id'].'" and record_id = "'.$args['record_id'].'"');

		// extract period and qty
    	list( $remnbr, $period) = explode('.', $args['interval']);

		// schedule is unset
		if( $remnbr == '' || $period == '')
		{
			// if exists it is removed from the table
	    	if( $schedule_id )
	    	{
				executeSQL('delete from schedules where schedule_id = "'.$schedule_id.'"');
    			if( $args['type_id'] == 'E')
    				executeSQL('delete from '.BACKOFFICE_DB.'.customers_schedules '.
    					' where company_id = "'.$args['company_id'].'" and schedule_id = "'.$schedule_id.'"');
			}

			// unset so we quit
			return;
		}

		// retrieve period name
		$period = getOneColOneRow('select period_name from global_schedules_periods where period_id = "'.$period.'"');

		// calculate timestamp
		if( $args['start_time'] != 'NULL' )
		{
			$schedule_datetime = $GLOBALS['appshore']->local->TZToGMT(date('Y-m-d H:i:00', strtotime($args['start_date'].' '.$args['start_time'].' -'.$remnbr.' '.$period)));
			list($schedule_date, $schedule_time) = explode(' ', $schedule_datetime);
			// Schedule on past time is deactivated
			if( $schedule_datetime <= gmdate('Y-m-d H:i:00') )
				$args['status_id'] = 'D';
			$schedule_time = '"'.$schedule_time.'"';
		}
		else
		{
			$schedule_date = date('Y-m-d', strtotime($args['start_date'].' -'.$remnbr.' '.$period));
			if( $schedule_date < gmdate('Y-m-d') )
				$args['status_id'] = 'D';
			$schedule_time = 'NULL';			
		}
		
    	if( $schedule_id )
    	{	
    		// update the schedule
			executeSQL('update schedules set schedule_date = "'.$schedule_date.'", schedule_time = '.$schedule_time.
				', status_id = "'.$args['status_id'].'"'.' where schedule_id = "'.$schedule_id.'"');
     	}
    	else
    	{
    		// insert a new schedule
			$schedule_id = generateId();
	 		executeSQL('insert into schedules ( `schedule_id`, `user_id`, `schedule_date`, `schedule_time`, `app_name`, `record_id`, `type_id`, `status_id`)'.
	 			' values("'.$schedule_id.'","'.$args['user_id'].'","'.$schedule_date.'",'.$schedule_time.',"'.$args['app_name'].'","'.
	 			$args['record_id'].'", "'.$args['type_id'].'", "'.$args['status_id'].'")');
    	}

    	// set it in BO table
		if( $args['type_id'] == 'E')
		{
	 		executeSQL('replace into '.BACKOFFICE_DB.'.customers_schedules ( `schedule_date`, `schedule_time`, `company_id`, `schedule_id`)'.
	 			' values("'.$schedule_date.'",'.$schedule_time.',"'.$args['company_id'].'","'.$schedule_id.'")');
	 	}
    }	
    
    // retrieve list of schedules
    function getSchedules()
    {
		$args = new safe_args();
		$args->set('user_id',	$GLOBALS['appshore_data']['current_user']['user_id'], 'sqlsafe');
		$args->set('type_id', 	'P', 'sqlsafe'); // popup is the best guest
		$args = $args->get(func_get_args());

		$schedule_datetime = gmdate('Y-m-d H:i:00');
		list($schedule_date, $schedule_time) = explode(' ', $schedule_datetime);

		$schedules = getManyAssocArrays('select * from schedules '.
			'where user_id = "'.$args['user_id'].'" and type_id = "'.$args['type_id'].'" '.
			'and schedule_date <= "'.$schedule_date.'" '.
			'and (schedule_time <= "'.$schedule_time.'" or schedule_time is null) and status_id = "A" '.
			'order by schedule_date, schedule_time');

		if( $schedules )
			foreach( $schedules as $key => $val)
			{
				if( $record = execMethod( $val['app_name'].'.schedules.getRecordInformation', $val) )
					$result['schedules'][] = $record;			
			}

 		return $result ;
    }  

    // retrieve list of schedules
    function stopSchedule()
    {
		$args = new safe_args();
		$args->set('schedule_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		executeSQL('update schedules set status_id = "D" where schedule_id = "'.$args['schedule_id'].'"');
    }     
    
	// retrieve and execute schedules
	function triggerSchedules()
	{
		$args = new safe_args();
		$args->set('schedule_date',	gmdate('Y-m-d'), 'sqlsafe');
		$args->set('schedule_time',	gmdate('H:i:00'), 'sqlsafe');
		$args = $args->get(func_get_args());

		if( $args['schedule_time'] == 'NULL' )
	    	$schedules = getManyAssocArrays('select * from schedules where schedule_date = "'.$args['schedule_date'].'" and schedule_time is null'
    			.' and status_id = "A" and type_id = "E"');
		else
	    	$schedules = getManyAssocArrays('select * from schedules where schedule_date = "'.$args['schedule_date'].'" and schedule_time = "'.$args['schedule_time'].'"'
    			.' and status_id = "A" and type_id = "E" ');

		if( $schedules )
		{
	    	foreach( $schedules as $key => $val )
	    	{
				$return = execMethod( $val['app_name'].'.schedules.trigger', $val);
    		}

			if( $args['schedule_time'] == 'NULL' )
		    	executeSQL('update schedules set status_id = "D" where schedule_date = "'.$args['schedule_date'].'" and schedule_time is null and type_id = "E"');
			else
	    		executeSQL('update schedules set status_id = "D" where schedule_date = "'.$args['schedule_date'].'" and schedule_time = "'.$args['schedule_time'].'" and type_id = "E"');
    	}
		    	
		// purge and optimize the table
   		executeSQL('delete from schedules where schedule_date < "'.$args['schedule_date'].'"');
		executeSQL('alter table schedules order by schedule_date, schedule_time');	    		

		$result[$this->appName]['status'] = OK;
 		return $result;
	}

}
