<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */

// generic classe to export into tables
// classes child specific to each app must be defined to init some variables
// and to build menus
class lib_export 
{
	// these variables are declared globales
	// but initialized in the class constructor because of call to lang()
	var $appName;		// init in child classes
	var $appTable;		// init in child classes
	var $appRole;		// init in child classes
	var $appRecordId;	// init in child classes
	
	// stub
    function __construct()
    {
    }	
	
    function bulk()
    {
 		$args = new safe_args();
		$args->set('bulk_id', 	'All', 'any');			
		$args->set('selected', 	NOTSET, 'any');
		// retrieve all passed parameters
		$args = $args->get(func_get_args());
		
		switch( $args['bulk_id'] )
		{
			case 'Selected': 
			case 'Page':				 
				$selected = implode( '","', explode( ',', $args['selected']));				  
				if( $where = $_SESSION[$this->appName]['sql']['where'] )
					$where = str_replace( ' WHERE ', ' WHERE t0.'.$this->appRecordId.' in ("'.$selected.'") AND ', $where); 
				else
					$where = ' WHERE t0.'.$this->appRecordId.' in ("'.$selected.'") '; 
				$sql = $_SESSION[$this->appName]['sql']['select'].$_SESSION[$this->appName]['sql']['from'].$_SESSION[$this->appName]['sql']['join'].$where;		
				break;	

			case 'All':	
				$sql = $_SESSION[$this->appName]['sql']['request'];
				break;			 
		}

		$sql = str_replace( $this->appRecordId.',', '*,', $sql); 		
		
		return $this->download( $sql);
    }
    
    function record()
    {
 		$args = new safe_args();
		$args->set('record_id', NOTSET, 'any');			
		$args = $args->get(func_get_args());

		if( $args['record_id'] )
		{
			if( $where = $_SESSION[$this->appName]['sql']['where'] )
				$where = str_replace( ' WHERE ', ' WHERE t0.'.$this->appRecordId.' = "'.$args['record_id'] .'" AND ', $where); 
			else
				$where = ' WHERE t0.'.$this->appRecordId.' = "'.$args['record_id'] .'"'; 
		}

		$sql = $_SESSION[$this->appName]['sql']['select'].$_SESSION[$this->appName]['sql']['from'].$_SESSION[$this->appName]['sql']['join'].$where;		
		$sql = str_replace( $this->appRecordId.',', '*,', $sql); 
				
		return $this->download( $sql);
    }    
    
	// First stage of export where user set up export file type, name and if we have an header
    function download( $sql = '')
    {
		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !$GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export'))
        {
			messagebox( ERROR_PERMISSION_DENIED, ERROR);
			return execMethod( $this->appName.'.base.start', null, true);
        }
        
		//we set this global variable to avoid to build XSL templates
		$GLOBALS['appshore']->DownloadExport = true;
		
		// all these code came from php.net examples to work with IE
		ini_set( 'zlib.output_compression', 'Off');	
		header('Pragma: public');
		header('Cache-Control: no-store, no-cache, must-revalidate'); // HTTP/1.1
		header('Content-Transfer-Encoding: none');
		header('Content-Type: text/csv; name="'.$this->appName.'.csv"; charset='.$GLOBALS['appshore_data']['current_user']['charset_id']); //This should work for IE & Opera
		header('Content-Disposition: inline; filename="'.$this->appName.'.csv"; '. rand(1,9));	
	
	    // we build and execute the sql request specific for each table  
		//$db = $this->specificSQL();
		$db = executeSQL( $sql);

		$row = $db->GetRowAssoc(false);
		
		$output = '';
		$pos = 1;
		//get the columns name
		foreach( $row as $Name => $Value )
		{
			if( $rows[$Name] )
				continue;
				
			$rows[$Name] = $pos++ ;
			$output .=  '"'.$Name.'",';			
		}	
		$output[strlen($output)-1] = "\n";

		if( $GLOBALS['appshore_data']['current_user']['charset_id'] != 'UTF-8' )
			print iconv( 'UTF-8', $GLOBALS['appshore_data']['current_user']['charset_id'].'//TRANSLIT', $output);				
		else
			print $output;

		// loop all the retrieved records
		while( !$db->EOF )
		{
			$row = $db->GetRowAssoc(false);

			unset( $output);
					
			$pos = 1;
			foreach( $row as $Name => $Value )
			{
				if( $rows[$Name] == $pos++ )
				{
					$Value =  str_replace( '"', '""', $Value);
					$output .=  '"'.str_replace( array("\r","\n"), " ", $Value).'",';
				}
			}		

			$output[strlen($output)-1] = "\n";

			if( $GLOBALS['appshore_data']['current_user']['charset_id'] != 'UTF-8' )
				print iconv( 'UTF-8', $GLOBALS['appshore_data']['current_user']['charset_id'].'//TRANSLIT', $output);				
			else
				print $output;
				
			$db->MoveNext();
		}

		// exit is mandatory is this case because the output is unconventional (download)	
		// so we dont want to go through AppShore rendering engine				
		exit();	
    } 

}
