<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2010 Brice Michel                                     *
***************************************************************************/
	
// class to automatically upgrade the customer DB
// called in startup.inc.php
class base_upgrade
{

	function start()
	{
		// retrieve all the upgrades not yet applied on this customer DB
#		$versions = getManyAssocArrays('SELECT version FROM '.GLOBAL_DB.
#			'.versions WHERE version > (select appshore_version from company) AND editions = "ALL" ORDER BY version ASC');		
		$appshore_version = getOneColOneRow('SELECT appshore_version FROM company');		

		$versions = getManyAssocArrays('SELECT version FROM '.GLOBAL_DB.
			'.versions WHERE version > "'.$appshore_version.'" AND editions = "ALL" ORDER BY version ASC');		
				
		// Run each available upgrade starting the older
		if( $versions != null )
		{
			foreach( $versions as $key => $val )
			{
				executeSQLScript( 'upgrade_'.$val['version'], $GLOBALS['appshore_data']['server']['db_name']);
				$last_version = $val['version'];
			}
			// At last we update the current version of the DB to avoid to redo the upgrade
			executeSQL('UPDATE company SET appshore_version = "'.$last_version.'"');
		}
	}
}
	
