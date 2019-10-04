<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2007 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.export.php');

class leads_export extends lib_export {

    function __construct()
    {
        $this->appName = 'leads';  
        $this->appRole = 'leads';  
        $this->appRecordId = 'lead_id';  
    }  
}
