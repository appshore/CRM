<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class administration_users_popup extends lib_popup{

    function __construct()
    {
   		$this->appTable 		= 'users';
    	$this->appRecordId		= 'user_id';    	
    	$this->appRecordName	= 'user_name'; 
    	$this->appOrderBy		= 'user_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'administration_users';
    	$this->appNameSingular	= 'administration_user';    	
    	$this->appLabel 		= 'Users';
    	$this->appLabelSingular = 'User';    
    	$this->appXSL	 		= 'administration.users';
    	$this->appRole 			= 'administration';
    }
}
