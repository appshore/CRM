<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/


require_once ( 'class.customization_applications.php');

class administration_customization_linked extends administration_customization_applications{
	
    function __construct()
    {
        parent::__construct();    	

	    $this->form_name 		= 'linked';
	    $this->field_sequence	= 'linked_sequence';
	    unset($this->field_side);	    
	    unset($this->field_block_id);	    

        $GLOBALS['appshore']->add_xsl('administration.customization_'.$this->form_name);  		
	} 
	
	// view one customization
    function edit()
    {
		$args = new safe_args();
		$args->set('app_name', $_SESSION['customization']['applications']['app_name'], 'sqlsafe');
		$args->set('block_id', NOTSET, 'sqlsafe');
		$args = $args->get(func_get_args());
		
		$this->menus();	

		$result = $this->selectApplication( 'linked', $args['app_name']);
		$result['available_apps'] = getManyAssocArrays('select * from db_linked where app_name = "'.$result['customization']['app_name'].'" and linked_type <> "11" and sequence = 0 order by linked_app_label'); 
		$result['used_apps'] = getManyAssocArrays('select * from db_linked where app_name = "'.$result['customization']['app_name'].'"  and linked_type <> "11"  and sequence > 0 order by sequence'); 
						
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
		
		deleteRowWhere( 'db_linked', 'where `app_name` = "'.$args['app_name'].'"', false); 
					
		$GLOBALS['appshore']->db->execute('insert into db_linked select * from '.
			$GLOBALS['appshore_data']['server']['globaldb'].'.db_linked where app_name = "'.$args['app_name'].'"');	
										
		$result['return'] = 'success';
		$result['message'] = lang('Form restored');
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

		$update['sequence'] = 0;
		updateRowWhere( 'db_linked', 'where `app_name` = "'.$args['app_name'].'" and sequence > "0"', $update, false); 

		// to remove the block name
		list( $null, $fields) = explode( ':', $args['fields']);

		$sequence = 1;			
		foreach( explode( ',', $fields) as $key => $val)
		{
			$update['sequence'] = $sequence++;
			list( $table_name, $record_name) = explode( '.', $val);
			updateRowWhere( 'db_linked', 'where `app_name` = "'.$args['app_name'].'" and `linked_table_name` = "'.
				$table_name.'" and `linked_record_name` = "'.$record_name.'"', $update, false); 
		}	
			
		$result['return'] = 'success';
		$result['message'] = lang('Form updated');
 		return $result;
    }
 

}
