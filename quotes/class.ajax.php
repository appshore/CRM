<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/


// class quote extends import so requires it
require_once( APPSHORE_LIB . SEP . 'class.ajax.php');

class quotes_ajax extends lib_ajax {

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
    
    function grid()
    {
		$args = new safe_args();
		$args->set('page_size', 	10, 'any');		
		$args->set('offset', 		1, 'any');	
		$args->set('sort_col', 		'custom_field1', 'any');	
		$args->set('sort_dir', 		'ASC', 'any');	
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore']->add_xsl('lib.ajax');
		$result['action']['ajax'] = 'grid';		
		$GLOBALS['appshore_data']['server']['client_render'] = false;		
		
		$orderby = ' ORDER BY '.$args['sort_col'];
		$ascdesc = ' '.$args['sort_dir'];
		$limit = ' limit '.$args['offset'].','.$args['page_size'];
				   		$result['datas'] = getManyAssocArrays('
			SELECT 
				custom_field1,
				custom_field2,
				custom_field3,				
				custom_field4,				
				custom_field5				
			FROM
				quotes '.
			$orderby.$ascdesc.$limit);			
			
		//we force the output as an XML file
		header('Content-type: text/xml');			
			
		return $result;
    }        
  
}
