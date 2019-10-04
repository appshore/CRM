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

class support_tickets_popup extends lib_popup
{

    function __construct()
    {
    	$this->appTable 		= 'backoffice_support_tickets';
    	$this->appRecordId		= 'ticket_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appOrderBy		= 'status_id asc, priority_id asc, updated';    	
	    if( $GLOBALS['appshore_data']['my_company']['company_alias'] != 'backoffice' )
			$this->appWhereFilter	= 'company_id = "'.$GLOBALS['appshore_data']['my_company']['company_id'].'"';		// filter of the table
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'support_tickets';
    	$this->appNameSingular	= 'support_ticket';    	
    	$this->appLabel 		= 'Tickets';
    	$this->appLabelSingular = 'Ticket';    
    	$this->appXSL	 		= 'support.tickets';
    	$this->appRole 			= 'support';

        parent::__construct();    	
    }

}
