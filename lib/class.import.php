<?php
/**************************************************************************\
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* Brice MICHEL <bmichel@appshore.com>                                      *
* Copyright (C) 2004 - 2009 Brice MICHEL                                   *
\**************************************************************************/

define("CSV_Start",    0);
define("CSV_Quoted",   1);
define("CSV_Quoted2",  2);
define("CSV_Unquoted", 3);

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
	var $isUnique = Array();		

	// stub
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
    function setTableSchema( $header = null)
    {
		$this->tableSchema = getManyAssocArrays( 'select field_name, field_label, is_mandatory, is_unique, is_readonly from db_fields where app_name = "'.$this->appName.'" and table_name = "'.$this->importTable.'" order by field_label');

		if( $header )
		{
			foreach( $this->tableSchema as $tableKey => $tableValue )
			{
				$field_name = $tableValue['field_name'];
				$field_name = str_replace( 'custom_', '', $field_name);
				$field_name = str_replace( '_', ' ', $field_name);
				$value = str_replace( 'custom_', '', $value);
				$value = str_replace( '_', ' ', $value);
				$field_label = $tableValue['field_label'];
				
				$this->isUnique[$tableValue['field_name']] = $tableValue['is_unique'];
								
				// this allow us to try to match imported column names and the database ones. not perfect but good enough for purpose
				foreach( $header as $key => $value )
				{
					if( metaphone($value) == metaphone($field_name) || metaphone($value) == metaphone($field_label) )
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
		$args->set('header', 		'N','any');	
		$args->set('duplicate', 	'N','any');
		$args->set('related', 		'N','any');							
		$args = $args->get(func_get_args());

        $GLOBALS['appshore']->add_xsl('lib.import');
        $GLOBALS['appshore']->add_xsl('lib.base');        
        
        // set up the different files format supported
		$fileFormat = array(
	        array ( 'format_id' => ',', 		'format_name' => lang('Generic CSV file with comma delimiter')),
	        array ( 'format_id' => ';', 		'format_name' => lang('Generic CSV file with semicolon delimiter')),
	        array ( 'format_id' => ' ', 		'format_name' => lang('Generic CSV file with space delimiter')),
	        array ( 'format_id' => chr(9), 		'format_name' => lang('Generic CSV file with tab delimiter'))
	        );         

#		$duplicates = array(
#	        array ( 'duplicate_id' => 'IG', 		'duplicate_name' => lang('Ignore new record')),
#	        array ( 'duplicate_id' => 'MN', 		'duplicate_name' => lang('Merge records - new record prevails')),
#	        array ( 'duplicate_id' => 'MO', 		'duplicate_name' => lang('Merge records - old record prevails')),
#	        array ( 'duplicate_id' => 'RE', 		'duplicate_name' => lang('Replace old record'))
#	        );         

#		$mapping = array(
#	        array ( 'mapping_id' => 'I', 		'duplicate_name' => lang('Ignore')),
#	        array ( 'duplicate_id' => 'M', 		'duplicate_name' => lang('Merge')),
#	        array ( 'duplicate_id' => 'R', 		'duplicate_name' => lang('Replace'))
#	        );         
	        
		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !$GLOBALS['appshore']->rbac->check( $this->appRole, RBAC_USER_WRITE ) || !$GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'import'))
        {
			messagebox( ERROR_PERMISSION_DENIED, ERROR);
			return execMethod( $this->appName.'.base.start', null, true);
        }

 		switch($args['key'])
		{
			case 'Next':
			
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
				$result['duplicates'] = $duplicates;
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
   				
   				//if the file to import has a different encoding from utf-8 then we convert it
   				if( $GLOBALS['appshore_data']['current_user']['charset_id'] != 'UTF-8' )
   				{
	   				// test character set
	   				$test = fread( $fp, 1024); //read the first characters
	   				if( ($charset = mb_detect_encoding( $test, $GLOBALS['appshore_data']['current_user']['charset_id'])) )
	   				{
						fclose($fp);
	   					exec('iconv -f '.$charset.' -t UTF-8//IGNORE '.$_SESSION['import']['tmp_name'].' -o '.$_SESSION['import']['tmp_name'].'2') ;
	 					unlink($_SESSION['import']['tmp_name']);
	 					$_SESSION['import']['tmp_name'] .= '2';
		  				$fp = fopen( $_SESSION['import']['tmp_name'], "r"); //open the file
	   				}
					else
					  	fseek($fp,0);
				}

   				$filesize = filesize( $_SESSION['import']['tmp_name']);
    			if( $_SESSION['import']['header'] == 'Y' )	// there is a header
   				{	
   					//First is the main column names
	   				$header = $this->readCSV( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 
					$sample1 = $this->readCSV( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				
					$sample2 = $this->readCSV( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				

   					if( $header['data'] )
   					{
	   					$i=0;
	   					foreach( $header['data'] as $key => $val)
	   					{
	   						$result['sample'][] = array( 
	   							'field' 	=> 	'f'.$i,   						
	   							'header' 	=> 	sanitize($val, 'string'), 
	   							'column1' 	=> 	substr(sanitize($sample1['data'][$i], 'string'), 0, 30),
	   							'column2' 	=> 	substr(sanitize($sample2['data'][$i], 'string'), 0, 30));	
	   						$i++;
	   					}
	   				}			
				}
				else
   				{
   					unset( $header);
					$sample1 = $this->readCSV( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				
					$sample2 = $this->readCSV( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				
					$sample3 = $this->readCSV( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 	   				
   						
   						
   					if( $sample1['data'] )
   					{
	   					$i=0;
	   					foreach( $sample1['data'] as $key => $val)
	   					{
	   						$result['sample'][] = array( 
	   							'field' 	=> 	'f'.$i,   						
	   							'column1' 	=> 	substr(sanitize($sample1['data'][$i], 'string'), 0, 30),
	   							'column2' 	=> 	substr(sanitize($sample2['data'][$i], 'string'), 0, 30),
	   							'column3' 	=> 	substr(sanitize($sample3['data'][$i], 'string'), 0, 30));							
	   						$i++;
	   					}
   					}
   					
 				}				
				fclose($fp);

	    		// we get the table schema from child classe    
				$this->setTableSchema($header['data']);	        
 				
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
				
   				$fp = fopen( $_SESSION['import']['tmp_name'], "r"); //open the file
   				$filesize = filesize( $_SESSION['import']['tmp_name']);
   				
   				if( $_SESSION['import']['header'] == 'Y' )	// there is a header
   				{
	   				$this->readCSV( $fp, $filesize, $_SESSION['import']['format_id'],'"'); 
				}

				$this->error = array();

				// set the log 
				$log['app_name'] = $this->appName;
				$log['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
				$log['timestamp'] = gmdate( 'Y-m-d H:i:s');
				deleteRowWhere( 'logs_import', 'where app_name = "'.$log['app_name'].'" and user_id = "'.$log['user_id'].'"', false);
				
				$row = $rejected = 0;
				while ( ($record = $this->readCSV( $fp, $filesize, $_SESSION['import']['format_id'],'"')) !== false  && $row < IMPORT_MAX_LINES) 
				{				
					$converted = array();
					foreach($record['data'] as $key => $value)
					{
						$converted[$args['f'.$key]] = trim(sanitize($value,'string'));
					}

					$row++;	                		
				
					if( ($imp = $this->importSpecific( $tmpTable, $converted)) !== true )
					{
						$rejected++;
														
						$log['line'] = $row;
						$log['reason'] = $imp;
						$log['record'] = mysql_real_escape_string($record['line']);
						insertRow( 'logs_import', 'user_id', $log, false);
					}

					if( $rejected == 100 )
						break;						
				}	
							
				fclose($fp);
				unlink( $_SESSION['import']['tmp_name']);

				$result['import']['rows'] = $row-1; 		
				$result['import']['rejected'] = $rejected; 		
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
    
    
function readCSV($fh, $len, $delimiter = ',', $enclosure = '"') {
    $data = Array();
    $fildNr = 0;
    $state = CSV_Start;
   
    $data[0] = "";
   
    do {
        if( ($line = fgets($fh, $len)) == false )
        	return false;
        	
        for ($ix = 0; $ix < strlen($line); $ix++) 
        {
            if ($line[$ix] == $delimiter) 
            {
                if ($state != CSV_Quoted) 
                {
                    $fildNr++;
                    $data[$fildNr] = "";
                    $state = CSV_Start;
                } 
                else 
                    $data[$fildNr] .= $line[$ix];
            } 
            elseif ($line[$ix] == $enclosure) 
            {
                if ($state == CSV_Start) 
                    $state = CSV_Quoted;
                elseif ($state == CSV_Quoted) 
                    $state = CSV_Quoted2;
                elseif ($state == CSV_Quoted2) 
                {
                    $data[$fildNr] .= $line[$ix];
                    $state = CSV_Quoted;
                } 
                else 
                     $data[$fildNr] .= $line[$ix];
            } 
            else 
            {
                $data[$fildNr] .= $line[$ix];
                if ($state == CSV_Start) 
                    $state = CSV_Unquoted;
            }
        }
    } while ($state == CSV_Quoted);
 
 	$result['line'] = $line;
 	$result['data'] = $data;
 
    return $result;
}    

}
