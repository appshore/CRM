<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.print.php');

class accounts_print extends lib_print
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

    	// to allow list management from this app
		if ( $GLOBALS['appshore']->rbac->check('campaigns', RBAC_USER_WRITE ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'list');

		parent::__construct();
    }
    
}
