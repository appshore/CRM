<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.panelets.php');

class contacts_panelets extends lib_panelets
{
    function __construct()
    {
    	$this->appTable 		= 'contacts';
    	$this->appRecordId		= 'contact_id';    	
    	$this->appRecordName	= 'full_name';    	
    	$this->appOrderBy		= 'full_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'contacts';
    	$this->appNameSingular	= 'contact';    	
    	$this->appLabel 		= 'Contacts';
    	$this->appLabelSingular = 'Contact';    
    	$this->appXSL 			= 'contacts.base';
    	$this->appRole 			= 'contacts';
    }

	    
	function my_most_actives_contacts($args)
	{	
		if(	($result = getManyAssocArrays('SELECT * FROM contacts '.$this->filter($args))) == null)
			return null;
					
#		foreach( $result as $key => $val )
#		{
#			$result[$key]['time'] = $GLOBALS['appshore']->local->timeToLocal($GLOBALS['appshore']->local->gmtToTZ($val['activity_start']));
#		}
		return $result;
	}    
  
}
