<?php
/**************************************************************************\
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* Brice MICHEL <bmichel@appshore.com>                                      *
* Copyright (C) 2004 - 2008 Brice MICHEL                                   *
\**************************************************************************/

class backoffice_statistics 
{

    function menus()
    {
		$GLOBALS['appshore']->add_xsl('lib.base');
		$GLOBALS['appshore']->add_xsl('backoffice.statistics');		
    
		execMethod('backoffice.customers_base.menus');
    }    
   
    function start($args=null)
    {  
		return $this->view($args);		
    } 

	// view company about Statistics
    function view()
    {			
		$args = new safe_args();
		$args->set('agent_id', $_SESSION['statistics']['agent_id']?$_SESSION['statistics']['agent_id']:'inc', 'sqlsafe');
		$args = $args->get(func_get_args());

		$this->menus();  

		if ( $GLOBALS['appshore']->rbac->check('backoffice', RBAC_ADMIN ) == false )
			return;
		
		$result['edition'] = getManyAssocArrays( '
			select
				edition_name,
				count(company_id) 			count_companies,
				sum(subscription_price) 	sum_subscription_price, 
				sum(c.users_quota) 			sum_users_quota, 
				sum(users_count) 			sum_users_count,
				sum(users_activated) 		sum_users_activated,
				sum(c.disk_quota)			sum_disk_quota, 
				sum(c.records_quota)		sum_records_quota, 
				sum(db_size)				sum_db_size, 
				sum(db_records)				sum_db_records, 
				sum(documents_size)			sum_documents_size, 
				sum(documents_count)		sum_documents_count 
			from customers c, global_editions ge
			where c.company_status = "ACT" and c.edition_id = ge.edition_id '.
			(($args['agent_id'])?'and agent_id = "'.$args['agent_id'].'" ':' ').
			'group by edition_name order by edition_sequence');
			
		foreach( $result['edition'] as $key => $val )
		{
			$result['total']['count_companies'] += $result['edition'][$key]['count_companies'];
			$result['total']['sum_subscription_price'] += $result['edition'][$key]['sum_subscription_price'];
			$result['total']['sum_users_quota'] += $result['edition'][$key]['sum_users_quota'];
			$result['total']['sum_users_count'] += $result['edition'][$key]['sum_users_count'];
			$result['total']['sum_users_activated'] += $result['edition'][$key]['sum_users_activated'];
			$result['total']['sum_disk_quota'] += $result['edition'][$key]['sum_disk_quota'];
			$result['total']['sum_records_quota'] += $result['edition'][$key]['sum_records_quota'];
			$result['total']['sum_db_size'] += $result['edition'][$key]['sum_db_size'];
			$result['total']['sum_db_records'] += $result['edition'][$key]['sum_db_records'];
			$result['total']['sum_documents_size'] += $result['edition'][$key]['sum_documents_size'];
			$result['total']['sum_documents_count'] += $result['edition'][$key]['sum_documents_count'];

			// to improve display			
			$result['edition'][$key]['sum_subscription_price_year'] = 12*$result['edition'][$key]['sum_subscription_price'];
			$result['edition'][$key]['sum_disk_quota'] = getFileSize($result['edition'][$key]['sum_disk_quota']);
			$result['edition'][$key]['sum_db_size'] = getFileSize($result['edition'][$key]['sum_db_size']);
			$result['edition'][$key]['sum_documents_size'] = getFileSize($result['edition'][$key]['sum_documents_size']);
		}

		$result['total']['sum_subscription_price_year'] = 12*$result['total']['sum_subscription_price'];
		$result['total']['sum_disk_quota'] = getFileSize($result['total']['sum_disk_quota']);
		$result['total']['sum_db_size'] = getFileSize($result['total']['sum_db_size']);
		$result['total']['sum_documents_size'] = getFileSize($result['total']['sum_documents_size']);


		$result['agents'] = getManyAssocArrays('select agent_id, agent_name from agents');								
		$result['statistics']['agent_id'] = $args['agent_id'];				
		$result['action']['statistics'] = 'view';				
		return $result;
	} 
		
	function updateCompanyStatistics()
	{
		$args = new safe_args();
		$args->set('company_id',			NOTSET,'any');
		$args->set('license_time_stamp',	NOTSET,'any');
		$args->set('disk_used',				NOTSET,'any');
		$args->set('db_size',				NOTSET,'any');
		$args->set('db_records',			NOTSET,'any');		
		$args->set('documents_size',		NOTSET,'any');		
		$args->set('documents_count',		NOTSET,'any');		
		$args->set('attachments_size',		NOTSET,'any');		
		$args->set('attachments_count',		NOTSET,'any');		
		$args->set('users_count',			NOTSET,'any');		
		$args->set('users_activated',		NOTSET,'any');			
		$args = $args->get(func_get_args()); 
	
		if( $args['company_id'] )
		{
			$db = executeSQL('
				UPDATE '.BACKOFFICE_DB.'.customers 
				SET 
					license_time_stamp	= "'.$args['license_time_stamp'].'", 
					disk_used 			= "'.$args['disk_used'].'", 
					db_size 			= "'.$args['db_size'].'", 
					db_records 			= "'.$args['db_records'].'", 
					documents_size 		= "'.$args['documents_size'].'", 
					documents_count 	= "'.$args['documents_count'].'", 
					attachments_size 	= "'.$args['attachments_size'].'", 
					attachments_count 	= "'.$args['attachments_count'].'", 					
					users_count 		= "'.$args['users_count'].'", 
					users_activated 	= "'.$args['users_activated'].'" 
				WHERE company_id = "'.$args['company_id'].'"');

			return true;				
		}
		else
			return false;
	}		  
	
    function updateCustomers()
    {  
		foreach( getManyAssocArrays( 'select company_alias from '.BACKOFFICE_DB.'.customers where edition_id not in ("BACKOFFICE","CUSTOM")') as $key => $val )
		{
			$db = executeSQL('select max(last_login) as license_time_stamp from '.$val['company_alias'].'.users limit 1');
			
			$license_time_stamp = substr($db->fields['license_time_stamp'], 0, 10);
			
			// update of instance time stamp
			executeSQL('UPDATE '.$val['company_alias'].'.company SET license_time_stamp	= "'.$license_time_stamp.'", updated = now()
				WHERE license_time_stamp < "'.$license_time_stamp.'"');

			// update of backoffice db time stamp
			executeSQL('UPDATE '.BACKOFFICE_DB.'.customers SET license_time_stamp = "'.$license_time_stamp.'", updated = now()
				WHERE company_alias = "'.$val['company_alias'].'"');
						
		}	
    } 	

	
}

