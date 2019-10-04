<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class administration_roles_base extends lib_base
{
    function __construct()
    {
    	$this->appTable 		= 'roles';
    	$this->appRecordId		= 'role_id';    	
    	$this->appRecordName	= 'role_name';    	
    	$this->appOrderBy		= 'role_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'administration_roles';
    	$this->appNameSingular	= 'administration_role';    	
    	$this->appLabel 		= 'Roles';
    	$this->appLabelSingular = 'Role';    
    	$this->appXSL	 		= 'administration.roles';
    	$this->appRole 			= 'administration';

		parent::__construct();
    }
    
	function menus()
	{
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl($this->appXSL);
		
		execMethod('administration.base.menus', '', true);

		$GLOBALS['appshore']->add_appmenu($this->appLabel, 'List', 'administration_roles.base.search');
		if ( $GLOBALS['appshore']->rbac->check('administration', RBAC_ADMIN ) )
        {
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'New role', 'administration.roles_base.edit');
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Grant permissions','administration.roles_base.grantPermissionsToRoles');
		}
	}
	
	
    function start()
    {  
		$this->menus();		

		$result[$this->appName] = '';
		$result['action'][$this->appName] = 'start';
		$result['recordset'] = $_SESSION[$this->appName];
						
		return $result;
    }   
		
    function search( $args = null)
    {
		$result = parent::search( $args);	
		
		// no right to delete this role
		foreach( $result[$this->appName] as $key => $val)
			if( $val['role_id'] == 'admin')
				$result[$this->appName][$key]['scope'] = 0;
				
		// neutralize bulk all records
		$result['bulk']= array(
			array('bulk_id' => 'Selected', 'bulk_name'=>lang('Selected lines')),
			array('bulk_id' => 'Page', 'bulk_name'=>lang('Current page'))
			);					

		return $result;	
    } 	

	
    function view( $args)
    {
		$result = parent::view( $args);	

		// no right to delete this role
		if( $args['role_id'] == 'admin' )
			$result['scope'] = 0;	

		return $result;	
    } 	
    
	
    function edit( $args)
    {
		$result = parent::edit( $args);	
		
		// to avoid update of administration and special roles
		if( $args['role_id'] == 'admin' )
			$result['scope'] = 0;

		return $result;	
    } 	
     	
	function grantPermissionsToRoles()
	{
		$args = new safe_args();
		$args->set('key', 		NOTSET, 'any');
		$args->set('role_id', 	NOTSET, 'any');			
		// Allow to retrieve all the cols from this table
		$role = getManyAssocArrays( 'select app_name from db_applications where status_id in ("A","D","S")');	

		foreach( $role as $val => $curr )
		{
			$args->set( 'app_'.$curr['app_name'].'_level', 	NOTSET, 'any');
			$args->set( 'app_'.$curr['app_name'].'_imp', 	NOTSET, 'any');
			$args->set( 'app_'.$curr['app_name'].'_exp', 	NOTSET, 'any');
		}
		$args = $args->get(func_get_args()); 
		
		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !($result['scope'] = $GLOBALS['appshore']->rbac->check('administration', RBAC_USER_WRITE )) )
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_WRITE_DENIED;
        }
        
		switch($args['key'])
		{
			case 'Error':
				messagebox( $error, ERROR);
				//NO break		
				
			case 'Cancel':
				// back to the view form
				if ($args['role_id'])				
					return $this->view( $args);	
				else
					return $this->search();	
				
			case 'Save':
			
				if ( $args['role_id'] != 'admin' ) 
				{
					// First we delete permissions for current role
					$GLOBALS['appshore']->db->execute( 'DELETE FROM permissions WHERE role_id = "'. $args['role_id'].'"');
					
					// then we insert the new ones 
					foreach( $role as $val => $curr )	
					{
						if ( $args['app_'.$curr['app_name'].'_level'])
						{
							$GLOBALS['appshore']->db->execute( 'INSERT INTO permissions ( role_id, app_name, level, import, export)							
								VALUES ("'.$args['role_id'].'","'.$curr['app_name'].'","'.$args['app_'.$curr['app_name'].'_level'].'",
								"'.$args['app_'.$curr['app_name'].'_imp'].'","'.$args['app_'.$curr['app_name'].'_exp'].'")'); 
						}
					}
                	//we must update the rbac status
                	$GLOBALS['appshore']->rbac->have_changed();
					messagebox( lang('Permissions set'),'notice');
				}
					
				// NO Break	
			default:
				$result['roles'] = getManyAssocArrays( 'select role_id, role_name from roles order by role_name');
				$result['apps'] = getManyAssocArrays( 'select app_name, app_label from db_applications where status_id in ( "A", "D", "S") and app_name not like "%\_%" order by app_label');					

			    if ( !isset($args['role_id'])) 
			    	$args['role_id'] = $result['roles'][0]['role_id'];
			    	
			    foreach ( $result['apps'] as $val => $curr )
			    {
			    	$level = getOneAssocArray( 'select * from permissions where role_id ="'.$args['role_id'].'" and app_name ="'.$curr['app_name'].'"');	
			    	$result['apps'][$val]['level'] = $level['level'];	
			    	$result['apps'][$val]['ur'] = $level['level'] & RBAC_USER_READ;				    	
			    	$result['apps'][$val]['uw'] = $level['level'] & RBAC_USER_WRITE;
			    	$result['apps'][$val]['rr'] = $level['level'] & RBAC_ROLE_READ;
			    	$result['apps'][$val]['rw'] = $level['level'] & RBAC_ROLE_WRITE;
			    	$result['apps'][$val]['pr'] = $level['level'] & RBAC_ALL_READ;
			    	$result['apps'][$val]['pw'] = $level['level'] & RBAC_ALL_WRITE;
			    	$result['apps'][$val]['imp'] = $level['import'];																						    					    	
			    	$result['apps'][$val]['exp'] = $level['export'];																						    					    	
			    	$result['apps'][$val]['adm'] = $level['level'] & RBAC_ADMIN;																						    					    	
			    }

			    $result['role']['role_id'] = $args['role_id'];	
				    
				if( $args['role_id'] == 'admin')
				{
					$result['scope'] = 0;
					messagebox( lang('Permissions for this role cannot be changed'), NOTICE);
				}
				break;	
		} 

		$this->menus();		
		
		// define the related action for calling the right xsl template
		$result['action'][$this->appName] = 'grantPermissionsToRoles';

		// Put context in XML to be processed by XSL
		$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];
	
        return $result;
	}	

 
}
