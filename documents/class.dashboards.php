<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

// class account extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.dashboards.php');

class documents_dashboards extends lib_dashboards
{

    function __construct()
    {
    	$this->appTable 		= 'documents';
    	$this->appRecordId		= 'document_id';    	
    	$this->appRecordName	= 'document_name';    	
    	$this->appWhereFilter	= '';    	
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
