<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class administration_users_acl
{
    function __construct()
    {
    	$this->appTable 		= 'users';
    	$this->appRecordId		= 'user_id';    	
    	$this->appRecordName	= 'user_name'; 
    	$this->appOrderBy		= 'user_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'administration_users';
    	$this->appNameSingular	= 'administration_user';    	
    	$this->appLabel 		= 'Users';
    	$this->appLabelSingular = 'User';    
    	$this->appXSL	 		= 'administration.users';
    	$this->appRole 			= 'administration';
    }
    
    function start($args)
    {  

		if ( checkEdition() == false )
			return;

		return $this->ipAccessControl($args);
    }       
      	          	 	
	function ipAccessControl()
	{
		$args = new safe_args();
		$args->set('key', 		NOTSET, 'any');
		$args->set('is_ipacl', 	NOTSET, 'any'); 
		$args->set('ipacl', 	NOTSET, 'any'); 
			
		$result['users'] = getManyAssocArrays( 'select user_id, full_name, user_name, ipacl from users order by user_name');
		foreach( $result['users'] as $key => $val )
		{
			$args->set('ipacl_'.$val['user_id'], 	NOTSET, 'any'); 
		}		
		$args = $args->get(func_get_args()); 
	
		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !$GLOBALS['appshore']->rbac->check('administration', RBAC_USER_WRITE ) )
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_WRITE_DENIED;
        }
		elseif (  $args[$this->appRecordId] && !$GLOBALS['appshore']->rbac->checkDataPermissions( 'administration', 'users', $this->appRecordId, $args[$this->appRecordId] )	)
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_DENIED;
        }

		$result['public_ip_address'] = execMethod('base.auth.getUserIP');

 		switch($args['key'])
		{
			case 'Error':
				messagebox( $error, ERROR);
				//NO break
				
			case 'Save':
			
				executeSQL( 'UPDATE company set is_ipacl="'.$args['is_ipacl'].'", ipacl="'.$args['ipacl'].'" WHERE company_id = "'.$GLOBALS['appshore_data']['my_company']['company_id'].'"');
				$GLOBALS['appshore_data']['my_company']['is_ipacl'] = $args['is_ipacl'];
				$GLOBALS['appshore_data']['my_company']['ipacl'] = $args['ipacl'];
				
				// case of current user to avoid to lock it out
				if( strpos( $args['ipacl_'.$GLOBALS['appshore_data']['current_user']['user_id']], $result['public_ip_address']) === false 
					&& strpos( $args['ipacl'], $result['public_ip_address']) === false 
					&& (strlen($args['ipacl_'.$GLOBALS['appshore_data']['current_user']['user_id']]) || strlen($args['ipacl'])) )
					$args['ipacl_'.$GLOBALS['appshore_data']['current_user']['user_id']] .= ' '.$result['public_ip_address'].' ';

				foreach( $result['users'] as $key => $val )
				{
					executeSQL( 'UPDATE users set ipacl="'.ltrim($args['ipacl_'.$val['user_id']]).'" WHERE user_id = "'.$val['user_id'].'"');
					$result['users'][$key]['ipacl'] = ltrim($args['ipacl_'.$val['user_id']]);
				}
				
			    messagebox( MSG_UPDATE, NOTICE);					
				break;	
		} 

		$result['company']['is_ipacl'] = $GLOBALS['appshore_data']['my_company']['is_ipacl'];
		$result['company']['ipacl'] = $GLOBALS['appshore_data']['my_company']['ipacl'];

		execMethod('administration.users_base.menus');
        $GLOBALS['appshore']->add_xsl('administration.users_acl');

		// define the related action for calling the right xsl template
		$result['action'][$this->appName] = 'ipAccessControl';

		$result['recordset'] = $_SESSION[$this->appName];

		return $result;
	}    
       	
}
