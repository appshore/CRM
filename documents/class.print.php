<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.print.php');
require_once ( APPSHORE_LIB.SEP.'lib.folders.php');

class documents_print extends lib_print
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
    	
        parent::__construct();    	
    }
}
