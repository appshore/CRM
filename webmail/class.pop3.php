<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/


class webmail_pop3 {
	var $mailTypes;
	var $mailEncodings;	

	var $htmlmsg,
		$plainmsg,
		$charset = 'UTF-8',
		$is_attachment,
		$mail_size;


    function __construct()
    {
		$this->mailTypes = array( 'text', 'multipart', 'message', 'application', 'audio', 'image', 'video', 'other');
		$this->mailEncodings = array( '7bit', '8bit', 'binary', 'base64', 'quoted-printable', 'other');	
    }
    
    function testAccount()
    {
		$args = new safe_args();
		$args->set('account_id', NOTSET,	'any');
		$args = $args->get(func_get_args());

		$account = getOneAssocArray( 'select * from webmail_accounts where user_id = "'.
			$GLOBALS['appshore_data']['current_user']['user_id'].'" AND account_id = "'.$args['account_id'].'"');
		
		if( $account )
		{	
        	$account['pop3_password'] = base64_decode( $account['pop3_password']);

			if( $account['pop3_ssl'] == 'N' )
	    		$options = '/pop3/notls';
	    	else
	    		$options = '/pop3/ssl/novalidate-cert';

    		$mailbox = imap_open('{'.$account['pop3_server'].':'.$account['pop3_port'].$options.'}INBOX', $account['pop3_username'], $account['pop3_password']) 
				or die('Cannot connect to Gmail: ' . print_r(imap_errors()));

			if( $mailbox )
			{ 
				imap_close( $mailbox);
				return true;
			}
		}
		
		return false;
	}    
           
    // open each remote pop3 accounts, fetch them and fill up local mail database
    function check()
    {

		$accounts = getManyAssocArrays( 'select * from webmail_accounts where user_id = "'.
			$GLOBALS['appshore_data']['current_user']['user_id'].'" AND is_enable = "Y"');
		
		// no account set for this user
		if( $accounts == null )
			return false;
			
		// retrieve the folder_id of Inbox of this user
		$inbox_id = getOneColOneRow( 'select folder_id from webmail_folders where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and folder_type = "inbox"');

		foreach( $accounts as $key => $val)
		{
        	$val['pop3_password'] = base64_decode( $val['pop3_password']);

			if( $val['pop3_ssl'] == 'N' )
				$options = '/pop3/notls';
			else
				$options = '/pop3/ssl/novalidate-cert';

			$mailbox = @imap_open('{'.$val['pop3_server'].':'.$val['pop3_port'].$options.'}INBOX', $val['pop3_username'], $val['pop3_password']);
     	       
        	if( $mailbox )
        	{

				$mailbox_status = imap_status($mailbox, '{'.$val['pop3_server'].':'.$val['pop3_port'].$options.'}INBOX', SA_ALL);
#				if ($mailbox_status) {
#				  messagebox("Messages:   " . $mailbox_status->messages, ERROR);
#				  messagebox("Recent:     " . $mailbox_status->recent, ERROR);
#				  messagebox("Unseen:     " . $mailbox_status->unseen, ERROR);
#				  messagebox("UIDnext:    " . $mailbox_status->uidnext, ERROR);
#				  messagebox("UIDvalidity:" . $mailbox_status->uidvalidity, ERROR);
#				} else {
#				  messagebox("imap_status failed: " . imap_last_error(), ERROR);
#				}  

				$headers = imap_fetch_overview($mailbox,'1:'.$mailbox_status->messages,0);
				
				for( $mailnum = 0; $mailnum < $mailbox_status->messages; $mailnum++) 
				{   		        	       
					// get the raw header, generate unique md5 and check that this email is not already stored
					$mail_id = md5($val['pop3_username'].$headers[$mailnum]->date.$headers[$mailnum]->from.$headers[$mailnum]->to.$headers[$mailnum]->size.$headers[$mailnum]->subject);	

#  messagebox($headers[$mailnum]->uid.', '.$headers[$mailnum]->date.', '.$headers[$mailnum]->from.', '.$headers[$mailnum]->to.', '.$headers[$mailnum]->size.', '.
#  	$headers[$mailnum]->subject.', '.$headers[$mailnum]->seen.', '.$headers[$mailnum]->flagged, ERROR);
		
					if( getOneColOneRow('select mail_id from webmail where mail_id = "'.$mail_id.'"') == null )
						$this->fetchMail( $mailbox, $mailnum+1, $mail_id, $val['account_id'], $GLOBALS['appshore_data']['current_user']['user_id'], $inbox_id);

					if ($val['pop3_lmos'] == 'N') 
						imap_delete( $mailbox, $mailnum+1);
				}
			
				// if preferences say N we suppress all the email from email server
				if ($val['pop3_lmos'] == 'N') 
					imap_expunge( $mailbox);
				
				imap_close( $mailbox);
			}
			else
			{
				messagebox( $val['account_name'].', account unreachable, check your parameters', WARNING);
			}
		}
		
		return true;
	}
	
	function fetchMail( $mailbox, $mailnum, $mail_id, $account_id, $user_id, $folder_id)
	{
		$currentMail['mail_id'] = $mail_id;	
				
		// init some internal AppShore params	
	    $currentMail['user_id']		= $user_id;
	    $currentMail['folder_id']	= $folder_id;
	    $currentMail['account_id']	= $account_id;			
	    $currentMail['is_read']		= 'N';			
	    $currentMail['bound']		= 'I';			

		// input $mailbox = IMAP stream, $mailnum = message id
		// the message may in $this->htmlmsg, $this->plainmsg, or both
		$this->htmlmsg = $this->plainmsg = $charset = '';
		$this->is_attachment = 'N';
		$this->mail_size = 0;

		// BODY
		$structure = imap_fetchstructure( $mailbox, $mailnum);
		$currentMail['type']	 = $this->mailTypes[$structure->type];			
		$currentMail['subtype']	 = strtolower($structure->subtype);	
		$currentMail['encoding'] = $this->mailEncodings[$structure->encoding];			
		
		
		if ( !$structure->parts )  // not multipart
		    $this->getpart( $mailbox, $mailnum, $mail_id, $structure, 0, strtolower($structure->subtype));  // no part-number, so pass 0
		else 
		{  // multipart: iterate through each part
		    foreach ($structure->parts as $partno0 => $part)
		        $this->getpart( $mailbox, $mailnum, $mail_id, $part, $partno0+1, strtolower($structure->subtype));
		}

		// get header
		$headers = imap_header( $mailbox, $mailnum);	
	    $currentMail['mail_date']	= $GLOBALS['appshore']->local->datetimeToLocal(date('Y-m-d H:i:s', $headers->udate));				    

		mb_internal_encoding("UTF-8");
		$currentMail['mail_from']	= mb_decode_mimeheader($headers->fromaddress);
		$currentMail['reply_to']	= mb_decode_mimeheader($headers->reply_toaddress);
		$currentMail['mail_to']		= mb_decode_mimeheader($headers->toaddress);			
		$currentMail['mail_cc']		= mb_decode_mimeheader($headers->ccaddress);		
		$currentMail['mail_bcc']	= mb_decode_mimeheader($headers->bccaddress);	
		$currentMail['subject']		= mb_decode_mimeheader($headers->subject);

		// get bodies
		$currentMail['body_text'] 	= $this->plainmsg;
		$currentMail['body_html'] 	= $this->htmlmsg; //( strlen($this->htmlmsg) > 0 ) ? $this->htmlmsg : $this->plainmsg;

		// we check the charset and apply some conversion if necessary
		if( $this->charset != 'UTF-8' )
		{
			$currentMail['body_text'] = iconv( $this->charset, 'UTF-8//TRANSLIT', $currentMail['body_text']);
			$currentMail['body_html'] = iconv( $this->charset, 'UTF-8//TRANSLIT', $currentMail['body_html']);
		}

		// calculating the message size
		if (is_array($parts_size)) 
			$currentMail['mail_size'] = $this->mail_size;
		else 
			$currentMail['mail_size'] = $structure->bytes;
	
   		$currentMail['attachments'] = $this->is_attachment;
    	
    	// to clean content from invalid character
		/* BMI commented
		foreach( $currentMail as $temp_k => $temp_v) 
		{
			if( !is_array($temp_v) )
				$currentMail[$temp_k] = addslashes($temp_v);
		}
		*/

		// email is build and ready to be stored
	    insertRow( 'webmail', 'mail_id', $currentMail, false);
	}

	function getpart( $mailbox, $mailnum, $mail_id, $p, $partno, $parent_subtype) 
	{
		// DECODE DATA
		$data = ( $partno ) ? 
			imap_fetchbody($mailbox,$mailnum,$partno):  // multipart
		    imap_body($mailbox,$mailnum);  // not multipart
		    
		// Any part may be encoded, even plain text messages, so check everything.
		if ($p->encoding == 4 )
		    $data = quoted_printable_decode($data);
		elseif ( $p->encoding == 3 )
		    $data = base64_decode($data);
		// no need to decode 7-bit, 8-bit, or binary

		$this->mail_size += $p->bytes;

		// PARAMETERS
		// get all parameters, like charset, filenames of attachments, etc.
		$params = array();
		if ($p->parameters)
		    foreach ($p->parameters as $x)
		        $params[strtolower($x->attribute)] = $x->value;
		if ($p->dparameters)
		    foreach ($p->dparameters as $x)
		        $params[strtolower($x->attribute)] = $x->value;

		// ATTACHMENT
		// Any part with a filename is an attachment,
		// so an attached text file (type 0) is not mistaken as the message.
		if ($params['filename'] || $params['name']) 
		{
		    // filename may be given as 'Filename' or 'Name' or both
			$attachment['mail_id'] = $mail_id;
			$attachment['attachment_id'] = generateID();
			$attachment['filename'] =  ( $params['filename'] ) ? $params['filename'] : $params['name'];
			$attachment['type'] = $this->mailTypes[$p->type];
			$attachment['subtype'] = strtolower($p->subtype);
		    // filename may be encoded, so see imap_mime_header_decode()
			$fp = fopen( APPSHORE_ATTACHMENTS.SEP.$attachment['attachment_id'], 'wb');				
			fwrite( $fp, $data);
			fclose( $fp);
			$attachment['filesize'] = filesize(APPSHORE_ATTACHMENTS.SEP.$attachment['attachment_id']);
    		if( ($attachment['disposition'] = strtolower($p->disposition)) == 'attachment' )
	    		$this->is_attachment = 'Y';

    		insertRow( 'webmail_attachments', 'mail_id', $attachment, false);
		}
		else if ( ($p->type == 0 || $p->type == 2) && $data ) // text
		{
		    $this->charset = $params['charset'];  // assume all parts are same charset
		    
		    // Messages may be split in different parts because of inline attachments,
		    // so append parts together with blank row.
		    if( $parent_subtype == 'alternative' )
		    {
			    if ( strtolower($p->subtype) == 'plain' )
			        $this->plainmsg .= trim($data) ."\n";
			    else // html
			        $this->htmlmsg .= $data ."<br>";
			}
			else  // mixed
		    {
		        $this->plainmsg .= trim($data) ."\n";
		        $this->htmlmsg .= $data ."<br>";
			}
		}

		// SUBPART RECURSION
		if ($p->parts) 
		{
		    foreach( $p->parts as $partno0 => $p2 )
		        $this->getpart( $mailbox, $mailnum, $mail_id, $p2, $partno.'.'.($partno0+1), strtolower($p->subtype));  // 1.2, 1.2.1, etc.
		}
	}
	
    
}
