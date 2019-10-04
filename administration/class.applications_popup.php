<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class administration_applications_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'db_applications';
    	$this->appRecordId		= 'app_name';    	
    	$this->appRecordName	= 'app_label'; 
    	$this->appOrderBy		= 'app_label';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'administration_applications';
    	$this->appNameSingular	= 'administration_application';    	
    	$this->appLabel 		= 'Applications';
    	$this->appLabelSingular = 'Application';    
    	$this->appXSL	 		= 'administration.applications';
    	$this->appRole 			= 'administration';

		parent::__construct();
    }

   
}
