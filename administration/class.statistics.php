<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/


class administration_statistics 
{
    function start()
    {  
		return $this->view();		
    } 

	// view company about Statistics
    function view()
    {
		$args = new safe_args();
		$args->set('key', NOTSET, 'any');
		$args = $args->get(func_get_args());
		
        $GLOBALS['appshore']->add_xsl('administration.statistics');
		execMethod('administration.company_base.menus', $args, true);

		// get global information about the runing AppShore
		$result['statistics']['appshore_version'] = $GLOBALS['appshore_data']['my_company']['appshore_version'];		
		$result['statistics']['license_time_stamp'] = $GLOBALS['appshore_data']['my_company']['license_time_stamp'];		
		$result['statistics']['due_date'] = $GLOBALS['appshore_data']['my_company']['due_date'];				
		$result['statistics']['created'] = $GLOBALS['appshore_data']['my_company']['created'];
		$result['statistics']['emails_quota'] = $GLOBALS['appshore_data']['my_company']['emails_quota'];
			
		$edition = getOneAssocArray( 'select edition_name from global_editions where edition_id = "'.$GLOBALS['appshore_data']['my_company']['edition_id'].'"' );	
		$result['statistics']['edition_name'] = $edition['edition_name'];
		
		$sql = 'select app_label from db_applications da
			Left outer join global_editions_applications gea on da.app_name  = gea.app_name
			where da.status_id <> "I" AND gea.edition_id = "'.$GLOBALS['appshore_data']['my_company']['edition_id'].'"
			order by da.app_label';	
		$applications = getManyAssocArrays( $sql);	
   
		unset($result['statistics']['applications']);
   		foreach ( $applications as $key => $val) 
     		$result['statistics']['applications'] = (isset($result['statistics']['applications'])?$result['statistics']['applications'].', ':'').$val['app_label'];
			
		$result['statistics']['edition_name'] = $edition['edition_name'];		
	
		// Get the total size of MySQl tables and indexes
		$disk = $this->diskSpaceUsed();
		
		$result['statistics']['db_size'] = getfilesize($disk['db_size']);
		$result['statistics']['db_records'] = $disk['db_records'];		
		$result['statistics']['records_quota'] = $GLOBALS['appshore_data']['my_company']['records_quota'];		
		$result['statistics']['db_records_percentage'] = sprintf( "%3.2f", $disk['db_records']/$GLOBALS['appshore_data']['my_company']['records_quota']*100);
		
		// Get the total size and count of documents
        $result['statistics']['documents_size'] = getfilesize($disk['documents_size']);	
        $result['statistics']['documents_count'] = $disk['documents_count'];
        
		// Get the total size and count of documents
        $result['statistics']['attachments_size'] = getfilesize($disk['attachments_size']);	
        $result['statistics']['attachments_count'] = $disk['attachments_count'];	        	
        
		$result['statistics']['disk_used'] = getfilesize($disk['disk_used']);        			

		$result['statistics']['disk_quota'] = getfilesize($GLOBALS['appshore_data']['my_company']['disk_quota']);		
		$result['statistics']['disk_used_percentage'] = sprintf( "%3.2f", $disk['disk_used']/$GLOBALS['appshore_data']['my_company']['disk_quota']*100);
		
		// Statistics about users
		$users = getOneAssocArray( 'select count(*) users_count from users');
		$result['statistics']['users_count'] = $users['users_count'];
		$result['statistics']['users_quota'] = $GLOBALS['appshore_data']['my_company']['users_quota'];
		$users = getOneAssocArray( 'select count(*) users_activated from users where status_id = "A"');
		$result['statistics']['users_activated'] = $users['users_activated'];				
				
		$result['action']['statistics'] = 'view';
		
		return $result;
	}   
	
	// view company about Statistics
    function getStatistics()
    {
    	// disk and db space
		$statistics = $this->diskSpaceUsed();

		// company        		
		$company = getOneAssocArray( 'select license_time_stamp from company');
		$statistics['license_time_stamp'] = $company['license_time_stamp'];				

		// users
		$users = getOneAssocArray( 'select count(*) users_activated from users where status_id = "A"');
		$statistics['users_activated'] = $users['users_activated'];				
		$users = getOneAssocArray( 'select count(*) users_count from users');
		$statistics['users_count'] = $users['users_count'];

		return $statistics;
	}   			
	
	function diskSpaceUsed()
	{
		// retrieve tables list used for total count
		// get the db size
		$tables = showTableStatus();
		$result['db_records'] = 0;
		$result['db_size'] = 0;
		foreach( $tables as $key => $value )
		{
			if( in_array( $value['Name'], array('accounts','activities','campaigns','campaigns_lists','cases',
				'contacts','documents','leads','opportunities','tags','webmail','webmail_folders','webmail_attachments')))
#			if( !in_array( $value['Name'], array(
#				'campaigns_history', 'campaigns_records',
#				'db_applications', 'db_applications_statuses', 'db_blocks', 'db_fields', 'db_linked', 'db_lookups',
#				'history', 'links')))
			{
				$result['db_records'] += $value['Rows'];
				$result['db_size'] += $value['Data_length'] + $value['Index_length']; 
			}
		}
			
		// Get the total size and count of documents
		$documents = getOneAssocArray('SELECT sum(filesize) as documents_size, count(*) as documents_count FROM documents WHERE is_folder = "N"');	
        $result['documents_size'] = $documents['documents_size'];	
        $result['documents_count'] = $documents['documents_count'];	
		
		// Get the total size and count of attachments
		$attachments = getOneAssocArray('SELECT sum( filesize) as attachments_size, count(*) as attachments_count FROM webmail_attachments');	
        $result['attachments_size'] = $attachments['attachments_size'];	
        $result['attachments_count'] = $attachments['attachments_count'];
		$result['disk_used'] = $documents['documents_size']+$attachments['attachments_size']+$result['db_size'] ; 
			
		return $result;
	}
	
	function updateCompanyStatistics()
	{   	
		$statistics = $this->getStatistics();

		// mandatory for the soap request
		$statistics['sid'] = $soap_client->return['sid'];
		$statistics['company_id'] = $GLOBALS['appshore_data']['my_company']['company_id'];
		
		execMethod( 'backoffice.statistics.updateCompanyStatistics', (array)$statistics);
				
		return $statistics;
	}				
		
}
