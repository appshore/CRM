<?php
/**************************************************************************\
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* Brice MICHEL <bmichel@appshore.com>                                      *
* Copyright (C) 2004 Brice MICHEL                                          *
* ------------------------------------------------------------------------ *
* Portions from phpGroupWare                                               *
* http://www.phpgroupware.org                                              *
* Dan Kuykendall <dan@kuykendall.org>                					   *
* Copyright (C) 2003 Dan Kuykendall                                        *
* -------------------------------------------------------------------------*
* This library is free software; you can redistribute it and/or modify it  *
* under the terms of the GNU Lesser General Public License as published by *
* the Free Software Foundation; either version 2.1 of the License,         *
* or any later version.                                                    *
* This library is distributed in the hope that it will be useful, but      *
* WITHOUT ANY WARRANTY; without even the implied warranty of               *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     *
* See the GNU Lesser General Public License for more details.              *
* You should have received a copy of the GNU Lesser General Public License *
* along with this library; if not, write to the Free Software Foundation,  *
* Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA            *
\**************************************************************************/

	// extract the application name in case of sub app module
	function getAppName($name)
	{
		list( $appname) = explode( '_', $name);
		return $appname;
	}


	function __autoload($class)
	{	
		if(!validate($class,'alphanumericplus'))
			return false;
		
		list( $appname, $classname) = explode( '_', $class, 2);

		//if(!(validate($appname,'alphanumericplus') && validate($classname,'alphanumericplus')))
		//	return false;
		
		if (class_exists($class))
			return true;
		
		$filename = APPSHORE_HTTPD.SEP.$appname.SEP.'class.'.$classname.'.php';
		
		if(!file_exists($filename))
		{
			$filename = INSTANCES_DATA.SEP.$GLOBALS['appshore_data']['my_company']['company_alias'].SEP.'applications'.SEP.$appname.SEP.'class.'.$classname.'.php';
			if(!file_exists($filename))
			{

				if(defined('DOMPDF_INC_DIR'))
				{
					DOMPDF_autoload($class);
					return true;
				}
				return false;
			}
		}
		
		include_once($filename);
		
		return class_exists($class);
	}

	function createObject()
	{
		$args = new safe_args();
		$args->set( 'class',	REQUIRED);
		$args->set( 'inputs',	NOTSET);
		$args->set( 'silent',	true);
		$args = $args->get(func_get_args());	
		
		if(__autoload($args['class']))
		{
			if(!isset($args['inputs']))
				return new $args['class'];
				
			return new $args['class']($args['inputs']);
		}
		
		/* If method didnt exist */
		return '##NOMETHOD##';
	}

	function execMethod()
	{
		$args = new safe_args();
		$args->set('function', 	REQUIRED);
		$args->set('inputs',	NOTSET);
		$args->set('silent',	false);
		$args = $args->get(func_get_args());	
								
		// 	case where the op is a child class
		if( substr_count($args['function'], '.') == 3 )
			$args['function'] = str_replace( '.base.', '.', $args['function']);	
			
		list( $appname, $classname, $methodname) = explode('.', $args['function']);

		if(!validate( $args['function'],'alphanumericplus') && !validate($appname,'alphanumericplus') && 
			!validate($classname,'alphanumericplus') && !validate($methodname,'alphanumericplus'))
		{
			if( $args['silent'] == false )
				messagebox($args['function'].' '.ERROR_INVALID_APPLICATION, ERROR);
			return '##NOMETHOD##';
		}
				
		if ( substr($methodname, 0, 2) == '__')
		{
			if( $args['silent'] == false )
				messagebox($args['function'].' '.ERROR_INVALID_APPLICATION, ERROR);
			return '##NOMETHOD##';
		}

		$obj = createObject( $appname.'_'.$classname, $args['inputs'], $args['silent']);

		if (method_exists( $obj, $methodname))
		{
#			if($args['inputs'] == NOTSET)
#				return $obj->$methodname();
#				
			return $obj->$methodname($args['inputs']);
		}
		
		if( $args['silent'] == false )
			messagebox($args['function'].' '.ERROR_INVALID_APPLICATION, ERROR);

		// If method didnt exist
		return '##NOMETHOD##';
	}


	define('NOTSET', '##NOTSET##');
	define('NOVAR', '##NOVAR##');
	define('REQUIRED','##REQUIRED##');

	class safe_args
	{
		var $ref         = array();
		var $defaults    = array();
		var $types       = array();

		function set( $name, $default=NOTSET, $type='any')
		{
			if( isset($this->types[$name]) == null )
			{
				$this->ref[] = $name;
				$this->types[$name] = $type;
				$this->defaults[$name] = $default;
			}
		}

		function idx2name($var)
		{
			$newvar = array();
			foreach ($this->ref as $idx=>$name)
			{
				if (isset($var[$idx]))
				{
					$newvar[$name] = $var[$idx];
				}
			}
			return $newvar;
		}

		function get($received=NULL)
		{
			switch(count($received))
			{
				case 0:
					// No params sent, so we need to convert to array
					$received = array();
					break;
				case 1:
					// If they sent an indexed array, convert to normal function call.
					if(is_array($received[0]))
					{
						$received = $received[0];
						// if they sent associative array (most desired)
						reset($received);
						if (key($received) !== 0 )
						{
							break;
						}
					}
				default:
					// check to see if they used normal function calls.
					$received = $this->idx2name($received);
			}

			$args = array();

			foreach($this->ref as $idx => $key)
			{
						
				// enum type
				if ($this->types[$key] == 'enum')
				{
					// Invalid specification of enum options
					if (!is_array($this->defaults[$key]))
					{
						$msg = 'Invalid parameter for enum type';
						$this->error($msg.' "'.$key.'"',E_USER_ERROR);
						continue;
					}
					// No val, use first option
					if (!isset($received[$key]))
					{
						$args[$key] = reset($this->defaults[$key]);
						continue;
					}
					// Valid option
					if (in_array( $received[$key], $this->defaults[$key]))
					{
						$args[$key] = $received[$key];
						continue;
					}
					// Invalid option
					$msg = 'Invalid parameter type for';
					$this->error($msg.' "'.$key.'"',E_USER_ERROR);
					continue;
				}
				// not set
				//if (!isset($received[$key]) || $received[$key] == null )
				if (!isset($received[$key]) )
				{
					switch(strval($this->defaults[$key]))
					{
						case REQUIRED:
							$msg = 'Missing required parameter';
							$this->error($msg.' "'.$key.'"',E_USER_ERROR);
							break;
						case NOTSET:
							break;
						default:
							$args[$key] = $this->defaults[$key];
					}
					continue;
				}
				// everything else
				$val = $received[$key];
				
#				if (validate( $val, $this->types[$key]))
#				{
#					$args[$key] = $val;
#					continue;
#				}
				// try to fix if invalid

				$val = sanitize( $val, $this->types[$key]);
#				if (validate($val,$this->types[$key]))
#				{
					$args[$key] = $val;
					continue;
#				}
			}

			return $args;
		}
		
		function error($msg,$type)
		{
			messagebox($msg , ERROR);
		}
	}		
	
	function nice_addslashes($string)
	{
		if( (bool) ini_get('magic_quotes_gpc'))
		{
			return $string;
		}
		return addslashes($string);
	}

	/*!
	 @function validate
	 @abstract Validate data.
	 @author seek3r
	 @discussion This function is used to validate input data. 
	 @syntax validate('type', 'match string');
	 @example validate('number',$somestring);
	*/

	/* Define your own types like this:
	$GLOBALS['appshore_data']['server']['validate_types']['number'] = '/^[0-9]+$/i';
	*/

	function validate($input, $type, $min='', $max='')
	{
		if($input === true || $input === false)
		{
			$input = (int)$input;
		}

		$minmaxas = 'text';

		switch ($type)
		{
			case 'alpha': /* letters and spaces */
				//$result = preg_match("/^[[:alpha:]\s]+$/", $input);
				$result = filter_var($input, FILTER_VALIDATE_REGEXP, 
					array("options"=>array("regexp"=>"/^[[:alpha:]\s]+$/")));
				break;
				
			case 'alphanumeric': /* just letters and numbers */
				//$result = preg_match("/^[a-zA-Z0-9]+$/", $input);
				$result = filter_var($input, FILTER_VALIDATE_REGEXP, 
					array("options"=>array("regexp"=>"/^[a-zA-Z0-9]+$/")));
				break;
				
			case 'alphanumericplus': /* letters and numbers, along with period, dash, underscore and spaces */
				//$result = preg_match("/^[\w\s.-]+$/", $input);
				$result = filter_var($input, FILTER_VALIDATE_REGEXP, 
					array("options"=>array("regexp"=>"/^[\w\s.-]+$/")));
				break;
				
			case 'bool': /* boolean value */
				$result = filter_var($input, FILTER_VALIDATE_BOOLEAN);
				break;			
								
			case 'sqlsafe': /* standard sql safe string */
			case 'string': /* standard sql safe string */
				//$result = preg_match("/(\%27)|(\')|(\-\-)|(\%23)|(#)/i", $input);
				//$result = filter_var($input, FILTER_SANITIZE_STRING);
				//$result = (preg_match("/^[[:print:]]+$/", $input) && !preg_match("/['\"<>*#;]/$/", $input));
				$result = filter_var($input, FILTER_VALIDATE_REGEXP, 
					array("options"=>array("regexp"=>"/^[[:print:]]+$/")));
				break;

			case 'object':
				$result = is_object($input);
				break;
				
			case 'float':
				$result = filter_var($input, FILTER_VALIDATE_FLOAT);
				$minmaxas = 'float';
				break;
				
			case 'email': /* email addres. Wouldnt allow root@localhost because requires at least one period after the @ */
				$result = filter_var($input, FILTER_VALIDATE_EMAIL);
				break;
				
			case 'int':
				$result = filter_var($input, FILTER_VALIDATE_INT);
				$minmaxas = 'int';
				break;
				
			case 'ip': 
				$result = filter_var($input, FILTER_VALIDATE_IP);
				break;
				
			case 'ipv4':
				$result = filter_var($input, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4);
				break;
				
			case 'ipv6':
				$result = filter_var($input, FILTER_VALIDATE_IP, FILTER_FLAG_IPV6);
				break;
				
			case 'isprint': /* html printable chars. excludes stuff dangerous to sql */
				$result = (preg_match("/^[[:print:]]+$/", $input) && !preg_match("/['\"<>*#;]/$/", $input));
				break;
				
			case 'htmlsafe':
			case 'ldap':
				$result = true;
				break;
				
			case 'utf8':
			    $result =  preg_match('%^(?:[\x09\x0A\x0D\x20-\x7E]	| [\xC2-\xDF][\x80-\xBF] | \xE0[\xA0-\xBF][\x80-\xBF] 
			    	| [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2} | \xED[\x80-\x9F][\x80-\xBF] | \xF0[\x90-\xBF][\x80-\xBF]{2} | [\xF1-\xF3][\x80-\xBF]{3} 
			        | \xF4[\x80-\x8F][\x80-\xBF]{2})*$%xs', $input);
				break;
				
			case 'password': /* password with rules enforced */
				$result = true;
				if(@isset($GLOBALS['appshore_data']['server']['pass_min_length']) && (int)$GLOBALS['appshore_data']['server']['pass_min_length'] > 1)
				{
					$pass_length = strlen($input);
					if ($pass_length < (int)$GLOBALS['appshore_data']['server']['pass_min_length'])
					{
						$msg = 'Password must be at least';
						$msg2 = 'characters';
						messagebox($msg.' '.$min_length.' '.$msg2, 'error');
						$result = false;
					}
				}

				if(@isset($GLOBALS['appshore_data']['server']['pass_require_non_alpha']) && $GLOBALS['appshore_data']['server']['pass_require_non_alpha'] == true)
				{
					if (!preg_match("[[:^alpha:]]", $input))
					{
						$msg = 'Password requires at least one non-alpha character';
						messagebox($msg , 'error');						
						$result = false;
					}
				}
				
				if(@isset($GLOBALS['appshore_data']['server']['pass_require_numbers']) && $GLOBALS['appshore_data']['server']['pass_require_numbers'] == true)
				{
					if (!preg_match("/^[0-9]+$/", $input))
					{
						$msg = 'Password requires at least one numeric character';
						messagebox($msg , 'error');						
						$result = false;
					}
				}

				if(@isset($GLOBALS['appshore_data']['server']['pass_require_special_char']) && $GLOBALS['appshore_data']['server']['pass_require_special_char'] == true)
				{
					if (preg_match("[[:^alnum:]]", $input))
					{
						$msg = 'Password requires at least one special character (non-letter and non-number)';
						messagebox($msg , 'error');						
						$result = false;
					}
				}
				break;
				
			default:
				return true;
				break;
		}
		
		if($min != '' || $max != '')
		{
			switch($minmaxas)
			{
				case 'int':
				  $num = intval($input);
			  	if((($min != '') && ($num < $min)) || (($max != '') && ($num > $max)))
					{
						$result = false;
					}
					break;
				case 'float':
				  $num = floatval($input);
				  if((($min != '') && ($num < $min)) || (($max != '') && ($num > $max)))
					{
						$result = false;
					}
					break;
				default: // for text
					$len = strlen($input);
					if((($min != '') && ($len < $min)) || (($max != '') && ($len > $max)))
					{
						$result = false;
					}
			}
		}
		return $result;
	}
				
	function sanitize($input, $type)
	{
		/* regexp doesnt like PHP boolean types, so I convert these to integers */

		switch ($type)
		{
			case 'alphanumeric': /* just letters and numbers */
				$result = preg_replace("/[^a-zA-Z0-9]/", "", $input);	
				break;
				
			case 'sqlwords': /* just letters and numbers, underscore */
				$result = preg_replace("/[^a-zA-Z0-9_]/", "", $input);	
				break;
				
			case 'number': /* numbers only */
			case 'integer': 
			case 'int': 
				$result = filter_var($input, FILTER_SANITIZE_NUMBER_INT);
				break;
				
			case 'float':
				$result = filter_var($input, FILTER_SANITIZE_NUMBER_FLOAT);
				break;
				
			case 'sqlsafe': /* standard sql safe string */
				$search = array(
			       	'/;/',                                			// semi colon ...       
			     	'/[\x00-\x09\x0b\x0c\x0e-\x1f]/i'    	// all other non-ascii  minus \x7f-\x9f
			   		);
			   	$result = preg_replace( $search,'', nice_addslashes($input));	
			   	break;		
			   	
			case 'string':
				$search = array(
			     	'/[\x00-\x09\x0b\x0c\x0e-\x1f]/i'    	// all other non-ascii minus \x7f-\x9f
			   		);
			   	$result = preg_replace( $search,'', nice_addslashes($input));			
				break;	
							
			case 'bool': /* boolean value */
				$test = preg_match("/^(0|1|true|false)$/i", $input);
				if(!$test)
					$result = false;
				else
					$result = $input;
				break;
				
			case 'htmlsafe':
				$pattern[0] = '/\&/';
				$pattern[1] = '/</';
				$pattern[2] = "/>/";
				$pattern[3] = '/\n/';
				$pattern[4] = '/"/';
				$pattern[5] = "/'/";
				$pattern[6] = "/%/";
				$pattern[7] = '/\(/';
				$pattern[8] = '/\)/';
				$pattern[9] = '/\+/';
				$pattern[10] = '/-/';
				$replacement[0] = '&amp;';
				$replacement[1] = '&lt;';
				$replacement[2] = '&gt;';
				$replacement[3] = '<br>';
				$replacement[4] = '&quot;';
				$replacement[5] = '&#39;';
				$replacement[6] = '&#37;';
				$replacement[7] = '&#40;';
				$replacement[8] = '&#41;';
				$replacement[9] = '&#43;';
				$replacement[10] = '&#45;';
				$result = preg_replace($pattern, $replacement, $input);
				break;
				
			case 'ldap':
				$result = preg_replace("/(\)|\(|\||&)/", "", $input);
				break;
				
			case 'utf8':
				$result = strtr($input, "???????¥µÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýÿ", "SOZsozYYuAAAAAAACEEEEIIIIDNOOOOOOUUUUYsaaaaaaaceeeeiiiionoooooouuuuyy");	
				break;

			case 'any': 		// do nothing
			default:
				$result = $input;
		}
		
		return $result;
	}

	function reg_var_sub($type, $default = NULL, $value = NULL)
	{
		if (!isset($value))
		{
			if($default == NULL)
			{
				return;
			}
			return $default;
		}
		
		if (!is_array($value))
		{
#			if(validate($value,$type))
#			{
#				return $value;
#			}
			$value = sanitize($value,$type);
			if(validate($value,$type))
			{
				return $value;
			}
			return $default;
		}

		foreach($value as $key=>$val)
		{
			if (@isset($type[$key]))
			{
				if (@isset($type[$key]))
				{
					$val_type = $type[$key];
				}
				else
				{
					$val_type = 'string';
				}
			}
			else
			{
				$val_type = $type;
			}

			if (@isset($default[$key]))
			{
				if (@isset($default[$key]))
				{
					$val_default = $default[$key];
				}
				else
				{
					$val_default = NOTSET;
				}
			}
			else
			{
				$val_default = $default;
			}

			$result[$key] = reg_var_sub($val_type, $val_default, $val);
		}
		return $result;
	}

	/*
 		method choices are: any, post, get, cookie, session, server, and global. Default will be used internally only.
	*/

	function reg_var()
	{
		$args = new safe_args();
		$args->set('varname',		REQUIRED, 'alphanumericplus');
		$args->set('method',		'any', 'any');
		$args->set('type',			'alphanumericplus', 'alpha');
		$args->set('default',		null, 'any');
		$args->set('appname',		'api', 'string');
		$args->set('register', 		true, 'bool');
		$args = $args->get(func_get_args());

		if($args['method'] == 'any')
		{
			$args['method'] = Array('POST','GET','COOKIE','SESSION','SERVER');
		}
		elseif(is_string($args['method']))
		{
			$args['method'] = explode(',',$args['method']);
		}
		elseif(!is_array($args['method']))
		{
			$args['method'] = Array($args['method']);
		}

		$value = null;
		foreach ($args['method'] as $method)
		{
			$method = strtoupper($method);
			switch($method)
			{
				case 'GLOBAL':
					if(@isset($GLOBALS[$args['varname']]))
					{
						$value = $GLOBALS[$args['varname']];
						break 2;
					}
					break;
				case 'POST':
				case 'GET':
				case 'COOKIE':
				case 'FILES':
				case 'SERVER':
					if(@isset($GLOBALS['_'.$method][$args['varname']]))
					{
						$value = $GLOBALS['_'.$method][$args['varname']];
						break 2;
					}
					break;
				case 'SESSION':
					if(@isset($_SESSION['appshore_session'][$args['varname']]))
					{
						$value = $_SESSION['appshore_session'][$args['varname']];
						break 2;
					}
					break;
				default:
					if(@isset($GLOBALS[$method][$args['varname']]))
					{
						$value = $GLOBALS[$method][$args['varname']];
						break 2;
					}
			}
		}
		$result = reg_var_sub($args['type'], $args['default'], $value);

		if(isset($result))
		{
			if($args['register'])
			{
				$GLOBALS['appshore_data'][$args['appname']][$args['varname']] = $result;
			}
			return $result;
		}
		return;
	}

	/*!
	 @function get_var
	 @abstract retrieve a value from either a POST, GET, COOKIE, SERVER or from a class variable.
	 @author skeeter
	 @discussion This function is used to retrieve a value from a user defined order of methods. 
	 @syntax get_var('id',array('HTTP_POST_VARS'||'POST','HTTP_GET_VARS'||'GET','HTTP_COOKIE_VARS'||'COOKIE','GLOBAL','DEFAULT'));
	 @example $this->id = get_var('id',array('HTTP_POST_VARS'||'POST','HTTP_GET_VARS'||'GET','HTTP_COOKIE_VARS'||'COOKIE','GLOBAL','DEFAULT'));
	 @param $variable name
	 @param $method ordered array of methods to search for supplied variable
	 @param $default_value (optional)
	*/
	function get_var()
	{
		$args = new safe_args();
		$args->set('varname', 	REQUIRED, 'alphanumericplus');
		$args->set('method', 	'any', 'any');
		$args->set('type', 		'alphanumericplus', 'alpha');
		$args->set('default', 	NOTSET, 'any');
		$args = $args->get(func_get_args());

		$args['register'] = false;
		return reg_var($args);
	}

	
