<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class opportunities_notifications
{

    function __construct()
    {
    	$this->appTable 		= 'opportunities';
    	$this->appRecordId		= 'opportunity_id';    	
    	$this->appRecordName	= 'opportunity_name';    	
    	$this->appOrderBy		= 'opportunity_name';    	
    	$this->appAscDesc		= 'asc';    	    	
    	$this->appName 			= 'opportunities';
    	$this->appNameSingular	= 'opportunity';    	
    	$this->appLabel 		= 'Opportunities';
    	$this->appLabelSingular = 'Opportunity';    
    	$this->appXSL	 		= 'opportunities.base';
    	$this->appRole 			= 'opportunities';
    }

    function getRecordInformation()
    {
		$args = new safe_args();
		$args->set('notification_id', NOTSET, 'sqlsafe');
		$args->set('record_id', NOTSET, 'sqlsafe');
		$args->set('type_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());
		
		$result = getOneAssocArray('SELECT * FROM '.$this->appTable.' WHERE '.$this->appRecordId.' = "'.$args['record_id'].'"');

#		$result['source_name'] = getOneColOneRow('SELECT source_name FROM sources where source_id = "'.$result['source_id'].'"');
#		$result['stage_name'] = getOneColOneRow('SELECT status_name FROM stages where stage_id = "'.$result['stage_id'].'"');
#		$result['type_name'] = getOneColOneRow('SELECT type_name FROM types where type_id = "'.$result['type_id'].'"');
		
		// retrieve owner's information		
		$user = getOneAssocArray('SELECT * FROM users where user_id = "'.$result['user_id'].'"');
		$result['user_full_name'] = $user['full_name'];
		$result['user_email'] = $user['email'];
		if( $args['type_id'] == 'E' )
			setlang( $result['language_id'] = $user['language_id']);

		$result['appLabel'] = lang($this->appLabelSingular);
		$result['subject'] = $result['opportunity_name'];

		// retrieve related account information		
		$account = getOneAssocArray('SELECT * FROM accounts where account_id = "'.$result['account_id'].'"');
		$result['account_account_name'] = $account['account_name'];
		
		// retrieve related contact information		
		$contact = getOneAssocArray('SELECT * FROM contacts where contact_id = "'.$result['contact_id'].'"');
		$result['contact_full_name'] = $contact['full_name'];
		$result['contact_email'] = $contact['email'];
		$result['contact_phone'] = $contact['phone'];
		$result['contact_mobile'] = $contact['mobile'];

		// build some information from record and owner's profile
		$result['timestamp'] = $GLOBALS['appshore']->local->gmtToTZDateLocal( $result['due_date'], $user['timezone_id'], $user['locale_date_id']);
		$result['link'] = $GLOBALS['appshore']->session->basepath.'/?op='.$this->appName.'.base.view&amp;'.$this->appRecordId.'='.$args['record_id'];
		$result['notification_id'] = $args['notification_id'];
		$result['BRAND'] = BRAND;

 		return $result;
    }   
  
}
