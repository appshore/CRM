<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/


require_once ( 'class.customization_applications.php');

class administration_customization_linked_view extends administration_customization_applications{
	
    function __construct()
    {
        parent::__construct();    	

	    $this->field_sequence		= 'linked_sequence';
	    $this->form_name 			= 'linked_view';
	    $this->from_form_name 		= 'results';
	    $this->from_field_sequence 	= 'result_sequence';
	    unset($this->field_side);	    
	    unset($this->field_block_id);	    

        $GLOBALS['appshore']->add_xsl('administration.customization_searches'); 	    
	} 

}
