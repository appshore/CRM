<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( 'class.base.php');

class activities_calendars extends activities_base
{
	var $tabs ;
	var $tab_id ;

	var $currentDateTime;
	var $currentDate;
	var $currentTime;
	var $firstDayWeek = 0 ; // user preference: Sunday = 0, Monday = 1
	var $daysPerWeek = 7 ; // user preference: 5, 6, or 7 days in the week
	var $daysPerPeriod = 1 ; // computed according calendar type 
	var $startHour = 28800 ; // user preference in secondes
	var $endHour = 64800 ; // user preference in secondes
	var $incHour = 1800 ; // user preference in secondes
		
    function __construct()
    {
		parent::__construct();

		$this->userPreferences();
		
		if( isset($_SESSION[$this->appName]['currentDateTime']) == false )
			$this->currentDateTime = strtotime('Today');
		else
			$this->currentDateTime = $_SESSION[$this->appName]['currentDateTime'];
			
		$this->currentDate = strtotime( date('Y-m-d', $this->currentDateTime));	
		$this->currentTime = strtotime( date('H:i', $this->currentDateTime));	
		
		// we don't want a screen foot
		$GLOBALS['appshore']->addNode( 'no_window_footer', 'no_window_footer');
    }
    
    function userPreferences()
    {
		$this->firstDayWeek = isset($_SESSION[$this->appName]['preferences']['first_day_week'])?$_SESSION[$this->appName]['preferences']['first_day_week']:1; // user preference: Sunday = 0, Monday = 1
		$this->daysPerWeek = $_SESSION[$this->appName]['preferences']['days_per_week']?$_SESSION[$this->appName]['preferences']['days_per_week']:7; // user preference: 5, 6, or 7 days in the week
		$this->daysPerPeriod = 1 ; // computed according calendar type 
		$this->startHour = $_SESSION[$this->appName]['preferences']['day_start_hour']?$_SESSION[$this->appName]['preferences']['day_start_hour']:28800; // user preference in secondes
		$this->endHour = $_SESSION[$this->appName]['preferences']['day_end_hour']?$_SESSION[$this->appName]['preferences']['day_end_hour']:64800; // user preference in secondes
		$this->incHour = $_SESSION[$this->appName]['preferences']['inc_hour']?$_SESSION[$this->appName]['preferences']['inc_hour']:1800; // user preference in secondes   
    }
    
    function menus()
    {  
        $GLOBALS['appshore']->add_xsl('activities.calendars'); 
        $GLOBALS['appshore']->add_xsl('activities.'.$this->tab_id); 
  		parent::menus(); 
    } 
         
    function search($args=null)
    {
		$result = parent::search($args);	
		
		switch($args['keytabs'])
		{
			case 'Previous':
				$this->currentDateTime = strtotime('-1 '.$this->tab_id, $this->currentDateTime); 
 				break;
			case 'Next':
				$this->currentDateTime = strtotime('+1 '.$this->tab_id, $this->currentDateTime); 
 				break;
			case 'Now':
				$this->currentDateTime = strtotime('today'); 
 				break;
 			default:
				$this->currentDateTime = $args['period'] ? strtotime($args['period']) : $this->currentDateTime; 
 				break;
		}

		$this->currentDate = strtotime( date('Y-m-d', $this->currentDateTime));	
		$this->currentTime = strtotime( date('H:i', $this->currentDateTime));	

		$_SESSION[$this->appName]['currentDateTime'] = $this->currentDateTime;
		$_SESSION[$this->appName]['current_period'] = $this->getCurrentPeriod();

		$result['grid']['days'] = $this->daysPerPeriod;
		$result['grid']['month'] = date('m', strtotime('Today'));		
		$result['grid']['today'] = strtotime('Today');			

		// define next action		
		$result['action'][$this->appName] = $_SESSION[$this->appName]['tab_id'];
		$result['tabs'] = $this->tabs;	

		// Put context in XML to be processed by XSL
		$result['recordset'] = $_SESSION[$this->appName];
		
		return $result;   
	}
	
   
	function grid( $args=null)
    {
 		$args = new safe_args();
		$args->set('key',	 NOTSET, 'any');
		$args->set('period', 'now', 'any');
		$args->set('is_allday', NOTSET, 'any');
		$args = $args->get(func_get_args());	

		switch($args['key'])
		{
			case 'Today':
				$this->currentDateTime = strtotime('now'); 
 				break;
 			default:
				$this->currentDateTime = strtotime( $args['period']); 
 				break;
		}
		
		if($args['is_allday'] == 'false' )
	        $GLOBALS['appshore']->add_xsl('activities.calendars_grid'); 
		 else
		 	$GLOBALS['appshore']->add_xsl('activities.calendars_alldaygrid'); 
        
 		$result['recordset'] = $_SESSION[$this->appName];

		$result['grid']['hours'] = $this->getHoursGrid();
		$result['grid']['minutes'] = $this->getMinutesGrid();
		$result['grid']['start_hour'] = $this->startHour;
		$result['grid']['end_hour'] = $this->endHour;
		$result['grid']['inc_hour'] = $this->incHour;
		$result['grid']['today'] = strtotime('today');			
		$result['grid']['days'] = $this->daysPerPeriod;
		$result['grid']['month'] = date('m', strtotime('today'));		
		
		$result['action'][$this->appName] = $this->tab_id;
		$GLOBALS['appshore_data']['layout'] = 'popup';
		return $result;
    } 	     	    

    function getDayActivities( $firstDay = null, $lastDay = null, $is_allday = false)
    {

    	if( $lastDay == null )
    		$lastDay = $firstDay;
 
    	//put in gmt time for mysql request
    	$gmtFirstDay = $GLOBALS['appshore']->local->TZToGmt(date('Y-m-d H:i:s',$firstDay));
	   	$gmtLastDay = $GLOBALS['appshore']->local->TZToGmt(date('Y-m-d H:i:s',$lastDay+86400)) ; // add one day when dates and times are equal

		// in case there is no user selected at all
		if( strpos( $_SESSION[$this->appName]['sql']['join'], 'users t1') === false )
			$sqll = 'select date(t0.activity_start) as day_date, t0.* from activities t0 ';
		else
			$sqll = 'select date(t0.activity_start) as day_date, t0.*, t1.full_name from activities t0 ';
		
		$sqll .= $_SESSION[$this->appName]['sql']['join']
			.( strpos($_SESSION[$this->appName]['sql']['where'],'WHERE') !== false  ? $_SESSION[$this->appName]['sql']['where'].' and ' : ' where ')
    		.' ( ( t0.activity_start < "'.$gmtFirstDay.'" and t0.activity_end > "'.$gmtFirstDay.'")
    			or ( t0.activity_start < "'.$gmtLastDay.'" and t0.activity_end > "'.$gmtLastDay.'")
    			or ( t0.activity_start >= "'.$gmtFirstDay.'" and t0.activity_end < "'.$gmtLastDay.'") )
    			order by t0.activity_start';

//echo( $sqll);

		
     	if( $activities = getManyAssocArrays( $sqll) )
    	{ 		
	    	foreach( $activities as $key => $val)
	    	{
				$start = strtotime($GLOBALS['appshore']->local->gmtToTZ( $val['activity_start']));
				$end = strtotime($GLOBALS['appshore']->local->gmtToTZ( $val['activity_end']));

				if( $is_allday == false )
				{
					if( (date('Y-m-d',$start) == date('Y-m-d',$end)) && ($val['is_allday'] != 'Y') )
		    			$result[] = $this->computeGridActivity( $val, $firstDay, $is_allday);
		    	}
				else if( ($val['is_allday'] == 'Y') || (date('Y-m-d',$start) != date('Y-m-d',$end)) )
		    		$result[] = $this->computeGridActivity( $val, $firstDay, $is_allday);
	    	}
    	
    		return $result;
	    }
	    
	    return null;
    } 
       

    function computeGridActivity( $activity, $firstDay, $is_allday = false)
    {
		// put back in local time for display purpose
		$start = strtotime($GLOBALS['appshore']->local->gmtToTZ( $activity['activity_start']));
		$end = strtotime($GLOBALS['appshore']->local->gmtToTZ( $activity['activity_end']));
		$activity['day'] = ( $start <= $firstDay ) ? $firstDay : strtotime(date( 'Y-m-d 00:00:00', $start));
#		$activity['activity_time'] = date('H:i', $start);
		$activity['activity_time'] = trim($GLOBALS['appshore']->local->timeToLocal(date('H:i', $start)));
		
		$startDay = ($start > $firstDay) ? $start : $firstDay;
		$activity['startDay'] = floor(($startDay-$firstDay)/86400);
		
		$nbrDays = ceil(($end-$startDay)/86400);
		$activity['nbrDays'] = (($activity['startDay']+$nbrDays) > $this->daysPerPeriod) ? $this->daysPerPeriod-$activity['startDay'] : $nbrDays;
			
		
		$activity['start'] = $start;
		$activity['end'] = $end;
		
//messagebox( $activity['day'].'  '.$activity['startDay'].'  '.$nbrDays.'  '.$activity['start'].'  '.$activity['end']);		
		
    	return $activity;
    } 	     	          

	function getFirstDayWeek( $currentDate) 
	{
		//$this->firstDayWeek is a user preference, default value is 0 = Sunday
        $i = 0;
        do
        {
            $first = strtotime('-'.$i++.' day', $currentDate);
        }   
        while( date('w', $first) != $this->firstDayWeek );                     

        return $first;
	}
   
	function getLastDayWeek( $currentDate) 
	{
		$days = $this->daysPerPeriod-1;
        return strtotime('+'.$days.' day', $this->getFirstDayWeek($currentDate));
	} 
	
    function getHoursGrid()
    {
  		for ( $i = 0 ; $i < 24 ; $i++ )
		{
			$hours[] = array( 
				'hour'			=>	($i*3600),
				'hour_name'		=>	$GLOBALS['appshore']->local->timeToLocal(sprintf( '%02d:00', $i))//sprintf( '%02d', $i)
				);
		}

		return $hours;
    }              

    function getMinutesGrid()
    {
 		$i = 0;
		while( $i < 3600 )
		{
			$minutes[] = array( 'minute' => $i);
			$i += $this->incHour;
		}

		return $minutes;
    }     
    
}
