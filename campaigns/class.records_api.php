<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.api.php');

class campaigns_records_api extends lib_api {

    function __construct()
    {
    	$this->appTable 		= 'campaigns_records_view';
    	$this->appRecordId		= 'list_record_id';    	
    	$this->appRecordName	= 'record_name';    	
    	$this->appOrderBy		= 'record_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'campaigns_records';
    	$this->appNameSingular	= 'campaigns_record';    	
    	$this->appLabel 		= 'List Records';
    	$this->appLabelSingular = 'List Record';    
    	$this->appXSL	 		= 'campaigns.records_base';
    	$this->appRole 			= 'campaigns';

        parent::__construct();    	
    }
	
}
