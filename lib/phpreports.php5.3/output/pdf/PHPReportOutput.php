<?php
	// MUST be in the include path
	require_once($GLOBALS['phpreports']['path']."PHPReportOutputObject.php");
	
	/**
		PHPReports default plugin - renders the page
		into HTML (directly on the browser or in a file)
	*/
	class PHPReportOutput extends PHPReportOutputObject {
		function run() {
			$sPath  = getPHPReportsFilePath();
			$sXML	  = $this->getInput();
			$sXSLT  = "$sPath/output/pdf/pdf.xsl";
		
			$oProcFactory = new XSLTProcessorFactory();
			$oProc = $oProcFactory->get();
			$oProc->setXML($sXML);
			$oProc->setXSLT($sXSLT);
			$oProc->setOutput($this->getOutput()); 
			$sRst = $oProc->run();
			
			//if(is_null($this->getOutput()))			
			//	print $sRst;
				
			require_once('dompdf/dompdf_config.inc.php');

			$dompdf = new DOMPDF();
			$dompdf->load_html_file($this->getOutput());
			$dompdf->render();
			//$dompdf->stream("/tmp/sample.pdf");
$pdfoutput = $dompdf->output(); 
$fp = fopen($this->getOutput().'.pdf', "w"); 
fwrite($fp, $pdfoutput); 
fclose($fp); 				
			if($this->isCleaning())	
				unlink($sXML);	
		}
	}

