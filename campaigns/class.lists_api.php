<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class campaigns_lists_api {

    function __construct()
    {
    	$this->appTable 		= 'campaigns_lists';
    	$this->appRecordId		= 'list_id';    	
    	$this->appRecordName	= 'list_name';    	
    	$this->appOrderBy		= 'list_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'campaigns_lists';
    	$this->appNameSingular	= 'campaigns_list';    	
    	$this->appLabel 		= 'Lists';
    	$this->appLabelSingular = 'List';    
    	$this->appXSL	 		= 'campaigns.lists_base';
    	$this->appRole 			= 'campaigns';
  
        parent::__construct();    	
  }    
	
}
