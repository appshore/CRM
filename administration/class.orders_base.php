<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once ( 'class.base.php');

class administration_orders_base extends administration_base {

    function __construct()
    {
    	$this->appTable 		= 'company_orders';
    	$this->appRecordId		= 'order_id';    	
    	$this->appRecordName	= 'product_name'; 
    	$this->appOrderBy		= 'created';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'administration_orders';
    	$this->appNameSingular	= 'administration_order';    	
    	$this->appLabel 		= 'Orders';
    	$this->appLabelSingular = 'Order';    
    	$this->appXSL	 		= 'administration.orders';
    	$this->appRole 			= 'administration';
    }

    
    function menus()
    {
		parent::menus();   
    	
        $GLOBALS['appshore']->add_xsl($this->appXSL);    

		$GLOBALS['appshore']->add_appmenu('Company', 'Information', 'administration.company_base.view');
				
		if ( $GLOBALS['appshore']->rbac->check('administration', RBAC_ADMIN ) )
        {		
			//$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Email configuration', 'administration.emailer.view');        	
			$GLOBALS['appshore']->add_appmenu('Company', 'Usage statistics', 'administration.statistics.start');
						
			if( CUSTOMER_NAME == 'AppShore' && PRIVATE_LABEL == '' )
			{
				$GLOBALS['appshore']->add_appmenu('Company', 'Your orders', 'administration.orders_base.start');
				//$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Your invoices', 'administration.invoices_base.start');									
				$GLOBALS['appshore']->add_appmenu('Company', 'Upgrade AppShore', 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
			}
		}

	}     
    
    
    function start()
    {  
		return $this->search();
    }   
    
		
    function search( $args = null)
    {
		$result = parent::search( $args);	
		
		// forbid edit
		$result['scope'] = 0;

		foreach( $result[$this->appName] as $key => $val)
		{
			$result[$this->appName][$key]['scope'] = 0;
			//$result[$this->appName][$key]['disk_quota'] = getfilesize($val['disk_quota']);
		}

		return $result;	
    } 	    
    	
	// view one profile
    function view( $args)
    {
		$result = parent::view( $args);	
			
		$result['scope'] = 0;
		
		return $result;
    } 	
    
	// view one profile
    function edit( $args)
    {
    	unset($args['key']);
		return parent::view( $args);	
    } 	           
    
}
