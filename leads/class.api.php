<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.api.php');

class leads_api extends lib_api 
{
    function __construct()
    {
    	$this->appTable 		= 'leads';
    	$this->appRecordId		= 'lead_id';    	
    	$this->appRecordName	= 'account_name';   
    	$this->appOrderBy		= 'account_name';    	
    	$this->appAscDesc		= 'asc';    	    	 	
    	$this->appName 			= 'leads';
    	$this->appNameSingular	= 'lead';    	
    	$this->appLabel 		= 'Leads';
    	$this->appLabelSingular = 'Lead';    
   		$this->appXSL 			= 'leads.base';
    	$this->appRole 			= 'leads';    	

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
