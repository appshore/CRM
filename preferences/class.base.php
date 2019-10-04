<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

class preferences_base
{
    
    function start()
    {        	
		$this->menus();
		$result['preferences'] = '';	
		return $result;
    } 

    function menus()
    {
		$GLOBALS['appshore']->add_xsl('preferences.base');
		$GLOBALS['appshore']->add_xsl('lib.base');    
        $GLOBALS['appshore']->add_xsl('lib.menus');

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');
        
		$GLOBALS['appshore']->add_appmenu('Preferences', 'My information', 'preferences.profile_base.view');
		$GLOBALS['appshore']->add_appmenu('Preferences', 'Password', 'preferences.profile_base.changePassword');		
		$GLOBALS['appshore']->add_appmenu('Preferences', 'Presentation','preferences.lookandfeel_base.view');

    	// display extra menus
		if ( checkEdition() )
		{
#			$GLOBALS['appshore']->add_appmenu('Preferences', 'Notifications','preferences.notifications_base.start');
			$GLOBALS['appshore']->add_appmenu('Preferences', 'Search filters','preferences.searches_base.start');
		}
			
#		$GLOBALS['appshore']->add_appmenu('Preferences', 'Tags','preferences.tags_base.start');
	//$GLOBALS['appshore']->add_appmenu('Preferences', 'Pages','preferences.pages.start');		
	//$GLOBALS['appshore']->add_appmenu('Preferences', 'Dashboard','preferences.dashboards.edit');
	}
	
}
