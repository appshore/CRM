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

class administration_sales_popup {
	var $res;

    function administration_sales_popup()
    {
        $GLOBALS['appshore']->add_xsl('administration.base'); 
        $GLOBALS['appshore']->add_xsl('administration.sales_popup');
        $GLOBALS['appshore']->add_xsl('lib.base');

		$GLOBALS['appshore_data']['layout'] = 'popup';
		return $result;
	} 

   
    function getTeams( $avoid_team_id, $team_id = '0', $level = 0)
    {
  		$team = getOneAssocArray( 'SELECT 
				sales_teams.team_name,
				sales_teams.team_top_id,
				sales_teams.team_id
			FROM
				sales_teams
			WHERE team_id = "'.$team_id.'"');  		
  		
  		if( $team['team_id'] )
  		{
  			$team['level'] =  $level;
  			$this->res[] = $team;
  		}
    
    	$nodes = getManyAssocArrays( 'select * from sales_teams where team_top_id = "'.$team_id.'" ORDER BY team_name ASC');
   	
    	if( isset($nodes) )
    		foreach( $nodes as $key => $value )
    		{
    			if( $value['team_id'] != $avoid_team_id )
	    			$this->getTeams( $avoid_team_id, $value['team_id'], $level+1);
    		}
    			
    	return $this->res;
    }

	
	// edit or create one team
    function edit()
    {
		$args = new safe_args();
		$args->set( 'key', NOTSET, 'any');
		foreach( describeColumns('sales_teams') as $fieldName => $fieldValue )
			$args->set( $fieldName, NOTSET, 'any');	
		$args = $args->get(func_get_args()); 
		
 		switch($args['key'])
		{
			case 'Save':
	
				if ( $args['team_id'] != "") 			// UPDATE an existing team
					updateRow( 'sales_teams', 'team_id', $args);
				else 							// New team so we build an INSERT
					$args['team_id'] = insertRow( 'sales_teams', 'team_id', $args);
				// use to reload main window after some change
				$result['save'] = 'true';	
								
				// NO Break for 'Save' case		
			default:
				$GLOBALS['appshore_data']['layout'] = 'popup';	
				$result['action']['sales'] = 'edit';
				if ( $args['team_id']) 	// Edit existing team
					$result['team'] = $this->buildTeamView( $args['team_id'] );
					
				$result['users'] = getManyAssocArrays( 'select user_id, user_name, full_name from users where is_salespeople = "Y" order by last_name');
				$result['teams'] = $this->getTeams( $args['team_id'] );
					
				break;	
		} 

        return $result;
    } 	


	function buildTeamView( $team_id)
	{
		// retrieve the selected record
		$team = getOneAssocArray('
			SELECT 
				sales_teams.team_name,
				sales_teams.team_top_id,
				top_team.team_name top_team_name,
				sales_teams.team_id,								
				sales_teams.manager_id,												
				manager.full_name manager_full_name,
				manager.user_name manager_user_name
			FROM
				sales_teams
				LEFT OUTER JOIN users manager 
					ON sales_teams.manager_id = manager.user_id
				LEFT OUTER JOIN sales_teams top_team 
					ON sales_teams.team_top_id = top_team.team_id					
			WHERE sales_teams.team_id = "'.$team_id.'"'); 			

		return $team;
	}
	

}
