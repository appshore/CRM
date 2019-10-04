/**
 * Convert a single file-input element into a 'multiple' input list
 *
 * Usage:
 *
 *   1. Create a file input element (no name)
 *      eg. <input type="file" id="first_file_element">
 *
 *   2. Create a DIV for the output to be written to
 *      eg. <div id="files_list"></div>
 *
 *   3. Instantiate a MultiSelector object, passing in the DIV and an (optional) maximum number of files
 *      eg. var multi_selector = new MultiSelector( document.getElementById( 'files_list' ), 3 );
 *
 *   4. Add the first element
 *      eg. multi_selector.addElement( document.getElementById( 'first_file_element' ) );
 *
 *   5. That's it.
 *
 *   You might (will) want to play around with the addListRow() method to make the output prettier.
 *
 *   You might also want to change the line 
 *       element.name = 'file_' + this.count;
 *   ...to a naming convention that makes more sense to you.
 * 
 * Licence:
 *   Use this however/wherever you like, just don't blame me if it breaks anything.
 *
 * Credit:
 *   If you're nice, you'll leave this bit:
 *  
 *   Class by Stickman -- http://www.the-stickman.com
 *      with thanks to:
 *      [for Safari fixes]
 *         Luis Torrefranca -- http://www.law.pitt.edu
 *         and
 *         Shawn Parker & John Pennypacker -- http://www.fuzzycoconut.com
 *      [for duplicate name bug]
 *         'neal'
 */

function MultiSelector( list_target, max ){

	// Where to write the list
	this.list_target = list_target;
	// How many elements?
	this.count = 0;
	// How many elements?
	this.id = 0;
	// Is there a maximum?
	if( max ){
		this.max = max;
	} else {
		this.max = -1;
	};
	
	/**
	 * Add a new file input element
	 */
	this.addElement = function( element ){

		// Make sure it's a file input element
		if( element.tagName == 'INPUT' && element.type == 'file' ){

			// Element name -- what number am I?
			element.name = 'files[' + this.id++ +']';

			// Add reference to this object
			element.multi_selector = this;

			// What to do when a file is selected
			element.onchange = function(){

				// not twice the same file
				if( $('file-'+element.value) )
				{
					element.value = '';
					return;
				}
				element.id = 'file-'+element.value;

				// New file input
				var new_element = document.createElement( 'input' );
				new_element.type = 'file';
				//new_element.className = 'button';				
				
				// Add new element
				this.parentNode.insertBefore( new_element, this );

				// Apply 'update' to element
				this.multi_selector.addElement( new_element );

				// Update list
				this.multi_selector.addListRow( this );

				// Hide this: we can't use display:none because Safari doesn't like it
				this.style.position = 'absolute';
				this.style.left = '-1000px';

			};
			// If we've reached maximum number, disable input element
			if( this.max != -1 && this.count >= this.max ){
				element.disabled = true;
			};

			// File element counter
			this.count++;
			// Most recent element
			this.current_element = element;
			
		} else {
			// This can only be applied to file input elements!
			alert( 'Error: not a file input element' );
		};

	};

	/**
	 * Add a new row to the list of files
	 */
	this.addListRow = function( element ){
			
		// Row div
		var new_row = document.createElement( 'div' );
		new_row.name = element.name;
	
		// Checkbox button
		var new_row_button = document.createElement( 'input' );
		new_row_button.type = 'checkbox';
		new_row_button.onclick = function(){
			element.remove();this.parentNode.remove();
		};
					
		// References
		new_row.element = element;

		// Add button
		new_row.appendChild( new_row_button );

		// Add text
		var new_row_bis = document.createElement( 'text' );		
		new_row_bis.innerHTML = '&#160;'+element.value;		
		new_row.appendChild( new_row_bis );

		// Add it to the list
		this.list_target.appendChild( new_row );	
		
		// for IE must be checked once the row is added to the list	
		new_row_button.checked = true;
	};

};
