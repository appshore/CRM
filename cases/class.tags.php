<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

// class account extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.tags.php');

class cases_tags extends lib_tags 
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

        parent::__construct();    	
    }
      
}
