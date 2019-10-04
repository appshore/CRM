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
    $args['users_quota'] = 5;	        	
    $args['edition_id'] = 'LESS-TRIAL';	        	
    $args['due_date'] = gmdate( 'Y-m-d', strtotime('10 day'));	        	
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
    	case 'disk': 		
			$quota = 536870912;
			break;
		case 'emails': 		
			$quota = 500;
			break;
		case 'records':		
			$quota = 5000;
			break;
		default :
			$quota = 0;
			break;
	}

	if( $users == 1 )
		$quota *= 2;
	else if( $users == 5 )
		$quota *= 4;
	else if( $users == 10 )
		$quota *= 8;
	else if( $users == 20 )
		$quota *= 16;
	
	return $quota;
}
	

