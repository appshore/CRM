<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/


// class meeting extends activities so requires it
require_once ( 'class.setup.php');

class webmail_setup_folders extends webmail_setup {
	
	// view one setup
    function edit()
    {
		$args = new safe_args();
		$args->set('key',	NOTSET,	'any');
		$args->set('is_archive',	false,	'any');
		foreach( describeColumns( 'webmail_folders') as $fieldName => $fieldValue )
			$args->set( $fieldName,	$_SESSION['folders'][$fieldName], 'any');	
		$args = $args->get(func_get_args());
		
		$this->menus();	
        $GLOBALS['appshore']->add_xsl('webmail.setup_folders');  		
		
		$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], 'webmail');
		
		switch($args['key'])
		{
			case 'Delete':
				if( !$args['folder_id'] || deleteRow( 'webmail_folders', 'folder_id', $args, false) == FALSE )
				{
					unset( $args['key']);
				    $result = $this->edit( $args);					
				}
				else
				{
					// move the content to Trash folder
 					$folder = getOneAssocArray( 'select folder_id from webmail_folders 
						where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and folder_type = "trash"');    	
					executeSQL( 'update webmail set folder_id = "'.$folder['folder_id'].'" where folder_id = "'.$args['folder_id']
						.'" and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');					
			
					messagebox(MSG_DELETE);											
				}	      
				break;		
			case 'Save':
				$args['folder_type'] = ($args['is_archive'] == 'Y')?'archive':'folder'; // set the folder as an archive

                // check mandatory fields
                if ($args['folder_id']) 			// UPDATE an existing record
				{
					if( updateRow( 'webmail_folders', 'folder_id', $args) == null )
						$result['folder'] = $args;
	                else
	                	messagebox(MSG_UPDATE);
				}
				else 								// New record so we do an INSERT
				{
        			$args['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
        			$args['sequence'] = '999';  				
					if ( ($args['folder_id'] = insertRow( 'webmail_folders', 'folder_id', $args)) == null )
	                    $result['folder'] = $args;
	                else
	                	messagebox(MSG_INSERT);
				}	
								
				break;
		}
		
		if( $args['folder_id'])
		{
			$result['folder'] = getOneAssocArray('select * from webmail_folders where folder_id = "'.$args['folder_id'].'"'); 
            if ($result['folder']['folder_type'] == 'archive') 
    			$result['folder']['is_archive'] = 'Y';
        }
			
		$result['Myfolders'] = getManyAssocArrays('select folder_id, folder_name, folder_type from webmail_folders 
			where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and sequence = "999" order by folder_type desc, folder_name');	

		$result['action']['webmail'] = 'setup_folders';	
	
		// Put tab context 
		$result['recordset']['tab_id'] = 'folders';
		$result['recordset']['appName'] = 'webmail';
		$result['tabs'] = $this->tabs;	
		$result['folders'] = execMethod('webmail.folder.foldersList', true);
					
		return $result;
    } 	
 
}
