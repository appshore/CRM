<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.panelets.php');

class cases_panelets extends lib_panelets
{
    function __construct()
    {
    	$this->appTable 		= 'cases';
    	$this->appRecordId		= 'case_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appWhereFilter	= '';    	
    	$this->appOrderBy		= 'subject';    	
    	$this->appAscDesc		= 'asc';    	    	   	
    	$this->appName 			= 'cases';
    	$this->appNameSingular	= 'case';    	
    	$this->appLabel 		= 'Cases';
    	$this->appLabelSingular = 'Case';    
    	$this->appXSL	 		= 'lib.stub';		// to replace non existant 'cases.base';
    	$this->appRole 			= 'cases';
    }
	    
	function my_open_cases($args)
	{	
		if(	($result = getManyAssocArrays('SELECT * FROM cases '.$this->filter($args))) == null)
			return null;
					
		foreach( $result as $key => $val )
		{
			$result[$key]['date'] = $GLOBALS['appshore']->local->dateToLocal($GLOBALS['appshore']->local->gmtToTZ($val['due_date']));
		}
		return $result;
	}    
  
}
