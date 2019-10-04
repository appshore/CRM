<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

// class account extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.dashboards.php');

class notes_dashboards extends lib_dashboards
{

    function __construct()
    {
    	$this->appTable 		= 'notes';
    	$this->appRecordId		= 'note_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appWhereFilter	= '';    	
    	$this->appOrderBy		= 'subject';    	
    	$this->appAscDesc		= 'asc';    	    	   	
    	$this->appName 			= 'notes';
    	$this->appNameSingular	= 'note';    	
    	$this->appLabel 		= 'Notes';
    	$this->appLabelSingular = 'Note';    
    	$this->appXSL	 		= 'lib.stub';		// to replace non existant 'notes.base';
    	$this->appRole 			= 'notes';

        parent::__construct();    	
    }
      
}
