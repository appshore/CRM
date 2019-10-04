<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class administration_users_roles
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
		return $this->grantRolesToUsers($args);
    }       
      	          	 	
	function grantRolesToUsers()
	{
		$args = new safe_args();
		$args->set('key', 			NOTSET, 'any');
		$args->set('user_id', 		NOTSET, 'any'); 
		$args->set('selectedroles', NOTSET, 'any'); 
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

 		switch($args['key'])
		{
			case 'Error':
				messagebox( $error, ERROR);
				//NO break
				
			case 'Save':
				if( $args['selectedroles'])
					$roles = explode( ',', $args['selectedroles'] );
				
				if ( (count($roles) < 1) and ($args['user_id'] == $GLOBALS['appshore_data']['current_user']['user_id']) )					
				{
					messagebox( 'You can\'t remove all your roles', ERROR);
					unset( $args['key']);
					return $this->grantRolesToUsers( $args);
				}	
			
				// this is an administrator
				if ( $this->isAdministrator( $args['user_id']) == true )
				{

					if ( isset($roles) && !in_array( 'admin', $roles) )
					{
						if ( $args['user_id'] == $GLOBALS['appshore_data']['current_user']['user_id'] )					
						{
							messagebox( 'You can\'t remove yourself your Administrator role', ERROR);
							unset( $args['key']);
							return $this->grantRolesToUsers( $args);
						}	

						if ( $this->isLastAdministrator( $args['user_id']) )					
						{
							messagebox( 'This is the last user to own the Administration role, you can\'t remove it', ERROR);
							unset( $args['key']);
							return $this->grantRolesToUsers( $args);
						}	
					}	
				}
			
				if ( isset($args['user_id'])) 
				{ 				
					// First we delete existing roles granted to selected user
					executeSQL( 'DELETE FROM users_roles WHERE user_id = "'.$args['user_id'].'"');
					
					// then we insert the selected ones 
				    if ( $roles) 
				    {	
				   	    foreach ( $roles as $val => $curr)
					       executeSQL( 'INSERT INTO users_roles VALUES("'.$args['user_id'].'","'.$curr.'")');
				    }

                //we must update the rbac status because this user rights have changed
                $GLOBALS['appshore']->rbac->have_changed();

			    messagebox( 'User updated', NOTICE);					

				}

				// NO Break	
			default:
				$result['users'] = getManyAssocArrays( 'select user_id, full_name, user_name from users order by user_name');	
				$result['roles'] = getManyAssocArrays( 'select role_id, role_name from roles order by role_name');

			    if ( !isset($args['user_id'])) 
			    	$args['user_id'] = $result['users'][0]['user_id'];
 
			    $result['user_roles'] = getManyAssocArrays( 'select role_id from users_roles where user_id = "'.$args['user_id'].'"');	
			    $result['user']['user_id'] = $args['user_id'];	

				break;	
		} 

		execMethod('administration.users_base.menus');
        $GLOBALS['appshore']->add_xsl('administration.users_roles');

		// define the related action for calling the right xsl template
		$result['action'][$this->appName] = 'grantRolesToUsers';

#		// Put context in XML to be processed by XSL
#		$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];

		return $result;
	}
    
    // Check if we have still some administrator
    function isLastAdministrator( $user_id )
    {
		$count = getOneAssocArray( '
			SELECT count( users.user_id ) as nbr
			FROM users_roles
			LEFT OUTER JOIN users ON users.user_id = users_roles.user_id
			LEFT OUTER JOIN roles ON roles.role_id = users_roles.role_id
			WHERE roles.role_id = "admin"
			AND users.user_id != "'.$user_id.'"');	

        return ($count['nbr'] == 0 )? true : false;
    }
    
    // Check if this user is an administrator
    function isAdministrator( $user_id )
    {
		$count = getOneAssocArray( '
			SELECT count( users.user_id ) as nbr
			FROM users_roles
			LEFT OUTER JOIN users ON users.user_id = users_roles.user_id
			LEFT OUTER JOIN roles ON roles.role_id = users_roles.role_id
			WHERE roles.role_id = "admin"
			AND users.user_id = "'.$user_id.'"');		

        return ($count['nbr'] == 0 )? false : true; 
    }
    	    
       	
}
