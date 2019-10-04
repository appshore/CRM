<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2006 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class administration_applications_base extends lib_base
{

    function __construct()
    {
    	$this->appTable 		= 'db_applications';
    	$this->appRecordId		= 'app_name';    	
    	$this->appRecordName	= 'app_label'; 
    	$this->appWhereFilter	= 'status_id in ("A","D")';    	
    	$this->appOrderBy		= 'app_label';    	
    	$this->appAscDesc		= 'asc';    	    	   	
    	$this->appName 			= 'administration_applications';
    	$this->appNameSingular	= 'administration_application';    	
    	$this->appLabel 		= 'Applications';
    	$this->appLabelSingular = 'Application';    
    	$this->appXSL	 		= 'administration.applications';
    	$this->appRole 			= 'administration';

		parent::__construct();
    }

	function menus()
	{
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl($this->appXSL);
		
		execMethod('administration.base.menus', '', true);

		$GLOBALS['appshore']->add_appmenu($this->appLabel, 'List', 'administration.applications_base.search');
		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_ADMIN ) )
        {
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Activate - Rank','administration.applications_base.activateApplications');
		}	
	}

	
    function start()
    {  
		$this->menus();		

		$result[$this->appName] = '';
		$result['action'][$this->appName] = 'start';
		$result['recordset'] = $_SESSION[$this->appName];
						
		return $result;
    }  
    
    
	function activateApplications()
	{
		$args = new safe_args();
		$args->set('key', NOTSET, 'any');
		$args->set('activeapps', NOTSET, 'any'); // this is an array
		$args = $args->get(func_get_args()); 

		// test of RBAC level upon record owner, if no READ_WRITE then go to the View display
		if ( !$GLOBALS['appshore']->rbac->check('administration', RBAC_USER_WRITE ) )
        {
			$args['key'] = 'Error';
            $error = ERROR_PERMISSION_WRITE_DENIED;
        }

		switch($args['key'])
		{
			case 'Error':
				messagebox( $error, ERROR);
				return $this->activateApplications();
				break;					
			case 'Save':
				if ( isset($args['activeapps'][0])) 
				{
					$app = explode( ',', $args['activeapps']);		
					$args['activeapps'] = implode( '","', $app);					
				
					// then we deactivate the designated ones
					$sql = 'UPDATE db_applications 
						SET status_id = "D", app_sequence = 999
						WHERE status_id = "A"
						AND app_name not in ("'. $args['activeapps'].'")';
					$db = $GLOBALS['appshore']->db->execute( $sql);
								
					// then we activate the designated ones 
					$i = 1 ;
					foreach( $app as $val => $curr )
					{
						$sql = 'UPDATE db_applications 
							SET status_id = "A", app_sequence = '. $i++.'
							WHERE app_name = "'.$curr.'"';
						$db = $GLOBALS['appshore']->db->execute( $sql);
					}
	                //we must update the rbac status because applications status has perhaps changed
	                $GLOBALS['appshore']->rbac->have_changed();		                					
					
					messagebox(lang('Applications status saved'),NOTICE);
				}
				// NO Break	
			default:
				$this->menus();		
		
				$result['apps'] = getManyAssocArrays( 'select app_name, app_label, status_id from db_applications where status_id in ( "A", "D") order by app_sequence');

				// define the related action for calling the right xsl template
				$result['action'][$this->appName] = 'activateApplications';

				// Put context in XML to be processed by XSL
				$this->defaultSessionApp();
				$result['recordset'] = $_SESSION[$this->appName];
				break;	
		} 
	
        return $result;
	}	
    
    
}
