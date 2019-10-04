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

// class meeting extends activities so requires it
require_once ( 'class.customization.php');

class administration_customization_logo extends administration_customization
{
	
    function __construct()
    {
       	parent::__construct();

        // this place needs to be clean when it's called by others apps     
		require_once ( APPSHORE_LIB.SEP.'lib.files.php');
        checkDirectory( APPSHORE_STORAGE);
    }
	
 	// view one customization
    function edit()
    {
		$args = new safe_args();
		$args->set('key',NOTSET,'any');
		$args->set('filename', NOTSET,'any');		
		$args->set('userfile', NOTSET,'any');	// must be the same declares in $_Files['userfile']	
		$args = $args->get(func_get_args());

		$this->menus();
        $GLOBALS['appshore']->add_xsl('administration.customization_logo');    			
		
		$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], 'administration');
		
 		switch($args['key'])
		{
			case 'Save':
				if (is_uploaded_file( $_FILES['userfile']['tmp_name']))
				{ 	
					foreach( array('gif', 'jpeg', 'jpg', 'png') as $format )
						@unlink( APPSHORE_STORAGE.SEP.'logo.'.$format);

					$args['filesize'] = filesize( $_FILES['userfile']['tmp_name']);
					list( $void, $args['filetype']) = explode('/',$_FILES['userfile']['type']);									 
					move_uploaded_file( $_FILES['userfile']['tmp_name'], APPSHORE_STORAGE.SEP.'tmp.'.$args['filetype']);

					include_once(APPSHORE_INCLUDES.SEP.'rimage'.SEP.'rimage.php');		
					$rimg = new rimage(APPSHORE_STORAGE.SEP.'tmp.'.$args['filetype']);
					$rimg->resizeImage(160, 40, 'portrait');
					$rimg->saveImage(APPSHORE_STORAGE.SEP.'logo.'.$args['filetype'], $args['filetype'], 100);
	
					@unlink( APPSHORE_STORAGE.SEP.'tmp.'.$args['filetype']);					
				}
				break;	
			case 'Restore':
					foreach( array('gif', 'jpeg', 'jpg', 'png') as $format )
						@unlink( APPSHORE_STORAGE.SEP.'logo.'.$format);
				break;					
	
		} 
		
		$result['action']['customization'] = 'logo';			
		return $result;
    } 	
}
