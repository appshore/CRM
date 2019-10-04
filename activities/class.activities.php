<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once ( 'class.base.php');

class activities_activities extends activities_base
{
	var $tabs ;
	var $tab_id ;

	function __construct()
    {  	
		parent::__construct();

     	$_SESSION[$this->appName]['tab_id'] = $this->tab_id = 'activities';

    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');
	}
   
    function menus()
    {  
        $GLOBALS['appshore']->add_xsl('activities.activities'); 
  		parent::menus(); 
    } 

	
}
