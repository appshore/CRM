<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.panelets.php');

class dailies_panelets extends lib_panelets
{
    function __construct()
    {
    	$this->appTable 		= 'dailies';
    	$this->appRecordId		= 'contact_id';    	
    	$this->appRecordName	= 'full_name'; 
    	$this->appWhereFilter	= '';    	
    	$this->appOrderBy		= 'full_name';    	
    	$this->appAscDesc		= 'asc';    	    	   	
    	$this->appName 			= 'dailies';
    	$this->appNameSingular	= 'daily';    	
    	$this->appLabel 		= 'Dailies';
    	$this->appLabelSingular = 'Daily';    
    	$this->appXSL 			= 'dailies.base';
    	$this->appRole 			= 'dailies';
    }    

	    
	function my_open_dailies($args)
	{	
		if(	($result = getManyAssocArrays('SELECT * FROM dailies '.$this->filter($args))) == null)
			return null;
					
#		foreach( $result as $key => $val )
#		{
#			$result[$key]['time'] = $GLOBALS['appshore']->local->timeToLocal($GLOBALS['appshore']->local->gmtToTZ($val['activity_start']));
#		}
		return $result;
	}    
  
}
