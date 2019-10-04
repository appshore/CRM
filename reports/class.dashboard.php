<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by MF MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */


class reports_dashboard {

  
    function start()
    {  
    } 

	function d52()
	{	// IN GLOBAL Database: add this report/function to available dashboard apps
		// INSERT INTO `dashboards_apps` VALUES ('20', 'd52', 'reports.dashboard', 'reports', 'reports.dashboard.d52', '', 'Creations and updates by application', 'W');


		$GLOBALS['appshore']->add_xsl('lib.form');
		$GLOBALS['appshore']->add_xsl('lib.base');
		$GLOBALS['appshore']->add_xsl('reports.dashboard');

		$args['report_id']='52';
		$args['col_uc']='nuc';
		$args['within_prd']='p';
		$args['period']='LY';
 		$args['dashboard']='yes';	

		$result=execMethod('reports.listing.quick', $args, true);
		$result['param_quick']=urlencode('report_id=52&col_uc=nuc&within_prd=p&period=LY&dashboard=yes');
		$result['action']['reports'] = 'd52';
		ob_flush();
		return $result;
	}
function d53()
	{	// IN GLOBAL Database: add this report/function to available dashboard apps
		// INSERT INTO `dashboards_apps` VALUES ('21', 'd53', 'reports.dashboard', 'reports', 'reports.dashboard.d53', '', 'Creations and updates by application', 'W');


		$GLOBALS['appshore']->add_xsl('lib.form');
		$GLOBALS['appshore']->add_xsl('lib.base');
		$GLOBALS['appshore']->add_xsl('reports.dashboard');

		$args['report_id']='53';
		$args['col_uc']='nuc';
		$args['within_prd']='p';
		$args['period']='LY';
 		$args['dashboard']='yes';	
		
		$result=execMethod('reports.listing.quick', $args, true);
		$result['param_quick']=urlencode('report_id=53&col_uc=nuc&within_prd=p&period=LY&dashboard=yes');
		$result['action']['reports'] = 'd53';
		$this->writeHtml($result['report']['graphs1']['fname'],
						$result['report']['graphs1']['imtab']['map']['iname']);
		ob_flush();
		
// 		print_r($result['report']['graphs1']['fname']);
		return $result['report'];
	}

function writeHtml($fname,$iname)
	{
	$filename=urldecode($fname).'.htm';
	$fcontent='<html><head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	
	<body><div id="overDiv" style="position: absolute; visibility: hidden; z-index: 1000;"></div>

	<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
	<tbody>
	<tr width="100%" valign="top">
		<td width="*%">
			<table cellpadding="1" cellspacing="1" width="100%">
			<tbody>
				<tr><td align="center" width="90%">
					<img class="image"  src="lib/graphs/imagedisplay.php&#63;fname='.$fname.'" />
					</td>
				</tr>
			</tbody>
			</table>
		</td>
	</tr>
	</tbody>
	</table>

	</body>
	</html>';
	$handle = fopen($filename, "w");
	fwrite($handle, $fcontent);
	fclose($handle); 
	}
}//end class
