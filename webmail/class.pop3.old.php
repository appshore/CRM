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
			// set the decrypt function
			include_once(APPSHORE_INCLUDES.SEP.'cast128/cast128.php');		
			$crypto = new cast128;
        	$crypto->setkey( md5($GLOBALS['appshore_data']['current_user']['user_id']));
        	$account['pop3_password'] = $crypto->decrypt( $account['pop3_password']);

			if( $account['pop3_ssl'] == 'N' )
	    		$options = '/pop3/notls';
	    	else
	    		$options = '/pop3/ssl';//'/novalidate-cert';

    		$mailbox = @imap_open('{'.$account['pop3_server'].':'.$account['pop3_port'].$options.'}INBOX', $account['pop3_username'], $account['pop3_password']);

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

		// set the decrypt function
		include_once(APPSHORE_INCLUDES.SEP.'cast128/cast128.php');		
		$crypto = new cast128;
    	$crypto->setkey( md5($GLOBALS['appshore_data']['current_user']['user_id']));

		foreach( $accounts as $key => $val)
		{
        	$val['pop3_password'] = $crypto->decrypt( $val['pop3_password']);

			if( $val['pop3_ssl'] == 'N' )
				$options = '/pop3/notls';
			else
				$options = '/pop3/ssl';//'/novalidate-cert';

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
			
#				imap_setflag_full($mailbox, '0:'.$mailbox_status->messages, '\\Seen \\Flagged');

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
		
		// get header
		$headers = imap_header( $mailbox, $mailnum);	
	    $currentMail['mail_date']	= $GLOBALS['appshore']->local->datetimeToLocal(date('Y-m-d H:i:s', $headers->udate));				    
		$currentMail['subject']		= $this->decode_header($headers->subject);
		$currentMail['mail_from']	= $this->decode_header($headers->fromaddress);
		$currentMail['reply_to']	= $this->decode_header($headers->reply_toaddress);
		$currentMail['mail_to']		= $this->decode_header($headers->toaddress);			
		$currentMail['mail_cc']		= $this->decode_header($headers->ccaddress);		
		$currentMail['mail_bcc']	= $this->decode_header($headers->bccaddress);	
		
		// init some internal AppShore params	
	    $currentMail['user_id']		= $user_id;
	    $currentMail['folder_id']	= $folder_id;
	    $currentMail['account_id']	= $account_id;			
	    $currentMail['is_read']		= 'N';			
	    $currentMail['bound']		= 'I';			
		
		// get the main structure of the mail
		$structure = imap_fetchstructure( $mailbox, $mailnum);	
		$currentMail['type']		= $this->mailTypes[$structure->type];			
		$currentMail['subtype']		= strtolower($structure->subtype);	
		$currentMail['encoding']	= $this->mailEncodings[$structure->encoding];			
		
		$parts = $structure->parts;
			    
		// check for parts then loop them
		for( $temp_z = 0 ; $temp_z < count($parts) ; $temp_z++) 
		{
			$temp_p = null;
			$temp_b = null;
			$parts_type_main = null;
			$parts_subtype_main = null;

var_dump($parts[$temp_z])."<br/>";				


			if ($parts[$temp_z]->type == "") 
			{
				$parts[$temp_z]->type = 0;
			}
			
			$temp_y = $temp_z + 1;
			$parts_number = '_'.$temp_y;
			$parts_type_main = $this->mailTypes[$parts[$temp_z]->type];
			$parts_type[$parts_number] = $parts_type_main.'/'.strtolower($parts[$temp_z]->subtype);
			$parts_encoding[$parts_number] = $this->mailEncodings[$parts[$temp_z]->encoding];
			$parts_size[$parts_number] = $parts[$temp_z]->bytes;
			
			if (strtolower($parts[$temp_z]->disposition) == 'attachment' || strtolower($parts[$temp_z]->disposition) == 'inline' ) 
			{
				$temp_b = $parts[$temp_z]->dparameters;			
				if(is_array($temp_b) || is_object($temp_b)) 
				{
					reset($temp_b);
					
					while (list(, $temp_p) = each ($temp_b)) 
					{
						if ($temp_p->attribute == 'FILENAME') 
						{
							$currentMail['attachments'][$parts_number]['filename'] = $parts_filename[$parts_number] = $this->decode_header($temp_p->value);
							$currentMail['attachments'][$parts_number]['filesize'] = $parts_filesize[$parts_number] = $parts[$temp_z]->bytes;
						}
					}
				}
			}
			else if ($parts_type_main == 'image') // disposition unknown
			{
				$temp_b = $parts[$temp_z]->parameters;
				if(is_array($temp_b) || is_object($temp_b)) 
				{
					reset($temp_b);
					
					while (list(, $temp_p) = each ($temp_b)) 
					{
						if ($temp_p->attribute == 'NAME') 
						{
							$currentMail['attachments'][$parts_number]['filename'] = $parts_filename[$parts_number] = $this->decode_header($temp_p->value);
							$currentMail['attachments'][$parts_number]['filesize'] = $parts_filesize[$parts_number] = $parts[$temp_z]->bytes;
						}
					}
				}
			}			
				
			/* if there are inline parts dig deeper */
			if ($parts_type_main == 'multipart') 
			{
				$parts_sub = $parts[$temp_z]->parts;
				$parts_sub_count = count($parts_sub);
				
				for ($temp_s = 0; $temp_s < $parts_sub_count; $temp_s++) 
				{
					$temp_t = $temp_s + 1;
					$parts_sub_number = $parts_number.'.'.$temp_t;
					$parts_subtype_main = $this->mailTypes[$parts_sub[$temp_s]->type];
					$parts_type[$parts_sub_number] = $parts_subtype_main.'/'.strtolower($parts_sub[$temp_s]->subtype);
					$parts_encoding[$parts_sub_number] = $this->mailEncodings[$parts_sub[$temp_s]->encoding];
					$parts_size[$parts_sub_number] = $parts_sub[$temp_s]->bytes;
					
					/* 3level parts are rare but we want to be sure */
					if ($parts_subtype_main == 'multipart') 
					{
						$parts_subsub = $parts_sub[$temp_s]->parts;
						$parts_subsub_count = count($parts_subsub);
						
						for ($temp_m = 0; $temp_m < $parts_subsub_count; $temp_m++) 
						{
							$temp_n = $temp_m + 1;
							$parts_subsub_number = $parts_sub_number.'.'.$temp_n;
							$parts_type[$parts_subsub_number] = $this->mailTypes[$parts_subsub[$temp_m]->type].'/'.strtolower($parts_subsub[$temp_m]->subtype);
							$parts_encoding[$parts_subsub_number] = $this->mailEncodings[$parts_subsub[$temp_m]->encoding];
							$parts_size[$parts_subsub_number] = $parts_subsub[$temp_m]->bytes;
						}
					}
				}
			}
		}			
		
		// get the parts of the message we want

		if (is_array($parts_type)) 
		{
			while (list ($key, $val) = each($parts_type)) 
			{
				switch( $val )
				{
					case 'text/plain' :
					case 'message/rfc822' :
						$currentMail['body_text'] .= $this->decode_text( imap_fetchbody( $mailbox, $mailnum, str_replace('_', '', $key)), $parts_encoding[$key]);
						break;

					case 'text/html' : /* we need this just in case message has only html-part */
						$currentMail['body_html'] .= $this->decode_text( imap_fetchbody( $mailbox, $mailnum, str_replace('_', '', $key)), $parts_encoding[$key]);
						break;
						
					case 'multipart/alternative' :
					case 'message/delivery-status':
						break;
						
#					case 'application/msword':
#					case 'application/pdf':
#					case 'image/png':
#					case 'image/gif':
					default : 				// certainly an attachment
						$currentMail['attachments'][$key]['attachment_id'] = generateID();
						$currentMail['attachments'][$key]['type'] = $val;
						$fp = fopen( APPSHORE_ATTACHMENTS.SEP.$currentMail['attachments'][$key]['attachment_id'], 'wb');				
						fwrite( $fp, $this->decode_text( imap_fetchbody( $mailbox, $mailnum, str_replace('_', '', $key)), $parts_encoding[$key]));
						fclose( $fp);
						break;
				}
			}
		/* if the array is empty there's only text so we can simply get the body-part */
		} 
		else 
		{
			/* decode if body is encoded */
			if ($structure->encoding > 0) 
			{
				$currentMail['body_html'] = $this->decode_text(imap_body( $mailbox, $mailnum), $this->mailEncodings[$structure->encoding]);
			} 
			else 
			{
				$currentMail['body_html'] = imap_body( $mailbox, $mailnum);
			}
		}

		/* if we have no text till now we try to check for the html-part */
#		if ( ($currentMail['body_html'] == '') && ($temp_html_key)) 
#		{
#			$currentMail['body_html'] = $this->decode_text(imap_fetchbody( $mailbox, $mailnum, str_replace("_", "", $temp_html_key)), $parts_encoding[$temp_html_key]);
#			//$currentMail['body_html'] = strip_tags($this->decode_text(imap_fetchbody( $mailbox, $mailnum, str_replace("_", "", $temp_html_key)), $parts_encoding[$temp_html_key]));
#		}
	
		/* replacing line breaks according to preferences */
		if( $currentMail['subtype'] != 'html' && $currentMail['body_html'] == '' )
		{
			$currentMail['body_html'] = preg_replace("/(\r\n)|(\r)|(\n)/", '<br/>', $currentMail['body_text']);
		}
		
		/* calculating the message size */
		if (is_array($parts_size)) 
			$currentMail['mail_size'] = array_sum($parts_size);
		else 
			$currentMail['mail_size'] = $structure->bytes;

		/* this will make all data safe for mysql */
		if ($conf_magicquotes == 0) 
		{
			foreach( $currentMail as $temp_k => $temp_v) 
			{
				if( !is_array($temp_v) )
					$currentMail[$temp_k] = addslashes($temp_v);
			}
		}
		
	    if( is_array($currentMail['attachments']) )
	    {
	    	foreach( $currentMail['attachments'] as $key => $val)
	    	{
	    		// store each attachment found
	    		$attachment['mail_id'] = $currentMail['mail_id'];
	    		$attachment['attachment_id'] = $val['attachment_id'];	    		
	    		list( $attachment['type'], $attachment['subtype']) = explode( '/', $val['type']);		    		    		
	    		$attachment['filename'] = $val['filename'];	  
	    		$attachment['filesize'] = $val['filesize'];	 
	    		 	    			    		
	    		insertRow( 'webmail_attachments', 'mail_id', $attachment, false);
	    	}
	    	unset( $currentMail['attachments']);
	    	$currentMail['attachments'] = 'Y';
	    }

		// email is build and ready to be stored
	    insertRow( 'webmail', 'mail_id', $currentMail, false);
	}
	

	/*__________________ decode function ___________________________*/

	function decode_text( $input, $encoding)
	{
		switch ($encoding) 
		{
			case '7bit':
				return $input;
				break;

			case 'quoted-printable':
				$input = preg_replace("/=\r?\n/", '', $input);
				return quoted_printable_decode($input);
				break;

			case 'base64':
				return base64_decode($input);
				break;

			default:
				return $input;
		}
	}

	/*__________________ decodes encoded subject/ name- headers ___________________________*/

	function decode_header ($string)
	{
		if(ereg("=\?.{0,}\?[Bb]\?",$string))
		{
			$arrHead=split("=\?.{0,}\?[Bb]\?",$string);
			
			while(list($key,$value)=each($arrHead))
			{
				if(ereg("\?=",$value))
				{
					$arrTemp=split("\?=",$value);
					$arrTemp[0]=base64_decode($arrTemp[0]);
					$arrHead[$key]=join("",$arrTemp);
				}
			}
			
			$string=join("",$arrHead);
		} 
		elseif (ereg("=\?.{0,}\?[Qq]\?", $string))
		{
			$string = quoted_printable_decode($string);
			$string = ereg_replace("=\?.{0,}\?[Qq]\?","", $string);
			$string = ereg_replace("\?=","", $string);
		}
		
		if (substr_count($string, '@') < 1) 
		{
			$string = str_replace("_", " ", $string);
		}
		
		return $string;
	}

	/*__________________ extracts the name of a full address ___________________________*/

	function get_name ($body)
	{
		if (substr_count($body, '<') < 1 || substr_count($body, '>') < 1) 
		{
			return $body;
			break;
		}
		
		$endposition = strpos($body, '<');
		return trim(substr($body, 0, $endposition));
	}

	/*__________________ extracts substring of string  ___________________________*/

	function get_substring ($body, $start, $end)
	{
		$startposition = strpos($body, $start, 0) + strlen($start);
		if (substr_count($body, $start) < 1 || substr_count($body, $end) < 1) 
		{
			return $body;
			break;
		}
		
		$endposition = strpos($body, $end, 0);
		return substr($body, $startposition, $endposition - $startposition);
	}

    
}
