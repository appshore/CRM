<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

class sessions_cache
{
    function __construct()
    {
    	if( $this->is_cache_session() == false )
    		return false;

      	session_set_save_handler(
      		array(&$this, 'open'),
            array(&$this, 'close'),
            array(&$this, 'read'),
			array(&$this, 'write'),
            array(&$this, 'destroy'),
            array(&$this, 'gc'));
            
        return true;
    }
 
    function open( $save_path, $session_name)
    {
        return true;
    }
 
    function close()
    {
        return true;
    }
 
    function read( $sid)
    {
        return (string)xcache_get('SESS::'.$sid);
    }
 
    function write( $sid, $session_data)
    {
        return xcache_set('SESS::'.$sid, $session_data, 86400);
    }
 
    function destroy( $sid)
    {
        return xcache_unset('SESS::'.$sid);
    }
 
    function gc( $maxlifetime)
    {
        return true;
    }
 
    function is_cache_session() 
    {
        return ($GLOBALS['appshore_data']['server']['cache_session'] && extension_loaded('xcache'));
    }
}
