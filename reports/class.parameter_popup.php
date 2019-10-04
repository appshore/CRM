<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * \*************************************************************************
 */


class reports_parameter_popup
{
	var $periods ;

    function __construct()
    {
		$this->periods = array(
	        array ( 'period' => 'TD', 	'period_name' => 'Today'),
	        array ( 'period' => 'TO', 	'period_name' => 'Tomorrow'),
	        array ( 'period' => 'YE', 	'period_name' => 'Yesterday'),
	        array ( 'period' => 'TW', 	'period_name' => 'This week'),	
	        array ( 'period' => 'NW', 	'period_name' => 'Next week'),	        
	        array ( 'period' => 'LW', 	'period_name' => 'Last week'),	                
	        array ( 'period' => 'TM', 	'period_name' => 'This month'),	
	        array ( 'period' => 'NM', 	'period_name' => 'Next month'),		                	        	        
	        array ( 'period' => 'LM', 	'period_name' => 'Last month'),	   
	        array ( 'period' => 'TQ', 	'period_name' => 'This quarter'),		             
	        array ( 'period' => 'NQ', 	'period_name' => 'Next quarter'),
	        array ( 'period' => 'LQ', 	'period_name' => 'Last quarter'),	        
	        array ( 'period' => 'TY', 	'period_name' => 'This year'),
	        array ( 'period' => 'NY', 	'period_name' => 'Next year'),	 	        	        
	        array ( 'period' => 'LY', 	'period_name' => 'Last year')
	        );

        $GLOBALS['appshore']->add_xsl('reports.parameter_popup');
		$GLOBALS['appshore_data']['layout'] = 'popup';
    } 

	function popup_nuc_date()
    {
		$args = new safe_args();
		$args->set('key', 				NOTSET, 'any');
		$args->set('out', 				'default','any');
		$args->set('report_id', 		NOTSET, 'any');
		$args->set('report_popup_type', NOTSET, 'any');
		$args->set('col_uc', 			NOTSET, 'any');
		$args->set('within_prd', 		NOTSET, 'any');
		$args->set('period', 			NOTSET, 'any');		
		$args->set('p1', 				NOTSET, 'any');	
		$args->set('p2', 				NOTSET, 'any');
		$args->set('selectedusers', 	NOTSET, 'any');
		$args = $args->get(func_get_args()); 
		
		$GLOBALS['appshore']->add_xsl('lib.base');				
		$GLOBALS['appshore']->add_xsl('lib.form');
		
		$args['col_uc'] = 'nuc'; //nor update, nor create (see in preprocess of range_nucdate(u/c) 
		$result['report'] = getOneAssocArray('SELECT * from reports where report_id = "'.$args['report_id'].'"');
		$result['parameter'] = $this->periods;			
		$result['action']['reports'] = $result['report']['quickparameter'];		
	
		$result['recordset'] = $_SESSION['report']['parameter'] = array(
			'report_id'			=> $args['report_id'],
			'report_popup_type'	=> $args['report_popup_type'],
			'period'			=> $args['period'],
			'col_uc'			=> $args['col_uc'],
			'within_prd'		=> $args['within_prd'],
			'p1'				=> $args['p1'],
			'p2'				=> $args['p2'],
			'selectedusers' 	=> $args['selectedusers']	
			);
			
	
		switch( $args['key'])
		{
			case 'Continue':
				$result['error'] = $this->checkFieldsData('popup_nuc_date',$args);		
				if ( isset($result['error']) )
                {
                    messagebox( ERROR_INVALID_DATA, WARNING);
					$args['report_name'] = $result['report']['report_name'];
                    $result['report'] = $args;
					$result['action']['reports'] = 'popup_nuc_date';
                }
				else 
				{
					$result['report'] = execMethod('reports.listing.predefined', $args);
					
					if (strlen($result['report']['action']['reports']) !=0 )
					{
						//possible if called for Graphics (type_id=5) from listing.php
						$result['action']['reports'] = $result['report']['action']['reports'];
						$result['report'] = $result['report']['report'];
					}
					break;
				}

			case 'Clear': // we reset some values
	 				unset( $args);
					break;
		}
		$GLOBALS['appshore_data']['layout'] = 'popup';
        return $result;
    } 


    function popup_range_date()
    {
		$args = new safe_args();
		$args->set('key', 				NOTSET, 'any');
		$args->set('out', 				'default','any');
		$args->set('report_id', 		NOTSET, 'any');
		$args->set('report_popup_type', NOTSET, 'any');
		$args->set('col_uc', 			NOTSET, 'any');
		$args->set('within_prd', 		NOTSET, 'any');
		$args->set('period', 			NOTSET, 'any');		
		$args->set('p1', 				NOTSET, 'any');	
		$args->set('p2', 				NOTSET, 'any');
		$args->set('selectedusers', 	NOTSET,'any');
		$args = $args->get(func_get_args()); 
		
		$GLOBALS['appshore']->add_xsl('lib.base');				
		$GLOBALS['appshore']->add_xsl('lib.form');

		$result['report'] = getOneAssocArray('SELECT * from reports where report_id = "'.$args['report_id'].'"');	
		$result['parameter'] = $this->periods;			
		$result['action']['reports'] = $result['report']['quickparameter'];		
	
		$result['recordset'] = $_SESSION['report']['parameter'] = array(
			'report_id'			=> $args['report_id'],
			'report_popup_type'	=> $args['report_popup_type'],
			'period'			=> $args['period'],
			'col_uc'			=> $args['col_uc'],
			'within_prd'		=> $args['within_prd'],
			'p1'				=> $args['p1'],
			'p2'				=> $args['p2'],
			'selectedusers' 	=> $args['selectedusers']	
			);
			
		switch( $args['key'])
		{
			case 'Continue':

				$result['report'] = execMethod('reports.listing.predefined', $args);
				
				if ( strlen($result['report']['action']['reports']) )
				{
					//possible if called for Graphics (type_id=5) from listing.php
					$result['action']['reports'] = $result['report']['action']['reports'];
					$result['report'] = $result['report']['report'];
				}
				break;
			
			case 'Clear': // we reset some values
 				unset( $args);
				break;
				
		}
	
		$GLOBALS['appshore_data']['layout'] = 'popup';
        return $result;
    } 

	function popup_users_scope()
    {
		$args = new safe_args();
		$args->set('key', 				NOTSET, 'any');
		$args->set('out', 				'default','any');
		$args->set('report_id', 		$_SESSION['report']['parameter']['report_id'], 'any');
		$args->set('report_popup_type', $_SESSION['report']['parameter']['report_popup_type'], 'any');
		$args->set('col_uc', 			NOTSET, 'any');
		$args->set('period', 			NOTSET, 'any');		
		$args->set('selectedusers', 	NOTSET,'any');
		$args = $args->get(func_get_args()); 
		
		$GLOBALS['appshore']->add_xsl('lib.base');				
		$GLOBALS['appshore']->add_xsl('lib.form');

		$result['report'] = getOneAssocArray('SELECT * from reports where report_id = "'.$args['report_id'].'"');	
		$result['report']['scope'] = ( $GLOBALS['appshore_data']['current_user']['user_id'] )?$GLOBALS['appshore']->rbac->checkPermissionOnUser($result['report']['scope'], $GLOBALS['appshore_data']['current_user']['user_id']):1 ;

		//users list having scope on $result['report']['table_name']
		$result['scope_users'] = getManyAssocArrays( 'select user_id, user_name, full_name from users '.buildClauseWhere($result['report']['table_name'],'W').' order by user_name');
		$result['parameter'] = $this->periods;			
		$result['action']['reports'] = $result['report']['quickparameter'];	
	
		if( $args['selectedusers'] == '')
		{
			//default scope is all users from the scope list
			foreach($result['scope_users'] as $key => $val)
				$args['selectedusers'] .= $val['user_id'].',';
			//remove last ,
			$args['selectedusers'] = substr_replace( $args['selectedusers'],'', strlen($args['selectedusers'])-1, 1 );
		}
		
		$result['recordset'] = $_SESSION['report']['parameter'] = array(
			'report_id'			=> $args['report_id'],
			'report_popup_type'	=> $args['report_popup_type'],
			'col_uc'			=> $args['col_uc'],
			'period'			=> $args['period'],
			'selectedusers'		=> $args['selectedusers']	
			);
			
		$result['action']['reports'] = $result['report']['quickparameter'];	

		switch($args['key'])
		{
			case 'Continue':
                // use to reload main window after some change
				$result['Continue'] = 'true';	

				$result['report'] = execMethod('reports.listing.predefined', $args, true);

				if ( strlen($result['report']['action']['reports']) )
				{
					//possible if called for Graphics (type_id=5) from listing.php
					$result['action']['reports'] = $result['report']['action']['reports'];
					$result['report'] = $result['report']['report'];
				}
				break;

			case 'Clear':
				unset( $args);
				break;	
		} 
		
		$GLOBALS['appshore_data']['layout'] = 'popup';	
        return $result;
    } 

	function checkFieldsData( $type,$args )
	{
		unset( $result['error'] );
		switch($type)
		{
			case 'popup_nuc_date':
				if ($args['within_prd'] == 'p')
				{
					if (!$args['period'])
						$result['error']['period'] = ERROR_MANDATORY_FIELD;
				}
				else
				{
					if ( !$args['p1'] )
						$result['error']['p1'] = ERROR_MANDATORY_FIELD;
					if ( !$args['p2'] )
						$result['error']['p2'] = ERROR_MANDATORY_FIELD;
				}
			default:
				break;
		}
		return $result['error'];
	}

}
