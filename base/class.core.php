<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/

class base_core
{
	var $session;
	var $db; 
	var $interface;
	var $auth;
	var $rbac;
	var $apps;
	var $lang;

	var $xmlroot;
	var $plugins = array();
	var $xsl_files = array();

	var $app_menus = array();
	var $submenus = array();	

	var $context = array();	

	function start()
	{
		$result['text']   = ' ';
		return $result;
	}

	function ping()
	{
		return $GLOBALS['appshore']->interface->ping();
	}

	/*!
	@function load_base_classes
	@abstract Loads up the users base classes only once.
	*/
	function load_base_classes($force = false)
	{
		if ( $GLOBALS['appshore']->session->is_anonymous() == true )
		{
			// We create a fake user named anomymous
			$GLOBALS['appshore']->rbac = createObject('base_rbac');	
			$GLOBALS['appshore_data']['current_user'] = isset($_SESSION['current_user'])?$_SESSION['current_user']:array();
			$GLOBALS['appshore_data']['current_user']['user_id'] = 'anonymous';
			$GLOBALS['appshore_data']['current_user']['user_name'] = 'anonymous';				
			$GLOBALS['appshore_data']['current_user']['first_names'] = '';
			$GLOBALS['appshore_data']['current_user']['last_name'] = '';										
			$GLOBALS['appshore_data']['current_user']['full_name'] = '';					
		}		
		else if( $force == false || isset($GLOBALS['appshore']->rbac) == false )
		{
			$GLOBALS['appshore']->rbac = createObject('base_rbac');	
			$GLOBALS['appshore_data']['current_user'] = $_SESSION['current_user'] = $GLOBALS['appshore']->rbac->getUserInfos($_SESSION['appshore_session']['session_username']);						
		}		

		if( $force == false )
			$GLOBALS['appshore']->rbac->getCompanyInfos();
				
		$GLOBALS['appshore']->rbac->setUserRBAC();																			
		$GLOBALS['appshore']->rbac->setUserApps();				

		// Now we load translation specific to user language pref, current application and common api
		$GLOBALS['appshore']->local = createObject('base_localization');						
		$GLOBALS['appshore']->local->getUserPreferences();	

		// Now we load translation specific to user language pref, current application and common api
		$GLOBALS['appshore']->trans = createObject('base_translation');						
		$GLOBALS['appshore']->trans->load();
		
		$GLOBALS['appshore']->history = createObject('base_history');			

		// no need more steps if the user is anonymous
		if ( $GLOBALS['appshore']->session->is_anonymous() == true )
			return;
			
		// set default app once user is authentified for html interface only
		if( $force == true && $GLOBALS['appshore_interface'] == 'html' )
		{
			$GLOBALS['appshore_data']['layout'] = 'topbar';
			$GLOBALS['appshore_data']['api']['op'] = $GLOBALS['appshore_data']['current_user']['app_name'].'.base.start';
		}

		$this->check_op();
		
		// we force the user to the subscription form if the sub or the trial has ended
		if( $GLOBALS['appshore_data']['api']['op'] != 'base.core.ping' && $GLOBALS['appshore_data']['my_company']['company_status'] == 'CLO' )
		{
			list( $classname, $methodname) = explode( '.', $GLOBALS['appshore_data']['api']['op']);
			if( $classname.'.'.$methodname != 'administration.'.PRIVATE_LABEL.'subscription' )
			{
				$GLOBALS['appshore_data']['api']['op'] = 'administration.'.PRIVATE_LABEL.'subscription.upgrade';
		
				if( strpos( $GLOBALS['appshore_data']['my_company']['edition_id'], 'TRIAL') )
					messagebox( ERROR_TRIAL_ENDED, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
				else
					messagebox( ERROR_SUBSCRIPTION_ENDED, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
				return;
			}
		}	

		// We check the timezone
		//$GLOBALS['appshore']->local->checkTimezone();

#		if( $_SESSION['statistics']['db_records'] >= $GLOBALS['appshore_data']['my_company']['records_quota'] )
#		{
#            messagebox( ERROR_RECORDS_QUOTA, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
#		}
#		else if( $_SESSION['statistics']['disk_used'] >= $GLOBALS['appshore_data']['my_company']['disk_quota'] )
#		{
#            messagebox( ERROR_DISK_QUOTA, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
#		}
	}	
	
	/*!
	@function add_xsl
	@abstract Adds another xsl file to the list of those required by the current operation.
	@param $xsl
	*/
	function add_xsl()
	{
		$args = new safe_args();
		$args->set('xsl', NOTSET, 'any');
		$args = $args->get(func_get_args());

		if( $args['xsl'] )
		{
			$this->xsl_files[] = $args['xsl'];
			$this->xsl_files   = array_unique($this->xsl_files);
		}
	}
	
	/*!
	@function remove_xsl
	@abstract Adds another xsl file to the list of those required by the current operation.
	@param $xsl
	*/
	function remove_xsl()
	{
		$args = new safe_args();
		$args->set('xsl', NOTSET, 'any');
		$args = $args->get(func_get_args());
		
		if( $args['xsl'] )
			$this->xsl_files = array_diff($this->xsl_files, array($args['xsl']));
	}
	
	
	/*!
	@function apimenu private
	@abstract Adds the api's menu to the xml
	* BMI: Add associative array with each $menu
	*/
	function apimenu()	
	{
	
		// Anonymous users must go through a process handle by api.base.anonymous method 	
		if( $GLOBALS['appshore']->session->is_anonymous() == false )
		{
			if ( $GLOBALS['appshore']->rbac->check('administration', RBAC_RUN_APP) )
			{
				$menu['administration'][] = array(
					'title' => 'Administration',
					'op'    => 'administration.base.start'
					);
			}
	
			if ( $GLOBALS['appshore']->rbac->check('preferences', RBAC_RUN_APP) )
			{
				$menu['preferences'][] = array(
					'title'     => 'Preferences',
					'op'        => 'preferences.base.start'
					);
			}

			$menu['logout'][]	 = array(
				'title' => 'Logout',
				'op'    => 'base.auth.logout'
				);	
		}
		else
		{
			$menu['login'][]	 = array(
				'title' => 'Login',
				'op'    => 'base.auth.login'
				);				
		}
		
		return $menu;
	}

	function add_appmenu()
	{
		$args = new safe_args();
		$args->set('title', 		NOTSET, 'string');
		$args->set('item_title',	NOTSET, 'string');
		$args->set('item_op',		NOTSET, 'string');
		$args = $args->get(func_get_args());

		// loop test to avoid to stack many times the same menu
		if( $this->app_menus[$args['title']] )
		{
			foreach ( $this->app_menus[$args['title']] as $key => $val )
			{
				if ( $val['title'] == $args['item_title'] && $val['op'] == $args['item_op'] )
					return false;
			}
		}
		
		if( $args['title'] && $args['item_title'] && $args['item_op'] )
			$this->app_menus[$args['title']][] = array(
				'title' => $args['item_title'],
				'op'    => $args['item_op']
			);

		return true;
	}
	
	function finish_appmenus()
	{
		$result = array();
		
		foreach ($this->app_menus as $key => $values)
		{
			unset($r);

			foreach ($values as $value)
			{
				$r[] = array(
					'title' => $value['title'],
					'op'    => $value['op']
					);
			}
			
			$result[] = array(
				'title' => $key,
				'links' => $r
			);
		}

		return $result;
	}
	
	function add_submenu()
	{
		$args = new safe_args();
		$args->set('id', 	NOTSET, 'string');
		$args->set('title',	NOTSET, 'string');
		$args->set('op',	NOTSET, 'string');
		$args = $args->get(func_get_args());

		// loop test to avoid to stack many times the same menu
		foreach ( $this->submenus as $key => $val )
		{
			if ( $val['title'] == $args['title'] && $val['op'] == $args['op'] && $val['id'] == $args['id'] )
				return false;
		}
		
		if( $args['id'] && $args['title'] && $args['op'] )
			$this->submenus[] = array(
				'id' 	=> $args['id'],		
				'title' => $args['title'],
				'op'    => $args['op']
			);

		return true;
	}
	
	/*
		function to set a value in the xml stream /APPSHORE/API
	*/
	function setContext( )
	{
		$args = new safe_args();
		$args->set('name', 	REQUIRED, 'string');
		$args->set('value', REQUIRED, 'any');		
		$args = $args->get(func_get_args());
			
		$this->context[$args['name']] = $args['value'];
	}
	
	/*
		function to set a value in the xml stream /APPSHORE/API
	*/
	function addNode( $nodeValue, $nodeName)
	{
		$GLOBALS['xml_api']->AttachToXml( $nodeValue, $nodeName);
	}		

	/*
		function to set a value in the xml stream /APPSHORE/API/Plugins
	*/
	function addPlugins( $plugins = null )
	{
		if( $plugins )
		{
			$this->plugins[] = $plugins;
			$this->plugins   = array_unique($this->plugins);
		}
	}		

	function removePlugins( $plugins = null )
	{		
		if( $plugins )
			$this->plugins = array_diff($this->plugins, array($plugins));
	}		
					
	
	/*!
	@function check_op
	@abstract Picks up and parses the op param and makes sure that its values are generally sane.
	*/
	function check_op()
	{

		if( isset($GLOBALS['appshore_data']['api']['op']) == false )
		{
#			if( isset($inputs['op']) )
#				$GLOBALS['appshore_data']['api']['op'] = $inputs['op'] ;
#			else 
			if ( $GLOBALS['appshore']->session->is_anonymous() == true )
				$GLOBALS['appshore_data']['api']['op'] = $GLOBALS['appshore_data']['server']['default_anon_op'];
			else if ( isset($GLOBALS['appshore_data']['current_user']['app_name']) )
				$GLOBALS['appshore_data']['api']['op'] = $GLOBALS['appshore_data']['current_user']['app_name'].'.base.start';
			else if ( isset($_SESSION['current_user']['app_name']) )
				$GLOBALS['appshore_data']['api']['op'] = $_SESSION['current_user']['app_name'].'.base.start';
			else
				$GLOBALS['appshore_data']['api']['op'] = $GLOBALS['appshore_data']['server']['default_start_op'];
		}
		
		list( $GLOBALS['appshore_data']['api']['appname'], $GLOBALS['appshore_data']['api']['classname'], 
			$GLOBALS['appshore_data']['api']['methodname']) = explode('.', $GLOBALS['appshore_data']['api']['op']);
			
		if( strpos($GLOBALS['appshore_data']['api']['appname'], '_') !== false )
			list( $GLOBALS['appshore_data']['api']['appname'], $prefixclassname) = explode('_', $GLOBALS['appshore_data']['api']['appname']);
			
		if( isset($prefixclassname) )
			$GLOBALS['appshore_data']['api']['classname'] = $prefixclassname.'_'.$GLOBALS['appshore_data']['api']['classname'];
	}
}
