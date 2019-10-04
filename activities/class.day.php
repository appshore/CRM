<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( 'class.calendars.php');

class activities_day extends activities_calendars
{

   function __construct()
    {
		parent::__construct();
     	$_SESSION[$this->appName]['tab_id'] = $this->tab_id = 'day';
     	$this->daysPerPeriod = $this->getDaysPerPeriod();
	}
	
    function grid($args=null)
    {
		$result = parent::grid( $args);

		$result['week'][0] = array( 
			'day'			=>	$this->currentDate, 
			'day_name' 		=>	date('l', $this->currentDate), 
			'day_local' 	=>	$GLOBALS['appshore']->local->dateToLocal($this->currentDate), 
			'day_date' 		=>	date('Y-m-d', $this->currentDate));
		
		$result['activities'] = $this->getDayActivities($result['week'][0]['day'], $result['week'][$this->daysPerPeriod-1]['day'],  $args['is_allday']=='true'?true:false);

		return $result;
    } 	     	      
    
	
    function getCurrentPeriod()
    {
		list($weekday, $day, $month, $year) = explode( " ", date('l j F Y', $this->currentDateTime));
		return lang($weekday).', '.$day.' '.lang($month).' '.$year;
    } 
    
    
    function getDaysPerPeriod()
    {    	
    	return 1;
    }       
        	    
}
