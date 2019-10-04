<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

<xsl:template match="/APPSHORE/API/Plugins" mode="ViewButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="ViewLines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:call-template name="edit_lines">
		<xsl:with-param name="appName" select="$appName"/>
		<xsl:with-param name="thisForm" select="$thisForm"/>	
	</xsl:call-template>
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="EditButtons">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
</xsl:template>

<xsl:template match="/APPSHORE/API/Plugins" mode="EditLines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	
	<xsl:call-template name="edit_lines">
		<xsl:with-param name="appName" select="$appName"/>
		<xsl:with-param name="thisForm" select="$thisForm"/>	
	</xsl:call-template>
</xsl:template>

<xsl:template name="view_lines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Quote items</xsl:with-param>
	</xsl:call-template>
	
	<table border="0" width="100%" cellpadding="1" cellspacing="1" style="line-height:2em">
		<tr class="label" align="center">
			<td width="*%">
                <xsl:value-of select="php:function('lang','Group')"/>
			</td>
			<td width="*%">
                <xsl:value-of select="php:function('lang','Product')"/>
			</td>
			<td width="30%">
                <xsl:value-of select="php:function('lang','Description')"/>
 			</td>
			<td style="width:3em">
                <xsl:value-of select="php:function('lang','Qty')"/>
			</td>
			<td width="*%">
                <xsl:value-of select="php:function('lang','Unit')"/>
			</td>
			<td width="*%">
                <xsl:value-of select="php:function('lang','Tax')"/>
			</td>
			<td style="width:6em">
                <xsl:value-of select="php:function('lang','Price')"/>
 			</td>
			<td style="width:3em">
                <xsl:value-of select="php:function('lang','Discount')"/>
			</td>						
			<td style="width:6em">
                <xsl:value-of select="php:function('lang','Amount')"/>
			</td>
			<td style="width:2em">
                <xsl:value-of select="php:function('lang','Op')"/>
			</td>
		</tr>
		<xsl:for-each select = "quote_lines/quote_lines_item">
			<tr class="field">
            	<td align="left">
					<xsl:value-of select="group_name"/>
				</td>
            	<td align="left">
					<xsl:value-of select="product_name"/>
				</td>
				<td align="left">
					<textarea readonly="true" class="textarea" wrap="off" style="height:2em;width:100%;overflow:hidden" onblur="style.height='2em';style.overflow='hidden'" onfocus="style.height='10em';style.overflow='auto'">
						<xsl:value-of select="description"/>
					</textarea>
				</td>
				<td align="right">
		    		<xsl:value-of select="quantity"/>
				</td>
				<td align="left">
		    		&#160;<xsl:value-of select="unit_name"/>&#160;
				</td>
				<td align="center">
		    		<xsl:value-of select="tax_name"/>
				</td>
				<td align="right">
		    		<xsl:value-of select="price"/>
				</td>
				<td align="right">
		    		<xsl:value-of select="discount"/>%
				</td>
				<td align="right">
		    		<xsl:value-of select="amount"/>
				</td>
				<td align="center">
					<xsl:choose>
					    <xsl:when test="is_option = 'N'">
							<img class="image" src="{$api_image_path}/unchecked.gif"/>
					    </xsl:when>	
					    <xsl:otherwise>
							<img class="image" src="{$api_image_path}/checked.gif"/>
				   	   </xsl:otherwise>			    		    
					</xsl:choose>					
				</td>
			</tr>
		</xsl:for-each>
	</table>
	<br/>

   	<xsl:call-template name="groups_and_totals"/>
   	
</xsl:template>

<xsl:template name="edit_lines">
	<xsl:param name="appName"/>
	<xsl:param name="thisForm"/>	

	<xsl:call-template name="headerListForm">
		<xsl:with-param name="appLabel">Quote items</xsl:with-param>
	</xsl:call-template>
	
	<script LANGUAGE="JavaScript" >
		function populateProductLine( lineNumber)
		{	
			params = {
				method: 'post', 
				postBody: 'sid=<xsl:value-of select="/APPSHORE/API/sid" />&amp;op=products.ajax.getProduct&amp;product_id='+$('product_id_'+lineNumber).value, 
				onSuccess: function(t){
					$('description_'+lineNumber).value = t.responseXML.getElementsByTagName('description').item(0).firstChild.data;
					$('unit_id_'+lineNumber).value = t.responseXML.getElementsByTagName('unit_id').item(0).firstChild.data;
					$('price_'+lineNumber).value = t.responseXML.getElementsByTagName('sell_price').item(0).firstChild.data;
					if( $('quantity_'+lineNumber).value == 0 )
						$('quantity_'+lineNumber).value = 1;
					popupClose();
					}
				};
			new Ajax.Request('raw.php', params);
		}
					
	</script>				
	
	
	<table border="0" width="100%" cellpadding="1" cellspacing="1" style="line-height:2em">
		<tr class="label" align="center" style="min-height:2em">
		    <xsl:call-template name="checkAllListForm">
				<xsl:with-param name="thisForm" select="$thisForm"/>
			</xsl:call-template>
			<td >
                <xsl:value-of select="php:function('lang','Group')"/>
			</td>
			<td>
                <xsl:value-of select="php:function('lang','Product')"/>
			</td>
			<td  style="width:*">
                <xsl:value-of select="php:function('lang','Description')"/>
 			</td>
			<td >
                <xsl:value-of select="php:function('lang','Qty')"/>
			</td>
			<td >
                <xsl:value-of select="php:function('lang','Unit')"/>
			</td>
			<td >
                <xsl:value-of select="php:function('lang','Tax')"/>
			</td>
			<td>
                <xsl:value-of select="php:function('lang','Price')"/>
 			</td>
			<td>
                <xsl:value-of select="php:function('lang','Discount')"/>
			</td>						
			<td>
                <xsl:value-of select="php:function('lang','Amount')"/>
			</td>
			<td style="width:2em">
                <xsl:value-of select="php:function('lang','Op')"/>
			</td>
		</tr>
		<xsl:for-each select = "/APPSHORE/APP/quote_lines/quote_lines_item">
			<tr class="unselectedtext" onMouseOver="this.className ='selectedtext'" onMouseOut="this.className ='unselectedtext'">
			    <xsl:call-template name="checkListForm">
					<xsl:with-param name="thisForm" select="$thisForm"/>
					<xsl:with-param name="thisId" select="quote_line_id"/>					
					<xsl:with-param name="scope" select="scope"/>					
				</xsl:call-template>
				<td align="center">
					<xsl:variable name="groupId"><xsl:value-of select="group_id" /></xsl:variable>											
					<select name="group_id_{increment}" id="group_id_{increment}" >
							<option/>
						<xsl:for-each select = "/APPSHORE/APP/groups/groups_item">
							<option value="{group_id}">
								<xsl:if test="group_id = $groupId">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>
								<xsl:value-of select="group_name"/>
							</option>
						</xsl:for-each>
					</select>
				</td>
            	<td align="left">
					<input type="hidden" name="quote_line_id_{increment}" value="{quote_line_id}" />
					<input type="hidden" name="product_id_{increment}" id="product_id_{increment}" value="{product_id}" onChange="populateProductLine('{increment}');"/>
					<input id="product_name_{increment}" name="product_name_{increment}" style="width:15em;" value="{product_name}"/>
					<a href="javascript:top.window.retrieve=new getBackTuple(document.custom_edit.product_name_{increment},document.custom_edit.product_id_{increment});popupIntra('{$baseurl}&amp;op=products.popup.search&amp;product_id='+document.custom_edit.product_id_{increment}.value,'Products');">
						<img class="icon" src="{$api_image_path}/maglass_16.png"/>
					</a>						
				</td>
				<td align="left">
					<input type="text" name="description_{increment}" id="description_{increment}" style="width:99%" value="{description}"/>
				</td>
				<td align="right">
					<input type="text" name="quantity_{increment}" id="quantity_{increment}" size="4" style="width:99%" value="{quantity}" />
				</td>
				<td align="center">
					<xsl:variable name="unitId"><xsl:value-of select="unit_id" /></xsl:variable>											
					<select name="unit_id_{increment}" id="unit_id_{increment}" >
							<option/>
						<xsl:for-each select = "/APPSHORE/APP/units/units_item">
							<option value="{unit_id}">
								<xsl:if test="unit_id = $unitId">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>
								<xsl:value-of select="unit_name"/>
							</option>
						</xsl:for-each>
					</select>
				</td>
				<td align="center">
					<xsl:variable name="taxId"><xsl:value-of select="tax_id" /></xsl:variable>											
					<select name="tax_id_{increment}" id="tax_id_{increment}" >
							<option/>
						<xsl:for-each select = "/APPSHORE/APP/taxes/taxes_item">
							<option value="{tax_id}">
								<xsl:if test="tax_id = $taxId">
									<xsl:attribute name="selected" value="true"/>
								</xsl:if>
								<xsl:value-of select="tax_name"/>
							</option>
						</xsl:for-each>
					</select>
				</td>
				<td align="right">
					<input type="text" name="price_{increment}" id="price_{increment}" size="6" style="width:99%" value="{price}" />
				</td>
				<td align="right">
					<input type="text" name="discount_{increment}" id="discount_{increment}" size="4" style="width:75%" value="{discount}" />%
				</td>
				<td align="right">
		    		<xsl:value-of select="amount"/>
				</td>
				<td align="center">
					<input name="is_option_{increment}" id="is_option_{increment}" type="hidden" value="{is_option}" />				
					<input type="checkbox" name="checkbox_is_option_{increment}" value="{is_option}" onclick="boxchecked(document.custom_edit.checkbox_is_option_{increment}, document.custom_edit.is_option_{increment});" >
						<xsl:if test="is_option = 'Y'">
							<xsl:attribute name="checked"/>
						</xsl:if>
					</input>							
				</td>
			</tr>
		</xsl:for-each>
	</table>
<!--	<div style="clear:both">  -->
<!--		<input type="hidden" name="selected" />-->
<!--	    <table cellSpacing="0" cellPadding="0" border="0">-->
<!--			<tr>-->
<!--			    <xsl:call-template name="checkAllListForm">-->
<!--					<xsl:with-param name="thisForm">custom_edit</xsl:with-param>				-->
<!--				</xsl:call-template>	-->
<!--				<td>				 		                                    -->
<!--			    	<xsl:call-template name="footerListDelete">-->
<!--						<xsl:with-param name="thisForm">custom_edit</xsl:with-param>	-->
<!--					</xsl:call-template>-->
<!--				</td>-->
<!--			</tr>-->
<!--		</table>	        	-->
<!--	</div>-->

   	<xsl:call-template name="groups_and_totals"/>

</xsl:template>

<xsl:template name="groups_and_totals">
	<xsl:if test = "quote_groups/quote_groups_item">
		<table border="0" align="center" cellpadding="1" cellspacing="1" style="line-height:2em">	
			<tr align="center">						
				<td class="label" style="width:15em">
	                <xsl:value-of select="php:function('lang','Group')"/>
				</td>
				<td class="label" style="width:10em">
	                <xsl:value-of select="php:function('lang','Price')"/>
				</td>
				<xsl:if test = "/APPSHORE/APP/total/option">	
					<td class="label" style="width:10em">
	    	            <xsl:value-of select="php:function('lang','Options')"/>
					</td>
				</xsl:if>
				<td class="label" style="width:10em">
	                <xsl:value-of select="php:function('lang','Discount')"/>
				</td>
				<td class="label" style="width:10em">
	                <xsl:value-of select="php:function('lang','Amount')"/>
				</td>
			</tr>
			<xsl:for-each select = "quote_groups/quote_groups_item">
				<tr align="right">						
					<td class="field" align="left">
		                <xsl:value-of select="group_name"/>
					</td>
					<td class="field">
		                <xsl:value-of select="group_price"/>
					</td>			
					<xsl:if test = "/APPSHORE/APP/total/option">	
						<td class="field">
		    	            <xsl:value-of select="group_option"/>
						</td>			
					</xsl:if>
					<td class="field">
		                <xsl:value-of select="group_discount"/>
					</td>			
					<td class="field">
		                <xsl:value-of select="group_amount"/>
					</td>			
				</tr>
			</xsl:for-each>
		</table>
		<br/>	
	</xsl:if> 
	<table border="0" align="right" cellpadding="1" cellspacing="1" style="line-height:2em">
		<xsl:if test = "/APPSHORE/APP/total/option">	
			<tr align="center">						
				<td align="left" style="width:30em">
	 			</td>
				<td style="width:20em">
				</td>
				<td class="label" style="width:15em">
	                <xsl:value-of select="php:function('lang','Without options')"/>
				</td>			
				<td class="label" style="width:15em">
	                <xsl:value-of select="php:function('lang','With options')"/>
				</td>			
			</tr>
		</xsl:if>
		<tr align="right">						
			<td align="left" style="width:30em">
 			</td>
			<td class="label" style="width:20em">
                <xsl:value-of select="php:function('lang','Total price')"/>
			</td>
			<xsl:if test = "/APPSHORE/APP/total/option">	
				<td class="field" style="width:15em">
                	<xsl:value-of select="total/total_price_option"/>
				</td>			
			</xsl:if>
			<td class="field" style="width:15em">
                <xsl:value-of select="total/total_price"/>
			</td>			
		</tr>
		<tr align="right">						
			<td style="width:30em">
			</td>
			<td class="label">
                <xsl:value-of select="php:function('lang','Discount')"/>
			</td>
			<xsl:if test = "/APPSHORE/APP/total/option">	
				<td class="field">
                	(<xsl:value-of select="total/total_discount_option"/>)
				</td>			
			</xsl:if>
			<td class="field">
                (<xsl:value-of select="total/total_discount"/>)
			</td>			
		</tr>
		<tr align="right">						
			<td style="width:30em">
			</td>
			<td class="label">
                <xsl:value-of select="php:function('lang','Subtotal')"/>
			</td>
			<xsl:if test = "/APPSHORE/APP/total/option">	
				<td class="field">
        	        <xsl:value-of select="total/total_subtotal_option"/>
				</td>			
			</xsl:if>
			<td class="field">
                <xsl:value-of select="total/total_subtotal"/>
			</td>			
		</tr>
		<xsl:for-each select = "quote_taxes/quote_taxes_item">
			<xsl:if test = "string-length(tax_id)">	
				<tr align="right">						
					<td style="width:30em">
					</td>
					<td class="label">
		        		<xsl:value-of select="php:function('lang','Tax')"/>:&#160;<xsl:value-of select="tax_name"/>
					</td>
					<xsl:if test = "/APPSHORE/APP/total/option">	
						<td class="field">
		        	        <xsl:value-of select="tax_amount_option"/>
						</td>			
					</xsl:if>
					<td class="field">
		                <xsl:value-of select="tax_amount"/>
					</td>			
				</tr>
			</xsl:if>
		</xsl:for-each>
		<tr align="right">						
			<td style="width:30em">
			</td>
			<td class="label">
                <xsl:value-of select="php:function('lang','Total amount')"/>
			</td>
			<xsl:if test = "/APPSHORE/APP/total/option">	
				<td class="field">
        	        <xsl:value-of select="total/total_amount_option"/>
				</td>			
			</xsl:if>
			<td class="field">
                <xsl:value-of select="total/total_amount"/>
			</td>			
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>
