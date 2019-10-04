<?php

/************************************************************************
* Appshore                                                                 
* http://www.appshore.com                                                  
* Brice MICHEL <bmichel@appshore.com>                                      
* Copyright (C) 2004 Brice MICHEL                                          
* ------------------------------------------------------------------------ 
* Portions from Joel Finkel  finkel@sd-il.com                              
* Credits:*	Concept by vImage by Rafael Machado Dohms (dooms@terra.com.br)*   Coding example from HumanCheck 2.1 by Yuriy Horobey (yuriy@horobey.com)*   The function, simpleRandString, is by demogracia@metropoliglobal.com and posted*	to www.php.net                                       *
* -------------------------------------------------------------------------
* This library is free software; you can redistribute it and/or modify it  
* under the terms of the GNU Lesser General Public License as published by 
* the Free Software Foundation; either version 2.1 of the License,         
* or any later version.                                                    
* This library is distributed in the hope that it will be useful, but      
* WITHOUT ANY WARRANTY; without even the implied warranty of               
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                     
* See the GNU Lesser General Public License for more details.              
* You should have received a copy of the GNU Lesser General Public License 
* along with this library; if not, write to the Free Software Foundation,  
* Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA            
\**************************************************************************/


class securityImage 
{
	// stub
    function __construct()
    {
    }
	function simpleRandString( $length=5, $list="123456789ABCDEFGHJKLMNPQRSTWXYZ") 
	{
		/*
		 * Generates a random string with the specified length
		 * Chars are chosen from the provided [optional] list
		*/
		mt_srand((double)microtime()*1000000);
	
		$newstring = "";
	
		while (strlen($newstring) < $length) 
		{
			$newstring .= $list[mt_rand(0, strlen($list)-1)];
		}
		return $newstring;
	}
	
	
	function generateImage( $imageName ) 
	{
		$fontSize = 15;
		$width=150; 
		$height=50;		
		
		// generate a random string
		$securityCode = $this->simpleRandString();
		// create a new string with a blank space between each letter so it looks better
		$newstr = "";
		for ($i = 0; $i < strlen($securityCode); $i++) 
		{
			$newstr .= $securityCode[$i] ." ";
		}
		
		// remove the trailing blank
		$newstr = trim($newstr);
	
		// create an image stream	
		$img = imagecreate( $width, $height);

		//define the background color		
		$backgroundcolor = imagecolorallocate( $img, 255, 255, 255);
		
		for($i=0; $i < 20; $i++) 
		{
			$line_color = imagecolorallocate ($img, rand (100, 255), rand (100, 255), rand (100, 255));
			imagesetthickness ( $img, 1);
			imageline( $img, rand( 0, $width), rand( 0, $height), rand( 0, $width), rand( 0, $height), $line_color );
		}		
		
		// output each character at a random height and standard horizontal spacing
		for ($i = 0, $x = 5 ; $i < strlen($newstr); $i++) 
		{
			$fh = mt_rand( 12, 20);
			
			$fw = imagefontwidth( $fh);
			
			// define the text color
			$textcolor = imagecolorallocate( $img, mt_rand( 0, 100), mt_rand( 0, 100), mt_rand( 0, 100));			
				
			//imagechar( $img, $fh, $x, mt_rand( 5, 45-$fw), $newstr[$i], $textcolor);
			imagettftext($img, $fh, 0, $x, mt_rand( 20, 50-$fw), $textcolor, APPSHORE_LIB . SEP .'FreeSansBold.ttf', $newstr[$i]);
			
			$x = $x+$fw+5;
		}
		
		// save the image
		imagejpeg( $img, $imageName);
		
		// and free the memory
		imagedestroy($img);		
		
		return $securityCode;
	}

} 
