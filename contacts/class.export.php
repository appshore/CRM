<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2007 Brice Michel                                     *
 ***************************************************************************/

// class contact extends export so requires it
require_once( APPSHORE_LIB . SEP . 'class.export.php');

class contacts_export extends lib_export 
{

    function __construct()
    {
        $this->appName = 'contacts';  
        $this->appRole = 'contacts';  
        $this->appRecordId = 'contact_id';  
    }    
}
