<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */


class administration_emailer {
	var $mailers;
	var $auths;	
	
    function __construct()
    {
	    $this->mailers = array(
	        array ( 'emailer_mailer' => 'sendmail'),
	        array ( 'emailer_mailer' => 'smtp')
	        );   
	        
	    $this->auths = array(
	        array ( 'emailer_auth' => 'Y', 'auth_name' => lang('Yes')),
	        array ( 'emailer_auth' => 'N', 'auth_name' => lang('No'))
	        );    	          

	} 

    function setMenus()
    {
		execMethod('administration.company.setMenus', $args, true);	
        $GLOBALS['appshore']->add_xsl('administration.emailer');			
	} 
	
	// view email configuration
    function view()
    {
		$args = new safe_args();
		$args->set('key',NOTSET,'any');
		$args = $args->get(func_get_args()); 
				
		$this->setMenus();
				
		switch($args['key'])
		{
			case 'Test':
				// back to the view form
				$result = $this->view();				
				$result['test'] = $this->emailTest();	
				break;	
				
			case 'Edit':
				$result = $this->edit( $args);	
				break;

			default:
       					
				// scope is set to 0 or 1 means READ_ONLY or READ_WRITE
				// xsl file will test this value to display or not edit/delete/copy buttons
				$result['scope'] = $GLOBALS['appshore']->rbac->checkPermissionOnUser('administration', $result['administration']['user_id']) ;
				$result['action']['emailer'] = 'view';
				$result['emailer'] = $this->buildEmailerView();				
				break;
		}
		
		return $result;
    } 	


	// edit or create one emailer
    function edit()
    {
		$args = new safe_args();
		$args->set('key',NOTSET,'any');

		// Allow to retrieve all the cols from this table
		$emailer = getOneAssocArray( 'select * from company limit 1');	
		foreach( $emailer as $fieldName => $fieldValue )
			$args->set( $fieldName, NOTSET, 'any');
		unset($emailer);	

		$args = $args->get(func_get_args()); 	
	
		$this->setMenus();
					
 		switch($args['key'])
		{
			case 'Test':
				// back to the view form
				$result = $this->edit();				
				$result['test'] = $this->emailTest();
				messagebox( EMAIL_SEND, NOTICE);					
				break;						
				
			case 'Cancel':
				// back to the view form
				$result = $this->view( $args);	
				break;				

			case 'Save':
				if( !$args['emailer_port'])
					$args['emailer_port'] = ($args['emailer_mailer'] == 'smtp') ? '25' : '143';			
                $result['error'] = $this->checkFields($args);
                if ( isset ( $result['error']) )
                {
                    messagebox( ERROR_INVALID_DATA, 'error');
                    $result['emailer'] = $args;
                }
				else
				{			
					if( $args['emailer_password'] )
					{
 						include_once(APPSHORE_INCLUDES.SEP.'cast128'.SEP.'cast128.php');		
						$crypto = new cast128;
						$args['emailer_password'] = $crypto->encrypt( $args['emailer_password'], md5('appshore'));
					}
					else
						unset($args['emailer_password']);
				
					updateRow( 'company', 'company_id', $args);
				}
				// NO Break for 'Save' case	
					
			default:
			    $result['emailer'] = $this->buildEmailerView();
			    $result['mailers'] = $this->mailers;
			    $result['auths'] = $this->auths;			    
				$result['action']['emailer'] = 'edit';	
				break;	
		} 
		
        return $result;
    } 	
    
	function buildEmailerView()
	{
		// retrieve the selected record
		$emailer = getOneAssocArray( 'SELECT * from company limit 1');	

		$emailer['created'] = $GLOBALS['appshore']->local->gmtToTZLocal( $emailer['created']);	        
		$emailer['updated'] = $GLOBALS['appshore']->local->gmtToTZLocal( $emailer['updated']);	
	
		if ($emailer['created_by'])				
			$created_by = getOneAssocArray( 'select user_name as created_by from users where user_id= "'.$emailer['created_by'].'"');
		if ($emailer['updated_by'])				
			$updated_by = getOneAssocArray( 'select user_name as updated_by from users where user_id= "'.$emailer['updated_by'].'"');
		if ($emailer['emailer_auth'])
            $auth = searchArray( $this->auths, 'emailer_auth',  $emailer['emailer_auth']);        		
		
		// merge all arrays to build up emailer branch in XML stream
		return array_merge( $emailer, $created_by, $updated_by, $auth);
	}
	
    // Check mandatory fields and type of some
    function checkFields( $args )
    {
        unset( $result['error'] );

        if ( !$args['emailer_from'] )
            $result['error']['emailer_from'] = ERROR_MANDATORY_FIELD;

        if ( !$args['emailer_host'] )
            $result['error']['emailer_host'] = ERROR_MANDATORY_FIELD;
                                               
        if ( !is_numeric($args['emailer_port']) )
            $result['error']['emailer_port'] = ERROR_NUMERIC_FIELD;
            
        return $result['error'];
    }   	
    
    function emailTest()
    {	
		// create mailer class and set up message
		
		include_once( APPSHORE_INCLUDES.SEP.'phpmailer/class.phpmailer.php');		
		$mail = new PHPMailer();
        $mail->From = $GLOBALS['appshore_data']['my_company']['emailer_from'];
		$mail->FromName = $GLOBALS['appshore_data']['my_company']['emailer_fromname'];
        $mail->Username = $GLOBALS['appshore_data']['my_company']['emailer_from'];

 		include_once(APPSHORE_INCLUDES.SEP.'cast128/cast128.php');		
		$crypto = new cast128;
        $mail->Password = $crypto->decrypt( $GLOBALS['appshore_data']['my_company']['emailer_password'], md5('appshore'));        

		//$mail->Mailer = 'sendmail';	
		$mail->Mailer = $GLOBALS['appshore_data']['my_company']['emailer_mailer'];	
		
		$mail->Host =	$GLOBALS['appshore_data']['my_company']['emailer_host'];
		$mail->Port =	$GLOBALS['appshore_data']['my_company']['emailer_port'];
		$mail->SMTPAuth = ($GLOBALS['appshore_data']['my_company']['emailer_auth'] == 'Y')? true:false; 
		
		$mail->SetLanguage( 'en', APPSHORE_INCLUDES.SEP.'phpmailer/language/');
		$mail->CharSet = substr_replace(_ISO, '', 0, 8);
		//$mail->IsMail();		
		$mail->Subject = 'Test email configuration';	
			
		$mail->isHTML(false);
		$mail->Body = "Test email configuration:\n";
		$mail->Body .= "From             : ".$mail->From."\n";
		$mail->Body .= "Name             : ".$mail->FromName."\n";		
		$mail->Body .= "To               : ".$mail->From."\n";
		$mail->Body .= "Protocol         : ".$mail->Mailer."\n";
		if ( $mail->Mailer != 'sendmail' )
		{
			$mail->Body .= "Email server     : ".$mail->Host."\n";		
			$mail->Body .= "Port             : ".$mail->Port."\n";			
			$mail->Body .= "Authentification : ".($GLOBALS['appshore_data']['my_company']['emailer_auth'] == 'Y')? lang('Yes'):lang('No')."\n";		
		}
		
		$mail->AddAddress($GLOBALS['appshore_data']['my_company']['emailer_from']);
		
		$result['email'] = $mail->Send(); 

        return $result;
    }       
	
}
