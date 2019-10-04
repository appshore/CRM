<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/


class dashboards_base
{

    function start()
    {
        $GLOBALS['appshore']->add_xsl('lib.base');     
        $GLOBALS['appshore']->add_xsl('dashboards.base');
        
		// define next action		
		$result['action']['dashboard'] = 'dashboard';

		// we build the user's dashboard by selecting dashboard infos (columns, boxes, apps)
		// then we execute method related to each boxe to generate global xml stream
		
		for(  $colnum = 1 ; $colnum < 3 ; $colnum++)
		{
			$dashlets = getManyAssocArrays('SELECT db.*, dl.*
				FROM 
					dashboards db 
				LEFT OUTER JOIN global_dashlets dl
					ON db.dashlet_name = dl.dashlet_name
				WHERE
					db.user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'" 
					AND db.column_nbr = "'.$colnum.'" and dl.is_available = "Y"
					order by dashlet_sequence ASC');

			unset( $dashlet);
			
			if ( $dashlets )
			{			
				foreach( $dashlets as $key => $val )
				{
											
					// we retrieve list of dashlets then filter to eliminate those not allowed for the current user				
					if( $GLOBALS['appshore']->rbac->check( $val['app_name'], RBAC_RUN_APP) || !$val['app_name'] )
					{
					
						// test what kind of box we have here, dashboard or customized
						if( $val['template_path'])
						{
							$GLOBALS['appshore']->add_xsl($val['template_path']);
						}
						else
						{
					        $GLOBALS['appshore']->add_xsl($this->appXSL);
					        $GLOBALS['appshore']->add_xsl('lib.custom');         
					        $GLOBALS['appshore']->add_xsl('lib.grid');         
					        $GLOBALS['appshore']->add_xsl('lib.gridfields');         
						    $GLOBALS['appshore']->add_xsl('lib.dashboard');    
	   					}     

						if( $val['app_path'] == null )
							$val['app_path'] = $val['app_name'].'.dashboards.display';
							
						if( $val['app_name'] && $val['app_path'] )
						{
		        			$result['dashlet'][$val['dashlet_name']] = execMethod($val['app_path'], $val, true);		
		        		}		
						
						$dashlet[] = array( 
							'app_name' 			=> $val['app_name'],
							'dashlet_name' 		=> $val['dashlet_name'],
							'is_custom' 		=> $val['template_path']?'N':'Y',
							'app_path' 			=> $val['app_path'],
							'dashlet_label' 	=> $val['dashlet_label']														
							); 	
					}					        		
	        	}
	        }
				
			$result['dashboard']['columns'][$colnum] = array(
				'column_nbr'	=> $colnum, 
				'dashlets' 		=> $dashlet
				);   
		}

		$result['dashlets_available'] = getManyAssocArrays('SELECT * 
				FROM global_dashlets
				WHERE dashlet_name not in (
					select dashlet_name from dashboards 
					where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"
					)
				AND is_available  = "Y" order by app_name, dashlet_label ASC');

        return $result;
    }
    
    
    function getDashlet()
    {
        $GLOBALS['appshore']->add_xsl('lib.base');         											
        $GLOBALS['appshore']->add_xsl('dashboards.base');

		// we retrieve list of dashlets then filter to eliminate those not allowed for the current user				
		if( $GLOBALS['appshore']->rbac->check( $val['app_name'], RBAC_RUN_APP) == false )
			return null;
			
		// test what kind of box we have here, dashboard or customized
		if( $val['template_path'])
		{
			$GLOBALS['appshore']->add_xsl($val['template_path']);
		}
		else
		{
	        $GLOBALS['appshore']->add_xsl($this->appXSL);
	        $GLOBALS['appshore']->add_xsl('lib.custom');         
	        $GLOBALS['appshore']->add_xsl('lib.grid');         
	        $GLOBALS['appshore']->add_xsl('lib.gridfields');         
		    $GLOBALS['appshore']->add_xsl('lib.dashboard');    
		}     

		if( $val['app_path'] == null )
			$val['app_path'] = $val['app_name'].'.dashboards.display';
			
		if( $val['app_name'] && $val['app_path'] )
		{
			$result['dashlet'] = array( 
				'app_name' 				=> $val['app_name'],
				'dashlet_name' 			=> $val['dashlet_name'],
				'is_custom' 			=> $val['template_path']?'N':'Y',
				'app_path' 				=> $val['app_path'],
				'dashlet_label' 		=> $val['dashlet_label'],
				$val['dashlet_name']	=> execMethod($val['app_path'], $val, true)								
				); 
		}

		$result['action']['dashboard'] = 'dashlet';

        return $result;
    }


}
