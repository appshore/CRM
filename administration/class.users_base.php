<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

define( 'ERROR_DELETE_CURRENT_USER', lang('You can\'t delete yourself'));
define( 'ERROR_CHANGE_STATUS_CURRENT_USER', lang('You can\'t change your status'));

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class administration_users_base extends lib_base
{
	var $usersQuotaAvailable = 0;
	
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

    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		$this->usersQuotaAvailable = execMethod('base.license.usersQuotaAvailable');

		parent::__construct();
    }

	function menus()
	{
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl($this->appXSL);
		
		execMethod('administration.base.menus', '', true);

		$GLOBALS['appshore']->add_appmenu($this->appLabel, 'List', 'administration.users_base.search');
		if ( $GLOBALS['appshore']->rbac->check('administration', RBAC_ADMIN ) )
        {
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'New user', 'administration.users_base.edit');
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Grant roles','administration.users_roles.start');
			if ( checkEdition() )
				$GLOBALS['appshore']->add_appmenu($this->appLabel, 'IP access control','administration.users_acl.start');
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
    
			
    function view( $args = null)
    {
    	// A user can not delete himself
		if( $args['key'] == 'Delete' && $args[$this->appRecordId] == $GLOBALS['appshore_data']['current_user']['user_id'] )
		{
			messagebox( ERROR_DELETE_CURRENT_USER, ERROR);
			unset( $args['key']);	// we neutralize the delete key
	    }
 		
		// No duplicate when users quota reached				
		if( $args['key'] == 'Duplicate' && $this->usersQuotaAvailable <= 0 )
		{
			if( $this->usersQuotaAvailable <= 0 )
            	messagebox( ERROR_USERS_QUOTA, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
			unset( $args['key']);	// we neutralize the duplicate key
		}
    
   		$result = parent::view( $args); 
   		  		
		switch($args['key'])
		{
			case 'Duplicate':
    			unset( $result[$this->appNameSingular][$this->appRecordId]);
    			if ( $result['edit_fields'])
					foreach( $result['edit_fields'] as $fieldkey => $fieldvalue)
					{	
						if( in_array( $result['edit_fields'][$fieldkey]['field_name'], array($this->appRecordId, $this->appRecordName)) || ( $result['edit_fields'][$fieldkey]['is_unique'] == 'Y'))
							unset( $result['edit_fields'][$fieldkey]['field_current_value']);
					}	
	    		break;
	    }

		$result['view_fields'] = $this->setField( $result['view_fields'], 'timezone_id', array( 
			'field_current_value' => $GLOBALS['appshore']->local->timezone($result[$this->appNameSingular]['timezone_id'])
			));

        return $result;
    }    

    

    function edit( $args = null)
    {
		// the special case of full_name which occurs very frequently
		$args['full_name'] = setFullname( $args['first_names'], $args['last_name']);		
   		
		// No new user when quota reached					
		if( $args[$this->appRecordId] == '' && $this->usersQuotaAvailable <= 0 )
		{
           	messagebox( ERROR_USERS_QUOTA, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
			return $this->search();
		}
   
   		$result = parent::edit( $args); 
  		
		switch( ($result['Error'] != true) ? $args['key'] : '' )
		{
			case 'Duplicate':
    			unset( $result[$this->appNameSingular][$this->appRecordId]);
    			if ( $result['edit_fields'])
					foreach( $result['edit_fields'] as $fieldkey => $fieldvalue)
					{	
						if( in_array( $result['edit_fields'][$fieldkey]['field_name'], array($this->appRecordId, $this->appRecordName)) || ( $result['edit_fields'][$fieldkey]['is_unique'] == 'Y'))
							unset( $result['edit_fields'][$fieldkey]['field_current_value']);
					}	
	    		break;

			case 'Save':
				// new welcome email imply, new password as well so no need to reset also				
				if( $result[$this->appNameSingular][$this->appRecordId] )
				{
					if( $args['send_welcome_email'] == 'Y' || $args['reset_password'] == 'Y' )
					{
						$user['user_id'] = $result[$this->appNameSingular][$this->appRecordId];
						$user['mode'] = ($args['bulk_send_welcome_email'] == 'Y')?'CREATION':'RESET';
						execMethod( 'administration.users_password.sendNewPassword', $user) ;
					}
				
			    	// grant default role
					if( $args['initial_role_id'] )
					{
						$ur['user_id'] = $result[$this->appNameSingular][$this->appRecordId];
						$ur['role_id'] = $args['initial_role_id'];
				        insertRow( 'users_roles', $this->appRecordId, $ur, false); 
					}
				}
				break;
	    		
	    	default:
	    		if( isset($args[$this->appRecordId]) == false && $result['edit_fields'] )
	    		{
	    			unset( $result[$this->appNameSingular][$this->appRecordId]);
					$result['edit_fields'] = $this->setField( $result['edit_fields'], 'initial_role_id', array( 
						'is_mandatory' => 'Y'
						));
					$result['edit_fields'] = $this->setField( $result['edit_fields'], 'send_welcome_email', array( 
						'field_current_value' => 'Y'
						));
					$result['edit_fields'] = $this->setField( $result['edit_fields'], 'reset_password', array( 
						'field_current_value' => 'Y'
						));
	    		}
	    		break;
	    }
		
		if( $GLOBALS['appshore_data']['my_company']['agent_id'] != 'jpn' )
			$result['edit_fields'] = $this->setField( $result['edit_fields'], 'language_id', array( 
				'field_options' => getManyAssocArrays('SELECT language_id as option_id, language_name as option_name FROM global_languages WHERE language_id <> "ja" order by language_id')
				));

		// retrieve timezone list
		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'timezone_id', array( 
			'field_current_value' => $result[$this->appNameSingular]['timezone_id'],
			'field_options' => $GLOBALS['appshore']->local->timezones()
			));

        return $result;
    }
    
    function newEntry(  $args = null, $entry = null)
    {     
        $_SESSION[$this->appName]['countMax'] = $_SESSION[$this->appName]['currentVal'] = 0;
        
        $entry['app_name'] = $GLOBALS['appshore_data']['current_user']['app_name'];
        $entry['status_id'] = $GLOBALS['appshore_data']['current_user']['status_id'];
        $entry['language_id'] = $GLOBALS['appshore_data']['current_user']['language_id'];
        $entry['theme_id'] = $GLOBALS['appshore_data']['current_user']['theme_id'];
        $entry['currency_id'] = $GLOBALS['appshore_data']['current_user']['currency_id'];
        $entry['charset_id'] = $GLOBALS['appshore_data']['current_user']['charset_id'];
        $entry['locale_date_id'] = $GLOBALS['appshore_data']['current_user']['locale_date_id'];
        $entry['locale_time_id'] = $GLOBALS['appshore_data']['current_user']['locale_time_id'];
        $entry['timezone_id'] = $GLOBALS['appshore_data']['current_user']['timezone_id'];
        $entry['nbrecords'] = $GLOBALS['appshore_data']['current_user']['nbrecords'];
        
        $entry['confirm_delete'] = 'Y';

        if( $args )
        {
			if( $entry )
				foreach( $entry as $key => $val )
					if( !isset($args[$key]) || $args[$key] == '')
						$args[$key] = $val;
         	return $args;
        }
		else
        	return $entry;
    }
	
	// replace the default bulk delete
    function bulk_delete( $args = null)
    {
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = explode( ',', $args['selected']);				  
				if( in_array( $GLOBALS['appshore_data']['current_user']['user_id'], $selected) == false )
					return parent::bulk_delete($args);

			// if there is an attempt to delete the current user we do not break;				
			case 'All':	
				messagebox( ERROR_DELETE_CURRENT_USER, ERROR);
				break;			 
		}
    }  

	// bulk operations
    function bulk_save( $args = null)
    {   		
		if( $args['bulk_status_id'] == 'A' && $this->usersQuotaAvailable <= 0 )
		{
           	messagebox( ERROR_USERS_QUOTA, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
			return;
		}

		// special fields send_welcome_email and reset_password
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = explode( ',', $args['selected']);

				// if the current user is going to be deactivated we refused this bulk operation
				if( $args['bulk_status_id'] == 'D' && 
					in_array( $GLOBALS['appshore_data']['current_user']['user_id'], $selected) == true )
				{
					messagebox( ERROR_CHANGE_STATUS_CURRENT_USER, ERROR);
					return;
				}
				
				
				if( $args['bulk_send_welcome_email'] == 'Y' || $args['bulk_reset_password'] == 'Y' )
				{
					$user['mode'] = ($args['bulk_send_welcome_email'] == 'Y')?'CREATION':'RESET';
					foreach( $selected as $key => $val)
					{
						$user['user_id'] = $val;
						execMethod( 'administration.users_password.sendNewPassword', $user) ;
					}
				}
  				break;	

			case 'All':	
				if( $args['bulk_status_id'] == 'D' )
				{
					messagebox( ERROR_CHANGE_STATUS_CURRENT_USER, ERROR);
					return;
				}

				if( $args['bulk_send_welcome_email'] == 'Y' || $args['bulk_reset_password'] == 'Y' )
				{
					$db = executeSQL($_SESSION[$this->appName]['sql']['request']);
					$user['mode'] = ($args['bulk_send_welcome_email'] == 'Y')?'CREATION':'RESET';
					while( !$db->EOF )
					{            
						$user['user_id'] = $db->fields($this->appRecordId);
						execMethod( 'administration.users_password.sendNewPassword', $user) ;
			            $db->MoveNext();
					}
				}				

				break;			 
		}		
		
		// handle standard fields	
		parent::bulk_save($args);	
    }    	
    	    
       	
}
