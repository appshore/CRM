<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class www_base
{

	function __construct()
	{
		$this->appName 			= 'www';
		$this->appNameSingular	= 'www';
		$this->appLabel 		= 'www.appshore.com';
		$this->appLabelSingular = 'www.appshore.com';
		$this->appXSL	 		= 'www.base';
		$this->appRole 			= 'www';
	}
	
	function start()
	{
 		$this->menus();

		// define the related action for calling the right xsl template
		$result['action'][$this->appName] = 'start';

return execMethod('www.customization_translation.start');

		return $result;
	}


	function menus()
	{
		$GLOBALS['appshore']->add_xsl('www.base');		
		$GLOBALS['appshore']->add_xsl('lib.base');
		$GLOBALS['appshore']->add_xsl('lib.menus');

		// we remove this xsl lib to use the specific one
		$GLOBALS['appshore']->remove_xsl('lib.custom');

		// menu titles must be static because they are called by others
#		$GLOBALS['appshore']->add_appmenu('Administration', 'Company','www.company_base.start');
#		$GLOBALS['appshore']->add_appmenu('Administration', 'Departments', 'www.departments_base.start');

#		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_ADMIN ) && $GLOBALS['appshore']->rbac->check('forecasts', RBAC_ADMIN ) )
#			$GLOBALS['appshore']->add_appmenu('Administration', 'Sales organization', 'www.sales_base.start');

#		$GLOBALS['appshore']->add_appmenu('Administration', 'Users','www.users_base.start');

#		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_ADMIN ))
#		{
#			$GLOBALS['appshore']->add_appmenu('Administration', 'Roles', 'www.roles_base.start');
#			$GLOBALS['appshore']->add_appmenu('Administration', 'Applications', 'www.applications_base.start');
#			$GLOBALS['appshore']->add_appmenu('Administration', 'Customization', 'www.customization.start');
			$GLOBALS['appshore']->add_appmenu('Administration', 'Translation', 'www.customization_translation.start');
#		}
	}



}
