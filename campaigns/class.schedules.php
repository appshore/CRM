<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class campaigns_schedules
{

    function __construct()
    {
    	$this->appTable 		= 'campaigns';
    	$this->appRecordId		= 'campaign_id';    	
    	$this->appRecordName	= 'subject';    	
    	$this->appOrderBy		= 'campaign_name';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'campaigns';
    	$this->appNameSingular	= 'campaign';    	
    	$this->appLabel 		= 'Campaigns';
    	$this->appLabelSingular = 'Campaign';    
    	$this->appXSL 			= 'campaigns.base';
    	$this->appRole 			= 'campaigns';	
    }

    function trigger()
    {
		$args = new safe_args();
		$args->set('schedule_id', NOTSET, 'sqlsafe');
		$args->set('record_id', NOTSET, 'sqlsafe');
		$args->set('type_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		exec('echo '.$args['schedule_id'].'  start >>/tmp/schedules');
		sleep(5);
		exec('echo '.$args['schedule_id'].'  stop >>/tmp/schedules');

 		return $result;
    }   
  
}
