<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2007 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.export.php');

class notes_export extends lib_export {

    function __construct()
    {
        $this->appName = 'notes';  
        $this->appRole = 'notes';  
        $this->appRecordId = 'note_id';  
    }
  
}
