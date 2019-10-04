<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class campaigns_records_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'campaigns_records_view';
    	$this->appRecordId		= 'list_record_id';    	
    	$this->appRecordName	= 'record_name';    	
    	$this->appOrderBy		= 'record_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'campaigns_records';
    	$this->appNameSingular	= 'campaigns_record';    	
    	$this->appLabel 		= 'List Records';
    	$this->appLabelSingular = 'List Record';    
    	$this->appXSL	 		= 'campaigns.records_base';
    	$this->appRole 			= 'campaigns';

        parent::__construct();    	
    }


    function view(  $args = null)
    {
		list( $list_id, $record_id) = explode( '_', $args[$this->appRecordId]);					
      	$table_name = getOneColOneRow( 'select table_name from campaigns_records where list_id = "'.$list_id.'" and record_id = "'.$record_id.'"');
    	   	
    	switch( $table_name )
    	{
    		case 'accounts' :
    			$args['account_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'accounts.popup.view';
    			break;
    		case 'contacts' :
    			$args['contact_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'contacts.popup.view';
     			break;
    		case 'customers' :
    			$args['company_id'] = $record_id;
    			$GLOBALS['appshore_data']['api']['op'] = 'backoffice.customers_popup.view';
     			break;
    		case 'leads' :
    			$args['lead_id'] = $record_id;
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
