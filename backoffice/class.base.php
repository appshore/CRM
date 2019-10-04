<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class backoffice_base {

	var $appName = 'backoffice';	
	
    function menus()
    {
		$GLOBALS['appshore']->add_appmenu($this->appName, 'Search customers', $this->appName.'.customers_base.search');
		$GLOBALS['appshore']->add_appmenu($this->appName, 'New customer', $this->appName.'.customers_base.edit');
		$GLOBALS['appshore']->add_appmenu($this->appName, 'Search users', $this->appName.'.users_base.search');
		if ( $GLOBALS['appshore']->rbac->check('backoffice', RBAC_ADMIN ))
			$GLOBALS['appshore']->add_appmenu($this->appName, 'Statistics', $this->appName.'.statistics.start');
    }  

       
	function start()
	{
		return execMethod($this->appName.'.customers_base.start');
	}
         

}
