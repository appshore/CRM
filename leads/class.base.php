<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class leads_base extends lib_base
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
   
    function menus()
    {
		parent::menus();   
		$GLOBALS['appshore']->add_appmenu($this->appName, 'Capture '.strtolower($this->appLabel), $this->appName.'.base.capture');
    }
    
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
        $entry['email_opt_out'] = 'N';       	        	
        $entry['do_not_call'] = 'N';       	        	
        
        return parent::newEntry( $args, $entry);
    }

    function view( $args = null)
    {
		switch($args['key'])
		{
			case 'Convert':
				return $this->convert( $args);
				break;
			default:	// else we call the parent class
	    		$result = parent::view( $args); 
	    		break;
	    }

		if( $args['key'] != 'Edit' )
   			$GLOBALS['appshore']->addPlugins('ViewButtons');

        return $result;
    }  	
    
    function edit( $args = null)
    {
		switch($args['key'])
		{
			case 'Convert': // init the convertion
				$result = $this->convert( $args);
				break;
			default:	// else we call the parent class
	    		$result = parent::edit( $args); 
	    		break;
	    }

		if( $args['key'] != 'Cancel' && $result['lead']['lead_id'])
   			$GLOBALS['appshore']->addPlugins('EditButtons');

        return $result;
    }  		
	
	// convert an existing lead in an account and a contact
    function convert( $args)
    {		

		switch( $args['key']  )
		{
			case 'ConvertAC':
				// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
				if ( !$GLOBALS['appshore']->rbac->check('leads', RBAC_USER_WRITE ) ||
					!$GLOBALS['appshore']->rbac->check('accounts', RBAC_USER_WRITE ) ||
					!$GLOBALS['appshore']->rbac->check('contacts', RBAC_USER_WRITE ))
			    {
					$args['key'] = 'Error';
			        $error = ERROR_PERMISSION_WRITE_DENIED;
			    }
				elseif (  $args['lead_id'] && !$GLOBALS['appshore']->rbac->checkDataPermissions('leads', 'leads', 'lead_id', $args['lead_id'] )	)
			    {
					$args['key'] = 'Error';
			        $error = ERROR_PERMISSION_DENIED;
			    }
				$result = $this->convertAC($args);
				break;
			
			case 'ConvertA':
				// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
				if ( !$GLOBALS['appshore']->rbac->check('leads', RBAC_USER_WRITE ) || !$GLOBALS['appshore']->rbac->check('accounts', RBAC_USER_WRITE ))
			    {
					$args['key'] = 'Error';
			        $error = ERROR_PERMISSION_WRITE_DENIED;
			    }
				elseif (  $args['lead_id'] && !$GLOBALS['appshore']->rbac->checkDataPermissions('leads', 'leads', 'lead_id', $args['lead_id'] )	)
			    {
					$args['key'] = 'Error';
			        $error = ERROR_PERMISSION_DENIED;
			    }
				$result = $this->convertA($args);
				break;

			case 'ConvertC':
				// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
				if ( !$GLOBALS['appshore']->rbac->check('leads', RBAC_USER_WRITE ) || !$GLOBALS['appshore']->rbac->check('contacts', RBAC_USER_WRITE ))
			    {
					$args['key'] = 'Error';
			        $error = ERROR_PERMISSION_WRITE_DENIED;
			    }
				elseif (  $args['lead_id'] && !$GLOBALS['appshore']->rbac->checkDataPermissions('leads', 'leads', 'lead_id', $args['lead_id'] )	)
			    {
					$args['key'] = 'Error';
			        $error = ERROR_PERMISSION_DENIED;
			    }
				$result = $this->convertC($args);
				break;
		}

		if( $args['key'] == 'Cancel' )
			$result = $this->view($args);
		elseif( $args['key'] == 'Convert' || $result['error'] )
		{
			$result = parent::edit($args);
    		$result['action'][$this->appName] = 'convert';    
			// we remove this xsl lib to use the specific one
   			$GLOBALS['appshore']->remove_xsl('lib.custom');
   		}
		               
		return $result;	
	}

    function convertAC( $args)
    {		
    
		$args['full_name'] = setFullname($args['first_names'],$args['last_name']);
		$args['address_billing'] = $args['address_1'];
		$args['zipcode_billing'] = $args['zipcode_1'];
		$args['city_billing'] = $args['city_1'];
		$args['state_billing'] = $args['state_1'];
		$args['country_billing'] = $args['country_1'];					
		$args['address_shipping'] = $args['address_2'];
		$args['zipcode_shipping'] = $args['zipcode_2'];
		$args['city_shipping'] = $args['city_2'];
		$args['state_shipping'] = $args['state_2'];
		$args['country_shipping'] = $args['country_2'];	
		
		// for Contacts: set of default source in case no account name				
		$source_id = $args['lead_id'];
		$source_table = 'leads';
		
		$isaccount = 'no';												
		if( $args['account_name'] )
		{
			$account = getOneAssocArray('select account_id from accounts where account_name = "'.$args['account_name'].'" and user_id = "'.$args['user_id'].'"');
			
			if ( isset($account['account_id']) == true )
			{
				messagebox('Lead not converted, an account exists with the same name', ERROR);
	            $result['error']['account_name'] = ERROR_UNIQUE_FIELD;																				
                $result['lead'] = $args;
                $isaccount = 'error';				
			}
			else
			{
				$args['account_id'] = insertRow('accounts', 'account_id', $args, false);
				$isaccount = 'one';	
				
				// replace the lead record id by the account record id in the links table
				executeSQL('update links set from_table = "accounts", from_id = "'.$args['account_id'].'" where from_id = "'.$args['lead_id'].'" and from_table = "leads"');
				executeSQL('update links set to_table = "accounts", to_id = "'.$args['account_id'].'" where to_id = "'.$args['lead_id'].'" and to_table = "leads"');
					
				// For the activities linked to the account, set the account_id to this account Id if not already filled up	
				$record_ids = getOneColManyRows(
					'select to_id from links where to_table = "activities" and from_table = "accounts" and from_id = "'.$args['account_id'].'" '.
					'union '.
					'select from_id from links where from_table = "activities" and to_table = "accounts" and to_id = "'.$args['account_id'].'"');							
				executeSQL('update activities set account_id = "'.$args['account_id'].
					'" where account_id in ("","0") and activity_id in ("'.implode($record_ids,'","').'")');
											
				// For the cases linked to the account, set the account_id to this account Id if not already filled up	
				$record_ids = getOneColManyRows(
					'select to_id from links where to_table = "cases" and from_table = "accounts" and from_id = "'.$args['account_id'].'" '.
					'union '.
					'select from_id from links where from_table = "cases" and to_table = "accounts" and to_id = "'.$args['account_id'].'"');
				executeSQL('update cases set account_id = "'.$args['account_id'].
					'" where account_id in ("","0") and case_id in ("'.implode($record_ids,'","').'")');
		
				// for Contacts: we set new values since account exists				
				$source_id = $args['account_id'];
				$source_table = 'accounts';
			}					
		}

		$iscontact = 'no';
		if( $args['last_name'] && $isaccount != 'error' )	
		{			
			$contact_id = insertRow('contacts', 'contact_id', $args, false);
			$iscontact = 'one';						
				
			// create links between contact and the records linked previously to the lead
			executeSQL('insert into links ( from_table, from_id, to_table, to_id) SELECT "contacts", "'.
				$contact_id.'", to_table, to_id FROM links WHERE from_id = "'.$source_id.'" and from_table = "'.$source_table.'"');
			executeSQL('insert into links ( to_table, to_id, from_table, from_id) SELECT "contacts", "'.
				$contact_id.'", from_table, from_id FROM links WHERE to_id = "'.$source_id.'" and to_table = "'.$source_table.'"');

			// For the activities linked to the contact, set the contact_id to this contact Id if not already filled up	
			executeSQL('update activities set contact_id = "'.$contact_id.'" where contact_id in ("","0") and activity_id in ('.
				'select to_id from links where to_table = "activities" and from_table = "contacts" and from_id = "'.$contact_id.
				'" union '.
				'select from_id from links where from_table = "activities" and to_table = "contacts" and to_id = "'.$contact_id.

				'")');										

			// For the cases linked to the contact, set the contact_id to this contact Id if not already filled up	
			executeSQL('update cases set contact_id = "'.$contact_id.'" where contact_id in ("","0") and case_id in ('.
				'select to_id from links where to_table = "cases" and from_table = "contacts" and from_id = "'.$contact_id.
				'" union '.
				'select from_id from links where from_table = "cases" and to_table = "contacts" and to_id = "'.$contact_id.
				'")');										
		}					
				
		if( $isaccount == 'one' || $iscontact == 'one' )
		{	
			deleteRow('leads', 'lead_id', $args, false);
			messagebox( lang('Lead successfully converted, %(isaccount)s account created, %(iscontact)s contact created', 
				array('isaccount' => $isaccount, 'iscontact' => $iscontact)));									
			return $this->search();
		}
		else if( $isaccount != 'error' )
		{
			messagebox('Lead not converted, the fields Account or Last name must contain data', ERROR);														
		}
		       
		return $result;   
    }   
    
    function convertA( $args)
    {		
    
		$args['full_name'] = setFullname($args['first_names'],$args['last_name']);
		$args['address_billing'] = $args['address_1'];
		$args['zipcode_billing'] = $args['zipcode_1'];
		$args['city_billing'] = $args['city_1'];
		$args['state_billing'] = $args['state_1'];
		$args['country_billing'] = $args['country_1'];					
		$args['address_shipping'] = $args['address_2'];
		$args['zipcode_shipping'] = $args['zipcode_2'];
		$args['city_shipping'] = $args['city_2'];
		$args['state_shipping'] = $args['state_2'];
		$args['country_shipping'] = $args['country_2'];	
		
		$isaccount = 'no';												
		if( $args['account_name'] )
		{
			$account = getOneAssocArray('select account_id from accounts where account_name = "'.$args['account_name'].'" and user_id = "'.$args['user_id'].'"');
			
			if ( isset($account['account_id']) == true )
			{
				messagebox('Lead not converted, an account exists with the same name', ERROR);
	            $result['error']['account_name'] = ERROR_UNIQUE_FIELD;																				
                $result['lead'] = $args;
                $isaccount = 'error';				
			}
			else
			{
				$args['account_id'] = insertRow('accounts', 'account_id', $args, false);
				$isaccount = 'one';	
				
				// replace the lead record id by the account record id in the links table
				executeSQL('update links set from_table = "accounts", from_id = "'.$args['account_id'].'" where from_id = "'.$args['lead_id'].'" and from_table = "leads"');
				executeSQL('update links set to_table = "accounts", to_id = "'.$args['account_id'].'" where to_id = "'.$args['lead_id'].'" and to_table = "leads"');
					
				// For the activities linked to the account, set the account_id to this account Id if not already filled up	
				$record_ids = getOneColManyRows(
					'select to_id from links where to_table = "activities" and from_table = "accounts" and from_id = "'.$args['account_id'].'" '.
					'union '.
					'select from_id from links where from_table = "activities" and to_table = "accounts" and to_id = "'.$args['account_id'].'"');							
				executeSQL('update activities set account_id = "'.$args['account_id'].
					'" where account_id in ("","0") and activity_id in ("'.implode($record_ids,'","').'")');
											
				// For the cases linked to the account, set the account_id to this account Id if not already filled up	
				$record_ids = getOneColManyRows(
					'select to_id from links where to_table = "cases" and from_table = "accounts" and from_id = "'.$args['account_id'].'" '.
					'union '.
					'select from_id from links where from_table = "cases" and to_table = "accounts" and to_id = "'.$args['account_id'].'"');
				executeSQL('update cases set account_id = "'.$args['account_id'].
					'" where account_id in ("","0") and case_id in ("'.implode($record_ids,'","').'")');
		
			}					
		}
				
		if( $isaccount == 'one' )
		{	
			deleteRow('leads', 'lead_id', $args, false);
			messagebox('Lead successfully converted, one account created');
			return $this->search();
		}
		else if( $isaccount != 'error' )
		{
			messagebox('Lead not converted, the fields Account or Last name must contain data', ERROR);														
		}
		
		return $result;   
    }   
        		
    function convertC( $args)
    {		
    
		$args['full_name'] = setFullname($args['first_names'],$args['last_name']);		
		// for Contacts: set of default source in case no account name				
		$source_id = $args['lead_id'];
		$source_table = 'leads';
		
		$account_id = getOneColOneRow('select account_id from accounts where account_name = "'.$args['account_name'].'" and user_id = "'.$args['user_id'].'"');
		
		if ( isset($account_id) == true )
			$args['account_id'] = $account_id;
				
		$iscontact = 'no';
		if( $args['last_name'] )	
		{			
			$contact_id = insertRow('contacts', 'contact_id', $args, false);
			$iscontact = 'one';						
				
			// create links between contact and the records linked previously to the lead
			executeSQL('insert into links ( from_table, from_id, to_table, to_id) SELECT "contacts", "'.
				$contact_id.'", to_table, to_id FROM links WHERE from_id = "'.$source_id.'" and from_table = "'.$source_table.'"');
			executeSQL('insert into links ( to_table, to_id, from_table, from_id) SELECT "contacts", "'.
				$contact_id.'", from_table, from_id FROM links WHERE to_id = "'.$source_id.'" and to_table = "'.$source_table.'"');

			// For the activities linked to the contact, set the contact_id to this contact Id if not already filled up	
			executeSQL('update activities set contact_id = "'.$contact_id.'" where contact_id in ("","0") and activity_id in ('.
				'select to_id from links where to_table = "activities" and from_table = "contacts" and from_id = "'.$contact_id.
				'" union '.
				'select from_id from links where from_table = "activities" and to_table = "contacts" and to_id = "'.$contact_id.
				'")');										

			// For the cases linked to the contact, set the contact_id to this contact Id if not already filled up	
			executeSQL('update cases set contact_id = "'.$contact_id.'" where contact_id in ("","0") and case_id in ('.
				'select to_id from links where to_table = "cases" and from_table = "contacts" and from_id = "'.$contact_id.
				'" union '.
				'select from_id from links where from_table = "cases" and to_table = "contacts" and to_id = "'.$contact_id.
				'")');										
		}					
				
		if( $iscontact == 'one' )
		{	
			deleteRow('leads', 'lead_id', $args, false);
			messagebox('Lead successfully converted, one contact created');
			return $this->search();
		}
		               
		return $result;   
    }   

    function capture()
    {
		$result['action'][$this->appName] = 'capture';
		$result['recordset'] = $_SESSION[$this->appName];			
   		$GLOBALS['appshore']->add_xsl('leads.capture');
		// set the needed XSL files for presentation
        $GLOBALS['appshore']->add_xsl($this->appXSL);
        $GLOBALS['appshore']->add_xsl('lib.base'); 
        
        // build the menus        
        $this->menus();    
		
        return $result;
    } 	    	
  	
}
