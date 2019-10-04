<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class backoffice_orders {

	function setOrder()
	{   	
		$args = new safe_args();
		// Allow to retrieve all the cols from this table
		foreach( describeColumns( 'customers_orders') as $fieldName => $fieldValue )
			$args->set( $fieldName, NOTSET, 'any');	
		$args = $args->get(func_get_args());	

        //cancel the former ones
		executeSQL('UPDATE customers_orders SET order_status = "CAN", updated = "'.gmdate('Y-m-d H:i:s').
			'" where company_id = "'.$args['company_id'].'" and order_id not in ("'.$args['order_id'].'")');
			        
        //create the new order to active : ACT
        $args['order_status'] = 'ACT';
		
		if( insertRow( 'customers_orders', 'order_id', $args, false) )
		{     
			executeSQL('
				UPDATE 
					customers 
				SET 
					edition_id 		= "'.$args['edition_id'].'",
					company_status 	= "ACT", 
					due_date 		= "0000-00-00",								
					users_quota 	= "'.$args['users_quota'].'", 
					records_quota 	= "'.$args['records_quota'].'", 
					disk_quota 		= "'.$args['disk_quota'].'", 
					emails_quota 	= "'.$args['emails_quota'].'", 
					updated 		= "'.gmdate('Y-m-d H:i:s').'"
				WHERE 
					company_id = "'.$args['company_id'].'"');	
							
			$this->sendSuccessMail($args); 
		}   
        
        $result['order'] = $args;
        
		return $result;		
	}	
	
	
    function sendSuccessMail( )
	{
		$args = new safe_args();
		$args->set( 'company_id', NOTSET, 'sqlsafe');				
		$args->set( 'order_id', NOTSET, 'sqlsafe');				
		$args = $args->get(func_get_args());	
			
		$sep = "\n";		
		// create mailer class and set up message
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');		
		$mail = new emailer();
        $mail->getEmailerInformation();
        
		$mail->SMTPKeepAlive = true;	
		$mail->isHTML(false);	
  
       	$mail->From 	 = 'subscription@'.CUSTOMER_DOMAIN;
		$mail->FromName  = lang(BRAND.' - Subscription');
		
		$company = getOneAssocArray('select * from customers where company_id = "'.$args['company_id'].'"');
		$order = getOneAssocArray('select * from customers_orders where company_id = "'.$args['company_id'].'" and order_id = "'.$args['order_id'].'"');
		$edition = getOneAssocArray('select * from global_editions where edition_id = "'.$company['edition_id'].'"');
		
		$mail->Subject = "Your AppShore subscription has changed";
		
		$mail->Body  = "Dear ".$company['first_names']." ".$company['last_name'].",".$sep.$sep;
		$mail->Body .= "Paypal informed us that the payment process has been successfully completed.".$sep.$sep;
		$mail->Body .= "Your new Edition is ".$edition['edition_name'].", ".$company['users_quota']." users". $sep.$sep;				
		$mail->Body .= "Thank you for your business.".$sep.$sep;
		$mail->Body .= "The AppShore Team.";

		$mail->AddAddress( $company['email']);

		$mail->Send(); 
				
		// -----------------------------------send to registration@appshore.com------------------------------------

		$mail->Subject = 'Subscription changed: '.$company['company_name'].' - '.$company['users_quota'].' users'.' - '.$edition['edition_name'];

		$mail->Body  = "Date            : " . gmdate("D M j Y G:i:s").' GMT'. $sep;			
		$mail->Body .= "Company name    : " . $company['company_name'] .$sep;		
		$mail->Body .= "Company alias   : " . $company['company_alias'] .$sep;		
		$mail->Body .= "Training        : " . (($company['training'] == 'Y')?'Yes':'No') . $sep;			
		$mail->Body .= "Period          : " . (($order['period'] == 'M')?'Month':'Year'). $sep;		
		$mail->Body .= "Amount per user : " . $order['currency_id '].$order['price'] . $sep;		
		$mail->Body .= "Total amount    : " . $order['currency_id '].($order['price']*$order['users_quota']). $sep;		
		$mail->Body .= "Users quota     : " . $company['users_quota'] . $sep;		
		$mail->Body .= "Records quota   : " . $company['records_quota'] . $sep;		
		$mail->Body .= "Disk quota      : " . $company['disk_quota'] . $sep;	
		if( $company['emails_quota'] > 0 )	
			$mail->Body .= "Emails quota    : " . $company['emails_quota'] . $sep;		
		$mail->Body .= "First name      : " . $company['first_names'] . $sep;
		$mail->Body .= "Last name       : " . $company['last_name'] . $sep;
		$mail->Body .= "Title           : " . $company['title'] . $sep;
		$mail->Body .= "Phone           : " . $company['phone']  . $sep;
		$mail->Body .= "Email           : " . $company['email']  . $sep;
		$mail->Body .= "Address         : " . $company['address'] . $sep;
		$mail->Body .= "City            : " . $company['city'] . $sep;
		$mail->Body .= "State           : " . $company['state'] . $sep;		
		$mail->Body .= "ZipCode         : " . $company['zipcode'] . $sep;
		$mail->Body .= "Country         : " . $company['country_name'] . $sep;
		$mail->Body .= "Industry        : " . $company['industry_name'] . $sep;
		$mail->Body .= "Website         : " . $company['url'] . $sep;		
		$mail->Body .= "Employees       : " . $company['employees'] . $sep;
		$mail->Body .= "Note            : " . $company['note'] . $sep;
			
		$mail->ClearAddresses();
		$mail->AddAddress('registration@appshore.com');

		$mail->Send(); 
		$mail->SmtpClose();				
		
		return;
	}	
	       

}
