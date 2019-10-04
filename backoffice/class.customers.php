<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class backoffice_customers 
{

	function setStatus()
	{   	
		$args = new safe_args();
		$args->set( 'company_id',	NOTSET, 'sqlsafe');				
		$args->set( 'company_status',	NOTSET, 'sqlsafe');				
		$args = $args->get(func_get_args());	

		executeSQL('UPDATE '.BACKOFFICE_DB.'.customers SET company_status = "'.$args['company_status'].'", updated = "'.gmdate('Y-m-d H:i:s').
			'" where company_id = "'.$args['company_id'].'"');
	}
	
	    // create remotely the instance and dataspace
    function updateInstance()
	{   			
		$args = new safe_args();
		$args->set( 'company_id', NOTSET, 'sqlsafe');				
		$args = $args->get(func_get_args());	

		// no company_id to activate
		if( ($company = getOneAssocArray( 'select * from '.BACKOFFICE_DB.'.customers where company_id = "'.$args['company_id'].'"')) == null )
		{
			messagebox( 'Instance not updated, customer doesn\'t exist', ERROR);
			return false;
		}
		
		// update company profile
#		$company['address_billing'] = $company['address'];
#		$company['zipcode_billing'] = $company['zipcode'];
#		$company['city_billing'] = $company['city'];
#		$company['state_billing'] = $company['state_id'];
#		$company['country_billing'] = $company['country_id'];

		// these infos are potentially updated o the customer's side so they shouldn't be updated
		unset($company['industry_id']);
		unset($company['employees']);
		unset($company['url']);
		
		unset($company['address_billing']);
		unset($company['zipcode_billing']);
		unset($company['city_billing']);
		unset($company['state_billing']);
		unset($company['country_billing']);
		unset($company['note']);
		
		updateRowGMT( PRIVATE_LABEL.$company['company_alias'].'.company', 'company_id', $company, false);

		// update first user (admin) profile and grant him role
		execMethod('backoffice.users.updateMainUser', $company);

		// update applications list according Edition				
		$this->updateEdition( $company['company_alias'], $company['edition_id']);
		
		execMethod('backoffice.users.retrieveUsers', $company);
		
		return true;
	}      
      
          
    // create remotely the instance and dataspace
    function createInstance()
	{   			
		$args = new safe_args();
		$args->set( 'company_id', NOTSET, 'sqlsafe');				
		$args = $args->get(func_get_args());	

		// no company_id to activate
		if( ($company = getOneAssocArray( 'select * from '.BACKOFFICE_DB.'.customers where company_id = "'.$args['company_id'].'"')) == null )
		{
			messagebox( 'Instance not created, customer doesn\'t exist', ERROR);
			return false;
		}

		// database creation
		executeSQL('CREATE DATABASE `'.PRIVATE_LABEL.$company['company_alias'].'` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci');

		if( $this->checkInstance( array( 'company_id' => $company['instance_template_id']) ) == true )
		{	// copy from another instance used as a template
			
			//retrieve list of tables in template instance
			$db = executeSQL( 'show table status from `'.PRIVATE_LABEL.$company['instance_template_id'].'` where Row_format = "Dynamic"');	
	
			while( !$db->EOF )
			{
				// retrieve SQL order to create the table
				$db2 = executeSQL( 'SHOW CREATE TABLE `'.PRIVATE_LABEL.$company['instance_template_id'].'`.`'.$db->fields['Name'].'`');	
				// update it to match the target database
				$createTable = str_replace( 'CREATE TABLE ', 'CREATE TABLE `'.PRIVATE_LABEL.$company['company_alias'].'`.', $db2->fields['Create Table']);
				// run the updated order
				executeSQL( $createTable);	

				// populate the table
				executeSQL( 'insert into `'.PRIVATE_LABEL.$company['company_alias'].'`.`'.$db->fields['Name'].
					'` select * from `'.PRIVATE_LABEL.$company['instance_template_id'].'`.`'.$db->fields['Name'].'`');	

				// next table
				$db->MoveNext();
			}
			
			//truncate of few tables that must be emptied for the new instance
			$tables = array( 'company', 'campaigns_history', 'dashboards', 'history', 'links', 'tags', 'tags_records', 'users', 'users_roles');
			foreach( $tables as $value)
				$db = executeSQL( 'truncate table `'.PRIVATE_LABEL.$company['company_alias'].'`.`'.$value.'`');	

			executeSQL( 'INSERT INTO `'.PRIVATE_LABEL.$company['company_alias'].'`.`permissions` (role_id, app_name, level, import, export) VALUES
				("admin", "accounts", 127, "1", "1"),
				("admin", "activities", 127, "1", "1"),
				("admin", "administration", 127, "0", "0"),
				("admin", "base", 127, "1", "1"),
				("admin", "campaigns", 127, "1", "1"),
				("admin", "cases", 127, "1", "1"),
				("admin", "contacts", 127, "1", "1"),
				("admin", "dashboards", 127, "1", "1"),
				("admin", "documents", 127, "1", "1"),
				("admin", "forecasts", 127, "1", "1"),
				("admin", "leads", 127, "1", "1"),
				("admin", "opportunities", 127, "1", "1"),
				("admin", "preferences", 127, "1", "1"),
				("admin", "reports", 127, "1", "1"),
				("admin", "support", 127, "1", "1"),
				("admin", "webmail", 127, "1", "1")');
				
			executeSQL( 'INSERT INTO `'.PRIVATE_LABEL.$company['company_alias'].'`.`roles` (role_id, role_name, role_label, status_id) VALUES
				("admin", "Administration", "This Role must not be deleted. \r\nDo not change the permissions on this Role. \r\nAt least one User must be granted this Role.", "S")');

			executeSQL( 'INSERT INTO `'.PRIVATE_LABEL.$company['company_alias'].'`.`users_roles` (user_id, role_id) values ("initial","admin")');
		}
		else
		{
			// execute of main db template script
			executeSQLScript( 'template', PRIVATE_LABEL.$company['company_alias']);		
		}

		// execute of view db template script
		executeSQLScript( 'template_views', PRIVATE_LABEL.$company['company_alias']);			

		// execute of PRIVATE_LABEL specific script
		executeSQLScript( PRIVATE_LABEL.'specific_template', PRIVATE_LABEL.$company['company_alias']);			
				
		// insert or update the new subdomain in the domains db
		executeSQL('REPLACE INTO '.LIGHTTPD_DB.'.domains( domain, docroot) VALUES("'.$company['company_alias'].'.'.INSTANCES_DOMAIN.
			'","'.INSTANCES_HTTPD.'/")');	

		// add instance to Cloudflare DNS
		exec('cfcli -c /home/appshore/.cfcli.yml -a -t CNAME add '.$company['company_alias'].' '.INSTANCES_DOMAIN) ;	
		
		// update applications list according Edition				
		$this->updateEdition( $company['company_alias'], $company['edition_id']);
					 			 
		// create company profile
		$company['company_id'] = $company['company_alias'];
		$company['main_user_id'] = 'initial';	// initial admin
		$company['billing_user_id'] = 'initial';
		$company['company_status'] = 'ACT';
		$company['address_billing'] = $company['address'];
		$company['zipcode_billing'] = $company['zipcode'];
		$company['city_billing'] = $company['city'];
		$company['country_billing'] = $company['country'];
		unset($company['note']);
		insertRowGMT( PRIVATE_LABEL.$company['company_alias'].'.company', 'company_id', $company, false);

		// create first user (admin) profile and grant him role
		execMethod('backoffice.users.createMainUser', $company);

		execMethod('backoffice.users.retrieveUsers', $company);
				
        // create physical space for this instance     
		require_once ( APPSHORE_LIB.SEP.'lib.files.php');
        checkDirectory( INSTANCES_DATA.SEP.$company['company_alias'].'/documents');
        checkDirectory( INSTANCES_DATA.SEP.$company['company_alias'].'/images');
        checkDirectory( INSTANCES_DATA.SEP.$company['company_alias'].'/attachments');
        checkDirectory( INSTANCES_DATA.SEP.$company['company_alias'].'/reports');

		executeSQL('UPDATE '.BACKOFFICE_DB.'.customers SET company_status = "ACT", updated = "'.gmdate('Y-m-d H:i:s').
			'" where company_id = "'.$company['company_id'].'"');						

		messagebox( 'Instance created', NOTICE);				

		return true;
	}    
    	
    // delete remotely the instance and dataspace
    function deleteInstance()
	{   			
		$args = new safe_args();
		$args->set( 'company_id',NOTSET, 'sqlsafe');				
		$args = $args->get(func_get_args());	
       
		// no company to delete
		if( ($company = getOneAssocArray( 'select * from '.BACKOFFICE_DB.'.customers where company_id = "'.$args['company_id'].'"')) == null )
		{
			messagebox( 'Instance not deleted, customer doesn\'t exist', ERROR);
			return false;
		}
	
		// drop the db
		executeSQL('DROP DATABASE `'.PRIVATE_LABEL.$company['company_alias'].'`');
			
		// delete the subdomain in the domains db
		executeSQL('DELETE FROM '.LIGHTTPD_DB.'.domains WHERE domain = "'.$company['company_alias'].'.'.INSTANCES_DOMAIN.'"');	
				
		// remove data rep and files of the instance
		if( is_dir( INSTANCES_DATA.SEP.$company['company_alias']) == true ) 
			exec('rm -fr '.INSTANCES_DATA.SEP.$company['company_alias']) ;

		// remove instance from Cloudflare DNS
		exec('cfcli -c /home/appshore/.cfcli.yml rm '.$company['company_alias'].'.'.INSTANCES_DOMAIN) ;

		executeSQL( 'update '.BACKOFFICE_DB.'.customers set updated = now() where company_id = "'.$company['company_id'].'"');	
		
		//save the deleted custome to archive
		executeSQL( 'insert into '.BACKOFFICE_DB.'.customers_archived select * from '.BACKOFFICE_DB.'.customers where company_id = "'.$company['company_id'].'"');	
			
		return true;
	}  

		
	// create edition
	function updateEdition()   
	{
    	$args = new safe_args();
		$args->set('company_alias', NOTSET, 'any');
		$args->set('edition_id', 	NOTSET, 'any');
		$args = $args->get(func_get_args());

		// lock off apps unavailable for this edition
		executeSQL( 'UPDATE `'.PRIVATE_LABEL.$args['company_alias'].'`.db_applications SET status_id = "A_L" WHERE status_id = "A"');	 

		// lock off apps unavailable for this edition
		executeSQL( 'UPDATE `'.PRIVATE_LABEL.$args['company_alias'].'`.db_applications SET status_id = "D_L" WHERE status_id = "D"');	 

		// unlock all apps available for this edition
		executeSQL( 'UPDATE `'.PRIVATE_LABEL.$args['company_alias'].'`.db_applications SET status_id = "A"
			WHERE status_id = "A_L"
			AND app_name in ( select app_name from global_editions_applications where edition_id like "%'.$args['edition_id'].'%")');	 

		// unlock all apps available for this edition
		executeSQL( 'UPDATE `'.PRIVATE_LABEL.$args['company_alias'].'`.db_applications SET status_id = "D"
			WHERE status_id = "D_L"
			AND app_name in ( select app_name from global_editions_applications where edition_id like "%'.$args['edition_id'].'%")');	 

	}
	
	
	// create company profile
	function createCustomer()   
	{	
		$args = new safe_args();
		$args->set( 'setupFrom',	NOTSET, 'sqlsafe');				
		$inputs = describeColumns( BACKOFFICE_DB.'.customers');
		foreach( $inputs as $fieldName => $fieldValue )
			$args->set( $fieldName,	NOTSET, 'any');	
		$args = $args->get(func_get_args());		
		
		$customer['company_id'] = insertRowGMT( BACKOFFICE_DB.'.customers', 'company_id', $args, false);
		
		return $customer;
	}	
		
   
	// Check locally and remotely if the instance exists
    function checkInstance()
	{   	
		$args = new safe_args();
		$args->set( 'company_id',NOTSET, 'any');				
		$args->set( 'company_alias',NOTSET, 'any');				
		$args = $args->get(func_get_args());	

		// no id or alias so the instance isn't created
		$company = getOneAssocArray('select company_status from '.BACKOFFICE_DB.
		'.customers where company_id = "'.$args['company_id'].'" or company_alias = "'.$args['company_alias'].'"');

		return ( in_array($company['company_status'], array('ACT','CLO')) ? true : false) ;
	}   	
 	


}
