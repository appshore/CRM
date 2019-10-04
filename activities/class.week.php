<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( 'class.calendars.php');

class activities_week extends activities_calendars 
{

   function __construct()
    {
		parent::__construct();
     	$_SESSION[$this->appName]['tab_id'] = $this->tab_id = 'week';
     	$this->daysPerPeriod = $this->getDaysPerPeriod();
	}

    function search($args=null)
    {
		$result = parent::search( $args);

		$first = $this->getFirstDayWeek($this->currentDate);

		unset($result['week']);
		for ( $i = 0 ; $i < $this->daysPerPeriod ; $i++ )
		{
			$day = strtotime( '+'.$i.' day', $first);

			$result['week'][] = array( 
				'day'			=>	$day, 
				'day_name' 		=>	lang(date('l', $day)), 
				'day_local' 	=>	lang(date('l', $day)).' '.date('d', $day), 
				'day_date' 		=>	date('Y-m-d', $day));
		}
				 			
		return $result;
    } 
    
    
    function grid( $args=null)
    {
		$result = parent::grid( $args);
		
		$first = $this->getFirstDayWeek($this->currentDate);
    	$last = $this->getLastDayWeek($this->currentDate);

		for ( $i = 0 ; $i < $this->daysPerWeek ; $i++ )
		{
			$day = strtotime( '+'.$i.' day', $first);

			$result['week'][] = array( 
				'day'			=>	$day, 
				'day_name' 		=>	lang(date('l', $day)), 
				'day_local' 	=>	lang(date('l', $day)).' '.date('d', $day), 
				'day_date' 		=>	date('Y-m-d', $day));
		}
				 
		$result['activities'] = $this->getDayActivities($first, $last, $args['is_allday']=='true'?true:false);
		
		return $result;
    } 	     	   
    
    function getCurrentPeriod()
    {    	
    	$first = $this->getFirstDayWeek($this->currentDate);
    	$last = $this->getLastDayWeek($this->currentDate);
    	
		list($day1, $month1, $year1) = explode( " ", date('j F Y', $first));
		list($day2, $month2, $year2) = explode( " ", date('j F Y', $last));

    	if( date('Y', $first) != date('Y', $last) )
			$period = $day1.' '.lang($month1).' '.$year1.' - '.$day2.' '.lang($month2).' '.$year2;
    	else if( date('n', $first) != date('n', $last) )
			$period = $day1.' '.lang($month1).' - '.$day2.' '.lang($month2).' '.$year2;
    	else
			$period = $day1.' - '.$day2.' '.lang($month2).' '.$year2;
			
		return $period.', '.lang('Week').' '.date('W', $this->currentDate);
    } 
    
    function getDaysPerPeriod()
    {    	
    	return $this->daysPerWeek;
    }            
	
}
