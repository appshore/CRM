<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/


class administration_customization
{

    function __construct()
    {
    	$this->appName 			= 'administration_customization';
    	$this->appNameSingular	= 'administration_customization';    	
    	$this->appLabel 		= 'Customization';
    	$this->appLabelSingular = 'Customization';    
    	$this->appXSL	 		= 'administration.customization';
    	$this->appRole 			= 'administration';
   }
	
    function menus()
    {
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl('administration.customization');    
     
		$result = execMethod('administration.base.menus', $args, true);		
		
		if ( $GLOBALS['appshore']->rbac->check('administration', RBAC_ADMIN ) )
        {		
			$GLOBALS['appshore']->add_appmenu('Customization', 'Applications', 'administration.customization_applications.start');
			$GLOBALS['appshore']->add_appmenu('Customization', 'Company logo', 'administration.customization_logo.edit');	        		
			$GLOBALS['appshore']->add_appmenu('Customization', 'Drop down lists', 'administration.customization_dropdown.edit');
			$GLOBALS['appshore']->add_appmenu('Customization', 'Templates', 'administration.customization_templates.edit');		
			$GLOBALS['appshore']->add_appmenu('Customization', 'Translation', 'administration.customization_translation.start');		
		}
	} 
		
    
    function start()
    {  		
		$this->menus();	

 		$result['action']['customization'] = 'start';
		$result['customization'] = '';
					
		return $result;
    } 

}
