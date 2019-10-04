<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

require_once ( APPSHORE_LIB.SEP.'class.base.php');

class administration_departments_base extends lib_base
{
	var $res;

    function __construct()
    {
    	$this->appTable 		= 'departments';
    	$this->appRecordId		= 'department_id';    	
    	$this->appRecordName	= 'department_name'; 
    	$this->appOrderBy		= 'department_name';    	
    	$this->appAscDesc		= 'desc';    	    	   	
    	$this->appName 			= 'administration_departments';
    	$this->appNameSingular	= 'administration_department';    	
    	$this->appLabel 		= 'Departments';
    	$this->appLabelSingular = 'Department';    
    	$this->appXSL	 		= 'administration.departments';
    	$this->appRole 			= 'administration';

    	// to allow tag management from this app
		if ( $GLOBALS['appshore']->rbac->check('tags', RBAC_RUN_APP ))
			$GLOBALS['appshore']->addNode( $this->appRole, 'tag');

		parent::__construct();
    }

    function menus()
    {
        $GLOBALS['appshore']->add_xsl('lib.base');
        $GLOBALS['appshore']->add_xsl($this->appXSL);
		
		execMethod('administration.base.menus', '', true);

		$GLOBALS['appshore']->add_appmenu($this->appLabel, 'List', 'administration.departments_base.search');	
		if ( $GLOBALS['appshore']->rbac->check($this->appRole, RBAC_ADMIN ) )
			$GLOBALS['appshore']->add_appmenu($this->appLabel, 'New department', 'administration.departments_base.edit');
		$GLOBALS['appshore']->add_appmenu($this->appLabel, 'Org Chart', 'administration.departments_base.orgchart');		
    }
	
    function start()
    {  
		$this->menus();		

		$result[$this->appName] = '';
		$result['action'][$this->appName] = 'start';
		$result['recordset'] = $_SESSION[$this->appName];
						
		return $result;
    }       
    
#    function newEntry(  $args = null, $entry = null)
#    {     
#        $entry['department_top_id'] = '0';                   
#	            
#        return parent::newEntry( $args, $entry);
#    }       
	
	
	// search and list sales
    function orgchart()
    {
 		$this->menus();			

		$result[$this->appName] = $this->getDepartmentsUsers();

		// define the related action for calling the right xsl template		
		$result['action'][$this->appName] = 'orgchart';	

		// Put context in XML to be processed by XSL
		$this->defaultSessionApp();
		$result['recordset'] = $_SESSION[$this->appName];

		return $result;
    } 
    
    
    function getDepartmentsUsers( $department_id = null, $level = 0 )
    {
    	if( $department_id )
    	{
	  		$department = getOneAssocArray( 'SELECT 
					departments.*,					
					manager.full_name manager_full_name,
					assistant.full_name assistant_full_name				
				FROM
					departments
					LEFT OUTER JOIN users manager 
						ON departments.manager_id = manager.user_id
					LEFT OUTER JOIN users assistant 
						ON departments.assistant_id = assistant.user_id					
				WHERE departments.department_id = "'.$department_id.'"');  		
	  		
	  		if( $department['department_id'] )
	  		{
	  			$department['level'] =  $level;
	  			$department['users'] = getManyAssocArrays( '
	  				SELECT 
	  					users.user_id, 
	  					users.user_name, 
	  					users.full_name 
	  				FROM users	 
	  				WHERE users.department_id = "'.$department_id.'"');
	  			$this->res[] = $department;
	  		}
	  	}
    
    	$nodes = getManyAssocArrays( 'select * from departments where department_top_id = "'.$department_id.'" ORDER BY department_name ASC');
   	
    	if( isset($nodes) )
    		foreach( $nodes as $key => $value )
    			$this->getDepartmentsUsers( $value['department_id'], $level+1);
    			
    	return $this->res;
    }
	
    	
}
