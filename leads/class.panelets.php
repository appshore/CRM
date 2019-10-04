<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.panelets.php');

class leads_panelets extends lib_panelets
{
    function __construct()
    {
    	$this->appTable 		= 'leads';
    	$this->appRecordId		= 'lead_id';    	
    	$this->appRecordName	= 'account_name';   
    	$this->appOrderBy		= 'account_name';    	
    	$this->appAscDesc		= 'asc';    	    	 	
    	$this->appName 			= 'leads';
    	$this->appNameSingular	= 'lead';    	
    	$this->appLabel 		= 'Leads';
    	$this->appLabelSingular = 'Lead';    
   		$this->appXSL 			= 'leads.base';
    	$this->appRole 			= 'leads';    	
    }
	    
	function my_last_leads($args)
	{	
		if(	($result = getManyAssocArrays('SELECT * FROM leads '.$this->filter($args))) == null)
			return null;
					
#		foreach( $result as $key => $val )
#		{
#			$result[$key]['date'] = $GLOBALS['appshore']->local->dateToLocal($GLOBALS['appshore']->local->gmtToTZ($val['due_date']));
#		}
		return $result;
	}    
  
}
