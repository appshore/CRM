<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice MICHEL <bmichel@appshore.com>                 *
 * Copyright (C) 2004 Brice MICHEL                                          *
 * -------------------------------------------------------------------------*
 * This program is free software; you can redistribute it and/or modify it  *
 * under the terms of the GNU General Public License as published by the    *
 * Free Software Foundation; either version 2 of the License, or (at your   *
 * option) any later version.                                               *
 * \*************************************************************************
 */

// class meeting extends activities so requires it
require_once ( 'class.customization.php');

class administration_customization_dropdown extends administration_customization
{
	
	// view one customization
    function edit()
    {
		$args = new safe_args();
		$args->set('key',				NOTSET,'any');
		$args->set('table_name',		NOTSET,'any');		
		$args->set('new_table_name',	NOTSET,'any');		
		$args->set('table_label',		NOTSET,'any');		
		
		// Allow to retrieve all the cols from this table
		for( $i = 0 ; $i < 200 ; $i++ )
		{
			$args->set( 'id_'.$i,		NOTSET,	'any');
			$args->set( 'name_'.$i,		NOTSET,	'any');
			$args->set( 'value_'.$i,	NOTSET,	'any');
		}
		$args = $args->get(func_get_args());

		$this->menus();
        $GLOBALS['appshore']->add_xsl('administration.customization_dropdown');    			

		$list = getOneAssocArray( 'select * from db_lookups where table_name = "'.$args['table_name'].'" limit 1');
				
		$args['key'] = $GLOBALS['appshore']->rbac->checkGlobal( $args['key'], 'administration');
		
		switch($args['key'])
		{
			case 'New':
				unset( $args['table_name']);
				break;		
			case 'Restore':
				if( executeSQL('SELECT count(*) FROM '.$GLOBALS['appshore_data']['server']['globaldb'].'.'.$list['table_name']) == null) 
				{
					messagebox( 'No list to restore', ERROR);								
					break;
				}
				executeSQL('truncate '.$list['table_name']);
				executeSQL('INSERT INTO '.$list['table_name'].' SELECT * FROM '.$GLOBALS['appshore_data']['server']['globaldb'].'.'.$list['table_name']); 
				messagebox( MSG_RESTORE, NOTICE);					
				break;		
			case 'Delete':
				if( $list['is_custom'] == 'Y' ) // new custom drop down list
				{
	            	$list['table_name'] = $args['table_name'];
					deleteRow( 'db_lookups', 'table_name', $list, false);
					executeSQL( 'update db_fields set field_type = "TE", related_table = "", related_id = "", related_name = "" '.
						' where related_table = "'.$list['table_name'].'"') ;					
					executeSQL( 'DROP TABLE `'.$list['table_name'].'`') ;					
					messagebox( MSG_DELETE, NOTICE);								
					unset( $args['table_name']);
				}
				break;
			case 'Save':
				if( $list == null ) // new custom drop down list
				{
					if( trim($args['new_table_name']) == '' )
					{
						messagebox( 'List name is mandatory', ERROR);				
						break;
					}								
	            	$list['table_name'] 		= 'custom_'.sanitize($args['new_table_name'], 'sqlwords');
	            	$list['table_label'] 		= $args['table_label']?$args['table_label']:ucwords(str_replace( '_', ' ', $args['new_table_name']));
	            	$list['is_custom']  		= 'Y' ;
	            	$list['is_customizable']  	= 'Y' ;
	            	$list['lookup_id']  		= 'list_id' ;
	            	$list['lookup_name']  		= 'list_name' ;
					if( insertRow( 'db_lookups', 'table_name', $list, false) == null )
					{
						messagebox( 'List can\'t be created', ERROR);				
						break;
					}								
					else if( executeSQL( 'CREATE TABLE `'.$list['table_name'].'` '.
							' ( `list_id` varchar(32) NOT NULL default "", `list_name` varchar(250) NOT NULL default "", primary key  (`list_id`))') == null )
					{
						messagebox( 'List can\'t be created', ERROR);				
						break;
					}													
					else 
						$args['table_name'] = $list['table_name'];				
				}
				else if( ($list['table_label'] != $args['table_label']) && $args['table_label'] )
				{
	            	$list['table_name'] 		= $args['table_name'];
	            	$list['table_label'] 		= $args['table_label'];
					updateRow( 'db_lookups', 'table_name', $list, false);				
				}
				
				executeSQL('truncate '.$list['table_name']);
				if ( $list['lookup_value'] )
				{
					for( $i = 0 ; $i < 200 ; $i++ )
						if( trim($args['id_'.$i]) != '' && trim($args['name_'.$i]) != '' )
						{
							executeSQL('INSERT INTO '.$list['table_name'].' 
								SET '.$list['lookup_id'].' = "'.$args['id_'.$i].'", '.$list['lookup_value'].' = "'.$args['value_'.$i].'", '.
									$list['lookup_name'].' = "'.$args['name_'.$i].'"'); 
						}
				}
				else
				{
					for( $i = 0 ; $i < 200 ; $i++ )
						if( trim($args['id_'.$i]) != '' && trim($args['name_'.$i]) != '' )
						{
							executeSQL('INSERT INTO '.$list['table_name'].' 
								SET '.$list['lookup_id'].' = "'.$args['id_'.$i].'", '.$list['lookup_name'].' = "'.$args['name_'.$i].'"'); 
						}
				}
				
				messagebox( MSG_UPDATE, NOTICE);					
				break;
		}
		
		if( $args['table_name'])
		{
			if ( $list['lookup_value'] )
			{
				$result['dropdown'] = getManyAssocArrays('select "1" as scope, '.
					$list['lookup_id'].' as lookup_id, '.$list['lookup_name'].' as lookup_name, '.
					$list['lookup_value'].' as lookup_value from '.$list['table_name'].' order by '.$list['lookup_name']);
			}
			else
			{
				$result['dropdown'] = getManyAssocArrays('select "1" as scope, '.
					$list['lookup_id'].' as lookup_id, '.$list['lookup_name'].' as lookup_name '.
					'from '.$list['table_name'].' order by '.$list['lookup_name']);
			} 
			
			$inc=1;
			if( $result['dropdown'] )
				foreach( $result['dropdown'] as $key => $val)
					$result['dropdown'][$key]['increment'] = $inc++;
				
			if ( $list['lookup_value'] )
				for( $i = 0 ; $i < 5 ; $i++ )	
					$result['dropdown'][] = array('scope' => '1','lookup_id' => '','lookup_name' => '','lookup_value' => '','increment' => $inc++);	
			else
				for( $i = 0 ; $i < 5 ; $i++ )	
					$result['dropdown'][] = array('scope' => '1','lookup_id' => '','lookup_name' => '','increment' => $inc++);	
			
			$result['customization'] = $list;	
		}
		
		// scope is set to 0 or 1 means READ_ONLY or READ_WRITE
		// xsl file will test this value to display or not edit/delete/copy buttons
		$result['scope'] = ($GLOBALS['appshore']->rbac->checkPermissionOnUser('administration', $result['administration']['user_id']))?1:0 ;
		
		$result['dropdownlists'] = getManyAssocArrays('select * from db_lookups where is_customizable = "Y" order by table_label');					
		$result['action']['customization'] = 'dropdown';			
		return $result;
    } 	
 

}
