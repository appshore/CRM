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
require_once ( APPSHORE_LIB.SEP.'class.popup.php');

class support_faqs_popup extends lib_popup
{

    function __construct()
    {
    	$this->appTable 		= 'backoffice_support_faqs';
    	$this->appRecordId		= 'faq_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appOrderBy		= 'created';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'support_faqs';
    	$this->appNameSingular	= 'support_faq';    	
    	$this->appLabel 		= 'Frequently Asked Questions';
    	$this->appLabelSingular = 'Frequently Asked Question';    
    	$this->appXSL	 		= 'support.faqs';
    	$this->appRole 			= 'support';

        parent::__construct();    	
    }

}
