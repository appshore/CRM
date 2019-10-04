<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class quotes_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'quotes';
    	$this->appRecordId		= 'quote_id';    	
    	$this->appRecordName	= 'quote_name';    	
   		$this->appOrderBy		= 'quote_name';    	
    	$this->appAscDesc		= 'asc';    	
    	$this->appName 			= 'quotes';
    	$this->appNameSingular	= 'quote';    	
    	$this->appLabel 		= 'Quotes';
    	$this->appLabelSingular = 'Quote';    
    	$this->appXSL			= 'quotes.base';    
    	$this->appRole 			= 'quotes';

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

        parent::__construct();    	
    }
  
    function view($args)
    {
		$result = parent::view($args);

		if( $result['action'][$this->appName] == 'view' )
			$result = array_merge( $result, $this->view_lines($result['quote']['quote_id']?$result['quote']:$args)); 

		$GLOBALS['appshore']->addPlugins( 'ViewLines');
		
		return $result;   
    }
    
    function view_lines( $args)
    {
		$result['quote_lines'] = getManyAssocArrays( '
				select 
					q.*, group_name, unit_name, tax_name, tax_value 
				from quotes_lines q 
				left outer join quotes_groups g on q.group_id = g.group_id 
				left outer join products_units u on q.unit_id = u.unit_id 
				left outer join taxes t on q.tax_id = t.tax_id 
				where quote_id = "'.$args['quote_id'].'" order by sequence'); 

		$this->build_quote( $args, $result);

		if( $result['quote_lines'] )
	        foreach( $result['quote_lines'] as $curr => $val )
	        	$result['quote_lines'][$curr]['price'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['quote_lines'][$curr]['price'], false, 2);
	        
		return $result;   
    }
    	
    
    function edit($args)
    {
		if( $args['key'] == 'Save' )
			$this->edit_addresses($args);
			
		$result = parent::edit($args);

		if( $args['key'] == 'Save' || $args['key'] == 'Delete')
			$result = array_merge( $result, $this->edit_lines($args)); 
		else if( $result['action'][$this->appName] == 'edit' )
			$result = array_merge( $result, $this->edit_lines($result['quote']['quote_id']?$result['quote']:$args)); 

		$GLOBALS['appshore']->addPlugins( 'EditLines');
		
		return $result;   
    }    	

    function edit_addresses( &$args)
    {
    	if( $args['quote_id'] )
			$quote = getOneAssocArray( 'select account_id, contact_id from quotes where quote_id = "'.$args['quote_id'].'"');
		
		if( $args['account_id'] && $args['account_id'] != $quote['account_id'] )
		{
			$record = getOneAssocArray( 'select address_billing, city_billing, state_billing, zipcode_billing, country_billing, 
				address_shipping, city_shipping, state_shipping, zipcode_shipping, country_shipping 
				from accounts where account_id = "'.$args['account_id'].'"');
			
		}
		else if( $args['contact_id'] && $args['contact_id'] != $quote['contact_id'] )
		{
			$record = getOneAssocArray( 'select address_1 as address_billing, city_1 as city_billing, state_1 as state_billing, zipcode_1 as zipcode_billing, country_1 as country_billing, 
				address_2 as address_shipping, city_2 as city_shipping, state_2 as state_shipping, zipcode_2 as zipcode_shipping, country_2 as country_shipping 
				from contacts where contact_id = "'.$args['contact_id'].'"');
		}
			
		if( $record )	
			foreach( $record as $key => $val)
				$args[$key] = $record[$key];
	}
    
    function edit_lines( $args)
    {
		switch($args['key'])
		{
			case 'Delete':
				$selected = explode( ',', $args['selected']);				  
				foreach( $selected as $key => $val)
				{
					$record[$this->appNameSingular.'_line_id'] = $val;
					deleteRow( $this->appName.'_lines', $this->appNameSingular.'_line_id', $record, false);
				}	
				messagebox( MSG_DELETE, NOTICE);					
				break;
						
			case 'Save':
				for( $i = 0 ; $i < 50 ; $i++ )
					if( $args['product_name_'.$i] )		
		 			{ 		
						unset($record);
		            	$record['quote_id'] 	= $args['quote_id'];
		            	$record['group_id'] 	= $args['group_id_'.$i];
		            	$record['product_id'] 	= $args['product_id_'.$i];
		            	$record['product_name'] = $args['product_name_'.$i];
		            	$record['description']  = $args['description_'.$i];
		            	$record['quantity']  	= $args['quantity_'.$i];
		            	$record['unit_id']  	= $args['unit_id_'.$i];
		            	$record['tax_id']  		= $args['tax_id_'.$i];
		            	$record['price']  		= $args['price_'.$i];
		            	$record['discount']  	= $args['discount_'.$i];
		            	$record['is_option']  	= $args['is_option_'.$i];
		            	$record['sequence']  	= $i;

						if( $args['quote_line_id_'.$i] )
						{
			            	$record['quote_line_id'] = $args['quote_line_id_'.$i];
				 			updateRow( 'quotes_lines', 'quote_line_id', $record, false); 
			 			}
			 			else
			 			{	
				 			insertRow( 'quotes_lines', 'quote_line_id', $record, false); 
						}
					}
				break;
		}

		$result['quote_lines'] = getManyAssocArrays( 'select * from quotes_lines where quote_id = "'.$args['quote_id'].'" order by sequence'); 
       	
		$this->build_quote( $args, $result);
		
		$inc=0;
		if( $result['quote_lines'] )
		{
	        foreach( $result['quote_lines'] as $curr => $val )
	        {  
				$result['quote_lines'][$curr]['scope'] = 1;	        
				$result['quote_lines'][$curr]['increment'] = $inc++;
	        }
        }

		for( $i = $inc ; $i < $inc+5 ; $i++)
		{
			$result['quote_lines'][$i]['product_name'] = '';
			$result['quote_lines'][$i]['scope'] = 1;
			$result['quote_lines'][$i]['increment'] = $i;
		}		
				
		$result['scope'] = ( $args['user_id'] )?$GLOBALS['appshore']->rbac->checkPermissionOnUser('quotes', $args['user_id']):1 ;
       				
		$result['groups'] = getManyAssocArrays( 'select group_id, group_name from quotes_groups order by group_name');
		$result['units'] = getManyAssocArrays( 'select unit_id, unit_name from products_units order by unit_name');
		$result['taxes'] = getManyAssocArrays( 'select tax_id, tax_name, tax_value from taxes order by tax_name');
		return $result;   
    } 
    
    function build_quote( $args, &$result)
    {
		$result['total']['total_price'] = $result['total']['total_discount'] = $result['total']['total_amount'] = 0;
		if( $result['quote_lines'] )
	        foreach( $result['quote_lines'] as $curr => $val )
	        {  
	        	$total_price = $result['quote_lines'][$curr]['price']*$result['quote_lines'][$curr]['quantity'];
	        	$total_discount = $total_price*$result['quote_lines'][$curr]['discount']/100;
				$result['total']['total_price'] += $total_price; 
				$result['total']['total_discount'] += $total_discount; 
	        	$result['quote_lines'][$curr]['amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $total_price-$total_discount, false, 2);
				if( $result['quote_lines'][$curr]['is_option'] == 'N')
				{
					$result['total']['total_price_option'] += $total_price; 
					$result['total']['total_discount_option'] += $total_discount; 
				}
				else
					$result['total']['option'] = 1;
	        }

       // results by group			
		$result['quote_groups'] = getManyAssocArrays( 'select 
				q.group_id, group_name, 
				sum(price*quantity) as group_price,  
				sum(price*quantity*discount/100) as group_discount 
			from quotes_lines q 
			left outer join quotes_groups g on q.group_id = g.group_id 
			where quote_id = "'.$args['quote_id'].'" 
			group by q.group_id');
			
		if( $result['quote_groups'] )
	        foreach( $result['quote_groups'] as $curr => $val )
	        {  
				$option = getOneAssocArray( 'select sum(price*quantity) as group_option from quotes_lines q 
							where quote_id = "'.$args['quote_id'].'" and is_option = "Y" and group_id = "'.$result['quote_groups'][$curr]['group_id'].'" group by q.group_id');
				$result['total']['total_option'] += $result['quote_groups'][$curr]['group_option'] = $option['group_option'];	        
	        	$result['quote_groups'][$curr]['group_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['quote_groups'][$curr]['group_price']-$result['quote_groups'][$curr]['group_discount'], true, 2);
	        	$result['quote_groups'][$curr]['group_price'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['quote_groups'][$curr]['group_price'], true, 2);
	        	$result['quote_groups'][$curr]['group_discount'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['quote_groups'][$curr]['group_discount'], true, 2);
	        	$result['quote_groups'][$curr]['group_option'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['quote_groups'][$curr]['group_option'], true, 2); 
	        }
    
        // results by tax			
		$result['quote_taxes'] = getManyAssocArrays( 'select 
				q.tax_id, tax_name, 
				sum(((price*quantity)-(price*quantity*discount/100))*tax_value/100) as tax_amount  
			from quotes_lines q 
			left outer join taxes t on q.tax_id = t.tax_id 
			where quote_id = "'.$args['quote_id'].'" 
			group by q.tax_id');
			

        // results by tax			
		$quote_taxes_option = getManyAssocArrays( 'select 
				q.tax_id, tax_name, 
				sum(((price*quantity)-(price*quantity*discount/100))*tax_value/100) as tax_amount_option  
			from quotes_lines q 
			left outer join taxes t on q.tax_id = t.tax_id 
			where quote_id = "'.$args['quote_id'].'" 
			and is_option = "N"
			group by q.tax_id');
			
		if( $result['quote_taxes'] )
	        foreach( $result['quote_taxes'] as $curr => $val )
	        {  
				$result['total']['total_tax'] += $result['quote_taxes'][$curr]['tax_amount'];	        
	        	$result['quote_taxes'][$curr]['tax_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['quote_taxes'][$curr]['tax_amount'], true, 2);
				if( $quote_taxes_option )
			        foreach( $quote_taxes_option as $currOption => $valOption )
			        {  
			        	if( $valOption['tax_id'] == $val['tax_id'] )
			        	{
							$result['total']['total_tax_option'] += $valOption['tax_amount_option'];	        
		        			$result['quote_taxes'][$curr]['tax_amount_option'] = $GLOBALS['appshore']->local->decimalToCurrency($valOption['tax_amount_option'], true, 2);
		        		}
		        	}
	        }

		$result['currency'] = $GLOBALS['appshore']->local->currencySymbol();

		$result['total']['total_amount_option'] 	= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_price_option']+$result['total']['total_tax_option']-$result['total']['total_discount_option'], true, 2); 
		$result['total']['total_subtotal_option'] 	= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_price_option']-$result['total']['total_discount_option'], true, 2); 
		$result['total']['total_tax_option'] 		= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_tax_option'], true, 2); 
		$result['total']['total_discount_option'] 	= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_discount_option'], true, 2); 
		$result['total']['total_price_option'] 		= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_price_option'], true, 2); 
		$result['total']['total_amount'] 			= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_price']+$result['total']['total_tax']-$result['total']['total_discount'], true, 2); 
		$result['total']['total_subtotal'] 			= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_price']-$result['total']['total_discount'], true, 2); 
		$result['total']['total_tax'] 				= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_tax'], true, 2); 
		$result['total']['total_discount'] 			= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_discount'], true, 2); 
		$result['total']['total_price'] 			= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_price'], true, 2); 
		$result['total']['total_option'] 			= $GLOBALS['appshore']->local->decimalToCurrency( $result['total']['total_option'], true, 2); 
    }       	
    	
    	
    function open_quotes()
    {
        $_SESSION[$this->appName]['first'] = 0;
        $_SESSION[$this->appName]['currentVal'] = 0;
        $_SESSION[$this->appName]['countMax'] = 0;	
	
		$where =  ' WHERE quotes.status_id not in ("CL") AND users.user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"';
		$orderby = 'description';
		$ascdesc = 'DESC limit 5';			
		

   		return $this->searchAndList( $where, $orderby, $ascdesc);
    }

}
