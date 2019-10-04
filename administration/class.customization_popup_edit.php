<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * \*************************************************************************
 */

require_once ( 'class.customization_applications.php');

class administration_customization_popup_edit extends administration_customization_applications{
	
    function __construct()
    {
        parent::__construct();    	

	    $this->form_name 			= 'popup_edit';
	    $this->field_sequence 		= 'popup_edit_sequence';
	    $this->field_block_id 		= 'popup_edit_block_id';	    
	    $this->field_side 			= 'popup_edit_side';	    
	    $this->from_form_name		= 'edit';
	    $this->from_field_sequence	= 'edit_sequence';
	    $this->from_field_block_id 	= 'edit_block_id';	    
	    $this->from_field_side 		= 'edit_side';	

        $GLOBALS['appshore']->add_xsl('administration.customization_edit');                
	} 
  
}
