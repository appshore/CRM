<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class administration_roles_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'roles';
    	$this->appRecordId		= 'role_id';    	
    	$this->appRecordName	= 'role_name';    	
    	$this->appOrderBy		= 'role_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'administration_roles';
    	$this->appNameSingular	= 'administration_role';    	
    	$this->appLabel 		= 'Roles';
    	$this->appLabelSingular = 'Role';    
    	$this->appXSL	 		= 'administration.roles';
    	$this->appRole 			= 'administration';
    }
    
}
