<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/


require_once ( APPSHORE_LIB.SEP.'class.base.php');

class products_categories_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'products_categories';
    	$this->appRecordId		= 'category_id';    	
    	$this->appRecordName	= 'category_name';    	
    	$this->appOrderBy		= 'category_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'products_categories';
    	$this->appNameSingular	= 'products_category';    	
    	$this->appLabel 		= 'Categories';
    	$this->appLabelSingular = 'Category';    
    	$this->appXSL	 		= 'products.base';
    	$this->appRole 			= 'products';

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

#    	// to allow tag management from this app
#		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
#			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

        parent::__construct();    	
    }
          
   
    function menus()
    {
		execMethod( 'products.base.menus');
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
