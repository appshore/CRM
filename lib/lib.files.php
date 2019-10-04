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


// check that a directory exists
function checkDirectory( $thisDirectory)
{
	// this place needs to be clean when it's called by others apps     
	if( is_dir($thisDirectory) == false )
	{
		createFoldersTree($thisDirectory);
	}
}

function createFoldersTree( $thisDirectory)
{
	$newDir = '';
	foreach( explode( '/', $thisDirectory) as $dirPart)
	{
		$newDir .= trim($dirPart);			
		if( is_dir( $newDir) == false )			
			@mkdir( $newDir, 0777);
		$newDir .= '/' ;			
	}
}

