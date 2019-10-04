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

// generic classe to import into tables
// classes child specific to each app must be defined to init some variables
// and to build menus
class lib_import 
{	
	// these variables are declared globales
	// but initialized in the class constructor because of call to lang()
	var $error;
	
	// all init in child classes
	var $tableSchema;			
	var $appName;	
	var $appRole;	
	
	var $importTable;	
	var $importIndex;	
	var $specific;			
	var $isDuplicate = false;		
	var $isRelated = false;			

    function __construct()
    {
    }

    function load_specific_xsl()
    {
    }
    
    function start()
    {
    	unset( $_SESSION['import']);
		return $this->upload();
    }


    // set table schema
    function setTableSchema( $header)
    {
		$this->tableSchema = getManyAssocArrays( 'select field_name, field_label, is_mandatory from db_fields where app_name = "'.$this->appName.'" and table_name = "'.$this->importTable.'" order by field_label');

		if( $header )
		{
			foreach( $header as $key => $value )
				$header[$key] = strtolower($value);

			foreach( $this->tableSchema as $tableKey => $tableValue )
			{
				$match = '';
				$field_name = strtolower($tableValue['field_name']);
				if( substr($field_name,0,7) == 'custom_' )
					$field_name = substr($field_name,7);
				$field_name = str_replace( '_', ' ', $field_name);

				// this allow us to try to match imported column names and the database ones. not perfect but good enough for purpose
				foreach( $header as $key => $value )
				{
					if( metaphone($value) == metaphone($field_name) )
					{
						$this->tableSchema[$tableKey]['field_match'] = $value;
						continue;
					}
				}
			}
		}

 	}

	// First stage of import where user set up import file type, name and if we have an header
    function upload()
    {
		$args = new safe_args();
		$args->set('key',			NOTSET,'any');
		$args->set('format_id', 	NOTSET,'any');		
		$args->set('filename', 		NOTSET,'any');		
		$args->set('userfile', 		NOTSET,'any');	// must be the same declares in $_Files['userfile']	
		$args->set('header', 		0,'any');	
		$args->set('duplicate', 	NOTSET,'any');
		$args->set('related', 		NOTSET,'any');							
		$args = $args->get(func_get_args());

        $GLOBALS['appshore']->add_xsl('lib.import');
        $GLOBALS['appshore']->add_xsl('lib.base');        
        
        // set up the different files format supported
		$fileFormat = array(
	        array ( 'format_id' => ',', 		'format_name' => lang('Generic CSV file with comma delimiter')),
	        array ( 'format_id' => ';', 		'format_name' => lang('Generic CSV file with semicolon delimiter')),
	        array ( 'format_id' => ' ', 		'format_name' => lang('Generic CSV file with space delimiter')),
	        array ( 'format_id' => chr(9), 		'format_name' => lang('Generic CSV file with tab delimiter')),
	        //array ( 'format_id' => 'xls2002', 'format_name' => lang('MS Excel 2002 file (.xls)')),	        
	        //array ( 'format_id' => 'access', 	'format_name' => lang('MS Access 2002 file')),	 	        
	        //array ( 'format_id' => 'xml', 	'format_name' => lang('XML file'))	        
	        );         
	        
		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !$GLOBALS['appshore']->rbac->check( $this->appRole, RBAC_USER_WRITE ) || !$GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'import'))
        {
			messagebox( ERROR_PERMISSION_DENIED, ERROR);
			return execMethod( $this->appName.'.base.start', null, true);
        }

 		switch($args['key'])
		{
			case 'Next':
			
				if ( $args['header'] != 1)
					$args['header'] = 0;
				if ( $args['duplicate'] != 1)
					$args['duplicate'] = 0;		
				if ( $args['related'] != 1)
					$args['related'] = 0;								
									
				// test if upload gone well
				if (is_uploaded_file( $_FILES['userfile']['tmp_name']))
				{ 
					move_uploaded_file( $_FILES['userfile']['tmp_name'], $_FILES['userfile']['tmp_name'].'.imp');
					$args['tmp_name'] = $_FILES['userfile']['tmp_name'].'.imp';
					$_SESSION['import']['format_id'] = $args['format_id'] ;
					$_SESSION['import']['filename'] = $args['filename'];							
					$_SESSION['import']['userfile'] = $_FILES['userfile']['name'];							
					$_SESSION['import']['tmp_name'] = $_FILES['userfile']['tmp_name'].'.imp';						
					$_SESSION['import']['header'] = $args['header'];
					
					if( $this->isDuplicate )		
						$_SESSION['import']['duplicate'] = $args['duplicate'];	
					else
						unset($_SESSION['import']['duplicate']);						
						
					if( $this->isRelated )		
						$_SESSION['import']['related'] = $args['related'];	
					else
						unset($_SESSION['import']['related']);								
					
					unset( $args['key']);						
					$result = $this->selectFields( $args);
				}
				else
				{
	                messagebox( ERROR_INVALID_DATA, ERROR);	
	                $result['error']['userfile'] = ERROR_MANDATORY_FIELD;				
					$result['action']['import'] = 'upload';
					$result['format'] = $fileFormat;	
				}
				$result['import'] = $_SESSION['import'];	
				break;
				
			default:
				$result['action']['import'] = 'upload';
				$result['format'] = $fileFormat;
				$result['import'] = $_SESSION['import'];	
				$result['import']['isDuplicate'] = $this->isDuplicate;	
				$result['import']['isRelated'] = $this->isRelated;						
				break;
		}
		
        return $result;
    }


	// Second stage where we match table columns and field of import rows
    function selectFields()
    {
		$args = new safe_args();
		$args->set('key',NOTSET,'any');		
		
		for( $i = 0 ; $i < $_SESSION['import']['count'] ; $i++ )
			$args->set( 'f'.$i, NOTSET, 'any');		
			
		$args = $args->get(func_get_args());

		$this->load_specific_xsl();
        $GLOBALS['appshore']->add_xsl('lib.import');
        $GLOBALS['appshore']->add_xsl('lib.base');  

		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !$GLOBALS['appshore']->rbac->check( $this->appRole, RBAC_USER_WRITE ) )
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_WRITE_DENIED;
        }

 		switch($args['key'])
		{
			case 'Error':
				messagebox( $error, ERROR);
				$result['action']['import'] = 'selectFields';
				break;	

			case 'Previous':	
				unset( $args['key']);
				$result = $this->upload( $args);
				break;					
				
			case 'Next':

               	if ( $this->checkFields($args) )
                {
					// we modify the $args['key'] value to trigger the import
					$args['key'] = 'importFile';
					return $this->importFile( $args);
				}

                messagebox( ERROR_INVALID_DATA, ERROR);
				//	No break

			default:
   				$fp = fopen( $_SESSION['import']['tmp_name'], "r"); //open the file
   				$filesize = filesize( $_SESSION['import']['tmp_name']);   				

    			if( $_SESSION['import']['header'] == 1 )	// there is a header
   				{	
   					//First is the main column names
	   				$header = fgetcsv( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 
					$sample1 = fgetcsv( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				
					$sample2 = fgetcsv( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				
 
   					if( $header )
   					{
	   					$i=0;
	   					foreach( $header as $key => $val)
	   					{
	   						$result['sample'][] = array( 
	   							'field' 	=> 	'f'.$i,   						
	   							'header' 	=> 	sanitize($val, 'string'), 
	   							'column1' 	=> 	substr(sanitize($sample1[$i], 'string'), 0, 30),
	   							'column2' 	=> 	substr(sanitize($sample2[$i], 'string'), 0, 30));	
	   						$i++;
	   					}
	   				}			
				}
				else
   				{
   					unset( $header);
					$sample1 = fgetcsv( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				
					$sample2 = fgetcsv( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				
					$sample3 = fgetcsv( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				
   						
   						
   					if( $sample1 )
   					{
	   					$i=0;
	   					foreach( $sample1 as $key => $val)
	   					{
	   						$result['sample'][] = array( 
	   							'field' 	=> 	'f'.$i,   						
	   							'column1' 	=> 	substr(sanitize($sample1[$i], 'string'), 0, 30),
	   							'column2' 	=> 	substr(sanitize($sample2[$i], 'string'), 0, 30),
	   							'column3' 	=> 	substr(sanitize($sample3[$i], 'string'), 0, 30));							
	   						$i++;
	   					}
   					}
   					
 				}				
				fclose($fp);

	    		// we get the table schema from child classe    
				$this->setTableSchema($header);	        
 				
 				$result['columns'] = $this->tableSchema;
 				$result['index_name'] = $this->importIndex;
				
				$_SESSION['import']['count'] = $i;
						   
				$result['action']['import'] = 'selectFields';
				$result['import'] = $_SESSION['import'];				
				break;
		}

        return $result;
    }


	// Third stage where imported rows are loaded in a temporary table based on the current schema
    function importFile()
    {
		$args = new safe_args();
		$args->set('key',NOTSET,'any');		

		for( $i = 0 ; $i < $_SESSION['import']['count'] ; $i++ )
			$args->set( 'f'.$i, NOTSET, 'any');

		$args = $args->get(func_get_args());	

		$this->load_specific_xsl();
        $GLOBALS['appshore']->add_xsl('lib.import');
        $GLOBALS['appshore']->add_xsl('lib.base');  

		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display 
		if ( !$GLOBALS['appshore']->rbac->check( $this->appRole, RBAC_USER_WRITE ) )
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_WRITE_DENIED;
        }

 		switch($args['key'])
		{
			case 'Error':
				messagebox( $error, ERROR);
				$result['action']['import'] = 'importFile';
				break;					
				
			case 'importFile':

				// we create a temporay table to host the records
				/*
				if ( ($tmpTable = $this->createTMP()) == NULL )
				{
	                messagebox( 'Can\'t import these datas', ERROR);	
					return $this->upload();
				}
				*/
				
   				$fp = fopen( $_SESSION['import']['tmp_name'], "r"); //open the file
   				$filesize = filesize( $_SESSION['import']['tmp_name']);
   				
   				if( $_SESSION['import']['header'] == 1 )	// there is a header
   				{
	   				$header = fgetcsv( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 
				}

				$this->error = array();
				
				$row=1;
				while ( ($record = fgetcsv( $fp, $filesize, $_SESSION['import']['format_id'],'"')) !== FALSE  && $row < IMPORT_MAX_LINES) 
				{				
					$converted = array();
					foreach($record as $key => $value)
						$converted[$args['f'.$key]] = sanitize($value, 'string'); 						
				
	                //$this->insertRecord( $tmpTable, $converted, $row);			
					$this->importSpecific( $tmpTable, $converted);				
					
					$row++;	                		
				}	
							
				fclose($fp);
				unlink( $_SESSION['import']['tmp_name']);

				//now we do application specific import process
				//$result['import']['specific'] = $this->importSpecific( $tmpTable);
				
				$result['import']['rows'] = $row-1; 		
				$result['import']['specific'] = $this->specific;								
				$result['action']['import'] = 'importFile';				
				break;
		}
		
        return $result;
    }


    // Check mandatory fields and type of some
    function checkFields( $args )
    {
		return true;
    }
    
    
 /*
    // create a temporay table based on current schema
    function createTMP()
    {
    	// temporary table schema is build on the user id so if two end users are connecting with the same
    	// user_name and do an import we'll have some trouble for one on them... 
    	// Normally 2 users must use 2 different ids.
    	$tmpTable = 'tmp_'.$GLOBALS['appshore_data']['current_user']['user_id'];
    	
	    // we get the table schema from child classe    
		$this->setTableSchema();    	
    
		$GLOBALS['appshore']->db->execute('drop table '. $tmpTable );
		
		// create the temporay table based on current import table and index
		$sql = 'create table '.$tmpTable.' ( ';
    	foreach( $this->tableSchema as $tableKey => $tableValue )
		{
			$sql .= $tableValue['name'].' '.$tableValue['type'].', ';
		}
		$sql .= 'primary key('.$this->importIndex.'))';
					
		if ( $GLOBALS['appshore']->db->execute( $sql) == NULL )
			return NULL;
		
		return $tmpTable;
	}    
    
    // Insert a record in the temporary table
    // if not all ready defined we assigned the row to the current user
    function insertRecord( $tmpTable, $record, $row)
    {			    	
		if ( insertRow( $tmpTable, $this->importIndex, $record, false) == NULL )
		{
			$this->error['insert']['count']++;
			$this->error['insert']['lines'][] = $row;				
		}
	}    
	
*/
    

}
