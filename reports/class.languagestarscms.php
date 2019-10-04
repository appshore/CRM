<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * \*************************************************************************
 */

require_once ( 'class.parameter_popup.php');

class reports_languagestarscms extends reports_parameter_popup
{

    function __construct()
    {
    	parent::__construct();
        $GLOBALS['appshore']->add_xsl('reports.languagestarscms');
    } 
    
	function start_popup()
    {
		$args = new safe_args();
		$args->set('key', 				NOTSET, 'any');
		$args->set('out', 				'default','any');
		$args->set('report_id', 		NOTSET, 'any');
		$args->set('report_popup_type', NOTSET, 'any');
		$args->set('col_uc', 			NOTSET, 'any');
		$args->set('within_prd', 		NOTSET, 'any');
		$args->set('period', 			'TM', 'any');		
		$args->set('p1', 				NOTSET, 'any');	
		$args->set('p2', 				NOTSET, 'any');
		$args = $args->get(func_get_args()); 
		
		$GLOBALS['appshore']->add_xsl('lib.base');				
		$GLOBALS['appshore']->add_xsl('lib.form');
		
		$args['col_uc'] = 'custom_free_class_date'; //nor update, nor create (see in preprocess of range_nucdate(u/c) 
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
			'p2'				=> $args['p2']	
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
    
        
	function start_popup_2()
    {
		$args = new safe_args();
		$args->set('key', 				NOTSET, 'any');
		$args->set('out', 				'default','any');
		$args->set('report_id', 		NOTSET, 'any');
		$args->set('report_popup_type', NOTSET, 'any');
		$args->set('col_uc', 			NOTSET, 'any');
		$args->set('within_prd', 		NOTSET, 'any');
		$args->set('period', 			'TM', 'any');		
		$args->set('p1', 				NOTSET, 'any');	
		$args->set('p2', 				NOTSET, 'any');
		$args = $args->get(func_get_args()); 
		
		$GLOBALS['appshore']->add_xsl('lib.base');				
		$GLOBALS['appshore']->add_xsl('lib.form');
		
		$args['col_uc'] = 'custom_original_contact_date'; //nor update, nor create (see in preprocess of range_nucdate(u/c) 
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
			'p2'				=> $args['p2']	
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
    
    function start_popup_4()
    {
		$args = new safe_args();
		$args->set('key', 				NOTSET, 'any');
		$args->set('out', 				'default','any');
		$args->set('report_id', 		NOTSET, 'any');
		$args->set('report_popup_type', NOTSET, 'any');
		$args->set('col_uc', 			NOTSET, 'any');
		$args->set('within_prd', 		NOTSET, 'any');
		$args->set('period', 			'TM', 'any');		
		$args->set('p1', 				NOTSET, 'any');	
		$args->set('p2', 				NOTSET, 'any');
		$args = $args->get(func_get_args()); 
		
		$GLOBALS['appshore']->add_xsl('lib.base');				
		$GLOBALS['appshore']->add_xsl('lib.form');
		
		$args['col_uc'] = 'custom_recent_contact_date'; //nor update, nor create (see in preprocess of range_nucdate(u/c) 
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
			'p2'				=> $args['p2']	
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



}
