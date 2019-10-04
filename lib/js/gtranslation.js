
// call Google Translate API to retrieve tranlation according language
function gTranslate( rowid, google_language_code) 
{
	if( $F('phrase_'+rowid) != ''  )
		origin = $F('phrase_'+rowid);
	else if( $('source_'+rowid) != undefined )
		origin = $F('source_'+rowid);
	else
		origin = '';
		
	google.language.translate( 
		origin, "en", google_language_code, 
		function(result) 
		{ 
			$('target_'+rowid).value = result.error ? '' : result.translation.replace(/\&\#(.*?)\;/g,
				function() {return (String.fromCharCode(arguments[1]))});
			if( $('source_'+rowid) != undefined && $('target_'+rowid).value != $F('source_'+rowid) )
				$('target_'+rowid).style.color = 'red';
		}
	);
} 

// Loop on all fields to be translated
function gTranslateAll( MyForm, google_language_code) 
{
	for( var i = 1 ; i < $$('.target').length ; i++)
	{
		gTranslate( i, google_language_code);
	}
} 		

// Apply the default translation
function dTranslate( rowid) 
{
	$('target_'+rowid).style.color = 'black';
	$('target_'+rowid).value = $F('source_'+rowid);
} 

function resizeTextArea()
{
	cols = $('source_col').getWidth()/7;
	
	for( var i = 1 ; i < $$('.target').length ; i++)
	{
		$('target_'+i).rows = $('source_'+i).rows = $('phrase_'+i).rows = parseInt($F('source_'+i).length/cols)+2;
	}
} 		



