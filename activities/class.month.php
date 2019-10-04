<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( 'class.calendars.php');

class activities_month extends activities_calendars
{

   function __construct()
    {
		parent::__construct();
     	$_SESSION[$this->appName]['tab_id'] = $this->tab_id = 'month';
     	$this->daysPerPeriod = $this->getDaysPerPeriod();
	}

    function search($args=null)
    {
		$result = parent::search( $args);

		$firstDayMonth = $this->getFirstDayMonth($this->currentDate);
		$lastDayMonth = $this->getLastDayMonth($this->currentDate);
		
		unset($result['week']);		
		unset($result['weeks']);		
		for ( $i = 0; $i < 6 ; $i++ )
		{		
			$week = strtotime( '+'.$i.' week', $firstDayMonth);
				
			$firstDayWeek = $this->getFirstDayWeek($week);
			if( $firstDayWeek > $lastDayMonth )
				continue;

			$days = array();
			for ( $j = 0 ; $j < $this->daysPerWeek ; $j++ )
			{
				$day = strtotime( '+'.$j.' day', $firstDayWeek);

				$days[] = array( 
					'month'			=>	date('m', $day), 
					'day'			=>	$day, 
					'day_name' 		=>	lang(date('l', $day)), 
					'day_local' 	=>	lang(date('l', $day)).' '.$GLOBALS['appshore']->local->dateToLocal(date('Y-m-d', $day)), 
					'day_date' 		=>	date('Y-m-d', $day),
					'day_nbr' 		=>	date('j', $day));
			}

			$result['weeks'][] = array( 
				'week' 			=> 	lang(date('W', $week)),
				'days'			=>	$days);
		}
		
				
		$firstDayWeek = $this->getFirstDayWeek($this->currentDate);
		unset($result['week']);
		for ( $i = 0 ; $i < $this->daysPerWeek ; $i++ )
		{
			$day = strtotime( '+'.$i.' day', $firstDayWeek);

			$result['week'][] = array( 
				'day'			=>	$day, 
				'day_name' 		=>	lang(date('l', $day))
				);
		}		

		$result['grid']['month'] = date('m', $this->currentDate);	

		$alldayactivities = $this->getDayActivities($result['weeks'][0]['days'][0]['day'], $result['weeks'][count($result['weeks'])-1]['days'][$this->daysPerWeek-1]['day'], false);
		$activities = $this->getDayActivities($result['weeks'][0]['days'][0]['day'], $result['weeks'][count($result['weeks'])-1]['days'][$this->daysPerWeek-1]['day'], true);
		$result['activities'] = array_merge( (array)$alldayactivities, (array)$activities);
						 
		return $result;
    } 	  
   
    function getPeriodActivities($currentPeriod = null)
    {
    	if( $currentPeriod == null )
    		$currentPeriod = strtotime('now');
    		
		$currentDate = date('Y-m', $currentPeriod) ;  		
//messagebox( $currentDate, NOTICE);
   
    	$activities = getManyAssocArrays( 'select date(activity_start) as day, a.*, t.type_name from activities a left outer join activities_types t on t.type_id = a.type_id where date(activity_start) <= "'.$currentDate.'"'.
    		' and date(activity_end) >= "'.$currentDate.'"'.' and user_id in ("1") order by activity_start');

     	//$upcomings = $this->getUpcomingsActivities($currentPeriod);
     	
     	$result['activities'] = array_merge( (array)$day, (array)$upcomings);
     	
     	foreach( $result['activities'] as $key => $val)
     	{
     		$datetime = strtotime($val['activity_start']);
     		$result['activities'][$key]['fullweekday'] = lang(date('l', $datetime));
     		$result['activities'][$key]['fulldate'] = date('j F Y', $datetime);
     		if( $val['is_allday'] == 'N' )
      			$result['activities'][$key]['hoursminutes'] = date('G:i', $datetime);
     	}
     	
    	return $result;
    } 
    
	
    function getCurrentPeriod()
    {
		list($month, $year) = explode( " ", date('F Y', $this->currentDateTime));
		return lang($month).' '.$year;
    } 
    
    
	function getFirstDayMonth( $currentDate) 
	{
        return strtotime( date('Y-m', $currentDate).'-01 00:00:00');
 	}

    
	function getLastDayMonth( $currentDate) 
	{
        return strtotime( '-1 day', strtotime( '+1 month', $this->getFirstDayMonth($currentDate)));
	}
	
		    
    function getDaysPerPeriod()
    {    	
		$firstDayMonth = $this->getFirstDayMonth($this->currentDate);
		$lastDayMonth = $this->getLastDayMonth($this->currentDate);
		for ( $i = 0; $i < 6 ; $i++ )
		{		
			if( $this->getFirstDayWeek(strtotime( '+'.$i.' week', $firstDayMonth)) > $lastDayMonth )
				continue;
		}    
		
    	return ($i*$this->daysPerWeek);
    }  
    	
    
}
