<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2010 Brice Michel                                     *
***************************************************************************/
	
// class to migrate existing a v1 instance to v2

class base_migration
{
	// db name
	var $source_db;
	var $target_db;
	
	function start()
	{
		$args = new safe_args();
		$args->set('source_db',		$GLOBALS['appshore_data']['server']['db_name'],'any');
		$args->set('target_db',		$GLOBALS['appshore_data']['server']['db_name'],'any');	
		$args = $args->get(func_get_args());

		$success = true;

		// we set the dbs names
		$this->source_db = $args['source_db'];
		$this->target_db = $args['target_db'];	
		
		// we start by testing that source exists and is a V1 instance
		if( describeColumns( $this->source_db.'.company') == null ||
			describeColumns( $this->source_db.'.db_applications') != null ) //db_application is a V2 table 
			return false;
		
		if( $this->source_db == $this->target_db ) // we do self migration
		{
			// the source Instance is backup
			$this->copyInstance( $this->source_db, $this->source_db.'_backup', 'v1');
			
			// the source Instance is renamed
			$this->renameInstance( $this->source_db, $this->source_db.'_tmp', 'v1');
			
			// we create the v2 database by using the default database sql template.
			$this->createInstance( $this->target_db);

			// we create the v2 database by using the default database sql template.
			$this->migrateInstance( $this->source_db, $this->target_db);
			
			$selfMigration = true;
		}
		else // we do migration from one base to another
		{
			// we start by testing that target if exists is a V2 instance
			if( describeColumns( $this->target_db.'.company') != null  && 
				describeColumns( $this->target_db.'.db_applications') == null ) //db_application is a V2 table 
				return false;

			// the source Instance is backup
			$this->copyInstance( $this->source_db, $this->source_db.'_backup', 'v1');

			// the target Instance is backuped if exists
			if( describeColumns( $this->target_db.'.company') )
				$this->copyInstance( $this->target_db, $this->target_db.'_backup', 'generic');
			else
				// we create the v2 database by using the default database sql template.
				$this->execSQLFile( 'appshore_common.sql');
		
			$selfMigration = false;
		}
		

		// we delete finally the temporary and the backup instances
		if( $success == true )
		{
			if ( $selfMigration == true )
			{
				$this->deleteInstance( $this->source_db.'_tmp', 'v1');
				$this->deleteInstance( $this->source_db.'_backup', 'v1');
			}
			else
			{
				$this->deleteInstance( $this->source_db.'_backup', 'v1');
				$this->deleteInstance( $this->target_db.'_backup', 'generic');
			}
		}
		
		return;
	}
	
	// Run each SQL file
	function execSQLFile( $filename)
	{
		$fp = fopen( APPSHORE_HTTPD.SEP.'sql'.SEP.$filename, 'r'); 
			
		while (!feof ($fp))
		{
			$sql .= trim(fgets( $fp, 4096));
			
			if( $sql != null && $sql[strlen($sql)-1] == ';')
			{		
				// run every single SQL order find in this file
				$db = $GLOBALS['appshore']->db->execute( $sql); 
				unset($sql);            		
			}
		}	
					
		fclose($fp);
	}
	
	
	// duplicate an instance which means db and files
	function createInstance( $target, $path)
	{
		// create the target db
		exec( 'mysqladmin --user='.$GLOBALS['appshore_data']['server']['db_user'].' --password='.$GLOBALS['appshore_data']['server']['db_password'].
			' create '.$target) ;
			
		// create the initial data set
		exec( ' mysql --user='.$GLOBALS['appshore_data']['server']['db_user'].' --password='.$GLOBALS['appshore_data']['server']['db_password'].
			' '.$target.' < '.$this->setHttpdPath($path).'/sql/appshore_common.sql') ;
	}

	
	// duplicate an instance which means db and files
	function copyInstance( $source = 'MUSTEXIST', $target, $path)
	{
		// create the target db
		exec( 'mysqladmin --user='.$GLOBALS['appshore_data']['server']['db_user'].' --password='.$GLOBALS['appshore_data']['server']['db_password'].
			' create '.$target) ;
			
		// dump the source db in the target db
		exec( 'mysqldump --user='.$GLOBALS['appshore_data']['server']['db_user'].' --password='.$GLOBALS['appshore_data']['server']['db_password'].
			' --opt '.$source.' | '.
			' mysql --user='.$GLOBALS['appshore_data']['server']['db_user'].' --password='.$GLOBALS['appshore_data']['server']['db_password'].
			' '.$target) ;
						
		if( is_dir($this->setDataPath($path).SEP.$source) == true ) 
			exec( 'cp -frp '.$this->setDataPath($path).SEP.$source.' '.$this->setDataPath($path).SEP.$target);
	}
	
	// rename an instance
	function renameInstance( $source = 'MUSTEXIST', $target, $path)
	{
		$db = $GLOBALS['appshore']->db->execute('RENAME DATABASE '.$source.' TO '.$target);
					
		if( is_dir($this->setDataPath($path).SEP.$source) == true ) 
			exec( 'mv -frp '.$this->setDataPath($path).SEP.$source.' '.$this->setDataPath($path).SEP.$target);
	}
	
	// delete an Instance
	function deleteInstance( $target = 'MUSTEXIST', $path)
	{
		$db = $GLOBALS['appshore']->db->execute('DROP DATABASE '.$target);
			
		if( is_dir($this->setDataPath($path).SEP.$target) == true ) 
			exec( 'rm -fr '.$this->setDataPath($path).SEP.$target);
	}


	// set the path of the exec files
	function setHttpdPath( $path)
	{
		return APPSHORE_ENTRY_PATH.SEP.$path.SEP.'httpd';
	}


	// set the path of the datas
	function setDataPath( $path)
	{
		return APPSHORE_ENTRY_PATH.SEP.$path.SEP.'datas';
	}
	
	function table_accounts()
	{
		$table_source = $this->source_db.'.'.'accounts';
		$table_target = $this->target_db.'.'.'accounts';
		$column_target = 'account_id';

		$db = $GLOBALS['appshore']->db->execute('SELECT * FROM '.$table_source);

		$result = array;
		
		while( !$db->EOF )
		{
			$data = $db->GetRowAssoc(false);
			
			$data['type_id'] = $data['status_id']; // new name

			if ( insertRow( $table_target, $column_target, $data) == NULL )
			{
				$result[$table_target]['error'][] = $data[$column_target];
			}
			
			$db->MoveNext();
			$result[$table_target]['processed']++;
		}  	
		
		return $result;
	}
	
	
	
}
	
