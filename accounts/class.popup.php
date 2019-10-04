<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class accounts_popup extends lib_popup{

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
    
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
        $entry['account_top_id'] = $args['linked_recordIdValue'];
        unset($args['linked_recordIdValue']);
        unset($args['account_id']);

        return parent::newEntry( $args, $entry);
    }
              
             	
}
