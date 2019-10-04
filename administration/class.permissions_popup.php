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

class administration_permissions_popup {

    function administration_permissions_popup()
    {
        $GLOBALS['appshore']->add_xsl('administration.permissions_popup');

		$GLOBALS['appshore_data']['layout'] = 'popup';
		return $result;
	} 

	// delete permission
    function delete()
    {
		$args = new safe_args();
		$args->set('permission_id',NOTSET,'any');
		$args->set('key',NOTSET,'any');
		$args = $args->get(func_get_args()); 
		
		switch($args['key'])
		{
			case 'Confirm':
				if ( $args['permission_id']) 
                {
                    deleteRow( 'permissions', 'permission_id', $args );
                    //we must update the rbac status
                    $GLOBALS['appshore']->rbac->have_changed();
                }
				$GLOBALS['appshore_data']['layout'] = 'popup';	
				$result['delete'] = 'true';					
				$result['action']['permissions'] = 'delete';					
				break;		
					
			default:
				$GLOBALS['appshore_data']['layout'] = 'popup';	
				$result['action']['permissions'] = 'delete';
				$result['permission'] = $this->buildPermissionView( $args['permission_id'] );	
				break;
		}


		//$result['purposes'] = getManyAssocArrays( 'select purpose_id, purpose from permission_purposes order by purpose');		
			
        return $result;
    } 	
	
	// edit or create many permissions
    function edit()
    {
		$args = new safe_args();
		$args->set( 'key', NOTSET, 'any');

		// Allow to retrieve all the cols from this table
		$permission = getOneAssocArray( 'select * from permissions');	
		foreach( $permission as $fieldName => $fieldValue )
			$args->set( $fieldName, NOTSET, 'any');	

		$args = $args->get(func_get_args()); 
		
 		switch($args['key'])
		{
			case 'Save':
	
				if ( $args['permission_id']) 			// UPDATE an existing permission
					updateRow( 'permissions', 'permission_id', $args);
				else //if ( $args['user_id'] ) 		// New permission so we build an INSERT
					$args['permission_id']= insertRow( 'permissions', 'permission_id', $args);

                //we must update the rbac status
                $GLOBALS['appshore']->rbac->have_changed();

                // use to reload main window after some change
				$result['save'] = 'true';	
								
				// NO Break for 'Save' case		
			default:
				$GLOBALS['appshore_data']['layout'] = 'popup';	
				$result['action']['permissions'] = 'edit';
				if ( $args['permission_id']) 	// Edit existing permission
					$result['permission'] = $this->buildPermissionView( $args['permission_id'] );
				else						// new permission, we keep the user_id
					$result['permission']['user_id'] = $args['user_id'];
				break;	
		} 

		//$result['purposes'] = getManyAssocArrays( 'select purpose_id, purpose from permission_purposes order by purpose');		
		
        return $result;
    } 	
	

	function buildPermissionView( $permission_id)
	{
		// retrieve the selected record
		$permission = getOneAssocArray( 'SELECT * FROM permissions WHERE permission_id = "'.$permission_id.'"');
		//if ($permission['purpose_id'])			
		//	$purpose = getOneAssocArray( 'SELECT purpose FROM permission_purposes WHERE purpose_id = '.$permission['purpose_id'] );	

		// merge all arrays to build up user branch in XML stream
		return array_merge( $permission, $purpose);
	}
	

}
