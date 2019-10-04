<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/


require_once ( 'class.customization.php');

class administration_customization_translation extends administration_customization{
	
    function start()
    {  
		return $this->edit();		
    } 
    	
	// view one customization
    function edit()
    {
		$args = new safe_args();
		$args->set('selected', 		NOTSET, 'any');
		$args->set('key',			NOTSET,'any');
		$args->set('language_id',	$GLOBALS['appshore_data']['current_user']['language_id'],'any');		
		$args->set('character',		'A','any');		


		// Allow to retrieve all the cols from this table
		for( $i = 0 ; $i < 200 ; $i++ )
		{
			$args->set( 'phrase_'.$i,	NOTSET,	'any');
			$args->set( 'target_'.$i,	NOTSET,	'any');
		}
		$args = $args->get(func_get_args());

 		$count_args = ((count($args)-4)/2);
		

		$this->menus();
        $GLOBALS['appshore']->add_xsl('administration.customization_translation');    			

		if( checkEdition(true) == false )
			unset($args['key']);

		switch($args['key'])
		{
			case 'Delete':
				$selected = explode( ',', $args['selected']);				  
				foreach( $selected as $key => $val)
				{
            		$line['phrase'] = $args['phrase_'.$val];
					deleteRow('translation', 'phrase', $line, false);
				}						
				messagebox( MSG_DELETE, NOTICE);					
				break;
				
			case 'Save':
			
				// Allow to retrieve all the cols from this table
				for( $i = 0 ; $i < $count_args ; $i++ )
				{
					if( $args['target_'.$i])
					{
		            	$line['phrase'] = $args['phrase_'.$i];
		            	$line[$args['language_id']] = $args['target_'.$i];
		            	$target = getOneAssocArray('select `'.$args['language_id'].'` target from translation where phrase = "'.$args['phrase_'.$i].'"');
		            	$source = getOneAssocArray('select `'.$args['language_id'].'` source from global_translation where phrase = "'.$args['phrase_'.$i].'"');
		            	if( $target )
		            	{
		            		if( $source['source'] == $target['target'] || $source['source'] == $args['target_'.$i] )
				            	$line[$args['language_id']] = '';
							updateRow( 'translation', 'phrase', $line, false);
						}
		            	else if( $source['source'] != $args['target_'.$i] )
							insertRow( 'translation', 'phrase', $line, false);								
					}
				}

				$languages = getManyAssocArrays('select language_id from global_languages where is_available = "Y" order by language_id');

				foreach( $languages as $key => $val )
					$sql .= '`'.$val['language_id'].'` = "" and ';			
				executeSQL( 'delete from translation where '.$sql.'1=1');

				// the custom translation in cache needs to be updated so we flag it outdated
				$GLOBALS['appshore']->trans->outdateltrs();	
				
				messagebox( MSG_UPDATE, NOTICE);					
				break;
		}
		

		// build the filter list on character
		$result['character'] = $args['character'];
		$result['characters'][]['char'] = '#';
		for( $i = 0; $i < 26; $i++)
			$result['characters'][]['char'] = chr(65+$i);
			
		// retrieve the language name from the list
		$result['language'] = getOneAssocArray('select  * from global_languages where language_id = "'.$args['language_id'].'" and is_available = "Y"');
		if ( $result['language'] == null )
			unset( $args['language_id']);

		if( $args['language_id'])
		{

			// retrieve the translation according the character selected
			// @a is used to generate a fictitious rowid for each line
			executeSQL('SET @a := 0');	
					
			if( $args['character'] == '#' ) // all non alpha characters
				$filter = 'substring(tr.phrase,1,1) not between "A" and "Z" order by tr.phrase';			
			else
				$filter = 'tr.phrase like "'.$args['character'].'%" order by tr.phrase';

			$result['translation'] = getManyAssocArrays('
				select tr.phrase, gt.phrase source_phrase, gt.`'.$args['language_id'].'` as source, tr.`'.$args['language_id'].'` as target, (@a:=@a+1) as rowid, "0" as scope 
				from translation_view tr left outer join global_translation gt on tr.phrase = gt.phrase
				where tr.is_template = "N" and '.$filter);
				
			// case of custom words added by customer, we make them editable
			foreach( $result['translation'] as $key => $val )
				if( !$val['source'] && ($val['phrase'] != $val['source_phrase']) )
					$result['translation'][$key]['scope'] = '1';

			// add 10 empty lines to allow custom translation by customer
			$rowid = count($result['translation'])+1;
			for( $i = 0; $i < 10; $i++)
				$result['translation'][] = array(
					'phrase' => '', 
					'source' => '', 
					'target' => '', 
					'rowid' => $rowid+$i, 
					'scope' => '1');
		} 
		
		// retrieve language list
		$result['languages'] = getManyAssocArrays('select * from global_languages where is_available = "Y" and google_language_code not in ("") order by language_id');					

		// scope is set to 0 or 1 means READ_ONLY or READ_WRITE
		// xsl file will test this value to display or not edit/delete/copy buttons
		$result['scope'] = ($GLOBALS['appshore']->rbac->checkPermissionOnUser('administration', $result['administration']['user_id']))?1:0;

		$result['action']['customization'] = 'translation';			

		return $result;
    } 	
 

}
