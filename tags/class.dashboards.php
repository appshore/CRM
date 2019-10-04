<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class tags_dashboards 
{
	
	function cloud()
	{	
		$tags = getManyAssocArrays('SELECT tags.tag_id, tag_name, count(tr.tag_id) tag_count FROM tags, tags_records tr WHERE tags.tag_id = tr.tag_id and user_id = "'.
			$GLOBALS['appshore_data']['current_user']['user_id'].'" '.' GROUP BY tag_name');
			
		$max = $min = 0;
		foreach( $tags as $key => $value )
		{
			if( $value['tag_count'] > $max )
				$max = $value['tag_count'] ;
			if( $value['tag_count'] < $min )
				$min = $value['tag_count'] ;
		}
		
		$spread = $max - $min ;
		if ($spread == 0)
			$spread = 1;
        
        // set the font-size increment
        $max_size = 28; // max font size in pixels
        $min_size = 8; // min font size in pixels
        $step = ($max_size - $min_size) / $spread;
       
        foreach( $tags as $key => $value ) 
        {
			$tags[$key]['tag_size'] = ceil($min_size + (($value['tag_count'] - $min) * $step));
        }

			
		return $tags;				
	}         
    
}
