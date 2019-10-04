<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB.SEP.'class.base.php');

class dailies_base extends lib_base
{
    function __construct()
    {
    	$this->appTable 		= 'dailies';
    	$this->appRecordId		= 'daily_id';    	
    	$this->appRecordName	= 'start_date'; 
    	$this->appWhereFilter	= '';    	
    	$this->appOrderBy		= 'start_date';
    	$this->appAscDesc		= 'asc';    	    	   	
    	$this->appName 			= 'dailies';
    	$this->appNameSingular	= 'daily';    	
    	$this->appLabel 		= 'Dailies';
    	$this->appLabelSingular = 'Daily';    
    	$this->appXSL 			= 'dailies.base';
    	$this->appRole 			= 'dailies';

    	// to allow saved searches management from this app
		if ( checkEdition() )
			$GLOBALS['appshore']->addNode( $this->appRole, 'savedSearches');

		if ( $GLOBALS['appshore']->rbac->checkPermissionOnFeature($this->appRole, 'export') )
			$GLOBALS['appshore']->addNode( $this->appRole, 'export');

        parent::__construct();    	

		if( isset($_SESSION[$this->appName]['preferences']) == false )
			$_SESSION[$this->appName]['preferences'] = getOneAssocArray('select * from dailies_preferences where user_id ="'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');

    	$this->check_daily($GLOBALS['appshore_data']['current_user']['user_id']);

	} 

   
    function menus()
    {
		parent::menus();   
		if( checkEdition() )
			$GLOBALS['appshore']->add_appmenu($this->appName, 'Preferences', $this->appName.'.preferences_base.start');
    }   
         
    // init some values when new Entry
    function newEntry( $args = null, $entry = null)
    {
		$start = round((int)(strtotime('+0 hour')/60),-1)*60;
        $entry['start_date'] = gmdate('Y-m-d H:i', $start);	
		$duration = (int)($_SESSION[$this->appName]['preferences']['duration']?$_SESSION[$this->appName]['preferences']['duration']:'3600');
        $entry['end_date'] = gmdate('Y-m-d H:i', $start+$duration);

		$entry['type_id'] = $_SESSION[$this->appName]['preferences']['type_id']?$_SESSION[$this->appName]['preferences']['type_id']:'CA';
		$entry['status_id'] = $_SESSION[$this->appName]['preferences']['status_id']?$_SESSION[$this->appName]['preferences']['status_id']:'SC';
        $entry['priority_id'] = $_SESSION[$this->appName]['preferences']['priority_id']?$_SESSION[$this->appName]['preferences']['priority_id']:'NO';   
        $entry['reminder_email'] = $_SESSION[$this->appName]['preferences']['reminder_email']?$_SESSION[$this->appName]['preferences']['reminder_email']:'';   
        $entry['reminder_popup'] = $_SESSION[$this->appName]['preferences']['reminder_popup']?$_SESSION[$this->appName]['preferences']['reminder_popup']:'';   

        return parent::newEntry( $args, $entry);
    }    
    
    // retrieve date for notifications
    function getNotificationStartDate( $args = null)
    {
        list( $date) = explode(' ', $GLOBALS['appshore']->local->localToDatetime($args['start_date']));
        return $date;
    }
    
    // retrieve time for notifications
    function getNotificationStartTime( $args = null)
    {
        list( $date, $time) = explode(' ', $GLOBALS['appshore']->local->localToDatetime($args['start_date']));
        return $time;
    } 
    
    function search($args=null)
    {    	
		$result = parent::search($args);

		return $result;   
    }

  
    function view($args)
    {
		$result = parent::view($args);

		if( $result['action'][$this->appName] == 'view' )
			$result = array_merge( $result, $this->view_lines($args)); 

		$GLOBALS['appshore']->addPlugins( 'ViewLines');
		
		return $result;   
    }
    
    function view_lines( $args)
    {
		$result = $this->get_daily( $args);

#		if( $result['daily_lines'] )
#	        foreach( $result['daily_lines'] as $curr => $val )
#	        	$result['daily_lines'][$curr]['price'] = $GLOBALS['appshore']->local->decimalToCurrency( $result['daily_lines'][$curr]['price'], false, 2);
	        
		return $result;   
    }
    	
    
    function edit($args)
    {			

		$result = parent::edit($args);

		if( $args['key'] == 'Save' && $args['daily_id'] == null)
			$result = $this->build_daily( $args, $result);
		else if( $args['key'] == 'Save' || $args['key'] == 'Delete')
			$result = array_merge( $result, $this->edit_lines($args)); 
		else if( $result['action'][$this->appName] == 'edit' )
			$result = array_merge( $result, $this->edit_lines($args)); 

		$GLOBALS['appshore']->addPlugins( 'EditLines');
		
		return $result;   
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
		            	$record['daily_id'] 		= $args['daily_id'];
		            	$record['supervisor_note']	= $args['supervisor_note_'.$i];
		            	$record['manager_note']		= $args['manager_note_'.$i];
		            	$record['sequence']  		= $i;

						if( $args['daily_line_id_'.$i] )
						{
			            	$record['daily_line_id'] = $args['daily_line_id_'.$i];
				 			updateRow( 'dailies_lines', 'daily_line_id', $record, false); 
			 			}
			 			else
			 			{	
				 			insertRow( 'dailies_lines', 'daily_line_id', $record, false); 
						}
					}
				break;
		}

		$result = $this->get_daily( $args);
		
		$inc=0;
		if( $result['daily_lines'] )
		{
	        foreach( $result['daily_lines'] as $curr => $val )
	        {  
				$result['daily_lines'][$curr]['scope'] = 1;	        
				$result['daily_lines'][$curr]['increment'] = $inc++;
	        }
        }
				
		$result['scope'] = ( $args['user_id'] )?$GLOBALS['appshore']->rbac->checkPermissionOnUser('dailies', $args['user_id']):1 ;
       				
		return $result;   
    } 
    
    function get_daily( $args)
    {
		$lines = getManyAssocArrays('select * from dailies_lines where daily_id = "'.$args['daily_id'].'"');
		if( $lines )
	        foreach( $lines as $curr => $val )
	        {  
				$line['line'] = $val; 
				$line['activity'] = getOneAssocArray('select act.*, ast.status_name from activities act
					left outer join activities_statuses ast on ast.status_id = act.status_id
					where act.activity_id = "'.$val['activity_id'].'"'); 
				
				$line['activity']['activity_start'] = $GLOBALS['appshore']->local->gmtToTZTimeLocal($line['activity']['activity_start']);
					
				$line['opportunity'] = getOneAssocArray('select * from opportunities opp
					where opportunity_id = "'.$val['opportunity_id'].'"'); 

				$account_id = $line['activity']['account_id']?$line['activity']['account_id']:$line['opportunity']['account_id']; 
				$line['account'] = getOneAssocArray('select account_name from accounts where account_id = "'.$account_id.'"'); 
				$contact_id = $line['activity']['contact_id']?$line['activity']['contact_id']:$line['opportunity']['contact_id']; 
				$line['contact'] = getOneAssocArray('select full_name from contacts where contact_id = "'.$contact_id.'"'); 

	        	$result['daily_lines'][] = $line;
	        }

		return $result;
    }
    
    function check_daily( $user_id)
    {
#		$lines = getManyAssocArrays('select * from act_opp_lines 
#			where start_date not in (select start_date from dailies where user_id = "'.$args['user_id'].'") 
#			and user_id = "'.$args['user_id'].'"'); 

		// clean up orfan child
		executeSQL('delete from dailies_lines where daily_id not in (select daily_id from dailies)'); 


		$dailies = getManyAssocArrays('select distinct start_date, user_id from act_opp_lines 
			where start_date not in (select start_date from dailies where user_id = "'.$user_id.'") 
			and user_id = "'.$user_id.'"'); 

				
		if( $dailies )
		{
		    foreach( $dailies as $curr => $val )
		    {  
			    	
			    $daily = $val;
				$daily['start_date'] = $GLOBALS['appshore']->local->dateToLocal($val['start_date']);			    					
				$daily['status_id'] = 'TC';			    					
			    // create entry in the dailies table
			    $daily_id = insertRow( 'dailies', 'daily_id', $daily);

				$lines = getManyAssocArrays('select * from act_opp_lines 
					where start_date = "'.$val['start_date'].'"
					and user_id = "'.$val['user_id'].'"'); 
					
				if( $lines )
				{
					// create entry in the dailies_lines table for each activity
					foreach( $lines as $curr2 => $val2 )
					{  
						
						$line = $val2;
						$line['start_date'] = $GLOBALS['appshore']->local->dateToLocal($val2['start_date']);			    	
						$line['daily_id'] = $daily_id;			    	
						insertRow( 'dailies_lines', 'daily_id', $line);				
					}
				}
			}
		}
    }   
            
	   	
}
