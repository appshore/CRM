<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.dashboards.php');

class accounts_dashboards extends lib_dashboards
{

    function __construct()
    {
    	$this->appTable 		= 'accounts';
    	$this->appRecordId		= 'account_id';    	
    	$this->appRecordName	= 'account_name';    	
    	$this->appOrderBy		= 'account_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'accounts';
    	$this->appNameSingular	= 'account';    	
    	$this->appLabel 		= 'Accounts';
    	$this->appLabelSingular = 'Account';    
    	$this->appXSL 			= 'accounts.base';
    	$this->appRole 			= 'accounts';

		parent::__construct();
    }

}
