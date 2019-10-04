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

// class meeting extends activities so requires it
require_once ( 'class.billing.php');

class administration_billing_invoices extends administration_billing 
{


    function __construct()
    {
		// we call the parent class
	    parent::__construct();  
	} 
   
    function start()
    {  	 	               
		// Synchronization with server central no more than one time a one day
		if (!isset($_SESSION['billing']['synchronization'] )) 
		{
			// Save context in cookie SESSION_SID
			$_SESSION['billing']['synchronization'] = true;
			$this->synchronization();
		}  	
		           
		// First time that we start this app during the current session so we must init search criterias
		if (!isset($_SESSION['invoices']['search'])) 
		{
			// Save context in cookie SESSION_SID
			$_SESSION['invoices']['search']['invoice_id'] = '';		
			$_SESSION['invoices']['search']['appOrderBy'] = 'created';
			$_SESSION['invoices']['search']['appAscDesc'] = 'DESC';
		}    
		$_SESSION['invoices']['search']['first'] = 0;   
		$_SESSION['invoices']['search']['currentVal'] = 0;   
		$_SESSION['invoices']['search']['countMax'] = 0;   
	

		$result = $this->search();

		return $result;
    }     
    
	// search and list customers
    function search()
    {
		$args = new safe_args();
		$args->set('key', 				NOTSET, 'any');
		$args->set('selected', 			NOTSET, 'any');
		$args->set('nbrecords', 		NOTSET, 'any');				
		$args->set('currentVal', 		$_SESSION['invoices']['search']['currentVal'], 'any');
		$args->set('countMax', 			$_SESSION['invoices']['search']['countMax'], 'any');
		$args->set('first', 			$_SESSION['invoices']['search']['first'], 'any');
		$args->set('orderby', 			$_SESSION['invoices']['search']['appOrderBy'], 'any');
		$args->set('ascdesc', 			$_SESSION['invoices']['search']['appAscDesc'], 'any');
		$args->set('invoice_id', 		$_SESSION['invoices']['search']['invoice_id'], 'any');
		$args->set('order_id', 			$_SESSION['invoices']['search']['order_id'], 'any');		
		$args->set('invoice_status', 	$_SESSION['invoices']['search']['invoice_status'], 'any');		
		$args = $args->get(func_get_args());

        $GLOBALS['appshore']->add_xsl('administration.billing_invoices');
		execMethod('administration.company.menus', $args, true);
		   	    
		$currentVal = $args['currentVal'];
		$countMax = $args['countMax'];
		$first = $args['first'];    	    	

 		switch($args['key'])
		{
			case 'Clear':
				unset($_SESSION['invoices']['search']);
				unset($args['order_id']);						
				unset($args['invoice_id']);
				unset($args['invoice_status']);				
				// No Break
			case 'Search':				
				$args['ascdesc'] ='DESC';				
				$args['orderby'] ='created';
				// No Break		
			case 'Next':
			case 'Previous':
			case 'Last':
			case 'First':
				setPosition( $currentVal, $countMax, $first, $args['key']);
				break;	
			case 'NbRecords':
				$GLOBALS['appshore_data']['current_user']['nbrecords'] = $args['nbrecords'];
				execMethod( 'preferences.lookandfeel_base.setNbRecords', null, true); 
				setPosition( $currentVal, $countMax, $first, $args['key']);
				break;						
		} 

		$where = ' WHERE 1 = 1';
		if ($args['order_id'] ) 
			$where .= ' AND company_invoices.order_id = "'.$args['invoice_id'].'" ';					
		if ($args['invoice_id'] ) 
			$where .= ' AND company_invoices.invoice_id = "'.$args['invoice_id'].'" ';	
		if ($args['invoice_status'] ) 
			$where .= ' AND company_invoices.invoice_status = "'.$args['invoice_status'].'" ';			
		if ($args['creation'] ) 
		{
	    	$p['1'] = '>= "'.date('Y-m-d', mktime(0, 0, 0, date("m"), 1, date("Y"))).'" ';	    	
	    	$p['2'] = 'like "'.date('Y-m', mktime(0, 0, 0, date("m")-1, 1, date("Y"))).'%" ';	    	
	    	$p['3'] = '>= "'.date('Y-m-d', mktime(0, 0, 0, date("m")-2, 1, date("Y"))).'" ';
	    	$p['4'] = '>= "'.date('Y-m-d', mktime(0, 0, 0, 1, 1, date("Y"))).'" ';	 	    	
			$where .= ' AND company_invoices.created '.$p[$args['creation']].' ';													
		}			
			
		// search the db
		$result['invoices'] = $this->searchAndList( $where, $args['orderby'], $args['ascdesc'], $first, $currentVal, $countMax);

		// Save context in cookie SESSION_SID
		$_SESSION['invoices']['search']['countMax'] 		= $countMax;
		$_SESSION['invoices']['search']['currentVal'] 		= $currentVal;
		$_SESSION['invoices']['search']['first'] 			= $first;
		$_SESSION['invoices']['search']['appOrderBy'] 		= $args['orderby'];
		$_SESSION['invoices']['search']['appAscDesc'] 		= $args['ascdesc'];
		$_SESSION['invoices']['search']['invoice_id']		= $args['invoice_id'];	
		$_SESSION['invoices']['search']['order_id']			= $args['order_id'];			
		$_SESSION['invoices']['search']['invoice_status']	= $args['invoice_status'];	
		$_SESSION['invoices']['search']['creation']			= $args['creation'];				

		// Put context in XML to be processed by XSL
		$result['recordset'] = $_SESSION['invoices']['search'];
		
		// get these fields for search criterias form
		$result['invoice_statuses'] = $this->invoice_statuses;
		$result['creations'] = $this->creations;		
		$result['nbrecords'] = array(array('nbrecords'=>10),array('nbrecords'=>15),array('nbrecords'=>20),array('nbrecords'=>25),array('nbrecords'=>30),array('nbrecords'=>35),array('nbrecords'=>40),array('nbrecords'=>45),array('nbrecords'=>50));
				
		// define next action
		$result['action']['invoices'] = 'search';

        return $result;
    }
    

    function view()
    {
		$args = new safe_args();
		$args->set('invoice_id', NOTSET,'any');
		$args->set('key',NOTSET,'any');

		$args = $args->get(func_get_args());


        $GLOBALS['appshore']->add_xsl('administration.billing_invoices');
        $GLOBALS['appshore']->add_xsl('administration.billing_orders');
		execMethod('administration.company.setMenus', $args, true);		            
        
		if( !isset($args['invoice_id']))
		{
			$args['key'] = 'Error';
		}
		

		switch($args['key'])
		{
			case 'Error':
				$result = $this->search( $args);
				break;

			default:
				$result['invoice'] = $this->buildInvoiceView( $args['invoice_id']);
				
				$order = execMethod( 'administration.billing_orders.view', $result['invoice'], true);
				$result['order'] = $order['order'];			
	        	
	        	// record passage in history
				$GLOBALS['appshore']->history->setHistory( 'administration.billing_invoices.view', $result['invoice']['subject'], 'invoice_id='.$args['invoice_id']);

				// scope is set to 0 or 1 means READ_ONLY or READ_WRITE
				// xsl file will test this value to display or not edit/delete/copy buttons
				$result['scope'] = $GLOBALS['appshore']->rbac->checkPermissionOnUser('administration', $result['invoice']['user_id']) ;
                $result['action']['invoices'] = 'view';
				break;
		}
		$GLOBALS['appshore']->setContext( 'submenu_id', 'invoices');

		return $result;
    }


	// join SQL query to retrieve customers according search criterias
	function searchAndList( $where = ' WHERE 1=1 ' , $orderby = 'created', $ascdesc = 'DESC', &$first, $currentVal, &$countMax )
	{	
		$db = $GLOBALS['appshore']->db->execute('
			SELECT 
				company_invoices.*
			FROM
				company_invoices '.
			$where.'
			AND company_invoices.company_id = "'.$GLOBALS['appshore_data']['my_company']['company_id'].'" 					
			ORDER BY '.$orderby.' '.$ascdesc
			);	
	
		$db->Move($currentVal);    
		$countMax = $db->RowCount();
			
		while( !$db->EOF && $nbr < $GLOBALS['appshore_data']['current_user']['nbrecords'])
		{
		    if ( $db->fields['invoice_status'] )
                $invoice_status = searchArray( $this->invoice_statuses, 'invoice_status',  $db->fields['invoice_status'] );
               
            if( $db->fields['first_month'] == 'N' )
				$items = getManyAssocArrays( 'select * from company_orders where order_id= "'.$db->fields['order_id'].'" and period = "per month" order by sequence');	
			else
				$items = getManyAssocArrays( 'select * from company_orders where order_id= "'.$db->fields['order_id'].'" order by sequence');	
 			unset($count);
			foreach ( $items as $key => $val)
			{
				$count['amount'] += $val['users_quota']*$val['price'];
				
				if( $count['items']++ > 0 ) 
					$count['product_name'] = $count['product_name'].', '.$val['product_name'];		
				else
					$count['product_name'] = $val['product_name'];
			}	
			
			$count['amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $count['amount'], true, 0);					
			               		
			//$db->fields['created'] = $GLOBALS['appshore']->local->localToDate( $db->fields['created'] );
			
			$invoice = $db->GetRowAssoc(false);
			$invoice['first_month'] = ( $invoice['first_month'] == 'Y')?'Yes':'No';
                		
			$result['invoices'][] = array_merge( (array)$invoice, (array)$invoice_status, (array)$count);				
				
			$db->MoveNext();
			$nbr++;
		}  	

		$first = $currentVal + $nbr ;
		return $result['invoices'];
	}
	
	function buildInvoiceView( $invoice_id)
	{
		// retrieve the selected record
		$invoice = getOneAssocArray( 'select * from company_invoices where invoice_id= "'.$invoice_id.'" AND company_id = "'.$GLOBALS['appshore_data']['my_company']['company_id'].'"');	

		$invoice['created'] = $GLOBALS['appshore']->local->gmtToTZLocal( $invoice['created']);	        
		$invoice['updated'] = $GLOBALS['appshore']->local->gmtToTZLocal( $invoice['updated']);	               
		
		// get these datas to replace id's by names 		
		if ($invoice['invoice_status'])		
			$invoice_status = searchArray( $this->invoice_statuses, 'invoice_status',  $invoice['invoice_status'] );			
			             
        if( $invoice['first_month'] == 'N' )
			$amount = getOneAssocArray( 'select sum(price*users_quota) as amount from company_orders where order_id= "'.$invoice['order_id'].'" and period = "per month"');	
		else
			$amount = getOneAssocArray( 'select sum(price*users_quota) as amount from company_orders where order_id= "'.$invoice['order_id'].'"');	
		
		$invoice['first_month'] = ( $invoice['first_month'] == 'Y')?'Yes':'No';
		
		$amount['amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $amount['amount'], true, 0);
		
		// merge all arrays to build up invoice branch in XML stream
		return array_merge((array)$invoice, (array)$company, (array)$invoice_status, (array)$amount);	
	}    

}
