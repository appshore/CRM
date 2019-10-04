<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.api.php');

class contacts_api extends lib_api
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

        parent::__construct();    	
    }
    
        // init some values when new Entry
    function newEntry(  $args = null, $entry = null)
    {
		// the special case of full_name which occurs very frequently
		$args['full_name'] = setFullname($args['first_names'],$args['last_name']);
		
        $entry['email_opt_out'] = 'N';       	        	
        $entry['do_not_call'] = 'N';       	        	
               
        return parent::newEntry( $args, $entry);
    }    
     

}
