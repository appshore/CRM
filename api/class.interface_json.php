<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

class api_interface_json
{
	var $render;

	function __construct()
	{
		reg_var('op', 'any', 'any');
	}

	function bad_login($error=null)
	{
		// define next action
		$result['status'] = ERROR;
		switch( $error )
		{
			case ERROR_AUTH_INVALID:
				$result['error']['code'] = 'ERROR_AUTH_INVALID';
				break;		
			case ERROR_AUTH_IPACL:
				$result['error']['code'] = 'ERROR_AUTH_IPACL';
				break;		
		}
		$result['error']['message'] = $error;

		$this->handle_result($result);
		exit();
	}

	function good_login()
	{
		// define next action
		$result['status'] = OK;
		$result['sid'] = $GLOBALS['appshore']->session->sid;

		$this->handle_result($result);
	}

	function login()
	{
		// we clean up the session context
		$GLOBALS['appshore']->session->createSession();
		
		// and send a status saying not yet auth
		$result['status'] = ERROR;
		$result['error']['code'] = 'ERROR_NO_AUTH';
		$result['error']['message'] = ERROR_NO_AUTH;
		
		$this->handle_result($result);
	}

	function logout()
	{
		$GLOBALS['appshore']->session->deleteSession();

		$result['status'] = OK;

		$this->handle_result($result);
	}

	function get_inputs()
	{
		return array_merge((Array)$_SESSION['appshore_session'], $_REQUEST);
	}

	function handle_result($result)
	{
		if( $result )
			echo json_encode(array('api'=>$result));
	}	
	

	function ping()
	{
		$company = getOneAssocArray( 'select company_alias from company limit 1');
		echo json_encode(array('ping'=>PRIVATE_LABEL.$company['company_alias']));
	}	

}
