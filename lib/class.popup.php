<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class lib_popup extends lib_base
{

	// search and list records
    function search()
    {
		$args = new safe_args();
		$args->set('key', 			NOTSET, 'any');
		$args->set('orderby', 		NOTSET, 'any');
		$args->set('ascdesc', 		NOTSET, 'any');
		$args->set('table_name', 	$_SESSION['popup_'.$this->appName]['table_name']?$_SESSION['popup_'.$this->appName]['table_name']:NOTSET, 'any');
		$args->set('record_id', 	$_SESSION['popup_'.$this->appName]['record_id']?$_SESSION['popup_'.$this->appName]['record_id']:NOTSET, 'any');
		$args->set('readonly', 		$_SESSION['popup_'.$this->appName]['readonly']?$_SESSION['popup_'.$this->appName]['readonly']:'R', 'any');
		$args->set('is_multiple', 	'false', 'any');
		$args->set('is_attachment', NOTSET, 'any');
		$args->set('related_name', 	NOTSET, 'any');

		// bulk operation
		$args->set('bulk_id', 		NOTSET, 'any');			
		$args->set('selected', 		NOTSET, 'any');
		
		// search fields
		if( $search_fields = $this->getFields($this->appName, $this->appTable, 'popup_search') )			
			foreach( $search_fields as $fieldkey => $fieldvalue)
			{
        		if( in_array( $fieldvalue['field_type'], array('RR')) && $fieldvalue['related_table'] && $fieldvalue['related_id'] && $fieldvalue['related_name'] )
					$args->set( 'related_'.$fieldvalue['field_name'], $_SESSION[$this->appName]['related_'.$fieldvalue['field_name']], 'any');	
				else
					$args->set( $fieldvalue['field_name'], $_SESSION['popup_'.$this->appName][$fieldvalue['field_name']], 'any');	
			}

		// retrieve all passed parameters
		$args = $args->get(func_get_args());	

		//save the passed arguments in session
		$_SESSION['popup_'.$this->appName] = array_merge( (array)$_SESSION['popup_'.$this->appName], (array)$args);

		// act according returned Key
 		switch($args['key'])
		{
			case 'Clear':
				foreach( $search_fields as $fieldkey => $fieldvalue)
				{
					unset($_SESSION['popup_'.$this->appName][$fieldvalue['field_name']]);	
					unset($args[$fieldvalue['field_name']]);
				}		
				$_SESSION['popup_'.$this->appName][$this->appRecordName] = '';
				break;
			case 'Link':
				$args['sessionpopup'] = 'popup_';			
				$this->bulk_link( $args);
				setPosition( $_SESSION['popup_'.$this->appName]['currentVal'], $_SESSION['popup_'.$this->appName]['countMax'], $_SESSION['popup_'.$this->appName]['first'], $args['key'], 10);
				break;		
			case 'Search':	
				unset($args[$this->appRecordId]);						
				// No Break		
			case 'Next':
			case 'Previous':
			case 'Last':
			case 'First':
			default:
				setPosition( $_SESSION['popup_'.$this->appName]['currentVal'], $_SESSION['popup_'.$this->appName]['countMax'], $_SESSION['popup_'.$this->appName]['first'], $args['key'], 10);
				break;											
		} 
	
		// retrieve fields to display results
		$result['popup_result_fields'] = $this->getFields($this->appName, $this->appTable, 'popup_result'); 

		// we retrieve the blocks that format the form
		$result['popup_result_blocks'] = getManyAssocArrays('select * from db_blocks where app_name = "'.$this->appName.'" and form_name = "popup_result" order by block_sequence');			

		// build the SQL request
		$sql = $this->buildSQL( $args, $search_fields, $result['popup_result_fields'], 'popup_');

		// fetch results and format them
		$result[$this->appName] = $this->getSearchResults( 'popup_'.$this->appName, 10, $sql, $result['popup_result_fields'], true);		
		
		// Save context in cookie SESSION_SID
		$this->defaultSessionApp('popup_'.$this->appName);
		$_SESSION['popup_'.$this->appName]['appOrderBy'] = $args['orderby'];
		$_SESSION['popup_'.$this->appName]['appAscDesc'] = $args['ascdesc'];
		
		$_SESSION['popup_'.$this->appName]['related_name'] = $args['related_name'];
		
		// Put context in XML to be processed by XSL
		$result['recordset'] = $_SESSION['popup_'.$this->appName];			

		// scope in popup is always 1 or max
		$result['scope'] = 1 ;

		// scan search form fields to handle some specifc cases (related, drop down)
		$result['popup_search_fields'] = $search_fields;
		if( $result['popup_search_fields'] )
			foreach( $result['popup_search_fields'] as $fieldkey => $fieldvalue)
			{
				switch( $fieldvalue['field_type'] )
				{
        			case 'DD':
						if( !$fieldvalue['related_table'] || !$fieldvalue['related_id'] || !$fieldvalue['related_name'] )
							break;
	       				if ( $fieldvalue['related_table'] == 'users' )
							$result['popup_search_fields'][$fieldkey]['field_options'] = getManyAssocArrays( 
								'select distinct '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
								$fieldvalue['related_table'].buildClauseWhere($this->appRole,'R').' '.$fieldvalue['related_filter']);
        				else
							$result['popup_search_fields'][$fieldkey]['field_options'] = getManyAssocArrays( 
								'select distinct '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
								$fieldvalue['related_table'].' '.$fieldvalue['related_filter']);
						$result['popup_search_fields'][$fieldkey]['field_current_value'] = $args[$fieldvalue['field_name']];						
						break;
					
       				case 'DF':
						$result['popup_search_fields'][$fieldkey]['field_current_value'] = stripslashes($args[$fieldvalue['field_name']]);
						require_once ( APPSHORE_LIB.SEP.'lib.folders.php');
						$result['popup_search_fields'][$fieldkey]['folders'] = getFolders('0');
						break;

					case 'RD' :			
					case 'RM' :											
						$result['popup_search_fields'][$fieldkey]['field_current_value'] = stripslashes($args[$fieldvalue['field_name']]);
						$result = $this->setNotificationOptions( $result, $fieldvalue['field_type']);
						list($remnbr,$period) = explode('.',$result['popup_search_fields'][$fieldkey]['field_current_value']);
						if( $remnbr != '' && $period != '')
						{
							$result['popup_search_fields'][$fieldkey]['field_current_value'] = $result['popup_search_fields'][$fieldkey]['field_current_value'];
							$result['popup_search_fields'][$fieldkey]['field_current_value_nbr'] = $remnbr;
							$result['popup_search_fields'][$fieldkey]['field_current_value_period'] = $period;
						}
						break;				
												
        			case 'RR':
						if( $fieldvalue['related_name'] )
							$result['popup_search_fields'][$fieldkey]['field_current_value'] = $args['related_'.$fieldvalue['field_name']];
						else
							$result['popup_search_fields'][$fieldkey]['field_current_value'] = stripslashes($args[$fieldvalue['field_name']]);												
						break;
						
					default:
						$result['search_fields'][$fieldkey]['field_current_value'] = stripslashes($args[$fieldvalue['field_name']]);						
						break;
 				}
			}

		$result['bulk']= array(
			array('bulk_id' => 'Selected', 'bulk_name'=>lang('Selected lines')),
			array('bulk_id' => 'Page', 'bulk_name'=>lang('Current page')),
			array('bulk_id' => 'All', 'bulk_name'=>lang('All results'))
			);
				
		// set the needed XSL files for presentation
        $GLOBALS['appshore']->add_xsl($this->appXSL);
        $GLOBALS['appshore']->add_xsl('lib.base'); 
        $GLOBALS['appshore']->add_xsl('lib.custom');         
        $GLOBALS['appshore']->add_xsl('lib.actions');         
        $GLOBALS['appshore']->add_xsl('lib.search');         
        $GLOBALS['appshore']->add_xsl('lib.grid');         
        $GLOBALS['appshore']->add_xsl('lib.gridfields');         

		// define next action		
		$result['action'][$this->appName] = 'popup_search';
		// this is a popup so we precise this to the XSL because it can be generic
		$GLOBALS['appshore_data']['layout'] = 'popup';

		// we return the whole created array
        return $result;
    } 


   	// view one record
    function view()
    {
		$args = new safe_args();
		$args->set($this->appRecordId, 	NOTSET,'any');
		$args->set('key',				NOTSET,'any');
		$args = $args->get(func_get_args());

        $GLOBALS['appshore']->add_xsl($this->appXSL);
        $GLOBALS['appshore']->add_xsl('lib.base');         
        $GLOBALS['appshore']->add_xsl('lib.custom');         
        $GLOBALS['appshore']->add_xsl('lib.actions');         
        $GLOBALS['appshore']->add_xsl('lib.view');         
        			    	
		$result[$this->appNameSingular] = getOneAssocArray( 'select * from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');	        	

		$popup_view = ($args['key']=='Print')?'view':'popup_view';
		
		// view form
		if( $result['popup_view_fields'] = $this->getFields($this->appName, $this->appTable, $popup_view) )
		{
			foreach( $result['popup_view_fields'] as $fieldkey => $fieldvalue)
			{
				switch( $fieldvalue['field_type'] )
				{
					case 'DA' :
						$result['popup_view_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->dateToLocal($result[$this->appNameSingular][$fieldvalue['field_name']]);
						break;
						
					case 'DD':
					case 'DF' :
					case 'RR' :
						$related = getOneAssocArray( 'select '.$fieldvalue['related_name'].' from '.
							$fieldvalue['related_table'].' where '.$fieldvalue['related_id'].' = "'.$result[$this->appNameSingular][$fieldvalue['field_name']].'"');
						$result[$this->appNameSingular]['related_'.$fieldvalue['field_name']] = $related[$fieldvalue['related_name']];						
						$result['popup_view_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
						break;
						
					case 'DS' :
						$result['popup_view_fields'][$fieldkey]['field_current_value'] = getfilesize($result[$this->appNameSingular][$fieldvalue['field_name']]);
						break;
						
					case 'DT' :
						$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
						$result['popup_view_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
						break;
								

					case 'RD' :			
					case 'RM' :			
						list($remnbr,$period) = explode('.',$result[$this->appNameSingular][$fieldvalue['field_name']]);
						if( $remnbr != '' && $period != '')
						{
							$result['popup_view_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
							$result['popup_view_fields'][$fieldkey]['field_current_value_nbr'] = $remnbr;
							$result['popup_view_fields'][$fieldkey]['field_current_value_period'] = getOneColOneRow('select period_name from global_notifications_periods where period_id = "'.$period.'"');
						}
						break;
														
					case 'TS' :
						$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
						$result['popup_view_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
						$field = getOneAssocArray( 'select field_name, related_name, related_id, related_table from db_fields where app_name = "'.$this->appName.'" and field_name = "'.$fieldvalue['field_name'].'_by"');
						if( $field['related_name'] && $field['related_id'] && $field['related_table'] )
						{
							$related = getOneAssocArray( 'select '.$field['related_name'].' as related_name from '.
								$field['related_table'].' where '.$field['related_id'].' = "'.$result[$this->appNameSingular][$field['field_name']].'"');
							$result[$this->appNameSingular]['related_'.$field['field_name']] = $related['related_name'];						
						}
						break;
						
					case 'WS' :
						if( strlen($result['popup_view_fields'][$fieldkey]['field_current_value']) && strpos( $result['popup_view_fields'][$fieldkey]['field_current_value'], '://') === false )
							$result['popup_view_fields'][$fieldkey]['field_current_value'] = 'http://'.$result['popup_view_fields'][$fieldkey]['field_current_value'];
						break;
						
					default:
						$result['popup_view_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
						break;					
				}
			}               		           		               		             
			$result['popup_view_blocks'] = getManyAssocArrays('select * from db_blocks where app_name = "'.$this->appName.'" and form_name = "'.$popup_view.'" order by block_sequence');			
		}
		
		if( $args['key'] == 'Print')
		{
			$GLOBALS['appshore']->add_xsl('lib.print');         

			foreach( $result['popup_view_fields'] as $fieldkey => $fieldvalue)
			{
				$result['popup_view_fields'][$fieldkey]['popup_view_block_id'] = $fieldvalue['view_block_id'];
				$result['popup_view_fields'][$fieldkey]['popup_view_side'] = $fieldvalue['view_side'];
			}		
			
			$result['action'][$this->appName] = 'print';
		}
		else	
			$result['action'][$this->appName] = 'popup_view';

		$GLOBALS['appshore_data']['layout'] = 'popup';

		$this->defaultSessionApp('popup_'.$this->appName);
		$result['recordset'] = $_SESSION['popup_'.$this->appName];			

		return $result;
    }
    
	// edit or create one record
    function edit()
    {
		$args = new safe_args();
		$args->set('key',						NOTSET,'any');
		$args->set('offset', 					NOTSET,'any');		
		$args->set('linked_appName',			NOTSET,'any');
		$args->set('linked_recordId',			NOTSET,'any');
		$args->set('linked_recordIdValue',		NOTSET,'any');
		$args->set('linked_recordNameValue',	NOTSET,'any');

		// edit fields
		$recordKey = $userKey = false;
		if( $edit_fields = $this->getFields($this->appName, $this->appTable, 'popup_edit') )
			foreach( $edit_fields as $fieldkey => $fieldvalue)
			{
				if( $edit_fields[$fieldkey]['field_name'] == $this->appRecordId )
					$recordKey = true;
				if( $edit_fields[$fieldkey]['field_name'] == 'user_id' )
					$userKey = true;
				$args->set( $edit_fields[$fieldkey]['field_name'], $_SESSION['popup_'.$this->appName][$edit_fields[$fieldkey]['field_name']], 'any');
			}
			
		if( $recordKey == false)
			$args->set($this->appRecordId, NOTSET,'any');
		if( $userKey == false && $this->appRecordId != 'user_id' )
			$args->set('user_id', NOTSET,'any');
				
		$args = $args->get(func_get_args());

        $GLOBALS['appshore']->add_xsl($this->appXSL);
        $GLOBALS['appshore']->add_xsl('lib.base');         
        $GLOBALS['appshore']->add_xsl('lib.custom');         
        $GLOBALS['appshore']->add_xsl('lib.actions');         
        $GLOBALS['appshore']->add_xsl('lib.edit');         

		//if( $this->appRole == $this->appName )
			$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], $this->appRole, $this->appTable, $this->appRecordId, $args[$this->appRecordId]);
		//else
			//$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], $this->appRole);

 		switch($args['key'])
		{

			case 'Delete':
				if( $this->deleteRecord( $args[$this->appRecordId], true) == false )
				{
					unset( $args['key']);
					$args['offset'] = $_SESSION[$this->appName]['currentVal'];								
					return $this->edit( $args);
				}
				unset( $args['key']);
				$GLOBALS['appshore_data']['layout'] = 'popup';
				$this->defaultSessionApp('popup_'.$this->appName);
				$result['recordset'] = $_SESSION['popup_'.$this->appName];			
				$result['action'][$this->appName] = 'popup_confirm_delete';
				
				// delete if exists notification and/or schedule on this record
   				$this->deleteNotification( $args);
   				$this->deleteSchedule( $args);   				

				return $result;
                break;
 
				
			case 'Error':
				messagebox( $error, ERROR);
				//NO break

			case 'Save':
				// the special case of full_name which occurs very frequently
				$args['full_name'] = setFullname($args['first_names'],$args['last_name']);
				
				if ($args[$this->appRecordId]) 	// UPDATE an existing record
				{
               		if ( $this->checkFields($args, $edit_fields) == false )
					{
						$result[$this->appNameSingular] = $args;
	                    $result['Error'] = true;
	                }
					else if( updateRow( $this->appTable, $this->appRecordId, $args) == null )
					{
						$result[$this->appNameSingular] = $args;
	                    $result['Error'] = true;
	                }
	                else
	                {
	                	messagebox( MSG_UPDATE, NOTICE);
	                		                        
                        // set a notification if available    
               			$this->setNotification( $args);
               			
                        // set a schedule if available    
               			$this->setSchedule( $args);
					}
				}
				else 								// New record so we do an INSERT
				{
			        // quickAdd feature
			        if( $args['linked_appName'] && $args['linked_recordIdValue'] )
			        {	
						$linked = getOneAssocArray( 'select * from db_linked where app_name = "'.$this->appName.'" and linked_app_name = "'.$args['linked_appName'].'"');	        	

						$args[$this->appRecordId] = generateId() ;
						if( $linked['linked_type'] == 'NN' )
						{
							$link['from_table'] = $this->appTable;
							$link['from_id'] = $args[$this->appRecordId];
							$link['to_table'] = $linked['linked_table_name'];
							$link['to_id'] = $args['linked_recordIdValue'];
							insertRow( 'links', 'from_id', $link, false);
						}
						else
						{
			 				$args[$linked['linked_record_name']] = $args['linked_recordIdValue'];
						}	
			 		}     
				
					$args = (array)$this->newEntry($args);
               		if ( $this->checkFields($args, $edit_fields) == false )
					{
						$result[$this->appNameSingular] = $args;
	                    $result['Error'] = true;
	                }
					else
					{
						$args[$this->appRecordId] = insertRow( $this->appTable, $this->appRecordId, $args);
						if ( $args[$this->appRecordId] == null )
						{
							$result[$this->appNameSingular] = $args;
							$result['Error'] = $GLOBALS['Error'];
							messagebox($result['Error']['msg'].': '.$result['Error']['value'], ERROR, null, false);
						}
						else
						{
							messagebox( MSG_INSERT, NOTICE);
                        
		                    // set a notification if available    
		           			$this->setNotification( $args);
		           			
		                    // set a schedule if available    
		           			$this->setSchedule( $args);
		           		}
					}
				}		
				
				// NO Break for 'Save' record
			default:
				if ($args[$this->appRecordId])
				{
					$result[$this->appNameSingular] = getOneAssocArray( 'select * from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');	        	
				}
                else // New record: init of some value
                {
                    $result[$this->appNameSingular] = $this->newEntry( $args);                    
                }
				
				// format result according field_type and other parameters
				foreach( $edit_fields as $fieldkey => $fieldvalue)
					if( $fieldvalue['popup_edit_sequence'] > 0 )
						$result['popup_edit_fields'][] = $fieldvalue; 

				if( $result['popup_edit_fields'] )
				{				
					foreach( $result['popup_edit_fields'] as $fieldkey => $fieldvalue)
					{
						// no computed fields should appear in the SQL request
						if(  $fieldvalue['is_computed'] == 'Y' )
							continue;
					
						switch( $fieldvalue['field_type'])
						{
							case 'DA' :
								$result['popup_edit_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->dateToLocal($result[$this->appNameSingular][$fieldvalue['field_name']]);
								break;
								
							case 'DS' :
								$result['popup_edit_fields'][$fieldkey]['field_current_value'] = getfilesize($result[$this->appNameSingular][$fieldvalue['field_name']]);
								break;
								
							case 'DT' :
								$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
								$result['popup_edit_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
								break;
								
							case 'DD' :			
								$result['popup_edit_fields'][$fieldkey]['field_options'] = getManyAssocArrays( 
									'select '.$fieldvalue['related_id'].' as option_id, '.$fieldvalue['related_name'].' as option_name from '.
									$fieldvalue['related_table'].' order by '.$fieldvalue['related_name']);
								// no break
								
							case 'RR' :			
								$related = getOneAssocArray( 'select '.$fieldvalue['related_name'].' from '.
									$fieldvalue['related_table'].' where '.$fieldvalue['related_id'].' = "'.$result[$this->appNameSingular][$fieldvalue['field_name']].'"');
								$result[$this->appNameSingular]['related_'.$fieldvalue['field_name']] = $related[$fieldvalue['related_name']];						
								$result['popup_edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								break;
								
							case 'RD' :			
							case 'RM' :											
								$result = $this->setNotificationOptions( $result, $fieldvalue['field_type']);
								list($remnbr,$period) = explode('.',$result[$this->appNameSingular][$fieldvalue['field_name']]);
								if( $remnbr != '' && $period != '')
								{
									$result['popup_edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
									$result['popup_edit_fields'][$fieldkey]['field_current_value_nbr'] = $remnbr;
									$result['popup_edit_fields'][$fieldkey]['field_current_value_period'] = $period;
								}
								break;
								
							case 'TS' :
								$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
								$result['popup_edit_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
								$field = getOneAssocArray( 'select field_name, related_name, related_id, related_table from db_fields where app_name = "'.$this->appName.'" and field_name = "'.$fieldvalue['field_name'].'_by"');
								if( $field['related_name'] && $field['related_id'] && $field['related_table'] )
								{
									$related = getOneAssocArray( 'select '.$field['related_name'].' as related_name from '.
										$field['related_table'].' where '.$field['related_id'].' = "'.$result[$this->appNameSingular][$field['field_name']].'"');
									$result[$this->appNameSingular]['related_'.$field['field_name']] = $related['related_name'];	
								}					
								break;
								
							case 'WS' :
								$result['popup_edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								if( strlen($result['popup_edit_fields'][$fieldkey]['field_current_value']) && strpos( $result['popup_edit_fields'][$fieldkey]['field_current_value'], '://') === false )
									$result['popup_edit_fields'][$fieldkey]['field_current_value'] = 'http://'.$result['popup_edit_fields'][$fieldkey]['field_current_value'];
								break;
								
							default :
								$result['popup_edit_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
								break;
						}
					}
					$result['popup_edit_blocks'] = getManyAssocArrays('select * from db_blocks where app_name = "'.$this->appName.'" and form_name = "popup_edit" order by block_sequence');			

				}      
				else	// no custom form here
				{
					// we remove this xsl lib to use the specific one
			        $GLOBALS['appshore']->remove_xsl('lib.custom');				
				}      		           		               		             
				
	        	// record passage in history
				$GLOBALS['appshore']->history->setHistory( $this->appName.'.base.view', $result[$this->appNameSingular][$this->appRecordName], $this->appRecordId.'='.$result[$this->appNameSingular][$this->appRecordId] );		
				// scope is set to 0 or 1 means READ_ONLY or READ_WRITE
				// xsl file will test this value to display or not edit/delete/copy buttons
				$result['scope'] = ''.$GLOBALS['appshore']->rbac->checkPermissionOnUser( $this->appRole, $result[$this->appNameSingular]['user_id']?$result[$this->appNameSingular]['user_id']:$GLOBALS['appshore_data']['current_user']['user_id']) ;
				// get the users list that we can RW to potentialy assign the record to one of them
				$result['users'] = getManyAssocArrays( 'select user_id, user_name, full_name from users '.buildClauseWhere($this->appRole,'W',''). ' order by full_name');				
				break;
		}

		$GLOBALS['appshore_data']['layout'] = 'popup';
        $result['action'][$this->appName] = 'popup_edit';           
		$this->defaultSessionApp('popup_'.$this->appName);
		$result['recordset'] = $_SESSION['popup_'.$this->appName];			
        return $result;
    }
        
      
}
