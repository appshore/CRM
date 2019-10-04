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

class webmail_folder {

    function foldersSetup()
    {
    	// initial set up of defaults folders
		if( $this->folderCreate( 'Inbox', 'inbox', 10) != null )
		{
			$this->folderCreate( 'Draft', 'draft', 30);
			$this->folderCreate( 'Sent', 'sent', 40);
			$this->folderCreate( 'All', 'all', 50);			
			$this->folderCreate( 'Junk', 'junk', 60);
			$this->folderCreate( 'Trash', 'trash', 70);
		}   
    }
       
    
    function emptyTrash()
    {
 		$folder = getOneAssocArray( 'select folder_id from webmail_folders 
			where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and folder_type = "trash"');
			
		$emails = getManyAssocArrays(' select mail_id from webmail where folder_id = "'.$folder['folder_id'].'"');
    	
    	if( $emails )
    	{
	    	foreach( $emails as $keyemail => $valemail)
	    	{
				if( $files = getManyAssocArrays( 'select attachment_id from webmail_attachments where mail_id = "'.$valemail['mail_id'].'"') )
				{	//we delete each attachment
					foreach ($files as $keyfiles => $valfiles) 
						@unlink( APPSHORE_ATTACHMENTS.SEP.$valfiles['attachment_id']);
				}

				$GLOBALS['appshore']->db->execute( 'delete from webmail_attachments where mail_id = "'.$valemail['mail_id'].'"');
				$GLOBALS['appshore']->db->execute( 'delete from webmail_documents where mail_id = "'.$valemail['mail_id'].'"');
			}
			
			$GLOBALS['appshore']->db->execute( 'delete from webmail where folder_id = "'.$folder['folder_id'].'"');

			messagebox( 'Trash emptied', NOTICE);
		}
					
	    return execMethod( 'webmail.base.search', '', true);									
    }      
    
    function folderCreate( $folder_name, $folder_type, $sequence)
    {
    	$result = null;

		$folder = getOneAssocArray( 'select count(folder_id) as count from webmail_folders 
			where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and folder_name = "'.$folder_name.'"');
			
		if( $folder['count'] == '0' )
		{
			$folder['folder_name'] = $folder_name;
			$folder['folder_type'] = $folder_type;
			$folder['folder_id'] = generateID();	// to simplify management					
			$folder['sequence'] = $sequence;				
			$folder['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
					
			if ( ($folder_id = insertRow( 'webmail_folders', 'folder_id', $folder, false)) != NULL )
            	$result = $folder_id;
        }    				

		return $result;
    }
    
     
    function folderInfo( $folder_id)
    {
		return getOneAssocArray( 'select * from webmail_folders 
			where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and folder_id = "'.$folder_id.'"');
    }  
 
  
    function foldersList()
    {
		$folders =  getManyAssocArrays( 'select * from webmail_folders where folder_type not in ("archive") and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].
			'" order by sequence, folder_name');
			
		if( $folders )
		{
			foreach( $folders as $key => $val)
			{
				$folders[$key]['nbr_webmail'] = getOneColOneRow( 'select count(mail_id) from webmail 
					where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and folder_id = "'.$val['folder_id'].'"');
				$folders[$key]['nbr_unread'] = getOneColOneRow( 'select count(mail_id) from webmail 
					where is_read = "N" and user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and folder_id = "'.$val['folder_id'].'"');
			}
		}
		
		return $folders;
    }  
     
    function folderDefault()
    {
		$result = getOneAssocArray( 'select folder_id from webmail_folders 
			where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" and folder_type = "inbox"');
			
		return $result['folder_id'];
    }  

}
