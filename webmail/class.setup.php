<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */


class webmail_setup {
	var $tabs ;
   
    function menus()
    {  
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl('lib.form');
        $GLOBALS['appshore']->add_xsl('webmail.base');
        $GLOBALS['appshore']->add_xsl('webmail.setup');
        
    	// define the periods list
	    $this->tabs = array(    
	          array ( 'tab_id' => 'folders', 		'tab_op' => 'webmail.setup_folders.edit',		'tab_name' => 'Folders')
	        , array ( 'tab_id' => 'signatures', 	'tab_op' => 'webmail.setup_signatures.edit',	'tab_name' => 'Signatures')
	        , array ( 'tab_id' => 'accounts',		'tab_op' => 'webmail.setup_accounts.edit', 		'tab_name' => 'External accounts')
	        //, array ( 'tab_id' => 'templates', 	'tab_op' => 'webmail.setup_templates.edit',		'tab_name' => 'Templates')
	        //, array ( 'tab_id' => 'filters',		'tab_op' => 'webmail.setup_filters.edit', 		'tab_name' => lang('Filters'))
	        //, array ( 'tab_id' => 'spam', 		'tab_op' => 'webmail.setup_spam.edit',			'tab_name' => lang('Spam'))
	        );           
         return execMethod('webmail.base.menus');		
    } 
        
    function start()
    {  
		return execMethod('webmail.setup_folders.edit');		
    } 

}
