<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

// init some values when new Entry
function getInstanceNewEntry(  $args = null)
{
	if( $args['key'] == '' )
		$args['company_id'] = $args['company_alias'] = '';
    else
    	$args['company_id'] = $args['company_alias'];   
    $args['users_quota'] = 10;	        	
    $args['edition_id'] = 'TRIAL';	        	
    $args['due_date'] = gmdate( 'Y-m-d', strtotime('1 month'));	        	
    $args['disk_quota'] = getInstanceQuota('disk', $args['users_quota'], $args['edition_id']);   	        	
    $args['records_quota'] = getInstanceQuota('records', $args['users_quota'], $args['edition_id']);	        	
    $args['emails_quota'] = getInstanceQuota('emails', $args['users_quota'], $args['edition_id']);	        	
    $args['country_id'] = 'USA'; 	        	
    return $args;
} 


// set user's quotas
function getInstanceQuota( $type, $users, $edition_id)
{
	switch( $type )
	{
    		case 'disk': 		// disk
				$quota = 536870912;
			if( strpos($edition_id,'PRO') !== false )
					$quota *= $users;
			else if( strpos($edition_id,'PRE') !== false )
				$quota *= 2*$users;
			break;
		case 'emails': 		// emails
				$quota = 100;
			if( strpos($edition_id,'PRO') !== false )
					$quota *= 5 * $users;
			else if( strpos($edition_id,'PRE') !== false )
				$quota *= 20 * $users;
			break;
		case 'records':		// records
				$quota = 10000;
			if( strpos($edition_id,'PRO') !== false )
					$quota *= $users;
			else if( strpos($edition_id,'PRE') !== false )
				$quota *= 2*$users;
			break;
		default :
			$quota = 0;
			break;
	}
	
	return $quota;
}
	

