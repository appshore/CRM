<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2018 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');
require_once ( APPSHORE_LIB.SEP.'lib.folders.php');

class documents_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'documents';
    	$this->appRecordId		= 'document_id';
    	$this->appRecordName	= 'document_name';
    	$this->appOrderBy		= 'is_folder';
    	$this->appAscDesc		= 'desc';
    	$this->appName 			= 'documents';
    	$this->appNameSingular	= 'document';
    	$this->appLabel 		= 'Documents';
    	$this->appLabelSingular = 'Document';
    	$this->appXSL 			= 'documents.base';
    	$this->appRole 			= 'documents';

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

    	if( !isset($_SESSION[$this->appName]) )
    	{
	        parent::__construct();

	        // this place needs to be clean when it's called by others apps
			require_once ( APPSHORE_LIB.SEP.'lib.files.php');
	        checkDirectory( APPSHORE_DOCUMENTS);
		}
    }

    function menus()
    {
		$GLOBALS['appshore']->add_appmenu($this->appName, 'Search '.strtolower($this->appLabel), $this->appName.'.base.search');
		if ( $GLOBALS['appshore']->rbac->check($this->appName, RBAC_USER_WRITE ) )
		{
			$GLOBALS['appshore']->add_appmenu($this->appName, 'Upload document', $this->appName.'.base.edit&is_folder=N');
			$GLOBALS['appshore']->add_appmenu($this->appName, 'New folder', $this->appName.'.folders_base.edit&'.$this->appRecordId.'='.generateID());
		}
    }

    function reset()
    {
		// First time that we start this app during the current session so we must init search criterias
		if (!isset($_SESSION[$this->appName]))
		{
			// Save context in cookie SESSION_SID
			$this->defaultSessionApp();
			$_SESSION[$this->appName][$this->appRecordName] = '';
			$_SESSION[$this->appName]['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
 			$_SESSION[$this->appName][$this->appRecordId] = '0';
			$_SESSION[$this->appName]['folder_id'] = '0';
			$_SESSION[$this->appName]['first'] = 0;
			$_SESSION[$this->appName]['currentVal'] = 0;
			$_SESSION[$this->appName]['countMax'] = 0;
		}
    }


    function start()
    {
    	return $this->search();
    }

	// search directories and documents
    function search( $args = null)
    {
     	switch( $args['key'] )
		{
			case 'Save':
				if( isset($args['bulk_folder_id']) && $args['bulk_folder_id'] != '0')
				{
					$selected = explode( ',', $args['selected']);
					foreach( $selected as $selectkey => $selectval)
					{
						$children = getChildren( $selectval );
						foreach( $children as $key => $val)
						{
							if( $args['bulk_folder_id'] == $selectval || $args['bulk_folder_id'] == $val['document_id'])
							{
								unset($selected[$selectkey]);
								$suppressed = true;
							}
						}
					}
					if( $suppressed == true )
						$args['selected'] = implode(',',$selected);
				}
				break;
		}

		if( isset($args['folder_id']) ) // filter on a folder
			$_SESSION[$this->appName][$this->appRecordId] = $args[$this->appRecordId] = $_SESSION[$this->appName]['folder_id'] = $args['folder_id'];
		else
		{
			if( ($_SESSION[$this->appName]['appOrderBy'] == $args['orderby'] || !isset($args['orderby']))
				&& ($_SESSION[$this->appName]['appAscDesc'] == $args['ascdesc'] || !isset($args['ascdesc'])) )
			{
				if( isset($_SESSION[$this->appName]['folder_id']) )
					$args['folder_id'] = $_SESSION[$this->appName]['folder_id'];

				if( isset($args[$this->appRecordId]) ) // drill in a folder
					$_SESSION[$this->appName]['folder_id'] = $args['folder_id'] = $_SESSION[$this->appName][$this->appRecordId] = $args[$this->appRecordId];
			}
				if( isset($_SESSION[$this->appName][$this->appRecordId]) )
					$args[$this->appRecordId] = $_SESSION[$this->appName][$this->appRecordId];
		}

    	$result = parent::search( $args);

    	if( $result[$this->appName] && $args['key'] != 'Clear')
    	{
			foreach( $result[$this->appName] as $key => $val)
			{
				if( $val['is_folder'] == 'Y' )
					$result[$this->appName][$key]['filesize'] = getfilesize(folderSize($val[$this->appRecordId]));

				if( !$val['related_folder_id'] )
					$result[$this->appName][$key]['related_folder_id'] = lang('Home');
			}
		}

		$result['filesize'] = getfilesize(folderSize($_SESSION[$this->appName][$this->appRecordId]));

		$result['currentFolder'] = getReverseFolders( $_SESSION[$this->appName][$this->appRecordId]);

		// folders list from home
		$result['folders'] = getFolders('0');

		// we remove this xsl lib to use the specific one
		$GLOBALS['appshore']->remove_xsl('lib.custom');

    	return $result;
	}

    // we build the SQL request based on search, result fields and filter criterias
	function buildSQL( $args=null, $search_fields=null, $result_fields=null, $session_popup = '')
	{

		$args['folder_id'] = $_SESSION[$this->appName]['folder_id'];
		$search_fields[] = array('field_name' => 'folder_id','field_type' => 'RE');

    	$sql =  parent::buildSQL( $args, $search_fields, $result_fields);
    	return $sql;
	}


	// view one document
    function view( $args = null )
    {
		// needed for duplicate and test if folder
		$document = getOneAssocArray( 'select * from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');

    	if( $document['is_folder'] == 'Y')
			return execMethod( 'documents.folders_base.view', $args);


		switch($args['key'])
		{
			case 'Duplicate':
				// retrieve all infos from source record to populate target record
				//$document = getOneAssocArray( 'select * from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');

				$document['key'] = 'Save';
				unset( $document[$this->appRecordId] );
				$document['document_name'] .= ' ('.lang('Copy').')';
				$result = parent::edit( $document);

				if( $result[$this->appNameSingular][$this->appRecordId] )
					copy( APPSHORE_DOCUMENTS.SEP.$args[$this->appRecordId], APPSHORE_DOCUMENTS.SEP.$result[$this->appNameSingular][$this->appRecordId]);
				else
				{
					unset($args['key']);
					$result = $this->view($args);
				}
				//chmod( APPSHORE_DOCUMENTS.SEP.$result[$this->appName][$this->appRecordId], 0666);
				//$args[$this->appRecordId] = $result[$this->appName][$this->appRecordId];
				break;

			default:
				if( $args['document_id'] == '0' )
					return $this->search($args);
				$result = parent::view( $args);
				if( $result['action'][$this->appName] != 'view' )
					return $result;
				break;
		}

		return $result;
    }


    function deleteRecord( $document_id, $verbose=false)
    {
		$document = getOneAssocArray( 'select is_folder,document_id from documents where document_id = "'.$document_id.'"');

		if( $document['is_folder'] == 'Y' )
		{
			unset( $GLOBALS['foldersTree']);
			$children = getChildren( $document_id);
		}
		else
		{
			$children[] = array(
				'document_id' 	=> $document_id,
				'is_folder' 	=> 'N'
				);
		}

		$truefalse = false;
   		foreach( $children as $key => $value )
   		{
			$truefalse |= parent::deleteRecord( $value[$this->appRecordId], $verbose);

			if( $value['is_folder'] == 'N' )
           		if( is_file( APPSHORE_DOCUMENTS.SEP.$value[$this->appRecordId]) == true )
					unlink( APPSHORE_DOCUMENTS.SEP.$value[$this->appRecordId]);
		}


		return $truefalse;
    }



	// edit or create one document
    function edit( $args = null )
    {
		// needed test if folder
		$document = getOneAssocArray( 'select is_folder from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');

    	if( $document['is_folder'] == 'Y')
			return execMethod( 'documents.folders_base.edit', $args);

 		switch($args['key'])
		{
			case 'Save':		// overload of default Save
				if ($args[$this->appRecordId]) 			// UPDATE an existing record
				{
               		if ( $this->checkFields($args, $edit_fields) == false )
               		{
	                    $result[$this->appNameSingular] = $args;
	                }
					else if( updateRow( $this->appTable, $this->appRecordId, $args) == null )
					{
						$result[$this->appNameSingular] = $args;
					}
					else
                    	messagebox( MSG_UPDATE, NOTICE);
				}
				else 								// New record so we do an INSERT
				{
					$args[$this->appRecordId] = generateId();

					if ( $_FILES['userfile'] == null || $_FILES['userfile'][ERROR] == '1')
					{
	                    messagebox( ERROR_FILE_TOO_BIG, ERROR);
						unset($args);
						$args['is_folder'] = 'N';
						return $this->edit($args);
	                }
					else if (is_uploaded_file( $_FILES['userfile']['tmp_name']))
					{
		                if( strlen($args['document_name']) == 0 )
		                	$args['document_name'] = $_FILES['userfile']['name'];

						$args['filesize'] = filesize( $_FILES['userfile']['tmp_name']);
						$args['filetype'] = $_FILES['userfile']['type'];

						move_uploaded_file( $_FILES['userfile']['tmp_name'], APPSHORE_DOCUMENTS.SEP.$args[$this->appRecordId]);
						//chmod(APPSHORE_DOCUMENTS.SEP.$args[$this->appRecordId], 0666);

						if ( is_file( APPSHORE_DOCUMENTS.SEP.$args[$this->appRecordId]) == false )
						{
							messagebox( ERROR_FILE_NOT_FOUND, ERROR);
							$this->deleteRecord( $args[$this->appRecordId]);
							unset($args);
							$args['is_folder'] = 'N';
							return $this->edit($args);
						}
					}

					$args = (array)$this->newEntry($args);
               		if ( $this->checkFields($args, $edit_fields) == false )
	                    $result[$this->appNameSingular] = $args;
					else if ( ($args[$this->appRecordId] = insertRow( $this->appTable, $this->appRecordId, $args)) == NULL )
					{
						messagebox( ERROR_FILE_EXISTS, ERROR);
						$this->deleteRecord( $args[$this->appRecordId]);
						unset($args);
						$args['is_folder'] = 'N';
						return $this->edit($args);
					}
					else
                    	messagebox( MSG_INSERT, NOTICE);
				}
				unset($args['key']);
				// NO Break for 'Save' case
			default:

				$result = parent::edit( $args);

				$result['folders'] = getFolders( $args[$this->appRecordId] );
				break;
		}

        return $result;
    }


     // called by others when embedded
    function linked( $args = null)
    {
    	$result = parent::linked( $args);

    	if( $result['results'] )
    	{
			foreach( $result['results'] as $key => $val)
			{
				if( !$val['related_folder_id'] )
					$result['results'][$key]['related_folder_id'] = lang('Home');
			}
		}

		return $result;
    }


     // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
	    $entry['is_folder'] = 'N';
	    $entry['filetype'] = '';
        $entry['folder_id'] = $_SESSION[$this->appName]['folder_id'];
        $entry['filesize'] = getfilesize(0);

        return parent::newEntry( $args, $entry);
    }

}
