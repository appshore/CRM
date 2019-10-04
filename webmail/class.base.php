<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/


require_once ( APPSHORE_LIB.SEP.'class.base.php');

class webmail_base extends lib_base
{
    var $folders ;

    function __construct()
    {
    	$this->appTable 		= 'webmail';
    	$this->appRecordId		= 'mail_id';
    	$this->appRecordName	= 'subject';
    	$this->appOrderBy		= 'mail_date';
    	$this->appAscDesc		= 'desc';
    	$this->appName 			= 'webmail';
    	$this->appNameSingular	= 'mail';
    	$this->appLabel 		= 'Webmail';
    	$this->appLabelSingular = 'Email';
    	$this->appXSL 			= 'webmail.base';
    	$this->appRole 			= 'webmail';

    	if( !isset($_SESSION[$this->appName]) )
    	{
	        // this place needs to be clean when it's called by others apps
			require_once ( APPSHORE_LIB.SEP.'lib.files.php');
	        checkDirectory( APPSHORE_ATTACHMENTS);

			// we test existence of default folders
			execMethod('webmail.folder.foldersSetup', null, true);
		}

		$this->folders = execMethod('webmail.folder.foldersList');

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

		parent::__construct();
	}


    function menus()
    {
		$GLOBALS['appshore']->add_appmenu('webmail', 'Check Mailboxes', 'webmail.base.checkMailboxes');
		$GLOBALS['appshore']->add_appmenu('webmail', 'Search '.strtolower($this->appLabel), 'webmail.base.search');
		if ( $GLOBALS['appshore']->rbac->check('webmail', RBAC_USER_WRITE ) )
		{
			$GLOBALS['appshore']->add_appmenu('webmail', 'New '.strtolower($this->appLabelSingular), 'webmail.base.edit');
			$GLOBALS['appshore']->add_appmenu('webmail', 'Empty trash', 'webmail.folder.emptyTrash');
			$GLOBALS['appshore']->add_appmenu('webmail', 'Setup', 'webmail.setup.start');
		}
    }

    // to initialize the context
    function reset()
    {
		if (!isset($_SESSION[$this->appName]))
		{
			// Save context in cookie SESSION_SID
			$this->defaultSessionApp();
			$_SESSION[$this->appName][$this->appRecordName] = '';
			$_SESSION[$this->appName]['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
			$_SESSION[$this->appName]['folder_id'] = searchArray( $this->folders, 'folder_type',  'inbox', 'folder_id' );
			$_SESSION[$this->appName]['first'] = 0;
			$_SESSION[$this->appName]['currentVal'] = 0;
			$_SESSION[$this->appName]['countMax'] = 0;
		}
    }

	function checkMailboxes()
    {
    	if( execMethod('webmail.pop3.check') == false )
    	{
    		messagebox( 'Set and activate an external account', WARNING);
    		return execMethod('webmail.setup_accounts.edit');
    	}

	   	return $this->search();
	}


	function search( $args = null)
    {
		if( isset($args['folder_id']) )
			$_SESSION[$this->appName]['folder_id'] = $args['folder_id'];
		else
			$args['folder_id'] = $_SESSION[$this->appName]['folder_id'];

		$folder = searchArray( $this->folders, 'folder_id',  $args['folder_id']);

		if( $folder['folder_type'] == 'all')
		{
			unset($args['folder_id']);
			unset($_SESSION[$this->appName]['folder_id']);
		}

		if( $args['key'] == 'Clear')
		{
			unset($args);
			unset($_SESSION[$this->appName]);
	    	$this->reset();
			return $this->search();
		}
		else
			$result = parent::search( $args);

    	if( $result[$this->appName])
			foreach( $result[$this->appName] as $key => $val)
			{
				$files = getOneAssocArray('select count(*) as files_count, sum(filesize) as files_size
					from webmail_attachments where mail_id = "'.$val['mail_id'].'" and disposition = "attachment"');

				$documents = getOneAssocArray('select count(*) as documents_count, sum(filesize) as documents_size
					from documents left outer join webmail_documents on webmail_documents.document_id = documents.document_id
					where mail_id = "'.$val['mail_id'].'"');

				$result[$this->appName][$key]['attachments'] = $files['files_count'] + $documents['documents_count'];
				$result[$this->appName][$key]['mail_size'] = getfilesize($val['mail_size'] + $files['files_size'] + $documents['documents_size']);

			}

		$result['result_fields'] = $this->setField( $result['result_fields'], 'mail_to', array(
			'field_type' => 'VF'
			));

		$result['folders'] = $this->folders;

		if( $result['bulk_fields'] )
			foreach( $result['bulk_fields'] as $key => $value )
			{
				if ( $result['bulk_fields'][$key]['field_name'] == 'bulk_folder_id' )
				{
					$result['bulk_fields'][$key]['field_options'] = getManyAssocArrays( 'select folder_id as option_id, folder_name as option_name from webmail_folders where folder_type not in ("all","archive") and user_id = "'.
						$GLOBALS['appshore_data']['current_user']['user_id'].'" order by sequence, folder_name');
					break;
				}
			}

		if( $folder['folder_id'] )
			$result['folder'] = searchArray( $this->folders, 'folder_id',  $folder['folder_id']);
		else
			$result['folder'] = searchArray( $this->folders, 'folder_type',  'all');

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');

		return $result;
	}


    // we build the SQL request based on search, result fields and filter criterias
	function buildSQL( $args=null, $search_fields=null, $result_fields=null, $session_popup = '')
	{

		// set filter according folder name, no filter if folder == all
		if( $_SESSION[$this->appName]['folder_id'] != 'all' )
		{
			$args['folder_id'] = $_SESSION[$this->appName]['folder_id'];
			$search_fields[] = array('field_name' => 'folder_id','field_type' => 'RE');
			$sql = parent::buildSQL( $args, $search_fields, $result_fields);
		}
		else
		{
			$sql = parent::buildSQL( $args, $search_fields, $result_fields);
			$sql = str_replace( 'WHERE 1=1', 'WHERE folder_type not in ("trash","junk")', $sql);
		}

    	return $sql;
	}

	// view webmail
    function view( $args = null)
    {
		switch($args['key'])
		{
			case 'Reply':
			case 'ReplyAll':
    			$args['bound'] = 'D';
    			$previous_mail_id = $args['mail_id'];
    			unset($args['mail_id']);
				$result = $this->edit( $args);

	   			$result[$this->appNameSingular]['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
				$previous_mail = getOneAssocArray( 'select * from webmail where mail_id = "'.$previous_mail_id.'"');
    			$header = '<b>From:</b> '.$this->cleanupEmailAddress($previous_mail['mail_from']).'<br/>'.
    			$header .= '<b>To:</b> '.$this->cleanupEmailAddress($previous_mail['mail_to']).'<br/>';
    			if( strlen($previous_mail['mail_cc']))
	    			$header .= '<b>Cc:</b> '.$this->cleanupEmailAddress($previous_mail['mail_cc']).'<br/>';
	    		$header .= '<b>Date:</b> '.$previous_mail['mail_date'].'<br/>';
	    		$header .= '<b>Subject:</b> '.$previous_mail['subject'].'<br/>';

				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'mail_to', array( 'field_current_value' => $previous_mail['mail_from']));
				if( $args['key'] == 'Reply' )
				{
					unset($result[$this->appNameSingular]['mail_cc']);
					unset($result[$this->appNameSingular]['mail_bcc']);
				}
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'mail_from',
					array( 'field_current_value' => $GLOBALS['appshore_data']['current_user']['full_name'].' <'.$GLOBALS['appshore_data']['current_user']['email'].'>'));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'is_read', array( 'field_current_value' => 'Y'));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'bound', array( 'field_current_value' => 'D'));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'folder_id',
					array( 'field_current_value' => searchArray( $this->folders, 'folder_type',  'draft', 'folder_id' )));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'subject',
					array( 'field_current_value' => 'Re: '.$previous_mail['subject']));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'body_html',
					array( 'field_current_value' => '<br/><br/><BLOCKQUOTE TYPE=CITE><PRE>---- Start Original Message ----<br/>'.
	    				$header.$previous_mail['body_html'].'<br/>---- End Original Message ----</PRE></BLOCKQUOTE>'));


    			//$result[$this->appNameSingular]['mail_id'] = generateID();
				//insertRow( 'webmail', 'mail_id', $result[$this->appNameSingular], false);
    			break;

			case 'Forward':
    			$args['bound'] = 'D';
    			$previous_mail_id = $args['mail_id'];
				$result = $this->edit( $args);
    			unset($args['mail_id']);
    			unset($result[$this->appNameSingular]['mail_id']);

	   			$result[$this->appNameSingular]['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];

				$previous_mail = getOneAssocArray( 'select * from webmail where mail_id = "'.$previous_mail_id.'"');
    			$header = '<b>From:</b> '.$this->cleanupEmailAddress($previous_mail['mail_from']).'<br/>'.
    			$header .='<b>To:</b> '.$this->cleanupEmailAddress($previous_mail['mail_to']).'<br/>';
    			if( strlen($previous_mail['mail_cc']))
	    			$header .= '<b>Cc:</b> '.$this->cleanupEmailAddress($previous_mail['mail_cc']).'<br/>';
	    		$header .= '<b>Date:</b> '.$previous_mail['mail_date'].'<br/>';
	    		$header .= '<b>Subject:</b> '.$previous_mail['subject'].'<br/>';

				unset($result[$this->appNameSingular]['mail_to']);
				unset($result[$this->appNameSingular]['mail_cc']);
				unset($result[$this->appNameSingular]['mail_bcc']);

				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'mail_from',
					array( 'field_current_value' => $GLOBALS['appshore_data']['current_user']['full_name'].' <'.$GLOBALS['appshore_data']['current_user']['email'].'>'));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'is_read', array( 'field_current_value' => 'Y'));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'bound', array( 'field_current_value' => 'D'));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'folder_id',
					array( 'field_current_value' => searchArray( $this->folders, 'folder_type',  'draft', 'folder_id' )));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'subject',
					array( 'field_current_value' => 'Fwd: '.$previous_mail['subject']));
				$result['edit_fields'] = $this->setField( $result['edit_fields'], 'body_html',
					array( 'field_current_value' => preg_replace('/"/','\'','<br/><br/>---- Forwarded Message ----<br/>'.
	    				$header.$previous_mail['body_html'].'<br/>')));

				// retrieve attachment and documents associated with the email
				$result['files'] = getManyAssocArrays('select attachment_id, filename from webmail_attachments where mail_id = "'.$previous_mail_id.'" and disposition="attachment"');
				$result['documents'] = getManyAssocArrays('select documents.document_id, document_name from documents
					left outer join webmail_documents on webmail_documents.document_id = documents.document_id where mail_id = "'.$previous_mail_id.'"');
    			//$temp_mail_id = generateID();
    			//$this->copyAllAttachments( $result[$this->appNameSingular]['mail_id'], $temp_mail_id);
    			//$result[$this->appNameSingular]['mail_id'] = $temp_mail_id;
				//insertRow( 'webmail', 'mail_id', $result[$this->appNameSingular], false);
    			break;

			default:
				$result = parent::view( $args);
				if( $result['action'][$this->appName] != 'view' )
					return $result;

				if( $result[$this->appNameSingular]['bound'] == 'D' )
				{
					$result = $this->edit( $args);
				}
				else
				{
					if( $result[$this->appNameSingular]['is_read'] == 'N' )
					{
	       				$args['is_read'] = 'Y';        // we update the read status of this email because we just open it
						updateRow( 'webmail', 'mail_id', $args, false);
					}

					// check for embededded media and make them usable in this context
					$result['view_fields'] = $this->setField( $result['view_fields'], 'body_html', array(
						'field_current_value' => $this->embeddedMedia($result[$this->appNameSingular]['mail_id'], $result[$this->appNameSingular]['body_html'])
						));

					// retrieve attachment and documents associated with this email
					$result['files'] = getManyAssocArrays('select attachment_id, filename from webmail_attachments where mail_id = "'.$result[$this->appNameSingular]['mail_id'].'" and disposition="attachment"');
					$result['documents'] = getManyAssocArrays('select documents.document_id, document_name from documents
						left outer join webmail_documents on webmail_documents.document_id = documents.document_id where mail_id = "'.$result[$this->appNameSingular]['mail_id'].'"');

					$result['folders'] = $this->folders;
				}

				break;
		}

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');
		return $result;
	}



	// edit webmail
    function edit(  $args = null)
    {

 		switch($args['key'])
		{
			case 'Cancel':
		    	$result = $this->search();
				break;

			case 'Send':
        		$args['folder_id'] = searchArray( $this->folders, 'folder_type',  'sent', 'folder_id' );
       			$args['bound'] = 'O';
       			$args['is_read'] = 'Y';
				$args['mail_date'] = gmdate('Y-m-d H:i:s');

                // check mandatory fields
           		if ( $this->checkFields($args) == false )
                {
                    unset($args['key']);
                    $result = array_merge( (array)$this->edit($args), (array)$result);
 					$result['documents'] = getManyAssocArrays('select document_id, document_name from documents where document_id in ("'.implode('","',explode(',',$args['selectedDocuments'])).'")');
					return $result;
                }
                $args['body_text'] = strip_tags($args['body_html']);
                $args['mail_size'] = strlen($args['mail_from'])+strlen($args['mail_to'])+strlen($args['mail_cc'])+strlen($args['mail_bcc']);
                $args['mail_size'] += strlen($args['subject'])+strlen($args['body_html'])+strlen($args['body_text']);

				if ($args['mail_id']) // UPDATE an existing record
				{
					if( updateRow( 'webmail', 'mail_id', $args, false) == NULL )
						$result[$this->appNameSingular] = $args;
				}
				else // New record so we do an INSERT
				{
					unset($args['mail_id']);
 					if ( ($args['mail_id'] = insertRow( 'webmail', 'mail_id', $args, false)) == NULL )
	                    $result[$this->appNameSingular] = $args;
				}

				$this->addFiles( $args['selectedFiles'], $args['mail_id']);
				$this->addDocuments( $args['selectedDocuments'], $args['mail_id']);

				$result = $this->sendEmail($args['mail_id']);
        		messagebox( lang('Email sent'), NOTICE);

				return $this->view($args);
				break;

			case 'Save': // as a draft
        		$args['folder_id'] = searchArray( $this->folders, 'folder_type',  'draft', 'folder_id' );
       			$args['bound'] = 'D';
       			$args['is_read'] = 'Y';
				$args['mail_date'] = gmdate('Y-m-d H:i:s');

                $args['body_text'] = strip_tags($args['body_html']);
                $args['mail_size'] = strlen($args['mail_from'])+strlen($args['mail_to'])+strlen($args['mail_cc'])+strlen($args['mail_bcc']);
                $args['mail_size'] += strlen($args['subject'])+strlen($args['body_html'])+strlen($args['body_text']);

				if ($args['mail_id']) // UPDATE an existing record
				{
					if( updateRow( 'webmail', 'mail_id', $args, false) == NULL )
						$result[$this->appNameSingular] = $args;
				}
				else // New record so we do an INSERT
				{
					unset($args['mail_id']);
 					if ( ($args['mail_id'] = insertRow( 'webmail', 'mail_id', $args, false)) == NULL )
	                    $result[$this->appNameSingular] = $args;
				}

				// we add attachments and documents
				$this->addFiles( $args['selectedFiles'], $args['mail_id']);
				$this->addDocuments( $args['selectedDocuments'], $args['mail_id']);

        		messagebox( lang('Email draft saved'), NOTICE);

				unset($args['key']);
				return $this->edit($args);
				break;

			default:
				$mail = getOneAssocArray('select bound from webmail where mail_id = "'.$args['mail_id'].'"');
				if( $mail['bound'] == 'D' || $args['bound'] == 'D' || !$args['mail_id'])
					$result = parent::edit( $args);
				else
					$result = parent::view( $args);

				if ($result[$this->appNameSingular]['mail_id'])
				{
					// retrieve attachment and documents associated with this email
					$result['files'] = getManyAssocArrays('select attachment_id, filename from webmail_attachments where mail_id = "'.$result[$this->appNameSingular]['mail_id'].'" and disposition="attachment"');
					$result['documents'] = getManyAssocArrays('select documents.document_id, document_name from documents
						left outer join webmail_documents on webmail_documents.document_id = documents.document_id where mail_id = "'.$result[$this->appNameSingular]['mail_id'].'"');
				}
				else
				{
                    $result[$this->appNameSingular] = $this->newEntry( $args, null);
				}


				$result['priorities'] = getManyAssocArrays('select * from webmail_priorities order by priority_id');
				$result['folders'] = $this->folders;
				break;
		}

		//if( $result['files'] || $result['documents'] )
	//	{
			//$result['view_fields'] = $this->setField( $result['view_fields'], 'is_attachment', array( 'field_type' => 'AT'));
	//	}

		if( $result['edit_fields'] )
		{
			$result['edit_fields'] = $this->setField( $result['edit_fields'], 'mail_from', array(
				'field_type' 			=> 'DD',
				'field_current_value' 	=> $GLOBALS['appshore_data']['current_user']['full_name'].' <'.$GLOBALS['appshore_data']['current_user']['email'].'>',
				'field_options' 		=> $this->listAccounts()
				));
		}

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');

        return $result;
    }

    function newEntry( $args = null, $entry = null)
    {
		$entry['mail_from'] = $GLOBALS['appshore_data']['current_user']['full_name'].' <'.$GLOBALS['appshore_data']['current_user']['email'].'>';
		$entry['priority_id'] = 'NO';

        return parent::newEntry( $args, $entry);
    }

    function listAccounts()
    {
		$mail_from = $GLOBALS['appshore_data']['current_user']['full_name'].' <'.$GLOBALS['appshore_data']['current_user']['email'].'>';
		$result[] = array( 'option_id' => $mail_from, 'option_name' => $mail_from);

    	$accounts = getManyAssocArrays('select account_name, email from webmail_accounts where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
    	if( $accounts )
    	{
    		foreach( $accounts as $key => $val)
    		{
				$mail_from = $val['account_name'].' <'.$val['email'].'>';
    			$result[] = array( 'option_id' => $mail_from, 'option_name' => $mail_from);
    		}
    	}
        return $result;
    }


    function deleteRecord( $record_id, $verbose=false)
    {

		// if the webmail is not in Trash we just move it in without deletion
		$mail = getOneAssocArray( 'select folder_id from webmail where mail_id = "'.$record_id.'"');
		$webmail['folder_id'] = searchArray( $this->folders, 'folder_type',  'trash', 'folder_id' );
		if( $mail['folder_id'] != $webmail['folder_id'] )
		{
			$webmail['mail_id'] = $record_id;
			if( updateRow( 'webmail', 'mail_id', $webmail, false) == true )
				return true;
		}


    	// do the default delete operation then the specific ones
		if ( ($truefalse = parent::deleteRecord( $record_id, $verbose)) == true )
		{
			$record[$this->appRecordId] = $record_id;

			// remove all attachment records for this record_id
			$attachments = getManyAssocArrays( 'select attachment_id from webmail_attachments where mail_id = "'.$record_id.'"');
			if( $attachments )
			{
		   		foreach( $attachments as $key => $value )
		   		{
	           		if (is_file(APPSHORE_ATTACHMENTS.SEP.$value['attachment_id']) )
						unlink( APPSHORE_ATTACHMENTS.SEP.$value['attachment_id']);
				}

				deleteRow( 'webmail_attachments', $this->appRecordId, $record, false);
			}

			// remove all documents records for this record_id
			deleteRow( 'webmail_documents', $this->appRecordId, $record, false);
		}

		return $truefalse;
    }


   function addFiles( $list, $mail_id)
   {
   		// we suppress each file that have been unselected in the email form
		if( $selected = explode( ',', $list) )
		{
			foreach( $selected as $key => $val)
			{
				if( $val[0] == '-' )
				{
					list( $void, $attachment_id) = explode( '-', $val);
					deleteRowWhere( 'webmail_attachments', 'where mail_id = "'.$mail_id.'" and attachment_id = "'.$attachment_id.'"', false);
					unlink( APPSHORE_ATTACHMENTS.SEP.$attachment_id);
				}
				elseif( $val[0] == '+' )
				{
					list( $void, $attachment_id) = explode( '+', $val);
					$attachment = getOneAssocArray( 'select * from webmail_attachments where attachment_id = "'.$attachment_id.'"');
					// if this attachment doesn't belong to this mail_id then we copy it to attach it
					if( $attachment['mail_id'] != $mail_id )
					{
						$attachment['attachment_id'] = generateId();
						$attachment['mail_id'] = $mail_id;
						@copy( APPSHORE_ATTACHMENTS.SEP.$attachment_id, APPSHORE_ATTACHMENTS.SEP.$attachment['attachment_id']);
						insertRow( 'webmail_attachments', 'attachment_id', $attachment, false);
					}

				}
			}
		}

   		// we upload and add to the list the new ones
   		if( $_FILES['files']['tmp_name'])
   		{
			foreach ($_FILES['files']['tmp_name'] as $key => $val)
			{
				if( is_uploaded_file( $_FILES['files']['tmp_name'][$key]))
				{
					$attachment = array(
						'attachment_id'		=> generateID(),
						'mail_id'			=> $mail_id,
						'filename'			=> $_FILES['files']['name'][$key],
						'filesize'			=> $_FILES['files']['size'][$key],
						'disposition'		=> 'attachment',
						'type'				=> $_FILES['files']['type'][$key]
						);

					move_uploaded_file( $_FILES['files']['tmp_name'][$key], APPSHORE_ATTACHMENTS.SEP.$attachment['attachment_id']);

					insertRow( 'webmail_attachments', 'attachment_id', $attachment, false);
				}
			}
		}
   }

   function addDocuments( $list, $mail_id)
   {
   		// we suppress all documents attached with this email
		$doc['mail_id'] = $mail_id;
		deleteRow( 'webmail_documents', 'mail_id', $doc, false);

		// we rebuild the list of attached documents
 		if( $selected = explode( ',', $list) )
 		{
 			$selected = array_unique( $selected);
			foreach( $selected as $key => $val)
			{
				if( $val[0] == '+' )
				{
					list( $void, $document_id) = explode( '+', $val);
					$document = array('mail_id' => $mail_id, 'document_id' => $document_id);
					insertRow( 'webmail_documents', 'document_id', $document, false);
				}
			}
		}
   }

	function sendEmail( $mail_id)
	{
		// get the email and list information
		$email = getOneAssocArray('select * from webmail where mail_id = "'.$mail_id.'"');

		// create mailer class and set up message
		include_once(APPSHORE_INCLUDES.SEP.'swift/lib/swift_required.php');

        $message = Swift_Message::newInstance()
        	->setCharset( strtoupper($GLOBALS['appshore_data']['current_user']['charset_id']));

//		$message->setReturnPath( $mail_id.'.'.$this->appName.'.'.$GLOBALS['appshore_data']['my_company']['company_alias'].'@bounced.'.CUSTOMER_DOMAIN);

		//Give the message a subject
		$message->setSubject( $email['subject']);

		//Set the From address with an associative array
		$message->setSender( $this->cleanAddresses($email['mail_from'], true));
		$message->setFrom( $this->cleanAddresses($email['mail_from']));

		//Set the To addresses with an associative array
		$message->setTo( $this->cleanAddresses($email['mail_to']));

		//Set the Cc addresses with an associative array
		$mail_cc = $this->cleanAddresses($email['mail_cc']);
		if($mail_cc)
			$message->setCc( $mail_cc);

		//Set the Bcc addresses with an associative array
		$mail_bcc = $this->cleanAddresses($email['mail_bcc']);
		if($mail_bcc)
			$message->setBcc( $mail_bcc);

		//Give it a body
		$message->setBody( $email['body_html'], 'text/html');

		//Optionally add any attachments
		$files = getManyAssocArrays('select * from webmail_attachments where mail_id = "'.$mail_id.'"');
		if( $files)
			foreach( $files as $key => $val)
				$message->attach( Swift_Attachment::fromPath(APPSHORE_ATTACHMENTS.SEP.$val['attachment_id'])
					->setFilename($val['filename'])
					->setContentType($val['type']));

		$documents = getManyAssocArrays('select * from documents left outer join webmail_documents
			on webmail_documents.document_id = documents.document_id where mail_id = "'.$mail_id.'"');
		if( $documents)
			foreach( $documents as $key => $val)
				$message->attach( Swift_Attachment::fromPath(APPSHORE_DOCUMENTS.SEP.$val['document_id'])
					->setFilename($val['document_name'])
					->setContentType($val['filetype']));

		//Sendmail
		$transport = Swift_SendmailTransport::newInstance('/usr/sbin/sendmail -bs');

		//Create the Mailer using your created Transport
		$mailer = Swift_Mailer::newInstance($transport);

		//Send the message
		$result = $mailer->send($message);

	}

	function cleanupEmailAddress( $phrase)
	{
		return str_replace(array('<', '>'),array('&#60;','&#62'), $phrase);
	}


    function cleanAddresses( $addresses, $unique=false)
    {
	    $addresses = str_replace( ";", ",", $addresses);
	    $addresses = str_replace( array("\n", ">"), "", $addresses);
    	$addresses2 = explode( ",", $addresses);

    	$result = array();

    	foreach( $addresses2 as $key => $val)
    	{
	    	list( $part1, $part2) = explode( "<", $val);
	    	if( is_email(trim($part2)) )
	    	{
	    		if( $unique == true )
	    			return trim($part2);

	    		if( isset($part1) )
	    			$result = array_merge( $result, array(trim($part2) => trim($part1)));
	    		else
	    			$result = array_merge( $result, array(trim($part2)));
			}
	    	else if( is_email(trim($part1)) )
	    	{
	    		if( $unique == true )
	    			return trim($part1);

	   			$result = array_merge( $result, array(trim($part1)));
	   		}
		}

		// Anti Spam check
		if( ($GLOBALS['appshore_data']['my_company']['edition_id'] == 'TRIAL' )
			&& ( count($result) > 2 )
			&& ( substr($GLOBALS['appshore_data']['my_company']['created'], 0, 10) == gmdate('Y-m-d', strtotime('today')))
		)
			$result = array_slice($result, 0, 1);

    	//return array_unique($result);
    	return $result;
    }


	function copyAllAttachments( $source_id, $target_id)
	{
		//get all files attached with the source
		if( $files = getManyAssocArrays('select * from webmail_attachments where mail_id = "'.$source_id.'"') )
		{	//then copy each attached to a new email
			foreach ($files as $key => $val)
			{
				$new_attachment_id = generateID();

				@copy( APPSHORE_ATTACHMENTS.SEP.$val['attachment_id'], APPSHORE_ATTACHMENTS.SEP.$new_attachment_id);

				$val['attachment_id'] = $new_attachment_id;
				$val['mail_id'] = $target_id;
				insertRow( 'webmail_attachments', 'attachment_id', $val, false);
			}
		}

		//get all documents attached with the source
		if( $documents = getManyAssocArrays('select * from webmail_documents where mail_id = "'.$source_id.'"'))
		{	//then link them to a new email
			foreach ($documents as $key => $val)
			{
				$val['mail_id'] = $target_id;
				insertRow( 'webmail_documents', 'document_id', $val, false);
			}
		}
	}

	function embeddedMedia( $mail_id, $body = null)
	{
		return $body.'<script type="text/javascript" src="includes/prototype/prototype.js"></script>'
				.'<script type="text/javascript" src="lib/js/embedded.js"></script>'
				.'<script type="text/javascript">var embed = new Embedded("'.$GLOBALS['appshore']->session->sid().'","'	.$mail_id.'");</script>';
	}

}
