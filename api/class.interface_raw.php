<?php
/**************************************************************************\
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* Brice MICHEL <bmichel@appshore.com>                                      *
* Copyright (C) 2004 - 2009 Brice MICHEL                                   *
* ------------------------------------------------------------------------ *
* Portions from phpGroupWare                                               *
* http://www.phpgroupware.org                                              *
* Dan Kuykendall <dan@kuykendall.org>                					   *
* Copyright (C) 2003 Dan Kuykendall                                        *
* -------------------------------------------------------------------------*
* This library is free software; you can redistribute it and/or modify it  *
* under the terms of the GNU Lesser General Public License as published by *
* the Free Software Foundation; either version 2.1 of the License,         *
* or any later version.                                                    *
* This library is distributed in the hope that it will be useful, but      *
* WITHOUT ANY WARRANTY; without even the implied warranty of               *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
* See the GNU Lesser General Public License for more details.              *
* You should have received a copy of the GNU Lesser General Public License *
* along with this library; if not, write to the Free Software Foundation,  *
* Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA            *
\**************************************************************************/

class api_interface_raw
{
	var $render;

	function __construct()
	{
		reg_var('op', 'any', 'any');
	}

	function good_login()
	{
		/* Not needed in this RPC, but stub required */
	}

	function bad_login()
	{
		/* Not needed in this RPC, but stub required */
	}

	function login()
	{
		$GLOBALS['appshore']->session->createSession();
		
		$GLOBALS['appshore']->add_xsl('api.login');

		// we don't want a screen foot
		$GLOBALS['appshore']->addNode( 'no_window_header', 'no_window_header');
		$GLOBALS['appshore']->addNode( 'no_window_footer', 'no_window_footer');
		
		// define next action
		$result['action']['login'] = 'login';
		
		return $result;
	}

	function logout()
	{
		$GLOBALS['appshore']->session->deleteSession();
		$GLOBALS['appshore_data']['api']['op'] = $GLOBALS['appshore_data']['server']['default_anon_op'];
		header('Location: /');
	}


	function get_inputs()
	{
		return array_merge((Array)$_SESSION['appshore_session'], $_REQUEST);
	}

	/*!
	@function handle_result
	@abstract Takes the results of the operation, packs it up and then has appshore->finish handle the rest.
	@param $app_data
	*/
	function handle_result($result)
	{
		/* Add the APP and API sections to the main XML doc APPSHORE */			

		$xml_data = new DOMi('APPSHORE');

		$xml_data->AttachToXml( $result, 'APP');

		/* Constructing the XML doc */
		if( $GLOBALS['appshore_data']['server']['xml_render'] == true )
		{
			echo $xml_data->Render( false, DOMi::RENDER_XML); 
			return;
		}
			
		/* Start the XSLT class for it to be able to decide how to build the strings */
		$this->render = createObject('base_xslt');
		
		$this->render->setStylesheet($GLOBALS['appshore']->xsl_files);

		/* Use the XSLT class to handle browser detection */
		/* and if needed, the rendering of the XML */
		$this->render->set_xml($xml_data->saveXML());

		/* Have XSLT class output as it determins as best */
		echo $this->render->getOutput();
	}
	

	function ping()
	{
		$company = getOneAssocArray('select company_alias from company limit 1');
		echo PRIVATE_LABEL.$company['company_alias'];
		exit();
	}	

}
