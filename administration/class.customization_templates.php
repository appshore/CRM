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

class administration_customization_templates extends administration_customization{
	
	// view one customization
    function edit()
    {
		$args = new safe_args();
		$args->set('key',	NOTSET,	'any');
		foreach( ($inputs = describeColumns( 'templates')) as $fieldName => $fieldValue )
			$args->set( $fieldName,	$_SESSION['templates'][$fieldName], 'any');	
		$args = $args->get(func_get_args());
		
		$this->menus();	
        $GLOBALS['appshore']->add_xsl('lib.form');    			
        $GLOBALS['appshore']->add_xsl('administration.customization_templates');  		
		
		$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], 'administration');
		
		switch($args['key'])
		{
			case 'Delete':
				if( deleteRow( 'templates', 'template_id', $args) == false )
					unset( $args['key']);
				break;		
			case 'Save':
                // check mandatory fields
                $result['error'] = $this->checkFields($args);
                if ( isset ( $result['error']) )
                {
                    messagebox( ERROR_INVALID_DATA, 'error');
                    $result['template'] = $args;
                }
				elseif ($args['template_id']) 			// UPDATE an existing record
				{
					if( updateRow( 'templates', 'template_id', $args) == null )
						$result['template'] = $args;
				}
				else 								// New record so we do an INSERT
				{
					if ( ($args['template_id'] = insertRow( 'templates', 'template_id', $args)) == null )
	                    $result['template'] = $args;
				}	
								
				break;
		}
		
		if( $args['template_id'])
		{
			$result['template'] = getOneAssocArray('select * from templates where template_id = "'.$args['template_id'].'"'); 
		}
			
		$result['templates'] = getManyAssocArrays('select template_id, template_name from templates order by template_name');					
		$result['action']['customization'] = 'templates';			
		return $result;
    } 	
 
    // Check mandatory fields and type of some
    function checkFields( $args )
    {
        unset( $result['error'] );

        if ( !$args['template_name'] )
            $result['error']['template_name'] = ERROR_MANDATORY_FIELD;

        return $result['error'];
    }
}
