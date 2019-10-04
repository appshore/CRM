<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class administration_sales_base extends lib_base
{
	var $res;

    function __construct()
    {
    	$this->appTable 		= 'users';
    	$this->appRecordId		= 'user_id';    	
    	$this->appRecordName	= 'user_name'; 
    	$this->appOrderBy		= 'user_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'administration_sales';
    	$this->appNameSingular	= 'administration_sale';    	
    	$this->appLabel 		= 'Sales organization';
    	$this->appLabelSingular = 'Sales organization';    
    	$this->appXSL	 		= 'administration.sales';
    	$this->appRole 			= 'administration';

		parent::__construct();
    }
	
	function menus()
	{
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl($this->appXSL);
		
		execMethod('administration.base.menus', '', true);

		$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Sales people', 'administration.sales_base.salesPeople');
		$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Sales teams', 'administration.sales_base.teams');
		$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Team members', 'administration.sales_base.assignUsersToTeams');
		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_ADMIN ) )			
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Quotas', 'administration.sales_base.setQuotas');
	}

	
    function start()
    {  
		$this->menus();		

		$result[$this->appName] = '';
		$result['action'][$this->appName] = 'start';
		$result['recordset'] = $_SESSION[$this->appName];
						
		return $result;
    }   
    
		
	// search and list sales
    function teams()
    {
		$args = new safe_args();
		$args->set('team_id',	NOTSET,'any');
		$args->set('key',		NOTSET,'any');
		$args->set('selected', 	NOTSET, 'any');		
		
		$args = $args->get(func_get_args());

 		$this->menus();	
 			 		
		switch($args['key'])
		{
			case 'Delete':
				$selected = explode( ',', $args['selected']);			
				foreach( $selected as $key => $val)
				{
					$team = getOneAssocArray( 'select * from sales_teams where team_id = "'.$val.'"');
					executeSQL( 'UPDATE sales_teams SET team_top_id = "'.$team['team_top_id'].'" WHERE team_top_id = "'.$team['team_id'].'"');					
					deleteRow( 'sales_teams', 'team_id', $team, false);
					deleteRow( 'sales_users', 'team_id', $team, false);										
				}	
				messagebox( MSG_DELETE, NOTICE);				
				break;
		} 	
					
		// retrieve the RBAC status of this user on this application
		$result['scope'] = ( $args['user_id'] )?$GLOBALS['appshore']->rbac->checkPermissionOnUser('administration', $args['user_id']):1 ;
		
		$result['sales'] = $this->getTeamsUsers();

		// define the related action for calling the right xsl template
		$result['action'][$this->appName] = 'teams';	
				
		// Put context in XML to be processed by XSL
		$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];
				
		return $result;
    } 
    
    
    function getTeamsUsers( $team_id = '0', $level = 0 )
    {
  		$team = getOneAssocArray( 'SELECT 
				sales_teams.team_name,
				sales_teams.team_top_id,
				sales_teams.team_id,								
				sales_teams.manager_id,												
				manager.full_name manager_full_name,
				manager.user_name manager_user_name
			FROM
				sales_teams
				LEFT OUTER JOIN users manager 
					ON sales_teams.manager_id = manager.user_id
			WHERE sales_teams.team_id = "'.$team_id.'"');  		
  		
  		if( $team['team_id'] )
  		{
  			$team['level'] =  $level;
  			$team['users'] = getManyAssocArrays( '
  				SELECT 
  					users.user_id, 
  					users.user_name, 
  					users.full_name 
  				FROM sales_users
				LEFT OUTER JOIN users 
					ON sales_users.user_id = users.user_id  				 
  				WHERE sales_users.team_id = "'.$team_id.'"');
  			$this->res[] = $team;
  		}
    
    	$nodes = getManyAssocArrays( 'select * from sales_teams where team_top_id = "'.$team_id.'" ORDER BY team_name ASC');
   	
    	if( isset($nodes) )
    		foreach( $nodes as $key => $value )
    			$this->getTeamsUsers( $value['team_id'], $level+1);
    			
    	return $this->res;
    }

	function salesPeople()
	{
		$args = new safe_args();
		$args->set('key', NOTSET, 'any');
		$args->set('selectedusers', NOTSET, 'any'); 
		$args = $args->get(func_get_args()); 

		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !$GLOBALS['appshore']->rbac->check('administration', RBAC_USER_WRITE ) )
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_WRITE_DENIED;
        }
		elseif (  $args['user_id'] && !$GLOBALS['appshore']->rbac->checkDataPermissions( 'administration', 'users', 'user_id', $args['user_id'] )	)
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_DENIED;
        }

 		switch($args['key'])
		{
			case 'Error':
				messagebox( $error, ERROR);
				break;
				
			case 'Save':
				$args['selectedusers'] = implode( '","', explode( ',', $args['selectedusers']));	
								
				executeSQL('UPDATE users set is_salespeople = "N" WHERE user_id not in ("'. $args['selectedusers'].'")');
				executeSQL('UPDATE users set is_salespeople = "Y" WHERE user_id in ("'. $args['selectedusers'].'")');	
			    messagebox( 'Sales People updated', NOTICE);					
				// NO Break	
				
			default:
				$result['users'] = getManyAssocArrays( 'select user_id, user_name, full_name from users where is_salespeople = "N" order by last_name');	
			    $result['salespeople'] = getManyAssocArrays( 'select user_id, user_name, full_name from users where is_salespeople = "Y" order by last_name');	
				break;	
		} 
			
		$this->menus();			

		// define the related action for calling the right xsl template
		$result['action'][$this->appName] = 'salesPeople';	
				
		// Put context in XML to be processed by XSL
		$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];
			
        return $result;
	}	
    
	function assignUsersToTeams()
	{
		$args = new safe_args();
		$args->set('key', NOTSET, 'any');
		$args->set('selectedteams', NOTSET, 'any'); 
		$args->set('selectedusers', NOTSET, 'any'); 
		$args = $args->get(func_get_args()); 

		//BMI: due to change of format
		$args['selectedteams'] = implode( '","', explode( ',', $args['selectedteams']));
		
		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !$GLOBALS['appshore']->rbac->check('administration', RBAC_USER_WRITE ) )
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_WRITE_DENIED;
        }
		elseif (  $args['user_id'] && !$GLOBALS['appshore']->rbac->checkDataPermissions( 'administration', 'users', 'user_id', $args['user_id'] )	)
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_DENIED;
        }

 		switch($args['key'])
		{
			case 'Error':
				messagebox( $error, ERROR);
				break;
				
			case 'Save':
					
				if ( isset($args['selectedteams'][0])) 
				{ 				
					// First we delete existing users assigned to selected team
					$sql = 'DELETE FROM sales_users 
						WHERE team_id in ("'. $args['selectedteams'].'")';
					$db = $GLOBALS['appshore']->db->execute( $sql);
					
					// then we insert the selected ones 
				    if ( isset($args['selectedusers'][0])) 
				    {	
					   $userids = explode(',', $args['selectedusers']); 
				   	    foreach ( $userids as $val => $curr)
                        {	
					       $sql = 'INSERT INTO sales_users VALUES("'.$args['selectedteams'].'","'.$curr.'")';
					       $db = $GLOBALS['appshore']->db->execute( $sql);
					    }
				    }

			    	messagebox( 'Team updated', NOTICE);					
				}
				// NO Break	
				
			default:
			
				$result['users'] = getManyAssocArrays( 'select user_id, user_name, full_name from users where is_salespeople = "Y" order by last_name');	
				$result['teams'] = $this->getTeamsUsers();
                
                if ( isset($args['selectedteams'][0])) 
				{	
				    $result['sales_users'] = getManyAssocArrays( 'select user_id from sales_users where team_id in("'.$args['selectedteams'].'")');	
				    $teamids = explode(',', $args['selectedteams']); 
				   	foreach ( $teamids as $val => $curr)
				   	    $result['selected'][]['team_id'] = $curr;
				}
				break;	
		} 

		$this->menus();			

		// define the related action for calling the right xsl template
		$result['action'][$this->appName] = 'assignUsersToTeams';	
				
		// Put context in XML to be processed by XSL
		$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];
			
        return $result;
	}	
	
	
	function setQuotas()
	{
		$args = new safe_args();
		$args->set('key', 			NOTSET, 'any');
		$args->set('fiscalyear', 	NOTSET, 'any');			
		$args->set('user_id', 		NOTSET, 'any');	
		// get from form the new quotas						
		for ( $i = 1 ; $i <= 12 ; $i++ )
			$args->set( 'amount_'.sprintf( '%02d', $i), 0, 'any');				
		$args = $args->get(func_get_args()); 
        
        /*
		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !$GLOBALS['appshore']->rbac->check('administration', RBAC_USER_WRITE ) )
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_WRITE_DENIED;
        }
		elseif (  $args['user_id'] && !$GLOBALS['appshore']->rbac->checkDataPermissions( 'administration', 'users', 'user_id', $args['user_id'] )	)
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_DENIED;
        } 
        */
        
			
		// get the first month of the company fiscal year
		$start = getOneAssocArray( 'select fiscal_year from company limit 1');
		$result['fiscalyear'] = $args['fiscalyear']?$args['fiscalyear']:date('Y');
						
		for ( $i = $start['fiscal_year'] ; $i < $start['fiscal_year']+12 ; $i++ )
		{
			$result['months'][] = array( 
				'month_id' => sprintf( '%02d' , ($i>12)?$i-12:$i), 
				'month_name' => lang(date('F',mktime(0,0,0,$i,1,$result['fiscalyear']))).' '.date('Y',mktime(0,0,0,$i,1,$result['fiscalyear']))
			);
			$months .= date('Y-m-d', mktime(0,0,0,$i,1,$result['fiscalyear'])).'","';
		}		
				        
		switch($args['key'])
		{
			case 'Error':
				messagebox( $error, ERROR);
				break;		
	
			case 'Save':

				// First we delete existing quotas for designed user
				$sql = 'DELETE FROM sales_quotas 
					WHERE month in ("'.$months.'") and user_id = "'. $args['user_id'].'"';
				$db = $GLOBALS['appshore']->db->execute( $sql);
					
				// then we insert the new ones 
				for( $i = $start['fiscal_year'] ; $i < $start['fiscal_year']+12 ; $i++ )	
				{
					
					$sql = 'INSERT INTO sales_quotas ( user_id, month, amount) VALUES ("'.$args['user_id'].'","'.date('Y-m-d', mktime(0,0,0, $i,1,$args['fiscalyear'])).'","'.$GLOBALS['appshore']->local->currencyToDecimal($args['amount_'.sprintf( '%02d' , ($i>12)?$i-12:$i)]).'")';
					$db = $GLOBALS['appshore']->db->execute( $sql);
				}

				messagebox('Quotas set','notice');
		
				// NO Break	
			default:
				$result['currency_id'] = $GLOBALS['appshore']->local->currencySymbol();					

				for ( $i = date('Y')-5 ; $i <= date('Y')+5 ; $i++ )
					$result['fiscalyears'][] = array( 'year' => $i);								

				$result['users'] = getManyAssocArrays( 'select user_id, user_name, full_name from users where is_salespeople = "Y" order by last_name');	
	
			   	$result['user_id'] = isset($args['user_id']) ? $args['user_id'] : $result['users'][0]['user_id'];

				$user_quotas = getManyAssocArrays( 'select date_format( month, "%m") as month_id, amount from sales_quotas where month in ("'.$months.'") and user_id = "'.$result['user_id'].'" order by month');	
				
				$i=1;$j=0;
				$quarter_amount = array() ;
				$year_amount = 0;
							
				foreach( $result['months'] as $key => $value)
				{
					if( $user_quotas )
						foreach( $user_quotas as $subkey => $subvalue)
							if( $subvalue['month_id'] == $value['month_id'] )
							{
								$result['months'][$key]['amount'] = $subvalue['amount'];
								$quarter_amount[$j] += $subvalue['amount'];
								$year_amount += $subvalue['amount'];
							}
							
					if( $i%3 == 0 )
					{
						$result['months'][$quarterly_key]['quarterly_amount'] = $GLOBALS['appshore']->local->decimalToCurrency($quarter_amount[$j++]);
						$result['months'][$quarterly_key]['quarter_name'] = $j;						
					}
									
					$quarterly_key = $key;
					
					$i++;
				}
				
				$i=1;$j=0;
				foreach( $result['months'] as $key => $value)
				{
					if( $year_amount != 0 ) 
						$result['months'][$key]['month_year_ratio'] = sprintf( '%02.2f', round($result['months'][$key]['amount']/$year_amount*100, 2));
					$quarter_ratio[$j] += $result['months'][$key]['month_year_ratio'];
					
					if( $quarter_amount[$j] != 0 ) 						
						$result['months'][$key]['month_quarter_ratio'] = sprintf( '%02.2f', round($result['months'][$key]['amount']/$quarter_amount[$j]*100, 2));
					$result['months'][$key]['amount'] = $GLOBALS['appshore']->local->decimalToCurrency($result['months'][$key]['amount']);
											
					if( $i%3 == 0 )
						$result['months'][$quarterly_key]['quarter_year_ratio'] = sprintf( '%02.2f', $quarter_ratio[$j++]);		
					
					$quarterly_key = $key;
										
					$i++;
				}				
				$result['yearly_amount'] = $GLOBALS['appshore']->local->decimalToCurrency($year_amount);
 						
				break;	
		} 

        $GLOBALS['appshore']->add_xsl('lib.form');			
		$this->menus();			

		// define the related action for calling the right xsl template
		$result['action'][$this->appName] = 'setQuotas';	
				
		// Put context in XML to be processed by XSL
		$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];
			
        return $result;
	}		
	
}
