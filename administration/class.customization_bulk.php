<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/

require_once ( 'class.customization_applications.php');

class administration_customization_bulk extends administration_customization_applications
{

    function __construct()
    {
        parent::__construct();    	

	    $this->form_name 		= 'bulk';
	    $this->field_sequence 	= 'bulk_sequence';
	    $this->field_block_id 	= 'bulk_block_id';
	    $this->field_side 		= 'bulk_side';
	    		
	    // same model as edit
        $GLOBALS['appshore']->add_xsl('administration.customization_edit'); 	    
	} 
}
