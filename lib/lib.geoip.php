<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

function getCountryId( $remote_addr = null)
{
	include_once(APPSHORE_INCLUDES.'/geoip/geoip.inc.php');		

	if( $remote_addr == null )
		list( $ip, $ip, $ip, $remote_addr) = explode( ':', $_SERVER['REMOTE_ADDR']);
		
	$geoipdb = geoip_open(APPSHORE_INCLUDES.'/geoip/GeoIP.dat',GEOIP_STANDARD);
	$country_iso_3166 = geoip_country_code_by_addr( $geoipdb, $remote_addr);
	geoip_close($geoipdb);
	
	if( $country_iso_3166 == '' )
		return null;
		
	$country = getOneAssocArray( 'select country_id from global_countries where country_iso_3166 = "'.$country_iso_3166.'"');
	return $country['country_id'];
}	
