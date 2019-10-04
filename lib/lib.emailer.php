<?php 
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by mf MICHEL <mfmichel@appshore.com>            *
 * Copyright (C) 2004 mf MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */

require_once(APPSHORE_INCLUDES.SEP.'phpmailer'.SEP.'class.phpmailer.php');

class emailer extends PHPMailer
{
	  		        		
	function getEmailerInformation()
 	{ 	    	
		$emailer = getOneAssocArray('SELECT * FROM '.$GLOBALS['appshore_data']['server']['globaldb'].'.emailer limit 1');
				
        $this->Sender = $this->From = $emailer['from'];
		$this->FromName = $emailer['fromname'];
        
       	if( ($this->Mailer = $emailer['mailer']) != 'sendmail' )
       	{
        	$this->Username = $emailer['username'];
               	
	 		include_once(APPSHORE_INCLUDES.SEP.'cast128/cast128.php');		
			$crypto = new cast128;
	        $this->Password = $crypto->decrypt( $emailer['password'], md5('appshore'));
	        
			$this->IsSMTP();
			$this->Host =	$emailer['host'];
			$this->Port =	$emailer['port'];
			$this->SMTPSecure = ($emailer['protocol'])?$emailer['protocol']:'';
			$this->SMTPAuth = ($emailer['auth'] == 'Y')?true:false; 
		}
		
		$this->CharSet = 'UTF-8';		
    }
       
    function cleanAddresses( $address)
    {
    	$address = str_replace( array(",", ";", "\n", "<", ">"), " ", $address);    	
    	$addresses = explode( " ", $address);
    	
    	foreach( $addresses as $key => $val)
    		if( is_email(trim($val)) )
    			$result[] = trim($val);
    			
    	if( is_array($result) )
    		return array_unique($result);
    	else
    		return array();
    }    
    
    function cleanName( $name)
    {
    	$name = str_replace( array(",", ";", "\n", "<", ">"), " ", $name);    	
    	$name = explode( " ", $name);

		$result = '';
    	
    	foreach( $name as $key => $val)
    		if( !is_email(trim($val)) )
    			$result .= ' '.trim($val);
  
   		return $result;
    }   
    
    
    function setUniqueId( $mail_id)
    {
    	list($app_name) = explode('.',$GLOBALS['appshore_data']['api']['op']);
    	return base_convert(gmdate('YmdHis'),10,16).'.'.base64_encode($GLOBALS['appshore_data']['current_user']['user_id'].'.'.$app_name.'.'.$mail_id);
    }           
}
