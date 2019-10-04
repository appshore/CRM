<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class support_base
{
    function __construct()
    {
		$this->menus();
    }

    function menus()
    {
		$GLOBALS['appshore']->add_xsl('support.base');
		$GLOBALS['appshore']->add_xsl('lib.base');    
        $GLOBALS['appshore']->add_xsl('lib.menus');

		// we remove this xsl lib to use the specific one
        $GLOBALS['appshore']->remove_xsl('lib.custom');
        
		$GLOBALS['appshore']->add_appmenu('Support', 'Customer support', 'support.base.start');		
#		$GLOBALS['appshore']->add_appmenu('Support', 'New features', 'support.base.newfeatures');		
		$GLOBALS['appshore']->add_appmenu('Support', 'Tickets', 'support.tickets_base.start');
		if( $GLOBALS['appshore_data']['current_user']['language_id'] != 'ja')
			$GLOBALS['appshore']->add_appmenu('Support', 'Frequently asked questions','support.faqs_base.start');
		$GLOBALS['appshore']->add_appmenu('Support', 'Documentation', 'support.base.documentation');		
	}
	    
    function start()
    {        	
		$result['support'] = '';	
		return $result;
    } 
        
	function documentation()
	{
		$args = new safe_args();
		$args->set('action', 'documentation','any');
		$args = $args->get(func_get_args());		
				
		// define next action
		$result['action']['support'] = __FUNCTION__;

        return $result;
    }  
    
	function newfeatures()
	{
		$args = new safe_args();
		$args->set('nbrposts', 1,'any');
		$args = $args->get(func_get_args());		
				
		$result['newfeatures'] = $this->getNewFeatures(3);
					
		// define next action
		$result['action']['support'] = __FUNCTION__;

	    return $result;
    }
    
   	function getNewFeatures()
	{
		$args = new safe_args();
		$args->set('nbrposts', 3,'any');
		$args = $args->get(func_get_args());		
				
		$posts = getManyAssocArrays( 'SELECT * from '.BACKOFFICEDB.'_newfeatures order by created desc limit '.$args['nbrposts']);
		
		if( $posts )
			foreach ($posts as $key => $value) 
				$posts[$key]['nice_date'] = date( 'F j, Y', strtotime($value['created']));
					
	    return $posts;
    }	    	
	
}
