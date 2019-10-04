<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class base_search {

    function start()
    {

		$result = $this->quickSearch();

		return $result;
    } 


    function quickSearch()
    {
		$args = new safe_args();
		$args->set('key',NOTSET,'any');
		$args->set('criteria',NOTSET,'any');
		$args = $args->get(func_get_args());

        $GLOBALS['appshore']->add_xsl('lib.base');  
        //$GLOBALS['appshore']->add_xsl('lib.custom');  
        $GLOBALS['appshore']->add_xsl('lib.grid');  
        $GLOBALS['appshore']->add_xsl('lib.gridfields');  
        $GLOBALS['appshore']->add_xsl('base.search');  

		// define next action
		$result['action']['quicksearch'] = 'search';
		$args['criteria'] = filter_var(trim($args['criteria']), FILTER_SANITIZE_SPECIAL_CHARS);
		$_SESSION['temp']['quicksearch'] = $args['criteria'];
		//$_SESSION['temp']['quicksearch'] = stripslashes($args['criteria']);	
		$_SESSION['temp']['nbrecords'] = 100;		
		       
		if ( $args['criteria'] )
		{
	    	// record passage in history if criteria not null
			$GLOBALS['appshore']->history->setHistory( 'base.search.quicksearch', $args['criteria'], 'criteria='.$args['criteria'] );
		}
		
   		$result['text'] = 'No result'; 
   		
   		$apps = getManyAssocArrays('select * from db_applications where is_search = "Y" order by app_label'); 

		if( $apps )
		{

			// split the criteria in manies if needed
			$criterias = explode( ' ', preg_replace("|  +|", " ", preg_replace("|(\r\n){3,}|", "\r\n\r\n", trim($args['criteria']))));
			
			foreach( $criterias as $keycriteria => $valcriteria)
			{
				if( strlen($valcriteria) < 2 )
					unset($criterias[$keycriteria]);
			}
			
			if( count($criterias) > 5 )
			{
		   		$result['text'] = 'Your search sentence is too complex, please narrow it to a maximum of 5 words'; 
		   		return $result;
		   	}
			
			
			// scan available apps
			foreach( $apps as $keyapp => $valapp)
			{
				// find search fields per app
				$fields = getManyAssocArrays('select field_name from db_fields where app_name = "'.$valapp['app_name'].'" and table_name = "'.$valapp['table_name'].'" and is_search = "Y"');

/*
				if( $fields )
				{
					unset($where);
					foreach( $fields as $keyfield => $valfield)
					{
						if( $where )
	        				$where .= ' OR t0.'.$valfield['field_name'].' like "%'; 			
						else
	        				$where = ' (t0.'.$valfield['field_name'].' like "%';

						foreach( $criterias as $keycriteria => $valcriteria)
						{
							$where .= $valcriteria.'%'; 			
	        			}
						
						$where .= '"'; 			
					}
		        	$where .= ')';           	         	          

			        $result[$valapp['app_name']] = execMethod($valapp['app_name'].'.base.quicksearch',  $where, true);

			        if ( !$result[$valapp['app_name']]['results']  )
			        	unset( $result[$valapp['app_name']]);
			        else
			        {
				        $result['apps'][] = $valapp;
			        	unset( $result['text']) ;
			        }
				}
*/
				
				if( $fields )
				{
					unset($where);
					foreach( $fields as $keyfield => $valfield)
					{
						foreach( $criterias as $keycriteria => $valcriteria)
						{
							if( $where )
		        				$where .= ' OR t0.'.$valfield['field_name'].' like "%'.$valcriteria.'%" '; 			
							else
		        				$where = ' (t0.'.$valfield['field_name'].' like "%'.$valcriteria.'%" ';
	        			}
					}
		        	$where .= ')';           	         	          

			        $result[$valapp['app_name']] = execMethod($valapp['app_name'].'.base.quicksearch',  $where, true);

			        if ( !$result[$valapp['app_name']]['results']  )
			        	unset( $result[$valapp['app_name']]);
			        else
			        {
				        $result['apps'][] = $valapp;
			        	unset( $result['text']) ;
			        }
				}

	        }
	    }
		return $result;
    }

}
