<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class administration_base
{

	function __construct()
	{
		$this->appName 			= 'administration';
		$this->appNameSingular	= 'administration';
		$this->appLabel 		= 'Administration';
		$this->appLabelSingular = 'Administration';
		$this->appXSL	 		= 'administration.base';
		$this->appRole 			= 'administration';
	}
	
	function start()
	{
 		$this->menus();

		// define the related action for calling the right xsl template
		$result['action'][$this->appName] = 'start';

		return $result;
	}


	function menus()
	{
		$GLOBALS['appshore']->add_xsl('administration.base');		
		$GLOBALS['appshore']->add_xsl('lib.base');
		$GLOBALS['appshore']->add_xsl('lib.menus');

		// we remove this xsl lib to use the specific one
		$GLOBALS['appshore']->remove_xsl('lib.custom');

		// menu titles must be static because they are called by others
		$GLOBALS['appshore']->add_appmenu('Administration', 'Company','administration.company_base.start');
		$GLOBALS['appshore']->add_appmenu('Administration', 'Departments', 'administration.departments_base.start');

		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_ADMIN ) && $GLOBALS['appshore']->rbac->check('forecasts', RBAC_ADMIN ) )
			$GLOBALS['appshore']->add_appmenu('Administration', 'Sales organization', 'administration.sales_base.start');

		$GLOBALS['appshore']->add_appmenu('Administration', 'Users','administration.users_base.start');

		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_ADMIN ))
		{
			$GLOBALS['appshore']->add_appmenu('Administration', 'Roles', 'administration.roles_base.start');
			$GLOBALS['appshore']->add_appmenu('Administration', 'Applications', 'administration.applications_base.start');
			$GLOBALS['appshore']->add_appmenu('Administration', 'Customization', 'administration.customization.start');
		}
	}



}
