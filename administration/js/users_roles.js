	function passRolesList( l2, MyList) 
	{ 
		MyList.value.length = 0;	
	    for ( i=0; i < l2.length ; i++) 
		{
			if ( i > 0 && MyList.value.length )	
				MyList.value += ',';	
				
			MyList.value += l2.options[i].value;			
		}
	}	
	
	function copyAll( list1, list2) 
	{
	    list1len = list1.length ;
	    for ( i=0; i<list1len ; i++)
		{
			list2len = list2.length;
			already = false;
			
			for ( j=0; j<list2len ; j++)
				if (list2.options[j].text == list1.options[i].text )
					already = true;
					
			if (already == false)
			{
	            list2.options[list2len]= new Option(list1.options[i].text, list1.options[i].value);
			}
	    }
	}
	
	function copySelected( list1, list2) 
	{
	    list1len = list1.length ;
	    for ( i=0; i<list1len ; i++)
		{
	        if (list1.options[i].selected == true ) 
			{
	            list2len = list2.length;
				already = false;
				for ( j=0; j<list2len ; j++)
					if (list2.options[j].text == list1.options[i].text )
						already = true;
				if (already == false)
				{
		            list2.options[list2len]= new Option(list1.options[i].text, list1.options[i].value);
				}
	        }
	    }
	
	}

	function removeSelected(list) 
	{
	    for ( i=(list.length-1); i>=0; i--) 
	       if (list.options[i].selected == true ) 
	          list.options[i] = null;
	}
	
	function removeAll(list) 
	{
	    for ( i=(list.length-1); i>=0; i--) 
		    list.options[i] = null;
	}
