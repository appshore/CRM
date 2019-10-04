<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/

class www_customization
{

    function __construct()
    {
    	$this->appName 			= 'www_customization';
    	$this->appNameSingular	= 'www_customization';    	
    	$this->appLabel 		= 'Customization';
    	$this->appLabelSingular = 'Customization';    
    	$this->appXSL	 		= 'www.customization';
    	$this->appRole 			= 'www';
   }
	
    function menus()
    {
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl('www.customization');    
     
		$result = execMethod('www.base.menus', $args, true);		
		
		if ( $GLOBALS['appshore']->rbac->check('www', RBAC_ADMIN ) )
        {		
#			$GLOBALS['appshore']->add_appmenu('Customization', 'Applications', 'www.customization_applications.start');
#			$GLOBALS['appshore']->add_appmenu('Customization', 'Company logo', 'www.customization_logo.edit');	        		
#			$GLOBALS['appshore']->add_appmenu('Customization', 'Drop down lists', 'www.customization_dropdown.edit');
#			$GLOBALS['appshore']->add_appmenu('Customization', 'Templates', 'www.customization_templates.edit');		

#			$GLOBALS['appshore']->add_appmenu('Customization', 'Translation', 'www.customization_translation.start');		
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
