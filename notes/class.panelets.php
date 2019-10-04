<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.panelets.php');

class notes_panelets extends lib_panelets
{
    function __construct()
    {
    	$this->appTable 		= 'notes';
    	$this->appRecordId		= 'note_id';    	
    	$this->appRecordName	= 'subject'; 
    	$this->appWhereFilter	= '';    	
    	$this->appOrderBy		= 'subject';    	
    	$this->appAscDesc		= 'asc';    	    	   	
    	$this->appName 			= 'notes';
    	$this->appNameSingular	= 'note';    	
    	$this->appLabel 		= 'Notes';
    	$this->appLabelSingular = 'Note';    
    	$this->appXSL	 		= 'lib.stub';		// to replace non existant 'notes.base';
    	$this->appRole 			= 'notes';
    }
	    
	function my_open_notes($args)
	{	
		if(	($result = getManyAssocArrays('SELECT * FROM notes '.$this->filter($args))) == null)
			return null;
					
		foreach( $result as $key => $val )
		{
			$result[$key]['date'] = $GLOBALS['appshore']->local->dateToLocal($GLOBALS['appshore']->local->gmtToTZ($val['due_date']));
		}
		return $result;
	}    
  
}
