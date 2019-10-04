<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/


require_once ( 'class.customization_applications.php');

class administration_customization_searches extends administration_customization_applications{
	
    function __construct()
    {
        parent::__construct();    	

	    $this->form_name 			= 'searches';
	    $this->field_sequence 		= 'search_sequence';
	    $this->from_form_name 		= 'popup_searches';
	    $this->from_field_sequence 	= 'popup_search_sequence';
	    unset($this->field_side);	    
	    unset($this->field_block_id);	    

        $GLOBALS['appshore']->add_xsl('administration.customization_'.$this->form_name);  		
	} 
}
