<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/

// class meeting extends activities so requires it
require_once ( 'class.customization.php');

class administration_customization_applications extends administration_customization
{
	var $tabs ;
	var $form_name;
	var $field_sequence;
	var $field_block_id;
	var $field_side;
	var	$from_form_name;
	var	$from_field_sequence;

    function __construct()
    {
    	// define the periods list
	    $this->tabs = array(    
//	        array ( 'tab_id' => 'properties',		'tab_op' => 'administration.customization_properties.edit', 	'tab_name' => 'Application properties'),
	        array ( 'tab_id' => 'fields',			'tab_op' => 'administration.customization_fields.edit', 		'tab_name' => 'Field properties'),
	        array ( 'tab_id' => 'searches', 		'tab_op' => 'administration.customization_searches.edit',		'tab_name' => 'Search filters'),
	        array ( 'tab_id' => 'results', 			'tab_op' => 'administration.customization_results.edit',		'tab_name' => 'Search results'),
	        array ( 'tab_id' => 'bulk',				'tab_op' => 'administration.customization_bulk.edit', 			'tab_name' => 'Bulk form'),	        
	        array ( 'tab_id' => 'view', 			'tab_op' => 'administration.customization_view.edit',			'tab_name' => 'View form'),
	        array ( 'tab_id' => 'edit', 			'tab_op' => 'administration.customization_edit.edit',			'tab_name' => 'Edit form'),
	        array ( 'tab_id' => 'linked', 			'tab_op' => 'administration.customization_linked.edit',			'tab_name' => 'Linked applications'),
	        array ( 'tab_id' => 'linked_view', 		'tab_op' => 'administration.customization_linked_view.edit',	'tab_name' => 'Linked view form'),
	        array ( 'tab_id' => 'popup_searches', 	'tab_op' => 'administration.customization_popup_searches.edit',	'tab_name' => 'Popup search filters'),
	        array ( 'tab_id' => 'popup_results', 	'tab_op' => 'administration.customization_popup_results.edit',	'tab_name' => 'Popup search results'),
	        array ( 'tab_id' => 'popup_view', 		'tab_op' => 'administration.customization_popup_view.edit',		'tab_name' => 'Popup view form'),
	        array ( 'tab_id' => 'popup_edit', 		'tab_op' => 'administration.customization_popup_edit.edit',		'tab_name' => 'Popup edit form')
	        );         

		parent::__construct();
    }
    
    function menus()
    {  
    	parent::menus();
        $GLOBALS['appshore']->remove_xsl('administration.customization');    
        $GLOBALS['appshore']->add_xsl('administration.customization_applications'); 
        $GLOBALS['appshore']->add_xsl('lib.custom_lib');   
        
        checkEdition(true);             
    } 
        
    function start()
    {  
    	// set context to first tab module
		$GLOBALS['appshore_data']['api']['op'] = $_SESSION['customization']['applications']['tab_id']?$this->selectOp($_SESSION['customization']['applications']['tab_id']):'administration.customization_fields.edit';   
		return execMethod($GLOBALS['appshore_data']['api']['op']);		
    } 
    
	
	// view one customization
    function selectApplication( $tab_id, $app_name)
    {						
		$result['applications'] = getManyAssocArrays('select * from db_applications where is_visible = "Y" and is_customizable = "Y" order by app_label');					
		
		if( !$app_name )
		{
			$app_name = $result['applications'][0]['app_name'];
			$_SESSION['customization']['applications']['table_name'] = $result['customization']['table_name'] = $result['applications'][0]['table_name'];
			$excluded = explode( ',', $result['applications'][0]['excluded_tabs']);
		}
		else
		{
			$application = getOneAssocArray('select * from db_applications where app_name = "'.$app_name.'"');					
			$app_name = $application['app_name'];
			$_SESSION['customization']['applications']['table_name'] = $result['customization']['table_name'] = $application['table_name'];
			$excluded = explode( ',', $application['excluded_tabs']);
		}
		
		foreach( $this->tabs as $key => $value)
			if( in_array( $value['tab_id'], $excluded) == false )
				$result['tabs'][] = $this->tabs[$key];		
		
		if( in_array( $tab_id, $excluded) == false )
			$_SESSION['customization']['applications']['tab_id'] = $result['customization']['tab_id'] = $tab_id;	
		else
			$_SESSION['customization']['applications']['tab_id'] = $result['customization']['tab_id'] = $result['tabs'][0]['tab_id'];	
			
		$_SESSION['customization']['applications']['app_name'] = $result['customization']['app_name'] = $app_name;	
		
		$GLOBALS['appshore_data']['api']['op'] = $this->selectOp($result['customization']['tab_id']);

		// scope is set to 0 or 1 means READ_ONLY or READ_WRITE
		// xsl file will test this value to display or not edit/delete/copy buttons
		$result['scope'] = $GLOBALS['appshore']->rbac->checkPermissionOnUser('administration', $result['administration']['user_id']) ;
		
		// Put tab context 
		$result['action']['customization'] = $result['customization']['tab_id'];

		return $result;
    } 	
    
	// view one customization
    function selectOp( $tab_id)
    {						
		foreach( $this->tabs as $key => $value )
			if( $value['tab_id'] == $tab_id )
				return $value['tab_op'];
		return null;
    }  
    
    function edit()
    {
		$args = new safe_args();
		$args->set('app_name', $_SESSION['customization']['applications']['app_name'], 'sqlsafe');
		$args->set('block_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());
		
		$this->menus();	
		
		if( $args['app_name'] != $_SESSION['customization']['applications']['app_name'] )
		{
			$result = $this->selectApplication( $this->form_name, $args['app_name']);
			return execMethod($GLOBALS['appshore_data']['api']['op']);		
		}
		else
			$result = $this->selectApplication( $this->form_name, $args['app_name']);
		
		$result['available_fields'] = getManyAssocArrays('select * from db_fields where app_name = "'.$result['customization']['app_name'].
			'" and '.$this->field_sequence.' = "0" order by field_label'); 

		if( $this->field_side )
		{		
			$result['lside_fields'] = getManyAssocArrays('select *, '.$this->field_block_id.' as current_block_id from db_fields where app_name = "'.
				$result['customization']['app_name'].'" and '.$this->field_sequence.' > "0" and '.
				$this->field_side.' = "L" order by '.$this->field_sequence); 
			$result['rside_fields'] = getManyAssocArrays('select *, '.$this->field_block_id.' as current_block_id from db_fields where app_name = "'.
				$result['customization']['app_name'].'" and '.$this->field_sequence.' > "0" and '.
				$this->field_side.' = "R" order by '.$this->field_sequence); 
			$result['blocks'] = getManyAssocArrays('select * from db_blocks where app_name = "'.$result['customization']['app_name'].
				'" and form_name = "'.$this->form_name.'" order by block_sequence'); 
			if( $args['block_id'])
				$result['block'] = getOneAssocArray('select * from db_blocks where block_id = "'.$args['block_id'].'"'); 
		}
		else
			$result['used_fields'] = getManyAssocArrays('select * from db_fields where app_name = "'.$result['customization']['app_name'].
				'" and '.$this->field_sequence.' > "0" order by '.$this->field_sequence); 

		return $result;
    } 	
 
    function save()
    {
		$args = new safe_args();
		$args->set('app_name', 	$_SESSION['customization']['applications']['app_name'], 'sqlsafe');
		$args->set('fields', 	NOTSET, 'any');
		$args = $args->get(func_get_args());  
		
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
		
		if( checkEdition(true) == false )
		{
			$result['return'] = 'failure';
			$result['message'] = 'Unauthorized operation';
 			return $result ;
		}

		// we reset the existing fields for the current form
		$update[$this->field_sequence] = 0;
		updateRowWhere( 'db_fields', 'where app_name ="'.$args['app_name'].'" and '.$this->field_sequence.' > "0"', $update, false); 
		
		// we switch between the 2 differents types of serialization 
		if( strpos( $args['fields'], ':') === false)
		{	//first is forms without block
			$sequence = 1;			
			if( $fields = explode( ',', $args['fields']) )
			{
				foreach( $fields as $key => $val)
				{
					if( $val )
					{
		            	unset( $update);
						$update[$this->field_sequence] = $sequence++;
    					updateRowWhere( 'db_fields', 'where app_name ="'.$args['app_name'].'" and field_name = "'.$val.'"', $update, false);
					}
				}
			}
		}
		else
		{	// then forms with blocks
			$groupsequence = 1;			
			if( $fields = explode( ';', $args['fields']) )
			{
				foreach( $fields as $keyblock => $varblock)
				{
					list( $blockname, $blockvalues) = explode( ':', $varblock);
					list( $blockside, $block_id) = explode( '_', $blockname);
					
					$groupupdate['block_id'] = $block_id;
					$groupupdate['block_sequence'] = $groupsequence++;
					updateRow( 'db_blocks', 'block_id', $groupupdate, false); 

					if( $blockside )
					{
						$sequence = 1;			
						if( $field = explode( ',', $blockvalues) )
						{
							foreach( $field as $key => $val)
							{
								if( $val )
								{
					            	unset( $update);
									$update[$this->field_sequence] = $sequence++;
									$update[$this->field_block_id] = $block_id;
									$update[$this->field_side] = ucfirst($blockside[0]); 
                					updateRowWhere( 'db_fields', 'where app_name ="'.$args['app_name'].'" and field_name = "'.$val.'"', $update, false);
								}
							}
						}
					}	
				}
			}
		}
			
		$result['return'] = 'success';
		$result['message'] = 'Form updated';
 		return $result;
    }        
    
    function copy()
    {	
		$args = new safe_args();
		$args->set('app_name', 	$_SESSION['customization']['applications']['app_name'], 'sqlsafe');
		$args = $args->get(func_get_args());  
		
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
				
		if( checkEdition(true) == false )
		{
			$result['return'] = 'failure';
			$result['message'] = 'Unauthorized operation';
 			return $result ;
		}
		
		if( $this->field_block_id)
		{
			// we suppress the existings blocks
			deleteRowWhere( 'db_blocks', 'where app_name = "'.$args['app_name'].'" and form_name = "'.$this->form_name.'"', false); 

			// we reset the existing fields for the current form
			$update[$this->field_sequence] = 0;
			updateRowWhere( 'db_fields', 'where app_name ="'.$args['app_name'].'" and '.$this->field_sequence.' > "0"', $update, false); 
				
			$blocks = getManyAssocArrays('select * from db_blocks where app_name = "'.$args['app_name'].'" and form_name = "'.$this->from_form_name.'"');
			if( $blocks )
				foreach( $blocks as $key => $val)
				{
					$from_block_id = $val['block_id'];
					unset($val['block_id']);
					$val['form_name'] = $this->form_name;
					$val['block_name'] = sanitize($val['block_name'], 'sqlsafe');
					$block_id = insertRow( 'db_blocks', 'block_id', $val, false); 
	                executeSQL('update db_fields set '.
	                	$this->field_side.' = '.$this->from_field_side.', '.
	                	$this->field_sequence.' = '.$this->from_field_sequence.', '.
	                	$this->field_block_id.' = "'.$block_id.'" '.
	                    ' where app_name = "'.$args['app_name'].'" and '.$this->from_field_block_id.' = "'.$from_block_id.'" ');
				}
		}
		else
		{
			executeSQL('update db_fields set '.
             	$this->field_sequence.' = '.$this->from_field_sequence.' where app_name = "'.$args['app_name'].'"');
		}
						
		$result['return'] = 'success';
		$result['message'] = 'Form copied';
 		return $result;
    } 
 
    function restore()
    {
		$args = new safe_args();
		$args->set('app_name', 	$_SESSION['customization']['applications']['app_name'], 'sqlsafe');
		$args = $args->get(func_get_args());  
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
		
		if( checkEdition(true) == false )
		{
			$result['return'] = 'failure';
			$result['message'] = 'Unauthorized operation';
 			return $result ;
		}
		
		if( $this->field_block_id)
		{
			// we suppress the existings blocks
			deleteRowWhere( 'db_blocks', 'where app_name = "'.$args['app_name'].'" and form_name = "'.$this->form_name.'"', false); 

			$blocks = getManyAssocArrays('select * from '.$GLOBALS['appshore_data']['server']['globaldb'].
				'.db_blocks where app_name = "'.$args['app_name'].'" and form_name = "'.$this->form_name.'"');
			if( $blocks )
				foreach( $blocks as $key => $val)
					$block_id = insertRow( 'db_blocks', 'block_id', $val, false); 
		}

		// we reset the existing fields for the current form
		$update[$this->field_sequence] = 0;
		updateRowWhere( 'db_fields', 'where app_name ="'.$args['app_name'].'" and '.$this->field_sequence.' > "0"', $update, false); 

		$theseFields = 'field_name,'.$this->field_sequence;
		if( $this->field_side )
			$theseFields .= ','.$this->field_side;
		if( $this->field_block_id )
			$theseFields .= ','.$this->field_block_id;

        $fields = getManyAssocArrays('select '.$theseFields.'  from '.$GLOBALS['appshore_data']['server']['globaldb'].
                '.db_fields where app_name = "'.$args['app_name'].'"  and '.$this->field_sequence.' > "0"');

        if( $fields )
            foreach( $fields as $key => $val)
            {
            	unset( $update);
               	$update[$this->field_sequence] = $val[$this->field_sequence];
				if( $this->field_side )
					$update[$this->field_side] = $val[$this->field_side];
				if( $this->field_block_id )
					$update[$this->field_block_id] = $val[$this->field_block_id];
                updateRowWhere( 'db_fields', 'where app_name ="'.$args['app_name'].'" and field_name = "'.$val['field_name'].'"', $update, false);
            }		
					
						
		$result['return'] = 'success';
		$result['message'] = 'Form restored';
 		return $result;
    } 
       
    
    function saveBlock()
    {	
		$args = new safe_args();
		$args->set('app_name', 		$_SESSION['customization']['applications']['app_name'], 'sqlsafe');
		$args->set('form_name', 	$this->form_name, 'sqlsafe');
		$args->set('block_id', 		NOTSET, 'sqlsafe');
		$args->set('block_name', 	'New block', 'sqlsafe');
		$args->set('is_title', 		'N', 'sqlsafe');
		$args->set('columns', 		'2', 'sqlsafe');
		$args = $args->get(func_get_args());  
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
		
		if( checkEdition(true) == false )
		{
			$result['return'] = 'failure';
			$result['message'] = 'Unauthorized operation';
 			return $result ;
		}

		if( $args['block_id'] )
		{
			updateRow( 'db_blocks', 'block_id', $args, false);
			if( $args['columns'] == '1' )
			{
				$update[$this->field_block_id] = '';
				$update[$this->field_sequence] = '0';
				$update[$this->field_side] = 'L';
				updateRowWhere( 'db_fields', 'where app_name ="'.$args['app_name'].'" and '.$this->field_block_id.' = "'.
					$args['block_id'].'" and '.$this->field_side.' = "R"', $update, false); 			
			}
		} 
		else
		{
			insertRow( 'db_blocks', 'block_id', $args, false); 
		}
												
		$result['return'] = 'success';
		$result['message'] = 'Block saved';
 		return $result;
    }        
    
    
    function deleteBlock()
    {	
		$args = new safe_args();
		$args->set('app_name', 	$_SESSION['customization']['applications']['app_name'], 'sqlsafe');
		$args->set('block_id', 	NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());  
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
		
		if( checkEdition(true) == false )
		{
			$result['return'] = 'failure';
			$result['message'] = 'Unauthorized operation';
 			return $result ;
		}

		if( $args['block_id'] )
		{
			deleteRow( 'db_blocks', 'block_id', $args, false);
			$update[$this->field_block_id] = '';
			$update[$this->field_sequence] = '0';
			$update[$this->field_side] = 'L';
			updateRowWhere( 'db_fields', 'where app_name = "'.$args['app_name'].'" and '.$this->field_block_id.' = "'.
				$args['block_id'].'"', $update, false); 			
		} 
						
												
		$result['return'] = 'success';
		$result['message'] = 'Block deleted';
 		return $result;
    }       
    
    //ajax call to retrieve associated fields with a related table
    function getBlock()
    {
		$args = new safe_args();
		$args->set('app_name', 	$_SESSION['customization']['applications']['app_name'], 'sqlsafe');
		$args->set('block_id', 	NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());
		$GLOBALS['appshore_data']['server']['xml_render'] = true;	
		
		if( $args['block_id'] )
			$result['customization'] = getManyAssocArrays('select * from db_blocks where app_name = "'.$args['app_name'].
				'" and block_id = "'.$args['block_id'].'"');
												
		$result['return'] = 'success';
		$result['message'] = '';
 		return $result;
    }	    

}
