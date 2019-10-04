<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once( 'class.base.php');

class forecasts_dashboards extends forecasts_base
{
    function __construct()
    {    	

		if (!isset($_SESSION['forecasts']))
		{
			// init some default value for filter criterias
			$this->setMonthlySession();
			$this->setQuarterlySession();
			$this->setYearlySession();
		}
	        
        $GLOBALS['appshore']->add_xsl('forecasts.base');
        $GLOBALS['appshore']->add_xsl('forecasts.chart');
	}	  
	
	function yearly()
    {
		$args = new safe_args();
		$args->set('scope', NOTSET, 'any');
		$args = $args->get(func_get_args());	

		if( $args['scope'] == 'user' )
			$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

		return parent::yearly( $args);
    }   
    
}
