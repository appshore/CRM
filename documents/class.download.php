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

// class contact extends download so requires it
require_once( APPSHORE_LIB . SEP . 'class.download.php');

class documents_download extends lib_download {
    
    function start()
    {
		$args = new safe_args();
		$args->set('document_id', NONE, 'any');
		$args = $args->get(func_get_args());
		
		// retrieve the selected record
		$document = getOneAssocArray( 'select document_name, filetype from documents where document_id = "'.$args['document_id'].'"');
		
		return $this->download( APPSHORE_DOCUMENTS.SEP.$args['document_id'], $document['document_name'], $document['filetype']);
    }
	
  
}
