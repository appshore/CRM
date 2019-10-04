<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2007 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.base.php');

class products_base extends lib_base{

    function __construct()
    {
    	$this->appTable 		= 'products';
    	$this->appRecordId		= 'product_id';    	
    	$this->appRecordName	= 'product_name';    	
    	$this->appOrderBy		= 'product_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'products';
    	$this->appNameSingular	= 'product';    	
    	$this->appLabel 		= 'Products';
    	$this->appLabelSingular = 'Product';    
    	$this->appXSL 			= 'products.base';
    	$this->appRole 			= 'products';

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

        parent::__construct();    	
    }
          
   
    function menus()
    {
    	parent::menus();
		$GLOBALS['appshore']->add_appmenu($this->appName, 'Search categories', 'products.categories_base.search');
		if ( $GLOBALS['appshore']->rbac->check($this->appName, RBAC_USER_WRITE ) )
		{
			$GLOBALS['appshore']->add_appmenu($this->appName, 'New category', 'products.categories_base.edit');
			$GLOBALS['appshore']->add_appmenu($this->appName, 'Import category', 'products.categories_import.start');
		}
    }

	// search directories and documents
    function view( $args = null)
    {
     	$result = parent::view( $args);
 
		// we remove this xsl lib to use the specific one
		$GLOBALS['appshore']->remove_xsl('lib.custom');

    	return $result;
	} 
	    
	// search directories and documents
    function edit( $args = null)
    {
     	$result = parent::edit( $args);
 
		// we remove this xsl lib to use the specific one
		$GLOBALS['appshore']->remove_xsl('lib.custom');

    	return $result;
	}     
    	
}
