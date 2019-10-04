<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/
 
require_once ( APPSHORE_LIB.SEP.'class.base.php');

class support_tickets_base extends lib_base
{
    function __construct()
    {
    	$this->appTable 		= 'backoffice_support_tickets';
    	$this->appRecordId		= 'ticket_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appOrderBy		= 'status_id asc, priority_id asc, updated';    	
	    if( $GLOBALS['appshore_data']['my_company']['company_alias'] != 'backoffice' )
			$this->appWhereFilter = 'company_id = "'.$GLOBALS['appshore_data']['my_company']['company_id'].'"';		// filter of the table
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'support_tickets';
    	$this->appNameSingular	= 'support_ticket';    	
    	$this->appLabel 		= 'Tickets';
    	$this->appLabelSingular = 'Ticket';    
    	$this->appXSL	 		= 'support.tickets';
    	$this->appRole 			= 'support';

        parent::__construct();    	
    }
    
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
        $entry['due_date'] = gmdate( 'Y-m-d', strtotime('1 week'));
        $entry['status_id'] = '1OP';
        $entry['priority_id'] = '2NO';   
        $entry['edition_id'] = $GLOBALS['appshore_data']['my_company']['edition_id'];
        $entry['appshore_version'] = $GLOBALS['appshore_data']['my_company']['appshore_version'];
        $entry['company_id'] = $GLOBALS['appshore_data']['my_company']['company_id'];
        $entry['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
        $entry['email'] = $GLOBALS['appshore_data']['current_user']['email'];   
				if( $GLOBALS['appshore_data']['my_company']['company_alias'] == 'backoffice' )
				{
	        $entry['created_by_name'] = lang(CUSTOMER_NAME.' Support Team');   
  	      $entry['updated_by_name'] = lang(CUSTOMER_NAME.' Support Team');   
				}
				else
				{
        	$entry['created_by_name'] = $GLOBALS['appshore_data']['current_user']['full_name'];   
        	$entry['updated_by_name'] = $GLOBALS['appshore_data']['current_user']['full_name'];   
        }
               
        return parent::newEntry( $args, $entry);
    }
    
	function menus()
	{
    	execMethod('support.base.menus');
    	
        $GLOBALS['appshore']->add_xsl($this->appXSL);    

		$GLOBALS['appshore']->add_appmenu($this->appLabel, 'List', 'support.tickets_base.search');
		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_USER_WRITE ) )
        {
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'New ticket', 'support.tickets_base.edit');
		}	
	}
	
	// view one profile
    function start($args = null)
    {
   		$args['status_id'] = '1OP';
    	return $this->search($args);		
    } 	

	// view one profile
    function search( $args = null)
    {
    	// only the current user profile must be accessible
    	$args['company_id'] = $GLOBALS['appshore_data']['my_company']['company_id'];

		$result = parent::search( $args);	

		return $result;	
    } 	

	// view one profile
    function view( $args = null)
    {
    	// only the current company records must be accessible
    	$args['company_id'] = $GLOBALS['appshore_data']['my_company']['company_id'];
		$result = parent::view( $args);	

		return $result;	
    } 	

	
	// view one profile
    function edit( $args = null)
    {
    	// only the current company records must be accessible
	    if( !isset($args[$this->appRecordId]) )
    		$args['company_id'] = $GLOBALS['appshore_data']['my_company']['company_id'];
    	
		switch( $args['key'] )
		{
			case 'Save':
			    $historic = '========== '.date('Y-m-d H:i:s T').', ';
			    if( $GLOBALS['appshore_data']['my_company']['company_alias'] == 'backoffice' )
			    {
			    	$historic .= lang(CUSTOMER_NAME.' Support Team');
			    	$args['updated_by_name'] = lang(CUSTOMER_NAME.' Support Team');   
					}
			    else
			    {
			    	$historic .= $GLOBALS['appshore_data']['my_company']['company_name'].', '.$GLOBALS['appshore_data']['current_user']['full_name'];
			    	$args['updated_by_name'] = $GLOBALS['appshore_data']['current_user']['full_name'];   
					}
				if( $args['status_id'] == '1OP')
			    	$historic .= ', '.lang('ticket open');
				else if( $args['status_id'] == '3CL')
			    	$historic .= ', '.lang('ticket closed');
			    else if( $args['status_id'] == '2AS')
			    	$historic .= ', '.lang('ticket assigned');			    	
			    $historic .= ' =========='."\n".$args['note']."\n\n".$args['historic'];
			    $args['historic'] = $historic;
			    unset( $args['note']);
	    		break;
	     }
    	
			$result = parent::edit( $args);	

    	switch( ($result['Error'] != true) ? $args['key'] : '' )
		{
			case 'Save':
			    // update existing ticket
				if( $result[$this->appNameSingular][$this->appRecordId] == $args[$this->appRecordId])
					$this->sendEmail( $result[$this->appNameSingular]['email'], $args['status_id'], $args['subject'], $args['historic'], 'UPDATED');
				else
					$this->sendEmail( $result[$this->appNameSingular]['email'], $args['status_id'], $args['subject'], $args['historic'], 'CREATED');
	    		break;
	     }

		// update only
	    if( $result['edit_fields'] && ( $result[$this->appNameSingular][$this->appRecordId] == $args[$this->appRecordId]) )
			$result['edit_fields'] = $this->setField( $result['edit_fields'], 'note', array('is_mandatory' => 'N'));		

		// we want historic read only at this level (form) not at the database level
		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'historic', array('is_readonly' => 'Y'));		
		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'updated_by_name', array('is_readonly' => 'Y'));		
		
		
		unset($result[$this->appNameSingular]['note']);

		return $result;	
    } 
    
	function sendEmail( $email, $status_id, $subject, $historic, $stage = 'CREATED') 
	{
  	 	$historic = stripslashes($historic);
  	 	$subject = stripslashes($subject);

		// create mailer class and set up message
		include_once(APPSHORE_LIB.SEP.'lib.emailer.php');		
		$mail = new emailer();    
		      
        $mail->Sender = $mail->From = 'no-reply@'.CUSTOMER_DOMAIN;
		$mail->FromName = CUSTOMER_NAME.' Support Team';
 		$mail->isHTML(true);		

		if( $stage == 'CREATED' )
			$mail->Subject 	= lang(CUSTOMER_NAME.' Support, new ticket').' ';			
		else
		{
			$mail->Subject 	= lang(CUSTOMER_NAME.' Support, ticket updated').' ';
			
			if( $status_id == '1OP')
		    	$mail->Subject .= lang('(Open)').' ';
			else if( $status_id == '3CL')
		    	$mail->Subject .= lang('(Closed)').' ';
		    else if( $status_id == '2AS')
		    	$mail->Subject .= lang('(Assigned)').' ';		
		}
			    		    	
		if( $GLOBALS['appshore_data']['my_company']['company_alias'] == 'backoffice')
			$mail->Subject .= lang('by the '.CUSTOMER_NAME.' Support Team').' ';			

		$mail->Subject .= ': '.$subject;			

  	 
		if( $GLOBALS['appshore_data']['my_company']['company_alias'] == 'backoffice')
		{
			if( $stage == 'UPDATED' ) 
				$mail->Body	= lang("Find below the answer of the ".CUSTOMER_NAME." Support Team.")."<br/>";
		}
  	 	else
			$mail->Body	= lang("The ".CUSTOMER_NAME." Support Team has been informed and will respond as soon as possible.")."<br/>";
		
		$mail->Body	.= lang("Please do not reply to this email. This mailbox is outbound only and you will not receive a response. Go to the ".CUSTOMER_NAME." Support application used to open the ticket instead.")."<br/><br/>";
  	 
		$mail->Body	.= str_replace(array("\n\r","\n","\r"), "<br/>", $historic)."<br/><br/>";
  	         
		$mail->AddAddress($email);
		$mail->AddBCC(SUPPORT_EMAIL);

		$mail->Send(); 
	}	    	

}
