function addCurrentIP( ip, currentIP)
{
	var result = '';
	ip += ' '+currentIP;
	ips = cleanIP(ip);
	for( i=0; i < ips.length; i++)
		if( ips[i].length )
			result += ips[i]+' ';
	return result;
}

function cleanIP( ip)
{
	ip = ip.replace(/[,;\n\r\t]/g,' ');
	ips = ip.split(' ');
	return ips.uniq();
}

function checkIP(ip)
{
	var isAlert = false ;
	var result = '', error = '';
	
	ips = cleanIP(ip);
	for( i=0; i < ips.length; i++)
	{
		if( ips[i].length )
		{
			if( checkIPV4V6( ips[i]) == false )
			{
				error +='<strong style="color:black">'+ips[i]+'</strong> ';
				isAlert = true;
			}
			else
				result += ips[i]+' ';
		}
	}
	
	if( isAlert == true )
		top.growler.warning(getTranslation('common','Invalid IP address')+'<br>'+error);
		
	return result;
}

function checkIPV4V6(ip)
{
   var match = ip.match(/^(?:(?:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9](?::|$)){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))$/i);
   return match != null;
}



