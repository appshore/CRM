<?php
/***************************************************************************
* Appshore                                                                 *
* http://www.appshore.com                                                  *
* This file written by Brice Michel  bmichel@appshore.com                  *
* Copyright (C) 2004-2009 Brice Michel                                     *
***************************************************************************/

class base_xslt
{
	var $xsl;
	var $xml;
	var $output;
	var $cache;
	var $xml_render = false;
	var $amp = '&amp;';

	function __construct()
	{
		if( $GLOBALS['appshore_data']['server']['cache_xslt'] !== false )
		{
			include('class.xslt_'.$GLOBALS['appshore_data']['server']['cache_xslt'].'.php');
        	$this->cache = new xslt_cache();
        }
	
        if( preg_match( '/msie/i', $_SERVER['HTTP_USER_AGENT'] ) )
 	    	$this->amp = '&amp;';
	    else
	    	$this->amp = '&';
	}
	
	function set_xml($xml)
	{
		$this->xml = $xml;
		return true;
	}
	
	function set_xsl($xsl)
	{
		$this->xsl = $xsl;
		return true;
	}
	
	function transform()
	{
        $xmldoc = new DOMDocument();
//        $xmldoc->loadXML(iconv( 'UTF-8', 'UTF-8//IGNORE', sanitize($this->xml,'string')));
        $xmldoc->loadXML(iconv( 'UTF-8', 'UTF-8//IGNORE', $this->xml));
        
        $xsldoc = new DOMDocument();
        $xsldoc->loadXML($this->xsl);
        
        $xslt = new XSLTProcessor;

//$xslt->setProfiling('/tmp/profiling.txt');
        
		$xslt->registerPHPFunctions();

		$xslt->importStyleSheet($xsldoc);
		
		return $xslt->transformToXML($xmldoc);
	}
	
	function getOutput()
	{
		if($this->xml_render)
			return $this->xml;
		
		if(empty($this->output))
			return $this->transform();

		return $this->output;
	}
	
	function setStylesheet($xsl_files = null)
	{
		// if xsl files have already been cached then we get them
		// then no need to retrieve them again
		if( $this->xsl = $this->getCacheVar( $xsl_files) )
			return $this->xsl;

		/* Generate the initial XSL file and return nothing, since PHP is going to render anyways */
		$this->xsl = '<?xml version="1.0" encoding="utf-8" ?>'."\n";
		$this->xsl .= '<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl">'."\n";
		$this->xsl .= '<xsl:output method="html" encoding="utf-8" doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-public="-//W3C//DTD HTML 4.01//EN" omit-xml-declaration="yes" />'."\n";

		foreach($xsl_files as $key => $val)
		{
			list( $app, $file) = explode('.',$val);
			if( $content = $this->cacheFile( APPSHORE_HTTPD.SEP.$app.SEP.'xsl'.SEP.$file.'.xsl') )
				$this->xsl .= $content;				
		}
	
		$this->xsl .= '</xsl:stylesheet>';
		
		if( $this->isCacheVar( $xsl_files) == false )
			$this->setCacheVar( $xsl_files, $this->xsl);

		return $this->xsl;
	}

    function cacheFile($filename)
    {
    	// already in cache?
	   	if( isset($this->cache) == true )
	   		if( $cache = $this->cache->getvar($filename) )
	   			return $cache;

		// file exists?
		if( file_exists($filename) == false )
			return false;

		// process file
		$cache = '';
		
		foreach ( file( $filename) as $line_num => $line)
			if( preg_match('/^(<\?xml)|(<?xsl:stylesheet)|(<?xsl:output)$/i', $line) == false )
			{
				$line = trim($line, " \t"); 		
				$cache .= ($line != "\n") ? $line : ''; 		
			}

		// save in cache if possible
	   	if( isset($this->cache) == true )
   			return $this->cache->setvar( $filename, $cache);

		// or return processed content
 	   	return $cache;
    }     

    function getCacheVar($varname)
    {
	   	if( isset($this->cache) == true )
	   		return $this->cache->getvar( $this->cache->keyname($varname));

 		return false;
    }

    function setCacheVar($varname, $var)
    {
	   	if( isset($this->cache) == true )
	   		return $this->cache->setvar( $this->cache->keyname($varname), $var);
   			
 	   	return false;
    }  

    function isCacheVar($varname)
    {
	   	if( isset($this->cache) == true )
	   		return $this->cache->isvar( $this->cache->keyname($varname));
   			
 	   	return false;
    }           
 }
