<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once( APPSHORE_LIB . SEP . 'class.ajax.php');

class dailies_ajax extends lib_ajax {

    function __construct()
    {
    	$this->appTable 		= 'dailies';
    	$this->appRecordId		= 'contact_id';    	
    	$this->appRecordName	= 'full_name'; 
    	
    	// to limit the scope for external users
#    	if( $GLOBALS['appshore_data']['current_user']['type_id'] == 'Partner' && $GLOBALS['appshore_data']['current_user']['hmpartner_id'] )
#	    	$this->appWhereFilter = 'source_id = "'.$GLOBALS['appshore_data']['current_user']['hmpartner_id'].'"';    	
	    	
    	$this->appOrderBy		= 'full_name';    	
    	$this->appAscDesc		= 'asc';    	    	   	
    	$this->appName 			= 'dailies';
    	$this->appNameSingular	= 'daily';    	
    	$this->appLabel 		= 'Dailies';
    	$this->appLabelSingular = 'Daily';    
    	$this->appXSL 			= 'dailies.base';
    	$this->appRole 			= null;  //needed because no user_id field

        parent::__construct();    	
    }    
    
    
    // search a filtered text
    function getPipeline()
    {
		$args = new safe_args();
		$args->set('hmpartner_id', 	NOTSET, 'sqlsafe');
		$args->set('refresh', 		'N', 'sqlsafe');
		$args = $args->get(func_get_args());
				
		include_once('class.pipeline.php');
		$pipe = new pipeline;
    		
#    	if( $GLOBALS['appshore_data']['current_user']['type_id'] == 'Partner' && $GLOBALS['appshore_data']['current_user']['hmpartner_id'] )
#			$args['hmpartner_id'] = $GLOBALS['appshore_data']['current_user']['hmpartner_id'];

		$pipe->generate($args['hmpartner_id'], $args['refresh']);

		if ( $pipeline = $pipe->get($args['hmpartner_id']) )
		{
			$count = count($pipeline);
			reset($pipeline);
			for( $i = 0; $i < $count; $i++ )
			{
				$val = current($pipeline);
				$key = key($pipeline);
				if( preg_match('/(pct|pbg)/', $key) ) // percentage
					$result['pipeline'][$key] = number_format($val,2).'%';
				else if( preg_match('/(com|fat|ifa|pft|funding)/', $key) ) // currency
					$result['pipeline'][$key] = '$'.number_format((int)$val);
				else
					$result['pipeline'][$key] = $val;
				next($pipeline);
			}
		}
			
   		$_SESSION[$this->appName]['hmpartner_id'] = $args['hmpartner_id'];    		
		$GLOBALS['appshore_data']['server']['xml_render'] = true;
 		return $result;
	}  
     
}
