<?php
 /***************************************************************************
 * Appshore																	*
 * http://www.appshore.com													*
 * This file written by Brice Michel  bmichel@appshore.com					*
 * Copyright (C) 2004-2009 Brice Michel										*
 ***************************************************************************/

require_once ( 'class.subscription.php');

class administration_architect_subscription extends administration_subscription
{

	function upgrade()
	{
		$args = new safe_args();
		$args->set('key',			NOTSET,'any');
		$args->set('edition_id',	NOTSET,'any');
		$args = $args->get(func_get_args());

		$GLOBALS['appshore']->add_xsl('administration.'.PRIVATE_LABEL.'subscription');
		execMethod('administration.company_base.menus', $args, true);

		switch($args['key'])
		{
			case 'Checkout':
			case 'Confirm':
				// delete temporary orders
				executeSQL('delete from company_orders where order_status = "CHE"');

				// set the edition  
				$order = getOneAssocArray( 'select * from global_editions where edition_id = "'.$args['edition_id'].'"' );
				$order['order_id'] = generateID();
				$order['company_id'] = $GLOBALS['appshore_data']['my_company']['company_id'];
				$order['edition_id'] = $args['edition_id'];
				$order['period'] = $args['period'];
				$order['company_id'] = $GLOBALS['appshore_data']['my_company']['company_id'];
				$order['order_status'] = 'CHE';
				$order['users_quota'] = $args['users_quota'];
				$order['disk_quota'] *= $order['users_quota'];
				$order['records_quota'] *= $order['users_quota'];
				$order['emails_quota'] *= $order['users_quota'];
				unset($order['created']);
				unset($order['updated']);
				unset($order['created_by']);
				unset($order['updated_by']);

				$order['due_date'] = $GLOBALS['appshore']->local->dateToLocal($this->computeDueDate($order));
				$order['amount'] = $this->computeAmount($order);
				$order['order_id'] = insertRow( 'company_orders', 'order_id', $order, false);

				if( $args['key'] == 'Checkout' )
				{
					// here information required by Paypal 
					$result['paypal'] = array( 
						'business' 			=> 	PAYMENT_EMAIL,
						'mbr' 				=> 	PAYMENT_ID,
						'item_name'			=> 	$this->computeItemName($order),
						'item_number'		=> 	$this->computeItemNumber($order),
						'no_shipping'		=> 	'1',
						'return'			=> 	'&op=administration.'.PRIVATE_LABEL.'subscription.upgrade_success&order_id='.$order['order_id'],
						'cancel_return'		=> 	'&op=administration.'.PRIVATE_LABEL.'subscription.upgrade_cancel&order_id='.$order['order_id'],
						'no_note'			=> 	'1',
						'currency_code'		=> 	$order['currency_id'],
						'amount'			=> 	$order['amount'],
						'email'				=> 	$GLOBALS['appshore_data']['current_user']['email'],
						'first_name'		=> 	$GLOBALS['appshore_data']['current_user']['first_names'],
						'last_name'			=> 	$GLOBALS['appshore_data']['current_user']['last_name'],
						'address1'			=> 	$GLOBALS['appshore_data']['my_company']['address_billing'],
						'city'				=> 	$GLOBALS['appshore_data']['my_company']['city_billing'],
						'state'				=> 	$GLOBALS['appshore_data']['my_company']['state_billing'],
						'country'			=> 	$GLOBALS['appshore_data']['my_company']['country_billing'],
						'zip'				=> 	$GLOBALS['appshore_data']['my_company']['zipcode_billing']
						);

					// we send an welcome email to the customer
					//$this->sendupgradeMail($);

					$result['action']['subscription'] = 'paypal';
				}
				else
				{
					$result = $this->upgrade_success($order);				
				}
				break;

			default:

				// display current parameters
				$edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$GLOBALS['appshore_data']['my_company']['edition_id'].'" order by edition_sequence' );

				$result['subscription']['current']['edition_name'] = $edition['edition_name'];
				$result['subscription']['current']['edition_id'] = $GLOBALS['appshore_data']['my_company']['edition_id'];
				
				$users = getOneAssocArray( 'select count(*) users_activated from users where status_id = "A"');
				$result['subscription']['current']['users_activated'] = $users['users_activated'];				
				$result['subscription']['current']['users_quota'] = $GLOBALS['appshore_data']['my_company']['users_quota'];
		
				$result['subscription']['current']['due_date'] = $GLOBALS['appshore']->local->dateToLocal($GLOBALS['appshore_data']['my_company']['due_date']);

				if( isset($args['edition_id']) )
					$new_edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$args['edition_id'].'"' );
				else
					$new_edition = getOneAssocArray( 'select * from global_editions where users_quota >= '.$result['subscription']['current']['users_quota'].' and period = "1" order by edition_sequence' );

				$result['subscription']['new']['edition_id'] = $new_edition['edition_id'];
				$result['subscription']['new']['users_quota'] = $new_edition['users_quota'];
				$result['subscription']['new']['due_date'] = $GLOBALS['appshore']->local->dateToLocal($this->computeDueDate($new_edition));
				$result['subscription']['new']['amount'] = $this->computeAmount($new_edition);

				// retrieve editions available and add some labels
				$result['editions'] = getManyAssocArrays( 'select * from global_editions where is_available = "Y" order by edition_sequence ASC');
				         	
				$result['action']['subscription'] = 'upgrade';					
				break;	
		} 

		return $result;
	}

	// calculate the first payment amount and duration prorata of a previous order
	function computeAmount( $basket)   
	{

		$current_edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$GLOBALS['appshore_data']['my_company']['edition_id'].'"' );
		$new_edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$basket['edition_id'].'"' );

		$amount = 0;
		
		// we calculate the prorata update within the current period for the new users
		if( $new_edition['users_quota'] > $current_edition['users_quota'] )
		{
			$amount = $new_edition['price']-$current_edition['price'];
			$now = strtotime("now");
			$due = strtotime($GLOBALS['appshore_data']['my_company']['due_date']);
			if( $due > $now )
				$amount *= ((($due-$now)/(3600*24))/30/$new_edition['period']);
			else
				$amount = 0;
		}

		// add the amount for the new period
		if( $new_edition['period'] != 0 )
			$amount += $new_edition['price'];	
		
		return round($amount);
	}
	

	// calculate the first payment amount and duration prorata of a previous order
	function computeItemName( $order)   
	{
		$new_edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$order['edition_id'].'"' );

		return BRAND.' - '.$new_edition['edition_name'].' - due date '.$order['due_date'];	
	}
	
	// calculate the first payment amount and duration prorata of a previous order
	function computeItemNumber( $order)   
	{
		return $basket['edition_id'].'-DUE_DATE:'.$order['due_date'];	
	}	
	
	
	
    function sendSuccessMailCustomer()
	{
		$args = new safe_args();
		$args->set( 'order_id', NOTSET, 'sqlsafe');				
		$args = $args->get(func_get_args());	

		$edition = getOneAssocArray('select edition_name from global_editions where edition_id = "'.$GLOBALS['appshore_data']['my_company']['edition_id'].'"');
					
		$eol = "<br/>";		
		// create mailer class and set up message
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');		
		$mail = new emailer();
        $mail->getEmailerInformation();
        
		$mail->SMTPKeepAlive = true;	
		$mail->isHTML(true);	
		
		$mail->Subject = "Your ".BRAND." subscription has changed";
		
		$mail->Body  = "Dear ".$GLOBALS['appshore_data']['current_user']['first_names']." ".$GLOBALS['appshore_data']['current_user']['last_name'].",".$eol.$eol;
		$mail->Body .= "The subscription process has been successfully completed.".$eol.$eol;
		$mail->Body .= "The new Edition is ".BRAND." ".$edition['edition_name'].$eol.$eol;				
		$mail->Body .= "The due date is ".$GLOBALS['appshore_data']['my_company']['due_date'].$eol.$eol;				
		$mail->Body .= "Thank you for your business.".$eol.$eol;
		$mail->Body .= "The ".BRAND." Team.";

		$mail->AddAddress( $GLOBALS['appshore_data']['current_user']['email']);
		$mail->Send(); 
		$mail->SmtpClose();				
	}		
	
}
