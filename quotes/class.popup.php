<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class quotes_popup extends lib_popup{

    function __construct()
    {
    	$this->appTable 		= 'quotes';
    	$this->appRecordId		= 'quote_id';    	
    	$this->appRecordName	= 'quote_name';    	
   		$this->appOrderBy		= 'quote_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'quotes';
    	$this->appNameSingular	= 'quote';    	
    	$this->appLabel 		= 'Quotes';
    	$this->appLabelSingular = 'Quote';    
    	$this->appXSL			= 'quotes.base';    
    	$this->appRole 			= 'quotes';
    }
  
}
