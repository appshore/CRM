<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class campaigns_history_base extends lib_base{

    function __construct()
    {
    	$this->appTable 		= 'campaigns_history_view';
    	$this->appRecordId		= 'created';    	
    	$this->appRecordName	= 'campaign_name';    	
    	$this->appOrderBy		= 'created';    	
    	$this->appAscDesc		= 'desc';    	
    	$this->appName 			= 'campaigns_history';
    	$this->appNameSingular	= 'campaigns_history';    	
    	$this->appLabel 		= 'Campaign History';
    	$this->appLabelSingular = 'Campaign History';    
    	$this->appXSL	 		= 'campaigns.history_base';
    	$this->appRole 			= 'campaigns';
 
        parent::__construct();    	

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');
   }

    function menus()
    {
    	execMethod( 'campaigns.base.menus');
    }
 
	function search(  $args = null)
    {
		$result = parent::search( $args);

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');
		
		return $result;
	} 
		   
    function deleteRecord( $created, $verbose=false)
    {
		$GLOBALS['appshore']->db->execute( 'delete from campaigns_history where created = "'.$created.'"');
		return true;   
    }	
   
}
