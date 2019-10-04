<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2008 Brice Michel                                     *
 ***************************************************************************/

class opportunities_dashboard {
		
	// join SQL query to retrieve opportunities according search criterias
	function searchAndList( $where, $orderby = 'opportunity_name', $ascdesc = 'ASC')
	{
		$db = $GLOBALS['appshore']->db->execute('
			SELECT 
				opportunities.*,				
				accounts.account_name,			
				accounts.phone as account_phone,					
				accounts.email as account_email,				
				stages.stage_name,
				sources.source_name,				
				users.user_name
			FROM
				opportunities
				LEFT OUTER JOIN accounts
					ON opportunities.account_id = accounts.account_id
				LEFT OUTER JOIN users
					ON opportunities.user_id = users.user_id
				LEFT OUTER JOIN stages
					ON opportunities.stage_id = stages.stage_id
				LEFT OUTER JOIN sources
					ON opportunities.source_id = sources.source_id					
				'.$where.'	
			ORDER BY '.$orderby.' '.$ascdesc
			);

			
		$db->Move($this->currentVal);    
		$this->countMax = $db->RowCount();

		while( !$db->EOF && $nbr < $GLOBALS['appshore_data']['current_user']['nbrecords'])
		{
			$scope['scope'] = $GLOBALS['appshore']->rbac->checkPermissionOnUser('opportunities', $db->fields['user_id']) ;
			$result['opportunities'][] = array_merge( $db->GetRowAssoc(false), $scope);				
				
			$db->MoveNext();
			$nbr++;
		}  	

		$this->first = $this->currentVal + $nbr ;
		
		if ( is_array($result['opportunities']) )
		{		
			$currency = $GLOBALS['appshore']->local->currencySymbol();
	        foreach( $result['opportunities'] as $curr => $val )
	        {  
				$result['opportunities'][$curr]['currency_id'] = $currency;	        
	        	$result['opportunities'][$curr]['expected_amount'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['opportunities'][$curr]['expected_amount'], true, 0);	        
	        	$result['opportunities'][$curr]['closing'] = $GLOBALS['appshore']->local->dateToLocal( $result['opportunities'][$curr]['closing']);	        
	        	$result['opportunities'][$curr]['stage_name'] = lang($result['opportunities'][$curr]['stage_name']);
	        	if( strtotime($result['opportunities'][$curr]['created']) > mktime(0, 0, 0, date("m"), date("d")-1, date("Y")) )  
	        		$result['opportunities'][$curr]['record_date'] = 'new'; 
	        	else if( strtotime($result['opportunities'][$curr]['closing']) <  mktime() &&  $result['opportunities'][$curr]['probability']  != 0 && $result['opportunities'][$curr]['probability']  != 100)    	
	        		$result['opportunities'][$curr]['record_date'] = 'expired'; 
	        }
        }		
		
		return $result['opportunities'];
	}
	
	
	function top_opportunities()
    {
        $this->first = 0;
        $this->currentVal=0;
        $this->countMax=0;
	
		$where =  'WHERE users.user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"'.' AND opportunities.probability not in ("0") ';
		$orderby = 'expected_amount';
		$ascdesc = 'DESC limit 5';
			
   		return $this->searchAndList( $where, $orderby, $ascdesc);
    }
    
   	
    function open_opportunities()
    {
        $this->first = 0;
        $this->currentVal=0;
        $this->countMax=0;
	
		$where =  'WHERE users.user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"'.' AND opportunities.probability not in ("0","100") ';
		$orderby = 'closing';
		$ascdesc = 'ASC limit 10';
		
   		return $this->searchAndList( $where, $orderby, $ascdesc);

   }    
	  	
}    

/*	  	
    function my_ajax()
    {
		$args = new safe_args();
		$args->set('page_size', 	10, 'any');		
		$args->set('offset', 		1, 'any');	
		$args->set('sort_col', 		'opportunity_name', 'any');	
		$args->set('sort_dir', 		'ASC', 'any');	
		$args = $args->get(func_get_args());
		
		$orderby = ' ORDER BY '.$args['sort_col'];
		$ascdesc = ' '.$args['sort_dir'];
		$limit = ' limit '.$args['offset'].','.$args['page_size'];
		   		$result = getManyAssocArrays('
			SELECT 
				opportunity_name,
				closing
			FROM
				opportunities '.
			$orderby.$ascdesc.$limit);
		
		$output = '<?xml version="1.0" encoding="utf-8"?><ajax-response><response type="object" id="data_grid_updater"><rows update_ui="true" >';
		
		$sequence=$args['offset'];
		foreach( $result as $key => $val)
		{
			$output .= '<tr>
				<td>'.$sequence++.'</td>
				<td><![CDATA[<a href="">'.$val['opportunity_name'].'</a>]]></td>
				<td>'.$val['closing'].'</td>
				</tr>';
		}
		
		$output .= '</rows></response></ajax-response>';
				
				
		while (@ob_end_clean());	
		
		ini_set( 'zlib.output_compression', 'Off');
		header('Content-Type: text/xml');
		
		print $output;				

		exit;
    }   
    
    function my_ajax2()
    {
		$args = new safe_args();
		$args->set('page_size', 	10, 'any');		
		$args->set('offset', 		1, 'any');	
		$args->set('sort_col', 		'opportunity_name', 'any');	
		$args->set('sort_dir', 		'ASC', 'any');	
		$args = $args->get(func_get_args());
		
		$GLOBALS['appshore']->add_xsl('opportunities.ajax');
		$result['action']['ajax'] = 'grid';		
		$GLOBALS['appshore_data']['server']['xml_render'] = false;		
		
		$orderby = ' ORDER BY '.$args['sort_col'];
		$ascdesc = ' '.$args['sort_dir'];
		$limit = ' limit '.$args['offset'].','.$args['page_size'];
		
	   		$result['datas'] = getManyAssocArrays('
			SELECT 
				opportunity_id,
				opportunity_name,
				closing
			FROM
				opportunities '.
			$orderby.$ascdesc.$limit);
			   		$result['datas'] = getManyAssocArrays('
			SELECT 
				account_id as opportunity_id,
				account_name as opportunity_name,
				created as closing
			FROM
				accounts '.
			$orderby.$ascdesc.$limit);			
			
		//we force the output as an XML file
		header('Content-type: text/xml');			
			
		return $result;
    }    
	 	      
	 	 

    function listing( $where, $orderby='closing', $asdesc='ASC')
    {
        $this->first = 0;
        $this->currentVal = 0;
        $this->countMax = 0;  
        
        if( strstr( strtolower($where), ' where ') == false )
        	$where = buildClauseWhere('opportunities','R').$where;
                
   		return $this->searchAndList( $where, $orderby, $ascdesc);
    }
 */  	

