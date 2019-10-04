<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2007 Brice Michel                                     *
 ***************************************************************************/

// class contact extends export so requires it
require_once( APPSHORE_LIB . SEP . 'class.export.php');

class webmail_export extends lib_export {

    function __construct()
    {
        $this->appName = 'webmail';  
        $this->appRole = 'webmail';  
        $this->appRecordId = 'mail_id';  
    }    
}
