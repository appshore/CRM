<?php
 /***************************************************************************
 * Appshore                                                                 *
 * http://www.appshore.com                                                  *
 * This file written by Brice Michel  bmichel@appshore.com                  *
 * Copyright (C) 2004-2010 Brice Michel                                     *
 ***************************************************************************/


class lib_images
{
    function __construct()
    {
		require_once ( APPSHORE_LIB.SEP.'lib.files.php');
        checkDirectory( APPSHORE_IMAGES);
    }

    function delete()
    {
		$args = new safe_args();
		$args->set('file_name', NOTSET, 'any');
		$args = $args->get(func_get_args());	

 		// delete all files related to this record   	
 		if( strlen($args['file_name']) )
	    	foreach (glob(APPSHORE_IMAGES.'/'.$args['file_name'].'*') as $filename)
    		{
   				unlink($filename);
			}
    }  
    
    function duplicate()
    {
		$args = new safe_args();
		$args->set('old_file_name', 	NOTSET, 'any');
		$args->set('new_file_name', 	NOTSET, 'any');
		$args = $args->get(func_get_args());	

		if( strlen($args['old_file_name']) && strlen($args['new_file_name']) )
			foreach (glob(APPSHORE_IMAGES.'/'.$args['old_file_name'].'*') as $filename)
			{
				$newfilename = str_replace( $args['old_file_name'], $args['new_file_name'], $filename);
	   			copy($filename, $newfilename);
			}
    }     

	function upload() 
	{ 
		$args = new safe_args();
		$args->set('field_name', 			NOTSET, 'any');
		$args->set('field_name_value', 		NOTSET, 'any');
		$args = $args->get(func_get_args());	

		if ( $_FILES[$args['field_name'].'_file'] == null || $_FILES[$args['field_name'].'_file'][ERROR] == '1')
		{
            messagebox( ERROR_FILE_TOO_BIG, WARNING);
        }
		else if (is_uploaded_file( $_FILES[$args['field_name'].'_file']['tmp_name']))	
		{ 					 
			move_uploaded_file( $_FILES[$args['field_name'].'_file']['tmp_name'], APPSHORE_IMAGES.SEP.$args['field_name_value']);
	
			if ( is_file( APPSHORE_IMAGES.SEP.$args['field_name_value']) == false )
			{
				messagebox( ERROR_FILE_NOT_FOUND, WARNING);
			}
			else
			{
				$thumb = $this->thumbnail( APPSHORE_IMAGES.SEP.$args['field_name_value'], 96);
				imagejpeg($thumb, APPSHORE_IMAGES.SEP.$args['field_name_value'].'_96');
		
				$thumb = $this->thumbnail( APPSHORE_IMAGES.SEP.$args['field_name_value'], 48, 48);
				imagejpeg($thumb, APPSHORE_IMAGES.SEP.$args['field_name_value'].'_48');
			}
		}						
	}


	function thumbnail($imgSrc,$thumbnail_height=96,$thumbnail_width=null) 
	{ 
		//$imgSrc is a FILE - Returns an image resource.
		//getting the image dimensions 
		list($width_orig, $height_orig, $imgType) = getimagesize($imgSrc);  
		
		switch ($imgType)
		{
			case 1:   //   gif -> jpg
				$myImage = imagecreatefromgif($imgSrc);
				break;
			case 2:   //   jpeg -> jpg
				$myImage = imagecreatefromjpeg($imgSrc);
				break;
			case 3:  //   png -> jpg
				$myImage = imagecreatefrompng($imgSrc);
				break;
		}
		
		$ratio_orig = $width_orig/$height_orig;
		
		if( $thumbnail_width == null )
			$thumbnail_width = $thumbnail_height*$ratio_orig;
	   
		if ($thumbnail_width/$thumbnail_height > $ratio_orig) {
		   $new_height = $thumbnail_width/$ratio_orig;
		   $new_width = $thumbnail_width;
		} else {
		   $new_width = $thumbnail_height*$ratio_orig;
		   $new_height = $thumbnail_height;
		}
	   
		$x_mid = $new_width/2;  //horizontal middle
		$y_mid = $new_height/2; //vertical middle
	   
		$process = imagecreatetruecolor(round($new_width), round($new_height));
	   
		imagecopyresampled($process, $myImage, 0, 0, 0, 0, $new_width, $new_height, $width_orig, $height_orig);
		$thumb = imagecreatetruecolor($thumbnail_width, $thumbnail_height);
		imagecopyresampled($thumb, $process, 0, 0, ($x_mid-($thumbnail_width/2)), ($y_mid-($thumbnail_height/2)), $thumbnail_width, $thumbnail_height, $thumbnail_width, $thumbnail_height);

		imagedestroy($process);
		imagedestroy($myImage);
		return $thumb;
	}    
	
}
