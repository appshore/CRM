<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

class base_sessions
{
	var $sid;
	var $baseurl;
	var $basepath;
	var $cache;
	
	function __construct()
	{
		if( $GLOBALS['appshore_interface'] != 'html' || !isset($_COOKIE['APPSESSID']) )
			$this->sid = get_var('sid', 'any', 'alphanumeric');
		else		
			$this->sid = $_COOKIE['APPSESSID'];

		if( !isset($this->sid) || empty($this->sid)) 
		{
			// no sid so it's a starting point
            $this->sid = strtoupper(generateId());
        }	            

		// session is named
		session_name('APPSESSID');
		session_id($this->sid);
		
		if( $GLOBALS['appshore_data']['server']['cache_session'] !== false )
		{
			include('class.sessions_'.$GLOBALS['appshore_data']['server']['cache_session'].'.php');
        	$this->cache = new sessions_cache();
        }
		session_start();
				
		if (!empty($GLOBALS['appshore_data']['server']['baseurl']))
		{
			$this->baseurl = $GLOBALS['appshore_data']['server']['baseurl'].'/?';
			$this->basepath = $GLOBALS['appshore_data']['server']['baseurl'];
		}
		else if (!empty($_SESSION['appshore_data']['server']['baseurl']))
		{
			$this->baseurl = $_SESSION['appshore_data']['server']['baseurl'].'/?';
			$this->basepath = $_SESSION['appshore_data']['server']['basepath'];
		}
		else
		{
			$this->baseurl = $GLOBALS['HTTP_SERVER_VARS']['PHP_SELF'];
			$this->basepath = '';
		}

		if( $GLOBALS['appshore_interface'] != 'html' )
			$this->baseurl .= 'sid='.$this->sid;

	}

	function setSession( $username = null)
	{		
		if( $username )
			$_SESSION['appshore_session']['session_username'] = $username;
			
		$_SESSION['appshore_session']['ip_address'] = $GLOBALS['HTTP_SERVER_VARS']['REMOTE_ADDR'];
		$_SESSION['appshore_session']['login_time'] = time();
        $_SESSION['appshore_session']['browser'] = $GLOBALS['HTTP_SERVER_VARS']['HTTP_USER_AGENT'];
	}

	function createSession()
	{
		session_unset();
		$_SESSION = array();
		if ( session_id())
			session_destroy();
	}
	
	function deleteSession()
	{
		if ( isset($_COOKIE['APPSESSID']) )
			setcookie( 'APPSESSID', "", time()-(3600*25));
		session_unset();
		$_SESSION = array();
		if ( session_id())
			session_destroy();
	}

	function is_anonymous()
	{
		return !isset($_SESSION['appshore_session']['session_username']);
	}

	function sid()
	{
		return $this->sid;
	}
	
	function baseurl()
	{
		return $this->baseurl;
	}	

}
