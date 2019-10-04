<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class contacts_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'contacts';
    	$this->appRecordId		= 'contact_id';    	
    	$this->appRecordName	= 'full_name';    	
    	$this->appOrderBy		= 'full_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'contacts';
    	$this->appNameSingular	= 'contact';    	
    	$this->appLabel 		= 'Contacts';
    	$this->appLabelSingular = 'Contact';    
    	$this->appXSL 			= 'contacts.base';
    	$this->appRole 			= 'contacts';

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

    	// to allow list management from this app
		if ( $GLOBALS['appshore']->rbac->check('campaigns', RBAC_USER_WRITE ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'list');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

        parent::__construct();    	
    }
          
    // init some values when new Entry
    function newEntry(  $args = null, $entry = null)
    {
        $entry['email_opt_out'] = 'N';       	        	
        $entry['do_not_call'] = 'N';       	        	
               
        return parent::newEntry( $args, $entry);
    }    
       	
}
