<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/
 
require_once ( APPSHORE_LIB.SEP.'class.base.php');

class support_faqs_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'backoffice_support_faqs';
    	$this->appRecordId		= 'faq_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appOrderBy		= 'category_id';    	
    	$this->appAscDesc		= 'desc';    	    	   	
	    if( $GLOBALS['appshore_data']['my_company']['company_alias'] != 'backoffice' )
			$this->appWhereFilter	= 'is_active = "Y"';		// filter of the table
    	$this->appName 			= 'support_faqs';
    	$this->appNameSingular	= 'support_faq';    	
    	$this->appLabel 		= 'Frequently Asked Questions';
    	$this->appLabelSingular = 'Frequently Asked Question';    
    	$this->appXSL	 		= 'support.faqs';
    	$this->appRole 			= 'support';

        parent::__construct();    	
    }

	function menus()
	{
    	execMethod('support.base.menus');
    	
		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->add_xsl($this->appXSL);    

		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_USER_WRITE ) && 
			$GLOBALS['appshore_data']['my_company']['company_alias'] == 'backoffice')
        {
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'List', 'support.faqs_base.search');
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'New', 'support.faqs_base.edit');
		}	
	}
	
	     
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
        $entry['is_active'] = 'Y';
               
        return parent::newEntry( $args, $entry);
    }
	
	// view one profile
    function start($args)
    {
    	return $this->search($args);		
    } 	

	// view one profile
    function search( $args = null)
    {
    	$this->menus();
    
		$result = parent::search( $args);	
		
    	if( $GLOBALS['appshore_data']['my_company']['company_alias'] != 'backoffice' )
		{
			// forbid edit
			$result['scope'] = 0;

			foreach( $result[$this->appName] as $key => $val)
			{
				$result[$this->appName][$key]['scope'] = 0;
				//$result[$this->appName][$key]['disk_quota'] = getfilesize($val['disk_quota']);
			}
		}


		return $result;	
    } 	

	// view one profile
    function view( $args = null)
    {
    	$this->menus();
    
		$result = parent::view( $args);	
		
    	if( $GLOBALS['appshore_data']['my_company']['company_alias'] != 'backoffice' )
			$result['scope'] = 0;

		return $result;	
    } 	

	
	// view one profile
    function edit( $args = null)
    {
    	$this->menus();
    
    	if( $GLOBALS['appshore_data']['my_company']['company_alias'] != 'backoffice' )
		{
			unset($args['key']);
			$result = parent::view( $args);	
		}
		else
			$result = parent::edit( $args);	

		return $result;	
    } 


}
