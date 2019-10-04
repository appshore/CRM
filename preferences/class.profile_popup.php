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
require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class preferences_profile_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'users';
    	$this->appRecordId		= 'user_id';    	
    	$this->appRecordName	= 'full_name'; 
    	$this->appOrderBy		= 'full_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'preferences_profile';
    	$this->appNameSingular	= 'preferences_profile';    	
    	$this->appLabel 		= 'My information';
    	$this->appLabelSingular = 'My information';    
    	$this->appXSL	 		= 'preferences.profile';
    	$this->appRole 			= 'preferences';

        parent::__construct();    	
    }

}
