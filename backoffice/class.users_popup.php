<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class backoffice_users_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'customers_users';
    	$this->appRecordId		= 'customers_user_id';    	
    	$this->appRecordName	= 'customers_user_name'; 
    	$this->appOrderBy		= 'customers_user_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'backoffice_users';
    	$this->appNameSingular	= 'backoffice_user';    	
    	$this->appLabel 		= 'Users';
    	$this->appLabelSingular = 'User';    
    	$this->appXSL 			= 'backoffice.users';
    	$this->appRole 			= 'backoffice';  

        parent::__construct();    	
     }
}
