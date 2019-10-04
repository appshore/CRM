<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class lib_print extends lib_base
{

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
		$GLOBALS['appshore']->add_xsl('lib.print');         
        			    	
		$result[$this->appNameSingular] = getOneAssocArray( 'select * from '.$this->appTable.' where '.$this->appRecordId.' = "'.$args[$this->appRecordId].'"');	        	

		// view form
		if( $result['print_view_fields'] = $this->getFields($this->appName, $this->appTable, 'view') )
		{
			foreach( $result['print_view_fields'] as $fieldkey => $fieldvalue)
			{
				switch( $fieldvalue['field_type'] )
				{
					case 'DA' :
						$result['print_view_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->dateToLocal($result[$this->appNameSingular][$fieldvalue['field_name']]);
						break;
					case 'DD':
					case 'DF' :
					case 'RR' :
						$related = getOneAssocArray( 'select '.$fieldvalue['related_name'].' from '.
							$fieldvalue['related_table'].' where '.$fieldvalue['related_id'].' = "'.$result[$this->appNameSingular][$fieldvalue['field_name']].'"');
						$result[$this->appNameSingular]['related_'.$fieldvalue['field_name']] = $related[$fieldvalue['related_name']];						
						$result['print_view_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
						break;
					case 'DS' :
						$result['print_view_fields'][$fieldkey]['field_current_value'] = getfilesize($result[$this->appNameSingular][$fieldvalue['field_name']]);
						break;
					case 'DT' :
						$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
						$result['print_view_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
						break;
					case 'TS' :
						$datetime = $GLOBALS['appshore']->local->gmtToTZ($result[$this->appNameSingular][$fieldvalue['field_name']]);
						$result['print_view_fields'][$fieldkey]['field_current_value'] = $GLOBALS['appshore']->local->datetimeToLocal($datetime);
						$field = getOneAssocArray( 'select field_name, related_name, related_id, related_table from db_fields where app_name = "'.$this->appName.'" and field_name = "'.$fieldvalue['field_name'].'_by"');
						if( $field['related_name'] && $field['related_id'] && $field['related_table'] )
						{
							$related = getOneAssocArray( 'select '.$field['related_name'].' as related_name from '.
								$field['related_table'].' where '.$field['related_id'].' = "'.$result[$this->appNameSingular][$field['field_name']].'"');
							$result[$this->appNameSingular]['related_'.$field['field_name']] = $related['related_name'];						
						}
						break;
					case 'WS' :
						if( strlen($result['print_view_fields'][$fieldkey]['field_current_value']) && strpos( $result['print_view_fields'][$fieldkey]['field_current_value'], '://') === false )
							$result['print_view_fields'][$fieldkey]['field_current_value'] = 'http://'.$result['print_view_fields'][$fieldkey]['field_current_value'];
						break;
					default:
						$result['print_view_fields'][$fieldkey]['field_current_value'] = $result[$this->appNameSingular][$fieldvalue['field_name']];
						break;					
				}
			}               		           		               		             
			$result['print_view_blocks'] = getManyAssocArrays('select * from db_blocks where app_name = "'.$this->appName.'" and form_name = "'.'view'.'" order by block_sequence');			
		}
		

		foreach( $result['print_view_fields'] as $fieldkey => $fieldvalue)
		{
			$result['print_view_fields'][$fieldkey]['print_view_block_id'] = $fieldvalue['view_block_id'];
			$result['print_view_fields'][$fieldkey]['print_view_side'] = $fieldvalue['view_side'];
			unset( $result['print_view_fields'][$fieldkey]['field_type']);
		}		
		
		$result['action'][$this->appName] = 'print';
		$GLOBALS['appshore_data']['layout'] = 'print';

		$this->defaultSessionApp('print_'.$this->appName);
		$result['recordset'] = $_SESSION['print_'.$this->appName];			

		return $result;
    }
    
	function pdfprint( $html)
	{
		require_once(APPSHORE_INCLUDES.SEP.'dompdf'.SEP.'dompdf_config.inc.php');

		$dompdf = new DOMPDF();
		$dompdf->load_html($html);
		$dompdf->render();
		return $dompdf->stream("sample.pdf");	
	}
    
    
}
