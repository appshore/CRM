<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

// class daily extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.import.php');

class dailies_import extends lib_import {

    function __construct()
    {
		// we call the parent class
   		parent::__construct();  
   		      
    }

}
