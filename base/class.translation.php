<?php
/**************************************************************************\
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* Brice MICHEL <bmichel@appshore.com>                                      *
* Copyright (C) 2004 - 2009 Brice MICHEL                                   *
\**************************************************************************/

class base_translation
{
	var $cache;
	var $gtrs;
	var $ltrs;
	var $language_id;

	function __construct()
	{
		$this->language_id = '';
		$this->gtrs = 'GTRS::';	// global prefix key
		$this->ltrs = $GLOBALS['appshore_data']['server']['fulldomain'].'::LTRS::'; // local prefix key

		if( $GLOBALS['appshore_data']['server']['cache_translation'] !== false )
		{
			include('class.translation_'.$GLOBALS['appshore_data']['server']['cache_translation'].'.php');
        	$this->cache = new translation_cache();
        }		
	}

	function load()
	{	
		if( isset($this->cache) == false )
			return false;
			
		// set the global translation cache if needed
		if( $this->cache->getvar($this->gtrs) == false )
		{
			$db = executeSQL('SELECT * FROM global_translation');	
				
	       	while ($result = $db->FetchRow())
	 		{
				$this->cache->setvar( $this->gtrs.str_replace(' ', '', $result['phrase'] ), $result);
			}
			$this->cache->setvar( $this->gtrs, true);
		}

		// set the local (custom) translation cache if needed
		if( $this->cache->getvar($this->ltrs) == false )
		{
			$db = executeSQL('SELECT * FROM translation');	
				
	       	while ($result = $db->FetchRow())
	 		{
				$this->cache->setvar( $this->ltrs.str_replace(' ', '', $result['phrase'] ), $result, 14400);
			}
			$this->cache->setvar( $this->ltrs, true, 14400);
		}
	}

	function get( $phrase)
	{	
		if( isset($this->cache) == false )
			return $phrase;

		$key = str_replace(' ', '', $phrase);

		if( $this->language_id != '' )
			$language_id = $this->language_id;
		elseif( isset($GLOBALS['appshore_data']['current_user']['language_id']) )
			$language_id = $GLOBALS['appshore_data']['current_user']['language_id'];
		else
			$language_id = $GLOBALS['appshore_data']['server']['language_id'];

		$result = $this->cache->getvar( $this->ltrs.$key);
		if( isset($result) )
		{
			if( $result[$language_id] != '' )
				return $result[$language_id];

			if( $result[$GLOBALS['appshore_data']['server']['language_id']] != '' )
				return $result[$GLOBALS['appshore_data']['server']['language_id']];
		}
					
		$result = $this->cache->getvar( $this->gtrs.$key);
		if( isset($result) )
		{
			if( $result[$language_id] != '' )
				return $result[$language_id];

			if( $result[$GLOBALS['appshore_data']['server']['language_id']] != '' )
				return $result[$GLOBALS['appshore_data']['server']['language_id']];
		}

		return $phrase;
	}	

	// we force the local translation cache as invalid
	function outdateltrs( $ltrs=null)
	{	
		if( isset($this->cache) == false )
			return false;

		if( $ltrs )
			$this->cache->setvar( $ltrs.'::LTRS::', false, 14400);		
		else
			$this->cache->setvar( $this->ltrs, false, 14400);

		return true;
	}		

			
#	function load()
#	{	
#		$this->cache = new Memcached();
#		$this->cache->addServer('localhost', 11211);
#//$this->cache->flush(); sleep(2);
#		$this->cache->setOption( Memcached::OPT_HASH , Memcached::OPT_LIBKETAMA_COMPATIBLE);
#//var_dump($this->cache->getServerList());

#		if( $this->cache->get($this->gtrs) == false )
#		{
#			$db = executeSQL('SELECT * FROM global_translation');	
#				
#	       	while ($result = $db->FetchRow())
#	 		{
#				$key = str_replace(' ', '', $result['phrase'] );
#				if( $this->cache->get( $this->gtrs.$key) == false )
#					$this->cache->set( $this->gtrs.$key, $result);
#			}
#			$this->cache->set( $this->gtrs, true);
#		}

#		if( $this->cache->get($this->ltrs) == false )
#		{
#			$db = executeSQL('SELECT * FROM translation');	
#				
#	       	while ($result = $db->FetchRow())
#	 		{
#				$key = str_replace(' ', '', $result['phrase'] );
#				if( $this->cache->get( $this->ltrs.$key) == false )
#					$this->cache->set( $this->ltrs.$key, $result, 14400);
#			}
#			$this->cache->set( $this->ltrs, true, 14400);
#		}
##echo '<br/>'		;
##var_dump($this->cache->get(preg_replace( '/\s*/', '', 'First name')));
##echo $this->cache->getResultCode();
##var_dump($this->cache->getStats());
#	}		

#	function get( $phrase)
#	{	
#		$key = str_replace(' ', '', $phrase);

#		if( isset($GLOBALS['appshore_data']['current_user']['language_id']) )
#			$language_id = $GLOBALS['appshore_data']['current_user']['language_id'];
#		else
#			$language_id = $GLOBALS['appshore_data']['server']['language_id'];

#		$result = $this->cache->get( $this->ltrs.$key);
#		if( isset($result) && $result[$language_id] != '' )
#			return $result[$language_id];
#					
#		$result = $this->cache->get( $this->gtrs.$key);
#		if( isset($result) && $result[$language_id] != '' )
#			return $result[$language_id];

#		if( isset($result) && $result[$GLOBALS['appshore_data']['server']['language_id']] != '' )
#			return $result[$GLOBALS['appshore_data']['server']['language_id']];

#		return $phrase;
#	}	

	

}
	
