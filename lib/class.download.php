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

// generic classe to download into tables
// classes child specific to each app must be defined to init some variables
// and to build menus
class lib_download 
{   
	// stub
    function __construct()
    {
    }
 	// First stage of download where user set up download file type, name and if we have an header
    function safeArgsDownload()
    {  	   	
		$args = new safe_args();
		$args->set('pathAndFilename', 	NOTSET, 'any');
		$args->set('filename', 			NOTSET, 'any');
		$args->set('filetype', 			NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		$this->download( $args['pathAndFilename'], $args['filename'], $args['filetype']);
	}
	
	// First stage of download where user set up download file type, name and if we have an header
    function download( $pathAndFilename, $filename, $filetype='')
    {  	   	
		//we empty and suppress the rendering buffer to be sure that nothing will output
		while (@ob_end_clean());
        
		//we set this global variable to avoid to build XSL templates
		$GLOBALS['appshore']->DownloadExport = true;
				
		// all these code came from php.net examples to work with IE
		
		ini_set( 'zlib.output_compression', 'Off');	
		header('Pragma: public');
		header('Cache-Control: no-store, no-cache, must-revalidate'); // HTTP/1.1
		header('Content-Transfer-Encoding: none');
		
		if( $filetype == 'html' )
			header('Content-Type: text/html; charset=utf-8');	
		else 
		{
			if( $filetype == 'csv' )
				header('Content-Type: text/csv; name="'.$filename.'.csv"; charset='.$GLOBALS['appshore_data']['current_user']['charset_id']);
			else if( $filetype )
				header('Content-Type: '.$filetype.'; name="'.$filename.'"; charset=utf-8'); //This should work for IE & Opera	
			else
			{	
				header('Content-Type: application/octetstream; name="'.$filename.'"'); //This should work for IE & Opera
				header('Content-Type: application/octet-stream; name="'.$filename.'"'); //This should work for the rest
			}
		
			header('Content-Disposition: attachment; filename="'.$filename.'"; '. rand(1,9));
			
			header('Content-Length: '.(string)filesize( $pathAndFilename));
		}
		
		
		// open the file to download
		$fp = fopen( $pathAndFilename, 'rb');
		// send the file to the standard output
		fpassthru($fp);
		// close the file
		fclose($fp);
		
		
		// exit is mandatory is this case because the output is unconventional (download)	
		// so we dont want to go through AppShore rendering engine				
		exit();	
    } 


}
