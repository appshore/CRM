<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 - 2008 Brice MICHEL                                   *
 * \*************************************************************************
 */
 
require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class administration_departments_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'departments';
    	$this->appRecordId		= 'department_id';    	
    	$this->appRecordName	= 'department_name'; 
    	$this->appOrderBy		= 'department_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'administration_departments';
    	$this->appNameSingular	= 'administration_department';    	
    	$this->appLabel 		= 'Departments';
    	$this->appLabelSingular = 'Department';    
    	$this->appXSL	 		= 'administration.departments';
    	$this->appRole 			= 'administration';
    }

}
