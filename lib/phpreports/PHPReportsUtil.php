<?php
	/******************************************************************************
	*																										*
	*	Useful functions and classes to deal with PHPReports stuff.						*
	*	This file is part of the standard PHPReports package.								*
	*																										*
	******************************************************************************/	
	//$GLOBALS['phpreports_path'] = $GLOBALS['_SERVER']['DOCUMENT_ROOT']."/lib/phpreports/";
	/******************************************************************************
	*																										*
	*	This function will return if there is a PHPReports path in the PHP			*
	*																										*
	******************************************************************************/
	function getPHPReportsIncludePath(){
		return $GLOBALS['phpreports']['path']; 
	}

	/******************************************************************************
	*																										*
	*	Returns the temporary file path. It's up to your operational system to		*
	*	return that. In most cases, on Linux it will return /tmp and on				*
	*	Windows c:\temp																				*
	*																										*
	******************************************************************************/
	function getPHPReportsTmpPath(){
		return $GLOBALS['phpreports']['strict_dir'];
	}

	/******************************************************************************
	*																										*
	*	This function will return the file path where the PHPReports classes			*
	*	are.																								* 
	*																										*
	******************************************************************************/
	function getPHPReportsFilePath(){
		return $GLOBALS['phpreports']['path']; 
	}

	/******************************************************************************
	*																										*
	*	XSLTProcessorClass																			*
	*	This class is used as base for XSLT process.											*
	*																										*
	******************************************************************************/	
	class XSLTProcessorClass{
		var $_sXML;
		var $_sXSLT;
		var $_sOutput;
		var $_aParms;

		/**
			Constructor
		*/
		function XSLTProcessorClass(){
			$this->_sXML	= null;
			$this->_sXSLT	= null;
			$this->_sOutput = null;
			$this->_aParms	= null;
		}

		/**
			Sets the XML data file path
		*/			
		function setXML($sXML_ = null){
			$this->_sXML=$sXML_;
		}
		
		/**
			Returns the XML data file path
		*/
		function getXML(){
			return $this->_sXML;
		}
		
		/**
			Sets the style sheet file path
		*/
		function setXSLT($sXSLT_=null){
			$this->_sXSLT=$sXSLT_;
		}

		/**
			Returns the style sheet file path
		*/
		function getXSLT(){
			return $this->_sXSLT;
		}
		
		/**
			Specify the output file path
			A null just returns the result on the run method
		*/
		function setOutput($sOutput_=null){
			$this->_sOutput=$sOutput_;
		}

		/**
			Return the output file path
		*/		
		function getOutput(){
			return $this->_sOutput;
		}

		/**
			Specify the parameters array
		*/
		function setParms($aParms_=null){
			if(is_null($aParms_))
				return;
			if(!is_array($aParms_))
				return;	
			$this->_aParms=$aParms_;	
		}
		
		/**
			Insert a parameter
			sParm_ - parameter name
			oVal_  - parameter value
		*/			
		function setParm($sParm_=null,$oVal_=null){
			if(is_null($sParm_))
				return;
			$this->_aParms[$sParm_]=$oVal_;
		}

		/**
			Returns a parameter value
			sParm_ - parameter name
		*/
		function getParm($sParm_){
			if(!array_key_exists($sParm_))
				return null;
			return $this->_aParms[$sParm_];
		}
		
		/**
			Remove a parameter
			sParm_ - parameter name
		*/
		function removeParm($sParm_=null){
			if(is_null($sParm_))
				return;
			if(!array_key_exists($sParm_,$this->_aParms))
				return;					
			unset($this->_aParms[$sParm_]);					
		}

		/**
			This method MUST be overwritten on every subclass to reflect
			the behaviour of the desired XSLT processor.
			It MUST return the result, and if defined an output, save it.
		*/
		function run(){
		}
	}
	
	/******************************************************************************
	*																										*
	*	Sablotron processor																			*
	*	http://www.gingerall.com/charlie/ga/xml/p_sab.xml									*
	*	http://www.php.net/manual/en/ref.xslt.php												*
	*	Used on PHP4 or installed from the PECL modules.									*
	*																										*
	******************************************************************************/
	class Sablotron_xp extends XSLTProcessorClass{
		function run(){
			if(is_null($this->_sXML)){
				print "ERROR: no XML file specified";
				return;
			}
			if(is_null($this->_sXSLT)){
				print "ERROR: no XSLT file specified";
				return;
			}
			/* WITH SABLOTRON $oXSLT = xslt_create();
			$sRst	 = xslt_process($oXSLT,$this->_sXML,$this->_sXSLT,$this->_sOutput,null,$this->_aParms);
			xslt_free($oXSLT);
								
			return $sRst;*/
			// WITH DOMXML
			$xmldoc = domxml_open_file($this->_sXML);
       			$xsldoc = domxml_xslt_stylesheet_file($this->_sXSLT);
       			$result =  $xsldoc->process($xmldoc,$this->_aParms);
       			$this->output = $xsldoc->result_dump_mem($result);	
				
			//ADDED with DOMXML (same as PHP5 XSL processing bellow)
			// if output is not null, save the result there
			if(!is_null($this->_sOutput)){
				$fHand = fopen($this->_sOutput,"w");
				fputs($fHand,$this->output);
				fclose($fHand);
			}			
			return $this->output;
			
		}
	}

	/******************************************************************************
	*																										*
	*	PHP5 XSL processing																			*
	*	Uses libxslt																					*
	*	http://www.php.net/manual/en/ref.xsl.php												*
	*																										*
	******************************************************************************/
	class PHPXSL_xp extends XSLTProcessorClass{
		function run(){
			// xml document
			$oXML = new DomDocument();
			$oXML->load($this->_sXML);
			$oXML->xinclude();

			// xslt document
			$oXSL = new DomDocument();
			$oXSL->load($this->_sXSLT);

			// xslt processor
			$oProc = new XSLTProcessor();
			$oProc->importStyleSheet($oXSL);
			
			// set all the parameters
			if(!is_null($this->_aParms)){
				foreach($this->_aParms as $k => $v)
					$oProc->setParameter("",$k,$v);
			}	

			// make the transformation				
			$sRst = $oProc->transformToXML($oXML);

			// if output is not null, save the result there
			if(!is_null($this->_sOutput)){
				$fHand = fopen($this->_sOutput,"w");
				fputs($fHand,$sRst);
				fclose($fHand);
			}
			return $sRst;
		}
	}
	
	/******************************************************************************
	*																										*
	*	XSLT Processor factory																		*
	*	Returns a XSLT processor based on the current environment						*
	*	or the user choice (need to hack the code below).									*
	*																										*
	******************************************************************************/
	class XSLTProcessorFactory{
		function get(){
			// PHP major version number
			$iVer = intval(substr(phpversion(),0,1));

			// if PHP4 and Sablotron is installed
			// Not all for DOMXML : if($iVer<=4 && function_exists("xslt_create"))
			if($iVer<=4)
				return new Sablotron_xp();
			// if PHP5 and Sablotron is installed				
			else if($iVer>=5 && function_exists("xslt_create"))
				return new Sablotron_xp();	
			// if PHP5, Sablotron is not installed	and XSL support is compiled			
			else if($iVer>=5 && !function_exists("xslt_create") && class_exists("XSLTProcessor"))
				return new PHPXSL_xp();
			// there is no XSLT processor installed!				
			else
				return null;				
		}
	}

	/******************************************************************************
	*																										*
	*	PHPReportsError																				*
	*	Process error messages																		*
	*																										*
	******************************************************************************/
	class PHPReportsError{
		function PHPReportsError($sMsg_=null,$sURL_=null){
			if(is_null($sMsg_))
				return;
				
			echo "<p style='width:400px;background-color:#F5F5F5;border-style:solid;border-width:2;border-color:#CCCCCC;padding:10px 10px 10px 10px;margin:20px;font-family:verdana,arial,helvetica,sans-serif;color:#505050;font-size:12px;'>";
			echo "<span style='font-size:18px;color:#FF0000;font-weight:bold;'>ERROR</span><br/>";
			echo $sMsg_."<br/>";
			
			//if(!is_null($sURL_))
			//	print "<a href='$sPath/help/$sURL_'>More about this error here.</a><br/><br/>";

			echo "<span style='font-size:10px;font-weight:bold;'></span>";
			echo "</p>";
			return;				
		}
	}
		/******************************************************************************
	*																			*
	*	PHPReportsInfo															*
	*	Process Info messages													*
	*	APPSHORE MFM: added to handle trace messages							*
	******************************************************************************/
	class PHPReportsInfo{
		function PHPReportsInfo($sMsg_=null,$sURL_=null){
			if(is_null($sMsg_))
				return;
				
			echo "<p style='width:400px;background-color:#DDFFDD;border-style:solid;border-width:2;border-color:#CCCCCC;padding:10px 10px 10px 10px;margin:20px;font-family:verdana,arial,helvetica,sans-serif;color:#505050;font-size:12px;'>";
			echo "<span style='font-size:18px;color:#DFFDD;font-weight:bold;'>TRACE</span><br/>";
			echo $sMsg_."<br/>";
			
			//if(!is_null($sURL_))
			//	print "<a href='$sPath/help/$sURL_'>If you wish to report this error here.</a><br/><br/>";

			echo "<span style='font-size:10px;font-weight:bold;'></span>";
			echo "</p>";
			return;				
		}
	}

?>
