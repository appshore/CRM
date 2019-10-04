<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');
require_once ( APPSHORE_LIB.SEP.'lib.folders.php');

class documents_popup extends lib_popup
{
	
    function __construct()
    {
    	$this->appTable 		= 'documents';
    	$this->appRecordId		= 'document_id';    	
    	$this->appRecordName	= 'document_name';    	
    	$this->appOrderBy		= 'is_folder';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'documents';
    	$this->appNameSingular	= 'document';    	
    	$this->appLabel 		= 'Documents';
    	$this->appLabelSingular = 'Document';    
    	$this->appXSL 			= 'documents.base';    	
    	$this->appRole 			= 'documents';
    	
    	if( !isset($_SESSION['popup_'.$this->appName][$this->appRecordId]) )
    	{
			$_SESSION['popup_'.$this->appName][$this->appRecordId] = '0';    	
  			$_SESSION['popup_'.$this->appName]['appOrderBy'] = 'is_folder';
   			$_SESSION['popup_'.$this->appName]['appAscDesc'] = 'DESC';	
   			$_SESSION['popup_'.$this->appName]['folder_id'] = '0';
   
	        // this place needs to be clean when it's called by others apps     
			require_once ( APPSHORE_LIB.SEP.'lib.files.php');
	        checkDirectory( APPSHORE_DOCUMENTS);
		}
 

        parent::__construct();    	
    }
	
	// search directories and documents
    function search( $args = null)
    {
    	if( $args['key'] == 'Clear' )
    	{
			unset($args);
			unset( $_SESSION['popup_'.$this->appName]);
   			$_SESSION['popup_'.$this->appName]['appOrderBy'] = $args['orderby'] = 'is_folder';
   			$_SESSION['popup_'.$this->appName]['appAscDesc'] = $args['ascdesc'] = 'DESC';
			$args[$this->appRecordId] = '0';  	
			$args['folder_id'] = '0';  	
   		}
		
			
		if( isset($args['folder_id']) ) // filter on a folder
			$_SESSION['popup_'.$this->appName][$this->appRecordId] = $args[$this->appRecordId] = $_SESSION['popup_'.$this->appName]['folder_id'] = $args['folder_id'];
		else
		{
			if( ($_SESSION['popup_'.$this->appName]['appOrderBy'] == $args['orderby'] || !isset($args['orderby'])) 
				&& ($_SESSION['popup_'.$this->appName]['appAscDesc'] == $args['ascdesc'] || !isset($args['ascdesc'])) )
			{
				if( isset($_SESSION['popup_'.$this->appName]['folder_id']) )
					$args['folder_id'] = $_SESSION['popup_'.$this->appName]['folder_id'];
								
				if( isset($args[$this->appRecordId]) ) // drill in a folder
					$_SESSION['popup_'.$this->appName]['folder_id'] = $args['folder_id'] = $_SESSION['popup_'.$this->appName][$this->appRecordId] = $args[$this->appRecordId]; 		
			}	
				if( isset($_SESSION['popup_'.$this->appName][$this->appRecordId]) )
					$args[$this->appRecordId] = $_SESSION['popup_'.$this->appName][$this->appRecordId];
		}
		   	    
    	$result = parent::search( $args);
    	
    	if( $result[$this->appName] && $args['key'] != 'Clear')
    	{
			foreach( $result[$this->appName] as $key => $val)
			{
				if( $val['is_folder'] == 'Y' )
					$result[$this->appName][$key]['filesize'] = getfilesize(folderSize($val[$this->appRecordId]));

				if( !$val['related_folder_id'] )
					$result[$this->appName][$key]['related_folder_id'] = lang('Home');
			}  	    			
		}
		
		$result['filesize'] = getfilesize(folderSize($_SESSION['popup_'.$this->appName][$this->appRecordId]));

		$result['currentFolder'] = getReverseFolders($_SESSION['popup_'.$this->appName][$this->appRecordId]);

		// folders list from home
		$result['folders'] = getFolders('0');					

		// we add this xsl lib
   	   	$GLOBALS['appshore']->add_xsl('documents.popup');
		// we remove this xsl lib to use the specific one
		$GLOBALS['appshore']->remove_xsl('lib.custom');

    	return $result;
	} 
	
    // we build the SQL request based on search, result fields and filter criterias
	function buildSQL( $args=null, $search_fields=null, $result_fields=null)
	{

		$args['folder_id'] = $_SESSION['popup_'.$this->appName]['folder_id'];
		$search_fields[] = array('field_name' => 'folder_id','field_type' => 'RE');
		
    	$sql =  parent::buildSQL( $args, $search_fields, $result_fields);
    	return $sql;
	}	        

	
	// edit or create one document
    function edit( $args = null )
    {
		// needed test if folder
		//$document = getOneAssocArray( 'select is_folder from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');
    	
    	//if( $document['is_folder'] == 'Y')
			//return execMethod( 'documents.folders_popup.edit', $args);

 		switch($args['key'])
		{
			case 'Save':		// overload of default Save
				if ($args[$this->appRecordId]) 			// UPDATE an existing record
				{
               		if ( $this->checkFields($args, $edit_fields) == false )
	                    $result[$this->appNameSingular] = $args;
					else if( updateRow( $this->appTable, $this->appRecordId, $args) == null )
						$result[$this->appNameSingular] = $args;
				}
				else 								// New record so we do an INSERT
				{
					$args[$this->appRecordId] = generateId();
					  
					if ( $_FILES['userfile'] == null || $_FILES['userfile'][ERROR] == '1')
					{
	                    messagebox( ERROR_FILE_TOO_BIG, ERROR);
						unset($args);
						$args['is_folder'] = 'N';
						return $this->edit($args);
	                }
					else if (is_uploaded_file( $_FILES['userfile']['tmp_name']))	
					{ 					 
		                if( strlen($args['document_name']) == 0 )
		                	$args['document_name'] = $_FILES['userfile']['name'];
		                	
						$args['filesize'] = filesize( $_FILES['userfile']['tmp_name']);
						$args['filetype'] = $_FILES['userfile']['type'];

						move_uploaded_file( $_FILES['userfile']['tmp_name'], APPSHORE_DOCUMENTS.SEP.$args[$this->appRecordId]);
						//chmod(APPSHORE_DOCUMENTS.SEP.$args[$this->appRecordId], 0666);	
						
						if ( is_file( APPSHORE_DOCUMENTS.SEP.$args[$this->appRecordId]) == false )
						{
							messagebox( ERROR_FILE_NOT_FOUND, ERROR);
							$this->deleteRecord( $args[$this->appRecordId]);
							unset($args);
							$args['is_folder'] = 'N';
							return $this->edit($args);
						}
					}

			        // quickAdd feature
			        if( $args['linked_appName'] && $args['linked_recordIdValue'] )
			        {	
						$linked = getOneAssocArray( 'select * from db_linked where app_name = "'.$this->appName.'" and linked_app_name = "'.$args['linked_appName'].'"');	        	

						//$args[$this->appRecordId] = generateId() ;
						if( $linked['linked_type'] == 'NN' )
						{
							$link['from_table'] = $this->appTable;
							$link['from_id'] = $args[$this->appRecordId];
							$link['to_table'] = $linked['linked_table_name'];
							$link['to_id'] = $args['linked_recordIdValue'];
							insertRow( 'links', 'from_id', $link, false);
						}
						else
						{
			 				$args[$linked['linked_record_name']] = $args['linked_recordIdValue'];
						}	
			 		}     
				
					$args = (array)$this->newEntry($args);
               		if ( $this->checkFields($args, $edit_fields) == false )
	                    $result[$this->appNameSingular] = $args;
					else if ( ($args[$this->appRecordId] = insertRow( $this->appTable, $this->appRecordId, $args)) == NULL )
					{
						messagebox( ERROR_FILE_EXISTS, ERROR);
						$this->deleteRecord( $args[$this->appRecordId]);
						unset($args);
						$args['is_folder'] = 'N';
						return $this->edit($args);
					}
				}				
				unset($args['key']);
				// NO Break for 'Save' case		
			default:

				$result = parent::edit( $args);	

				$result['popup_edit_fields'] = $this->setField( $result['popup_edit_fields'], 'filesize', array( 'field_current_value' => getfilesize($result[$this->appNameSingular]['filesize'])));

				$result['folders'] = getFolders( $args[$this->appRecordId] );					
				break;
		}

        return $result;
    }
    

     // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
	    $entry['is_folder'] = 'N';     
	    $entry['filetype'] = '';     
        $entry['folder_id'] = $_SESSION['popup_'.$this->appName]['folder_id'];                
        $entry['filesize'] = getfilesize(0);                      
        
        return parent::newEntry( $args, $entry);
    }  	
    	
}
