<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/
 
class base_notifications
{

    // delete Notification according the related application and record_id 
    function deleteNotification( $args = null)
    {
		$args = new safe_args();
		$args->set('company_id',	$GLOBALS['appshore_data']['my_company']['company_id'],'sqlsafe');
		$args->set('app_name',		NOTSET,'sqlsafe');
		$args->set('record_id',		NOTSET,'sqlsafe');
		$args = $args->get(func_get_args());

		$notifications = getManyAssocArrays('select notification_id, type_id from notifications '.
			' where app_name = "'.$args['app_name'].'" and record_id = "'.$args['record_id'].'"');

		foreach( $notifications as $key => $val )
		{
			executeSQL('delete from notifications where notification_id = "'.$val['notification_id'].'"');
			if( $val['type_id'] == 'E')
    			executeSQL('delete from '.BACKOFFICE_DB.'.customers_notifications '.
	    			'where company_id = "'.$args['company_id'].'" and notification_id = "'.$val['notification_id'].'"');
		} 
    }
    
    // set (create or update) a Notification
    function setNotification( $args = null)
    {
		$args = new safe_args();
		$args->set('company_id',	$GLOBALS['appshore_data']['my_company']['company_id'],'sqlsafe');
		$args->set('user_id',		$GLOBALS['appshore_data']['current_user']['user_id'],'sqlsafe');
		$args->set('app_name',		NOTSET,'sqlsafe');
		$args->set('record_id',		NOTSET,'sqlsafe');
		$args->set('type_id',		NOTSET,'sqlsafe');
		$args->set('status_id',		NOTSET,'sqlsafe');
		$args->set('start_date',	NOTSET,'sqlsafe');
		$args->set('start_time',	NOTSET,'sqlsafe');
		$args->set('interval',		NOTSET,'sqlsafe');
		$args = $args->get(func_get_args());


		// retrieve the notification
		$notification_id = getOneColOneRow('select notification_id from notifications '.
			' where app_name = "'.$args['app_name'].'" and type_id = "'.$args['type_id'].'" and record_id = "'.$args['record_id'].'"');

		// extract period and qty
    	list( $remnbr, $period) = explode('.', $args['interval']);

		// notification is unset
		if( $remnbr == '' || $period == '')
		{
			// if exists it is removed from the table
	    	if( $notification_id )
	    	{
				executeSQL('delete from notifications where notification_id = "'.$notification_id.'"');
    			if( $args['type_id'] == 'E')
    				executeSQL('delete from '.BACKOFFICE_DB.'.customers_notifications '.
    					' where company_id = "'.$args['company_id'].'" and notification_id = "'.$notification_id.'"');
			}

			// unset so we quit
			return;
		}

		// retrieve period name
		$period = getOneColOneRow('select period_name from global_notifications_periods where period_id = "'.$period.'"');

		// calculate timestamp
		if( $args['start_time'] != 'NULL' )
		{
			$notification_datetime = $GLOBALS['appshore']->local->TZToGMT(date('Y-m-d H:i:00', strtotime($args['start_date'].' '.$args['start_time'].' -'.$remnbr.' '.$period)));
			list($notification_date, $notification_time) = explode(' ', $notification_datetime);
			// Notification on past time is deactivated
			if( $notification_datetime <= gmdate('Y-m-d H:i:00') )
				$args['status_id'] = 'D';
			$notification_time = '"'.$notification_time.'"';
		}
		else
		{
			$notification_date = date('Y-m-d', strtotime($args['start_date'].' -'.$remnbr.' '.$period));
			if( $notification_date < gmdate('Y-m-d') )
				$args['status_id'] = 'D';
			$notification_time = 'NULL';			
		}
		
    	if( $notification_id )
    	{	
    		// update the notification
			executeSQL('update notifications set notification_date = "'.$notification_date.'", notification_time = '.$notification_time.
				', status_id = "'.$args['status_id'].'"'.' where notification_id = "'.$notification_id.'"');
     	}
    	else
    	{
    		// insert a new notification
			$notification_id = generateId();
	 		executeSQL('insert into notifications ( `notification_id`, `user_id`, `notification_date`, `notification_time`, `app_name`, `record_id`, `type_id`, `status_id`)'.
	 			' values("'.$notification_id.'","'.$args['user_id'].'","'.$notification_date.'",'.$notification_time.',"'.$args['app_name'].'","'.
	 			$args['record_id'].'", "'.$args['type_id'].'", "'.$args['status_id'].'")');
    	}

    	// set it in BO table
		if( $args['type_id'] == 'E')
		{
	 		executeSQL('replace into '.BACKOFFICE_DB.'.customers_notifications ( `notification_date`, `notification_time`, `company_id`, `notification_id`)'.
	 			' values("'.$notification_date.'",'.$notification_time.',"'.$args['company_id'].'","'.$notification_id.'")');
	 	}
    }	
    
    // retrieve list of notifications
    function getNotifications()
    {
		$args = new safe_args();
		$args->set('user_id',	$GLOBALS['appshore_data']['current_user']['user_id'], 'sqlsafe');
		$args->set('type_id', 	'P', 'sqlsafe'); // popup is the best guest
		$args = $args->get(func_get_args());

		$notification_datetime = gmdate('Y-m-d H:i:00');
		list($notification_date, $notification_time) = explode(' ', $notification_datetime);

		$notifications = getManyAssocArrays('select * from notifications '.
			'where user_id = "'.$args['user_id'].'" and type_id = "'.$args['type_id'].'" '.
			'and notification_date <= "'.$notification_date.'" '.
			'and (notification_time <= "'.$notification_time.'" or notification_time is null) and status_id = "A" '.
			'order by notification_date, notification_time');

		if( $notifications )
			foreach( $notifications as $key => $val)
			{
				if( ($record = execMethod( $val['app_name'].'.notifications.getRecordInformation', $val)) != null )
					$result['notifications'][] = $record;			
			}

 		return isset($result)?$result:null ;
    }  

    // retrieve list of notifications
    function stopNotification()
    {
		$args = new safe_args();
		$args->set('notification_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());

		executeSQL('update notifications set status_id = "D" where notification_id = "'.$args['notification_id'].'"');
    }     
    
	// retrieve and execute email notification    
	function triggerEmailNotifications()
	{
		$args = new safe_args();
		$args->set('notification_date',	gmdate('Y-m-d'), 'sqlsafe');
		$args->set('notification_time',	gmdate('H:i:00'), 'sqlsafe');
		$args = $args->get(func_get_args());

		// create mailer class and set up message
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');		
		$mail = new emailer();
        $mail->getEmailerInformation();
        
#        $mail->Sender = $mail->From = $mail->cleanAddresses('');
		$mail->SMTPKeepAlive = true;	
#		$mail->Mailer = 'sendmail';
		$mail->SetLanguage('en', APPSHORE_INCLUDES.SEP.'phpmailer'.SEP.'language/');
		$mail->CharSet = 'UTF-8';				
        $mail->isHTML( true);	

		if( $args['notification_time'] == 'NULL' )
	    	$notifications = getManyAssocArrays('select * from notifications where notification_date = "'.$args['notification_date'].'" and notification_time is null'
    			.' and status_id = "A" and type_id = "E"');
		else
	    	$notifications = getManyAssocArrays('select * from notifications where notification_date = "'.$args['notification_date'].'" and notification_time = "'.$args['notification_time'].'"'
    			.' and status_id = "A" and type_id = "E" ');

        // we load here the common parameters once for all
		$fields = getManyAssocArrays('select * from global_notifications_fields');		

		if( $notifications )
		{
	    	foreach( $notifications as $key => $val )
	    	{
				if( $record = execMethod( $val['app_name'].'.notifications.getRecordInformation', $val) )
				{
					setlang( $record['language_id']);
					$mail->FromName = $mail->cleanName(lang('The %(BRAND)s Team', array('BRAND'=>BRAND)));            

				    $mail->Subject = lang('notifications.'.$val['app_name'].'.subject', $record);						
				    $mail->Body = lang('notifications.'.$val['app_name'].'.body_html', $record);
				    $mail->AltBody = lang('notifications.'.$val['app_name'].'.body_text', $record);

				    $mail->AddAddress($record['user_email']);
				    $mail->Send(); 
				    $mail->ClearAddresses();
				}
    		}

			if( $args['notification_time'] == 'NULL' )
		    	executeSQL('update notifications set status_id = "D" where notification_date = "'.$args['notification_date'].'" and notification_time is null and type_id = "E"');
			else
	    		executeSQL('update notifications set status_id = "D" where notification_date = "'.$args['notification_date'].'" and notification_time = "'.$args['notification_time'].'" and type_id = "E"');
    	}
		
		$mail->SmtpClose();				
		unset( $mail);
		    	
		// purge and optimize the table
   		executeSQL('delete from notifications where notification_date < "'.$args['notification_date'].'"');
		executeSQL('alter table notifications order by notification_date, notification_time');	    		

		//$result[$this->appName]['status'] = OK;
		$result['status'] = OK;
 		return $result;
	}

}
