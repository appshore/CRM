<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

class backoffice_users
{

   	function retrieveUsers()
	{   			
		$args = new safe_args();
		$args->set( 'company_id',NOTSET, 'sqlsafe');				
		$args = $args->get(func_get_args());	
       
		$company = getOneAssocArray( 'select company_alias, company_status from '.BACKOFFICE_DB.'.customers where company_id = "'.$args['company_id'].'"');	

		// no company to activate
		if( $company == null )
		{
			// the company is not yet created
			messagebox( 'Invalid customer instance', NOTICE);	
			return false; 
		}
		else if( $company['company_status'] == 'REG' )
		{
			// the company is not yet created no need to check for users
			return false;
		}	

		deleteRowWhere( BACKOFFICE_DB.'.customers_users', 'where company_id = "'.$args['company_id'].'"', false);
		
		// fetch the users from the customer database
		$users = getManyAssocArrays( 'select * from `'.PRIVATE_LABEL.$company['company_alias'].'`.users');

		if( $users )
		{
			foreach( $users as $key => $val )
			{
				$val['company_id'] = $args['company_id'];
				$val['customers_user_id'] = $args['company_id'].'_'.$val['user_id'];
				$val['customers_user_name'] = $val['user_name'];
				insertRowGMT( BACKOFFICE_DB.'.customers_users', 'customers_user_id', $val, false);
			}
		}
	}    
	
   	function resetPassword()
	{   			
		$args = new safe_args();
		$args->set( 'company_alias',	NOTSET, 	'sqlsafe');				
		$args->set( 'email',			NOTSET, 	'sqlsafe');				
		$args->set( 'mode', 			'RESET',	'sqlsafe');				
		$args = $args->get(func_get_args());	

        $ch = curl_init();        	
        curl_setopt($ch, CURLOPT_URL, 'http://'.$args['company_alias'].'.'.INSTANCES_DOMAIN.'/raw.php');
        curl_setopt($ch, CURLOPT_POSTFIELDS, 'op=base.auth.recovery&email='.$args['email'].'&mode='.$args['mode']);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true) ;
        $ret = curl_exec($ch);   
        curl_close($ch);
	}  		
	    
	// create user profile
	function createMainUser( $user)   
	{
		$user['user_id'] = 'initial'; 	// initial admin
		$user['full_name'] = setFullname($user['first_names'],$user['last_name']);
		$user['password'] =  md5($user['password'] ? $user['password'] : $user['user_name']); 	// initial password
		unset($user['note']);
		insertRowGMT( PRIVATE_LABEL.$user['company_alias'].'.users', 'user_id', $user, false);
	}
				
	// update user profile
	function updateMainUser( $args)   
	{
		$user = getOneAssocArray( 'select user_id from `'.PRIVATE_LABEL.$args['company_alias'].'`.users where user_name = "'.$args['user_name'].'"');	
		if( $user == null )
			return;
		$user['first_names'] = $args['first_names'];
		$user['last_name'] = $args['last_name'];
		$user['full_name'] = setFullname($user['first_names'],$user['last_name']);
		$user['phone'] = $args['phone'];
		$user['title'] = $args['title'];
		$user['email'] = $args['email'];
		updateRowGMT( PRIVATE_LABEL.$args['company_alias'].'.users', 'user_id', $user, false);
	}
		  	
	    	
}
