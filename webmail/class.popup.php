<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2007 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class webmail_popup extends lib_popup
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
		
		$this->folders = execMethod('webmail.folder.foldersList', true);
    }
    
    function view(  $args = null)
    {
		$result = parent::view( $args);
		
	    if( ($args['key'] == 'Save' || $args['key'] == 'Send') )
	    {	
			// retrieve attachment and documents associated with this email
			$result['files'] = getManyAssocArrays( 'select attachment_id, filename from webmail_attachments where mail_id = "'.$result[$this->appNameSingular][$this->appRecordId].'"');
			$result['documents'] = getManyAssocArrays('select documents.document_id, document_name from documents 
				left outer join webmail_documents on webmail_documents.document_id = documents.document_id where mail_id = "'.$result[$this->appNameSingular][$this->appRecordId].'"');				    

			// we add this specific xsl libs
	        $GLOBALS['appshore']->add_xsl('webmail.base');
	        $GLOBALS['appshore']->add_xsl('webmail.popup');
			// we remove this xsl lib to use the specific one
	        $GLOBALS['appshore']->remove_xsl('lib.custom');
	        $result['action'][$this->appName] = 'popup_view';   
        }
        else
	        $result['action'][$this->appName] = 'popup_view';

		// check for embededded media and make them usable in this context
		$result['popup_view_fields'] = $this->setField( $result['popup_view_fields'], 'body_html', array(
			'field_current_value' => $this->embeddedMedia($result[$this->appNameSingular]['mail_id'], $result[$this->appNameSingular]['body_html'])
			));
		
		$GLOBALS['appshore_data']['layout'] = 'popup';
		return $result;
	}   
	
    
    function edit( $args = null)
    {
		$result = execMethod( 'webmail.base.edit', $args);	

	    // quickAdd feature
	    if( ($args['key'] == 'Save' || $args['key'] == 'Send') )
	    {	

    	    if( $args['linked_appName'] && $args['linked_recordIdValue'] )
    	    {
			    $linked = getOneAssocArray( 'select * from db_linked where app_name = "'.$this->appName.'" and linked_app_name = "'.$args['linked_appName'].'"');	        	

			    if( $linked['linked_type'] == 'NN' )
			    {
				    $link['from_table'] = $this->appTable;
				    $link['from_id'] = $result[$this->appNameSingular][$this->appRecordId];
				    $link['to_table'] = $linked['linked_table_name'];
				    $link['to_id'] = $args['linked_recordIdValue'];
				    insertRow( 'links', 'from_id', $link, false);
			    }
			    else
			    {
				    $args[$linked['linked_record_name']] = $args['linked_recordIdValue'];
			    }	
            }
            			
			$args[$this->appRecordId] = $result[$this->appNameSingular][$this->appRecordId];

	        return $this->view($args);
		}  

		// we add this specific xsl libs
        $GLOBALS['appshore']->add_xsl('webmail.base');
        $GLOBALS['appshore']->add_xsl('webmail.popup');
		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');

		$GLOBALS['appshore_data']['layout'] = 'popup';
        $result['action'][$this->appName] = 'popup_edit';           	

		return $result;
	}     
    
    function newEntry( $args = null, $entry = null)
    {
		$entry = execMethod( 'webmail.base.newEntry', $args);	
        
        return parent::newEntry( $args, $entry);
    }  
    
	
	function embeddedMedia( $mail_id, $body = null)
	{	
		return $body;
		return $body.'<script type="text/javascript" src="includes/prototype/prototype.js"></script>'
				.'<script type="text/javascript" src="lib/js/embedded.js"></script>'
				.'<script type="text/javascript">var embed = new Embedded("'.$GLOBALS['appshore']->session->sid().'","'	.$mail_id.'");</script>';
	}      	    	  
        
          
}
