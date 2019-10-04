<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.api.php');

class tags_records_api extends lib_api {

    function __construct()
    {
    	$this->appTable 		= 'tags_records_view';
    	$this->appRecordId		= 'record_id';    	
    	$this->appRecordName	= 'record_name';    	
    	$this->appOrderBy		= 'record_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'tags_records';
    	$this->appNameSingular	= 'tags_record';    	
    	$this->appLabel 		= 'List Records';
    	$this->appLabelSingular = 'List Record';    
    	$this->appXSL	 		= 'tags.records_base';
    	$this->appRole 			= 'tags';

        parent::__construct();    	
    }
	
}
