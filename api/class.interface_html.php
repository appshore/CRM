<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class api_interface_html
{
	var $render;

	function __construct()
	{
		reg_var('op', 'any', 'any');
	}

	function bad_login($error)
	{
		messagebox( $error, ERROR);
	}

	function good_login()
	{
		// We apply the query string previously recorded see login() function
		if( $GLOBALS['appshore_data']['api']['nextop'] )
			header('Location: '.$GLOBALS['appshore']->session->baseurl.base64_decode($GLOBALS['appshore_data']['api']['nextop']));
	}

	function login()
	{
		// we clean up first
		$GLOBALS['appshore']->session->createSession();

		$GLOBALS['appshore_data']['layout'] = 'auth';
		
		// define next action
		$result['action']['auth'] = 'login';

		// if a query_string was passed without being auth we keep it to deliver it later
		if( strpos( $_SERVER["QUERY_STRING"], 'op=') !== false )
			$result['nextop'] = base64_encode($_SERVER["QUERY_STRING"]);
			
		return $result;
	}

	function logout()
	{
		// delete the session
		$GLOBALS['appshore']->session->deleteSession();
	
		// back to initial screen
		//$GLOBALS['appshore_data']['api']['op'] = $GLOBALS['appshore_data']['server']['default_anon_op'];
		header('Location: '.$GLOBALS['appshore_data']['server']['baseurl']);
	}

	function get_inputs()
	{
		return array_merge((Array)$_SESSION['appshore_session'], $_REQUEST);
	}

	function handle_result($result)
	{
		$this->buildXML();

		$xml_data = new DOMi('APPSHORE');

		/* Add the APP and API sections to the main XML doc APPSHORE */			
		$xml_data->AttachToXml( $result, 'APP');
		$xml_data->AttachToXml( $GLOBALS['xml_api'], 'APPSHORE');

		/* Constructing the XML doc */
		if( $GLOBALS['appshore_data']['server']['xml_render'] == true )
		{
			echo $xml_data->Render( false, DOMi::RENDER_XML); 
			return;
		}
						
		/* Start the XSLT class for it to be able to decide how to build the strings */
		$this->render = createObject('base_xslt');

		// retrieve the xsl files that constitutes the stylesheet
		$this->render->setStylesheet($GLOBALS['appshore']->xsl_files);

		/* Use the XSLT class to handle browser detection */
		/* and if needed, the rendering of the XML */
		$this->render->set_xml($xml_data->saveXML());
		
		echo $this->render->getOutput();
		return;
	}
	
	function buildXML()
	{
		$args = new safe_args();
		$args->set('sendoutput', true, 'bool');
		$args = $args->get(func_get_args());

		define('APPSHORE_FINISHED', true);
		
		// This variable is used for Export or Download
		if( isset($GLOBALS['appshore']->DownloadExport) &&  $GLOBALS['appshore']->DownloadExport == true )
			exit();

		/* Check to see if we should load the main xsl */
		$GLOBALS['appshore']->add_xsl('base.common');
		switch( $GLOBALS['appshore_data']['layout'] )
		{
			case 'auth':
				$GLOBALS['appshore']->add_xsl('base.header');
				$GLOBALS['appshore']->add_xsl('base.auth');
				break;
				
			case 'popup':
				$GLOBALS['appshore']->add_xsl('base.header');
				$GLOBALS['appshore']->add_xsl('base.popup');
				$GLOBALS['appshore']->add_xsl('base.panelets_popup');
				break;

			case 'print':
				$GLOBALS['appshore']->add_xsl('base.print');
				$GLOBALS['appshore']->add_xsl('base.panelets_popup');
				break;
				
#			case 'topbar':
			default:
				$GLOBALS['appshore']->add_xsl('base.header');
				$GLOBALS['appshore']->add_xsl('base.topbar');
				$GLOBALS['appshore']->add_xsl('base.panelets');
				break;
				
#			default:
#				$GLOBALS['appshore']->add_xsl('base.content');
#				break;		
		}
		
		$GLOBALS['appshore']->check_op();
		
		// Add Apps menus
		$GLOBALS['xml_api']->AttachToXml( $GLOBALS['appshore']->finish_appmenus(), 'appmenus');
			
		// Add Apps submenus
		$GLOBALS['xml_api']->AttachToXml( $GLOBALS['appshore']->submenus, 'submenus');
			
		// Add API menu
		$GLOBALS['xml_api']->AttachToXml( $GLOBALS['appshore']->apimenu(),'apimenu');
			
		// Add Apps submenus
		$GLOBALS['xml_api']->AttachToXml( $GLOBALS['appshore']->context, 'context');		
			
		// Add plugins
		if( $GLOBALS['appshore']->plugins )
			$GLOBALS['xml_api']->AttachToXml( $GLOBALS['appshore']->plugins, 'Plugins');		
		
		// Add the op data to the API XML node
		$op = array('opname'     => $GLOBALS['appshore_data']['api']['op'],
		            'appname'    => $GLOBALS['appshore_data']['api']['appname'],
		            'classname'  => $GLOBALS['appshore_data']['api']['classname'],
		            'methodname' => $GLOBALS['appshore_data']['api']['methodname']
		            );
		            
		$GLOBALS['xml_api']->AttachToXml($op, 'op');	
		
		// Add the basepath and baseurl to the xml contents
		$GLOBALS['xml_api']->AttachToXml($GLOBALS['appshore']->session->basepath, 'basepath');
		$GLOBALS['xml_api']->AttachToXml($GLOBALS['appshore']->session->baseurl, 'baseurl');
		$GLOBALS['xml_api']->AttachToXml($GLOBALS['appshore']->session->sid, 'sid');
		
		if( $GLOBALS['appshore']->session->is_anonymous() == false)
		{
			$_COOKIE['left_panel'] = ( isset($_COOKIE['left_panel']) == false ) ? 'block' : $_COOKIE['left_panel'];
			$_COOKIE['tags'] = ( isset($_COOKIE['tags']) == false ) ? 'block' : $_COOKIE['tags'];
			$_COOKIE['history'] = ( isset($_COOKIE['history']) == false ) ? 'block' : $_COOKIE['history'];
		}
		$GLOBALS['xml_api']->AttachToXml( $_COOKIE,'cookie');

		// Add the users account, apps and preferences data 
		$GLOBALS['xml_api']->AttachToXml( $GLOBALS['appshore_data']['apps'], 'apps');
		$GLOBALS['xml_api']->AttachToXml( $GLOBALS['appshore_data']['current_user'], 'current_user');						
		
		// server global params		
		$server = $GLOBALS['appshore_data']['server'];
		unset( $server['globaldb'], $server['db_host'], $server['db_name'], $server['db_user'], $server['db_pass'], $server['db_type']);
		foreach( $server as $key => $value)
		{
			if( $value === true )
				$server[$key] = 'true';
			else if( $value === false )
				$server[$key] = 'false';
		}
		$GLOBALS['xml_api']->AttachToXml( $server, 'server');		

		if( $GLOBALS['appshore']->session->is_anonymous() == false)
		{
			$GLOBALS['xml_api']->AttachToXml( $GLOBALS['appshore_data']['my_company'], 'my_company');

			if( in_array( $GLOBALS['appshore_data']['layout'], array('popup','print')) == false )
			{
				$GLOBALS['xml_api']->AttachToXml(execMethod('base.panelets.runPanelets'), 'panelets');	
				$GLOBALS['xml_api']->AttachToXml($GLOBALS['appshore']->history->getHistory(), 'histories');	
			}
			else
				$GLOBALS['xml_api']->AttachToXml(array('popup' => 'true'), 'popup');
				
			// to allow notification when the edition allows it
			if ( checkEdition() && $GLOBALS['appshore_data']['my_company']['company_status'] != 'CLO')
				$GLOBALS['xml_api']->AttachToXml('true', 'notifications');					

		}
		else
		{
			// we need alias for demo display info
			$GLOBALS['xml_api']->AttachToXml( array('company_alias' => $GLOBALS['appshore_data']['server']['subdomain']), 'my_company');
			
			// we need this for login screen
			$agent_id = getOneColOneRow( 'select agent_id from '.BACKOFFICE_DB.'.customers where company_alias = "'.$GLOBALS['appshore_data']['server']['subdomain'].'"');
			
			if( $agent_id == 'jpn' )
				$GLOBALS['xml_api']->AttachToXml( getManyAssocArrays('SELECT language_id, language_name FROM global_languages order by language_id'), 'languages');
			else
				$GLOBALS['xml_api']->AttachToXml( getManyAssocArrays('SELECT language_id, language_name FROM global_languages WHERE language_id <> "ja" order by language_id'), 'languages');
		}	

		// Add branding information
		$GLOBALS['xml_api']->AttachToXml( CUSTOMER_NAME, 'customer_name');
		$GLOBALS['xml_api']->AttachToXml( BRAND, 'brand');
		$GLOBALS['xml_api']->AttachToXml( LOGO, 'logo');	
		$GLOBALS['xml_api']->AttachToXml( FAVICON, 'favicon');	
		$GLOBALS['xml_api']->AttachToXml( BRAND_WEBSITE, 'brand_website');
		$GLOBALS['xml_api']->AttachToXml( SUPPORT_WEBSITE,'support_website');
		$GLOBALS['xml_api']->AttachToXml( SUPPORT_EMAIL,'support_email');
		
		//Google tracker
		if( defined('GOOGLE_TRACKER') )
		{
			$GLOBALS['xml_api']->AttachToXml( GOOGLE_TRACKER,'google_tracker');
			$GLOBALS['xml_api']->AttachToXml( GOOGLE_DOMAIN,'google_domain');
		}
	
		// Add translated messages to display
		if( $GLOBALS['appshore_data']['messages'] )
		{
			foreach ( $GLOBALS['appshore_data']['messages'] as $key => $val )
				$GLOBALS['appshore_data']['messages'][$key]['text'] = lang($val['text']);
			$GLOBALS['xml_api']->AttachToXml( $GLOBALS['appshore_data']['messages'], 'messages');
		}
		
		if( isset($_SESSION['temp']) )	
			$GLOBALS['xml_api']->AttachToXml( $_SESSION['temp'], 'temp');

		if( $GLOBALS['appshore_data']['server']['powered_by'] == true )
			$GLOBALS['xml_api']->AttachToXml( BRAND, 'powered_by');

		if( ( $GLOBALS['appshore_interface'] == 'html' ) && ($GLOBALS['appshore_data']['server']['performance'] == true) )
		{
        	list( $usec1, $sec1) = explode ( ' ', $GLOBALS['startBenchmark'] );
        	list( $usec2, $sec2) = explode ( ' ', microtime());
			$GLOBALS['xml_api']->AttachToXml( sprintf("%0.5f", ($sec2-$sec1)+($usec2-$usec1)) , 'performance');
		}
	}
	
	
	function ping()
	{
		$company = getOneAssocArray( 'select company_alias from company limit 1');
		echo PRIVATE_LABEL.$company['company_alias'];
		exit();
	}		
	
}
