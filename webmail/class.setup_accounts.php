<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/


// class meeting extends activities so requires it
require_once ( 'class.setup.php');

define('EMAIL_ACCOUNTS_QUOTA', 30);
define('MSG_EMAIL_ACCOUNTS_QUOTA', 'Quota of external email accounts reached');
define('MSG_EMAIL_ACCOUNT_INACCESSIBLE', ', email account inaccessible, check the parameters');
define('MSG_EMAIL_ACCOUNT_VERIFIED', ', email account verified');

class webmail_setup_accounts extends webmail_setup
{
 	
	// view one setup
    function edit()
    {
		$args = new safe_args();
		$args->set('key', NOTSET, 'any');
		foreach( describeColumns( 'webmail_accounts') as $fieldName => $fieldValue )
			$args->set( $fieldName,	$_SESSION['folders'][$fieldName], 'any');	
		$args = $args->get(func_get_args());
		
		$this->menus();	
        $GLOBALS['appshore']->add_xsl('webmail.setup_accounts');  		
		
		$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], 'webmail');

		
		switch($args['key'])
		{
			case 'Delete':
				if( !$args['account_id'] || deleteRow( 'webmail_accounts', 'account_id', $args, false) == false )
					unset( $args['key']);
				else
					messagebox(MSG_DELETE);											
				break;	
					
			case 'New':
				$count_accounts = getOneColOneRow('select count(account_id) from webmail_accounts where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');	
				if( $count_accounts >= EMAIL_ACCOUNTS_QUOTA )
					messagebox(MSG_EMAIL_ACCOUNTS_QUOTA, WARNING);
					
				unset( $args['account_id']);
				$result['account']['is_enable'] = 'Y';
				$result['account']['pop3_port'] = '995';
				$result['account']['pop3_ssl'] = 'Y';
				$result['account']['pop3_lmos'] = 'Y';
				break;	
					
			case 'Save':
	        	$args['pop3_password'] = $this->passwordEncrypt( $args['pop3_password']);
	        	$args['smtp_password'] = $this->passwordEncrypt( $args['smtp_password']);
				$args['is_enable'] = ($args['is_enable'] == 'Y')?'Y':'N';
				$args['pop3_ssl'] = ($args['pop3_ssl'] == 'Y')?'Y':'N';
				$args['pop3_lmos'] = 'Y';//($args['pop3_lmos'] == 'Y')?'Y':'N';
				
				if ($args['account_id']) 			// UPDATE an existing record
				{
					if( updateRow( 'webmail_accounts', 'account_id', $args) == null )
						$result['account'] = $args;
	                else
	                	messagebox(MSG_UPDATE);
				}
				else 								// New record so we do an INSERT
				{
					$count_accounts = getOneColOneRow('select count(account_id) from webmail_accounts where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');	
					if( $count_accounts >= EMAIL_ACCOUNTS_QUOTA )
					{
						messagebox(MSG_EMAIL_ACCOUNTS_QUOTA, WARNING);
					}
					else
					{
						$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
						if ( ($args['account_id'] = insertRow( 'webmail_accounts', 'account_id', $args)) == null )
			                $result['account'] = $args;
			            else
			            	messagebox(MSG_INSERT);			            	
	                }
				}									
				break;
				
			case 'Test':
				if( execMethod('webmail.pop3.testAccount', $args) == false )
					messagebox( $args['account_name'].MSG_EMAIL_ACCOUNT_INACCESSIBLE, WARNING);
				else
					messagebox( $args['account_name'].MSG_EMAIL_ACCOUNT_VERIFIED);
				break;		
		}
		
		if( $args['account_id'])
			$result['account'] = getOneAssocArray('select * from webmail_accounts where account_id = "'.$args['account_id'].'"'); 
			
		$result['accounts'] = getManyAssocArrays('select account_id, account_name from webmail_accounts 
			where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" order by account_name');	
			
		// Pop3 ports
		$result['pop3ports'] = array(  
			array('pop3_port' => '109'), array('pop3_port' => '110'), array('pop3_port' => '143'),
			array('pop3_port' => '220'), array('pop3_port' => '993'), array('pop3_port' => '995'),
			array('pop3_port' => '1110'), array('pop3_port' => '2221')
	        );   
							
		$result['action']['webmail'] = 'setup_accounts';	
	
		// Put tab context 
		$result['recordset']['tab_id'] = 'accounts';
		$result['recordset']['appName'] = 'webmail';
		$result['tabs'] = $this->tabs;				
		$result['folders'] = execMethod('webmail.folder.foldersList', true);

		return $result;
    } 
    
    function passwordEncrypt($password = null)
    {
		if( $password == '' || $password == null )
			return null;
		
		return base64_encode($password);
    }
    
    	
} 
 
