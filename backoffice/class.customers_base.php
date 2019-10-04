<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');
require_once ( 'lib.'.PRIVATE_LABEL.'customers.php');

class backoffice_customers_base extends lib_base{

    function __construct()
    {
    	$this->appTable 		= 'customers';
    	$this->appRecordId		= 'company_id';    	
    	$this->appRecordName	= 'company_alias';    	
    	$this->appOrderBy		= 'created';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'backoffice_customers';
    	$this->appNameSingular	= 'backoffice_customer';    	
    	$this->appLabel 		= 'Customers';
    	$this->appLabelSingular = 'Customer';    
    	$this->appXSL 			= 'backoffice.customers';
    	$this->appRole 			= 'backoffice';  

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');
  	
    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

        parent::__construct();    	
    }
    
   
    function menus()
    {
		execMethod('backoffice.base.menus');
    } 
    
    
	function search( $args = null)
    {
		$result = parent::search( $args);	

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');

    	// to allow list management from the search form
		if ( $GLOBALS['appshore']->rbac->check('campaigns', RBAC_USER_WRITE ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'list');

		// to allow export from the search form
		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');
		
		return $result;
	}       
           
    function view( $args = null)
    {
		switch($args['key'])
		{
			case 'Setup': // Setup the instance
				execMethod( 'backoffice.customers.createInstance', $args);
	    		break;
	    		
			case 'Delete': // Delete the instance
				if( execMethod( 'backoffice.customers.deleteInstance', $args) == false )
					unset($args['key']); // so this won't delete the company record in table customers in case of failure to delete the instance
				break;
	    }

  		$result = parent::view( $args); 
  		
		// the default drop down company_status is forced in a readonly field when the instance is not yet created
		if( $args['key'] != 'Edit' && execMethod( 'backoffice.customers.checkInstance',  $args) == false )
		{
			$result['view_fields'] = $this->setField( $result['view_fields'], 'company_status', array( 'field_type' => 'TE','field_current_value' => 'Instance not created'));
			
			if( $result[$this->appNameSingular][$this->appRecordId])
   				$GLOBALS['appshore']->addPlugins( 'ViewButtons'); // Display a setup button to create the instance
   		}

		$result['view_fields'] = $this->setField( $result['view_fields'], 'agent_id', array( 'is_readonly' => 'Y','is_mandatory' => 'N'));		
    		
   		// deactivate write permission on this linked app
   		if( $result['linked']['backoffice_users']['linked_scope'] )
	   		$result['linked']['backoffice_users']['linked_scope'] = $result['linked']['backoffice_users']['scope'] = 0;
   		
        return $result;
    }	
        
    function edit( $args = null)
    {
		if( ($isInstance = execMethod( 'backoffice.customers.checkInstance', $args)) == false )
			$args['company_status']	= 'REG';

		switch($args['key'])
		{
			case 'Setup':
				$isInstance = execMethod( 'backoffice.customers.createInstance', $args);
				$this->sendMail( $args['company_id'], 'create');
				break;
	    		
			case 'Delete': // Delete the instance
				if( execMethod( 'backoffice.customers.deleteInstance', $args) == false )
					unset($args['key']); // so this won't delete the company record in table customers in case of failure to delete the instance
				else
					$isInstance = false ;
				$this->sendMail( $args['company_id'], 'delete');
				break;
			
			case 'Save': 
				$company = getOneAssocArray( 'select * from customers where company_id = "'.$args['company_id'].'"');	

				if( $company['edition_id'] != $args['edition_id'] )
				{
					$args['emails_quota'] = '0';
					$args['records_quota'] = '0';
				}

				if( $args['tempwd'] != '' )
				{
					$args['tempwd'] = md5($args['tempwd']);
				}
				
				
				if( $company['user_name'] != $args['user_name'] )
				{
					$user = getOneAssocArray( 'select * from customers_users where company_id = "'.$args['company_id'].
						'" and customers_user_name = "'.$args['user_name'].'"');	
					// for each of these fields if not been manually changed we updated it
					if( $company['first_names'] == $args['first_names'] )
						$args['first_names'] = $user['first_names'];
					if( $company['last_name'] == $args['last_name'] )
						$args['last_name'] = $user['last_name'];
					if( $company['phone'] == $args['phone'] )
						$args['phone'] = $user['phone'];
					if( $company['title'] == $args['title'] )
						$args['title'] = $user['title'];
					if( $company['email'] == $args['email'] )
						$args['email'] = $user['email'];
				}
				
								
				if( in_array( $args['company_status'], array( 'CLO', 'INT')) )
					$args['subscription_amount'] = 0;
				
				
				if( in_array( $args['edition_id'], array( 'PRO', 'PRE', 'TRIAL')) )
				{
					$args['disk_quota'] = getInstanceQuota('disk', $args['users_quota'], $args['edition_id']);
					
					if( in_array( $args['records_quota'], array( '0', '')) || $company['users_quota'] != $args['users_quota'] )
						$args['records_quota'] =  getInstanceQuota('records', $args['users_quota'], $args['edition_id']);
						
					if( in_array( $args['emails_quota'], array( '0', '')) || $company['users_quota'] != $args['users_quota'] )
						$args['emails_quota'] =  getInstanceQuota('emails', $args['users_quota'], $args['edition_id']);
				}
				else
				{
					$edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$args['edition_id'].'"');	
					$args['users_quota'] = $edition['users_quota'];
					$args['disk_quota'] = $edition['disk_quota'];
					$args['records_quota'] =  $edition['records_quota'];
					$args['emails_quota'] =  $edition['emails_quota'];
					$args['subscription_metric_id'] = $edition['metric_id'];
					$args['subscription_price'] = $edition['price'];
				}
								    
				if( $args['subscription_metric_id'] == 'USER' )
					$args['subscription_amount'] = $args['subscription_price'] * $args['users_quota'];
				else
					$args['subscription_amount'] = $args['subscription_price'];
					
				switch( $args['subscription_period_id'] )
				{
					case 'QUARTER':
						$args['subscription_amount'] *= 3; 
						break;
					case 'SEMESTER':
						$args['subscription_amount'] = round(($args['subscription_amount']*6)*0.95);
						break; 
					case 'YEAR':
						$args['subscription_amount'] = round(($args['subscription_amount']*12)*0.9);
						break; 
				}	
			    break;
	    }

		// run the standard edit fct
   		$result = parent::edit( $args); 

		if( $result[$this->appNameSingular][$this->appRecordId] )
			$args[$this->appRecordId] = $result[$this->appNameSingular][$this->appRecordId];
		
		if( $args[$this->appRecordId] && $args['key'] == 'Save' && $result['Error'] == null && $isInstance == true )
		{
			execMethod('backoffice.customers.updateInstance', $args);

			// new welcome email imply, new password as well so no need to reset also
			$reset['company_alias'] = $result[$this->appNameSingular]['company_alias'];
			$reset['email'] = $result[$this->appNameSingular]['email'];
			if( $args['send_welcome_email'] == 'Y' )
			{
				$reset['mode'] = 'CREATION';			
				execMethod('backoffice.users.resetPassword', $reset);
			}
			else if( $args['reset_password'] == 'Y' )
			{
				$reset['mode'] = 'RESET';			
				execMethod('backoffice.users.resetPassword', $reset);
			}
		}

		// We can only send an email once the instance has been set up
		if( $isInstance == false )
		{
			$result['edit_fields'] = $this->setField( $result['edit_fields'], 'send_welcome_email', array( 'is_readonly' => 'Y'));		
			$result['edit_fields'] = $this->setField( $result['edit_fields'], 'reset_password', array( 'is_readonly' => 'Y'));		

			// the default drop down company_status is forced in a readonly field when the instance is not yet created
			if( $args['key'] != 'Cancel' )
			{
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'company_status', array( 'field_type' => 'TE','field_current_value' => 'Instance not created','is_readonly' => 'Y','is_mandatory' => 'N'));		
	 			
				if( $result[$this->appNameSingular][$this->appRecordId] )
	 	 			$GLOBALS['appshore']->addPlugins('EditButtons'); // Display a setup button to create the instance
	  		}
		}
		else
		{
			// update of users list for the instance
			execMethod('backoffice.users.retrieveUsers', $args);
			
			// we grab users list for this customer if null we retrieve from the instance
			$customers_users = getManyAssocArrays('select customers_user_name as option_id, concat(customers_user_name," - ", full_name) as option_name from customers_users where company_id = "'.$args['company_id'].'"');			
			if( $customers_users )
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'user_name', array( 
					'field_type' 		=>	'DD',
					'field_options' 	=>	$customers_users
					));		

			$result['edit_fields'] = $this->setField( $result['edit_fields'], 'company_status', array( 
				'field_type' 		=>	'DD',
				'field_options' 	=>	array( array( 'option_id' => 'ACT', 'option_name' => 'Activated'), array( 'option_id' => 'CLO', 'option_name' => 'Closed'))
				));		


			// retrieve the main user
			$user = getOneAssocArray( 'select * from customers_users where company_id = "'.$args['company_id'].'" and customers_user_name = "'.$result[$this->appNameSingular]['user_name'].'"');	
			// for each of these fields if not been manually changed we updated it
			if( $user )
			{
				if( $result[$this->appNameSingular]['first_names'] != $user['first_names'] )
					$result['edit_fields'] = $this->setField( $result['edit_fields'], 'first_names', array( 'field_current_value' => $user['first_names']));
				if( $result[$this->appNameSingular]['last_name'] != $user['last_name'] )
					$result['edit_fields'] = $this->setField( $result['edit_fields'], 'last_name', array( 'field_current_value' => $user['last_name']));
				if( $result[$this->appNameSingular]['phone'] != $user['phone'] )
					$result['edit_fields'] = $this->setField( $result['edit_fields'], 'phone', array( 'field_current_value' => $user['phone']));
				if( $result[$this->appNameSingular]['title'] != $user['title'] )
					$result['edit_fields'] = $this->setField( $result['edit_fields'], 'title', array( 'field_current_value' => $user['title']));
				if( $result[$this->appNameSingular]['email'] != $user['email'] )
					$result['edit_fields'] = $this->setField( $result['edit_fields'], 'email', array( 'field_current_value' => $user['email']));
			}
		}

		// the company_alias field becomes a readonly field once the customer record is created
		if( $args[$this->appRecordId] || $result[$this->appNameSingular][$this->appRecordId] )
			$result['edit_fields'] = $this->setField( $result['edit_fields'], 'company_alias', array( 'field_type' => 'TE','is_readonly' => 'Y','is_mandatory' => 'N','is_unique' => 'N'));		

		// If the user owns Admin RBAC we allow update of agent_id
#		if ( $GLOBALS['appshore']->rbac->check('backoffice', RBAC_ADMIN ) == false )
#			$result['edit_fields'] = $this->setField( $result['edit_fields'], 'agent_id', array( 'is_readonly' => 'Y','is_mandatory' => 'N'));		

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');

        return $result;
    }	

          
    // init some values when new Entry
    function newEntry(  $args = null, $entry = null)
    {
        $args = getInstanceNewEntry( $args);
        
        return parent::newEntry( $args, $entry);
    } 
    

	// replace the default bulk delete
    function bulk_save( $args)
    {
		foreach( $args as $key => $val)
		{
			// is_blank has been removed 
			if( strpos( $key, 'bulk_') !== false && $val && $key != 'bulk_id' ) 
				$record[substr($key,5)] = $val;
		}
		
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = explode( ',', $args['selected']);				  
				foreach( $selected as $key => $val)
				{
					$record[$this->appRecordId] = $val;
					if( $GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $this->appTable, $this->appRecordId, $record[$this->appRecordId] ) == true )
					{
						if( execMethod( 'backoffice.customers.checkInstance',  $record) == true )
						{
							updateRow( $this->appTable, $this->appRecordId, $record, false);
							execMethod( 'backoffice.customers.updateInstance', $record);
							$records_count++;							
						}
					}
				}	
				break;	

			case 'All':	
				$db = executeSQL($_SESSION[$this->appName]['sql']['request']);

				while( !$db->EOF )
				{            
					$record[$this->appRecordId] = $db->fields[$this->appRecordId];
					if( $GLOBALS['appshore']->rbac->checkDataPermissions( $this->appRole, $this->appTable, $this->appRecordId, $record[$this->appRecordId] ) == true )
					{
						if( execMethod( 'backoffice.customers.checkInstance',  $record) == true )
						{
							updateRow( $this->appTable, $this->appRecordId, $record, false);
							execMethod( 'backoffice.customers.updateInstance', $record);
							$records_count++;							
						}
					}
		        		
		            $db->MoveNext();
				}				
				break;			 
		}
					
		if ( $records_count )
			messagebox( lang('%s records updated', $records_count), NOTICE);
    }		
	
	
	// replace the default bulk delete
    function bulk_delete( $args)
    {
    	// a trick to know the number of deleted records
    	$verbose = $_SESSION[$this->appName]['countMax'];

		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = explode( ',', $args['selected']);				  
				foreach( $selected as $key => $val)
				{
					$instance['company_id'] = $val;
					if( execMethod( 'backoffice.customers.deleteInstance', $instance) == true )
					{
						if( $this->deleteRecord($instance['company_id']) == true )
						{
							$this->sendMail( $instance['company_id'], 'delete');
							$_SESSION[$this->appName]['countMax']--;
						}
					}
				}	
				break;	

			case 'All':	
				$db = executeSQL($_SESSION[$this->appName]['sql']['request']);

				while( !$db->EOF )
				{            
					$instance['company_id'] = $db->fields($this->appRecordId);
					if( execMethod( 'backoffice.customers.deleteInstance', $instance) == true )
					{
						if( $this->deleteRecord($instance['company_id']) == true )
						{
							$this->sendMail( $instance['company_id'], 'delete');
							$_SESSION[$this->appName]['countMax']--;
						}
					}
		            $db->MoveNext();
				}				
				break;			 
		}
					
		if( $verbose != $_SESSION[$this->appName]['countMax'] )	
			messagebox( lang('%s records deleted', (int)($verbose-$_SESSION[$this->appName]['countMax'])), NOTICE);
    }
    
	
	// check the consistency of the alias
	function checkAlias( $company_alias = null)   
	{
		if( !preg_match('/^[a-zA-Z0-9_]+$/', $company_alias) || strlen($company_alias) == 0 ) // not a valid alias
		{			
			$result['status'] = false;	
			$result['error'] = 'Invalid company alias';	
			return $result;
		}
		
		return null;	
	}	
	
    function sendMail( $company_id, $action)
	{
		$sep = "<br/>";		
		// create mailer class and set up message
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');		
		$mail = new emailer();
        $mail->getEmailerInformation();
        
		$mail->SMTPKeepAlive = true;	
		$mail->isHTML(true);	
		
      	$mail->From 	= 'backoffice@'.CUSTOMER_DOMAIN;
		$mail->FromName = BRAND.' '.'Backoffice';
		
		switch( $action )
		{
			case 'create':
				$mail->Subject = BRAND.' '.'Backoffice - Instance created: '. $company_id;			
				break;
			case 'delete':
				$mail->Subject = BRAND.' '.'Backoffice - Instance deleted: '. $company_id;			
				break;
		}	

		$mail->Body  = "<table>";			
		$mail->Body .= "<tr><td style='width:10em'></td><td></td></tr>";			
		$mail->Body .= "<tr><td>Date</td><td>: ". date("D M j Y G:i:s T")."</td></tr>";			
		$mail->Body .= "<tr><td>Company Id</td><td>: ". $company_id."</td></tr>";		
		$mail->Body .= "</TABLE>".$sep.$sep;
			
		$mail->ClearAddresses();
		$mail->AddAddress('registration@appshore.com');

		$mail->Send(); 
		$mail->SmtpClose();				
	}		
}
