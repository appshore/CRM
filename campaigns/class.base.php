<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/
 
require_once ( APPSHORE_LIB.SEP.'class.base.php');

class campaigns_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'campaigns';
    	$this->appRecordId		= 'campaign_id';    	
    	$this->appRecordName	= 'subject';    	
    	$this->appOrderBy		= 'campaign_name';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'campaigns';
    	$this->appNameSingular	= 'campaign';    	
    	$this->appLabel 		= 'Campaigns';
    	$this->appLabelSingular = 'Campaign';    
    	$this->appXSL 			= 'campaigns.base';
    	$this->appRole 			= 'campaigns';	

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

		parent::__construct();
	}
 
	function menus()
	{
	    $GLOBALS['appshore']->add_appmenu('campaigns', 'Search campaigns', 'campaigns.base.search');   	
		if ( $GLOBALS['appshore']->rbac->check('campaigns', RBAC_USER_WRITE ) )
			$GLOBALS['appshore']->add_appmenu('campaigns', 'New campaign', 'campaigns.base.edit');
		$GLOBALS['appshore']->add_appmenu('campaigns', 'Search lists', 'campaigns.lists_base.search');
		if ( $GLOBALS['appshore']->rbac->check('campaigns', RBAC_USER_WRITE ) )
			$GLOBALS['appshore']->add_appmenu('campaigns', 'New list', 'campaigns.lists_base.edit');
		$GLOBALS['appshore']->add_appmenu('campaigns', 'Search records', 'campaigns.records_base.start');
		$GLOBALS['appshore']->add_appmenu('campaigns', 'History', 'campaigns.history_base.start');
#		if( checkEdition() )
#			$GLOBALS['appshore']->add_appmenu('campaigns', 'Preferences', 'campaigns.preferences_base.start');
	} 
	
    function start()
    {
    	
    	// clean up campaigns_records when lists or records have been also deleted
        executeSQL( 'delete from campaigns_records where list_id not in (select list_id from campaigns_lists)');
        executeSQL( 'delete from campaigns_records where table_name = "accounts" and record_id not in (select account_id from accounts)');
        executeSQL( 'delete from campaigns_records where table_name = "contacts" and record_id not in (select contact_id from contacts)');
        executeSQL( 'delete from campaigns_records where table_name = "leads" and record_id not in (select lead_id from leads)');

		return parent::start();
    }	   
	
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
        $entry['type_id'] = 'email';        
        $entry['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
        $entry['from_email'] = $GLOBALS['appshore_data']['current_user']['email'];
        $entry['from_name'] = $GLOBALS['appshore_data']['current_user']['full_name'];        
        return parent::newEntry( $args, $entry);
    }

	function search( $args = null)
    {

    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

    	// update the records count for each list
        executeSQL( 'update campaigns_lists cl set records_count = ( select count(record_id) from campaigns_records cr where cl.list_id = cr.list_id)');

		$result = parent::search( $args);	

    	if( $result[$this->appName])
			foreach( $result[$this->appName] as $key => $val)
			{
				if( $result[$this->appName][$key]['related_list_id'] )
					$result[$this->appName][$key]['related_list_id'] .= ' ('.$this->recordsCount($val['campaign_id']).')';
			}
		
		return $result;
	}     

    function view( $args = null)
    {
	    $emails_quota_available = $GLOBALS['appshore_data']['my_company']['emails_quota'] - $this->emailsQuotaUsed();
	    
	    // in case some users will try to force the email shoot
	    if( $emails_quota_available <= 0  && $args['key'] == 'Send' )
	    	unset($args['key']);
	    	
	    $records_count = $this->recordsCount($args['campaign_id']);

		switch($args['key'])
		{
			case 'Send': // specific case to email campaigns
				$this->emailShot( $args);
				// NO break
			default:	// else we call the parent class
	    		$result = parent::view( $args); 
	    		break;
	    }
	    
	    // we do not want messages for these actions
	    if( in_array( $args['key'], array('Edit','Delete','Duplicate','Print')) )
	    	return $result;
	    	
	    // add a count of records to the name of the list
	    $result[$this->appNameSingular]['related_list_id'] .= ' ('.$records_count.')';
	    
	    //display a message according quota comsuption
	    if( $emails_quota_available <= 0 )
	    	messagebox( 
	    		lang(
	    			'You have no more daily quota of emails available (%(emails_quota)s)', 
	    			array('emails_quota'=>$GLOBALS['appshore_data']['my_company']['emails_quota'])
	    			), 
	    		ERROR);
	    else if ( $emails_quota_available < $records_count)
	    	messagebox( 
	    		lang(
	    			'The daily quota of emails available (%(quota_available)s of %(emails_quota)s) is smaller than the count of records in the list (%(records_count)s)', 
	    			array(
	    				'quota_available'=>$emails_quota_available, 
	    				'emails_quota'=>$GLOBALS['appshore_data']['my_company']['emails_quota'],
	    				'records_count'=>$records_count
	    				)
	    			), 
	    		ERROR);
	    else
	    {
	    	messagebox( 
	    		lang(
	    			'The daily quota of emails available is %(quota_available)s of %(emails_quota)s', 
	    			array(
	    				'quota_available'=>$emails_quota_available, 
	    				'emails_quota'=>$GLOBALS['appshore_data']['my_company']['emails_quota']
	    				)
	    			), 
	    		NOTICE);
	   		$GLOBALS['appshore']->addPlugins( 'ViewButtons');	    		
	    }

        return $result;
    }   	

    function emailShot()
    {
		$args = new safe_args();
		$args->set('campaign_id', 	NOTSET,'any');
		$args->set('key',			NOTSET,'any');
		$args = $args->get(func_get_args());
		
		// get the campaign and list information
		$campaign = getOneAssocArray('select * from campaigns where campaign_id = "'.$args['campaign_id'].'"');
		$campaigns_fields = getManyAssocArrays('select field_name, field_label from campaigns_fields order by field_label');		
									
		// create mailer class and set up message
		include_once(APPSHORE_INCLUDES.SEP.'swift/lib/swift_required.php');		
		//Sendmail
		$transport = Swift_SendmailTransport::newInstance();
		//Create the Mailer using your created Transport
		$mailer = Swift_Mailer::newInstance($transport);
        		
		// main loop
		$nbr = 0;
		$nbrsent = 0;

		$fields = getManyAssocArrays('select * from db_fields where app_name in ("accounts","contacts","leads") group by field_name');

		foreach( array('accounts','contacts','leads') as $app_name)
		{
			$app_label = ucfirst($app_name);
			
			if ($app_name == 'contacts')
				$record_name = 'contact_id';
			else if ($app_name == 'leads')
				$record_name = 'lead_id';
			else
				$record_name = 'account_id';
			
			//init the SQL select that will run the main loop
			$db = executeSQL('SELECT * FROM '.$app_name.
				' WHERE '.$record_name.' in '.
					' ( SELECT record_id from campaigns_records '.
					'   WHERE list_id = "'.$campaign['list_id'].'" '.
					'   AND table_name = "'.$app_name.'")'
				);	
									
			while( !$db->EOF )
			{
				// get the record information
		        $record = $db->GetRowAssoc(false);
		                   
		        if( is_email($record['email']) && $record['email_opt_out'] != 'Y' )
		        {
					// create the message instance        
					$message = Swift_Message::newInstance();
				
					//Set the From address with an associative array
					$message->setFrom( array( $campaign['from_email'] => $campaign['from_name']));

					//Set the To addresses with an associative array
					$message->setTo( array( $record['email'] => $record['full_name']));

					$subject = $campaign['subject'];
					$body_text = $campaign['body_text'];
					$body_html = $campaign['body_html'];			

					// handle generic dynamic fields 
					foreach( $campaigns_fields as $key => $val)
					{
						$subject = str_replace( '{'.$val['field_label'].'}', $record[$val['field_name']], $subject);
						$body_text = str_replace( '{'.$val['field_label'].'}', $record[$val['field_name']], $body_text);
						$body_html = str_replace( '{'.$val['field_label'].'}', $record[$val['field_name']], $body_html);
					}
				
					//handle table specific dynamic fields
					foreach( $fields as $key => $val)
					{
						switch( $val['field_type'])
						{
							case 'DA' :
								$record[$val['field_name']] = $GLOBALS['appshore']->local->dateToLocal($record[$val['field_name']]);
								break;
								
							case 'DD' :
							case 'DF' :
							case 'RR' :			
								$related = getOneAssocArray('select '.$val['related_name'].' from '.
									$val['related_table'].' where '.$val['related_id'].' = "'.$record[$val['field_name']].'"');
								$record[$val['field_name']] = $related[$val['related_name']];
								break;
								
							case 'DS' :
								$record[$val['field_name']] = getfilesize($record[$val['field_name']]);
								break;
								
							case 'DT' :
							case 'TS' :
								$record[$val['field_name']] = $GLOBALS['appshore']->local->datetimeToLocal($GLOBALS['appshore']->local->gmtToTZ($record[$val['field_name']]));
								break;

							case 'RD' :			
							case 'RM' :			
								list($remnbr,$period) = explode('.',$record[$val['field_name']]);
								if( $remnbr != '' && $period != '')
									$record[$val['field_name']] = $remnbr.' '.getOneColOneRow('select period_name from global_notifications_periods where period_id = "'.$period.'"');
								break;																
						}       		
						
						
						$subject = str_replace( '{'.$val['field_label'].'}', $record[$val['field_name']], $subject);
						$body_text = str_replace( '{'.$val['field_label'].'}', $record[$val['field_name']], $body_text);
						$body_html = str_replace( '{'.$val['field_label'].'}', $record[$val['field_name']], $body_html);
					}
		
					//Give it a body
					$message->setSubject( $subject);
					$message->setBody( $body_html?$body_html:$body_text, 'text/html');
					$message->addPart( $body_text, 'text/plain');

					//Send the message
					$result = $mailer->send($message);
		
					$nbrsent++;
				}
			
				$db->MoveNext();
				$nbr++;
			}  
		}		
		//create the second message instance
		$message = Swift_Message::newInstance();
		
		//Set the From address with an associative array
		$message->setFrom( array( $campaign['from_email'] => $campaign['from_name']));

		//Set the To addresses with an associative array
		$message->setTo( array( $GLOBALS['appshore_data']['current_user']['email'] => $GLOBALS['appshore_data']['current_user']['full_name']));

		$subject = lang('Your email campaign: %(campaign_name)s', array('campaign_name'=>$campaign['campaign_name']));			

		$body = lang('%(processed)s records processed.', array('processed'=>$nbr)).'<br/><br/>';
		$body .= lang('%(sent)s emails have been sent successfully.', array('sent'=>$nbrsent)).'<br/><br/>';
		if( $nbrsent < $nbr )
			$body .= lang('%(rejected)s records have been rejected due to invalid or opt out email address.', array('rejected'=>($nbr-$nbrsent))).'<br/><br/>';
		$body .= $campaign['subject'].'<br/><br/>'.$campaign['body_html'];
		
		//Give it a body
		$message->setSubject( $subject);
		$message->setBody( $body, 'text/html');

		//Send the message
		$result = $mailer->send($message);
		
		messagebox( lang('%(processed)s records processed, %(sent)s emails sent, %(rejected)s records rejected', 
			array('processed'=>$nbr,'sent'=>$nbrsent,'rejected'=>($nbr-$nbrsent))), NOTICE);

		$args['status'] = 'SE';
		updateRow( 'campaigns', 'campaign_id', $args, false);	

		$args['list_id'] = $campaign['list_id'];
		$args['records'] = $nbr;
		$args['rejected'] = $nbr-$nbrsent;
		$args['run'] = gmdate('Y-m-d H:i:s');			
		insertRow( 'campaigns_history', 'campaign_id', $args, false);	
		
        return $result;
    }   
    
    // number of emails sent Today
    function emailsQuotaUsed()
    {
			// get the record information
        $quota = getOneAssocArray( 'select sum(records) as emails_sent from campaigns_history where date(created) = curdate()');

        return $quota['emails_sent'];
    } 
    
    // number of records in a list    
    function recordsCount()
    {
		$args = new safe_args();
		$args->set('campaign_id', 	NOTSET,'any');
		$args = $args->get(func_get_args());

			// get the record information
        $records = getOneAssocArray( 'select records_count from campaigns_lists cl, campaigns ca 
        	where campaign_id = "'.$args['campaign_id'].'" and ca.list_id = cl.list_id');

        return $records['records_count'];
    }      
    
    // retrieve date for schedules
    function getScheduleStartDate( $args = null)
    {
        return $GLOBALS['appshore']->local->localToDate($args['due_date']);
    }
    
    // retrieve time for schedules
    function getScheduleStartTime( $args = null)
    {
        return 'NULL';
    }              
    
}
