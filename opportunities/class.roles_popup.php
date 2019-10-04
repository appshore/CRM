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

class opportunities_roles_popup {

	// delete role
    function delete()
    {
		$args = new safe_args();
		$args->set('role_id',NOTSET,'any');
		$args->set('key',NOTSET,'any');
		$args = $args->get(func_get_args()); 
		
        $GLOBALS['appshore']->add_xsl('opportunities.base'); 
        $GLOBALS['appshore']->add_xsl('opportunities.roles_popup');
        $GLOBALS['appshore']->add_xsl('lib.base');		
        $GLOBALS['appshore']->add_xsl('lib.popup');	        
		
		switch($args['key'])
		{
			case 'Confirm':
				if ( $args['role_id']) 
					deleteRow( 'opportunities_roles', 'role_id', $args );
				$GLOBALS['appshore_data']['layout'] = 'popup';	
				$result['delete'] = 'true';					
				$result['action']['roles'] = 'delete';					
				break;		
					
			default:
				$GLOBALS['appshore_data']['layout'] = 'popup';	
				$result['action']['roles'] = 'delete';
				$result['role'] = $this->buildRoleView( $args['role_id'] );	
				break;
		}

        return $result;
    } 	
	
	
	// edit or create one role
    function edit()
    {
		$args = new safe_args();
		$args->set( 'key', NOTSET, 'any');
		// Allow to retrieve all the cols from this table
		$role = getOneAssocArray( 'select * from opportunities_roles limit 1');	
		foreach( $role as $fieldName => $fieldValue )
			$args->set( $fieldName, NOTSET, 'any');	
		$args = $args->get(func_get_args()); 
		
        $GLOBALS['appshore']->add_xsl('opportunities.base'); 
        $GLOBALS['appshore']->add_xsl('opportunities.roles_popup');
        $GLOBALS['appshore']->add_xsl('lib.base');		
        $GLOBALS['appshore']->add_xsl('lib.form');	        
        $GLOBALS['appshore']->add_xsl('lib.popup');	        		
		
 		switch($args['key'])
		{
			case 'Save':
	                // check mandatory fields
                $result['error'] = $this->checkFields($args);
                if ( isset( $result['error']) )
                {
                    messagebox( ERROR_INVALID_DATA, 'error');
                    $result['role'] = $args;
                }
                elseif ( $args['role_id']) 			// UPDATE an existing role
					updateRow( 'opportunities_roles', 'role_id', $args);
				else if ( $args['opportunity_id'])		// New role so we build an INSERT
					$args['role_id']= insertRow( 'opportunities_roles', 'role_id', $args);
				
				// use to reload main window after some change
				$result['save'] = 'true';	
								
				// NO Break for 'Save' case		
			default:
				$GLOBALS['appshore_data']['layout'] = 'popup';	
				$result['action']['roles'] = 'edit';
				if ( $args['role_id']) 	// Edit existing role
					$result['role'] = $this->buildroleView( $args['role_id'] );
				else					// New role
					$result['role']['opportunity_id'] = $args['opportunity_id'];
				break;	
		} 

        return $result;
    } 	


	function buildRoleView( $role_id)
	{
		// retrieve the selected record
		$role = getOneAssocArray('
			SELECT 
				opportunities_roles.role_id,
				opportunities_roles.opportunity_id,
				opportunities_roles.role,
				opportunities_roles.note,
				contacts.contact_id,				
				contacts.first_names,	
				contacts.last_name,	
				contacts.title,	
				accounts.account_id,
				accounts.account_name
			FROM
				opportunities_roles
				LEFT OUTER JOIN contacts 
					ON opportunities_roles.contact_id = contacts.contact_id
				LEFT OUTER JOIN accounts 					
					ON contacts.account_id = accounts.account_id					
			WHERE 
				role_id ="'.$role_id.'"'	
			);				

		return $role;
	}
	
    // Check mandatory fields and type of some
    function checkFields( $args )
    {
        unset( $result['error'] );

        if ( !$args['contact_id'] )
            $result['error']['contact_id'] = ERROR_MANDATORY_FIELD;

        return $result['error'];
    }	

}
