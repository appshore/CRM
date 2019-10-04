<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class administration_users_password
{
	
	// used when a user requests a new password from the Lost Password form
	function passwordRecovery()
	{
		$args = new safe_args();
		$args->set('email', NOTSET, 'any');
		$args->set('mode', 'RECOVERY', 'any');		
		$args = $args->get(func_get_args());

		if ( is_email($args['email']) )
			$sql = 'SELECT user_id FROM users WHERE email = "'.$args['email'].'" limit 1';
		else
			$sql = 'SELECT user_id FROM users WHERE user_name = "'.$args['email'].'" limit 1';

		$user = getOneAssocArray($sql);
		
		if ( $user['user_id'] )
			return $this->sendNewPassword( array( 'user_id' => $user['user_id'], 'mode' => $args['mode']));
		else
			return NULL;
	}		
			
	function sendNewPassword() 
	{
		$args = new safe_args();
		$args->set('user_id', NOTSET, 'any');
		$args->set('mode', 'RESET', 'any');		
		$args = $args->get(func_get_args());

		// line separator in email
		$sep = "<br/>"; // "\n";
		
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');		
		$mail = new emailer();
        $mail->getEmailerInformation();
		
		$user = getOneAssocArray('SELECT full_name, email FROM users WHERE user_id = "'.$args['user_id'].'"');		
		
		$new_password = $this->generatePassword(8);
	
		executeSQL('UPDATE users SET password = "'.md5($new_password).
			'", last_password_change=convert_tz(now(), "'.$GLOBALS['appshore_data']['server']['timezone_id'].'", "GMT"), updated=convert_tz(now(), "'.
			$GLOBALS['appshore_data']['server']['timezone_id'].'", "GMT"), updated_by="'.
			$GLOBALS['appshore_data']['current_user']['user_id'].'" WHERE user_id = "'.$args['user_id'].'"');
		
 		$mail->isHTML(true);		

       	$mail->From 	 = SUPPORT_EMAIL;
		$mail->FromName  = BRAND;

 		$mail->Body  = lang('Dear %(full_name)s,', array('full_name'=>$user['full_name'])).$sep.$sep;
  	 
		switch ( $args['mode'])
		{
			case 'CREATION':
				$mail->Subject = lang('Welcome to %(BRAND)s, password generated',array('BRAND'=>BRAND));			
				$mail->Body	.= lang('Your user account has been created.').$sep.$sep;
				$mail->Body .= lang('Click this link:').' <a href="'.$GLOBALS['appshore_data']['server']['baseurl'].'">'.$GLOBALS['appshore_data']['server']['baseurl'].'</a>'.$sep.$sep;
				$mail->Body .= lang('You will be able to login using your email address and the following password.').$sep.$sep.$sep;
				break;
			case 'RESET':
				$mail->Subject = lang('%(BRAND)s: New password generated',array('BRAND'=>BRAND));			
				$mail->Body .= lang('Your %(BRAND)s Administrator has requested a new password for you.',array('BRAND'=>BRAND)).$sep.$sep.$sep;
				$mail->Body .= lang('Click this link:').' <a href="'.$GLOBALS['appshore_data']['server']['baseurl'].'">'.$GLOBALS['appshore_data']['server']['baseurl'].'</a>'.$sep.$sep;
				break;
			case 'RECOVERY':				
			default:
				$mail->Subject = lang('%(BRAND)s: New password generated',array('BRAND'=>BRAND));			
				$mail->Body .= lang('You have requested a new password. If you did not request this new password, please contact your %(BRAND)s Administrator.',array('BRAND'=>BRAND)).$sep.$sep.$sep;
				$mail->Body .= lang('Click this link:').' <a href="'.$GLOBALS['appshore_data']['server']['baseurl'].'">'.$GLOBALS['appshore_data']['server']['baseurl'].'</a>'.$sep.$sep;
		}
  	 
		$mail->Body	.= lang('Password is %(password)s',array('password'=>$new_password)).$sep.$sep.$sep;
		$mail->Body .= lang('If you would like to change this password after you login to your account go to Preferences > Change Password.').$sep.$sep;

		$mail->Body .= lang('If you have any difficulties please contact your %(BRAND)s Administrator.',array('BRAND'=>BRAND)).$sep.$sep; 
		$mail->Body .= lang('The %(BRAND)s Team', array('BRAND'=>BRAND)).$sep.$sep; 
  	   	         
		$mail->AddAddress( $user['email']);

		$mail->Send(); 

		return true;
	}	

	function generatePassword($length)
	{
  	     $vowels = array("a", "e", "i", "u", "y", "A", "E", "I", "U", "Y");
  	     $cons = array("b", "c", "d", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "z", "tr",
  	     	"cr", "br", "fr", "th", "dr", "ch", "pH", "wr", "st", "sp", "sw", "pr", "sl", "cl",
  	    	 "B", "C", "D", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Z", "Tr",
  	    	 "CR", "xR", "fD", "TH", "DR", "Ch", "cH", "PH", "Wr", "ST", "SP", "Sw", "Pz", "sL", "cQ");
  	     $numbers = array("2", "3", "4", "5", "6", "7", "8", "9");
  	 
  	     $num_vowels = count($vowels);
  	     $num_cons = count($cons);
  	     $num_numbers = count($numbers);
  	     $password="";
  	 
         $password = $cons[rand(0, $num_cons - 1)] . $vowels[rand(0, $num_vowels - 1)].$numbers[rand(0, $num_number - 1)];
         $password .= $cons[rand(0, $num_cons - 1)] . $vowels[rand(0, $num_vowels - 1)].$numbers[rand(0, $num_number - 1)];
         $password .= $cons[rand(0, $num_cons - 1)] . $vowels[rand(0, $num_vowels - 1)].$numbers[rand(0, $num_number - 1)];
   	 
  	     return substr($password, 0, $length);
	}		
}
