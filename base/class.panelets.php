<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class base_panelets
{

	function getPanelets()
	{	
		return getManyAssocArrays('SELECT * FROM panelets 
			WHERE user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" 
			ORDER BY panelet_sequence');
	}
	
	function availablePanelets()
	{	
		return getManyAssocArrays('SELECT * FROM global_panelets 
			WHERE panelet_name not in 
				(select panelet_name from panelets where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'") 
			ORDER BY panelet_label');
	}
	
	function runPanelets()
	{	
		$panelets = getManyAssocArrays('SELECT gp.*, p.is_open, p.panelet_sequence 
			FROM global_panelets gp 
			LEFT outer join panelets p on p.panelet_name = gp.panelet_name 
			WHERE p.user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" 
			ORDER BY p.panelet_sequence');

    	$result['available'] = $this->availablePanelets();

		if ( $panelets == null )
			return $result;
			
		foreach( $panelets as $key => $val )
		{
								
			// we retrieve list of panelets then filter to eliminate those not allowed for the current user				
			if(  $val['app_path'] )
			{
				if(  $GLOBALS['appshore']->rbac->check( $val['app_name'], RBAC_RUN_APP) )
				{			
					// test what kind of box we have here, panel or customized
					if( $val['template_path'])
						$GLOBALS['appshore']->add_xsl($val['template_path']);
			
					$result[$val['panelet_name']] = execMethod($val['app_path'], $val, true);	
				}
				else
					continue;
			}
			
			$result['used'][] = array( 
				'panelet_name' 		=> $val['panelet_name'],
				'panelet_label' 	=> $val['panelet_label'],
				'is_open' 			=> ($val['is_open']=='Y')?'block':'none',
				'panelet_sequence' 	=> $val['panelet_sequence']
				); 	
		}
    	
    	return $result;
	}	
	
}
