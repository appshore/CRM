<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2009 Brice Michel                                     *
 ***************************************************************************/

// check a phone number (international)
function is_time( &$time)
{
    list($h, $m) = explode(':', $time);

    if ( strlen($m) == 0 )
    {
        $m = $h;
        $h = '00';
        $time = $h.':'.$m;
    }

    if (strlen($m) == 1 )
    {
        $m[1] = $m[0];
        $m[0] = '0';
        $time = $h.':'.$m;
    }

    if (strlen($h) == 2 && $h[0] == '0' )
            $format = 'H:i';
    else
            $format = 'G:i';

    $dummy = date ( $format , mktime( $h, $m));

    if ( $dummy != $time )
        return false;
    else
        return true;
}

// check a phone number (international)
function is_date($date)
{   	
    list($y, $m, $d) = explode('-', $date);
    $dummy = date("Y-m-d", mktime (0,0,0,$m,$d,$y));
    if ($dummy != $date)
        return false;
    else
        return true;
}

// check a phone number (international)
function is_phone($phone)
{
	return true;

    if ( !preg_match("/^[ ]*[+]*[(]*[ ]*[0-9]*[ ]*[)]*[-]*[ ]*[0-9]*[ ]*[-]*[ ]*[0-9]*[-]*[ ]*[0-9]*[-]*[ ]*[0-9]*[ ]*$/",$phone) );
        return false;
    return true;
}


// check an alias address
function is_alias($name)
{
    if ( !preg_match('/^[a-zA-Z0-9]+$/i', $name) )
        return false;

    return true;
}

function is_email(&$email)
{
	$regexp = "/^[a-z0-9][a-z0-9_.-]*@[a-z0-9.-]+\.[a-z]{2,4}$/i";
	
	$email = rtrim($email);

	if( preg_match($regexp, $email) )
		return true;

	return false;
}    

function is_emailDomain($email)
{
	$regexp = "/^[a-z0-9][a-z0-9_.-]*@[a-z0-9.-]+\.[a-z]{2,4}$/i";

	if( preg_match($regexp, $email) )
	{
		list( $username, $domain) = split( '@', $email);
		// checks for if MX records in the DNS
		$mxhosts = array();
		if(!getmxrr( $domain, $mxhosts)) 
		{
			// no mx records, ok to check domain
			if (!fsockopen( $domain, 25, $errno, $errstr, 30)) 
				return false;
			else 
				return true;
		} 
		else 
		{
			// mx records found
			foreach ( $mxhosts as $host) 
			{
				if (fsockopen( $host, 25, $errno, $errstr, 30)) 
					return true;
			}
			return false;
		}
	
		// attempts a socket connection to mail server
		if(!fsockopen( $domain, 25, $errno, $errstr, 30)) 
			return false;
			
		return true;
	}	
	return false;
} 	


function messagebox( $text, $type=NOTICE, $op='', $translate=true)
{
	if( $translate == true )
		$text = lang($text);
	
	if( $GLOBALS['appshore_data']['messages'] )
		foreach ( $GLOBALS['appshore_data']['messages'] as $key => $val )
			if ( $val['text'] == $text && $val['type'] == $type )
				return ;
		
	$GLOBALS['appshore_data']['messages'][] = array('text'=>$text, 'type'=>$type, 'op'=>$op);
}

function debugmsg( $text)
{
	$GLOBALS['appshore_data']['messages'][] = array('text'=>$text, 'type'=>ERROR);
}


function generateID()
{
	return base_convert( uniqid( rand(), true), 16, 36);
}

function deleteRow( $tablename, $primarykey, $args, $verbose=false)
{
	return deleteRowWhere( $tablename, 'WHERE `'.$primarykey.'`="'.$args[$primarykey].'" ', $verbose);	
}

function deleteRowWhere( $tablename, $where, $verbose=false)
{
	
	if( strpos( $tablename,'.') )
	{
		list( $base, $table) = explode( '.', $tablename);
		$tablename = '`'.$base.'`.`'.$table.'`';
	}
	else
		$tablename = '`'.$tablename.'`';

	return executeSQL( 'DELETE FROM '.$tablename.' '.$where, $verbose);
}

function updateRow( $tablename, $primarykey, $args, $verbose=false)
{
	return updateRowWhere( $tablename, 'WHERE `'.$primarykey.'`="'.$args[$primarykey].'" ', $args, $verbose, true);
}

function updateRowGMT( $tablename, $primarykey, $args, $verbose=false)
{
	return updateRowWhere( $tablename, 'WHERE `'.$primarykey.'`="'.$args[$primarykey].'" ', $args, $verbose, false);
}

function updateRowWhere( $tablename, $where, $args, $verbose=false, $islocal=true)
{
	// Allow to retrieve all the cols from this table
	$fields = describeColumns( $tablename);
	
	if( isset($fields['updated']) && ($args['updated'] == null) )
	{
		$args['updated'] = $islocal ? $GLOBALS['appshore']->local->datetimeToLocal('now') : gmdate('Y-m-d H:i:s');
		$args['updated_by'] =  $GLOBALS['appshore_data']['current_user']['user_id'];
	}

	// retrieve each field fulfilled by user
	$sql=' ';
	foreach( $fields as $fieldName => $fieldValue)
	{
		if ( isset($args[$fieldName]))
		{
			$args[$fieldName] = str_replace('"', '\"', $args[$fieldName]);

			switch( ($islocal?$fieldValue:''))
			{
				case 'date':
					$sql .= '`'.$fieldName.'`="'.$GLOBALS['appshore']->local->localToDate($args[$fieldName]).'",';
					break;
				case 'datetime':
					$sql .= '`'.$fieldName.'`="'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDatetime($args[$fieldName])).'",';
					break;
				default:
					$sql .= '`'.$fieldName.'`="'.$args[$fieldName].'",';
					break;
			}
		}
	}
	
	if( strpos( $tablename,'.') )
	{
		list( $base, $table) = explode( '.', $tablename);
		$tablename = '`'.$base.'`.`'.$table.'`';
	}
	else
		$tablename = '`'.$tablename.'`';

	return executeSQL( 'UPDATE '.$tablename.' SET '.substr($sql, 0, -1).' '.$where, $verbose);
}

function updateRowWhereGMT( $tablename, $where, $args, $verbose=false)
{
	return updateRowWhere( $tablename, $where, $args, $verbose, false);
}


function insertRow( $tablename, $primarykey, $args, $verbose=false)
{
	return insertReplaceRow( 'INSERT', $tablename, $primarykey, $args, $verbose, true);
} 

function insertRowGMT( $tablename, $primarykey, $args, $verbose=false)
{
	return insertReplaceRow( 'INSERT', $tablename, $primarykey, $args, $verbose, false);
} 

function replaceRow( $tablename, $primarykey, $args, $verbose=false)
{
	return insertReplaceRow( 'REPLACE', $tablename, $primarykey, $args, $verbose, true);
} 

function replaceRowGMT( $tablename, $primarykey, $args, $verbose=false)
{
	return insertReplaceRow( 'REPLACE', $tablename, $primarykey, $args, $verbose, false);
} 

function insertReplaceRow( $sqlVerb, $tablename, $primarykey, $args, $verbose=false, $islocal=true)
{
		
	// Allow to retrieve all the cols from this table
	$fields = describeColumns( $tablename);

	if( isset($fields['created']) && ($args['created'] == null))
	{
		$args['created'] = $islocal ? $GLOBALS['appshore']->local->datetimeToLocal('now') : gmdate('Y-m-d H:i:s');
		$args['created_by'] =  $GLOBALS['appshore_data']['current_user']['user_id'];
	}
	if( isset($fields['updated']) && ($args['updated'] == null) )
	{
		$args['updated'] = $islocal ? $GLOBALS['appshore']->local->datetimeToLocal('now') : gmdate('Y-m-d H:i:s');
		$args['updated_by'] =  $GLOBALS['appshore_data']['current_user']['user_id'];
	}
    if ( !$args[$primarykey] )
	    $args[$primarykey] = generateID();	    

	// retrieve each field fulfilled by user
	$fieldList = ' ';		
	$values = ' ';		
	foreach( $fields as $fieldName => $fieldValue)
	{
		if ( isset($args[$fieldName]))
		{
			$fieldList .= '`'.$fieldName.'`,';

			$args[$fieldName] = str_replace('"', '\"', $args[$fieldName]);

			switch( ($islocal?$fieldValue:''))
			{
				case 'date':
					$values .= '"'.$GLOBALS['appshore']->local->localToDate($args[$fieldName]).'",';
					break;
				case 'datetime':
					$values .= '"'.$GLOBALS['appshore']->local->TZToGmt($GLOBALS['appshore']->local->localToDatetime($args[$fieldName])).'",';
					break;
				default:
					$values .= '"'.$args[$fieldName].'",';
					break;
			}
		}
	}
	
	if( strpos( $tablename,'.') )
	{
		list( $base, $table) = explode( '.', $tablename);
		$tablename = '`'.$base.'`.`'.$table.'`';
	}
	else
		$tablename = '`'.$tablename.'`';

	if( executeSQL( $sqlVerb.' INTO '.$tablename.' ('.substr($fieldList, 0, -1).') VALUES ('.substr($values, 0, -1).')') )
	{
		return $args[$primarykey] ;
	} 

	return null;
} 	

function executeSQL( $sql, $verbose=false)
{

//	echo 'SQL: '. $sql.'<br/>';
//debugmsg( $sql, NOTICE);	

	try 
	{ 
		return $GLOBALS['appshore']->db->Execute( $sql);
	} 
	catch (Exception $e) 
	{ 
		list( $msg, $GLOBALS['Error']['value'], $ignore) = explode( "'", $GLOBALS['appshore']->db->ErrorMsg());
		$GLOBALS['Error']['code'] = $GLOBALS['appshore']->db->ErrorNo();
		
		switch( $GLOBALS['Error']['code'] )
		{
			case '1062':
				$GLOBALS['Error']['msg'] = ERROR_INSERT_DUPLICATED_VALUE;
				break;
			default:
				$GLOBALS['Error']['msg'] = trim($msg).' '.$GLOBALS['Error']['code'];
				break;
		}

		$GLOBALS['Error']['msg'] = lang($GLOBALS['Error']['msg']);
	}
	
	return null;
}


// retrieve the first row returned by the query (must be unique if appropriate WHERE clause)
function getOneAssocArray( $sql, $verbose=false)
{
//echo 'SQL: '. $sql.'<br/>';
//debugmsg( $sql, NOTICE);	

	if( $db = executeSQL( $sql, $verbose) )
		$result = $db->GetArray(1);

    return (isset($result[0])?$result[0]:null);
}

// retrieve All rows returned by the query)
function getOneRow( $sql, $verbose=false)
{
	$GLOBALS['appshore']->db->SetFetchMode(ADODB_FETCH_NUM);

	if( $db = executeSQL( $sql, $verbose) )
		$result = $db->GetArray(1);

	$GLOBALS['appshore']->db->SetFetchMode(ADODB_FETCH_ASSOC);

    return (isset($result[0])?$result[0]:null);
}	

// retrieve one coll from one row
function getOneColOneRow( $sql, $verbose=false)
{
	$result = getOneRow( $sql, $verbose);
	
	return ( isset($result[0]) ? $result[0] : null);
}	


// retrieve All rows
function getManyAssocArrays( $sql, $verbose=false)
{
	if( $db = executeSQL( $sql, $verbose) )
		$result = $db->GetArray();

	return (isset($result)?$result:null);
}	

// retrieve All rows returned by the query)
function getManyRows( $sql, $verbose=false)
{
	$GLOBALS['appshore']->db->SetFetchMode(ADODB_FETCH_NUM);

	if( $db = executeSQL( $sql, $verbose) )
		$result = $db->GetArray();

	$GLOBALS['appshore']->db->SetFetchMode(ADODB_FETCH_ASSOC);

	return (isset($result)?$result:null);
}	

// retrieve All rows returned by the query)
function getOneColManyRows( $sql, $verbose=false)
{
	if( ($rows = getManyRows( $sql, $verbose)) == null )
		return null;
		
	foreach( $rows as $val)
	    $result[] = $val[0];

	return ( isset($result) ? $result : null);
}	

function showTableStatus($verbose=false)
{
	return getManyAssocArrays('show table status', $verbose);	
}	

// retrieve All rows returned by the query)
function describeColumns( $tablename, $column = null, $verbose=false)
{
	if( strpos( $tablename,'.') )
	{
		list( $base, $table) = explode( '.', $tablename);
		$tablename = '`'.$base.'`.`'.$table.'`';
	}
	else
		$tablename = '`'.$tablename.'`';
	
	$rows = getManyAssocArrays('describe '.$tablename.' '.$column, $verbose);	

	$result = (array)null;
	foreach( $rows as $key => $val )
		$result = array_merge( $result, array( $val['Field'] => $val['Type'] ));

	return $result; 
}	

// build a clause often used by applications
function buildClauseWhere( $appName = null, $rw = 'R', $users = 'users.')
{		
	// case where no user_id in the table
	if( $appName == null )
		$clausewhere = ' WHERE 1=1 ';
	else if ( $rw == 'W' )
	{
		if ( $GLOBALS['appshore']->rbac->check( $appName, RBAC_ALL_WRITE ) )
			$clausewhere = ' WHERE 1=1 ';
		else
			$clausewhere = ' WHERE '.$users.'user_id in ( "'. $GLOBALS['appshore_data']['current_user']['user_id'].'","'. implode( $GLOBALS['appshore']->rbac->usersList($appName, RBAC_ROLE_WRITE), '","') .'") ';
	}
	else
	{
		if ( $GLOBALS['appshore']->rbac->check( $appName, RBAC_ALL_READ ) )
			$clausewhere = ' WHERE 1=1 ';
		else
			$clausewhere = ' WHERE '.$users.'user_id in ( "'. implode( $GLOBALS['appshore']->rbac->usersList($appName), '","') .'") ';		
	}

	return $clausewhere; 
}		


function searchArray( $haystack, $key, $needle, $field = null )
{
    foreach( $haystack as $curr => $val )
        if ( $val[$key] == $needle )
            return ($field ? $val[$field] : $val);
	return null;
}

function filterArray( $haystack, $key, $needle)
{
	$filtered = null;
    foreach( $haystack as $curr => $val )
        if ( $val[$key] == $needle )
            $filtered[] = $val;
    return $filtered;
}

function getfilesize($size) 
{
	$units = array(' B', ' KB', ' MB', ' GB', ' TB');
	for ($i = 0; $size > 1024; $i++) 
	{ 
		$size /= 1024; 
	}
		return round($size, 2).$units[$i];
}	

function dirsize($dir)
{
	$totalsize = 0;
	
    $handle = opendir($dir);
    
    while ($file = readdir ($handle))
    {
        if (preg_match("/^\.{1,2}$/i",$file))
            continue;
        if(is_dir( $dir.$file))
    	    dirsize( "$dir.$file/");
    	else
            $totalsize += filesize($dir.$file);
    }
    
    closedir($handle);

    return($totalsize);
} 	

function setPosition( &$rowCurrent, &$rowCount, &$rowFirst, $key = 'Sync', $range = 0)
{
	// allow to set a temporary number of lines without interfering with users settings
	$range = $range?$range:$GLOBALS['appshore_data']['current_user']['nbrecords'];		

	// to round display on the range
	$rowCurrent -= $rowCurrent%$range;

	switch ( $key )
	{
		case 'Clear':
		case 'Search':
			$rowCount = 0;
		case 'First':
			$rowCurrent = $rowFirst = $rowCount = 0;
			break;
		case 'Next':
			if ( ($rowCurrent+$range) < $rowCount ) 
				$rowCurrent += $range; 				      			
			break;
		case 'Previous':
			$rowCurrent -= $range;
			break;
		case 'Last':
			if ( $rowCount%$range == 0 )
				$rowCurrent = $rowCount - $range;
			else 
     			$rowCurrent = $rowCount - $rowCount%$range;
     		$rowFirst = $rowCount;								
			break;
		case 'Sync':
			if ( $rowCount <= 0 )
				$rowFirst = $rowCurrent = $rowCount = 0;
			elseif ( $rowCurrent >= $rowCount )
			{
				if ( $rowCount%$range == 0 )
					$rowCurrent = $rowCount - $range;
				else 
	     			$rowCurrent = $rowCount - $rowCount%$range;
	     		$rowFirst = $rowCount;		
			}				
			break;
	}
	
	// should not happened
	if ( $rowCurrent <= 0 )
		$rowCurrent = $rowFirst = 0;
}

// TBModified
function checkEdition( $verbose=false)
{			
	if( $GLOBALS['appshore_data']['my_company']['is_edition_customizable'] == false )
	{
		if( $verbose == true )
			messagebox( ERROR_SUBSCRIBERS_ONLY, LINK, 'administration.'.PRIVATE_LABEL.'subscription.upgrade');
		return false;
	}
	return true;
} 


// execute a script SQL and replace db names when needed
function executeSQLScript( $filename, $db_name)
{
	if( file_exists( INSTANCES_HTTPD."/sql/".$filename.".sql") == false )
		return;
		
	$tmpfile = APPSHORE_TMP."/".$filename."_".$db_name."_".generateID().".sql";

	// create a temporary sql file to set the global and backoffice db names
	exec("/bin/sed". 
		" -e s/appshore_global/".GLOBAL_DB."/".
		" -e s/appshore_backoffice/".BACKOFFICE_DB."/".
		" <".INSTANCES_HTTPD."/sql/".$filename.".sql". 
		" >".$tmpfile);

	// run it
	exec("/usr/bin/mysql".
		" --database=".$db_name.
    	" --user=".$GLOBALS['appshore_data']['server']['db_user'].
        " --password=".$GLOBALS['appshore_data']['server']['db_pass'].
    	" <".$tmpfile) ;

	// delete it
	unlink($tmpfile) ;		
}		

function noun( $num, $singular, $plural)
{
	return ($num < 2) ? $singular : $plural;
}

function setFullname( $first=null, $last=null)
{
	if( !$first && !$last )
		return null;

	if ( isJapanese($first[0]) || isJapanese($last[0]))
		return $last.' '.$first;
	else
		return $first.' '.$last;
}

function uniord($c)
{
    $h = ord($c{0});
    
    if ($h <= 0x7F) 
    {
        return $h;
    } 
    else if ($h < 0xC2) 
    {
        return false;
    } 
    else if ($h <= 0xDF) 
    {
        return ($h & 0x1F) << 6 | (ord($c{1}) & 0x3F);
    } 
    else if ($h <= 0xEF) 
    {
        return ($h & 0x0F) << 12 | (ord($c{1}) & 0x3F) << 6 | (ord($c{2}) & 0x3F);
    } 
    else if ($h <= 0xF4) 
    {
        return ($h & 0x0F) << 18 | (ord($c{1}) & 0x3F) << 12 | (ord($c{2}) & 0x3F) << 6 | (ord($c{3}) & 0x3F);
    } 
    else 
    {
        return false;
    }
}

function isJapanese($chr) 
{ 

	$unicode = uniord($chr);

    $ret = 0; 
    //unicodeVal is a single value only 
    if ($unicode < 256) 
		return false;
		
    if ($unicode == 8221) 
    { 
        //right double quotation 
        $ret = 3; 
    } 
    elseif ($unicode >= 12288 && $unicode <= 12351) 
    { 
        //Japanese Style Punctuation 
        $ret = 3; 
    } 
    elseif ($unicode >= 12352 && $unicode <= 12447) 
    { 
        //Hiragana 
        $ret = 3; 
    } 
    elseif ($unicode >= 12448 && $unicode <= 12543) 
    { 
        //Katakana 
        $ret = 3; 
    } 
    elseif($unicode >= 12784 && $unicode <= 12799) 
    { 
        $ret = 3; 
    } 
    elseif ($unicode >= 12800 && $unicode <= 13054) 
    { 
        $ret = 3; 
    } 
    elseif ($unicode >= 65280 && $unicode <= 65376) 
    { 
        //full width roman character (Zen Kaku) 
        $ret = 1; 
    } 
    elseif ($unicode >= 65377 && $unicode <= 65439) 
    { 
        //half width character (Han Kaku) 
        $ret = 2; 
    } 
    elseif ($unicode >= 65504 && $unicode <= 65510) 
    { 
        //full width character (Zen Kaku) 
        $ret = 1; 
    } 
    elseif ($unicode >= 65512 && $unicode <= 65518) 
    { 
        //half width character (Han Kaku) 
        $ret = 2; 
    } 
    elseif ($unicode >= 19968 && $unicode <= 40879) 
    { 
        //common and uncommon kanji 
        $ret = 3; 
    } 
    elseif ($unicode >= 13312 && $unicode <= 19903) 
    { 
        //Rare Kanji 
        $ret = 3; 
    } 
 
    return ($ret == 0)?false:true; 
}

// to avoid to have to call the whole class
function setlang( $language_id)
{
	if( isset($GLOBALS['appshore']->trans) )
	{
		$GLOBALS['appshore']->trans->language_id = $language_id;
		return true;
	}
    
    return false;
}  

// to avoid to have to call the whole class
function lang()
{
	$args = func_get_args();
   	$phrase = array_shift($args);

	if( isset($GLOBALS['appshore']->trans) )
		$phrase = $GLOBALS['appshore']->trans->get($phrase);

	if( $args == null )
		return $phrase;
		
	// pass parameters to the translated string
    if( is_array($args[0]) )
   		return sprintfn( $phrase, $args[0]);
    
    return sprintfn( $phrase, $args);
}  

/**
 * version of sprintf for cases where named arguments are desired (python syntax)
 *
 * with sprintf: sprintf('second: %2$s ; first: %1$s', '1st', '2nd');
 *
 * with sprintfn: sprintfn('second: %(second)s ; first: %(first)s', array(
 *  'first' => '1st',
 *  'second'=> '2nd'
 * ));
 *
 * @param string $format sprintf format string, with any number of named arguments
 * @param array $args array of [ 'arg_name' => 'arg value', ... ] replacements to be made
 * @return string|false result of sprintf call, or bool false on error
 */
function sprintfn ($format, array $args = array()) 
{
    // map of argument names to their corresponding sprintf numeric argument value
    $arg_nums = array_slice(array_flip(array_keys(array(0 => 0) + $args)), 1);

    // find the next named argument. each search starts at the end of the previous replacement.
    for ($pos = 0; preg_match('/(?<=%)\(([a-zA-Z_]\w*)\)/', $format, $match, PREG_OFFSET_CAPTURE, $pos);) {
        $arg_pos = $match[0][1];
        $arg_len = strlen($match[0][0]);
        $arg_key = $match[1][0];

        // programmer did not supply a value for the named argument found in the format string
        if (! array_key_exists($arg_key, $arg_nums)) {
           $arg_nums[$arg_key] = '';
        }

        // replace the named argument with the corresponding numeric one
        $format = substr_replace($format, $replace = $arg_nums[$arg_key] . '$', $arg_pos, $arg_len);
        $pos = $arg_pos + strlen($replace); // skip to end of replacement for next iteration
    }

    return vsprintf($format, array_values($args));
}

