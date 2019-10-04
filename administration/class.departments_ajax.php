<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */
require_once ( APPSHORE_LIB.SEP.'class.ajax.php');

class administration_departments_ajax extends lib_ajax
{

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

		parent::__construct();
    }

}
