<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class contacts_popup extends lib_popup{

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

    	// to allow list management from this app
		if ( $GLOBALS['appshore']->rbac->check('campaigns', RBAC_USER_WRITE ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'list');

        parent::__construct();    	
    }
          
    // init some values when new Entry
    function newEntry(  $args = null, $entry = null)
    {
        $entry['email_opt_out'] = 'N';       	        	
        $entry['do_not_call'] = 'N';       	        	

        $entry['manager_id'] = $args['linked_recordIdValue'];
        unset($args['linked_recordIdValue']);
        unset($args['contact_id']);
               
        return parent::newEntry( $args, $entry);
    }    
       	
}
