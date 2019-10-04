<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.panelets.php');

class accounts_panelets extends lib_panelets
{
    function __construct()
    {
    	$this->appTable 		= 'accounts';
    	$this->appRecordId		= 'account_id';    	
    	$this->appRecordName	= 'account_name';    	
    	$this->appOrderBy		= 'account_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'accounts';
    	$this->appNameSingular	= 'account';    	
    	$this->appLabel 		= 'Accounts';
    	$this->appLabelSingular = 'Account';    
    	$this->appXSL 			= 'accounts.base';
    	$this->appRole 			= 'accounts';
    }

	    
	function my_most_actives_accounts($args)
	{	
		if(	($result = getManyAssocArrays('SELECT * FROM accounts '.$this->filter($args))) == null)
			return null;
					
#		foreach( $result as $key => $val )
#		{
#			$result[$key]['time'] = $GLOBALS['appshore']->local->timeToLocal($GLOBALS['appshore']->local->gmtToTZ($val['activity_start']));
#		}
		return $result;
	}    
  
}
