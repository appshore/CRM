<?php
/**
 * *************************************************************************\
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by MF MICHEL <bmichel@appshore.com>                 	*
 * Copyright (C) 2004 Brice MICHEL                                          *
 * \*************************************************************************
 */
 
define( 'NL', "\n");

class reports_listing 
{
	var $_dwurl					= '/reports/csv_download.php';
	var $_xmlpath				= 'reports/templates/';
	var $out					= 'default';
	var $report					= null;
	var $display				= null;
	var $_app_page_size			= '10000';
	var $_app_page_width		= '';
	var $_app_xhtml_print		= '<a><IMG SRC="api/images/print.gif" onclick="javascript:this.src=\'api/images/invisible.gif\';printWindow()"/></a>';
	var $_app_document_align	= 'LEFT';
	var $_WHERE_STR				= ' WHERE ';
	var $report_MAX_ROW_BUFFER 	= 10000;
	var $report_SQL_LIMIT 		= ' limit 0,10000';
	var $report_SQLerror 		= false;
	var $report_SQLerrorMess 	= '';
	var $exportFile;
	
	function __construct()
	{
		include_once('reports.inc.php');
	}

	function predefined()
	{
		$args = new safe_args();
		$args->set('action', 		NOTSET,'any');
		$args->set('preop', 		'search','any');
		$args->set('out', 			'default','any');
		$args->set('report_id',		NOTSET,'any');
		$args->set('col_uc', 		NOTSET,'any');		//Q:value='u' for update or 'c' for create
		$args->set('within_prd', 	NOTSET,'any');		//Q:value='p' for period  or 'rd' for range date (p1 and p2) 
		$args->set('period', 		NOTSET,'any');		//Q:			(see period list)
		$args->set('p1', 			NOTSET,'any');		//Q:init_date (BETWEEN)
		$args->set('p2', 			NOTSET,'any');		//Q:end_date
		$args->set('selectedusers', NOTSET,'any');		//Q:users_scope
		$args->set('record_id', 	NOTSET,'any');		//Q:record_scope
		$args->set('field_name', 	NOTSET,'any');		//Q:field for record_scope
		$args = $args->get(func_get_args());

		$this->out = $args['out'];
		if( in_array( $this->out, array('default', 'pdf')))
		{
			$this->display['document_header'] = true;
			$this->display['page_header'] = true;
		}

		$this->report = getOneAssocArray( 'select * from reports where report_id = "'.$args['report_id'].'"');
			
 		if ( $this->report['quickselect'] ) 
 		{
			// set range date criteria if any
			$aParms = Array();
			
			// set range date criteria if any (within period or range date) according to create or update
			$range_date = $this->set_range_date($args,$aParms);
			
			// set users_scope
			$users_scope = $this->set_users_scope($args,$aParms);
			
			//preprocess instructions
			if ($this->report['pre_process'])
			{
				$this->pre_process( $args, $this->report['pre_process'], $range_date);
			}
			
			// set record_scope
			if ( strlen($this->report['table_name']) && strstr($this->report['quickwhere'],'$bcwhere') )
			{
				$clause = buildClauseWhere( $this->report['table_name'], 'R', 'A.');
				$bcwhere = str_replace( 'WHERE 1=1', "", $clause );
//echo $clause;
				if( $args['record_id'] )
				{
#					if( strlen($bcwhere) )
#						$bcwhere .= ' and ';
					$bcwhere .= $args['field_name'].' = "'.$args['record_id'].'"';
				}
				$bcwhere = str_replace( '"', "'", $bcwhere );
			}

			$request = $this->report['quickselect'];
			$request .= ' WHERE '.$this->report['quickwhere'];
			$request = substr($request, 0,strlen($request)-1).$this->report_SQL_LIMIT.'"';

//echo $request;
			
			eval( "\$request = $request;");
 		}	
	
		//>>>>>HERE DO A DIFFERENT REQUEST
		include_once($GLOBALS['phpreports']['path'].'/PHPReportMaker.php');	
		
		// generate the temporary csv file name
		$this->exportFile = tempnam( APPSHORE_TMP,'report_'); //.'.exp';
	
		if ( !$this->report['quickselect'] )  
		{
			$this->checkMissingCriterias($this->report);
			$this->checkMissingOperation($this->report);
			
			if ($this->report_SQLerror)
			{

				$oRpt = new PHPReportMaker();
				$oOut = $oRpt->createOutputPlugin($args['out']);
				$oRpt->setOutputPlugin($oOut);
				new PHPReportsError($this->report_SQLerrorMess);
				$GLOBALS['appshore_data']['layout'] = 'popup';
				return $result;
			}	
			$this->report = $this->getFieldInfo($this->report);
		}
	
		$oRpt = new PHPReportMaker();

		if( $this->report['quickselect'])
		{

//echo $request;
		
			// test if empty of not
			if( getManyAssocArrays(str_replace( '0,10000', "0,1", $request )) == null )
			{
				messagebox( ERROR_RECORD_NOT_FOUND, WARNING);
				return null;
			}	
			
			$oRpt->setSQL($request);
			$aParms['report_name'] = $this->report['report_name'];
			$aParms['full_name'] = $GLOBALS['appshore_data']['current_user']['full_name'];
			$oRpt->setParameters($aParms);
			$oRpt->setXML($this->_xmlpath.$this->report['template']);
		}
		else
		{
			//>>>>>// generate the temporary csv file
			$file = $this->getUserXmlFileName($args['report_id'], 'xml');
			$this->composeTemplate($file);
			$oRpt->setXML($file);
		}

		$oOut = $oRpt->createOutputPlugin($args['out']);
		$oOut->setClean(true);
		$oOut->setJump(false);
		$oOut->setOutput($this->exportFile);    
		$oRpt->setOutputPlugin($oOut);

		$oRpt->run();

		// no data cases
		if( in_array( $args['out'], array('csv', 'pdf')) || $this->report['quickselect'] )
		{
			if( filesize($this->exportFile) == 0 )
			{
				messagebox( ERROR_RECORD_NOT_FOUND, WARNING);
				if( $args['preop'] == 'builder' )
					$GLOBALS['appshore_data']['api']['op'] = 'reports.builder.edit';
				else
					$GLOBALS['appshore_data']['api']['op'] = 'reports.base.'.$args['preop'];
				return execMethod( $GLOBALS['appshore_data']['api']['op'], $args);
			}
		}
		else
		{
			if( filesize($this->exportFile) < 400 )
			{
				messagebox( ERROR_RECORD_NOT_FOUND, WARNING);
			    $GLOBALS['appshore']->add_xsl('reports.parameter_popup');
				$result['action']['reports'] = 'no_data_found';
				$GLOBALS['appshore_data']['layout'] = 'popup';
				return $result;
			}
		}
	
		switch ( $args['out'] )
		{
			case 'csv':
				if( $GLOBALS['appshore_data']['current_user']['charset_id'] != 'UTF-8' )
				{
					exec('iconv -f UTF-8 -t '.$GLOBALS['appshore_data']['current_user']['charset_id']
						.'//IGNORE '.$this->exportFile.' -o '.$this->exportFile.'.iconv') ;
					unlink( $this->exportFile);
					rename( $this->exportFile.'.iconv', $this->exportFile);
				}
				$safeArgsDownload['pathAndFilename'] = $this->exportFile;
				$safeArgsDownload['filename'] = $this->report['report_name'].'.csv';
				$safeArgsDownload['filetype'] = 'csv';
				break;
			case 'pdf':
				$safeArgsDownload['pathAndFilename'] = $this->exportFile.'.pdf';
				$safeArgsDownload['filename'] = $this->report['report_name'].'.pdf';
				$safeArgsDownload['filetype'] = 'application/pdf';
				break;
			default:
				$safeArgsDownload['pathAndFilename'] = $this->exportFile;
				$safeArgsDownload['filename'] = $this->report['report_name'].'.html';
				$safeArgsDownload['filetype'] = 'html';
				break;			
		}
		
		execMethod( 'lib.download.safeArgsDownload', $safeArgsDownload);
		unlink($this->exportFile);
	}
	
	//---------------------------------------------
	// Custom/Wizard reports popup output
	//---------------------------------------------
	// MFM this new function  generate dynamically a 
	// template located in the user document directory
	// MFM
	function runtab()
	{
		$args = new safe_args();
		$args->set('action', NOTSET,'any');
		$args->set('report_id', NOTSET,'any');
		$args = $args->get(func_get_args());
		
		$this->display['page_header'] = true;
		$this->display['document_header'] = true;

		$result = $this->runrqtab($args['report_id']);
// ob_flush();return;
		$result['action']['reports'] = 'runtab';
		return; // $result;
	}

	function runrqtab($report_id)
	{
		$this->report = getOneAssocArray( 'select * from reports where report_id= "'.$report_id.'"');
			
		include_once($GLOBALS['phpreports']['path'].'/PHPReportMaker.php');
	
		$this->checkMissingCriterias($this->report);
		$this->checkMissingOperation($this->report);
		if ($this->report_SQLerror)
		{
			$oRpt = new PHPReportMaker();
			$oOut = $oRpt->createOutputPlugin("default");
			$oRpt->setOutputPlugin($oOut);
			new PHPReportsError($this->report_SQLerrorMess);
			$GLOBALS['appshore_data']['layout'] = 'popup';
			return $result;
		}	
		
		$this->report = $this->getFieldInfo($this->report);	
	
		$oRpt = new PHPReportMaker();
		$oRpt->setUser($GLOBALS[appshore_data][server][db_user]);
		$oRpt->setPassword($GLOBALS[appshore_data][server][db_pass]);
		
		//>>>>>HERE WE HAVE TO generate a special template first
		$file = $this->getUserXmlFileName($report_id,'xml');
		$inFileStr=$this->composeTemplate($file);
		$oRpt->setXML($file);
		
		$oOut = $oRpt->createOutputPlugin("default");
		$oRpt->setOutputPlugin($oOut);

		$tempstr = $this->postComposeGetSQL($inFileStr);
		$fichier = $oRpt->run();
		
		unlink($file);
		$GLOBALS['appshore_data']['layout'] = 'popup';

		return ;//$result;
	}

	function composeTemplate($file)
	{
		$this->_app_logo = 'lib/logo.php';
	
		$filestr = $this->startXmlReportDtdCss();
	
		$filestr .= $this->addSQL();
		$filestr .= $this->addInterfaceData();
	
		$filestr .= $this->startDocument();

		if ($this->display['document_header'])
		{ 
			$filestr .= $this->startHeader();
			$filestr .= $this->fillHeader('',1,'');
			$filestr .= $this->endHeader();
		}
		
		if ($this->display['document_footer_gtotal'])
			$filestr .= $this->addDocumentGrandTotal();
		$filestr .= $this->endDocument();
	
		$filestr .= $this->startPage();
		if ($this->display['page_header'])
		{ 
			$filestr .= $this->startHeader();
			$filestr .= $this->fillHeader('','','');
			$filestr .= $this->addHeaderRowColName();
			$filestr .= $this->addHeaderFooter();
			$filestr .= $this->endHeader();
		}
		else
		{
			$filestr .= $this->startHeader();
			$filestr .= $this->addHeaderRowColName();
			$filestr .= $this->endHeader();
		}
		$filestr .= $this->endPage();
		
		
		$filestr .= $this->startGroups();
		$filestr .= $this->addGroupsFieldsCol($this->report);	
		$filestr .= $this->endGroups();
		$filestr .= $this->endReport();
						
		//>>>>>HERE is our last chance to intervene ont the composed request and template
		if ($this->display['page_break'])
			$filestr = $this->postComposeSet_page_break($filestr);
								
		//write the file
		$handle = fopen($file, "w");
		fwrite($handle, $filestr);
		fclose($handle); 
		return ($filestr);
	}

	function postComposeGetSQL($str=null)
	{
		//get the SQL instruction from the variable
		$pos1 = strpos($str,'<SQL>',1);
		$pos2 = strpos($str,'</SQL>',$pos1+=5);
		return (substr($str,$pos1,$pos2-$pos1));
	}

	
	function postComposeSet_page_break($str=null)
	{
		//search for first occurence of GROUP
		$pos1 = strpos($str,'<GROUP ',1);
		$pos2 = strpos($str,'>',$pos1+=7);
		
		return(substr_replace($str,' PAGEBREAK="TRUE"', $pos2,0)); //insert the PAGEBREAK 
	}
		
	function getUserXmlFileName($report_id,$type='xml')
	{
		return($GLOBALS['phpreports']['userpath'].'/reports_'.$GLOBALS['appshore_data']['current_user']['user_id'].'_'.$report_id.'.'.$type);
	}

	//***********************************************************
	function startXmlReportDtdCss()
	{
		
		$tempstr='<?xml version="1.0" encoding="utf-8" standalone="no"?>'.NL
			.'<!DOCTYPE REPORT SYSTEM "reports/templates/PHPReport.dtd">'.NL
			.'<REPORT MARGINWIDTH="5" MARGINHEIGHT="5" MAX_ROW_BUFFER="'.$this->report_MAX_ROW_BUFFER.'">'.NL;
		$tempstr .= '<BACKGROUND_COLOR>'.$this->display['background_color'].'</BACKGROUND_COLOR>'.NL;
		$tempstr .= '<CSS>reports/css/reportS1.css</CSS>'.NL;
		return $tempstr;
	}

	function addSQL()
	{
		$tmpStr = '<SQL>SELECT '.$this->report['fieldList'].' FROM '.$this->report['table_name'].' A '
			.$this->report['leftOuterJoin'].$this->report['filtercriterias'];

		if ( strlen($this->report['gfields']['orderbygroupList']) || strlen($this->report['gfields']['orderbyList']) )
			$tmpStr .= ' ORDER BY '.$this->report['gfields']['orderbygroupList'].' ';

		if ( strlen($this->report['gfields']['orderbyList']) )
			$tmpStr .= ' '.$this->report['gfields']['orderbyList'].' ';

		$tmpStr .= $this->report_SQL_LIMIT.'</SQL>'.NL;
//print('<pre> ');print_r($tmpStr);print('</pre>');
		return $tmpStr;
	}
	
	function addInterfaceData()
	{
		$tmpStr = '<INTERFACE>mysql</INTERFACE>'.NL.'<CONNECTION>localhost</CONNECTION>'.NL.'<DATABASE>demo</DATABASE>'.NL
			.'<NO_DATA_MSG>No data was found, check your query</NO_DATA_MSG>'.NL.'<TITLE>Accounts</TITLE>'.NL;
		return  $tmpStr;
	}
	
	function startDocument()
	{
		return '<DOCUMENT>'.NL;
	}

	function addDocumentGrandTotal()
	{
		return '<FOOTER>'.NL
				.'<ROW>'.NL.'<COL><XHTML>&#160;<BR/></XHTML></COL>'.NL.'</ROW>'.NL
				.'<ROW>'.NL
					.'<COL COLSPAN="1" ALIGN="RIGHT" CELLCLASS="TOTAL" >Grand&#160;total&#160;:&#160;</COL>'.NL
					.'<COL COLSPAN="1" ALIGN="LEFT"  CELLCLASS="TOTAL" TYPE="EXPRESSION" TEXTCLASS="BOLD" >$this->getRowCount()</COL>'.NL
				.'</ROW>'.NL
			.'</FOOTER>'.NL;
	}


	function startPage()
	{
		if ($this->display['page_size'])
			$page_size = 'SIZE="'.$this->display['page_size'].'" ';
		else 
			$page_size = 'SIZE="'.$this->_app_page_size.'" ';
			
		if ($this->display['page_width'])
			$page_width = 'WIDTH="'.$this->display['page_width'].'" ';
		else 
			$page_width = 'WIDTH="'.$this->_app_page_width.'" ';
			
		if ($this->display['document_align'])
			$page_align = 'ALIGN="'.$this->display['document_align'].'" ';
		else
			$page_align = 'ALIGN="'.$this->_app_document_align.'" ';
			
		return '<PAGE CELLSPACING="0" '.$page_size.' '.$page_width.' '.$page_align.' CELLPADDING="0">'.NL ;
	}

	function startHeader()
	{
		return('<HEADER>'.NL);
	}
	
	function fillHeader($logo,$xprint,$title)
	{
		$temp_str = '<ROW>'.NL;

		if ($logo)
			$temp_str .= '<COL COLSPAN="1" TEXTCLASS="LOGO"><IMG>'.$logo.'</IMG></COL>'.NL;
		
		if($xprint)
			$temp_str .= '<COL CELLCLASS="HEADER" COLSPAN="1"><XHTML><a><IMG SRC="api/images/print.gif" onclick="javascript:this.src=\'api/images/invisible.gif\';print();"/></a></XHTML></COL>'.NL;

		if($title)
			$temp_str .= '<COL CELLCLASS="HEADER" COLSPAN="10">'.$title.'</COL>'.NL;

		$temp_str .= '</ROW>'.NL;
		return $temp_str;
	}
	
	function addHeaderRowColName()
	{
		return '<ROW>'.NL.$this->report['headerRowColName'].'</ROW>'.NL;
	}
	
	function addHeaderFooter()
	{
		return '<FOOTER>'.NL.'</FOOTER>'.NL;
	}
	
	function endHeader()
	{
		return '</HEADER>'.NL;
	}
	
	function endPage()
	{
		return '</PAGE>'.NL;
	}
	
	function endDocument()
	{
		return '</DOCUMENT>'.NL;
	}

	function startGroups()
	{
		return '<GROUPS>'.NL;
	}

	function getFooterCol( $dest, $rank, $funct, $col)
	{
		$tab = array(
			'sum'		=>	'$this->getSum',
			'min'		=>	'$this->getMin',
			'max'		=>	'$this->getMax',
			'avg'		=>	'$this->getAvg',
			'cnt'		=>	'$this->getRowCount',
			'val'		=>	'$this->getValue');
			
		$tablabel = array(
			'sum'		=>	'Sum of ',
			'min'		=>	'Minimum value of ',
			'max'		=>	'Maximum value of',
			'avg'		=>	'Average value of ',
			'cnt'		=>	'Total of ',
			'val'		=>	'$this->getValue');
			
		$sep = ':';
		$label = ' `'.$col.'`'; 
		
		// later "$col name" will be replaced by it's alias
		//		 `$col name`                     it's label for display
		if ( $funct == 'cnt' && $tab[$funct] )
		{
			$dest .= '<COL TYPE="EXPRESSION" CELLCLASS="FOOTER" TEXTCLASS="BOLD" ALIGN="RIGHT" VALIGN="DOWN" COLSPAN="'.$rank.'">"'.$tablabel[$funct].'".'.$tab['val'].'("'.$col.'")."'.$label.$sep.'"</COL>'.NL;
			$dest .= '<COL TYPE="EXPRESSION" CELLCLASS="FOOTER" TEXTCLASS="BOLD" ALIGN="LEFT" VALIGN="DOWN">'.$tab[$funct].'("'.$col.'")</COL>'.NL;
		}
		elseif ( $tab[$funct])
		{
			$dest .= '<COL TYPE="EXPRESSION" CELLCLASS="FOOTER" TEXTCLASS="BOLD" ALIGN="RIGHT" COLSPAN="'.$rank.'">"'.$tablabel[$funct].$label.$sep.'".'.$tab[$funct].'("'.$col.'")</COL>'.NL;
		}
		
		return $dest;
	}


	function addGroupsFieldsCol($rpt)
	{
		if ( $rpt['gfields']['grbyCount'] )
		{
			$tempstr = '';
			//reorder
			for ($i = 0 ; $i < $rpt['gfields']['grbyCount'] ; $i++)
			{
				$nameOrd = $rpt['gfields'][$i]; //name of field in order given by order by, we have to follow this order
				$index = $rpt['groupsGroupList'][ $nameOrd ]; //index of this field in groupsGroupList
				$tempstr .= $rpt['groupsGroupList'][$index];
				
				//testing FOOTER
				$tempstr .= '<FOOTER>'.NL.'<ROW>'.NL.$rpt['gfields']['grby_op'][ $i ].'</ROW>'.NL.'</FOOTER>'.NL;
			}
	
			$tempstr .= '<FIELDS>'.NL.'<ROW>'.NL.$rpt['groupsFieldsCol'].'</ROW>'.NL.'</FIELDS>'.NL;

			for( $ct = $rpt['gfields']['grbyCount'] ; $ct ; $ct--) 
				$tempstr .= '</GROUP>'.NL;
		}
		else
		{
			$tempstr = '<GROUP NAME="main" EXPRESSION="QU">'.NL
					.'<FIELDS>'.NL
						.'<ROW>'.NL.$this->report['groupsFieldsCol'].'</ROW>'.NL
					.'</FIELDS>'.NL
				.'</GROUP>'.NL;
		}
		
		return ($tempstr) ;
	}

	function addGroupHeaderRow( $rptGList, $gcnt, $lstrl, $xstrx, $val)
	{			
		$rptGList[$gcnt] = '<GROUP NAME="'.$xstrx.'" EXPRESSION="'.$xstrx.'" >'.NL
				.'<HEADER>'.NL
					.'<ROW>'.NL
						.'<COL ALIGN="LEFT" CELLCLASS="HEADER3">'.$lstrl.':</COL>'.NL
						.'<COL TYPE="EXPRESSION" CELLCLASS="HEADER3" TEXTCLASS="BOLD">$this->getValue("'.$xstrx.'")</COL>'.NL
					.'</ROW>'.NL
				.'</HEADER>'.NL; 

		$rptGList[$val] = $gcnt;
		
		return $rptGList;
	}
	
	function endGroups()
	{
		return '</GROUPS>'.NL;
	}

	function endReport()
	{
		return '</REPORT>'.NL;
	}


	function getFieldInfo($report)
	{
		// =================for groupby ====================
//print('<pre>');print_r($report);print('</pre>');
		
		if ( $report['groupbyfields'])
		{
			$report['gfields']['orderbygroupList'] = ''; 
			$report['gfields']['orderbyList'] = ''; 
			$report['gfields']['grbyCount'] = 0 ;
						
			foreach( explode ( '/', $report['groupbyfields']) as $key => $val)
			{
				// get fieldname plus its optional parameters (groupby, count, sum, max, min, average) separated by +
				list( $groupbyfield, $groupbyoperators) = explode( ':', $val);
								
				$pos = 1;
	
				foreach( explode( '+', $groupbyoperators) as $key2 => $val2)
				{
					$report['gfields'][$groupbyfield]['grby_op'][$val2] = true;
					
					if( $val2 == 'grp' ) 
					{
						$report['gfields']['orderbygroupList'] .= '`'.$groupbyfield.'`,';
						$report['gfields'][$report['gfields']['grbyCount']++] = $groupbyfield;
					}
					
					$report['gfields']['grby_op'][$report['gfields']['grbyCount']-1] = $this->getFooterCol( $report['gfields']['grby_op'][$report['gfields']['grbyCount']-1], $pos++, $val2, $groupbyfield);
				}
			}
		
			// orderbygroupList string is complete so we remove the last trailing '
			if( strlen($report['gfields']['orderbygroupList']) )			
				$report['gfields']['orderbygroupList'][strlen($report['gfields']['orderbygroupList'])-1] = ' ';
		}


		// =================for orderby ====================
		$report['ofields']['orbyCount']  = 0;
		if ( $report['orderbyfields'])
		{
			$addorderbylist='';
	
			foreach( explode ( '/', $report['orderbyfields']) as $key => $val)
			{
				// get fieldname plus its optional parameters (ASC/DESC) separated by +
				list( $orderbyfield, $ascdesc) = explode( '+', $val);
				$addorderbylist .= '`'.$orderbyfield.'` '.$ascdesc.',';
			}
			
			$report['gfields']['orderbyList'] .= $addorderbylist;
		
			// orderby string is complete so we remove the last trailing '
			if( strlen($report['gfields']['orderbyList']) )			
				$report['gfields']['orderbyList'][strlen($report['gfields']['orderbyList'])-1] = ' ';
		}	
		

//print('<pre>');print_r($report);print('</pre>');


		// =================for selected cols ====================
		if ( $report['selectedfields'])
			{
			$grCount = 0;
			$report['leftOuterJoin'] = '';
			$joinCount = 0;	//starting at number 1, the alias on a basic field will be C1,C2,C3 ...
			$joinAlias = 'A';	//starting at letter A, the alias on a join field will be CA,CB,CC ...
			$aliasCount = 0;
			$groupsFprefix = '<COL TYPE="FIELD" CELLCLASSEVEN="EVEN" CELLCLASSODD="ODD" CELLCLASS="HEADERFIELDS" >';
		
			$selected = explode( '/', $report['selectedfields']);
			$report['groupsGroupList'] = '';
			
			//insert first '`' in string
			$report['selectedfields'] = substr_replace($report['selectedfields'], '`', 0, 0);
			//insert last '`' in string
			$report['selectedfields'] = substr_replace($report['selectedfields'], '`', strlen($report['selectedfields']), 0);
			$report['selectedfields'] = str_replace( '/','`/`',$report['selectedfields']);
			
			// we do row by row to keeinput type="hidden" name="op" value="reports.base.edit"/>p field order
			foreach( $selected as $key => $val)
			{
				$newColValueAndAlias = NULL;
				
				$report['fields'][$val] = getOneAssocArray( '
					SELECT field_name, field_label, field_type, related_table, related_id, related_name
					FROM db_fields
					WHERE table_name = "'.$report['table_name'].'" AND field_name = "'.$val.'"');	
		
				switch($report['fields'][$val]['field_type']) 
				{	
					case 'RR':
					case 'DD':
						$joinCount += 1;
						$joinAlias = chr(ord($joinAlias)+1);
						$report['fields'][$val]['alias'] = 'C'.$joinAlias;
						$report['fields'][$val]['table_alias'] = $joinAlias;
						//if col is a groupby => 
						if ( $report['gfields'][$val]['grby_op']['grp'] )
						{
							$report['groupsGroupList'] = $this->addGroupHeaderRow($report['groupsGroupList'],$grCount,$report['fields'][$val]['field_label'],$report['fields'][$val]['alias'],$val);
							$grCount++;
							$report['gfields']['orderbygroupList'] = str_replace( '`'.$val.'`',$report['fields'][$val]['alias'],$report['gfields']['orderbygroupList']);
						}
						else 
						{
							$report['gfields']['orderbyList'] = str_replace( '`'.$val.'`',$report['fields'][$val]['alias'],$report['gfields']['orderbyList']);
							$report['groupsFieldsCol'] .= $groupsFprefix.$report['fields'][$val]['alias'].'</COL>'.NL;
							$report['headerRowColName'] .= '<COL CELLCLASS="HEADERFIELDS">'.$report['fields'][$val]['field_label'].'</COL>'.NL;
						}
						
						$report['fields'][$val]['alias'] = 'C'.$joinAlias;
						
						$report['leftOuterJoin'] .= ' LEFT OUTER JOIN '.$report['fields'][$val]['related_table'].' '.$joinAlias.' '
							.'on A.'.$report['fields'][$val]['field_name'].' = '.$joinAlias.'.'.$report['fields'][$val]['related_id'];
						
						//substitute field_id in selected_field with <related_name> <C><JoinAlias>
						$report['selectedfields'] = str_replace('`'.$report['fields'][$val]['field_name'].'`',$joinAlias.'.`'.$report['fields'][$val]['related_name'].'`'.' C'.$joinAlias,$report['selectedfields']);
						break;
					case 'NU':
						//This field is varchar to store integer. Beware when NULL: let's put zero value so we can sum/min/max...
						$colVal = 'A.`'.$report['fields'][$val]['field_name'].'`';
						$newColValueAndAlias = '@'.$colVal.':=(ifnull(@'.$colVal.',0)+'.$colVal.')';
						// NO break;
					default:
						$report['fields'][$val]['alias'] = 'C'.$aliasCount;
						$report['fields'][$val]['table_alias'] = 'A';
						$aliasCount++;
						//if col is a groupby => 
						if ($report['gfields'][$val]['grby_op']['grp'] == true)
						{
							$report['groupsGroupList'] = $this->addGroupHeaderRow($report['groupsGroupList'],$grCount,$report['fields'][$val]['field_label'],$report['fields'][$val]['alias'],$val);
							$grCount++;
							$report['gfields']['orderbygroupList'] = str_replace( '`'.$val.'`',$report['fields'][$val]['alias'],$report['gfields']['orderbygroupList']);
						}
						else 
						{
							$report['gfields']['orderbyList'] = str_replace( '`'.$val.'`',$report['fields'][$val]['alias'],$report['gfields']['orderbyList']);
							$report['groupsFieldsCol'] .= $groupsFprefix.$report['fields'][$val]['alias'].'</COL>'.NL;
							$report['headerRowColName'] .= '<COL CELLCLASS="HEADERFIELDS">'.$report['fields'][$val]['field_label'].'</COL>'.NL;
						}
						
						//to avoid ambiguous fields
						$protectedColCriteria = '`'.$report['fields'][$val]['field_name'].'`';
						if ( $newColValueAndAlias == NULL )
						{
							if ( in_array( $report['fields'][$val]['field_type'], array('DT', 'TS')) )
								$newColValueAndAlias = "timestampadd(second,".$GLOBALS['appshore_data']['current_user']['timezone_offset'].", A.".$report['fields'][$val]['field_name'].")";
							else
								$newColValueAndAlias = 'A.`'.$report['fields'][$val]['field_name'].'`';
						}
						$newColValueAndAlias .= ' '.$report['fields'][$val]['alias'];
			
						$report['selectedfields'] = str_replace($protectedColCriteria,$newColValueAndAlias,$report['selectedfields']);	
				}
					
			}
			
			$fieldList = str_replace( '/',',',$report['selectedfields']);
			$report['fieldList'] = $fieldList;
		
			//now replace each field name from a Group Footerfield with it's alias 
			for ( $i = 0 ; $i < $report['gfields']['grbyCount'] ; $i++ )
			{
				if ( $report['gfields']['grby_op'][$i] != null)
				{
					foreach( $selected as $key => $val)
					{
						$report['gfields']['grby_op'][$i] = str_replace('"'.$val.'"','"'.$report['fields'][$val]['alias'].'"',$report['gfields']['grby_op'][$i]);
						$report['gfields']['grby_op'][$i] = str_replace('`'.$val.'`',$report['fields'][$val]['field_label'],$report['gfields']['grby_op'][$i]);
					}
				}
			}
			
			//Now get rid of the '`' from avoiding ambiguous fields
			$report['fieldList'] = str_replace( '`','',$report['fieldList']);
		}//endif selectedfields



//print('<pre>');print_r($report);print('</pre>');


		// =================for selected cols ====================
		// same for filter
		if ( $report['filtercriterias'])
		{	
			$filtercriterias = NULL;
			foreach( explode( '/', $report['filtercriterias']) as $key => $val)
			{

				list( $field_name, $operator_id, $criteria) = explode( ':', $val);
				
				if( !isset( $field_name) || !isset($operator_id) )
					continue;
				
				if( strpos( $field_name, '.') !== false )
					list( $table_name, $field_name) = explode( '.', $field_name);
				
				// build the filter filed full name
				if( $report['fields'][$field_name]['table_alias'] )
				{
					if ($report['fields'][$field_name]['related_name'])
						$filterfield = $report['fields'][$field_name]['table_alias'].'.'.$report['fields'][$field_name]['related_name'];
					else 
						$filterfield = $report['fields'][$field_name]['table_alias'].'.'.$field_name;
				}
				else // when the field is not selected in display
				{
					if ($report['fields'][$field_name]['related_name'])
						$filterfield = $report['fields'][$field_name]['related_name'];
					else 
						$filterfield = $field_name;
				}

//print('<pre>');print_r($filterfield);print('</pre>');
			
				$filtercriterias .= ' AND '.$this->setOperator($filterfield, $report['fields'][$field_name]['field_type'], $operator_id, $criteria);
			}
			
			$report['filtercriterias'] = buildClauseWhere($report['table_name'], 'R', 'A.').$filtercriterias;
            $report['filtercriterias'] = str_replace( '"', "'", $report['filtercriterias'] );
	
		}//endif there is some filter criteria
		
//print('<pre>');print_r($report['filtercriterias']);print('</pre>');
//print('<pre>');print_r($report);print('</pre>');
		
		return $report;
	}

	function is_quoted($str)
	{//returns true if surrounded by simple quote or double quotes
		$first = $str{0};
		$last = $str{strlen($str)-1};
		if( $last == $first && $last == '"' ) 
			return true;
		if( $last == $first && $last == "'" ) 
			return true;
		return false; 
	}

	function set_quotes($str)
	{
		return("'".$str."'");
	}
	
	function checkMissingCriterias($report)
	{	//$this->report_SQLerror and $this->report_SQLerrorMess will be modified
		if ( $report['filtercriterias'])
		{	
			$line=0;
			$selected = explode( '/',$report['filtercriterias'] );
			foreach( $selected as $key => $val)
			{
				// get fieldname plus its criteria value separated by +
				$selectField = explode( '+', $val);
				$line++;
				$pos = 0; 
				$missing=false;
				// 	$this->report_SQLerrorMess.='line is ='.$val.'('.$line.'). <BR/>';
				foreach( $selectField as $key2 => $val2)
				{
					// first is field
					if ($pos == 0 )
					{
						$pos++;
						continue;
					}
					else 
					{	
						if( strlen($selectField[2]) )
						{
							$pos2 = strpos($val2,'+');
							$field_concat = substr($val2,0,$pos2);
							$pos1 = strpos($val2,'.');
							$field_name = substr($field_concat,$pos1+1,$pos2);
							$report['fields'][$field_name] = getOneAssocArray( '
								SELECT field_name, field_label, field_type, related_table, related_id, related_name
								FROM db_fields
								WHERE table_name = "'.$report['table_name'].'" AND field_name = "'.$field_name.'"');
							$missing=true;
						}
						else 
							$pos++;
					}
				}//endforeach
					
				if (($pos <= 2) && ($missing) )
				{//only the field criteria name is filled => Missing criteria value
					$this->report_SQLerror=true;
					$this->report_SQLerrorMess.='Missing filter criteria for field "'.$report['fields'][$field_name]['field_label'].'"<BR/>';
				}
			}
		}
	}

	function checkMissingOperation($report)
	{	
		//$this->report_SQLerror and $this->report_SQLerrorMess will be modified
		if ( $report['filtercriterias'])
		{	
			$line = 0;
			$selected = explode( '/',$report['filtercriterias'] );
			foreach( $selected as $key => $val)
			{
	
				// get fieldname plus its criteria value separated by +
				$selectField = explode( '+', $val);
				$line++;
				$pos = 0; 
				$missing = false;
				// 	$this->report_SQLerrorMess.='line is ='.$val.'('.$line.'). <BR/>';
					foreach( $selectField as $key2 => $val2)
					{
						// first is field
						if ($pos == 0 )
						{
							$pos++;
							continue;
						}
						else 
						{
							
							if((strlen($selectField[1])==0))
							{
								$pos2 = strpos($val2,'+');
								$field_concat = substr($val2,0,$pos2);
								$pos1 = strpos( $val2,'.');
								$field_name = substr($field_concat,$pos1+1,$pos2);
								$report['fields'][$field_name] = getOneAssocArray( '
									SELECT field_name, field_label, field_type, related_table, related_id, related_name
									FROM db_fields
									WHERE table_name = "'.$report['table_name'].'" AND field_name = "'.$field_name.'"');
								$missing=true;
							}
							else 
								$pos++;
						}
					}//endforeach
					
				if ( ($pos <= 2) && $missing )
				{//only the field criteria name is filled => Missing criteria value
					$this->report_SQLerror = true;
					$this->report_SQLerrorMess .= 'Missing filter operation for field "'.$report['fields'][$field_name]['field_label'].'"<BR/>';
				}
			}
		}
	}
	
	function setOperator( $filterfield, $fieldtype, $operator_id, $criteria)
	{
		$operator = getOneAssocArray('select operator_name from global_reports_operators where operator_id = "'.$operator_id.'"'); 

		if ( $operator['operator_name'] == 'period' )// nota: "3 equals" means not found
			return $this->setPeriod( $filterfield, $fieldtype, $criteria);
		if ( strpos( $operator['operator_name'],'{$rptRIGHT0}') === false)// nota: "3 equals" means not found
			return $filterfield.' '.$operator['operator_name']." '".$criteria."'";
		else 
			return $filterfield.' '.str_replace( '{$rptRIGHT0}', $criteria, $operator['operator_name']);
	}
	
	function pre_process( $args, $instructions, $range_date = '')
	{
		$instr = explode( ';', trim($instructions));
		$dummy = '';

		foreach( $instr as $key => $val)
		{
			$sql = $val;

			if (strstr($sql,'$range_date'))
				$sql = str_replace( '$range_date', $range_date, $sql);

			if (strstr($sql,'$bcwhere('))
			{
				$bctable = $this->getInsidePattern($sql,'$bcwhere(');
				$bcwhere = buildClauseWhere( $bctable, 'R', 'A.');
				$bcwhere = str_replace('"',"'",$bcwhere );
				$bcwhere = $bcwhere." AND ";

				$sql = str_replace('$bcwhere('.$bctable.')',$bcwhere,$sql);

			}

			if (strstr($sql,'$range_nucdate('))
			{
				$nuc = $this->getInsidePattern($sql,'$range_nucdate(');

				$sql = str_replace('$range_nucdate('.$nuc.')','$range_nucdate',$sql);

				$args['col_uc'] = $nuc;
				$range_nucdate = $this->set_range_date($args,$dummy);

				$sql = str_replace('$range_nucdate',$range_nucdate,$sql);
			}

//echo $sql;

			if ($sql != '')
				$GLOBALS['appshore']->db->execute( $sql);
		}	
	}

	function getInsidePattern($mystring, $pattern)
	{
		$pos1 = strpos($mystring,$pattern);		
		$pos2 = $pos1+strlen($pattern);		
		$pos3 = strpos($mystring,')',$pos2);	
		return (substr($mystring,$pos2,$pos3-$pos2));
	}


	function setPeriod( $filterfield, $fieldtype, $criteria)
	{
        // to take in account timezone in date ass as well
        $now = $this->gmtToTZDate('now');
	
		$periods = array(
			'TD' => ' day($moment) = day("'.$now.'") AND week($moment) = week("'.$now.'") AND year($moment) = year("'.$now.'")' ,
			'TO' => ' day($moment) = day(date_add("'.$now.'", interval 1 day)) AND week($moment) = week("'.$now.'") AND year($moment) = year("'.$now.'")' ,
			'YE' => ' day($moment) = day(date_add("'.$now.'", interval -1 day)) AND week($moment) = week("'.$now.'") AND year($moment) = year("'.$now.'")' ,
			'TW' => ' week($moment) = week("'.$now.'") AND year($moment) = year("'.$now.'")' ,	
			'NW' => ' week($moment) = week(date_add("'.$now.'", interval 7 day)) AND year($moment) = year(date_add("'.$now.'", interval 7 day))' ,	        
			'LW' => ' week($moment) = week(date_add("'.$now.'", interval -7 day)) AND year($moment) = year(date_add("'.$now.'", interval -7 day))' ,	                
			'TM' => ' month($moment) = month("'.$now.'") AND year($moment) = year("'.$now.'") ',	
			'NM' => ' month($moment) = month(date_add("'.$now.'", interval 1 month)) AND year($moment) = year(date_add("'.$now.'", interval 1 month)) ',		                	        	        
			'LM' => ' month($moment) = month(date_add("'.$now.'", interval -1 month)) AND year($moment) = year(date_add("'.$now.'", interval -1 month)) ',	   
			'TQ' => ' quarter($moment) = quarter("'.$now.'") AND year($moment) = year("'.$now.'") ',
			'NQ' => ' quarter($moment) = quarter(date_add("'.$now.'", interval 3 month)) AND year($moment) = year(date_add("'.$now.'", interval 3 month)) ',
			'LQ' => ' quarter($moment) = quarter(date_add("'.$now.'", interval -3 month)) AND year($moment) = year(date_add("'.$now.'", interval -3 month)) ',
			'TY' => ' year($moment) = year("'.$now.'") ',
			'NY' => ' year($moment) = year("'.$now.'")+1 ', 
			'LY' => ' year($moment) = year("'.$now.'")-1 ',
			'NO' => '1=1 '
			);

		if ( in_array( $fieldtype, array('DT', 'TS')) )
			$periods[$criteria] = str_replace( '$moment', 'timestampadd(second,'.$GLOBALS['appshore_data']['current_user']['timezone_offset'].', $moment)', $periods[$criteria]);

		return str_replace( '$moment', $filterfield, $periods[$criteria]);
	}
	
	/**--------------------
	*
	-----------------------**/
	function set_range_date($args,&$aParms)
	{
		// set range date criteria if any (within period or range date) according to create or update
		// 	$args->set('col_uc', NOTSET,'any');		//value='u' for update or 'c' for create
		// 	$args->set('within_prd', NOTSET,'any');	//value='p' for period  or 'rd' for range date (p1 and p2) 
		// 	$args->set('period', NOTSET,'any');		//			(see period list)
		// 	$args->set('p1', NOTSET,'any');//init_date (BETWEEN)
		// 	$args->set('p2', NOTSET,'any');//end_date

		$periods = array(
				'TD' => 'Today',
				'TO' => 'Tomorrow',
				'YE' => 'Yesterday',
				'TW' => 'This week',
				'NW' => 'Next week',
				'LW' => 'Last week',
				'TM' => 'This month',
				'NM' => 'Next month',
				'LM' => 'Last month',
				'TQ' => 'This quarter',
				'NQ' => 'Next quarter',
				'LQ' => 'Last quarter',
				'TY' => 'This year',
				'NY' => 'Next year',
				'LY' => 'Last year'
				);
	
		if ($args['col_uc'] == 'c')
		{
			$moment = 'A.created';
			$fieldtype = 'TS';
		}
		else if ($args['col_uc'] == 'u')
		{
			$moment = 'A.updated';
			$fieldtype = 'TS';
		}
		else
		{
			$moment = $args['col_uc'];
			list( $void, $fieldname) = explode('.', $args['col_uc']);
			$fieldtype = getOneColOneRow( 'SELECT field_type FROM db_fields WHERE table_name = "'.$this->report['table_name'].'" AND field_name = "'.$fieldname.'"');			
		}

		if ( in_array( $fieldtype, array('DT', 'TS')) )
			$moment = 'timestampadd(second,'.$GLOBALS['appshore_data']['current_user']['timezone_offset'].', '.$moment.')';

        // to take in account timezone in date ass as well
        $now = $this->gmtToTZDate('now');

		$periods_sql = array(
			"TD" => " day($moment) = day('".$now."') AND week($moment) = week('".$now."') AND year($moment) = year('".$now."')" ,
			"TO" => " day($moment) = day(date_add('".$now."', interval 1 day)) AND week($moment) = week('".$now."') AND year($moment) = year('".$now."')" ,
			"YE" => " day($moment) = day(date_add('".$now."', interval -1 day)) AND week($moment) = week('".$now."') AND year($moment) = year('".$now."')" ,
			"TW" => " week($moment) = week('".$now."') AND year($moment) = year('".$now."')" ,	
			"NW" => " week($moment) = week(date_add('".$now."', interval 7 day)) AND year($moment) = year(date_add('".$now."', interval 7 day))" ,	        
			"LW" => " week($moment) = week(date_add('".$now."', interval -7 day)) AND year($moment) = year(date_add('".$now."', interval -7 day))" ,	                
			"TM" => " month($moment) = month('".$now."') AND year($moment) = year('".$now."') ",	
			"NM" => " month($moment) = month(date_add('".$now."', interval 1 month)) AND year($moment) = year(date_add('".$now."', interval 1 month)) ",		                	        	        
			"LM" => " month($moment) = month(date_add('".$now."', interval -1 month)) AND year($moment) = year(date_add('".$now."', interval -1 month)) ",	   
			"TQ" => " quarter($moment) = quarter('".$now."') AND year($moment) = year('".$now."') ",
			"NQ" => " quarter($moment) = quarter(date_add('".$now."', interval 3 month)) AND year($moment) = year(date_add('".$now."', interval 3 month)) ",
			"LQ" => " quarter($moment) = quarter(date_add('".$now."', interval -3 month)) AND year($moment) = year(date_add('".$now."', interval -3 month)) ",
			"TY" => " year($moment) = year('".$now."') ",
			"NY" => " year($moment) = year('".$now."')+1 ", 
			"LY" => " year($moment) = year('".$now."')-1 ",
			"NO" => "1=1 "
			);


		$range_date = '';
		if ( $args['within_prd'] == 'rd' )
		{
			if ($args['p1'] and $args['p2'])
			{
				$args['p1'] = $this->localToDate($args['p1']);
				$args['p2'] = $this->localToDate($args['p2']);
		
				if ( is_date($args['p1']) and is_date($args['p2']))
				{
					$range_date = " ".$moment." BETWEEN '".$args['p1']."' AND '".$args['p2']."' AND ";	
					//set parameters (init_date end_date)
					$aParms['range_date'] = 'From '.$args['p1'].' to '.$args['p2'];
				}
			}
		}
		else
		{//assuming value is 'p' (period)
	
			if ($args['period'])
			{
				$period_date = $periods_sql[$args['period']];
				$aParms['range_date'] = $periods[$args['period']];
			}
			else
			{
				$period_date = $periods_sql['TM'];
				$aParms['range_date'] = $periods[$args['period']];
				return null;
			}

			$range_date = str_replace( '$moment', $moment, ' '.$period_date.' AND ');
		}

		return $range_date;
	}
	
	
    function gmtToTZDate( $date = 'now', $timezone_id = null)
    {  
    	if( $date == '0000-00-00')
    		return $date;

   		if( strtotime($date) === false )
   			$date = 'now';
   			
		// set the timezone
		date_default_timezone_set($timezone_id?$timezone_id:$GLOBALS['appshore_data']['current_user']['timezone_id']);
  			
    	return strftime( '%Y-%m-%d', strtotime($date)+date('Z'));
    }    
    
   	// convert user local date to generic date
    function localToDate( $date = null)
    {  
    	$temp = strptime( $date, $GLOBALS['appshore_data']['current_user']['locale_date_id']);

    	if( $temp === false )
    		return '';

    	return sprintf('%04d-%02d-%02d', $temp['tm_year']+1900,$temp['tm_mon']+1,$temp['tm_mday']);
    }             
	

	function set_users_scope($args,&$aParms)
	{
		$users_scope='';
	
		if (!empty($args['selectedusers']))
		{
			foreach( explode( ',', $args['selectedusers']) as $key => $val)
				$users_scope .= "'".$val."',";
				
			//remove last ,
			$users_scope = substr_replace( $users_scope,'', strlen($users_scope)-1, 1 );
			
			$names = '';
			foreach( getManyAssocArrays( 'select user_name from users where user_id in ('.$users_scope.')') as $key => $val)
				$names .= $val['user_name'].",";
	
			//remove last ,
			$names = substr_replace( $names,'', strlen($names)-1, 1 );
	
			$users_scope = 'B.user_id in ('.$users_scope.') AND ';
			$aParms['users_scope'] = $names;
		}
	
		return $users_scope;
	}

	function show_special( $instring)
	{
		return str_replace( '\n', '<BR/>', $instring);
	}

}
