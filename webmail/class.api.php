<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/


// class account extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.api.php');

class webmail_api extends lib_api {

    function __construct()
    {
    	$this->appTable 		= 'webmail';
    	$this->appRecordId		= 'mail_id';    	
    	$this->appRecordName	= 'subject';    	
    	$this->appOrderBy		= 'mail_date';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'webmail';
    	$this->appNameSingular	= 'mail';    	
    	$this->appLabel 		= 'Webmail';
    	$this->appLabelSingular = 'Email';    
    	$this->appXSL 			= 'webmail.base';
    	$this->appRole 			= 'webmail';

        parent::__construct();    	
    }

}
