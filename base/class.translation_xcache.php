<?php

class translation_cache
{    

    function getvar($key)
    {
        return xcache_get( $key);
    }
    
    function setvar( $key, $var, $ttl=0)
    {
     	xcache_set( $key, $var, $ttl);
     	return $var;
    }  

    function unsetvar( $key)
    {
     	return xcache_unset( $key);
    }  

    function unsetvars( $key)
    {
     	return xcache_unset_by_prefix( $key);
    }      
        
    function isvar( $key)
    {
    	return xcache_isset( $key);
    }          
   
    function iscache() 
    {
        return ($GLOBALS['appshore_data']['server']['cache_translation'] && extension_loaded('xcache'));
    }
}
