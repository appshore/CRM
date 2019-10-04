<?php
 /***************************************************************************
  * Appshore                                                                 *
   * http://www.appshore.com                                                  *
    * This file written by Brice Michel  bmichel@appshore.com                  *
	 * Copyright (C) 2004-2010 Brice Michel                                     *
	  ***************************************************************************/


	  class documents_backup
	  {

	  	var $backupDate;
			
				function __construct()
					{
							$this->backupDate = gmdate('Ymd');
								
									}

									 	// Open the Customer Database
											function setDatabase()
												{
														include_once(APPSHORE_INCLUDES.SEP.'adodb'.SEP.'adodb-exceptions.inc.php'); 
																include_once(APPSHORE_INCLUDES.SEP.'adodb'.SEP.'adodb.inc.php');
																		
																				// connect to specific database
																						$GLOBALS['appshore']->db = ADONewConnection($GLOBALS['appshore_data']['server']['db_type']);
																								if ( !$GLOBALS['appshore']->db->Connect($GLOBALS['appshore_data']['server']['db_host'],$GLOBALS['appshore_data']['server']['db_user'],$GLOBALS['appshore_data']['server']['db_pass'],$GLOBALS['appshore_data']['server']['db_name']) )
																										{
																													// can not connect with the customer db so we go to the generic one
																																// and we'll ask for more info
																																			echo 'Can\'t access database.<br>';
																																						echo 'Please contact your System Administrator';
																																									exit;		
																																											}
																																													
																																															// set the ADODB fetch mode
																																																	$GLOBALS['appshore']->db->SetFetchMode(ADODB_FETCH_ASSOC);
																																																			$ADODB_COUNTRECS = true;

																																																					executeSQL( 'SET CHARACTER SET "utf8"');		
																																																						}


																																																							// make sure that the have big enough and clean data space
																																																							    function prepareDataSpace( $args=null)
																																																								    {
																																																											if( is_dir(APPSHORE_DOCUMENTS_BACKUP.SEP.$this->backupDate) == false )
																																																													{
																																																													        	createFoldersTree( APPSHORE_DOCUMENTS_BACKUP.SEP.$this->backupDate);
																																																																        	echo 'Documents backup space created.'.RET;
																																																																			        }
																																																																					        else
																																																																							        {
																																																																									        	echo 'Documents backup space already created. Delete it first for a clean backup'.RET;
																																																																												        }
																																																																														    } 

																																																																															    function processDocuments( $folder_id = 0, $path='')
																																																																																    {
																																																																																	    // folders list from home
																																																																																		    $docs = getManyAssocArrays( 'SELECT document_id, document_name, is_folder, created, updated FROM documents where folder_id = "'.$folder_id.'" order by is_folder asc');

																																																																																			    if( $docs == null )
																																																																																				        return;

																																																																																						    foreach( $docs as $key => $doc)
																																																																																							        {
																																																																																									            if( $doc['is_folder'] == 'Y')
																																																																																												            {
																																																																																															                // remove non alphanumeric
																																																																																																			                $doc['document_name'] = preg_replace('/[^\da-z]/i', ' ', $doc['document_name']);
																																																																																																							                // remove excess white space
																																																																																																											                $doc['document_name'] = preg_replace('/\s\s+/', ' ', $doc['document_name']);
																																																																																																															                $doc['document_name'] = trim($doc['document_name']);
																																																																																																																			                //set the path
																																																																																																																							                $dst = APPSHORE_DOCUMENTS_BACKUP.SEP.$this->backupDate.SEP.$path.SEP.$doc['document_name'];
																																																																																																																											                //create folder
																																																																																																																															                createFoldersTree( $dst);
																																																																																																																																			                touch( $dst, strtotime($doc['created']), strtotime($doc['updated']));
																																																																																																																																							                $this->nbrdirs++;
																																																																																																																																											                // create sub folders if needed
																																																																																																																																															                $this->processDocuments( $doc['document_id'], $path.SEP.$doc['document_name']);
																																																																																																																																																			            }
																																																																																																																																																						            else
																																																																																																																																																									            {
																																																																																																																																																												                // remove excess white space
																																																																																																																																																																                $doc['document_name'] = preg_replace('/\s\s+/', ' ', $doc['document_name']);
																																																																																																																																																																				                $doc['document_name'] = trim($doc['document_name']);
																																																																																																																																																																								                // set the path
																																																																																																																																																																												                $dst = APPSHORE_DOCUMENTS_BACKUP.SEP.$this->backupDate.SEP.$path.SEP.$doc['document_name'];
																																																																																																																																																																																                // copy the file from AppShore to backup
																																																																																																																																																																																				                copy( APPSHORE_DOCUMENTS.SEP.$doc['document_id'], $dst);
																																																																																																																																																																																								                touch( $dst, strtotime($doc['created']), strtotime($doc['updated']));
																																																																																																																																																																																												                $this->nbrdocs++;
																																																																																																																																																																																																            }
																																																																																																																																																																																																			                
																																																																																																																																																																																																							        }
																																																																																																																																																																																																									    }

																																																																																																																																																																																																										}

																																																																																																																																																																																																										chdir('..');           
																																																																																																																																																																																																										define('SEP', '/');
																																																																																																																																																																																																										define('RET', '<br/>');

																																																																																																																																																																																																										$GLOBALS['distrib_dir'] = getcwd();
																																																																																																																																																																																																										$GLOBALS['config_dir'] = $GLOBALS['distrib_dir'].SEP.'config';

																																																																																																																																																																																																										$subdomain = '';
																																																																																																																																																																																																										list( $part1, $part2, $part3, $part4) = explode( '.', $_SERVER['SERVER_NAME'] );

																																																																																																																																																																																																										if( isset($part4) && $part1 == 'm')
																																																																																																																																																																																																										{
																																																																																																																																																																																																											$subdomain = $part2;
																																																																																																																																																																																																												$domain = $part3;
																																																																																																																																																																																																													$tld = $part4;
																																																																																																																																																																																																													}
																																																																																																																																																																																																													else
																																																																																																																																																																																																													{
																																																																																																																																																																																																														$subdomain = $part1;
																																																																																																																																																																																																															$domain = $part2;
																																																																																																																																																																																																																$tld = $part3;
																																																																																																																																																																																																																}

																																																																																																																																																																																																																// return server context
																																																																																																																																																																																																																if ( $_GET['alias'] != $subdomain )
																																																																																																																																																																																																																{
																																																																																																																																																																																																																	echo '?'.RET;	
																																																																																																																																																																																																																		exit();
																																																																																																																																																																																																																		}

																																																																																																																																																																																																																		if( !isset($tld) )
																																																																																																																																																																																																																			header('Location: http://www.'.$subdomain.'.'.$domain);

																																																																																																																																																																																																																			if(isset($subdomain) && isset($domain) && file_exists($GLOBALS['config_dir'].SEP.$subdomain.'.'.$domain.'.'.$tld.'.cfg.php') )
																																																																																																																																																																																																																			{
																																																																																																																																																																																																																				$GLOBALS['config_file'] = $GLOBALS['config_dir'].SEP.$subdomain.'.'.$domain.'.'.$tld.'.cfg.php';	
																																																																																																																																																																																																																				}
																																																																																																																																																																																																																				else if(isset($subdomain) && isset($domain) && file_exists($GLOBALS['config_dir'].SEP.$domain.'.'.$tld.'.cfg.php') )
																																																																																																																																																																																																																				{
																																																																																																																																																																																																																					$GLOBALS['config_file'] = $GLOBALS['config_dir'].SEP.$domain.'.'.$tld.'.cfg.php';	
																																																																																																																																																																																																																					}
																																																																																																																																																																																																																					else
																																																																																																																																																																																																																					{
																																																																																																																																																																																																																						echo '<br/><br/>Invalid domain name<br/><br/>';
																																																																																																																																																																																																																							echo 'Please contact your administrator';
																																																																																																																																																																																																																								exit();
																																																																																																																																																																																																																								}

																																																																																																																																																																																																																								include_once($GLOBALS['config_file']);	
																																																																																																																																																																																																																								include_once(APPSHORE_API.SEP.'core_functions.inc.php');
																																																																																																																																																																																																																								include_once(APPSHORE_LIB.SEP.'lib.inc.php');
																																																																																																																																																																																																																								include_once(APPSHORE_LIB.SEP.'lib.files.php');
																																																																																																																																																																																																																								include_once(APPSHORE_LIB.SEP.'lib.folders.php');

																																																																																																																																																																																																																								define('APPSHORE_DOCUMENTS_BACKUP', APPSHORE_STORAGE.SEP.'documents_backup');


																																																																																																																																																																																																																								// set database access
																																																																																																																																																																																																																								$nbrdocs = $nbrdirs = 0;
																																																																																																																																																																																																																								$backup = new documents_backup;
																																																																																																																																																																																																																								$backup->setDatabase();
																																																																																																																																																																																																																								$backup->prepareDataSpace();
																																																																																																																																																																																																																								$backup->processDocuments();
																																																																																																																																																																																																																								echo 'Folders = '.$nbrdirs.RET;
																																																																																																																																																																																																																								echo 'Documents = '.$nbrdocs.RET;

