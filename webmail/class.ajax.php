<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/


// class account extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.ajax.php');

class webmail_ajax extends lib_ajax {

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

        parent::__construct();    	
    }


    function embedded()
    {
		$args = new safe_args();
		$args->set('mail_id', 	NOTSET, 'any');
		$args->set('img_alt', 	NOTSET, 'any');
		$args->set('img_id', 	NOTSET, 'any');
		$args->set('img_name', 	NOTSET, 'any');
		$args->set('img_src', 	NOTSET, 'any');
		$args = $args->get(func_get_args());  

		$result['attachment_id'] = getOneColOneRow( 'select attachment_id from webmail_attachments where 
			filename = "'.$args['img_alt'].'" and mail_id = "'.$args['mail_id'].'"');
			
		if( $result['attachment_id'] == null )
		{
			list($img_src) = explode('@', substr($args['img_src'],4));
			$result['attachment_id'] = getOneColOneRow( 'select attachment_id from webmail_attachments where 
				filename = "'.$img_src.'" and mail_id = "'.$args['mail_id'].'"');
		}
		
	
		if( $result['attachment_id'] == null )
			$result['return'] = 'failure';
		else
			$result['return'] = 'success';

		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 		return $result ;
    }  
    
    function deleteSelectedRecords()
    {
		$args = new safe_args();
		$args->set('selected', 		NOTSET, 'any');
		$args = $args->get(func_get_args());  
		
		// delete the records
		if( $selected = explode( ',', $args['selected']) )	
		{			  
			foreach( $selected as $key => $val)
			{
				execMethod( $this->appName.'.base.deleteRecord', $val);
			}	
		}
		
		// remove all links in the links table
		$selected = '"'.implode( '","', $selected).'"'; 
		deleteRowWhere( 'links', 'where from_table = "'.$this->appTable.'" and from_id in ('.$selected.')', false); 
		deleteRowWhere( 'links', 'where to_table = "'.$this->appTable.'" and to_id in ('.$selected.')', false); 
    }  
    
    function getDynamicFields()
    {
		$GLOBALS['appshore_data']['server']['xml_render'] = true;
		$result['webmail'] = array_merge( 
			getManyAssocArrays('select field_name, field_label from campaigns_fields order by field_label'), 
			getManyAssocArrays('select field_name, concat("Accounts.",field_label) as field_label from db_fields 
				where app_name = "accounts" order by field_label'),
			getManyAssocArrays('select field_name, concat("Contacts.",field_label) as field_label from db_fields 
				where app_name = "contacts" order by field_label'),
			getManyAssocArrays('select field_name, concat("Leads.",field_label) as field_label from db_fields 
				where app_name = "leads" order by field_label')
			);

 		return $result;
    }	    


    function getSignature()
    {
		$args = new safe_args();
		$args->set('signature_id', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore_data']['server']['xml_render'] = true;
		$result['webmail'] = getOneAssocArray('select * from webmail_signatures where signature_id = "'.$args['signature_id'].'"');

 		return $result;
    }	
    
    function getSignatures()
    {
		$GLOBALS['appshore_data']['server']['xml_render'] = true;
		$result['webmail'] = getManyAssocArrays('select signature_id, signature_name from webmail_signatures where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" order by signature_name');

 		return $result;
    }	    

    function getTemplate()
    {
		$args = new safe_args();
		$args->set('template_id', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore_data']['server']['xml_render'] = true;

		$template = getOneAssocArray('select subject, body_html from templates where template_id = "'.$args['template_id'].'"');
		
		$tpls = str_split($template['body_html'], 1024);
				
		for( $inc = 0 ; $inc < count($tpls) ; $inc++ )
		{
			$result['webmail'][$inc]['body_html'] = $tpls[$inc];
		}

		$result['webmail'][0]['subject'] = $template['subject'];


 		return $result;
    }	

    
    function getTemplates()
    {
		$GLOBALS['appshore_data']['server']['xml_render'] = true;
		$result['webmail'] = getManyAssocArrays('select template_id, template_name from templates order by template_name');

 		return $result;
    }	    

    function getEmailAddresses()
    {
		$args = new safe_args();
		$args->set('recipient', 	NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore']->add_xsl('webmail.ajax');
		$result['action']['ajax'] = 'emailaddresses';
		$GLOBALS['appshore_data']['server']['xml_render'] = false;		
		
		$contacts = getManyAssocArrays(
			'select 
				concat(full_name," <",email,">") as full_name 
			from 
				contacts '.
			buildClauseWhere('contacts','R', ''). 
			' AND
				email not in ( "")
			AND	(
					full_name like "'.$args['recipient'].'%" 
				OR	email like "'.$args['recipient'].'%"
				)
			limit 10');

		$leads = getManyAssocArrays('
			select 
				concat(full_name," <",email,">") as full_name 
			from 
				leads '.
			buildClauseWhere('leads','R', ''). 
			' AND
				email not in ( "")
			AND	(
					full_name like "'.$args['recipient'].'%" 
				OR	email like "'.$args['recipient'].'%"
				)
			limit 10');
			

		$accounts = getManyAssocArrays('
			select 
				concat(account_name," <",email,">") as full_name 
			from 
				accounts '.
			buildClauseWhere('accounts','R', ''). 
			' AND
				email not in ( "")
			AND	(
				account_name like "'.$args['recipient'].'%" 
				OR	email like "'.$args['recipient'].'%"
				)
			limit 10');			
				
		$users = getManyAssocArrays('
			select 
				concat(full_name," <",email,">") as full_name 
			from 
				users '.
			buildClauseWhere('webmail','R', ''). 
			' AND
				email not in ( "")
			AND	(
					full_name like "'.$args['recipient'].'%" 
				OR	email like "'.$args['recipient'].'%"
				) 								
			limit 10');

		$list = array_merge( (array)$contacts, (array)$accounts, (array)$leads, (array)$users);
		array_multisort( $list);
		$result['webmail'] = array_slice( $list, 0, 10);
 		return $result;
    }	

}
