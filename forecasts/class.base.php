<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/

 
class forecasts_base 
{
	var $submenus ;

    function __construct()
    {    	
    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

    	// define the periods list
	    $this->submenus = array(    
	        array ( 'submenu_id' => 'monthly', 		'submenu_name' => lang('Monthly')),
	        array ( 'submenu_id' => 'quarterly', 	'submenu_name' => lang('Quarterly')),
	        array ( 'submenu_id' => 'yearly', 		'submenu_name' => lang('Yearly')),
	        array ( 'submenu_id' => 'custom', 		'submenu_name' => lang('Custom dates'))	        
	        );  
	        
        $GLOBALS['appshore']->add_xsl('forecasts.base');
        $GLOBALS['appshore']->add_xsl('forecasts.chart');
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl('lib.search');
        $GLOBALS['appshore']->add_xsl('lib.menus');
	}
    
    function start()
    {
		// First time that we start this app during the current session so we must init search criterias
		if (!isset($_SESSION['forecasts']))
		{
			// init some default value for filter criterias
			$this->setMonthlySession();
			$this->setQuarterlySession();
			$this->setYearlySession();
			$this->setCustomSession();	
		}

		switch( $_SESSION['forecasts']['action'] )
		{
			case 'custom':
				$result = $this->custom();			
				break;
			case 'quarterly':
				$result = $this->quarterly();			
				break;
			case 'yearly':
				$result = $this->yearly();			
				break;
			default:		
				$result = $this->monthly();			
				break;
		}

		// return the results to AppShore framework
		return $result;
    } 
    
    function setMonthlySession()
    {
		// Save context in cookie SESSION_SID
		$_SESSION['forecasts']['monthly']['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
		$_SESSION['forecasts']['monthly']['submenu_id'] = 'monthly';			
		$_SESSION['forecasts']['monthly']['month_id'] = date('n');				
		$_SESSION['forecasts']['monthly']['year'] = date('Y');				
		$_SESSION['forecasts']['monthly']['orderby'] = 'closing';
		$_SESSION['forecasts']['monthly']['ascdesc'] = 'ASC';
    }


	// Monthly forecasts
    function monthly()
    {
		$args = new safe_args();
		$args->set('key', 			NOTSET, 'any');
		$args->set('orderby', 		$_SESSION['forecasts']['monthly']['orderby'], 'any');
		$args->set('ascdesc', 		$_SESSION['forecasts']['monthly']['ascdesc'], 'any');
		$args->set('user_id', 		$_SESSION['forecasts']['monthly']['user_id'], 'any');
		$args->set('submenu_id', 	'monthly', 'any');		
		$args->set('month_id', 		$_SESSION['forecasts']['monthly']['month_id'], 'any');
		$args->set('year', 			$_SESSION['forecasts']['monthly']['year'], 'any');				
		$args->set('stage_id', 		$_SESSION['forecasts']['monthly']['stage_id'], 'any');
		$args->set('probability', 	$_SESSION['forecasts']['monthly']['probability'], 'any');
		$args = $args->get(func_get_args());	

		// add the needed XSl files
        $GLOBALS['appshore']->add_xsl('forecasts.monthly');        
	
		switch( $args['key'])
		{
			case 'Clear': // we reset some values
				unset( $args);
				$this->setMonthlySession();
				$args['submenu_id'] = $_SESSION['forecasts']['monthly']['submenu_id'];
				$args['user_id'] = $_SESSION['forecasts']['monthly']['user_id'];			
				$args['year'] = $_SESSION['forecasts']['monthly']['year'];			
				$args['month_id'] = $_SESSION['forecasts']['monthly']['month_id'];			
				$args['orderby'] = $_SESSION['forecasts']['monthly']['orderby'];			
				$args['ascdesc'] = $_SESSION['forecasts']['monthly']['ascdesc'];
				break;
		}
			
		// Check the data scope of current user
		if ( $GLOBALS['appshore']->rbac->check('forecasts', RBAC_ALL_READ ) )
			$clausewhere = ' WHERE 1=1 ';
		else
			$clausewhere = ' WHERE users.user_id in ( "'. implode( $GLOBALS['appshore']->rbac->usersList('forecasts'), '","') .'") ';

		$start_date = date('Y-m-d', mktime(0,0,0, $args['month_id'], 1, $args['year']));
		$end_date = date('Y-m-d', mktime(0,0,0, $args['month_id']+1, 0, $args['year']));
		
		$where = ' AND opportunities.closing between "'.$start_date.'" AND "'.$end_date.'" ';		

		// get these fields for search criterias form	
		$filters['users'] = getManyAssocArrays( 'select user_id, full_name, user_name from users '. $clausewhere. ' and is_salespeople = "Y" order by user_name');

		// we retrieve for each user requested his overall performance for the period
		if ($args['user_id'])
			$performance = $this->usersPerformance( $args['user_id'], $where, $start_date, $end_date);
		else		
			$performance = $this->usersPerformance( $filters['users'], $where, $start_date, $end_date);

		// These are extra filters only for detailed opportunities					
		if ($args['user_id'])
			$where .= ' AND users.user_id = "'.$args['user_id'].'" ';		
		if ($args['stage_id']) 
			$where .= ' AND stages.stage_id like "%'.$args['stage_id'].'%" ';
		if ($args['probability'] )
			$where .= ' AND opportunities.probability = "'.$args['probability'].'" ';
			
		// we retrieve the detailed list of opportunities plus total of amounts( expected, forecasted)
		$detailed = $this->listOpportunities( $clausewhere.$where, $args['orderby'], $args['ascdesc']);
		
		// get these fields for search criterias form	
		$filters['stages'] = getManyAssocArrays( 'select stage_id, stage_name from stages order by stage_id');
		$filters['submenus'] = $this->submenus;
		for ( $i = 1 ; $i <= 12 ; $i++ )
			$filters['months'][] = array( 'month_id' => $i , 'month_name' => lang(date('F', mktime(0,0,0, $i,1,2000))));
		for ( $i = date('Y')-5 ; $i <= date('Y')+5 ; $i++ )
			$filters['years'][] = array( 'year' => $i);
		for ( $i = 0 ; $i <= 100 ; $i += 10 )
			$filters['probabilities'][] = array( 'probability' => $i);
		

		// Session var to keep track of current state
		$_SESSION['forecasts']['monthly'] = array(
			'orderby' 			=> $args['orderby'],
			'ascdesc' 			=> $args['ascdesc'],
			'submenu_id'		=> $args['submenu_id'],			
			'month_id'			=> $args['month_id'],			
			'year'				=> $args['year'],						
			'user_id'			=> $args['user_id'],
			'stage_id'			=> $args['stage_id'],
			'probability'		=> $args['probability']		
			);
		// Put context 
		$context['recordset'] = $_SESSION['forecasts']['monthly'];
		// define next action
		$context['action']['forecasts'] = 'monthly';
		$_SESSION['forecasts']['action'] = 'monthly';	

		// we return all the different arrays that will constitute our XML stream
        return array_merge( $context, $filters, $performance, (array)$detailed);
    }
    
    function setQuarterlySession()
    {
		// Save context in cookie SESSION_SID
		$_SESSION['forecasts']['quarterly']['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
		$_SESSION['forecasts']['quarterly']['submenu_id'] = 'quarterly';			
		$_SESSION['forecasts']['quarterly']['month_id'] = date('n');				
		$_SESSION['forecasts']['quarterly']['year'] = date('Y');				
		$_SESSION['forecasts']['quarterly']['orderby'] = 'closing';
		$_SESSION['forecasts']['quarterly']['ascdesc'] = 'ASC';
    }


	// Monthly forecasts
    function quarterly()
    {
		$args = new safe_args();
		$args->set('key', NOTSET, 'any');
		$args->set('orderby', $_SESSION['forecasts']['quarterly']['orderby'], 'any');
		$args->set('ascdesc', $_SESSION['forecasts']['quarterly']['ascdesc'], 'any');
		$args->set('user_id', $_SESSION['forecasts']['quarterly']['user_id'], 'any');
		$args->set('submenu_id', 'quarterly', 'any');		
		$args->set('month_id', $_SESSION['forecasts']['quarterly']['month_id'], 'any');
		$args->set('year', $_SESSION['forecasts']['quarterly']['year'], 'any');				
		$args->set('stage_id', $_SESSION['forecasts']['quarterly']['stage_id'], 'any');
		$args->set('probability', $_SESSION['forecasts']['quarterly']['probability'], 'any');
		$args = $args->get(func_get_args());	

		// add the needed XSl files
        $GLOBALS['appshore']->add_xsl('forecasts.quarterly');        
	
		switch( $args['key'])
		{
			case 'Clear': // we reset some values
				unset( $args);
				$this->setQuarterlySession();
				$args['submenu_id'] = $_SESSION['forecasts']['quarterly']['submenu_id'];
				$args['user_id'] = $_SESSION['forecasts']['quarterly']['user_id'];			
				$args['year'] = $_SESSION['forecasts']['quarterly']['year'];			
				$args['month_id'] = $_SESSION['forecasts']['quarterly']['month_id'];			
				$args['orderby'] = $_SESSION['forecasts']['quarterly']['orderby'];			
				$args['ascdesc'] = $_SESSION['forecasts']['quarterly']['ascdesc'];
				break;
		}
			
		// Check the data scope of current user
		if ( $GLOBALS['appshore']->rbac->check('forecasts', RBAC_ALL_READ ) )
			$clausewhere = ' WHERE 1=1 ';
		else
			$clausewhere = ' WHERE users.user_id in ( "'. implode( $GLOBALS['appshore']->rbac->usersList('forecasts'), '","') .'") ';

		$start_date = date('Y-m-d', mktime(0,0,0, $args['month_id'], 1, $args['year']));
		$end_date = date('Y-m-d', mktime(0,0,0, $args['month_id']+3, 0, $args['year']));
		
		$where = ' AND opportunities.closing between "'.$start_date.'" AND "'.$end_date.'" ';		

		// get these fields for search criterias form	
		$filters['users'] = getManyAssocArrays( 'select user_id, full_name, user_name from users '. $clausewhere. ' and is_salespeople = "Y" order by user_name');

		// we retrieve for each user requested his overall performance for the period
		if ($args['user_id'])
			$performance = $this->usersPerformance( $args['user_id'], $where, $start_date, $end_date);
		else		
			$performance = $this->usersPerformance( $filters['users'], $where, $start_date, $end_date);

		// These are extra filters only for detailed opportunities					
		if ($args['user_id'])
			$where .= ' AND users.user_id = "'.$args['user_id'].'" ';		
		if ($args['stage_id']) 
			$where .= ' AND stages.stage_id like "%'.$args['stage_id'].'%" ';
		if ($args['probability'] )
			$where .= ' AND opportunities.probability = "'.$args['probability'].'" ';
			
		// we retrieve the detailed list of opportunities plus total of amounts( expected, forecasted)
		$detailed = $this->listOpportunities( $clausewhere.$where, $args['orderby'], $args['ascdesc']);

		// get the first month of the company fiscal year
		$start = getOneAssocArray( 'select fiscal_year from company limit 1');

		// get these fields for search criterias form	
		$filters['stages'] = getManyAssocArrays( 'select stage_id, stage_name from stages order by stage_id');
		$filters['submenus'] = $this->submenus;
		
		for ( $i = 0 ; $i < 12 ; $i += 3 )
		{
			$filters['quarters'][] = array( 
				'month_id' => $i+$start['fiscal_year'] , 
				'quarter_name' => 
					lang(date('F', mktime(0,0,0, $i+$start['fiscal_year'],1,$args['year']))).' '.date('Y', mktime(0,0,0, $i+$start['fiscal_year'],1,$args['year'])).' - '.
					lang(date('F', mktime(0,0,0, $i+$start['fiscal_year']+3,0,$args['year']))).' '.date('Y', mktime(0,0,0, $i+$start['fiscal_year']+3,0,$args['year']))
				);
		}
		
		for ( $i = date('Y')-5 ; $i <= date('Y')+5 ; $i++ )
			$filters['years'][] = array( 'year' => $i);
		for ( $i = 0 ; $i <= 100 ; $i += 10 )
			$filters['probabilities'][] = array( 'probability' => $i);
		

		// Session var to keep track of current state
		$_SESSION['forecasts']['quarterly'] = array(
			'orderby' 			=> $args['orderby'],
			'ascdesc' 			=> $args['ascdesc'],
			'submenu_id'		=> $args['submenu_id'],			
			'month_id'			=> $args['month_id'],			
			'year'				=> $args['year'],						
			'user_id'			=> $args['user_id'],
			'stage_id'			=> $args['stage_id'],
			'probability'		=> $args['probability']		
			);
		// Put context 
		$context['recordset'] = $_SESSION['forecasts']['quarterly'];
		// define next action
		$context['action']['forecasts'] = 'quarterly';
		$_SESSION['forecasts']['action'] = 'quarterly';			

		// we return all the different arrays that will constitute our XML stream
        return array_merge( $context, $filters, $performance, (array)$detailed);
	}


    function setYearlySession()
    {
		// Save context in cookie SESSION_SID
		$_SESSION['forecasts']['yearly']['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
		$_SESSION['forecasts']['yearly']['submenu_id'] = 'yearly';			
		$_SESSION['forecasts']['yearly']['year'] = date('Y');				
		$_SESSION['forecasts']['yearly']['orderby'] = 'closing';
		$_SESSION['forecasts']['yearly']['ascdesc'] = 'ASC';
    }


	// Monthly forecasts
    function yearly()
    {
		$args = new safe_args();
		$args->set('key', NOTSET, 'any');
		$args->set('orderby', $_SESSION['forecasts']['yearly']['orderby'], 'any');
		$args->set('ascdesc', $_SESSION['forecasts']['yearly']['ascdesc'], 'any');
		$args->set('user_id', $_SESSION['forecasts']['yearly']['user_id'], 'any');
		$args->set('submenu_id', 'yearly', 'any');		
		$args->set('year', $_SESSION['forecasts']['yearly']['year'], 'any');				
		$args->set('stage_id', $_SESSION['forecasts']['yearly']['stage_id'], 'any');
		$args->set('probability', $_SESSION['forecasts']['yearly']['probability'], 'any');
		$args = $args->get(func_get_args());	

		// add the needed XSl files
        $GLOBALS['appshore']->add_xsl('forecasts.yearly');        

		// get the first month of the company fiscal year
		$start = getOneAssocArray( 'select fiscal_year from company limit 1');
		$args['month_id'] = $start['fiscal_year'];		
		
		switch( $args['key'])
		{
			case 'Clear': // we reset some values
				unset( $args);
				$this->setYearlySession();
				$args['submenu_id'] = $_SESSION['forecasts']['yearly']['submenu_id'];
				$args['user_id'] = $_SESSION['forecasts']['yearly']['user_id'];			
				$args['year'] = $_SESSION['forecasts']['yearly']['year'];					
				$args['orderby'] = $_SESSION['forecasts']['yearly']['orderby'];			
				$args['ascdesc'] = $_SESSION['forecasts']['yearly']['ascdesc'];
				break;
		}
			
		// Check the data scope of current user
		if ( $GLOBALS['appshore']->rbac->check('forecasts', RBAC_ALL_READ ) )
			$clausewhere = ' WHERE 1=1 ';
		else
			$clausewhere = ' WHERE users.user_id in ( "'. implode( $GLOBALS['appshore']->rbac->usersList('forecasts'), '","') .'") ';

		$start_date = date('Y-m-d', mktime(0,0,0, $args['month_id'], 1, $args['year']));
		$end_date = date('Y-m-d', mktime(0,0,0, $args['month_id']+12, 0, $args['year']));
		
		$where = ' AND opportunities.closing between "'.$start_date.'" AND "'.$end_date.'" ';		

		// get these fields for search criterias form	
		$filters['users'] = getManyAssocArrays( 'select user_id, full_name, user_name from users '. $clausewhere. ' and is_salespeople = "Y" order by user_name');

		// we retrieve for each user requested his overall performance for the period
		if ($args['user_id'])
			$performance = $this->usersPerformance( $args['user_id'], $where, $start_date, $end_date);
		else		
			$performance = $this->usersPerformance( $filters['users'], $where, $start_date, $end_date);

		// These are extra filters only for detailed opportunities					
		if ($args['user_id'])
			$where .= ' AND users.user_id = "'.$args['user_id'].'" ';		
		if ($args['stage_id']) 
			$where .= ' AND stages.stage_id like "%'.$args['stage_id'].'%" ';
		if ($args['probability'] )
			$where .= ' AND opportunities.probability = "'.$args['probability'].'" ';
			
		// we retrieve the detailed list of opportunities plus total of amounts( expected, forecasted)
		$detailed = $this->listOpportunities( $clausewhere.$where, $args['orderby'], $args['ascdesc']);

		// get these fields for search criterias form	
		$filters['stages'] = getManyAssocArrays( 'select stage_id, stage_name from stages order by stage_id');
		$filters['submenus'] = $this->submenus;
			
		for ( $i = date('Y')-5 ; $i <= date('Y')+5 ; $i++ )
			$filters['years'][] = array( 'year' => $i);
		for ( $i = 0 ; $i <= 100 ; $i += 10 )
			$filters['probabilities'][] = array( 'probability' => $i);
		

		// Session var to keep track of current state
		$_SESSION['forecasts']['yearly'] = array(
			'orderby' 			=> $args['orderby'],
			'ascdesc' 			=> $args['ascdesc'],
			'submenu_id'		=> $args['submenu_id'],			
			'month_id'			=> $args['month_id'],			
			'year'				=> $args['year'],						
			'user_id'			=> $args['user_id'],
			'stage_id'			=> $args['stage_id'],
			'probability'		=> $args['probability']		
			);
		// Put context 
		$context['recordset'] = $_SESSION['forecasts']['yearly'];
		// define next action
		$context['action']['forecasts'] = 'yearly';
		$_SESSION['forecasts']['action'] = 'yearly';				

		// we return all the different arrays that will constitute our XML stream
        return array_merge( $context, $filters, $performance, (array)$detailed);
	}


    function setCustomSession()
    {
		// Save context in cookie SESSION_SID
		$_SESSION['forecasts']['custom']['user_id'] = $GLOBALS['appshore_data']['current_user']['user_id'];
		$_SESSION['forecasts']['custom']['submenu_id'] = 'custom';			
		$_SESSION['forecasts']['custom']['start_date'] = $GLOBALS['appshore']->local->dateToLocal( date('Y-m-d'));				
		$_SESSION['forecasts']['custom']['end_date'] = $GLOBALS['appshore']->local->dateToLocal( date('Y-m-d'));			
		$_SESSION['forecasts']['custom']['orderby'] = 'closing';
		$_SESSION['forecasts']['custom']['ascdesc'] = 'ASC';
    }


	// custom forecasts
    function custom()
    {
		$args = new safe_args();
		$args->set('key', NOTSET, 'any');
		$args->set('orderby', $_SESSION['forecasts']['custom']['orderby'], 'any');
		$args->set('ascdesc', $_SESSION['forecasts']['custom']['ascdesc'], 'any');
		$args->set('user_id', $_SESSION['forecasts']['custom']['user_id'], 'any');
		$args->set('submenu_id', 'custom', 'any');		
		$args->set('start_date', $_SESSION['forecasts']['custom']['start_date'], 'any');				
		$args->set('end_date', $_SESSION['forecasts']['custom']['end_date'], 'any');		
		$args->set('stage_id', $_SESSION['forecasts']['custom']['stage_id'], 'any');
		$args->set('probability', $_SESSION['forecasts']['custom']['probability'], 'any');
		$args = $args->get(func_get_args());	

		// add the needed XSl files
        $GLOBALS['appshore']->add_xsl('forecasts.custom');        

		switch( $args['key'])
		{
			case 'Clear': // we reset some values
				unset( $args);
				$this->setCustomSession();
				$args['submenu_id'] = $_SESSION['forecasts']['custom']['submenu_id'];
				$args['user_id'] = $_SESSION['forecasts']['custom']['user_id'];			
				$args['start_date'] = $_SESSION['forecasts']['custom']['start_date'];	
				$args['end_date'] = $_SESSION['forecasts']['custom']['end_date'];					
				$args['orderby'] = $_SESSION['forecasts']['custom']['orderby'];			
				$args['ascdesc'] = $_SESSION['forecasts']['custom']['ascdesc'];
				break;
		}
			
		// Check the data scope of current user
		if ( $GLOBALS['appshore']->rbac->check('forecasts', RBAC_ALL_READ ) )
			$clausewhere = ' WHERE 1=1 ';
		else
			$clausewhere = ' WHERE users.user_id in ( "'. implode( $GLOBALS['appshore']->rbac->usersList('forecasts'), '","') .'") ';

		$start_date = $GLOBALS['appshore']->local->localToDate($args['start_date']);
		$end_date = $GLOBALS['appshore']->local->localToDate($args['end_date']);
		
		$where = ' AND opportunities.closing between "'.$start_date.'" AND "'.$end_date.'" ';		

		// get these fields for search criterias form	
		$filters['users'] = getManyAssocArrays( 'select user_id, full_name, user_name from users '. $clausewhere. ' and is_salespeople = "Y" order by user_name');

		// we retrieve for each user requested his overall performance for the period
		if ($args['user_id'])
			$performance = $this->usersPerformance( $args['user_id'], $where, $start_date, $end_date);
		else		
			$performance = $this->usersPerformance( $filters['users'], $where, $start_date, $end_date);

		// These are extra filters only for detailed opportunities					
		if ($args['user_id'])
			$where .= ' AND users.user_id = "'.$args['user_id'].'" ';		
		if ($args['stage_id']) 
			$where .= ' AND stages.stage_id like "%'.$args['stage_id'].'%" ';
		if ($args['probability'] )
			$where .= ' AND opportunities.probability = "'.$args['probability'].'" ';
			
		// we retrieve the detailed list of opportunities plus total of amounts( expected, forecasted)
		$detailed = $this->listOpportunities( $clausewhere.$where, $args['orderby'], $args['ascdesc']);

		// get these fields for search criterias form	
		$filters['stages'] = getManyAssocArrays( 'select stage_id, stage_name from stages order by stage_id');
		$filters['submenus'] = $this->submenus;
		for ( $i = 0 ; $i <= 100 ; $i += 10 )
			$filters['probabilities'][] = array( 'probability' => $i);
		

		// Session var to keep track of current state
		$_SESSION['forecasts']['custom'] = array(
			'orderby' 			=> $args['orderby'],
			'ascdesc' 			=> $args['ascdesc'],
			'submenu_id'		=> $args['submenu_id'],			
			'start_date'		=> $args['start_date'],			
			'end_date'			=> $args['end_date'],								
			'user_id'			=> $args['user_id'],
			'stage_id'			=> $args['stage_id'],
			'probability'		=> $args['probability']		
			);
		// Put context 
		$context['recordset'] = $_SESSION['forecasts']['custom'];
		// define next action
		$context['action']['forecasts'] = 'custom';
		$_SESSION['forecasts']['action'] = 'custom';				

		// we return all the different arrays that will constitute our XML stream
        return array_merge( $context, $filters, $performance, (array)$detailed);
	}

	// join SQL query to retrieve forecasts according search criterias
	function usersPerformance( $users, $where, $start_date, $end_date)
	{
		$currency = $GLOBALS['appshore']->local->currencySymbol();
		
		if( !is_array( $users))
			$usersList[] = array( 'user_id' => $users) ;
		else
			$usersList = $users;
		
		foreach( $usersList as $key => $val )
		{
			$userInfos = getOneAssocArray( '
				SELECT user_id, user_name, first_names, last_name, full_name
				FROM users
				WHERE user_id = "'.$val['user_id'].'"' 
				);
				
			// done to get quota which is monthly
			$start_date[8] = '0';
			$start_date[9] = '1';
			$end_date[8] = '0';
			$end_date[9] = '1';			
									
			$userQuotas = getOneAssocArray( '
				SELECT sum(sales_quotas.amount) as sum_quota 
				FROM sales_quotas 
				WHERE sales_quotas.user_id = "'.$val['user_id'].'"
				AND sales_quotas.month between "'.$start_date.'" AND "'.$end_date.'" 				
				GROUP BY sales_quotas.user_id' 
				);
							
			$userAllOpportunities = getOneAssocArray( '
				SELECT 
					sum(expected_amount) sum_expected_amount,
					sum(expected_amount*probability/100) sum_forecasted_amount
				FROM
					opportunities
				WHERE user_id = "'.$val['user_id'].'" '. 
				$where. 
				'GROUP BY user_id' 
				);	

			$userWonOpportunities = getOneAssocArray( '
				SELECT 
					sum(expected_amount) sum_won_amount
				FROM
					opportunities
				WHERE probability = 100 
				AND stage_id = "100" 
				AND user_id = "'.$val['user_id'].'" '.
				$where. 
				'GROUP BY user_id' 
				);	

			$perf['total_performances']['quota'] += $userQuotas['sum_quota']; 
			$perf['total_performances']['sum_expected_amount'] += $userAllOpportunities['sum_expected_amount']; 
			$perf['total_performances']['sum_forecasted_amount'] += $userAllOpportunities['sum_forecasted_amount']; 
			$perf['total_performances']['sum_won_amount'] += $userWonOpportunities['sum_won_amount'];
				        
			$perf['performances'][] = array( 
				'user_id' 				=> $userInfos['user_id'],	        
				'user_name' 			=> $userInfos['user_name'],	        
				'full_name' 			=> $userInfos['full_name'],	        
				'first_names' 			=> $userInfos['first_names'],	
				'last_name' 			=> $userInfos['last_name'],									
				'quota' 				=> $GLOBALS['appshore']->local->decimalToCurrency( $userQuotas['sum_quota'], true, 0),	        
				'quota_int' 				=> $userQuotas['sum_quota'],	        
				'currency_id' 			=> $currency,	        
        		'sum_expected_amount' 	=> $GLOBALS['appshore']->local->decimalToCurrency( $userAllOpportunities['sum_expected_amount'], true, 0),	        
        		'sum_expected_amount_int' 	=> $userAllOpportunities['sum_expected_amount'],	        
        		'quota_vs_expected' 	=> ($userQuotas['sum_quota'])?(sprintf( '%3d', $userAllOpportunities['sum_expected_amount']/$userQuotas['sum_quota']*100).'%'):'0%',	        
        		'sum_forecasted_amount' => $GLOBALS['appshore']->local->decimalToCurrency( $userAllOpportunities['sum_forecasted_amount'], true, 0),
        		'sum_forecasted_amount_int' => $userAllOpportunities['sum_forecasted_amount'],
        		'quota_vs_forecasted' 	=> ($userQuotas['sum_quota'])?(sprintf( '%3d', $userAllOpportunities['sum_forecasted_amount']/$userQuotas['sum_quota']*100).'%'):'0%',
       			'sum_won_amount' 		=> $GLOBALS['appshore']->local->decimalToCurrency( $userWonOpportunities['sum_won_amount'], true, 0),
       			'sum_won_amount_int' 		=> $userWonOpportunities['sum_won_amount'],
       			'quota_vs_won' 			=> ($userQuotas['sum_quota'])?(sprintf( '%3d', $userWonOpportunities['sum_won_amount']/$userQuotas['sum_quota']*100).'%'):'0%'
       			);	        
        	
		}
		$perf['raw_total_performances'] = $this->getRawPerformances($perf['total_performances']);
		
				if( $perf['total_performances']['quota'] != 0 ) 					
	       	$perf['total_performances']['quota_vs_expected'] = sprintf( '%3d', $perf['total_performances']['sum_expected_amount']/$perf['total_performances']['quota']*100).'%';	        
       	$perf['total_performances']['sum_expected_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $perf['total_performances']['sum_expected_amount'], true, 0);	        

		if( $perf['total_performances']['quota'] != 0 ) 					
	       	$perf['total_performances']['quota_vs_forecasted'] = sprintf( '%3d', $perf['total_performances']['sum_forecasted_amount']/$perf['total_performances']['quota']*100).'%';	        
       	$perf['total_performances']['sum_forecasted_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $perf['total_performances']['sum_forecasted_amount'], true, 0);

		if( $perf['total_performances']['quota'] != 0 ) 					
	       	$perf['total_performances']['quota_vs_won'] = sprintf( '%3d', $perf['total_performances']['sum_won_amount']/$perf['total_performances']['quota']*100).'%';	        
       	$perf['total_performances']['sum_won_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $perf['total_performances']['sum_won_amount'], true, 0);
       	$perf['total_performances']['quota'] = $GLOBALS['appshore']->local->decimalToCurrency( $perf['total_performances']['quota'], true, 0);	        
		return $perf;
	}

	function getRawPerformances($perftotal)
	{
		if( $perftotal['quota'] != 0 ) 					
	       	$perftotal['quota_vs_expected'] = sprintf( '%3d', $perftotal['sum_expected_amount']/$perftotal['quota']*100);//in percent
		if( $perftotal['quota'] != 0 ) 					
	       	$perftotal['quota_vs_forecasted'] = sprintf( '%3d', $perftotal['sum_forecasted_amount']/$perftotal['quota']*100);//in percent
       	if( $perftotal['quota'] != 0 ) 					
	       	$perftotal['quota_vs_won'] = sprintf( '%3d', $perftotal['sum_won_amount']/$perftotal['quota']*100);//in percent
		$perftotal['checkvs_sum'] = $perftotal['quota_vs_expected']+$perftotal['quota_vs_won']+$perftotal['quota_vs_forecasted'];

		return $perftotal;
	}

	// join SQL query to retrieve forecasts according search criterias
	function listOpportunities( $where, $orderby = 'closing', $ascdesc = 'ASC')
	{
		$orderby = $orderby ? ('ORDER BY '.$orderby.' '.$ascdesc) : '';
		$sql = '
			SELECT 
				opportunities.opportunity_id,
				opportunities.opportunity_name,
				opportunities.probability,
				opportunities.expected_amount,
				opportunities.closing,
				opportunities.created,				
				accounts.account_name,
				accounts.account_id,				
				stages.stage_name,
				users.user_name, 
				users.full_name
			FROM
				opportunities
				LEFT OUTER JOIN accounts
					ON opportunities.account_id = accounts.account_id
				LEFT OUTER JOIN users
					ON opportunities.user_id = users.user_id
				LEFT OUTER JOIN stages
					ON opportunities.stage_id = stages.stage_id'.
			$where.$orderby;

		$db = executeSQL($sql);
	
		while( !$db->EOF)
		{
			$scope['scope'] = ''.($GLOBALS['appshore']->rbac->checkPermissionOnUser('opportunities', $db->fields['user_id']) )?1:0 ;
			$result['forecasts'][] = array_merge( $db->GetRowAssoc(false), $scope);				
			$db->MoveNext();
		}  	

		if ( is_array($result['forecasts']) )
		{		
			$currency = $GLOBALS['appshore']->local->currencySymbol();
	        foreach( $result['forecasts'] as $curr => $val )
	        {  
	        	$result['forecasts'][$curr]['forecasted_amount'] = $result['forecasts'][$curr]['expected_amount']*$result['forecasts'][$curr]['probability']/100;	

				$result['total']['expected_amount'] += $result['forecasts'][$curr]['expected_amount']; 
				$result['total']['forecasted_amount'] += $result['forecasts'][$curr]['forecasted_amount']; 
	        
				$result['forecasts'][$curr]['currency_id'] = $currency;	
				$result['forecasts'][$curr]['expected_amount_int'] =
					$result['forecasts'][$curr]['expected_amount'];
	        	$result['forecasts'][$curr]['expected_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['forecasts'][$curr]['expected_amount'], true, 0);
				$result['forecasts'][$curr]['forecasted_amount_int'] =
					$result['forecasts'][$curr]['forecasted_amount'];	        
	        	$result['forecasts'][$curr]['forecasted_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['forecasts'][$curr]['forecasted_amount'], true, 0);	        
	        	$result['forecasts'][$curr]['closing'] = $GLOBALS['appshore']->local->dateToLocal( $result['forecasts'][$curr]['closing']);	        
	        	$result['forecasts'][$curr]['stage_name'] = lang($result['forecasts'][$curr]['stage_name']);
	        	if( strtotime($result['forecasts'][$curr]['created']) > mktime(0, 0, 0, date("m"), date("d")-1, date("Y")) )  
	        		$result['forecasts'][$curr]['record_date'] = 'new'; 
	        	else if( strtotime($result['forecasts'][$curr]['closing']) <  mktime() &&  $result['forecasts'][$curr]['probability']  != 0 && $result['forecasts'][$curr]['probability']  != 100)    	
	        		$result['forecasts'][$curr]['record_date'] = 'expired'; 	        	
	        }

        	$result['total']['expected_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['expected_amount'], true, 0);	        
        	$result['total']['forecasted_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['forecasted_amount'], true, 0);
        }		
						
		$result['perstage'] = getManyAssocArrays( '
			SELECT
				stages.stage_name,				
				sum(expected_amount) sum_expected_amount_int,
				sum(expected_amount*probability/100) sum_forecasted_amount_int
			FROM
				opportunities
				LEFT OUTER JOIN users
					ON opportunities.user_id = users.user_id
				LEFT OUTER JOIN stages
					ON opportunities.stage_id = stages.stage_id'.
			$where. 
			'GROUP BY stages.stage_id' 
			);	

		$result['peruser'] = getManyAssocArrays( '
			SELECT
				users.full_name,
				sum(expected_amount) sum_expected_amount_int,
				sum(expected_amount*probability/100) sum_forecasted_amount_int
			FROM
				opportunities
				LEFT OUTER JOIN users
					ON opportunities.user_id = users.user_id'.
			$where. 
			'GROUP BY users.user_id' 
			);	

		return $result;
	}
	
}
