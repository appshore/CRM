<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.print.php');

class contacts_print extends lib_print{

    function __construct()
    {
    	$this->appTable 		= 'contacts';
    	$this->appRecordId		= 'contact_id';    	
    	$this->appRecordName	= 'last_name';    	
    	$this->appOrderBy		= 'last_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'contacts';
    	$this->appNameSingular	= 'contact';    	
    	$this->appLabel 		= 'Contacts';
    	$this->appLabelSingular = 'Contact';    
    	$this->appXSL 			= 'contacts.base';
    	$this->appRole 			= 'contacts';

    	// to allow list management from this app
		if ( $GLOBALS['appshore']->rbac->check('campaigns', RBAC_USER_WRITE ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'list');

        parent::__construct();    	
    }
}
