<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class tags_records_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'tags_records_view';
    	$this->appRecordId		= 'record_id';    	
    	$this->appRecordName	= 'record_name';    	
    	$this->appOrderBy		= 'record_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'tags_records';
    	$this->appNameSingular	= 'tags_record';    	
    	$this->appLabel 		= 'List Records';
    	$this->appLabelSingular = 'List Record';    
    	$this->appXSL	 		= 'tags.records_base';
    	$this->appRole 			= 'tags';

        parent::__construct();    	
    }


    function view(  $args = null)
    {
      	$record = getOneAssocArray( 'select record_type_id from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');
    	
    	switch( $record['record_type_id'] )
    	{
    		case 'accounts' :
    			$args['account_id'] = $args['record_id'];
    			$GLOBALS['appshore_data']['api']['op'] = 'accounts.popup.view';
    			break;
    		case 'contacts' :
    			$args['contact_id'] = $args['record_id'];
    			$GLOBALS['appshore_data']['api']['op'] = 'contacts.popup.view';
     			break;
    		case 'leads' :
    			$args['lead_id'] = $args['record_id'];
    			$GLOBALS['appshore_data']['api']['op'] = 'leads.popup.view';
    			break;
    		default :
    			unset($args);
    			$GLOBALS['appshore_data']['api']['op'] = $this->appName.'.base.search';
    			break;
		}
		
		return execMethod( $GLOBALS['appshore_data']['api']['op'], $args);
	} 
	
}
