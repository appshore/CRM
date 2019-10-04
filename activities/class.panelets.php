<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.panelets.php');

class activities_panelets extends lib_panelets
{
    function __construct()
    {
    	$this->appTable 		= 'activities';
    	$this->appRecordId		= 'activity_id';    	
    	$this->appRecordName	= 'subject';    	
    	$this->appOrderBy		= 'activity_start';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'activities';
    	$this->appNameSingular	= 'activity';    	
    	$this->appLabel 		= 'Activities';
    	$this->appLabelSingular = 'Activity';    
    	$this->appXSL 			= 'activities.base';
    	$this->appRole 			= 'activities';
    }
	    
	function my_upcoming_activities($args)
	{	
		if(	($result = getManyAssocArrays('SELECT * FROM activities '.$this->filter($args))) == null)
			return null;
					
		foreach( $result as $key => $val )
		{
			$result[$key]['time'] = $GLOBALS['appshore']->local->timeToLocal($GLOBALS['appshore']->local->gmtToTZ($val['activity_start']));
		}
		return $result;
	}    
  
}
