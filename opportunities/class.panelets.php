<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.panelets.php');

class opportunities_panelets extends lib_panelets
{
    function __construct()
    {
    	$this->appTable 		= 'opportunities';
    	$this->appRecordId		= 'opportunity_id';    	
    	$this->appRecordName	= 'opportunity_name';    	
    	$this->appOrderBy		= 'opportunity_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'opportunities';
    	$this->appNameSingular	= 'opportunity';    	
    	$this->appLabel 		= 'Opportunities';
    	$this->appLabelSingular = 'Opportunity';    
    	$this->appXSL 			= 'opportunities.base';
    	$this->appRole 			= 'opportunities';
    }    

	    
	function my_open_opportunities($args)
	{	
		if(	($result = getManyAssocArrays('SELECT * FROM opportunities '.$this->filter($args))) == null)
			return null;
					
#		foreach( $result as $key => $val )
#		{
#			$result[$key]['time'] = $GLOBALS['appshore']->local->timeToLocal($GLOBALS['appshore']->local->gmtToTZ($val['activity_start']));
#		}
		return $result;
	}    
  
}
