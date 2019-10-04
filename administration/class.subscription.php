<?php
 /***************************************************************************
 * Appshore																	*
 * http://www.appshore.com													*
 * This file written by Brice Michel  bmichel@appshore.com					*
 * Copyright (C) 2004-2009 Brice Michel										*
 ***************************************************************************/

class administration_subscription
{

	function close()
	{
		$args = new safe_args();
		$args->set('key',		NOTSET,'any');
		$args->set('confirm',	NOTSET,'any');
		$args = $args->get(func_get_args());

		$GLOBALS['appshore']->add_xsl('administration.'.PRIVATE_LABEL.'subscription');
		execMethod('administration.company_base.menus', $args, true);

		$result['action']['subscription'] = 'close';

		if( $args['key'] == 'Close' && $args['confirm'] == 'Y' )
		{
			// we send an email of confirmation to the customer
			$this->sendCloseEmail();

			execMethod('base.license.closeAccount');

			$GLOBALS['appshore_data']['layout'] = 'popup';
			$result['action']['subscription'] = 'close_confirmed';
		}
		else if( $args['key'] == 'Close' && $args['confirm'] != 'Y' )
		{
			messagebox( 'You must check the box to confirm the closing of your account', 'error');
		}

		return $result;
	}


	function upgrade()
	{
		$args = new safe_args();
		$args->set('key',			NOTSET,'any');
		$args->set('edition_id',	NOTSET,'any');
		$args->set('period',		1,'number');
		$args = $args->get(func_get_args());


		$GLOBALS['appshore']->add_xsl('administration.'.PRIVATE_LABEL.'subscription');
		execMethod('administration.company_base.menus', $args, true);

		switch($args['key'])
		{
			case 'GoogleWallet':
			case 'Paypal':
			case 'Confirm':
				// delete temporary orders
				executeSQL('delete from company_orders where order_status = "CHE"');

				$agent = getOneAssocArray( 'select payment_email, payment_id from '.BACKOFFICE_DB.'.agents where agent_id = (select agent_id from '.BACKOFFICE_DB.'.customers where company_id = "'.$GLOBALS['appshore_data']['my_company']['company_id'].'")' );
				if( isset($agent['payment_email']) == false )
				{
					$agent['payment_email'] = PAYMENT_EMAIL;
					$agent['payment_id'] = PAYMENT_ID;
				}

				// set the edition
				$order = getOneAssocArray( 'select * from global_editions where edition_id = "'.$args['edition_id'].'"' );
				$order['order_id'] = generateID();
				$order['period'] = $args['period'];
				$order['company_id'] = $GLOBALS['appshore_data']['my_company']['company_id'];
				$order['order_status'] = 'CHE';
				$order['gateway'] = $args['key'];

				unset($order['created']);
				unset($order['updated']);
				unset($order['created_by']);
				unset($order['updated_by']);

				$order['due_date'] = $GLOBALS['appshore']->local->dateToLocal($this->computeDueDate($order));
				$order['amount'] = $this->computeAmount($order);
				$order['order_id'] = insertRow( 'company_orders', 'order_id', $order, false);

				switch( $args['key'])
				{
					case 'GoogleWallet':
						// here information required by Paypal
						$result['google'] = array(
							'merchant_id'			=> 	MERCHANT_ID,
							'item_name_1'			=> 	$this->computeItemName($order),
							'item_description_1'	=> 	$this->computeItemNumber($order),
							'item_price_1'			=> 	$order['amount'],
							'item_quantity_1'		=> 	1,
							'item_currency_1'		=> 	$order['currency_id'],
							'return'				=> 	'&op=administration.'.PRIVATE_LABEL.'subscription.upgrade_success&order_id='.$order['order_id'],
							'cancel_return'			=> 	'&op=administration.'.PRIVATE_LABEL.'subscription.upgrade_cancel&order_id='.$order['order_id']
							);

						// we send an welcome email to the customer
						$this->sendCheckoutMail($order);

						$result['action']['subscription'] = 'GoogleWallet';
						break;

					case 'Paypal':
						// here information required by Paypal
						$result['paypal'] = array(
							'business' 			=> 	$agent['payment_email'],
							//'business' 			=> 	PAYMENT_EMAIL,
	#						'mbr' 				=> 	$agent['payment_id'],
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
						$this->sendCheckoutMail($order);

						$result['action']['subscription'] = 'Paypal';
						break;

					default:
						$result = $this->upgrade_success($order);
						break;
				}
				break;

			case 'Update':
				$result['subscription']['is_update'] = 'true';

			default:
				// retrieve editions available and add some labels
				$result['periods'] = getManyAssocArrays( 'select period_value, period_discount from global_editions_periods order by period_sequence ASC');
				foreach( $result['periods'] as $key => $value)
				{
					if( $value['period_value'] == 0)
						$result['periods'][$key]['period_comment'] = lang('No month added');
					else if( $value['period_value'] == 1)
						$result['periods'][$key]['period_comment'] = lang('%s month added',$value['period_value']);
					else if( $value['period_discount'] == 0)
						$result['periods'][$key]['period_comment'] = lang('%s months added',$value['period_value']);
					else
						$result['periods'][$key]['period_comment'] = lang('%s months added - %s%% discount',$value['period_value'],$value['period_discount']);
				}


				$result['editions'] = getManyAssocArrays( 'select * from global_editions where is_available = "Y" order by edition_sequence ASC');

				foreach( $result['editions'] as $key => $value)
				{
					if( $args['edition_id'] == $value['edition_id'] )
						$edition_id = $args['edition_id'];
					$result['editions'][$key]['combined_edition_name'] = $value['edition_name'].' - '.$value['users_quota'].' '.lang('User'.(($value['users_quota']>1)?'s':'')).' - USD '.$value['price'].' '.lang('per month');
				}

				if( isset($edition_id) == false )
				{
					$args['edition_id'] = $GLOBALS['appshore_data']['my_company']['edition_id'];

					if ( $GLOBALS['appshore_data']['my_company']['edition_id'] == 'TRIAL' )
						$args['edition_id'] = getOneColOneRow('select edition_id from global_editions where is_available = "Y" and users_quota >= (select count(user_id) from users) order by users_quota limit 1');
				}


				if( $args['key'] == 'Update' )
					$result['error'] = $this->checkFields($args);

				if ( $result['error'] == true )
				{
					messagebox( ERROR_INVALID_DATA, ERROR);
					$result['subscription']['new'] = $args;
				}
				else
				{
					// the new due date must be superior to current date
					if( $GLOBALS['appshore_data']['my_company']['due_date'] > '2010-01-01' )
						while( strtotime($GLOBALS['appshore_data']['my_company']['due_date'].' +'.$args['period'].' months') < strtotime('today') )
						{
							if( $args['period'] == 0 )
								$args['period'] = 1;
							else if( $args['period'] == 1 )
								$args['period'] = 3;
							else if( $args['period'] == 3 )
								$args['period'] = 6;
							else if( $args['period'] == 6 )
								$args['period'] = 12;
						}

					$result['subscription']['new']['edition_id'] = $args['edition_id'];
					$result['subscription']['new']['users_quota'] = $args['users_quota'];
					$result['subscription']['new']['period'] = $args['period'];
					$result['subscription']['new']['amount'] = $this->computeAmount($args);
					$result['subscription']['new']['updated'] = 'true';
				}

				// display current parameters
				$edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$GLOBALS['appshore_data']['my_company']['edition_id'].'"' );
				$result['subscription']['current']['edition_name'] = $edition['edition_name'];
				$result['subscription']['current']['edition_id'] = $GLOBALS['appshore_data']['my_company']['edition_id'];
				$result['subscription']['current']['users_quota'] = $GLOBALS['appshore_data']['my_company']['users_quota'];
				$result['subscription']['current']['due_date'] = $GLOBALS['appshore']->local->dateToLocal($GLOBALS['appshore_data']['my_company']['due_date']);

				if( !isset($args['edition_id']) )
					$result['subscription']['new']['edition_id'] = $GLOBALS['appshore_data']['my_company']['edition_id'];
				if( !isset($args['users_quota']) )
					$result['subscription']['new']['users_quota'] = $GLOBALS['appshore_data']['my_company']['users_quota'];
				$result['subscription']['new']['due_date'] = $GLOBALS['appshore']->local->dateToLocal($this->computeDueDate($args));
				if( $GLOBALS['appshore_data']['my_company']['due_date'] == '0000-00-00' )
					unset($result['subscription']['current']['due_date']);

				$result['action']['subscription'] = 'upgrade';
				break;
		}

		return $result;
	}


	// calculate the first payment amount and duration prorata of a previous order
	function computeDueDate( $basket, $local=true)
	{
		if( $basket['period'] < 0 )
			$basket['period'] = 0;

		if( $GLOBALS['appshore_data']['my_company']['due_date'] < '2010-01-01' )
			$due_date = date('Y-m-d',strtotime('now +'.$basket['period'].' months'));
		else
			$due_date = date('Y-m-d',strtotime($GLOBALS['appshore_data']['my_company']['due_date'].' +'.$basket['period'].' months'));

		return $due_date;
	}

	// calculate the first payment amount and duration prorata of a previous order
	function computeAmount( $basket)
	{

		$current_edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$GLOBALS['appshore_data']['my_company']['edition_id'].'"' );
		$new_edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$basket['edition_id'].'"' );

		$amount = $prorataAmount = 0;
		// if the current period is set
		if( $GLOBALS['appshore_data']['my_company']['due_date'] != '0000-00-00' )
		{
			$now = strtotime("now");
			$due = strtotime($GLOBALS['appshore_data']['my_company']['due_date']);
			$delta = round(($due-$now) / (3600*24) / 30, 1);

			// TRIAL users do not have to pay for past period
			if( in_array( $current_edition['edition_id'], array('TRIAL', 'PRO','PRE') ) === false)
			{
				// due date is ahead
				if( $now <= $due )
				{
					$prorataAmount = $delta * ( $new_edition['price'] - $current_edition['price'] );

					if( $current_edition['price'] > $new_edition['price'] && $delta < 0 )
					{
						$prorataAmount = -1 * abs( $prorataAmount );
					}
				}

			}
		}

		// compute the discount
		$discount = getOneColOneRow( 'select period_discount from global_editions_periods where period_value = "'.$basket['period'].'"' );
		$amount += ($new_edition['price']*((100-$discount)/100)*$basket['period']);

//messagebox ( ' pe:'.$basket['period'].'  A:'.$amount . '   P:'.$prorataAmount. '  D:'.$delta.'   N:'.$new_edition['price'].'   C:'.$current_edition['price'], ERROR);

		if( ($prorataAmount+$amount) < 1 )
			$amount = 0;
		else
			$amount += $prorataAmount;

		return round($amount);
	}


	// calculate the first payment amount and duration prorata of a previous order
	function computeItemName( $basket)
	{
		$new_edition = getOneAssocArray( 'select * from global_editions where edition_id = "'.$basket['edition_id'].'"' );

		$itemName = $new_edition['edition_name'].' - ';
		$itemName .= $basket['users_quota'].' user'.(($basket['users_quota']>1)?'s':'');
		$itemName .= ' - Due date '.$basket['due_date'];
		$itemName .= ' - '.$basket['period'].' month'.(($basket['period']>1)?'s':'').' added';

		return $itemName;
	}

	// calculate the first payment amount and duration prorata of a previous order
	function computeItemNumber( $basket)
	{
		$itemNumber = 'Alias='.$GLOBALS['appshore_data']['my_company']['company_alias'];
		$itemNumber .= ',Edition='.$basket['edition_id'];
		$itemNumber .= ',DueDate='.$basket['due_date'];
		$itemNumber .= ',Period='.$basket['period'];

		return $itemNumber;
	}


	// handle cancelation of paypal process
	function upgrade_cancel()
	{
		$args = new safe_args();
		$args->set('order_id',NOTSET,'sqlsafe');
		$args = $args->get(func_get_args());

		$GLOBALS['appshore']->add_xsl('administration.'.PRIVATE_LABEL.'subscription');
		execMethod('administration.company_base.menus', $args, true);

		$result['action']['subscription'] = 'upgrade_cancel';
		return $result;
	}

	// handle success of paypal process
	function upgrade_success()
	{
		$args = new safe_args();
		$args->set('order_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		$GLOBALS['appshore']->add_xsl('administration.'.PRIVATE_LABEL.'subscription');
		execMethod('administration.company_base.menus', $args, true);

		$this->processOrder($args);

		$result['action']['subscription'] = 'upgrade_success';
		return $result;
	}

	// handle success of paypal process
	function processOrder()
	{
		$args = new safe_args();
		$args->set('order_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		if( $args['order_id'] )
			$order = getOneAssocArray('SELECT * FROM company_orders where order_id = "'.$args['order_id'].'"');
		else // we process only the last one
			$order = getOneAssocArray('SELECT * FROM company_orders where order_status = "CHE" order by created DESC');

        //create the new order in BO and set it active : ACT
        $order['order_status'] = 'ACT';

		$due_date = $order['due_date'];
		// set to local time as needed by this function
		$order['due_date'] = $GLOBALS['appshore']->local->dateToLocal($due_date);

		insertRow( BACKOFFICE_DB.'.customers_orders', 'order_id', $order, false);

		// to keep it standard time format
		$order['due_date'] = $due_date;

		// update the company profile in BO
		executeSQL('UPDATE `'.BACKOFFICE_DB.'`.customers
			SET edition_id 		= "'.$order['edition_id'].'",
				company_status 	= "ACT",
				due_date 		= "'.$order['due_date'].'",
				users_quota 	= "'.$order['users_quota'].'",
				records_quota 	= "'.$order['records_quota'].'",
				disk_quota 		= "'.$order['disk_quota'].'",
				emails_quota 	= "'.$order['emails_quota'].'",
				updated 		= "'.gmdate('Y-m-d H:i:s').'"
			WHERE
				company_id = "'.$order['company_id'].'"');

		// update the company profile
		executeSQL('UPDATE company
			SET edition_id 		= "'.$order['edition_id'].'",
				company_status 	= "ACT",
				due_date 		= "'.$order['due_date'].'",
				users_quota 	= "'.$order['users_quota'].'",
				records_quota 	= "'.$order['records_quota'].'",
				disk_quota 		= "'.$order['disk_quota'].'",
				emails_quota 	= "'.$order['emails_quota'].'",
				updated 		= "'.$order['updated'].'"');

		// activate the current order
		executeSQL('UPDATE company_orders SET order_status = "ACT" where order_id = "'.$order['order_id'].'"');

		// cancel the former orders
		executeSQL('UPDATE company_orders SET order_status = "CAN", updated = "'.gmdate('Y-m-d H:i:s').
			'" where order_id not in ("'.$order['order_id'].'")');

        // cancel the former orders in BO
		executeSQL('UPDATE `'.BACKOFFICE_DB.'`.customers_orders SET order_status = "CAN", updated = "'.gmdate('Y-m-d H:i:s').
			'" where company_id = "'.$order['company_id'].'" and order_id not in ("'.$order['order_id'].'")');

		$this->sendSuccessMailCustomer($args);
		$this->sendSuccessMailBackoffice($args);

		// we update the current profile based on the new sub
		execMethod('base.rbac.getCompanyInfos');
	}


	// Check mandatory fields and type of some
	function checkFields( &$args )
	{
		if ( !is_numeric($args['period']) || ($args['period'] < 0) || ($args['period'] > 12) || ($args['period'] != round($args['period'])) )
		{
			$args['period'] = 1;
			return true;
		}

		return false;
	}

	function sendCloseEmail()
	{
		$sep = "<br/>";

		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');
		$mail = new emailer();
		$mail->getEmailerInformation();
		$mail->SMTPKeepAlive = true;
		$mail->isHTML(true);

       	$mail->From 	 = 'subscription@'.CUSTOMER_DOMAIN;
		$mail->FromName  = BRAND.' - Subscription';

		$mail->Subject 	= $GLOBALS['appshore_data']['my_company']['company_alias'].'.'.INSTANCES_DOMAIN.', '.BRAND.' Account closed';

		$mail->Body		= "Closing date: ".gmdate('Y-m-d H:i:s').$sep ;
		$mail->Body 	.= $sep;
		$mail->Body 	.= "By: ".$GLOBALS['appshore_data']['current_user']['full_name'].$sep;
		$mail->Body 	.= "Username: ".$GLOBALS['appshore_data']['current_user']['user_name'].$sep;
		$mail->Body 	.= "Email: ".$GLOBALS['appshore_data']['current_user']['email'].$sep;
		$mail->Body 	.= "Mobile: ".$GLOBALS['appshore_data']['current_user']['mobile'].$sep;
		$mail->Body 	.= "Email: ".$GLOBALS['appshore_data']['current_user']['phone'].$sep;
		$mail->Body 	.= $sep;
		$mail->Body 	.= "Company name: ".$GLOBALS['appshore_data']['my_company']['company_name'].$sep;
		$mail->Body 	.= "Company alias: ".$GLOBALS['appshore_data']['my_company']['company_alias'].'.'.INSTANCES_DOMAIN.$sep;
		$mail->Body 	.= $sep;
		$mail->Body 	.= "Edition: ".$GLOBALS['appshore_data']['my_company']['edition_id'].$sep;

		$mail->AddAddress( 'sales@'.CUSTOMER_DOMAIN);
		$mail->Send();
		$mail->SmtpClose();
	}


    function sendSuccessMailCustomer()
	{
		$args = new safe_args();
		$args->set( 'order_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		$order = getOneAssocArray('select * from company_orders where order_id = "'.$args['order_id'].'"');
		$edition = getOneAssocArray('select * from global_editions where edition_id = "'.$order['edition_id'].'"');

		$sep = "<br/>";
		// create mailer class and set up message
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');
		$mail = new emailer();
        $mail->getEmailerInformation();
		$mail->SMTPKeepAlive = true;
		$mail->isHTML(true);

       	$mail->From 	 = 'subscription@'.CUSTOMER_DOMAIN;
		$mail->FromName  = lang('%(BRAND)s - Subscription', array('BRAND'=>BRAND));

		$mail->Subject = lang('%(BRAND)s: subscription has changed', array('BRAND'=>BRAND));

 		$mail->Body  = lang('Dear %(full_name)s,', array('full_name'=>$GLOBALS['appshore_data']['current_user']['full_name'])).$sep.$sep;
		$mail->Body .= lang('The subscription process has been successfully completed.').$sep.$sep;
		$mail->Body .= lang('The new edition is %(BRAND)s %(edition_name)s, %(users_quota)s users', array('BRAND'=>BRAND,'edition_name'=>$edition['edition_name'],'users_quota'=>$edition['users_quota'])).$sep.$sep;
		$mail->Body .= lang('Thank you for your business').$sep.$sep;
		$mail->Body .= lang('The %(BRAND)s Team', array('BRAND'=>BRAND)).$sep.$sep;

		$mail->AddAddress( $GLOBALS['appshore_data']['current_user']['email']);
		$mail->Send();
		$mail->SmtpClose();
	}

    function sendSuccessMailBackoffice()
	{
		$args = new safe_args();
		$args->set( 'order_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		$order = getOneAssocArray('select * from company_orders where order_id = "'.$args['order_id'].'"');
		$edition = getOneAssocArray('select * from global_editions where edition_id = "'.$order['edition_id'].'"');

		$sep = "<br/>";
		// create mailer class and set up message
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');
		$mail = new emailer();
        $mail->getEmailerInformation();
		$mail->SMTPKeepAlive = true;
		$mail->isHTML(true);

       	$mail->From 	 = 'subscription@'.CUSTOMER_DOMAIN;
		$mail->FromName  = lang('%(BRAND)s - Subscription', array('BRAND'=>BRAND));

		$mail->Subject = 'Subscription changed: '.$GLOBALS['appshore_data']['my_company']['company_name'].' - '.$order['edition_id'].' - '.$order['users_quota'].' users'.' - '.$order['period'].' months';

		$mail->Body  = "Date            : " . gmdate("D M j Y G:i:s").' GMT'.$sep;
		$mail->Body .= "Company name    : " . $GLOBALS['appshore_data']['my_company']['company_name'].$sep;
		$mail->Body .= "Company alias   : " . $GLOBALS['appshore_data']['my_company']['company_alias'].$sep.$sep;

		$mail->Body .= "Edition         : " . $order['edition_id'].$sep;
		$mail->Body .= "Period          : " . $order['period'].$sep;
		$mail->Body .= "Amount paid     : " . $order['amount'].$sep;
		$mail->Body .= "Due date        : " . $order['due_date'].$sep.$sep;

		$mail->Body .= "Users quota     : " . $edition['users_quota'].$sep;
		$mail->Body .= "Records quota   : " . $edition['records_quota'].$sep;
		$mail->Body .= "Disk quota      : " . $edition['disk_quota'].$sep;
		$mail->Body .= "Emails quota    : " . $edition['emails_quota'].$sep.$sep;

		$mail->Body .= "Training        : " . (($GLOBALS['appshore_data']['my_company']['training'] == 'Y')?'Yes':'No').$sep;

		$mail->Body .= "First name      : " . $GLOBALS['appshore_data']['current_user']['first_names'].$sep;
		$mail->Body .= "Last name       : " . $GLOBALS['appshore_data']['current_user']['last_name'].$sep;
		$mail->Body .= "Title           : " . $GLOBALS['appshore_data']['current_user']['title'].$sep;
		$mail->Body .= "Phone           : " . $GLOBALS['appshore_data']['current_user']['phone'].$sep;
		$mail->Body .= "Email           : " . $GLOBALS['appshore_data']['current_user']['email'].$sep;

		$mail->Body .= "Address         : " . $GLOBALS['appshore_data']['my_company']['address'].$sep;
		$mail->Body .= "City            : " . $GLOBALS['appshore_data']['my_company']['city'].$sep;
		$mail->Body .= "State           : " . $GLOBALS['appshore_data']['my_company']['state'].$sep;
		$mail->Body .= "ZipCode         : " . $GLOBALS['appshore_data']['my_company']['zipcode'].$sep;
		$mail->Body .= "Country         : " . $GLOBALS['appshore_data']['my_company']['country_name'].$sep;
		$mail->Body .= "Industry        : " . $GLOBALS['appshore_data']['my_company']['industry_name'].$sep;
		$mail->Body .= "Website         : " . $GLOBALS['appshore_data']['my_company']['url'].$sep;
		$mail->Body .= "Employees       : " . $GLOBALS['appshore_data']['my_company']['employees'].$sep;
		$mail->Body .= "Note            : " . $GLOBALS['appshore_data']['my_company']['note'].$sep;

		$mail->AddAddress( 'sales@'.CUSTOMER_DOMAIN);
		$mail->Send();
		$mail->SmtpClose();
	}

    function sendCheckoutMail()
	{
		$args = new safe_args();
		$args->set( 'order_id', NOTSET, 'sqlsafe');
		$args->set( 'gateway', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		$order = getOneAssocArray('select * from company_orders where order_id = "'.$args['order_id'].'"');

		$sep = "<br/>";
		// create mailer class and set up message
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');
		$mail = new emailer();
        $mail->getEmailerInformation();
		$mail->SMTPKeepAlive = true;
		$mail->isHTML(true);

       	$mail->From 	 = 'subscription@'.CUSTOMER_DOMAIN;
		$mail->FromName  = lang('%(BRAND)s - Subscription', array('BRAND'=>BRAND));

		$mail->Subject = 'Checkout in process: '.$GLOBALS['appshore_data']['my_company']['company_name'].' - '.$order['edition_id'].' - '.$order['users_quota'].' users'.' - '.$order['period'].' months';

		$mail->Body  = "Date            : " . gmdate("D M j Y G:i:s").' GMT'.$sep;
		$mail->Body .= "Company name    : " . $GLOBALS['appshore_data']['my_company']['company_name'].$sep;
		$mail->Body .= "Company alias   : " . $GLOBALS['appshore_data']['my_company']['company_alias'].$sep.$sep;

		$mail->Body .= "Order" .$sep;
		$mail->Body .= "Edition         : " . $order['edition_id'].$sep;
		$mail->Body .= "Due date        : " . $order['due_date'].$sep;
		$mail->Body .= "User quota      : " . $order['users_quota'].$sep;
		$mail->Body .= "Period          : " . $order['period'].$sep;
		$mail->Body .= "Amount          : " . $order['amount'].$sep.$sep;
		$mail->Body .= "Gateway         : " . $args['gateway'].$sep.$sep;

		$mail->Body .= "Subscription" .$sep;
		$mail->Body .= "Due date        : " . $GLOBALS['appshore_data']['my_company']['due_date'].$sep;
		$mail->Body .= "Users quota     : " . $GLOBALS['appshore_data']['my_company']['users_quota'].$sep;
		$mail->Body .= "Records quota   : " . $GLOBALS['appshore_data']['my_company']['records_quota'].$sep;
		$mail->Body .= "Disk quota      : " . $GLOBALS['appshore_data']['my_company']['disk_quota'].$sep;
		$mail->Body .= "Emails quota    : " . $GLOBALS['appshore_data']['my_company']['emails_quota'].$sep.$sep;

		$mail->Body .= "Training        : " . (($GLOBALS['appshore_data']['my_company']['training'] == 'Y')?'Yes':'No') .$sep.$sep;

		$mail->Body .= "First name      : " . $GLOBALS['appshore_data']['current_user']['first_names'].$sep;
		$mail->Body .= "Last name       : " . $GLOBALS['appshore_data']['current_user']['last_name'].$sep;
		$mail->Body .= "Title           : " . $GLOBALS['appshore_data']['current_user']['title'].$sep;
		$mail->Body .= "Phone           : " . $GLOBALS['appshore_data']['current_user']['phone'].$sep;
		$mail->Body .= "Email           : " . $GLOBALS['appshore_data']['current_user']['email'].$sep;
		$mail->Body .= "Address         : " . $GLOBALS['appshore_data']['my_company']['address'].$sep;
		$mail->Body .= "City            : " . $GLOBALS['appshore_data']['my_company']['city'].$sep;
		$mail->Body .= "State           : " . $GLOBALS['appshore_data']['my_company']['state'].$sep;
		$mail->Body .= "ZipCode         : " . $GLOBALS['appshore_data']['my_company']['zipcode'].$sep;
		$mail->Body .= "Country         : " . $GLOBALS['appshore_data']['my_company']['country_name'].$sep;
		$mail->Body .= "Industry        : " . $GLOBALS['appshore_data']['my_company']['industry_name'].$sep;
		$mail->Body .= "Website         : " . $GLOBALS['appshore_data']['my_company']['url'].$sep;
		$mail->Body .= "Employees       : " . $GLOBALS['appshore_data']['my_company']['employees'].$sep;
		$mail->Body .= "Note            : " . $GLOBALS['appshore_data']['my_company']['note'].$sep;

		$mail->AddAddress( 'sales@'.CUSTOMER_DOMAIN);
		$mail->Send();
		$mail->SmtpClose();
	}


}
