<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.print.php');

class cases_print extends lib_print{

    function __construct()
    {
    	$this->appTable 		= 'cases';
    	$this->appRecordId		= 'case_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appOrderBy		= 'due_date';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'cases';
    	$this->appNameSingular	= 'case';    	
    	$this->appLabel 		= 'Cases';
    	$this->appLabelSingular = 'Case';    
    	$this->appXSL	 		= 'cases.base';
    	$this->appRole 			= 'cases';

        parent::__construct();    	
    }
 }
