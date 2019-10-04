<?php

class csv_download {
    var $arg_file=null;
    var $strict_dir="/tmp";

	function __construct()
	{
		require_once("reports.inc.php");
		$this->strict_dir=$GLOBALS['phpreports']['strict_dir'];
	}
	
	function download() 
	{
		
		$tableau = explode(".", $this->arg_file);
		$filename = basename($this->arg_file);
		$nb_element_1 = count ($tableau) -1;
		
		// only allow csv extensions for download
		if ($tableau[$nb_element_1] == "csv") 
			{
			while (@ob_end_clean());
                // all these code came from php.net examples to work with IE
                ini_set( 'zlib.output_compression','Off' );
                header('Pragma: public');
                header('Last-Modified: '.gmdate('D, d M Y H:i:s') . ' GMT');
                header('Cache-Control: no-store, no-cache, must-revalidate'); // HTTP/1.1
                header('Cache-Control: pre-check=0, post-check=0, max-age=0'); // HTTP/1.1
                header('Content-Transfer-Encoding: none');
                        //header("Content-disposition: attachment; filename=\"".$filename."\"");
                header("Content-Type: application/octetstream; name=\"".$filename."\"");
                header("Content-Type: application/octet-stream; name=\"".$filename."\"");
                header("Content-disposition: inline; filename=\"".$filename."\"");
                        //header("Content-Type: application/force-download");
                        //header("Content-Transfer-Encoding: binary\n");
                        header("Content-Length: ".filesize($this->arg_file));
                        //header("Pragma: no-cache");
                        //header("Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0");
                        //header("Expires: 0");

			//force download only from temporary dir (strict_dir) and only a csv file	
			$strict_file=$this->strict_dir."/".$filename;
			//TODO force maybe a check on a prefix: md5(userid) or sessionid if
			$fn=fopen($strict_file, "rb");
			fpassthru($fn);
			}
	}//if download
		
    }//class

if ($_GET) 
	extract($_GET);
	
if ($_POST) 
	extract($_POST); 
$dwn=new csv_download;
$dwn->arg_file=$file;
$dwn->download();

?>
