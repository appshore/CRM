<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/
 
require_once ( APPSHORE_LIB.SEP.'class.base.php');

class documents_folders_base extends lib_base
{
	var $res;	// to build folder tree
	
    function __construct()
    {
    	$this->appTable 		= 'documents';
    	$this->appRecordId		= 'document_id';    	
    	$this->appRecordName	= 'document_name';    	
    	$this->appOrderBy		= 'is_folder';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'documents_folders';
    	$this->appNameSingular	= 'documents_folder';    	
    	$this->appLabel 		= 'Folders';
    	$this->appLabelSingular = 'Folder';    
    	$this->appXSL 			= 'documents.folders';    	
    	$this->appRole 			= 'documents';

    	
    	if( !isset($_SESSION[$this->appName]['folder_id']) )
    	{
	        parent::__construct();    	

			$_SESSION[$this->appName]['folder_id'] = '0';    	
      
	        // this place needs to be clean when it's called by others apps     
			require_once ( APPSHORE_LIB.SEP.'lib.files.php');
	        checkDirectory( APPSHORE_DOCUMENTS);
		}

    }
  
    function menus()
    {
		execMethod('documents.base.menus');
    }    

  
    function search()
    {
		return execMethod('documents.base.search');
    }    

	// edit or create one document
    function view( $args = null )
    {

		$result = parent::view( $args);	

		$result['view_fields'] = $this->setField( $result['view_fields'], 'filesize', array( 'field_current_value' => getfilesize(folderSize($args[$this->appRecordId]))));

        return $result;
    }  
    
	// edit or create one document
    function edit( $args = null )
    {

		$result = parent::edit( $args);	

		$result['edit_fields'] = $this->setField( $result['edit_fields'], 'filesize', array( 'field_current_value' => getfilesize(folderSize($args[$this->appRecordId]))));

		$result['folders'] = getFolders( $args[$this->appRecordId] );					

        return $result;
    }    
	


     // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
	    $entry['is_folder'] = 'Y';     
	    $entry['filetype'] = 'Folder';     
        $entry['folder_id'] = $_SESSION[$this->appName]['folder_id'];                
        $entry['filesize'] = getfilesize(0);                      
        
        return parent::newEntry( $args, $entry);
    }  	
    
}
