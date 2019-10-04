<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/


// class document extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.api.php');

class documents_api extends lib_api {

    function __construct()
    {
    	$this->appTable 		= 'documents';
    	$this->appRecordId		= 'document_id';    	
    	$this->appRecordName	= 'document_name';    	
    	$this->appOrderBy		= 'document_name';    	
    	$this->appAscDesc		= 'asc';    	    	
    	$this->appName 			= 'documents';
    	$this->appNameSingular	= 'document';    	
    	$this->appLabel 		= 'Documents';
    	$this->appLabelSingular = 'Document';    
    	$this->appXSL 			= 'documents.base';
    	$this->appRole 			= 'documents';
 
        parent::__construct();    	
   }
  
}
