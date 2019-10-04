<?php

class translation_cache extends Memcached
{    
    function __construct()
    {
    	parent::__construct();
		$this->addServer('localhost', 11211);
//$this->cache->flush(); sleep(2);
		$this->setOption( Memcached::HASH_DEFAULT , Memcached::OPT_LIBKETAMA_COMPATIBLE);
//var_dump($this->cache->getServerList());    
    }

    function getvar($key)
    {
        return $this->get( $key);
    }
    
    function setvar( $key, $var, $ttl=0)
    {
     	$this->set( $key, $var, $ttl);
     	return $var;
    }  

    function unsetvar( $key)
    {
     	return $this->delete( $key);
    }  

    function unsetvars( $key)
    {
     	return $this->delete( $key);
    }      
        
    function isvar( $key)
    {
		return (bool)$this->get($key);
    }          
   
    function iscache() 
    {
        return ($GLOBALS['appshore_data']['server']['cache_translation'] && extension_loaded('memcached'));
    }
}
