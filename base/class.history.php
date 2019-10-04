<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/


class base_history
{
	function setHistory( $opname, $label, $filter)
	{
		if( $label && $GLOBALS['appshore']->db )	// no need to keep operation without label
		{
			executeSQL('replace into history ( user_id, history_date, opname, label, filter) 
				VALUES ( "'.$GLOBALS['appshore_data']['current_user']['user_id'].'","'.date('Y-m-d H:i:s').'","'.
				$opname.'","'.$label.'","'.$filter.'")');
		}
	}

	// Get the last 10 items viewed by user
	function getHistory()
	{	
		if( $GLOBALS['appshore']->db )
		{
			$history = getManyAssocArrays('SELECT distinct label, opname, filter FROM history WHERE user_id = "'.
				$GLOBALS['appshore_data']['current_user']['user_id'].'" '.'ORDER BY history_date DESC LIMIT 10');
				
			if( $history) 	
			{
				foreach( $history as $key => $value)
				{
					
					list($history[$key]['name']) = explode( '.', $value['opname']);

					//$history[$key]['label'] = filter_var(trim($history[$key]['label']), FILTER_SANITIZE_SPECIAL_CHARS);
					$history[$key]['label_slash'] = filter_var(trim($history[$key]['label']), FILTER_SANITIZE_SPECIAL_CHARS);
					$history[$key]['label_short'] = mb_substr(trim($history[$key]['label']), 0, 16);

					$history[$key]['filter'] = filter_var(trim($history[$key]['filter']), FILTER_SANITIZE_SPECIAL_CHARS);
					$history[$key]['filter_slash'] = $history[$key]['filter'];
				}
			}
				
			return $history;				
		}
	}

	function removeFromHistory( $filter)
	{
		if( $GLOBALS['appshore']->db )
			executeSQL( 'delete from history where filter = "'.$filter.'"');
	}

	// truncate the 10 oldest views
	function truncateHistory()
	{	
		if( $GLOBALS['appshore']->db )
			executeSQL('DELETE FROM history WHERE date_add( history_date, interval 1 month) < curdate()');		
	}	
		
}// end of class

