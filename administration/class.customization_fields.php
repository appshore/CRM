<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/

require_once ( 'class.customization_applications.php');

class administration_customization_fields extends administration_customization_applications{
	var $maxCustomFields = 150;
	
    function __construct()
    {        
        parent::__construct();    	

        $this->field_types = array(
   	        array ( 'type_id' => 'CH', 	'type_name' => 'Checkbox', 							'type_custom' => 'Y'),         
	        array ( 'type_id' => 'CU', 	'type_name' => 'Currency', 							'type_custom' => 'Y'),  
	        array ( 'type_id' => 'CD', 	'type_name' => 'Currency with decimals',			'type_custom' => 'Y'),  
	        array ( 'type_id' => 'DA', 	'type_name' => 'Date', 								'type_custom' => 'Y'), 
	        array ( 'type_id' => 'DD', 	'type_name' => 'Drop down list', 					'type_custom' => 'Y'),	        
	        array ( 'type_id' => 'DF', 	'type_name' => 'Document folder', 					'type_custom' => 'N'),
	        array ( 'type_id' => 'DO', 	'type_name' => 'Document', 							'type_custom' => 'N'),
	        array ( 'type_id' => 'DS', 	'type_name' => 'Document size', 					'type_custom' => 'N'),
  	        array ( 'type_id' => 'DT', 	'type_name' => 'Date - Time', 						'type_custom' => 'Y'),
	        array ( 'type_id' => 'DY', 	'type_name' => 'Document type', 					'type_custom' => 'N'),
	        array ( 'type_id' => 'EH', 	'type_name' => 'Editor HTML', 						'type_custom' => 'Y'),
	        array ( 'type_id' => 'EA', 	'type_name' => 'Editor HTML advanced', 				'type_custom' => 'Y'),
	        array ( 'type_id' => 'EM', 	'type_name' => 'Email address', 					'type_custom' => 'Y'),
	        array ( 'type_id' => 'EN', 	'type_name' => 'Enumeration', 						'type_custom' => 'N'),
	        array ( 'type_id' => 'ET', 	'type_name' => 'Editor Text', 						'type_custom' => 'N'),
 	        array ( 'type_id' => 'IM', 	'type_name' => 'Image',								'type_custom' => 'Y'),
 	        array ( 'type_id' => 'LI', 	'type_name' => 'Link', 								'type_custom' => 'N'),	// records link to
	        array ( 'type_id' => 'LR', 	'type_name' => 'Link to many records',				'type_custom' => 'N'),
  	        array ( 'type_id' => 'ML', 	'type_name' => 'Text - Multi lines', 				'type_custom' => 'Y'),
	        array ( 'type_id' => 'MV', 	'type_name' => 'Multi value drop down list',		'type_custom' => 'Y'),	        
  	        array ( 'type_id' => 'NU', 	'type_name' => 'Numeric', 							'type_custom' => 'Y'),
  	        array ( 'type_id' => 'ND', 	'type_name' => 'Numeric with decimals',				'type_custom' => 'Y'),
   	        array ( 'type_id' => 'PE', 	'type_name' => 'Percentage', 						'type_custom' => 'Y'),
   	        array ( 'type_id' => 'PD', 	'type_name' => 'Percentage with decimals', 			'type_custom' => 'Y'),
  	        array ( 'type_id' => 'PH', 	'type_name' => 'Phone, mobile, VoIP', 				'type_custom' => 'Y'),
  	        array ( 'type_id' => 'PW', 	'type_name' => 'Password', 							'type_custom' => 'N'),
 	        array ( 'type_id' => 'RE', 	'type_name' => 'Related', 							'type_custom' => 'N'),	// records related to
	        array ( 'type_id' => 'RK', 	'type_name' => 'Record key', 						'type_custom' => 'N'),	         
  	        array ( 'type_id' => 'RD', 	'type_name' => 'Reminder date',		 				'type_custom' => 'N'),
  	        array ( 'type_id' => 'RM', 	'type_name' => 'Reminder date time', 				'type_custom' => 'N'),
	        array ( 'type_id' => 'RR', 	'type_name' => 'Link to a record',					'type_custom' => 'Y'),
  	        array ( 'type_id' => 'SD', 	'type_name' => 'Scheduler date', 					'type_custom' => 'N'),
  	        array ( 'type_id' => 'ST', 	'type_name' => 'Scheduler date time', 				'type_custom' => 'N'),
  	        array ( 'type_id' => 'TE', 	'type_name' => 'Text', 								'type_custom' => 'Y'),
  	        array ( 'type_id' => 'TI', 	'type_name' => 'Time', 								'type_custom' => 'Y'),  	
  	        array ( 'type_id' => 'TS', 	'type_name' => 'Time stamp', 						'type_custom' => 'Y'),
	        array ( 'type_id' => 'VF', 	'type_name' => 'Link to the record', 				'type_custom' => 'Y'),
	        array ( 'type_id' => 'WM', 	'type_name' => 'Link to web mail', 					'type_custom' => 'Y'), 
  	        array ( 'type_id' => 'WS', 	'type_name' => 'Link to web site', 					'type_custom' => 'Y')
        );  
                         
        $this->result_classes = array(
	        array ( 'class_id' => 'grid_left', 		'class_name' => 'Left'),  
	        array ( 'class_id' => 'grid_center', 	'class_name' => 'Center'),  
	        array ( 'class_id' => 'grid_right', 	'class_name' => 'Right')  
        );                                                    
	} 
	
    function edit()
    {
		$args = new safe_args();
		$args->set('fields_selected', 	NOTSET, 'any');
		$args->set('key',				NOTSET, 'any');	
		$args->set('app_name', 			$_SESSION['customization']['applications']['app_name'], 'sqlsafe');

		$fields = describeColumns('db_fields');
		for( $i = 0 ; $i < $this->maxCustomFields ; $i++ )
		{
			foreach( $fields as $fieldName => $fieldValue)
				$args->set( $fieldName.'_'.$i, NOTSET, 'any');		
		}
		$args = $args->get(func_get_args());
		
		$this->menus();	
        $GLOBALS['appshore']->add_xsl('administration.customization_fields');  		

		$application = getOneAssocArray('select * from db_applications where app_name = "'.$args['app_name'].'"');

		switch($args['key'])
		{
			case 'Delete':
				$selected = explode( ',', $args['fields_selected']);				  
				foreach( $selected as $key => $val)
				{
					$apps = getManyAssocArrays('select app_name from db_applications where table_name = "'.$application['table_name'].'"'); 
					foreach( $apps as $keyapp => $valapp )
					{
						deleteRowWhere('db_fields', 'where app_name ="'.$valapp['app_name'].'" and table_name ="'.$application['table_name'].'" and field_name = "'.$val.'"', false);	
					}
					executeSQL( 'ALTER TABLE `'.$application['table_name'].'` DROP `'.$val.'`') ;	
				}						
				messagebox( MSG_DELETE, NOTICE);					
				break;
						
			case 'Save':
				for( $i = 0 ; $i < $this->maxCustomFields ; $i++ )
				{
					$args['field_name_'.$i]	= strtolower(sanitize($args['field_name_'.$i], 'sqlwords'));            		

					if( $args['field_name_'.$i] )		
		 			{ 		
						unset( $field);
						$field['app_name'] 		= $args['app_name'];            		
						$field['table_name'] 	= $application['table_name'];            		
						$field['field_label'] 	= ($args['field_label_'.$i])?$args['field_label_'.$i]:str_replace( '_', ' ', ucwords(str_replace('custom_', '', $args['field_name_'.$i])));            		
		            	$field['is_search']  	= $args['is_search_'.$i]?$args['is_search_'.$i]:'N';
		            	$field['is_readonly']   = $args['is_readonly_'.$i]?$args['is_readonly_'.$i]:'N';
		            	$field['is_mandatory']  = $args['is_mandatory_'.$i]?$args['is_mandatory_'.$i]:'N';
		            	$field['is_unique']  	= $args['is_unique_'.$i]?$args['is_unique_'.$i]:'N';
						$field['field_type'] 	= $args['field_type_'.$i]?$args['field_type_'.$i]:'TE';
						$field['field_height'] 	= 1;
						$field['result_class'] 	= 'grid_left';
		            	$field['related_table'] = '';
		            	$field['related_id'] 	= '';
		            	$field['related_name'] 	= '';
						//$field['result_sequence'] = $field['popup_search_sequence'] = $field['popup_result_sequence'] = $field['popup_view_sequence'] = '';								

						switch( $field['field_type'] )
						{
							case 'CH':	// checkbox
								$db_field_type = 'ENUM( "Y", "N" ) DEFAULT "N"';
								$field['result_class'] 	= 'grid_center';
								$field['is_search'] = 'N';
								break;								
							case 'DA':	// date
								$db_field_type = 'DATE';
								$field['result_class'] 	= 'grid_center';
								break;
							case 'DD':	// drop down key
							case 'DF':	// Document Folder
								$db_field_type = 'VARCHAR(32)';
				            	$field['related_table'] = $args['related_table_'.$i];
				            	$field['related_id'] 	= $args['related_id_'.$i];
				            	$field['related_name'] 	= $args['related_name_'.$i];
								$field['is_search'] = 'N';
								break;
							case 'DO':	// documents/attachments/folder name
								$db_field_type = 'VARCHAR(250)';
								break;								
							case 'DS':	// Document/folder size
								$db_field_type = 'INT';
								$field['result_class'] 	= 'grid_right';
								$field['is_search'] = 'N';
								break;
							case 'DT':	// date and time
								$db_field_type = 'DATETIME';
								$field['result_class'] 	= 'grid_center';
								$field['is_search'] = 'N';
								break;
							case 'DY':	// Document type
								$db_field_type = 'VARCHAR(250)';
								$field['is_search'] = 'N';
								break;
							case 'EA':	// advanced Editor HTML
							case 'EH':	// Editor HTML
								$db_field_type = 'LONGTEXT';
								$field['field_height'] = '15';
								break;
							case 'EM':	// Email address
								$db_field_type = 'LONGTEXT';
								$field['field_height'] = '1';
								break;
							case 'EN':	// enumeration
								$db_field_type = 'ENUM( "Y", "N" ) DEFAULT "N"';
								$field['result_class'] 	= 'grid_center';
								$field['is_search'] = 'N';
								break;								
							case 'ET':	// Editor Text
								$db_field_type = 'LONGTEXT';
								$field['field_height'] = '15';
								break;
							case 'IM':	// image
								$db_field_type = 'VARCHAR(250)';
								$field['field_height'] = '9';
								$field['result_class'] 	= 'grid_center';
								$field['is_search'] = 'N';
								break;								
							case 'LR':	// link to many records
								$db_field_type = 'VARCHAR(32)';
				            	$field['related_table'] = $args['related_table_'.$i];
				            	$field['related_id'] 	= $args['related_id_'.$i];
				            	$field['related_name'] 	= $args['related_name_'.$i];
								$field['is_search'] = 'N';
								break;
							case 'ML':	// multi lines
								$db_field_type = 'LONGTEXT';
								$field['field_height'] = '4';
								break;
							case 'MV':	// multi value drop down list
								$db_field_type = 'VARCHAR(1024)';
				            	$field['related_table'] = $args['related_table_'.$i];
				            	$field['related_id'] 	= $args['related_id_'.$i];
				            	$field['related_name'] 	= $args['related_name_'.$i];
								$field['is_search'] = 'N';
								break;
							case 'CU':	// currency
							case 'NU':	// numeric
							case 'PE':	// percentage
								$db_field_type = 'INT';
								$field['result_class'] 	= 'grid_right';
								break;
							case 'CD':	// currency with decimals
							case 'ND':	// numeric with decimals
							case 'PD':	// percentage with decimals
								$db_field_type = 'DECIMAL(11,2)';
								$field['result_class'] 	= 'grid_right';
								break;
							case 'PW':	// password
								$db_field_type = 'VARCHAR(250)';
								$field['is_search'] = 'N';
								break;								
							case 'PH':	// Phone, Mobile, VoIp
								$db_field_type = 'VARCHAR(250)';
								break;								
							case 'RK':	// record Key
								$db_field_type = 'VARCHAR(32)';
								$field['is_readonly'] = 'Y';								
								$field['is_mandatory'] = 'Y';								
								$field['is_unique'] = 'Y';								
								$field['view_sequence'] = $field['edit_sequence'] = $field['search_sequence'] = $field['bulk_sequence'] = '-1';								
								$field['result_sequence'] = $field['popup_search_sequence'] = $field['popup_result_sequence'] = $field['popup_view_sequence'] = '-1';								
								$field['is_search'] = 'N';
								break;								
							case 'RD':	// reminder date
								$db_field_type = 'DATE';
								$field['is_search'] = 'N';
								break;
							case 'RM':	// reminder date and time
								$db_field_type = 'DATETIME';
								$field['is_search'] = 'N';
								break;
							case 'RR':	// related record key
								$db_field_type = 'VARCHAR(32)';
				            	$field['related_table'] = $args['related_table_'.$i];
				            	$field['related_id'] 	= $args['related_id_'.$i];
				            	$field['related_name'] 	= $args['related_name_'.$i];
								$field['is_search'] = 'N';
								$field['is_readonly'] = 'N';								
								break;
							case 'SD':	// scheduler date
								$db_field_type = 'DATE';
								$field['is_search'] = 'N';
								break;
							case 'ST':	// scheduler date and time
								$db_field_type = 'DATETIME';
								$field['is_search'] = 'N';
								break;
							case 'TI':	// time
								$db_field_type = 'TIME';
								$field['result_class'] 	= 'grid_center';
								$field['is_search'] = 'N';
								break;								
							case 'TS':	// date time stamp
								$db_field_type = 'DATETIME';
								$field['result_class'] 	= 'grid_center';
								$field['is_search'] = 'N';
								break;								
							case 'VF':	// text
								$db_field_type = 'VARCHAR(250)';
								break;								
							case 'WM':	// webmail link
								$db_field_type = 'VARCHAR(250)';
								break;								
							case 'WS':	// web site link
								$db_field_type = 'VARCHAR(250)';
								$field['field_height'] = '5';
								//$field['result_class'] 	= 'grid_center';
								break;								
							case 'TE':	// text
							DEFAULT:
								$db_field_type = 'VARCHAR(250)';
								break;								
						}		            	

		          		$sql = 'select * from db_fields where app_name = "'.$args['app_name'].'" and table_name ="'.$field['table_name'].'" and field_name = "'.$args['field_name_'.$i].'"';

		          		$is_loaded = getOneAssocArray($sql);

						if( !$is_loaded['field_name'] ) // new custom field
						{
							$args['field_name_'.$i]	= str_replace('custom_', '', $args['field_name_'.$i]);            		
			            	$field['field_name'] = substr('custom_'.$args['field_name_'.$i], 0, 50);
			            	$field['is_custom']  = 'Y' ;
			            	
							$apps = getManyAssocArrays('select app_name from db_applications where table_name = "'.$field['table_name'].'"'); 
							foreach( $apps as $key => $val )
							{
			      				$field['app_name'] = $val['app_name'];	
								insertRow( 'db_fields', 'field_name', $field, false); 
							}
			 			}
			 			elseif( $is_loaded['is_custom'] == 'N' ) // standard field
			 			{	
							// we only allow update of label, mandatory and search		 			
     						$is_loaded['field_label'] = $field['field_label'];
     						$is_loaded['is_readonly'] = $field['is_readonly'];
     						$is_loaded['is_mandatory'] = $field['is_mandatory'];
     						$is_loaded['is_unique'] = $field['is_unique'];
     						$is_loaded['is_search'] = $field['is_search'];
				 			updateRowWhere( 'db_fields', 'where `app_name` = "'.$is_loaded['app_name'].'" and table_name ="'.$is_loaded['table_name'].'" and field_name = "'.$is_loaded['field_name'].'"', $is_loaded, false); 
						}
			 			else // existing custom fields
			 			{	
			            	$field['field_name'] = $args['field_name_'.$i];
			            	$field['is_custom']  = $is_loaded['is_custom'];
			            	$field_label  = $field['field_label'];
			 			
							$apps = getManyAssocArrays('select app_name from db_applications where table_name = "'.$field['table_name'].'"'); 
							foreach( $apps as $key => $val )
							{
			      				$field['app_name'] = $val['app_name'];
			      				
			      				if( $field['app_name'] == $args['app_name'] )
			      					$field['field_label'] = $field_label;
			      				else
			      					unset( $field['field_label']);
			      					
				 				updateRowWhere( 'db_fields', 'where `app_name` = "'.$field['app_name'].'" and table_name ="'.$field['table_name'].'" and field_name = "'.$field['field_name'].'"', $field, false); 
							}
						}
						
						if( $field['is_custom'] == 'Y' )
			 			{	
							if( describeColumns( $field['table_name'], $field['field_name']) )
								$sql = 'ALTER TABLE `'.$field['table_name'].'` CHANGE `'.$field['field_name'].'` `'.$field['field_name'].'` '.$db_field_type.' NOT NULL';
							else
								$sql = 'ALTER TABLE `'.$field['table_name'].'` ADD `'.$field['field_name'].'` '.$db_field_type.' NOT NULL';
							executeSQL( $sql);
						}
					}
				}
				messagebox( MSG_UPDATE, NOTICE);					
				break;
		}
		
		// set the data to the select applications
		$result = $this->selectApplication( 'fields', $args['app_name']);
		$this->defaultFields( $result['customization']['app_name'], $result['customization']['table_name']);
		
		// we insure that all standard/default fields are already loaded for this app
		$result['fields'] = getManyAssocArrays('select * from db_fields where app_name = "'.$result['customization']['app_name'].'" order by is_custom desc, field_name');

		// set the global scope according user's rights of this application
		$result['scope'] = ''.( $GLOBALS['appshore']->rbac->check('administration', RBAC_USER_WRITE ) )?1:0 ;
						
		$inc=0;			
		$customInc=0;
		if( $result['fields'] )
		{
			foreach( $result['fields'] as $key => $val)
			{
				$customInc += ($result['fields'][$key]['scope'] = ( $result['fields'][$key]['is_custom'] == 'Y' ) ? 1 : 0);				
				$result['fields'][$key]['increment'] = $inc++; 
				$result['fields'][$key]['disabled'] = (in_array($result['fields'][$key]['field_type'], array('DD','DF','MV','RR')))?'false':'true'; 
				$result['fields'][$key]['checkbox_is_readonly'] = (in_array($result['fields'][$key]['field_type'], array('CU','CD','CH','DA','DD','DO','DT','DY','ML','MV','NU','PH','RR','TE','TI','TS','VF','WM','WS')))?'true':'false'; 
				$result['fields'][$key]['checkbox_is_mandatory'] = (in_array($result['fields'][$key]['field_type'], array('CU','CD','CH','DA','DD','DO','DT','DY','ML','MV','NU','PH','RR','TE','TI','TS','VF','WM','WS')))?'true':'false'; 
				$result['fields'][$key]['checkbox_is_unique'] = (in_array($result['fields'][$key]['field_type'], array('PH','TE','VF','WM')))?'true':'false'; 
				$result['fields'][$key]['checkbox_is_search'] = (in_array($result['fields'][$key]['field_type'], array('CU','CD','DA','DO','DT','ML','NU','PH','TE','TI','TS','VF','WM','WS')))?'true':'false'; 
				
				if( trim($result['fields'][$key]['related_table']) )
				{
					if ( ($result['fields'][$key]['related_fields'] = getManyAssocArrays('select field_name as field_id, field_name from db_fields where app_name = "'. 
						$result['fields'][$key]['related_table'].'" order by field_name')) == null )
					{
						$result['fields'][$key]['related_fields'] = getManyAssocArrays('select lookup_id as field_id, lookup_name as field_name from db_lookups where table_name = "'. 
							$result['fields'][$key]['related_table'].'"');
					}
				}
			}
		}
			
		// we limit custom field
		$max = (($customInc+10) < $this->maxCustomFields) ? ((($customInc+10)<10)?10:($customInc+10)) : $this->maxCustomFields;
		
		unset( $fields);
		$fields['field_type'] = 'TE';
		while( $customInc < $max)
		{
			$result['fields'][] = array_merge( $fields, array( 'scope' => 1, 'disabled' => 'true', 'increment' => $inc++));
			$customInc++;
		} 
		
		$result['related_tables']	= getManyAssocArrays('select table_name, "DD" as field_type from db_lookups where is_customizable = "Y" union select table_name, "MV" as field_type from db_lookups where is_customizable = "Y" union select table_name, "DF" as field_type from db_applications where is_customizable = "Y" union select table_name, "RR" as field_type from db_applications where is_customizable = "Y"'); 
		$result['app_name']			= $result['customization']['app_name']; 
		$result['field_types'] 		= $this->field_types;
		$result['result_classes'] 	= $this->result_classes;	
		

 		$result['action']['customization'] = 'fields';
		return $result;
    } 
     
    function defaultFields( $app_name, $table_name = null)
    {
		// Get the total size of MySQl tables and indexes
		$db = executeSQL('SHOW COLUMNS FROM '.$table_name);	

      	$field['table_name'] = $table_name;	
 
		while( !$db->EOF )
		{
           $is_loaded = getOneAssocArray('select field_name from db_fields where app_name = "'.$app_name.'" and table_name = "'.$table_name.'" and field_name = "'.$db->fields['Field'].'"');

			if( !$is_loaded['field_name'] )
			{
            	$field['field_name'] = $db->fields['Field'];
				$field['field_label'] = ucfirst(str_replace( '_', ' ', $db->fields['Field']));            		
            	$field['is_custom']  = (strpos($db->fields['Field'], 'custom_') === false)?'N':'Y';
            	$field['is_unique']  = in_array($db->fields['Key'], array('PRI','UNI'))?'Y':'N' ;
            	$field['is_mandatory']  = 'N' ;
            	$field['is_readonly']  = 'N' ;
				$field['is_search'] = 'N';
            	$field['field_default'] = $db->fields['Default'];
				$field['field_height'] = '1';
				
				list( $type) = explode( '(', $db->fields['Type']);
            	
            	switch( $type)
            	{
            		case "date":
            			$field['field_type'] = 'DA';
						$field['result_class'] 	= 'grid_center';
            			break;
            		case "datetime":
            			$field['field_type'] = 'DT';
						$field['result_class'] 	= 'grid_center';
            			break;
            		case "enum":
             			$field['field_type'] = 'CH';
						$field['result_class'] 	= 'grid_center';
            			break;
            		case "tinyint":
            		case "smallint":
            		case "mediumint":
            		case "int":
            		case "bigint":
	           		case "float":
	           		case "double":
	           		case "decimal":
            			$field['field_type'] = 'NU';
						$field['result_class'] 	= 'grid_right';
            			break;
	           		case "tinytext":
	           		case "mediumtext":
	           		case "longtext":
            		case "text":
						$field['is_search'] = 'Y';
            			$field['field_type'] = 'ML';
						$field['field_height'] = '4';
            			break;
            		case "time":
            			$field['field_type'] = 'TI';
						$field['result_class'] 	= 'grid_center';
            			break;
            		case "varchar":
            		default:
            			if( $db->fields['Type'] == 'varchar(32)')
            			{
	            			if( $db->fields['Key'] == 'PRI' )
	            			{
				            	$field['is_readonly']  = 'Y' ;
		            			$field['field_type'] = 'RK';
		            		}
		            		else if( $db->fields['Default'] )            		
		            			$field['field_type'] = 'DD';
		            		else
		            			$field['field_type'] = 'RR';
		            	}
						else
						{
							$field['is_search'] = 'Y';
            				$field['field_type'] = 'TE';
            			}
            			break;
            	}
            	
   				$field['app_name'] = $app_name;	
				insertRow( 'db_fields', 'field_name', $field, false); 
 			}	
			            
			$db->MoveNext();
		}    
    }	    	    
    
    //ajax call to retrieve associated fields with a related table
    function getTables()
    {
		$args = new safe_args();
		$args->set('field_type', NOTSET, 'sqlsafe');		
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore_data']['server']['xml_render'] = true;
		
		$table_name = ( in_array( $args['field_type'], array('DD','MV')) ) ? 'db_lookups' : 'db_applications' ;
			
		$result['customization'] = getManyAssocArrays('select table_name from "'.$table_name.'" order by table_name where is_customizable = "Y"');

 		return $result;
    }	    
     

   
    //ajax call to retrieve associated fields with a related table
    function getRelated()
    {
		$args = new safe_args();
		$args->set('field_type', 	NOTSET, 'sqlsafe');		
		$args->set('related_table', NOTSET, 'sqlsafe');		
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore_data']['server']['xml_render'] = true;
		
		if( in_array( $args['field_type'], array('DD','MV')) )
			$result['customization'] = getManyAssocArrays('select lookup_id, lookup_name from db_lookups where table_name = "'.$args['related_table'].'" and is_customizable="Y"');
		else 
			$result['customization'] = getManyAssocArrays('select field_name from db_fields where table_name = "'.$args['related_table'].'" order by field_name');

 		return $result;
    }	    
      
    // creation and suppression of a unique index on the designated table-field
    function uniqueness()
    {	
		$args = new safe_args();
		$args->set('app_name', NOTSET, 'sqlsafe');		
		$args->set('field_name', NOTSET, 'sqlsafe');		
		$args->set('is_unique', NOTSET, 'sqlsafe');		
		$args = $args->get(func_get_args());

		// default expected result
		$GLOBALS['appshore_data']['server']['xml_render'] = true;						
		$result['return'] = 'success';
		$result['message'] = 'Unique index deleted';

		if( checkEdition(true) == false )
		{
			$result['return'] = 'failure';
			$result['message'] = 'Unauthorized operation';
			$GLOBALS['appshore_data']['server']['xml_render'] = true;	
 			return $result ;
		}
		
		try 
		{ 
			$table = getOneAssocArray('select table_name from db_fields where app_name = "'.$args['app_name'].'" and field_name = "'.$args['field_name'].'"');
			executeSQL( 'ALTER TABLE `'.$table['table_name'].'` DROP INDEX `'.$args['field_name'].'`') ;					
			$field['is_unique'] = 'N';
		} 
		catch (exception $e) 
		{ 
		}
		
		if( in_array( $args['is_unique'], array( 'Y', '1', 'true')) )
		{
			try 
			{ 
				executeSQL( 'ALTER TABLE `'.$table['table_name'].'` ADD UNIQUE (`'.$args['field_name'].'`)') ;
				$field['is_unique'] = 'Y';
				$result['message'] = 'Unique index created';
			} 
			catch (exception $e) 
			{ 
				$result['return'] = 'failure';
				$result['message'] = 'Unique index not created, duplicate records detected';
			}
		}

		updateRowWhere( 'db_fields', 'where `app_name` = "'.$args['app_name'].'" and table_name ="'.$table['table_name'].'" and field_name = "'.$args['field_name'].'"', $field, false); 
		
 		return $result;
    }         

}
