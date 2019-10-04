<?php
/**************************************************************************\
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* Brice MICHEL <bmichel@appshore.com>                                      *
* Copyright (C) 2004 - 2009 Brice MICHEL                                   *
\**************************************************************************/


class base_localization
{
	// a way to retrieve date format without knowing it
	function timeFormat()	
	{
		//return 'yyyy-mm-dd';
		
		$val = $this->timeToLocal( date( '1999-11-22 10:56'));
	
		$val = str_replace( '10', 'hh', $val);
		$val = str_replace( '56', 'mm', $val);		
		
		return $val;	
	}	

   	// convert a GMT date and time to user Timezone date and time
    function gmtToTZ( $dateTime = 'now' )
    {  
    	if( $dateTime == '0000-00-00 00:00:00')
    		return $dateTime;

    	if( $dateTime == null )
    		return '';

    	return $this->convertDateTime( $dateTime, $this->getTZOffset());
    }
    
   	// convert a GMT date to user Timezone date
    function gmtToTZDate( $date = 'today')
    {  
    	if( $date == '0000-00-00')
    		return $date;

    	if( $date == null )
    		return '';

    	return $this->convertDateTime( $date, $this->getTZOffset(), 'Y-m-d', 'Y-m-d');
    }         

   	// convert a GMT time to user Timezone date and time
    function gmtToTZTime( $time = 'now' )
    {  
    	if( $time == '00:00:00')
    		return $time;

    	if( $time == null )
    		return '';

    	return $this->convertDateTime( $time, $this->getTZOffset(), 'H:i:s', 'H:i:s');
    }
    
   	// convert a local date and time to a GMT date and time
    function TZToGmt( $dateTime = 'now' )
    {  
   		if( strtotime($dateTime) === false )
   			$dateTime = 'now';
   			
//   		return strftime( '%Y-%m-%d %H:%M:%S', strtotime($dateTime)-$this->getTZOffset());	    
    	return $this->convertDateTime( $dateTime, -$this->getTZOffset());
    }
    
   	// convert a GMT date and time to user Timezone date and time with localized date/time format
    function gmtToTZLocal( $dateTime = 'now', $timezone_id = null, $locale_date_id = null, $locale_time_id = null)
    {  
    	if( $dateTime == '0000-00-00 00:00:00' )
    		return $dateTime;
   			
    	return $this->translateDate( $this->convertDateTime( $dateTime, $this->getTZOffset($timezone_id), 'Y-m-d H:i:s', $this->localDateTimeFormat( $locale_date_id, $locale_time_id)), true);
    }   
    
   	// convert a GMT date to user Timezone date with localized date format
    function gmtToTZDateLocal( $date = 'today', $timezone_id = null, $locale_date_id = null)
    {  
    	if( $date == '0000-00-00')
    		return $date;

    	return $this->translateDate( $this->convertDateTime( $date, $this->getTZOffset($timezone_id), 'Y-m-d', $this->localDateFormat( $locale_date_id)), true);
    }  
    
   	// convert a GMT time to user Timezone time with localized time format
    function gmtToTZTimeLocal( $time = 'now', $timezone_id = null, $locale_time_id = null)
    {  
    	if( $time == '00:00:00')
    		return $time;

		return $this->convertDateTime( $time, $this->getTZOffset($timezone_id), 'H:i:s', $this->localTimeFormat( $locale_time_id));
    }             
    
   	// convert a date to user local date
    function datetimeToLocal( $dateTime = null, $locale_date_id = null, $locale_time_id = null)
    {  
    	if( $dateTime == null || $dateTime == '0000-00-00 00:00:00')
    		return '';
 
    	return $this->translateDate( $this->convertDateTime( $dateTime, 0, 'Y-m-d H:i:s', $this->localDateTimeFormat( $locale_date_id, $locale_time_id)), true);
    }      
       
   	// convert a date to user local date
    function dateToLocal( $date = null, $locale_date_id = null)
    {  
    	if( $date == null  || $date == '0000-00-00')
    		return '';

    	return $this->translateDate( $this->convertDateTime( $date, 0, 'Y-m-d', $this->localDateFormat( $locale_date_id)), true);
    }    

   	// convert a time to user local time
    function timeToLocal( $time = null, $locale_time_id = null)
    {  
    	if( $time == null || $time == '00:00:00' )
    		return '';

    	return $this->convertDateTime( $time, 0, 'H:i:s', $this->localTimeFormat( $locale_time_id));
    }   

    
   	// convert a date and a time to user local date and time
    function localToDatetime( $dateTime = null)
    {  
    	if( $dateTime == null || $dateTime == '')
    		return '';
    		
		return ($this->localToDate($dateTime).' '.$this->localToTime($dateTime));
    }      

   	// convert user local date to generic date
    function localToDate( $date = null)
    {      
		$date = $this->translateDate( $date, false);
    
    	$temp = strptime( $date, $this->localDateFormat());

    	if( $temp === false )
    		return '';

    	return sprintf('%04d-%02d-%02d', $temp['tm_year']+1900,$temp['tm_mon']+1,$temp['tm_mday']);
    }    
    
   	// convert user local time to generic time
    function localToTime( $time = null)
    {         
		$time = $this->translateDate( $time, false);

    	$temp = strptime( $time, $this->localDateTimeFormat());

    	if( $temp === false )
    		return '';

    	return sprintf('%02d:%02d:%02d',$temp['tm_hour'],$temp['tm_min'],$temp['tm_sec']);
    } 

    
    function convertDateTime( $dateTime = null, $offset = 0, $InFormat = 'Y-m-d H:i:s', $OutFormat = 'Y-m-d H:i:s')
    {
    	if( ($date = date_create_from_format( $InFormat, $dateTime)) == null )
    		if( ($date = date_create( $dateTime)) == null )
    			return '';
    	
    	if( $offset != 0 )
    		date_modify( $date, ''.$offset.' seconds');
    		
    	$OutFormat = str_replace( array('M','l','p','%','B','h','e'), array('i','g','a','','F','M','j'), $OutFormat);
    	
    	return date_format( $date, $OutFormat);    	
    }    
    
    
    function localDateFormat($locale_date_id = null)
    {
    	return ($locale_date_id?$locale_date_id:$GLOBALS['appshore_data']['current_user']['locale_date_id']);
    }
    
    function localTimeFormat($locale_time_id = null)
    {
    	return ($locale_time_id?$locale_time_id:$GLOBALS['appshore_data']['current_user']['locale_time_id']);
    }
    
    function localDateTimeFormat($locale_date_id = null, $locale_time_id = null)
    {
    	return (($locale_date_id?$locale_date_id:$GLOBALS['appshore_data']['current_user']['locale_date_id']).' '.
    		($locale_time_id?$locale_time_id:$GLOBALS['appshore_data']['current_user']['locale_time_id']));
    }
    
    
    function translateDate( $date, $tolocal = true)
    {    

    	if( strpos($GLOBALS['appshore_data']['current_user']['locale_date_id'], '%B') !== false )
    	{
    		switch ( $GLOBALS['appshore_data']['current_user']['language_id'])
    		{
    			case 'de':
    				$localmonths = array('Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember');
					break;
    			case 'es':
    				$localmonths = array('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre');
    				break;
    			case 'fr':
    				$localmonths = array('Janvier','Février','Mars','Avril','Mai','Juin','Juillet','Août','Septembre','Octobre','Novembre','Décembre');
    				break;	
    			case 'ja':
    				$localmonths = array('1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月');
    				break;
    			case 'pt':
    				$localmonths = array('Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro');  
    				break;		
    			case 'zh':
    			case 'zh-cn':
    				$localmonths = array('一','二','三','四','五','六','七','八','九','十','十一','十二');
    				break;
    			default:
    				return $date;
    		}
	     	$months = array('January','February','March','April','May','June','July','August','September','October','November','December');
    	}
    	else if( strpos($GLOBALS['appshore_data']['current_user']['locale_date_id'], '%h') !== false )
    	{
       		switch ( $GLOBALS['appshore_data']['current_user']['language_id'])
    		{
    			case 'de':
    				$localmonths = array('Jan','Feb','Mär','Apr','Mai','Jun','Jul','Aug','Sep','Okt','Nov','Dez');
					break;
    			case 'es':
    				$localmonths = array('Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic');
    				break;
    			case 'fr':
    				$localmonths = array('Jan','Fév','Mar','Avr','Mai','Jui','Jul','Aou','Sep','Oct','Nov','Déc');
    				break;	
    			case 'ja':
    				$localmonths = array('1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月');
    				break;
    			case 'pt':
    				$localmonths = array('Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez');  
    				break;		
    			case 'zh':
    			case 'zh-cn':
    				$localmonths = array('一','二','三','四','五','六','七','八','九','十','十一','十二');
    				break;
    			default:
    				return $date;
    		}
	     	$months = array('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');    	
    	}
		else
			return $date;

		if( $tolocal == true )
			return strtr( $date, array_combine($months, $localmonths));

		return strtr( $date, array_combine($localmonths, $months));
    }
    
    
	function timezones() 
	{
	    $key = 0;
	    foreach( DateTimeZone::listIdentifiers() as $zone) 
	    {
	      	list( $continent, $city, $subcity) = explode('/',$zone);
			if( in_array($continent, array('Africa','America','Asia','Atlantic','Australia','Europe','Indian','Pacific','US')) )
			{
				$timezones[$key]['option_id'] = $zone;
				if( isset($subcity) )
				{
					$timezones[$key]['option_id'] = $continent.'/'.$subcity;
					$timezones[$key]['option_name'] = $continent.', '.str_replace('_', ' ', $subcity);
				}
				else
					$timezones[$key]['option_name'] = $continent.', '.str_replace('_', ' ', $city);
				$key++;
	      	}
	    }
	    
	    asort($timezones);
	    
	    return $timezones;
    }
    
    function timezone( $zone = 'Europe/London') 
	{
       	list( $continent, $city, $subcity) = explode('/',$zone);
		if( in_array($continent, array('Africa','America','Asia','Atlantic','Australia','Europe','Indian','Pacific','US')) )
		{
			if( isset($subcity) )
				return $continent.', '.str_replace('_', ' ', $subcity);
			else
				return $continent.', '.str_replace('_', ' ', $city);
      	}
      	else
      		return $zone;
    }    
           
    function setTZOffset()
    {
 		date_default_timezone_set($GLOBALS['appshore_data']['current_user']['timezone_id']?$GLOBALS['appshore_data']['current_user']['timezone_id']:'GMT');
		return ($GLOBALS['appshore_data']['current_user']['timezone_offset'] = date('Z'));
    }
    
               
    function getTZOffset($timezone_id = null)
    {
		if( $timezone_id && $timezone_id != $GLOBALS['appshore_data']['current_user']['timezone_id'] )
		{
			$date = date_create(null, timezone_open($timezone_id));
			return date_format($date, 'Z');
		}
		return ($GLOBALS['appshore_data']['current_user']['timezone_offset']?$GLOBALS['appshore_data']['current_user']['timezone_offset']:$this->setTZOffset());
    }
                                                
   	// convert generic format to local format                                                           
    function decimalToCurrency( $value, $currencySymbol = false, $dec = 0)
    {
    	if ( $currencySymbol == false ) 
	    	return number_format( $value, $dec, $this->decimalPoint(), $this->thousandsSeparator());
    	else
	    	return $this->currencySymbol().' '.
	    		number_format( $value, $dec, $this->decimalPoint(), $this->thousandsSeparator());
    }	
    
   	// convert local format to generic format
    function currencyToDecimal( $value, $dec = 0 )
    {
		list( $integer, $decimal) = explode( $this->decimalPoint(), $value);
		
		$remove = array( ' ', '.', ',', $this->thousandsSeparator());
		$integer = str_replace($remove, '', $integer);		
		
		if ( $dec == 0 ) 
			return sprintf( '%s', $integer);
		else
			return sprintf( '%s.%s', $integer, $decimal);
    }	

   
    function decimalPoint()
    {	
    	if( isset($GLOBALS['appshore_data']['current_user']['decimal_point']) )
    		return $GLOBALS['appshore_data']['current_user']['decimal_point'];
    	else
	    	return '.';
    }
    
    
    function thousandsSeparator()
    {	
    	if( isset($GLOBALS['appshore_data']['current_user']['thousands_separator']) )
    		return $GLOBALS['appshore_data']['current_user']['thousands_separator'];
    	else
	    	return ',';
    }	        
    	        
    function currencySymbol()
    {	
    	if( isset($GLOBALS['appshore_data']['current_user']['currency_id']) )
    		return $GLOBALS['appshore_data']['current_user']['currency_id'];
    	else
	    	return '';
    }	

	function getUserPreferences()
	{
		if( isset($GLOBALS['appshore_data']['current_user']['theme_id']) == false )
			$GLOBALS['appshore_data']['current_user']['theme_id'] = $GLOBALS['appshore_data']['server']['theme_id'];
			
		if( isset($GLOBALS['appshore_data']['current_user']['locale_date_id']) == false )
			$GLOBALS['appshore_data']['current_user']['locale_date_id']	= $GLOBALS['appshore_data']['server']['locale_date_id'];
			
		if( isset($GLOBALS['appshore_data']['current_user']['locale_time_id']) == false )
			$GLOBALS['appshore_data']['current_user']['locale_time_id']	= $GLOBALS['appshore_data']['server']['locale_time_id'];
			
		if( isset($GLOBALS['appshore_data']['current_user']['charset_id']) == false )
			$GLOBALS['appshore_data']['current_user']['charset_id']	= $GLOBALS['appshore_data']['server']['charset_id'];
			
		if( isset($GLOBALS['appshore_data']['current_user']['timezone_id']) == false )
			$GLOBALS['appshore_data']['current_user']['timezone_id'] = $GLOBALS['appshore_data']['server']['timezone_id'];
			
		if( isset($GLOBALS['appshore_data']['current_user']['currency_id']) == false )
			$GLOBALS['appshore_data']['current_user']['currency_id'] = $GLOBALS['appshore_data']['server']['currency_id'];
						
		if( isset($GLOBALS['appshore_data']['current_user']['nbrecords']) == false )
			$GLOBALS['appshore_data']['current_user']['nbrecords'] = $GLOBALS['appshore_data']['server']['nbrecords'];	
			
		if( isset($GLOBALS['appshore_data']['current_user']['confirm_delete']) == false )
			$GLOBALS['appshore_data']['current_user']['confirm_delete']	= $GLOBALS['appshore_data']['server']['confirm_delete'];
														
		if( isset($GLOBALS['appshore_data']['current_user']['app_name']) == false )
			$GLOBALS['appshore_data']['current_user']['app_name'] = $GLOBALS['appshore_data']['server']['default_start_op'];											
		
		//specific case of the display language
		// set up of language parameters
		// default value
       	$language = $GLOBALS['appshore_data']['server']['language_id'];				
		if( isset($GLOBALS['appshore_data']['server']['auto_language']) )
		{
			if( $GLOBALS['appshore_data']['server']['auto_language'] === true )
			{
				if ( isset($_POST['forced_language_id']) )
		            $language = $_POST['forced_language_id'];
				else if ( isset($_COOKIE['language']))
		            $language = $_COOKIE['language'];
				else if ( isset($_SERVER['HTTP_ACCEPT_LANGUAGE']) )
		    	{
		        	$language = explode(',', $_SERVER['HTTP_ACCEPT_LANGUAGE']);
		            $language = explode(';', $language[0]);
		            $language = strtolower(trim($language[0]));
		            if( isset($GLOBALS['appshore_data']['server']['languages_enable']) && in_array( $language,$GLOBALS['appshore_data']['server']['languages_enable']) == false  )
		            	$language = $GLOBALS['appshore_data']['server']['language_id'];
		        }
		        else if( isset($GLOBALS['appshore_data']['current_user']['language_id']) && ($GLOBALS['appshore_data']['current_user']['language_id'] != '') )
		        	$language = $GLOBALS['appshore_data']['current_user']['language_id'];
			}
		}
		else if( isset($GLOBALS['appshore_data']['current_user']['user_id']) && ($GLOBALS['appshore_data']['current_user']['user_id'] == 'anonymous') )
		{
			if ( isset($_POST['forced_language_id']) )
	            $language = $_POST['forced_language_id'];
			else if ( isset($_COOKIE['language']))
	            $language = $_COOKIE['language'];
			else if ( isset($_SERVER['HTTP_ACCEPT_LANGUAGE']) )
	    	{
	        	$language = explode(',', $_SERVER['HTTP_ACCEPT_LANGUAGE']);
	            $language = explode(';', $language[0]);
	            $language = strtolower(trim($language[0]));
	            if( isset($GLOBALS['appshore_data']['server']['languages_enable']) && in_array( $language,$GLOBALS['appshore_data']['server']['languages_enable']) == false  )
	            	$language = $GLOBALS['appshore_data']['server']['language_id'];
	        }
		}
		else
		{
		
			if ( isset($_POST['forced_language_id']) && $_POST['forced_language_id'] == 'default' )
	        	$language = $GLOBALS['appshore_data']['current_user']['language_id'];
			else if ( isset($_POST['forced_language_id']) )
	            $language = $_POST['forced_language_id'];
			else if ( isset($_COOKIE['language']))
	            $language = $_COOKIE['language'];
#			else if ( isset($_SESSION['current_user']['language_id']))
#	            $language = $_SESSION['current_user']['language_id'];
	        else if( isset($GLOBALS['appshore_data']['current_user']['language_id']) && ($GLOBALS['appshore_data']['current_user']['language_id'] != '') )
	        	$language = $GLOBALS['appshore_data']['current_user']['language_id'];
	    }    
	    
		if( ($lang = getOneAssocArray('SELECT * FROM global_languages where language_id = "'.$language.'"')) == null )
			if( ($lang = getOneAssocArray('SELECT * FROM global_languages where language_id = "'.substr($language,0,2).'"')) == null )
				$lang = getOneAssocArray('SELECT * FROM global_languages where language_id = "'.$GLOBALS['appshore_data']['server']['language_id'].'"');

		$GLOBALS['appshore_data']['current_user']['language_id'] = $lang['language_id'];
		$GLOBALS['appshore_data']['current_user']['google_language_code'] = $lang['google_language_code'];
		$GLOBALS['appshore_data']['current_user']['language_direction'] = $lang['language_direction'];		
		setcookie( 'language', $GLOBALS['appshore_data']['current_user']['language_id']);
		
		$this->setTZOffset();
		
		if( isset($GLOBALS['appshore_data']['current_user']) )
		{
			if( isset($_SESSION['current_user']) )			
				$_SESSION['current_user'] = array_merge((Array)$_SESSION['current_user'], (Array)$GLOBALS['appshore_data']['current_user']);	
			else
				$_SESSION['current_user'] = (Array)$GLOBALS['appshore_data']['current_user'];	
		}	
	}	
	
	
	function checkTimezone()
	{
		if( $GLOBALS['appshore_data']['current_user']['timezone_id'] == '')
		{
			$_SESSION['current_user']['timezone_id'] = $GLOBALS['appshore_data']['current_user']['timezone_id'] = $GLOBALS['appshore_data']['server']['timezone_id'];				
			executeSQL( 'update users set timezone_id = "'.$GLOBALS['appshore_data']['current_user']['timezone_id'].
				'" where user_id = "'.$GLOBALS['appshore_data']['current_user']['user_id'].'"');
			messagebox( 'Your time zone preference has not been set. Click here to set it to your location', 'link', 'preferences.lookandfeel_base.edit');
		}

		$this->setTZOffset();
	}		

}
	
