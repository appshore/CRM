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



// calculate the size of a folder and its children
function folderSize( $folder_id)
{
	unset( $GLOBALS['foldersTree']);
	$children = getChildren( $folder_id);
	
	$filesize = 0;
	if( $children )
   		foreach( $children as $key => $value )
   		{
   			if( $value['is_folder'] == 'N' )
				$filesize += $value['filesize'];
		}	
					
	return $filesize;
}


// list all ancestors from a designated folder
function getReverseFolders( $document_id = '0', $level = 0)
{
	if( $level == 0 )
		unset( $GLOBALS['foldersTree']);

	if( $document_id != '0')
	{
		$document = getOneAssocArray( 'SELECT document_name, document_id, folder_id FROM documents WHERE document_id = "'.$document_id.'"');  		

		if( isset($document['document_id']) )
		{
			$GLOBALS['foldersTree'][] = $document;
			return getReverseFolders($document['folder_id'], $level+1);
		}
	}

	$GLOBALS['foldersTree'][] = array( 'document_name' => lang('Home'), 'document_id' => '0', 'folder_id' => '0');
	return array_reverse($GLOBALS['foldersTree']);
}

function getFolders( $avoid_document_id, $document_id = '0', $level = 0)
{
		if( $level == 0 )
			unset( $GLOBALS['foldersTree']);
			    
		$document = getOneAssocArray( 'SELECT document_name, document_id, folder_id FROM documents
		WHERE document_id = "'.$document_id.'"');  		
		
		if( $document['document_id'] )
		{
			$document['level'] =  $level;
			$GLOBALS['foldersTree'][] = $document;
		}
		else
		{
			$level++;
			$document['level'] =  $level;  		
			$GLOBALS['foldersTree'][] = array( 'document_name' => lang('Home'), 'document_id' => '0', 'folder_id' => '0');
		}  		

	$nodes = getManyAssocArrays( 'select document_id from documents '.buildClauseWhere('documents','R','').' AND folder_id = "'.$document_id
		.'" AND is_folder = "Y" ORDER BY document_name ASC');
	
	if( isset($nodes) )
	{
		foreach( $nodes as $key => $value )
		{
			if( $value['document_id'] != $avoid_document_id )
    			getFolders( $avoid_document_id, $value['document_id'], $level+1);
		}
	}
			
	return $GLOBALS['foldersTree'];
}  

function getChildren( $document_id = '0', $level = 0)
{		
	if( $level == 0 )
		unset( $GLOBALS['foldersTree']);
		   
	$document = getOneAssocArray( 'SELECT * FROM documents WHERE document_id = "'.$document_id.'"');  		
	
	if( $document['document_id'] )
	{
		$document['level'] =  $level;
		$GLOBALS['foldersTree'][] = $document;
	}


	$nodes = getManyAssocArrays( 'SELECT document_id FROM documents '.buildClauseWhere('documents','R','').' AND folder_id = "'.$document_id.'"');
	
	if( isset($nodes) )
	{
		foreach( $nodes as $key => $value )
		{
			$avoid = false;
	    	if( isset($GLOBALS['foldersTree']) )
	    	{
   				foreach( $GLOBALS['foldersTree'] as $keyres => $valres )
   					if( $valres['document_id'] == $value['document_id'] )
   					{
   						$avoid = true;
   						break;
   					}
   			}
				if( $avoid == false )
			   		getChildren( $value['document_id'], $level+1);
		}
	}
			
	return $GLOBALS['foldersTree'];
}    
