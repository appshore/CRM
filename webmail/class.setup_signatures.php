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
require_once ( 'class.setup.php');

class webmail_setup_signatures extends webmail_setup{
	
 	// view one setup
    function edit()
    {
		$args = new safe_args();
		$args->set('key',	NOTSET,	'any');
		foreach( describeColumns( 'webmail_signatures') as $fieldName => $fieldValue )
			$args->set( $fieldName,	$_SESSION['signatures'][$fieldName], 'any');	
		$args = $args->get(func_get_args());
		
		$this->menus();	
        $GLOBALS['appshore']->add_xsl('webmail.setup_signatures');  		
		
		$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], 'webmail');
		
		switch($args['key'])
		{
			case 'Delete':
				if( !$args['signature_id'] || deleteRow( 'webmail_signatures', 'signature_id', $args, false) == false )
					unset( $args['key']);
				else
					messagebox(MSG_DELETE);											
				break;		
			case 'Save':
				if ($args['signature_id']) 			// UPDATE an existing record
				{
					if( updateRow( 'webmail_signatures', 'signature_id', $args) == null )
						$result['signature'] = $args;
	                else
	                	messagebox(MSG_UPDATE);
				}
				else 								// New record so we do an INSERT
				{
					$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
					if ( ($args['signature_id'] = insertRow( 'webmail_signatures', 'signature_id', $args)) == null )
	                    $result['signature'] = $args;
	                else
	                	messagebox(MSG_INSERT);
				}	
								
				break;
		}
		
		if( $args['signature_id'])
			$result['signature'] = getOneAssocArray('select * from webmail_signatures where signature_id = "'.$args['signature_id'].'"'); 
			
		$result['signatures'] = getManyAssocArrays('select signature_id, signature_name from webmail_signatures 
			where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" order by signature_name');	
							
		$result['action']['webmail'] = 'setup_signatures';	
	
		// Put tab context 
		$result['recordset']['tab_id'] = 'signatures';
		$result['recordset']['appName'] = 'webmail';
		$result['tabs'] = $this->tabs;				
		$result['folders'] = execMethod('webmail.folder.foldersList', true);
		return $result;
    } 	

}
