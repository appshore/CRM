<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/
 
class administration_billing 
{
	var $company_statuses ;		
	var $order_statuses ;		
	var $invoice_statuses ;	
	var $creations ;	

    function __construct()
    {            
        // this place needs to be clean when it's called by others apps
	    $this->company_statuses = array(
	        array ( 'company_status' => 'INT', 'company_status_name' => 'Internal'),
	        array ( 'company_status' => 'REG', 'company_status_name' => 'Registered'),
	        array ( 'company_status' => 'ACT', 'company_status_name' => 'Activated'),
	        array ( 'company_status' => 'CLO', 'company_status_name' => 'Closed'),
	        array ( 'company_status' => 'HEL', 'company_status_name' => 'Held')
	        );    	
	        
	    $this->order_statuses = array(
	        array ( 'order_status' => 'ACT', 'order_status_name' => 'Active')
	        ,array ( 'order_status' => 'CAN', 'order_status_name' => 'Cancelled')
	        //,array ( 'order_status' => 'CHE', 'order_status_name' => 'Checkout')	        
	        //,array ( 'order_status' => 'HEL', 'order_status_name' => 'Held')
	        );  	        
	        
	    $this->invoice_statuses = array(
	        array ( 'invoice_status' => 'PAI', 'invoice_status_name' => 'Paid'),
	        array ( 'invoice_status' => 'CAN', 'invoice_status_name' => 'Cancelled'),
	        array ( 'invoice_status' => 'REF', 'invoice_status_name' => 'Refunded'),
	        array ( 'invoice_status' => 'DUE', 'invoice_status_name' => 'Due')
	        );  	  	        
	        	        
	    $this->creations = array(                
	        array ( 'creation' => '1', 	'creation_name' => 'This month'),	        	        	        
	        array ( 'creation' => '2', 	'creation_name' => 'Last month'),	        
	        array ( 'creation' => '3', 	'creation_name' => 'Past three months'),
	        array ( 'creation' => '4', 	'creation_name' => 'This year')
	        ); 	  
	                    
    }
            
       
	function synchronization()
	{   	
		$last_order = GetOneAssocArray(' select updated from company_orders where company_id = "'.$GLOBALS['appshore_data']['my_company']['company_id'].'" order by updated desc limit 1'); 
		$last_invoice = GetOneAssocArray(' select updated from company_invoices where company_id = "'.$GLOBALS['appshore_data']['my_company']['company_id'].'" order by updated desc limit 1'); 
		
		include_once( APPSHORE_INCLUDES . SEP . 'nusoap' . SEP . 'nusoap.php');

		// initiate soap client
		$soap_client = new nusoapclient('http://'.BACKOFFICE_SERVER.'/soap.php');
				
		// log in the server		
		$soap_client->call( 'base.auth.login', array( 'appshore_user'=> BACKOFFICE_USERNAME, 'appshore_pass'=> BACKOFFICE_PASSWORD));
				
		// retrieve the SID of the soap transaction
		$soap_clientSID = $soap_client->return['sid'];		
		
		// retrieve current company information
		$soap_client->call( 'shop.synchronization.getOrders', array( 
			'sid' => $soap_clientSID, 
			'company_id' => $GLOBALS['appshore_data']['my_company']['company_id'],
			'updated' =>  (isset($last_order['updated']))?$last_order['updated']:'0000-00-00 00:00:00')
			);

		if( isset($soap_client->return['soapVal']['orders']['soapVal']))
		{
			if( isset($soap_client->return['soapVal']['orders']['soapVal'][0]['order_line_id']) )
				$orders = $soap_client->return['soapVal']['orders']['soapVal']; 
			elseif( isset($soap_client->return['soapVal']['orders']['soapVal']['order_line_id']) )
				$orders[] = $soap_client->return['soapVal']['orders']['soapVal'];	

			if( $orders )
			{					
				foreach( $orders as $key => $val )
				{
					unset($order);			
					$order = getOneAssocArray('select order_line_id from company_orders where order_id = "'.$val['order_id'].'" and order_line_id ="'.$val['order_line_id'].'"');
					if( isset($order['order_line_id']) )
						deleteRow( 'company_orders', 'order_line_id', $val, false);
					insertRow( 'company_orders', 'order_line_id', $val, false);
				}
			}
		}
		
		// retrieve current company information
		$soap_client->call( 'shop.synchronization.getInvoices', array( 
			'sid' => $soap_clientSID, 
			'company_id' => $GLOBALS['appshore_data']['my_company']['company_id'],
			'updated' =>  (isset($last_invoice['updated']))?$last_order['updated']:'0000-00-00 00:00:00')
			);


		if( isset($soap_client->return['soapVal']['invoices']['soapVal']))
		{
			if( isset($soap_client->return['soapVal']['invoices']['soapVal'][0]['invoice_id']) )
				$invoices = $soap_client->return['soapVal']['invoices']['soapVal']; 
			elseif( isset($soap_client->return['soapVal']['invoices']['soapVal']['invoice_id']) )
				$invoices[] = $soap_client->return['soapVal']['invoices']['soapVal'];		

			if( $invoices )
			{					
				foreach( $invoices as $key => $val )
				{
					unset($invoice);
					$invoice = getOneAssocArray('select invoice_id from company_invoices where invoice_id = "'.$val['invoice_id'].'"');
					if( isset($invoice['invoice_id']) )
						deleteRow( 'company_invoices', 'invoice_id', $val, false);
					insertRow( 'company_invoices', 'invoice_id', $val, false);
				}
			}
		}	
			
		return;
	}    

}
