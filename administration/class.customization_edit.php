<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/

require_once ( 'class.customization_applications.php');

class administration_customization_edit extends administration_customization_applications{	
	
    function __construct()
    {
        parent::__construct();    	

	    $this->form_name 			= 'edit';
	    $this->field_sequence		= 'edit_sequence';
	    $this->field_block_id 		= 'edit_block_id';
	    $this->field_side 			= 'edit_side';
	    $this->from_form_name		= 'view';
	    $this->from_field_sequence	= 'view_sequence';
	    $this->from_field_block_id 	= 'view_block_id';	    
	    $this->from_field_side 		= 'view_side';
	    		
        $GLOBALS['appshore']->add_xsl('administration.customization_'.$this->form_name);  		
	}  
}
