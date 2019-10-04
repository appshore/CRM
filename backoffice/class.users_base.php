<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class backoffice_users_base extends lib_base{

    function __construct()
    {
    	$this->appTable 		= 'customers_users';
    	$this->appRecordId		= 'customers_user_id';    	
    	$this->appRecordName	= 'customers_user_name'; 
    	$this->appOrderBy		= 'customers_user_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'backoffice_users';
    	$this->appNameSingular	= 'backoffice_user';    	
    	$this->appLabel 		= 'Users';
    	$this->appLabelSingular = 'User';    
    	$this->appXSL 			= 'backoffice.users';
    	$this->appRole 			= 'backoffice';  

        parent::__construct();    	
    }

	function menus()
	{
		execMethod('backoffice.base.menus');
	}
	
    
	function search(  $args = null)
    {
    	$args['company_id'] = $args['company_id']?$args['company_id']:$_SESSION[$this->appName]['company_id'];		

    	if( $args['company_id'] == null )
    	{
    		$customer = getOneAssocArray('select company_id from customers '.
				buildClauseWhere($this->appRole,'R','').' order by company_name limit 1');
    		if( $customer['company_id'] == null )
    			messagebox( lang('No customer'), ERROR);
 			$args['company_id'] = $customer['company_id'];
     	}
     	
 		if( $args['key'] == 'Clear' )
 		{
  			$args['company_id'] = $_SESSION[$this->appName]['company_id'];
			$_SESSION[$this->appName][$this->appRecordName] = '';
			$_SESSION[$this->appName]['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
			$_SESSION[$this->appName]['appOrderBy'] = $this->appOrderBy?$this->appOrderBy:$this->appRecordName;
			$_SESSION[$this->appName]['appAscDesc'] = $this->appAscDesc?$this->appAscDesc:'ASC';
		}      	
     	
     	if( ($args['company_id'] != null) && ($args['company_id'] != $_SESSION[$this->appName]['company_id']) )
     		execMethod('backoffice.users.retrieveUsers', $args);
     			
 		$result = parent::search( $args);

    	if( $args['company_id'] == null )
    		unset($result[$this->appName]);

 		// to filter alias list to the user scope
		$result['search_fields'] = $this->setField( $result['search_fields'], 'company_id', array( 
			'field_type' 		=>	'DD',
			'field_options' 	=>	getManyAssocArrays('select company_id as option_id, company_alias as option_name from customers '.
				buildClauseWhere($this->appRole,'R', '').' order by company_alias')
			));						
				
		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');

		return $result;
	} 

   
    function edit( $args = null)
    {
		if( $args['key'] == 'Save' )
		{
			if( isset($args['password']) && $args['password'] != '')
				$args['password'] = md5($args['password']);
			else if ( $args['reset_password'] == 'Y')
				$this->resetPasswordByUserId( $args[$this->appRecordId]);
	    }    
	    
		// run the standard edit fct
   		$result = parent::edit( $args);    		

		if( $args[$this->appRecordId] && $args['key'] == 'Save' && $result['Error'] != true )
			$this->updateUser( $args);

        return $result;
   		
    }    
    
 	// bulk operations
    function bulk_save( $args = null)
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
						updateRow( $this->appTable, $this->appRecordId, $record, false);

						if( $args['bulk_reset_password'] == 'Y' )
							$this->resetPasswordByUserId( $val);

						$this->updateUser( $record);

						$records_count++;							
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
						updateRow( $this->appTable, $this->appRecordId, $record, false);
			
						if( $args['bulk_reset_password'] == 'Y' )
							$this->resetPasswordByUserId( $record[$this->appRecordId]);

						$this->updateUser( $record) ;
							
						$records_count++;							
					}
		        		
		            $db->MoveNext();
				}				

				break;			 
		}		
		if ( $records_count )
			messagebox( lang('%s records updated', $records_count), NOTICE);
    } 
    
    
    function related( $args = null)
    {    	
     	if( $args['company_id'] != $_SESSION[$this->appName]['company_id'] )
     		execMethod('backoffice.users.retrieveUsers', $args);

        return parent::related($args);
    }         

   	function updateUser( $newuser)
	{   			
		list( $company_id, $newuser['user_id']) = explode( '_', $newuser['customers_user_id']);

		$company = getOneAssocArray( 'select company_alias from '.BACKOFFICE_DB.'.customers where company_id = "'.$company_id.'"');	
		$user = getOneAssocArray( 'select password from `'.PRIVATE_LABEL.$company['company_alias'].'`.users where user_id = "'.$newuser['user_id'].'"');	

		if( strlen($newuser['customers_user_name']) )
			$newuser['user_name'] = $newuser['customers_user_name'];

		if( strlen($newuser['password']) == 0 )
			$newuser['password'] = $user['password'];

		updateRow( PRIVATE_LABEL.$company['company_alias'].'.users', 'user_id', $newuser, false);
	}       

   	function resetPasswordByUserId( $customers_user_id)
	{   			
		list( $company_id) = explode( '_', $customers_user_id);
		$company = getOneAssocArray( 'select company_alias from '.BACKOFFICE_DB.'.customers where company_id = "'.$company_id.'"');	
		$user = getOneAssocArray( 'select email from '.BACKOFFICE_DB.'.customers_users where customers_user_id = "'.$customers_user_id.'"');	

		$reset['company_alias'] = $company['company_alias'];
		$reset['email'] = $user['email'];
		$reset['mode'] = 'RESET';			
        execMethod('backoffice.users.resetPassword', $reset);
	}  		 	 
	
	
   	function autoLogin()
	{   			
		$args = new safe_args();
		$args->set('customers_user_id', NOTSET, 'any');
		$args = $args->get(func_get_args());  

		list( $company_id, $user_id) = explode( '_', $args['customers_user_id']);
		$company = getOneAssocArray( 'select company_id, company_alias, domain_name from '.BACKOFFICE_DB.'.customers where company_id = "'.$company_id.'"');
			
		$user = getOneAssocArray( 'select customers_user_name as user_name from '.BACKOFFICE_DB.'.customers_users where customers_user_id = "'.$args['customers_user_id'].'"');	

		$tempwd = generateID();
		
		executeSQL('update '.BACKOFFICE_DB.'.customers set tempwd = "'.$tempwd.'" where company_id = "'.$company_id.'"');

		header('Location: http://'.$company['company_alias'].'.'.$company['domain_name'].'/?op=base.auth.login&login_ref='.
			base64_encode($user['user_name'].' '.$tempwd));
		exit();

	}  		    
   	
}
