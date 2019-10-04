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

class administration_customization_popup_view extends administration_customization_applications{
	
    function __construct()
    {
        parent::__construct();    	

	    $this->form_name 			= 'popup_view';
	    $this->field_sequence 		= 'popup_view_sequence';
	    $this->field_block_id 		= 'popup_view_block_id';	    
	    $this->field_side 			= 'popup_view_side';	    
	    $this->from_form_name		= 'view';
	    $this->from_field_sequence	= 'view_sequence';
	    $this->from_field_block_id	= 'view_block_id';
	    $this->from_field_side 		= 'view_side';

        $GLOBALS['appshore']->add_xsl('administration.customization_view');  		
	} 
  
}
