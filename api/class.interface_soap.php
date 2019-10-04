<?php
	/**************************************************************************\
	* phpGroupWare                                                             *
	* http://www.phpgroupware.org                                              *
	* This file written by Dan Kuykendall <dan@kuykendall.org>                 *
	* Copyright (C) 2003 Dan Kuykendall                                        *
	* -------------------------------------------------------------------------*
	* This library is part of the phpGroupWare API                             *
	* http://www.phpgroupware.org/api                                          * 
	* ------------------------------------------------------------------------ *
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

	class api_interface_soap
	{
		var $methodName;
		var $mainnodename;
		var $op;
		var $inputs;
		
		function __construct()
		{
			$this->parse();
			$GLOBALS['appshore_data']['api']['op'] = $this->op;
		}
		
		function soapFault($code, $text)
		{
			$output  = "<SOAP-ENV:Fault>\n";
			$output .= "<faultcode>".$code."</faultcode>\n";
			$output .= "<faultstring>".$text."</faultstring>\n";
			$output .= "</SOAP-ENV:Fault>\n";
			$this->output($output);
		}	
		
		
		function soapResponse($result)
		{
			$output  = "<SOAP-ENV:Response>\n";
			$output .=  $this->add_vars($GLOBALS['appshore']->session->sid(), 'sid');
			if( !empty($result) )
				$output .=  $this->add_vars($result);
			$output .= "</SOAP-ENV:Response>\n";
			$this->output($output);
		}	

		function output($result)
		{
			$output = "<?xml version=\"1.0\"?>\n";
			$output .= "<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n";
			$output .= "<SOAP-ENV:Body>\n";
			$output .= $result;
			$output .= "</SOAP-ENV:Body>\n";
			$output .= "</SOAP-ENV:Envelope>\n";

			header('Content-type: text/xml');
			header('Content-Length: '.strlen($output));
			echo $output;

			exit();
		}

		function get_op()
		{
			$this->op;
		}

		function good_login()
		{
			// sid will be provided by default
			$this->soapResponse(null);
		}

		function bad_login()
		{
			// sid will be provided by default
			$this->failed_login('invalid');
		}
		
		function failed_login($reason = 'missing')
		{
			if($reason == 'invalid')
			{
				$code = 4;
				$msg = 'Authentication Failed!';
			}
			elseif($reason == 'missing')
			{
				$code = 3;
				$msg = 'Username and/or password missing.';
			}
			$this->soapFault($code, $msg);
		}

		function login()
		{
			$this->soapFault('1', 'Please login.');
		}

		function logout()
		{
		}
		

		function ping()
		{
			$company = getOneAssocArray( 'select company_alias from company limit 1');
			$result['ping'] = PRIVATE_LABEL.$company['company_alias'];
			$this->soapResponse($result);
		}	

		function access_denied($methodname, $inputs = '')
		{
			$this->soapFault('99', 'Access denied to '.$methodname);
		}
		
		function get_inputs()
		{
			return $this->inputs;
		}

		function handle_nextmatchs($current_position, $record_count)
		{

		}

		function handle_result($result)
		{
			$this->soapResponse($result);
		}
		
		
		function parse()
		{
			// we reject connections from browsers
			if(!isset($GLOBALS['HTTP_RAW_POST_DATA']))
			{
				header('Location: index.php');
				exit;
			}			
			
			if(!strstr($GLOBALS['HTTP_RAW_POST_DATA'], '<?xml'))
				$GLOBALS['HTTP_RAW_POST_DATA'] = "<?xml version=\"1.0\"?>\n".$GLOBALS['HTTP_RAW_POST_DATA'];
			
			$tmp = explode ("\n", $GLOBALS['HTTP_RAW_POST_DATA']);
			$num = count($tmp);
			$hit_start = false;
			$soap_input = '';
			for ( $i = 0; $i < $num; $i++)
			{
				if($hit_start)
					$soap_input .= $tmp[$i]."\n";
				else if(stristr($tmp[$i], '<?xml'))
				{
					$hit_start = true;
					$soap_input .= $tmp[$i]."\n";
				}
			}

			$parser = xml_parser_create();
			xml_parser_set_option($parser, XML_OPTION_CASE_FOLDING, 0);
			xml_parser_set_option($parser, XML_OPTION_SKIP_WHITE,   1);
			xml_parse_into_struct($parser, $soap_input, $xml_vals, $xml_index);
			xml_parser_free($parser);
			$this->xml_index = $xml_index;
			$this->xml_vals = $xml_vals;
			unset($xml_index, $xml_vals);

			$this->mainnodename = $this->xml_vals[$this->xml_index['SOAP-ENV:Body'][0]+1]['tag'];
			$this->mainnodelevel = $this->xml_vals[$this->xml_index['SOAP-ENV:Body'][0]+1]['level'];
			$tmpmeth = explode(':', $this->mainnodename);
			$this->methodName = $tmpmeth[1];
			switch ($this->methodName)
			{
				case 'system.logout':
					$this->op = 'base.auth.logout';
					break;
				default:
					$this->op = $this->methodName;
			}

			if($this->xml_vals[$this->xml_index['SOAP-ENV:Body'][0]+2]['tag'] != $this->mainnodename && $this->xml_vals[$this->xml_index['SOAP-ENV:Body'][0]+2]['tag'] != 'SOAP-ENV:Body')
			{
				$this->i = $this->xml_index['SOAP-ENV:Body'][0]+2;
				while($this->xml_vals[$this->i]['tag'] != $this->mainnodename)
				{
					$additional_inputs = $this->parse_params();
					$this->inputs = array_merge((array)$this->inputs, (array)$additional_inputs);
				}
			}
		}

		function parse_params()
		{
			switch($this->xml_vals[$this->i]['type'])
			{
				case 'complete':
					switch($this->xml_vals[$this->i]['attributes']['xsi:type'])
					{
						case 'SOAP-ENC:base64':
							$value = base64_decode($this->xml_vals[$this->i]['value']);
							break;
						case 'xsd:boolean':
							$value = $this->xml_vals[$this->i]['value'];
							settype($value,'boolean');
							break;
						case 'xsd:int':
						case 'xsd:i4':
						case 'xsd:double':
						case 'dateTime.iso8601':
						case 'xsd:string':
						default:
							$name = $this->xml_vals[$this->i]['tag'];
							$value = $this->xml_vals[$this->i]['value'];
							break;
					}
					$this->i++;
					if($this->op == 'base.auth.login')
					{
						if($name == 'appshore_user')
						{
							$_GET['appshore_user'] = $value;
						}
						elseif($name == 'appshore_pass')
						{
							$_GET['appshore_pass'] = $value;
						}
						return;
					}
					elseif($name == 'sid')
					{
						$_GET['sid'] = $value;
						return;
					}
					else
					{
						if(isset($name))
							return array($name => $value);
						else
							return $value;
					}
					break;
				case 'open':
					switch ($this->xml_vals[$this->i]['attributes']['xsi:type'])
					{
						case 'SOAP-ENC:Array':
							$name = $this->xml_vals[$this->i]['tag'];
							$this->i++;
							while($this->xml_vals[$this->i]['type'] != 'close')
							{
								$tmp = $this->parse_params();
								if(isset($tmp))
								{
									if(is_array($tmp))
										$result[] = $tmp[key($tmp)];
									else
										$result[] = $tmp;
								}
							}
							$this->i++;
							return array($name=>$result);
							break;
						default:
							$name = $this->xml_vals[$this->i]['tag'];
							$this->i++;
							while($this->xml_vals[$this->i]['type'] != 'close')
							{
								$tmp = $this->parse_params();
								if(isset($tmp) && is_array($tmp))
								{
									if(key($tmp) !==0 && key($tmp) != 'soapVal')
										$result[key($tmp)] = $tmp[key($tmp)];
									else
										$result[] = $tmp[key($tmp)];
								}
							}
							$this->i++;
							return array($name=>$result);
					}
					break;
				case 'close':
					return;
					break;
			}
		}

		function add_vars($params, $name='soapVal')
		{
			//$this->i++;
			if(!is_array($params))
				$result =  $this->add_params_type_handler($params, $name)."\n";
			else
			{
				$result = "<$name>\n";
				foreach($params as $key=>$val)				
				{
					if(is_array($val))
					{
						if(!is_int(key($params)))
							$result .= $this->add_vars($val, key($params));
						else
							$result .= $this->add_vars($val);
					}
					else
						$result .= $this->add_params_type_handler($val,$key)."\n";
				}
				$result .= "</$name>\n";
			}
			return $result;
		}

		function add_params_type_handler($value, $name='soapVal')
		{
			switch(gettype($param))
			{
				case 'boolean':
					return "<$name xsi:type=\"xsd:boolean\">$value</$name>";
					break;
				case 'double':
					return "<$name xsi:type=\"xsd:double\">$value</$name>";
					break;
				case 'integer':
					return "<$name xsi:type=\"xsd:int\">$value</$name>";
					break;
				case 'array':
					//need to handle this
					break;
				default:
					return "<$name xsi:type=\"xsd:string\">$value</$name>";
			}
		}
	}
